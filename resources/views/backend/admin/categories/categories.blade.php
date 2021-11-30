@extends('backend.admin.layouts.admin')
@section('dashboard')



    <div class="container-fluid">
        @if (session()->has('success'))


            <div class="alert alert-success alert-dismissible fade show" role="alert">
                {{ session('success') }}<button type="button" class="btn-close" data-bs-dismiss="alert"
                    aria-label="Close"></button>
            </div>



        @endif
        <h1>Categories</h1>
        <button style="background-color: #6C5ECF" class="btn mb-3 text-light" data-toggle="modal"
            data-target="#createModal">+ Add
            Data</button>

        <div class="table-responsive mb-5">
            <table class="table text-light text-center">
                <thead style="background-color:#6C5ECF">
                    <tr>
                        <th scope="col">No</th>
                        <th scope="col">Name</th>
                        <th scope="col">Action</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($categories as $category)
                        <tr>
                            <th class="align-middle" scope="row">{{ $loop->iteration }}</th>
                            <td class="align-middle" scope="row">{{ $category->name }}</td>
                            <td class="align-middle" scope="row"><button data-toggle="modal"
                                    data-target="#updateModal{{ $category->id }}"
                                    class="btn btn-warning m-1">Update</button>

                                <button type="submit" class="btn btn-danger m-1" data-toggle="modal"
                                    data-target="#categorydeleteModal{{ $category->id }}">Delete</button>

                            </td>
                        </tr>
                        <!-- delete Modal-->
                        <div class="modal fade" id="categorydeleteModal{{ $category->id }}" tabindex="-1"
                            role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div style="background-color: #1F1D2B" class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Delete Category</h5>
                                        <button class="close" type="button" data-dismiss="modal"
                                            aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">Are you sure you want to delete {{ $category->name }}?
                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                                        <form class="d-inline" action="/dashboard/category/{{ $category->id }}"
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

                        <!-- update Modal-->
                        <div class="modal fade" id="updateModal{{ $category->id }}" tabindex="-1" role="dialog"
                            aria-labelledby="exampleModalLabel" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div style="background-color: #1F1D2B" class="modal-content">
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="exampleModalLabel">Update Category</h5>
                                        <button class="close" type="button" data-dismiss="modal"
                                            aria-label="Close">
                                            <span aria-hidden="true">×</span>
                                        </button>
                                    </div>
                                    <div class="modal-body">
                                        <form method="POST" action="/dashboard/category/{{ $category->id }}">
                                            @csrf
                                            @method('PUT')
                                            <div class="mb-3">
                                                <label for="name" class="form-label">Name</label>
                                                <input type="text"
                                                    class="form-control @error('name')
                                                is-invalid
                                            @enderror"
                                                    id="name" name="name"
                                                    value="{{ old($category->name, $category->name) }}">
                                                @error('name')
                                                    <div class="invalid-feedback">{{ $message }}</div>
                                                @enderror
                                            </div>

                                    </div>
                                    <div class="modal-footer">
                                        <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>

                                        <button style="background-color: #6C5ECF" type="submit"
                                            class="btn btn-primary">Update Data</button>

                                        </form>

                                    </div>
                                </div>
                            </div>
                        </div>
                    @endforeach
                </tbody>
            </table>
        </div>
    </div>


    {{-- add new data modal --}}
    <div class="modal fade" id="createModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div style="background-color: #1F1D2B" class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add New Category</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="POST" action="/dashboard/category">
                        @csrf
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text"
                                class="form-control @error('name')
                                is-invalid
                            @enderror"
                                id="name" name="name">
                            @error('name')
                                <div class="invalid-feedback">{{ $message }}</div>
                            @enderror
                        </div>

                </div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>

                    <button style="background-color: #6C5ECF" type="submit" class="btn btn-primary">Create Data</button>

                    </form>

                </div>
            </div>
        </div>
    </div>




@endsection
