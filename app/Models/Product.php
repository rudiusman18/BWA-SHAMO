<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;

    protected $guarded = ['id'];

    public function productcategory()
    {
        return $this->belongsTo(
            ProductCategory::class,
            'product_category_id',
            'id'
        );
    }

    public function productgallery()
    {
        return $this->hasMany(ProductGallery::class, 'product_id', 'id');
    }
}