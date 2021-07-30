 <?php

// Check for local file existence, set Last-Modified value to false if file doesn't exist
// to force curl of API
if ($github_file = file_get_contents('github_api_output.json')) {
    $github_json = json_decode($github_file, true);
} else {
    $github_json = ['headers' => ['Last-Modified' => false]];
}

// Send API request to GitHub, including authentication information to ensure rate limits are higher
// See https://developer.github.com/v3/#increasing-the-unauthenticated-rate-limit-for-oauth-applications for details
$curl = curl_init();
$url = 'https://api.github.com/repos/openshift/origin/releases/latest';
$data = ['client_id' => getenv('OPENSHIFT_GITHUB_ID'),
         'client_secret' => getenv('OPENSHIFT_GITHUB_SECRET')];
$url = sprintf("%s?%s", $url, http_build_query($data));

curl_setopt($curl, CURLOPT_URL, $url);
curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
curl_setopt($curl, CURLOPT_HEADER, true);
curl_setopt($curl, CURLOPT_USERAGENT, 'Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.13) Gecko/20080311 Firefox/2.0.0.13');
// Prevent the API request from counting against limit conditionally based on ETag value
// See https://developer.github.com/v3/#conditional-requests for details
if ($github_json['headers']['Last-Modified']) {
    curl_setopt($curl, CURLOPT_HTTPHEADER, ['If-Modified-Since: ' . $github_json['headers']['Last-Modified']]);
}

$result = curl_exec($curl);
$header_size = curl_getinfo($curl, CURLINFO_HEADER_SIZE);
curl_close($curl);

$header = substr($result, 0, $header_size);
$body = substr($result, $header_size);

// Convert headers and API response into arrays for local storage
$body_arr = json_decode($body, true);
$header_arr = array();
foreach (explode("\r\n", $header) as $i => $line) {
    if ($i === 0) {
        $header_arr['http_code'] = $line;
    } else {
        $data = explode(': ', $line);
        if (count($data) == 2) {
            $header_arr[$data[0]] = $data[1];
        }
    }
}
$body_arr['headers'] = $header_arr;

// Return Cached data for a 304 Not Modified status, otherwise return the API result
if ($body_arr['headers']['Status'] == '304 Not Modified') {
    print(json_encode($github_json, JSON_UNESCAPED_SLASHES));
} else {
    file_put_contents('github_api_output.json', json_encode($body_arr, JSON_UNESCAPED_SLASHES));
    print(json_encode($body_arr, JSON_UNESCAPED_SLASHES));
}
