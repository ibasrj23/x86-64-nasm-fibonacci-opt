# 🚀 x86-64-nasm-fibonacci-opt ✨

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Assembly Language](https://img.shields.io/badge/Language-Assembly_x86--64-blue.svg)](https://en.wikipedia.org/wiki/Assembly_language)
[![Architecture: x86-64](https://img.shields.io/badge/Arch-x86--64-red.svg)](https://en.wikipedia.org/wiki/X86-64)
[![Performance: Optimized](https://img.shields.io/badge/Performance-Optimized-brightgreen.svg)]()
[![Convention: System V ABI](https://img.shields.io/badge/Convention-System_V_ABI-orange.svg)]()

Proyek ini berisi implementasi fungsi **Deret Fibonacci** yang sangat teroptimasi menggunakan metode iteratif, ditulis dalam **Bahasa Assembly x86-64** dengan *assembler* **NASM**. 🌟 Fungsi ini dirancang dengan kepatuhan penuh terhadap **C Calling Convention (System V AMD64 ABI)**, memungkinkannya dipanggil dengan mulus dari kode C/C++ untuk **performa maksimal** di level *bare-metal*.

***

### 🎯 Tujuan dan Karakteristik Utama

Kami fokus pada efisiensi *low-level* untuk setiap siklus CPU.

| Fitur Utama | Deskripsi | Manfaat Performa |
| :---: | :--- | :--- |
| **Optimasi Register** | Pemanfaatan register CPU secara langsung (`RAX`, `RDI`, dll.) untuk perhitungan *loop*. | Meminimalkan *overhead* akses memori utama (cache-friendly). |
| **Iterasi Cepat** | Algoritma iteratif sederhana, menghindari stack *overhead*. | **Jauh lebih cepat** dan stabil dibandingkan implementasi rekursif di Assembly. |
| **Kompatibilitas ABI** | Implementasi Prologue dan Epilogue yang ketat. | Integrasi **plug-and-play** dengan *host program* C/C++. |

***

### 🛠️ Prasyarat (Tools Wajib)

Pastikan Anda memiliki *toolchain* pengembangan x86-64 yang terinstal di sistem Anda (direkomendasikan Linux/macOS).

| Alat | Deskripsi | Perintah Verifikasi |
| :--- | :--- | :--- |
| **NASM** | **Netwide Assembler**. Wajib untuk mengkompilasi file `.asm` ke *object file* 64-bit. | `nasm -v` |
| **GCC** | **GNU Compiler Collection**. Digunakan untuk mengkompilasi *driver* C dan menautkannya (*linking*) dengan *object file* Assembly. | `gcc -v` |

***

### 🧩 Kode Sumber: The Low-Level Logic

#### 1. Assembly Code (`fibonacci.asm`)

> Kode inti yang dioptimasi untuk menghitung $F_n$.
```assembly
; File: fibonacci.asm
section .text
    global fibonacci_iterative

fibonacci_iterative:
    push    rbp
    mov     rbp, rsp

    cmp     rdi, 0          
    je      .done_zero      

    cmp     rdi, 1          
    je      .done_one       
    
    mov     rcx, rdi        
    sub     rcx, 1          
    
    mov     rsi, 0          ; F_{i-2} = 0
    mov     rdi, 1          ; F_{i-1} = 1

.fibo_iter_loop:
    mov     rbx, rdi        ; RBX = F_{i-1} (temp)
    add     rdi, rsi        ; RDI = F_{i-1} + F_{i-2} (New F_i)
    mov     rsi, rbx        ; RSI = Old F_{i-1} (New F_{i-2})

    loop    .fibo_iter_loop 

    mov     rax, rdi        
    jmp     .epilogue

.done_zero:
    mov     rax, 0          
    jmp     .epilogue

.done_one:
    mov     rax, 1          
    jmp     .epilogue

.epilogue:
    pop     rbp
    ret                     
2. C Driver Code (main.c)Kode C yang memanggil fungsi Assembly fibonacci_iterative.C// main.c
#include <stdio.h>

// Deklarasi fungsi Assembly eksternal
extern long long fibonacci_iterative(int n);

int main() {
    int n1 = 10;
    int n2 = 20;

    // Panggil fungsi Assembly (Perhatikan: input di RDI, output di RAX)
    long long result1 = fibonacci_iterative(n1);
    long long result2 = fibonacci_iterative(n2);

    printf("Fibonacci ke-%d (F%d) adalah: %lld\n", n1, n1, result1);
    printf("Fibonacci ke-%d (F%d) adalah: %lld\n", n2, n2, result2);

    return 0;
}
````
⚙️ Cara Kompilasi dan EksekusiIni adalah urutan perintah di terminal untuk membangun proyek Anda.LangkahPerintah TerminalDeskripsi1. Kompilasi Assemblynasm -f elf64 fibonacci.asm -o fibonacci.oMengubah kode Assembly menjadi object file 64-bit (.o).2. Kompilasi & Linkgcc -o fib_app main.c fibonacci.oMenautkan object file C dan Assembly menjadi executable tunggal.3. Eksekusi./fib_appMenjalankan program yang sudah ditautkan.✅ Output Hasil yang DiharapkanCode snippet$ ./fib_app
Fibonacci ke-10 (F10) adalah: 55
Fibonacci ke-20 (F20) adalah: 6765

📦 Protokol Pemanggilan (System V AMD64 ABI)Fungsi fibonacci_iterative harus dipanggil sesuai dengan ABI standar x86-64.RegisterTujuanKeteranganRDIInput Argument 1Menerima nilai $N$ (suku Fibonacci yang dicari) dari pemanggil C.RAXOutput/Return ValueWajib digunakan untuk mengembalikan hasil (suku Fibonacci ke-$N$).📜 Lisensi (MIT)Proyek ini dirilis di bawah Lisensi MIT. Anda bebas menggunakan, memodifikasi, dan mendistribusikan kode ini untuk tujuan komersial maupun non-komersial. Lihat file LICENSE untuk detail lengkap.

***

### ✍️ Author & Contact

Script ini dibuat dan dikelola oleh **[ibasrj23]**. Silakan hubungi untuk pertanyaan, *bug reports*, atau kolaborasi!

| Platform | Ikon & Tautan |
| :--- | :--- |
| **Instagram** | [![Instagram](https://img.shields.io/badge/Instagram-Follow-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://instagram.com/kyy_rj) |
| **WhatsApp** | [![WhatsApp](https://img.shields.io/badge/WhatsApp-Chat-25D366?style=for-the-badge&logo=whatsapp&logoColor=white)](https://wa.me/6285167414106) |

***
