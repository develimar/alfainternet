<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\PrincipalController;
use App\Http\Controllers\PlanosController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

//Route::get('/', function () {
//    return view('index');
//});

//Route::get('/', function (){
//   return view('site.index');
//});

Route::get('/', [PrincipalController::class, 'Principal'])->name('site.index');
Route::prefix('/planos')->group(function (){
    Route::get('/100megas', [PlanosController::class, 'CemMegas'])->name('detalhes.100megas');
    Route::get('/300megas', [PlanosController::class, 'TrezentosMegas'])->name('detalhes.300megas');
    Route::get('/250megas', [PlanosController::class, 'DuzentosCinquentaMegas'])->name('detalhes.250megas');
    Route::get('/400megas', [PlanosController::class, 'QuatroCentosMegas'])->name('detalhes.400megas');
    Route::get('/500megas', [PlanosController::class, 'QuinhentosMegas'])->name('detalhes.500megas');
    Route::get('/1giga', [PlanosController::class, 'Giga'])->name('detalhes.1giga');
});

