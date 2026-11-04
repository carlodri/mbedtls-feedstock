/* Uses a function from each of tfpsacrypto, mbedx509, and mbedtls */
#include <stdio.h>
#include <mbedtls/ssl.h>
#include <mbedtls/version.h>
#include <mbedtls/x509_crt.h>
#include <psa/crypto.h>

int main(void) {
    mbedtls_ssl_context ssl;
    mbedtls_x509_crt crt;

    printf("Mbed TLS %s\n", mbedtls_version_get_string());

    mbedtls_x509_crt_init(&crt);
    mbedtls_x509_crt_free(&crt);
    mbedtls_ssl_init(&ssl);
    mbedtls_ssl_free(&ssl);

    return psa_crypto_init() == PSA_SUCCESS ? 0 : 1;
}
