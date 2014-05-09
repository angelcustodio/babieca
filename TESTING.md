# Performance tests

Performance test using siege.

    sudo apt-get install siege

## do nothing

    siege 'http://127.0.0.1:7000/nothing POST' -b -c 200 -t60s \
    --header="Content-Type: application/json"

## store_position

    siege 'http://127.0.0.1:7000/store_position_async POST \
    {"token":"QDNnIFRrQXaqnyVuVs8HEw==", "position": 424}' -b -c 200 -t60s \
    --header="Content-Type: application/json"


