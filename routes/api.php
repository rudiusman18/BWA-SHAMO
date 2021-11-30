<?php

use App\Http\Controllers\API\ProductCategoryController;
use App\Http\Controllers\API\ProductController;
use App\Http\Controllers\API\TransactionController;
use App\Http\Controllers\API\UserController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

// route ini merupakan sebuah route grup, apapun route yang ada didalam route ini akan memiliki middleware(auth:sanctum)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [UserController::class, 'fetch']); //Mengambil data user dengan middleware auth, artinya untuk mengakses method ini diperlukan token atau telah melakukan login
    Route::post('/user', [UserController::class, 'updateProfile']); //melakukan perubahan data pada field tertentu
    Route::post('/logout', [UserController::class, 'logout']); // meminta akses logout kepada sistem
    Route::get('/transaction', [TransactionController::class, 'all']); // mengambil data transaksi dari user tertentu
    Route::post('/checkout', [TransactionController::class, 'checkout']); // mengirimkan data melalui front end untuk mendapatkan data barang yang ingin dibeli oleh pengguna
});

Route::get('/product', [ProductController::class, 'index']); // Menampilkan semua data product
Route::get('/category', [ProductCategoryController::class, 'index']); // Menampilkan semua data kategori

Route::post('/register', [UserController::class, 'register']); // mengambil data register dari front end
Route::post('/login', [UserController::class, 'login']); //mengambil data login dari request