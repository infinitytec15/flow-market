<?php

// Health check endpoint for Railway
header('Content-Type: application/json');

try {
    // Check if Laravel is working
    if (file_exists('../vendor/autoload.php')) {
        echo json_encode([
            'status' => 'healthy',
            'timestamp' => date('Y-m-d H:i:s'),
            'laravel' => 'loaded'
        ]);
    } else {
        echo json_encode([
            'status' => 'unhealthy',
            'error' => 'Laravel not loaded'
        ]);
    }
} catch (Exception $e) {
    echo json_encode([
        'status' => 'unhealthy',
        'error' => $e->getMessage()
    ]);
}
