-- Ganti <usern> dengan username (misal user1, user2, user3, dst)
CREATE VIEW workshop.<usern>.preparation.employee AS SELECT * FROM "dremio-oss"."employee.employees".employees;
CREATE VIEW workshop.<usern>.preparation.dept AS SELECT * FROM "dremio-oss"."employee.employees".departments;
CREATE VIEW workshop.<usern>.preparation.salaries AS SELECT * FROM "dremio-oss"."employee.employees".salaries;
CREATE VIEW workshop.<usern>.preparation.titles AS SELECT * FROM "dremio-oss"."employee.employees".titles;
CREATE VIEW workshop.<usern>.preparation.dept_manager AS SELECT * FROM "dremio-oss"."employee.employees".dept_manager;
CREATE VIEW workshop.<usern>.preparation.dept_emp AS SELECT * FROM "dremio-oss"."employee.employees".dept_emp;

-- Pelajari struktur data yang ada di dalam 6 view tersebut.

-- Tugas 1: Buat view di folder application dengan nama "tugas1" yang berisi jawaban pertanyaan berikut: Berapa jumlah total employee yang pernah bekerja di perusahaan?

-- Tugas 2: Buat view di folder application dengan nama "tugas2" yang berisi jawaban pertanyaan berikut: Ada berapa department di perusahaan ini?

-- Tugas 3: Buat view di folder application dengan nama "tugas3" yang berisi jawaban pertanyaan berikut: Berapa jumlah employee yang aktif saat ini?

-- Tugas 4: Buat view di folder application dengan nama "tugas4" yang berisi jawaban pertanyaan berikut: Berapa salary terendah yang diperoleh oleh employee yang masih aktif?

-- Tugas 5: Buat view di folder application dengan nama "tugas5" yang berisi jawaban pertanyaan berikut: Berapa jumlah employee di hire paling awal?

-- Tugas 6: Buat view di folder application dengan nama "tugas6" yang berisi jawaban pertanyaan berikut: Siapa nama employee aktif yang tertua?

-- Tugas 7: Buat view di folder application dengan nama "tugas7" yang berisi jawaban pertanyaan berikut: Siapa nama employee yang memiliki salary tertinggi dan apa title nya saat ini?

-- Tugas 8: Buat view di folder application dengan nama "tugas8" yang berisi jawaban pertanyaan berikut: Tanggal lahir dan salary dari manager Marketing saat ini?

-- Tugas 9: Buat user <auditn>, dengan n sesuai urutan user (misal user1=audit1)

-- Tugas 10: Berikan privilege kepada audit1 agar dapat mengakses folder application dan melihat isi view yang ada di dalamnya
