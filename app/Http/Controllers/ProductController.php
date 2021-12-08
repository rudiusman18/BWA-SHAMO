<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductCategory;
use App\Models\ProductGallery;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('backend.admin.products.product', [
            'title' => 'Products',
            'products' => Product::latest()->get(),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('backend.admin.products.create', [
            'title' => 'New Product',
            'categories' => ProductCategory::all(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validateProduct = $request->validate([
            'name' => 'required|max:255',
            'price' => 'required',
            'images' => 'required',
            'images.*' => 'image|mimes:png,jpg,svg,jpeg',
            'product_category_id' => 'required',
            'description' => 'required',
        ]);
        $dataProduct = Product::create($validateProduct);

        if ($request->hasFile('images')) {
            $iteration = 0;
            $files = $request->file('images');
            foreach ($files as $file) {
                $name = 'image' . time() . '[' . $iteration++ . ']';
                // $name = ProductGallery::getUrlAttribute($file);
                $extension = $file->getClientOriginalExtension();
                $newName = $name . '.' . $extension;
                // $file->storeAs('ProductImage', $newName);
                Storage::putFileAs('public', $file, $newName);
                $data = [
                    'product_id' => $dataProduct->id,
                    'img_url' => ProductGallery::getUrlAttribute($newName),
                ];

                ProductGallery::create($data);
            }
            return redirect('/dashboard/product')->with(
                'success',
                'New Data has been added!'
            );
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function show(Product $product)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function edit(Product $product)
    {
        return view('backend.admin.products.edit', [
            'title' => 'update',
            'product' => $product,
            'galleries' => ProductGallery::where(
                'product_id',
                $product['id']
            )->get(),
            'categories' => ProductCategory::all(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Product $product)
    {
        $validateProduct = $request->validate([
            'name' => 'required|max:255',
            'price' => 'required',
            'product_category_id' => 'required',
            'description' => 'required',
        ]);
        $dataProduct = Product::where('id', $product->id)->update(
            $validateProduct
        );

        $request->validate([
            'images.*' => 'image|mimes:png,jpg,svg,jpeg',
        ]);

        if ($request->hasFile('images')) {
            foreach ($product->productgallery as $images) {
                Storage::delete('public/' . $images->img_url);
                $images->delete();
            }

            $iteration = 0;
            $files = $request->file('images');
            foreach ($files as $file) {
                $name = $request->name . '[' . $iteration++ . ']';
                $extension = $file->getClientOriginalExtension();
                $newName = $name . '.' . $extension;
                // $file->storeAs('ProductImage', $newName);
                Storage::putFileAs('public', $file, $newName);
                $data = [
                    'product_id' => $product->id,
                    'img_url' => $newName,
                ];

                ProductGallery::create($data);
            }
        }
        return redirect('/dashboard/product')->with(
            'success',
            'Data has been updated'
        );
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Product  $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Product $product)
    {
        $imageData = $product->productgallery;
        foreach ($imageData as $images) {
            Storage::delete('public/' . $images->img_url);
            $images->delete();
        }
        // return $images;
        $product->delete();

        return redirect('dashboard/product')->with(
            'success',
            'Your data successfully deleted'
        );
    }
}