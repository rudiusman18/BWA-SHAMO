<?php

namespace App\Http\Controllers\API;

use App\Helpers\ResponseFormatter;
use App\Http\Controllers\Controller;
use App\Models\User;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Laravel\Fortify\Rules\Password;

class UserController extends Controller
{
    // method register
    public function register(Request $request)
    {
        // menggunakan block try-catch untuk mengetahui apakah berhasil atau tidak, jika gagal akan diberikan pesan error dan jika berhasil maka akan diteruskan ke halaman login
        try {
            $validateData = $request->validate([
                'name' => 'required|string|max:255',
                'username' => 'required|string|max:255|unique:users',
                'email' => 'required|string|email:rfc,dns|max:255|unique:users',
                'phone_number' => 'string|max:255',
                'password' => ['required', 'string', new Password()],
            ]);

            $validateData['password'] = Hash::make($validateData['password']);

            // untuk menyimpan data user baru (tidak bisa menggunakan variable baru)
            User::create(
                // 'name' => $request->name,
                // 'username' => $request->username,
                // 'email' => $request->email,
                // 'phone_number' => $request->phone_number,
                // 'password' => Hash::make($request->password),
                $validateData
            );

            // mendapatkan user yang baru terdaftar kemudian memberikan token pada setiap user baru dengan variabel tokenResult
            $user = User::where('email', $request->email)->first();
            $tokenResult = $user->createToken('authToken')->plainTextToken;

            return ResponseFormatter::success(
                [
                    'access_token' => $tokenResult,
                    'token_type' => 'Bearer',
                    'user' => $user,
                ],
                'Registrasion successfull'
            );
        } catch (Exception $error) {
            return ResponseFormatter::error(
                [
                    'message' => 'Something went wrong',
                    'error' => $error,
                ],
                'Authentication failed',
                500
            );
        }
    }

    // method login
    public function login(Request $request)
    {
        try {
            // menvalidasi request login dari user
            $validateLogin = $request->validate([
                'email' => 'required|email:dns,rfc|max:255',
                'password' => 'required|max:255',
            ]);

            // melakukan cek apakah user yang masuk telah terdaftar didalam database atau belum
            if (!Auth::attempt($validateLogin)) {
                return ResponseFormatter::error(
                    [
                        'message' => 'Unauthorized',
                    ],
                    'authentication failed',
                    500
                );
            }

            // jika user telah terdaftar maka data user paling pertama akan diambil berdasarkan email
            $user = User::where(['email' => $request->email])->first();

            // melakukan cek pada password apakah password yang digunakan user sudah sesuai dengan saat user tersebut mendaftar (sifatnya tidak wajin karena dengan menggunakan Auth::attempt([]) Laravel telah mampu melakukan pengecekan password)
            if (!Hash::check($request->password, $user->password)) {
                throw new \Exception('Error Processing Request', 1);
            }

            // mengenerate token
            $tokenResult = $user->createToken('authToken')->plainTextToken;
            return responseFormatter::success(
                [
                    'access_token' => $tokenResult,
                    'token_type' => 'bearer',
                    'user' => $user,
                ],
                'Authenticated'
            );
        } catch (Exception $error) {
            // menangkap setiap error yang ada
            return ResponseFormatter::error(
                [
                    'message' => 'Something went wrong',
                    'error' => $error,
                ],
                'authentication failed',
                500
            );
        }
    }

    // mendapatkan data user yang sedang login
    public function fetch(Request $request)
    {
        return responseFormatter::success(
            ['User' => $request->user()],
            'Data telah berhasil diambil'
        );
    }

    // error disini
    public function updateProfile(Request $request)
    {
        try {
            // mengambil data user yang sedang login
            $user = Auth::user();

            $rules = [
                'name' => 'string|max:255',
                'phone_number' => 'string|max:255',
            ];
            // melakukan pengecekan apakah username sudah ada yang menggunakan atau belum selain user itu sendiri
            if ($user->username != $request->username) {
                $rules['username'] = 'required|string|max:255|unique:users';
            }

            $validateData = $request->validate($rules);

            $data = $request->all();
            $user->update($validateData); //Ini adalah false alarm

            return responseFormatter::success(
                $user,

                'profile updated'
            );
        } catch (Exception $error) {
            return ResponseFormatter::error(
                [
                    'message' => 'Something went wrong',
                    'error' => $error,
                ],
                'Authentication failed',
                500
            );
        }
    }

    public function logout(Request $request)
    {
        // mengambil data user yang sedang direquest
        $user = $request->user();
        //melakukan revoked (menghapus) token
        $token = $user->tokens()->delete();
        return responseFormatter::success(null, 'Token has been revoked');
    }
}