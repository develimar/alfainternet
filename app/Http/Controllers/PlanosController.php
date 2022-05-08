<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class PlanosController extends Controller
{
    public function CemMegas()
    {
        return view('site.detalhes.100megas');
    }

    public function TrezentosMegas()
    {
        return view('site.detalhes.300megas');
    }

    public function QuatroCentosMegas()
    {
        return view('site.detalhes.400megas');
    }

    public function QuinhentosMegas()
    {
        return view('site.detalhes.500megas');
    }

    public function UmGiga()
    {
        return view('site.detalhes.1giga');
    }
}
