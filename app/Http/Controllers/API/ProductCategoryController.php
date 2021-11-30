<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\ProductCategory;
use Illuminate\Http\Request;

class ProductCategoryController extends Controller
{
    public function index(Request $request)
    {
        $id = $request->input('id');
        $limit = $request->input('limit'); // batas untuk pagination
        $name = $request->input('name'); //mengambil nama produk
        $show_product = $request->input('show_product'); //menentukan apakah ingin menampilkan produk sesuai dengan kategori yang ada atau tidak

        if ($id) {
            $category = ProductCategory::with(['product'])->find($id);

            // jika produk yang dicari ada
            if ($category) {
                return ResponseFormatter::success(
                    $category,
                    'Data kategori berhasil diambil'
                );
            } else {
                return ResponseFormatter::error(
                    null,
                    'Data kategori tidak ada',
                    404
                );
            }
        }
        // menampilkan semua data
        $category = ProductCategory::query();
        if ($name) {
            $category->where('name', 'like', '%' . $name . '%');
        }

        if ($show_product) {
            $category = ProductCategory::with(['product']);
        }

        // mengembalikan nilai dan diserahkan pada ResponseFormatter
        return ResponseFormatter::success(
            $category->paginate($limit),
            'Data kategori berhasil diambil'
        );
    }
}