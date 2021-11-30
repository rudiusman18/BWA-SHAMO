<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Transaction extends Model
{
    use HasFactory, SoftDeletes;
    protected $guarded = ['id'];

    // inverse relation
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'id');
    }

    public function transactionitem()
    {
        return $this->hasMany(TransactionItem::class, 'transaction_id', 'id');
    }
}