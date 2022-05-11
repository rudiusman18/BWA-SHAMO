<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Transaction;
use App\Models\TransactionItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class TransactionController extends Controller
{
    // mengambil semua data maupun data transaksi dengan parameter tertentu
    public function all(Request $request)
    {
        // untuk mengakses request
        $id = $request->input('id'); //mengambil id dari request
        $limit = $request->input('limit'); // batas untuk pagination
        $status = $request->input('status'); // mengambil status transaksi
        if ($id) {
            // jika terdapat id maka ambil data transaksi dengan id yang di request
            $transaction = Transaction::with(['transactionitem.product'])->find(
                $id
            ); //mengambil data transaksi dengan id tertentu beserta data product dalam transaksi tersebut

            // jika variabel transaction dijalankan maka kembalikan response success
            if ($transaction) {
                return ResponseFormatter::success(
                    ['transaction' => $transaction],
                    'Data dengan id ' . $id . ' berhasil diambil'
                );
            } else {
                // mengembalikan response error jika id yang dicari tidak ditemukan
                return responseformatter::error(null, 'data tidak ada', 404);
            }
        }

        // jika kondisi tidak terpenuhi maka ambil semua data transaksi dengan id user yang sedang login
        $transaction = Transaction::with(['transactionitem.product'])->where(
            'user_id',
            Auth::user()->id
        );

        //  mengambil data user sesuai dengan request status
        if ($status) {
            $transaction = Transaction::with([
                'transactionitem.product',
            ])->where('status', $status);
        }

        // mengembalikan response success
        return responseformatter::success(
            [
                'transaction' => $transaction->paginate($limit),
            ],
            'Data list transaksi berhasil diambil'
        );
    }

    public function checkout(Request $request)
    {
        $request->validate([
            'transactionitem' => 'required|array', //validasi yang menandakan bahwa key 'transactionitem' harus berbentuk array
            'transactionitem.*.id' => 'exists:products,id', //validasi yang melakukan pengecekan item pada tabel transactionitem apakah terdaftar pada tabel products
            'status' =>
                'required|in:pending, success, cancelled, failed, shippping, shipped', // validasi yang melakukan pengecekan bahwa status hanya dapat berisi nilai yang terdaftar didalam in
            'shipping_price' => 'required',
            'total_price' => 'required',
        ]);

        $transaction = Transaction::create([
            'user_id' => Auth::user()->id, // mengambil data user yang sedang login
            'address' => $request->address,
            'total_price' => $request->total_price,
            'shipping_price' => $request->shipping_price,
            'status' => $request->status,
        ]); //membuat data baru dan menyimpannya kedalam database

        foreach ($request->transactionitem as $items) {
            TransactionItem::create([
                'user_id' => Auth::user()->id, // mengambil data user yang sedang login
                'product_id' => $items['id'], // mengambil id dari request id
                'transaction_id' => $transaction->id, // mengambil id dari $transaction diatas
                'quantity' => $items['quantity'], //mengambil request quantity
            ]);
        }

        return responseformatter::success(
            $transaction->load(['transactionitem']), // mengambil data pada variabel transaction serta melakukan load pada method product pada model yang ada pada transaction item pada model transaction (relationship)
            'Transaksi Berhasil'
        );
    }
}