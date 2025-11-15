### 💻 x86-64-nasm-fibonacci-opt

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Assembly Language](https://img.shields.io/badge/Language-Assembly_x86--64-blue.svg)](https://en.wikipedia.org/wiki/Assembly_language)
[![Architecture: x86-64](https://img.shields.io/badge/Arch-x86--64-red.svg)](https://en.wikipedia.org/wiki/X86-64)

Proyek ini berisi implementasi fungsi **Deret Fibonacci** yang sangat teroptimasi menggunakan metode iteratif, ditulis dalam **Bahasa Assembly x86-64** dengan *assembler* **NASM**. Fungsi ini dirancang dengan kepatuhan penuh terhadap **C Calling Convention (System V AMD64 ABI)**, memungkinkannya dipanggil dengan mulus dari kode C/C++ untuk performa maksimal.

---

### 🚀 Tujuan dan Karakteristik

Tujuan utama dari proyek ini adalah untuk menyediakan implementasi Fibonacci yang memiliki kecepatan eksekusi tinggi dan efisiensi sumber daya komputasi. Implementasi ini menonjolkan praktik *low-level* profesional:

* **Optimasi Register:** Pemanfaatan register CPU secara langsung (`RAX`, `RDI`, dll.) untuk meminimalkan akses memori.
* **Efisiensi Iteratif:** Penggunaan algoritma iteratif untuk menghindari *overhead* pemanggilan fungsi pada metode rekursif.
* **Kompatibilitas ABI:** Penerapan **Prologue** dan **Epilogue** yang benar untuk integrasi mulus dengan *host program* C/C++.

---

### 🛠️ Prasyarat (Tools Wajib)

Untuk membangun dan menguji kode Assembly ini, Anda memerlukan *toolchain* pengembangan *low-level* yang standar.

| Alat | Deskripsi | Perintah Verifikasi |
| :--- | :--- | :--- |
| **NASM** | **Netwide Assembler**. Digunakan untuk mengkompilasi file Assembly (`.asm`) menjadi *object file* (`.o`). | `nasm -v` |
| **GCC** | **GNU Compiler Collection**. Digunakan untuk mengkompilasi *driver* C dan menautkannya (*linking*) dengan *object file* Assembly. | `gcc -v` |
| **make** | (Opsional, disarankan) Alat bantu otomatisasi proses kompilasi. | `make -v` |

---

### ⚙️ Cara Kompilasi dan Menjalankan

Asumsikan file Assembly Anda bernama `fibonacci.asm` dan Anda memiliki file *driver* C yang memanggilnya (misalnya `main.c`).

#### 1. Kompilasi Kode Assembly

Gunakan NASM untuk mengkompilasi kode Assembly menjadi *object file* 64-bit (`-f elf64`).

```bash
nasm -f elf64 fibonacci.asm -o fibonacci.o
