#!/bin/bash

## Backup jika terkena limit
# curl http://api.db-ip.com/v2/free/203.161.185.210
# curl https://db-ip.com/demo/home.php?s=203.161.185.210
# curl http://ipwho.is/8.8.4.4
##

# Fungsi untuk mendapatkan informasi IP, negara, dan hostname
get_ip_info() {
    local ip="$1"
    local ip_info

    # Mendapatkan informasi IP dari api ipinfo.io
    ip_info=$(curl -s "http://ipinfo.io/${ip}/json")

    if [ -z "$ip_info" ]; then
        echo "Gagal mendapatkan informasi untuk IP: ${ip}"
        return 1
    fi

    # Mengambil data dari hasil JSON
    local country
    local city
    local hostname

    country=$(echo "$ip_info" | jq -r '.country')
    city=$(echo "$ip_info" | jq -r '.city')
    hostname=$(echo "$ip_info" | jq -r '.hostname')

    # Menampilkan hasil
    echo "${ip} (${country}/${city}/${hostname})"
}

# Cek apakah ada argumen IP
if [ $# -eq 0 ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

# Proses setiap IP yang diberikan sebagai argumen
for ip in "$@"; do
    get_ip_info "$ip"
done
