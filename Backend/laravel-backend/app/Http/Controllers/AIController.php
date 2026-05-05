<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class AIController extends Controller
{
    public function health()
    {
        $response = Http::get('http://127.0.0.1:8001/health');

        return response()->json([
            'from_fastapi' => $response->json()
        ]);
    }

//     public function chat(Request $request)
    // {
    //     $response = Http::post('http://127.0.0.1:8001/chat', [
    //         'message' => $request->message
    //     ]);
    //     return response()->json($response->json());
    // }

    public function chat(Request $request)
    {
        //Grab model's URL and the token from the .env file
        $modelUrl = 'https://api-inference.huggingface.co/models/crispyfrise/llama_3epoch_merged';
        $hfToken = env('HF_TOKEN');

        //Make sure the user actually sent a message
        if (!$request->filled('message')) {
            return response()->json(['error' => 'Message is required'], 400);
        }

        //Send the request to Hugging Face
        $response = Http::withToken($hfToken)
            ->timeout(180) //IMPORTANT: 3-minute timeout to allow the free model to wake up
            ->post($modelUrl, [
                'inputs' => $request->message,
                'parameters' => [
                    'max_new_tokens' => 200, //Adjust how long you want the response to be
                    'temperature' => 0.7     //Adjust creativity (lower is more strict)
                ]
            ]);

        //Return the JSON response and the exact HTTP status code back to your frontend
        return response()->json($response->json(), $response->status());
    }

}
