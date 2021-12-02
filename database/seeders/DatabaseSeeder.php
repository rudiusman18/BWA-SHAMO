<?php

namespace Database\Seeders;

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\Transaction;
use App\Models\TransactionItem;
use App\Models\User;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     *
     * @return void
     */
    public function run()
    {
        // \App\Models\User::factory(10)->create();

        User::create([
            'name' => 'Rudi Usman',
            'username' => 'rudiusman18',
            'email' => 'rudiusmanprogrammer@gmail.com',
            'roles' => 'admin',
            'phone_number' => '09121214213123',
            'password' => Hash::make('password'),
        ]);

        User::create([
            'name' => 'Raviola Firdausia',
            'username' => 'raviola',
            'email' => 'raviola12@gmail.com',
            'phone_number' => '09121214213123',
            'password' => Hash::make('password'),
        ]);

        // create product manual
        // Product::create([
        //     'product_category_id' => 1,
        //     'name' => 'Indomie',
        //     'price' => 15000,
        //     'description' => 'lorem ipsum dolor sit amet, consectetur adipis',
        // ]);

        // Product::create([
        //     'product_category_id' => 2,
        //     'name' => 'Sari roti',
        //     'price' => 10000,
        //     'description' => 'lorem ipsum dolor sit amet, consectetur adipis',
        // ]);

        // Product::create([
        //     'product_category_id' => 2,
        //     'name' => 'Oreo',
        //     'price' => 5000,
        //     'description' => 'lorem ipsum dolor sit amet, consectetur adipis',
        // ]);

        //membuat data kategori
        ProductCategory::create(['name' => 'makanan']);
        ProductCategory::create(['name' => 'cemilan']);
        ProductCategory::create(['name' => 'makanan ringan']);

        // membuat data transaksi
        // Transaction::create(['user_id' => mt_rand(1, 2)]);
        // Transaction::create(['user_id' => mt_rand(1, 2)]);
        // Transaction::create(['user_id' => mt_rand(1, 2)]);
        // Transaction::create(['user_id' => mt_rand(1, 2)]);
        // Transaction::create(['user_id' => mt_rand(1, 2)]);
        // Transaction::create(['user_id' => mt_rand(1, 2)]);

        // membuat data transaction item
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
        // TransactionItem::create([
        //     'user_id' => mt_rand(1, 2),
        //     'product_id' => mt_rand(1, 3),
        //     'transaction_id' => mt_rand(1, 6),
        //     'quantity' => mt_rand(1, 10),
        // ]);
    }
}