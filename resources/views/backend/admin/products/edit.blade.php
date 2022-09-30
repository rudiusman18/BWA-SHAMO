@extends('backend.admin.layouts.admin')
@section('dashboard')



    <div class="container-fluid">
        <h1 class="mb-3">Update Product</h1>
        <div class="row">
            <div class="col-lg-8">
                <form action="/dashboard/product/{{ $product->id }}" method="POST" enctype="multipart/form-data">
                    @csrf
                    @method('PUT')
                    <div class="mb-3">
                        <label for="name" class="form-label">Product Name</label>
                        <input type="text"
                            class="form-control @error('name')
                            is-invalid
                        @enderror"
                            id="name" name="name" value="{{ old('name', $product->name) }}" autofocus>
                        @error('name')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <label for="product_category_id" class="form-label">Category</label>
                        <select
                            class="form-select @error('product_category_id')
                            is-invalid
                        @enderror"
                            name="product_category_id" id="product_category_id">
                            <option disabled selected value>Choose one of the category</option>
                            @foreach ($categories as $category)
                                @if (old('product_category_id', $product->product_category_id) == $category->id)
                                    <option selected value="{{ $category->id }}">{{ $category->name }}</option>
                                @else
                                    <option value="{{ $category->id }}">{{ $category->name }}</option>
                                @endif
                            @endforeach
                        </select>
                        @error('product_category_id')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <div><label for="images" class="form-label">Images</label></div>

                        @if ($galleries->first()->img_url)
                            <div id="preview">
                                @foreach ($galleries as $gallery)
                                    <img style="height:100px" src="{{ $gallery->img_url }}" alt="Foto">
                                @endforeach
                            </div>
                        @else
                            <div id="preview"></div>
                        @endif



                        <input
                            class="
                            form-control @error('images.*')
                                is-invalid
                            @enderror"
                            type="file" multiple id="images" name="images[]">



                        @error('images.*')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <label for="price" class="form-label">Price</label>
                        <input type="text" onkeypress="if ( isNaN( String.fromCharCode(event.keyCode) )) return false;"
                            class="form-control @error('price')
                                is-invalid
                            @enderror"
                            id="price" name="price" placeholder="0" value="{{ old('price', $product->price) }}">
                        @error('price')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>

                    <div class="mb-3">
                        <label for="description"
                            class="form-label @error('description')
                            is-invalid
                        @enderror">Description</label>
                        <input id="description" type="hidden" name="description"
                            value="{{ old('description', $product->description) }}">
                        <trix-editor class="bg-light text-dark" input="description"></trix-editor>
                        @error('description')
                            <div class="invalid-feedback"> {{ $message }}</div>
                        @enderror
                    </div>

                    <button style="background-color:#6C5ECF" type="submit" class="btn btn-dark mb-5">Update Data</button>
                </form>
            </div>
        </div>

    </div>





    <script>
        // Fungsi preview images
        function previewImages() {

            var $preview = $('#preview').empty();
            if (this.files) $.each(this.files, readAndPreview);

            function readAndPreview(i, file) {

                var reader = new FileReader();

                $(reader).on("load", function() {
                    $preview.append($("<img/>", {
                        src: this.result,
                        height: 100
                    }));
                });

                reader.readAsDataURL(file);

            }

        }

        $('#images').on("change", previewImages);
    </script>





@endsection