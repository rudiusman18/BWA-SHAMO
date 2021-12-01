@extends('backend.layouts.main')


@section('container')

    <div class="row justify-content-center">
        <div class="col-lg-6">
            <main class="form-signin">
                <div class="col text-center"><img class="mb-3" style="width: 20%;" src="/assets/Union.png"
                        alt="shamo_logo"></div>

                {{-- error message when email or password false --}}
                @if (session()->has('loginFailed'))
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        {{ session('loginFailed') }}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                @endif

                <form action="/" method="POST">
                    @csrf
                    <h1 class="h3 mb-3 fw-normal text-center text-light">Admin BWA-SHAMO Login</h1>

                    <div class="form-floating mb-3">
                        <input type="email"
                            class="form-control @error('email')
                            is-invalid
                        @enderror"
                            id="email" value="{{ request()->old('email') }}" name="email" placeholder="email" autofocus>
                        <label for="email">Email address</label>
                        @error('email')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                        @enderror
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password"
                            class="form-control @error('password')
                            is-invalid
                        @enderror"
                            id="password" name="password" placeholder="password">
                        <label for="password">Password</label>
                        @error('password')
                            <div class="invalid-feedback">
                                {{ $message }}
                            </div>
                        @enderror
                    </div>

                    <button class="w-100 btn btn-lg btn-primary mb-3" type="submit">Login</button>


                </form>
                <footer class="position-relative" style="margin-top:-200px">
                    <p class="mt-5 mb-3 text-light fixed-bottom text-center">BWA-Shamo &copy; 2021</p>
                </footer>

            </main>
        </div>
    </div>


@endsection
