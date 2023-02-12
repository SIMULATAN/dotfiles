set -e

mkdir .local && cd .local

git clone https://github.com/Jarusk/pass-rs

cd pass-rs/

cargo install --path .
