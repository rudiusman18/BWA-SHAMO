@extends('backend.admin.layouts.admin')
@section('dashboard')



    <div class="container-fluid">
        @if (session()->has('success'))


            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ session('success') }}<button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            </div>



        @endif
        <h1>Products</h1>
        <a href="/dashboard/product/create"><button style="background-color: #6C5ECF" class="btn mb-3 text-light">+ Add
                Data</button></a>
        <div class="table-responsive mb-5">
            <table class="table text-light text-center">
                <thead style="background-color:#6C5ECF">
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Name</th>
                        <th scope="col">Category</th>
                        <th scope="col">Price</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($products as $product)
                        <tr>
                            <th class="align-middle" scope="row">{{ $loop->iteration }}</th>
                            <td class="align-middle">{{ $product->name }}</td>
                            <td class="align-middle">{{ $product->productcategory->name }}</td>
                            <td class="align-middle">${{ $product->price }}</td>
                            <td class="align-middle"><button class="btn btn-success m-1" data-toggle="modal"
                                    data-target="#detailModal{{ $product->id }}">Details</button><button
                                    onclick="location.href='/dashboard/product/{{ $product->id }}/edit'"
                                    class="btn btn-warning m-1">Update</button>
                                <button class="btn btn-danger m-1" data-toggle="modal"
                                    data-target="#deleteModal{{ $product->id }}">Delete</button>

                            </td>
                        </tr>
                        <!-- delete Modal-->
                        <div class="modal fade" id="deleteModal{{ $product->id }}" tabindex="-1" role="dialog"
                            aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div style="background-color: #1F1D2B" class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Delete Product</h5>
                                        <button class="close" type="button" data-dismiss="modal"
                                            aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">Are you sure you want to delete {{ $product->name }}?
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                        <form class="d-inline" action="/dashboard/product/{{ $product->id }}"
                                            method="POST">
                                            @csrf
                                            @method('DELETE')
                                            <button style="background-color: #6C5ECF" type="submit"
                                                class="btn btn-primary">Delete</button>
                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- detail product -->
                        <div class="modal fade" id="detailModal{{ $product->id }}" tabindex="-1" role="dialog"
                            aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div style="background-color: #1F1D2B" class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
                                        <button class="close" type="button" data-dismiss="modal"
                                            aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        Name : {{ $product->name }} <br>
                                        Price :{{ $product->price }} <br>
                                        Description: {!! $product->description !!}
                                        Images:
                                        <div class="img">
                                            @foreach ($product->productgallery as $gallery)
                                                <img class="img-fluid my-2" src="storage/{{ $gallery->img_url }}"
                                                    alt="{{ $gallery->img_url }}">

                                            @endforeach
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button style="background-color: #6C5ECF" class="btn btn-secondary" type="button"
                                            data-dismiss="modal">Ok</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>




@endsection
