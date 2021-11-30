<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function index()
    {
        return view('backend.login', ['title' => 'LOGIN']);
    }

    public function authenticate(Request $request)
    {
        $loginValidate = $request->validate([
            'email' => 'required|email:dns,rfc',
            'password' => 'required|max:255',
        ]);

        if (Auth::attempt($loginValidate)) {
            $request->session()->regenerate();
            // mengenerate token

            return redirect()->intended('/dashboard');
        }

        // if failed
        return back()->with(
            'loginFailed',
            'Login Failed! your email or password might be false or maybe yo aren\'t admin'
        );
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/');
    }
}