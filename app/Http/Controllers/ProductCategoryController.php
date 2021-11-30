<?php

namespace App\Http\Controllers;

use App\Models\ProductCategory;
use Illuminate\Http\Request;

class ProductCategoryController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return view('backend.admin.categories.categories', [
            'title' => 'categories',
            'categories' => ProductCategory::latest()->get(),
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
        $validateRequest = $request->validate([
            'name' => 'required',
        ]);
        ProductCategory::create($validateRequest);
        return redirect('/dashboard/category')->with(
            'success',
            'New Data has been added!'
        );
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\ProductCategory  $category
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, ProductCategory $category)
    {
        $validateCategory = $request->validate(['name' => 'required']);
        ProductCategory::where('id', $category->id)->update($validateCategory);
        return redirect('/dashboard/category')->with(
            'success',
            'Data has been Updated!'
        );
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\ProductCategory  $category
     * @return \Illuminate\Http\Response
     */
    public function destroy(ProductCategory $category)
    {
        $category->delete();

        return redirect('dashboard/category')->with(
            'success',
            'Your data successfully deleted'
        );
    }
}