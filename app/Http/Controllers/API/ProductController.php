<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    //mengambil semua data dan data product tertentu
    public function index(Request $request)
    {
        // untuk mengakses request
        $id = $request->input('id');
        $limit = $request->input('limit'); // batas untuk pagination
        $name = $request->input('name'); //mengambil nama produk
        $description = $request->input('description');
        $tags = $request->input('tags');
        $categories = $request->input('product_category_id');

        $price_from = $request->input('price_from'); // mengambil batas bawah sebuah harga
        $price_to = $request->input('price_to'); // mengambil batas atas sebuah harga

        // jika terdapat id pada request (mengambil data dengan id tertentu)
        if ($id) {
            $product = Product::with([
                'productgallery',
                'productcategory',
            ])->find($id);

            // jika produk yang dicari ada
            if ($product) {
                return ResponseFormatter::success(
                    ['product' => $product],
                    'Data produk berhasil diambil'
                );
            } else {
                return ResponseFormatter::error(
                    null,
                    'Data produk tidak ada',
                    404
                );
            }
        }

        // mengambil semua data
        $product = Product::with(['productgallery', 'productcategory']);

        // mengambil semua data dengan parameter tertentu
        if ($name) {
            $product->where('name', 'like', '%' . $name . '%');
        }

        if ($description) {
            $product->where('description', 'like', '%' . $description . '%');
        }

        if ($tags) {
            $product->where('tags', 'like', '%' . $tags . '%');
        }

        if ($price_from) {
            $product->where('price', '>=', $price_from);
        }

        if ($price_to) {
            $product->where('price', '<=', $price_to);
        }

        if ($categories) {
            $product->where('categories', $categories);
        }

        // mengembalikan nilai dan diserahkan pada ResponseFormatter
        return ResponseFormatter::success(
            ['product' => $product->paginate($limit)],
            'Data produk berhasil diambil'
        );
    }
}