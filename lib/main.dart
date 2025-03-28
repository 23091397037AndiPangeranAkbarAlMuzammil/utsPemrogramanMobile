import 'package:flutter/material.dart';  // Library utama untuk membangun UI dengan Flutter
import 'package:google_fonts/google_fonts.dart';  // Library untuk menggunakan Google Fonts
import 'package:confetti/confetti.dart';  // Library untuk efek konfeti saat pengguna menyelesaikan kuis
import 'dart:async';  // Library untuk menggunakan fitur Timer
import 'dart:math';  // Library untuk operasi matematika seperti randomisasi

void main() {
  runApp(QuizApp());  // Fungsi utama yang menjalankan aplikasi dengan memanggil QuizApp
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,  // Menghilangkan label debug pada aplikasi
        title: 'K3Kuis',  // Judul aplikasi
        home: HomeScreen()  // Menentukan bahwa halaman pertama aplikasi adalah HomeScreen
    );
  }
}

// Halaman Awal
class HomeScreen extends StatelessWidget {  // HomeScreen adalah halaman utama aplikasi
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(  // Membuat AppBar di bagian atas layar
        title: Text(
            'K3Kuis',  // Judul AppBar
            style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.white) // Menggunakan font Poppins
        ),
        backgroundColor: Colors.deepOrange,  // Warna latar belakang AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(  // Mengatur background dengan efek gradasi
            colors: [Colors.orangeAccent, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(  // Memposisikan konten di tengah layar
          child: Column(  // Menyusun elemen secara vertikal
            mainAxisAlignment: MainAxisAlignment.center,  // Memposisikan elemen ke tengah secara vertikal
            children: [
              Text(
                'Mulai Kuis?',  // Teks utama di halaman
                style: GoogleFonts.poppins(  // Menggunakan font Poppins
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),  // Jarak antar elemen
              ElevatedButton(
                onPressed: () {  // Ketika tombol ditekan, berpindah ke halaman kuis
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizScreen()),  // Berpindah ke QuizScreen
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,  // Warna tombol putih
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),  // Ukuran tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20), // ATUR BORDER RADIUS
                  ),
                ),
                child: Text(
                  'Gas',  // Teks tombol
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Halaman Kuis - Menggunakan StatefulWidget agar dapat mengubah tampilan saat kuis berlangsung
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

// State dari QuizScreen, di sini logika permainan kuis akan dikelola
class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0; // Menyimpan indeks pertanyaan yang sedang ditampilkan
  double _timeLeft = 10.0; // Waktu tersisa untuk menjawab pertanyaan dalam detik
  int _score = 0; // Skor pemain berdasarkan jawaban yang benar
  Timer? _timer; // Timer untuk menghitung mundur waktu
  bool _quizFinished = false; // Menandai apakah kuis sudah selesai atau belum
  late ConfettiController _confettiController; // Digunakan untuk menampilkan efek konfeti saat menjawab benar

  int? _selectedIndex; // Menyimpan indeks jawaban yang dipilih oleh pengguna
  bool? _isCorrect; // Menandai apakah jawaban yang dipilih benar atau salah

  // Daftar pertanyaan untuk kuis, menggunakan List<Map<String, dynamic>>
  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'Apa kepanjangan dari PTN?', // Pertanyaan pertama
      'options': [
        'Perguruan Tinggi Negeri',
        'Pendidikan Tinggi Nasional',
        'Program Tertentu Nasional',
        'Perguruan Teknologi Nasional'
      ], // Pilihan jawaban
      'answer': 'Perguruan Tinggi Negeri' // Jawaban benar
    },
    {
      'question': 'Apa yang biasanya dilakukan mahasiswa baru di awal perkuliahan?',
      'options': ['Wisuda', 'PKKMB', 'UTS', 'KKN'],
      'answer': 'PKKMB'
    },
    {
      'question': 'Siapa yang bertanggung jawab mengajar di kelas?',
      'options': ['Mahasiswa', 'Rektor', 'Dosen', 'Asisten Lab'],
      'answer': 'Dosen'
    },
    {
      'question': 'Apa nama dokumen yang digunakan mahasiswa untuk memilih mata kuliah?',
      'options': ['KRS', 'KTM', 'SIAKAD', 'Skripsi'],
      'answer': 'KRS'
    },
    {
      'question': 'Organisasi mahasiswa di tingkat universitas biasanya disebut?',
      'options': ['OSIS', 'BEM', 'Senat Sekolah', 'HIMA'],
      'answer': 'BEM'
    },
    {
      'question': 'Apa kepanjangan dari UKM di kampus?',
      'options': [
        'Unit Kegiatan Mahasiswa',
        'Universitas Kampus Mandiri',
        'Usaha Kecil Mahasiswa',
        'Unit Kesejahteraan Mahasiswa'
      ],
      'answer': 'Unit Kegiatan Mahasiswa'
    },
    {
      'question': 'Sistem yang digunakan untuk mengelola data akademik mahasiswa disebut?',
      'options': ['E-learning', 'SIAKAD', 'SIPD', 'SPP'],
      'answer': 'SIAKAD'
    },
    {
      'question': 'Dokumen identitas resmi mahasiswa yang dikeluarkan kampus adalah?',
      'options': ['SIM', 'KTP', 'KTM', 'NPWP'],
      'answer': 'KTM'
    },
    {
      'question': 'Apa yang biasanya menjadi tugas akhir mahasiswa sebelum lulus?',
      'options': ['PKKMB', 'UTS', 'Skripsi', 'Praktikum'],
      'answer': 'Skripsi'
    },
    {
      'question': 'Istilah untuk mahasiswa yang baru masuk kuliah adalah?',
      'options': ['Fresh Graduate', 'Senior', 'Maba', 'Dosen Muda'],
      'answer': 'Maba'
    },
  ];


  @override
  void initState() {
    super.initState();
    _startTimer(); // Memulai timer saat halaman dimulai
    _confettiController = ConfettiController(duration: Duration(
        seconds: 3)); // Inisialisasi efek confetti dengan durasi 3 detik
  }

  void _startTimer() {
    _timer?.cancel(); // Jika ada timer sebelumnya, hentikan terlebih dahulu
    setState(() {
      _timeLeft =
      10.0; // Mengatur ulang waktu ke 10 detik setiap pertanyaan dimulai
    });

    // Membuat timer yang berjalan setiap 100 milidetik (0.1 detik)
    _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (_timeLeft > 0) {
        setState(() {
          // Mengurangi waktu 0.1 detik dan membulatkan hingga 1 desimal
          _timeLeft = double.parse((_timeLeft - 0.1).toStringAsFixed(1));
        });
      } else {
        timer.cancel(); // Hentikan timer saat waktu habis
        _nextQuestion(); // Pindah ke pertanyaan berikutnya
      }
    });
  }

  // Fungsi untuk menentukan warna progres berdasarkan sisa waktu
  Color _getProgressColor() {
    if (_timeLeft > 6) {
      return Colors.green; // Warna hijau jika waktu masih lebih dari 6 detik
    } else if (_timeLeft > 3) {
      return Colors.yellow; // Warna kuning jika waktu antara 3 hingga 6 detik
    } else {
      return Colors.red; // Warna merah jika waktu kurang dari 3 detik
    }
  }

// Fungsi untuk menangani jawaban yang dipilih pengguna
  void _answerQuestion(int index) {
    setState(() {
      _selectedIndex = index; // Menyimpan indeks jawaban yang dipilih
      // Mengecek apakah jawaban yang dipilih benar dengan membandingkan dengan jawaban yang benar
      _isCorrect = _questions[_currentQuestionIndex]['options'][index] ==
          _questions[_currentQuestionIndex]['answer'];
      if (_isCorrect!) _score++; // Jika benar, tambahkan skor
    });

    // Tunggu 1 detik sebelum pindah ke pertanyaan berikutnya
    Future.delayed(Duration(seconds: 1), () {
      _nextQuestion();
    });
  }


  // Fungsi untuk melanjutkan ke pertanyaan berikutnya
  void _nextQuestion() {
    _timer?.cancel(); // Menghentikan timer saat berpindah ke pertanyaan baru
    setState(() {
      _selectedIndex = null; // Reset pilihan jawaban pengguna
      _isCorrect = null; // Reset status jawaban benar atau salah

      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++; // Pindah ke pertanyaan berikutnya
        _startTimer(); // Memulai ulang timer untuk pertanyaan baru
      } else {
        _quizFinished = true; // Jika pertanyaan habis, tandai kuis selesai
        _confettiController.play(); // Memainkan efek konfeti sebagai perayaan
      }
    });
  }

// Fungsi untuk mengulang kuis dari awal
  void _restartQuiz() {
    setState(() {
      _currentQuestionIndex = 0; // Reset ke pertanyaan pertama
      _score = 0; // Reset skor ke nol
      _quizFinished = false; // Menandai bahwa kuis belum selesai
      _startTimer(); // Memulai kembali timer
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'K3Kuis',
          style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
        // Mengatur warna latar belakang AppBar
        iconTheme: IconThemeData(
            color: Colors.white), // Mengubah warna ikon default menjadi putih
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrange],
            // Mengatur efek gradasi latar belakang
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Memberikan jarak dari tepi layar
          child: _quizFinished ? _buildScoreScreen() : _buildQuizScreen(),
          // Menampilkan halaman hasil jika kuis selesai, atau halaman pertanyaan jika masih berlangsung
        ),
      ),
    );
  }

  Widget _buildQuizScreen() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // Menengahkan elemen secara vertikal
      crossAxisAlignment: CrossAxisAlignment.stretch,
      // Memastikan elemen memenuhi lebar layar
      children: [
        // Menampilkan pertanyaan kuis
        Text(
          _questions[_currentQuestionIndex]['question'],
          // Mengambil pertanyaan berdasarkan indeks saat ini
          key: ValueKey<int>(_currentQuestionIndex),
          // Membantu dalam animasi atau transisi state
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign
              .center, // Membuat teks pertanyaan berada di tengah
        ),
        SizedBox(height: 20), // Jarak antar elemen

        // Menampilkan progress bar waktu
        LinearProgressIndicator(
          value: _timeLeft / 10,
          // Menghitung progress berdasarkan waktu tersisa
          backgroundColor: Colors.white54,
          // Warna latar belakang progress bar
          color: _getProgressColor(),
          // Warna progress akan berubah sesuai dengan waktu
          minHeight: 8, // Tinggi progress bar
        ),
        SizedBox(height: 20), // Jarak antar elemen

        // Menampilkan opsi jawaban
        ...(_questions[_currentQuestionIndex]['options'] as List<String>)
            .asMap()
            .entries
            .map((entry) {
          int index = entry.key; // Indeks dari opsi jawaban
          String option = entry.value; // Teks dari opsi jawaban
              index; // Mengecek apakah opsi ini yang dipilih

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 8),
            // Memberikan jarak horizontal 80 dan vertical 8
            child: ElevatedButton(// Jika belum memilih jawaban, tombol dapat ditekan untuk menjawab; jika sudah memilih, tombol dinonaktifkan
              onPressed: _selectedIndex == null
                  ? () => _answerQuestion(index)
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 14), // Memberikan padding vertikal agar tombol lebih besar
                minimumSize: Size(double.infinity, 50), // Lebar full, tinggi 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Membuat sudut tombol menjadi lebih melengkung
                ),
              ),
              //menampilkan opsi jawaban
              child: Text(
                option, //teks opsi jawaban
                style: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black), //tebal font, dan warna hitam
              ),
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildScoreScreen() {
    return Stack(
      alignment: Alignment.center,
      // Mengatur elemen dalam Stack agar berada di tengah
      children: [
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            // Membuat ukuran Column seminimal mungkin
            children: [
              // Menampilkan teks "Kuis Selesai!"
              Text(
                'Kuis Selesai!',
                style: GoogleFonts.poppins(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              // Jarak antara teks "Kuis Selesai!" dan skor

              // Menampilkan skor pengguna
              Text(
                'Skor Anda: $_score / ${_questions.length}',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  color: Colors
                      .white70, // Warna sedikit transparan agar tidak terlalu kontras
                ),
              ),
              SizedBox(height: 30),
              // Jarak antara skor dan tombol ulangi

              // Tombol untuk mengulang kuis
              ElevatedButton(
                onPressed: _restartQuiz,
                // Memanggil fungsi untuk mengulang kuis
                child: Text(
                  'Ulangi Kuis',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors
                        .black, // Warna teks hitam agar kontras dengan tombol
                  ),
                ),
              ),
            ],
          ),
        ),

        // Efek konfeti saat kuis selesai
        ConfettiWidget(
          confettiController: _confettiController,
          // Menggunakan controller konfeti yang sudah dibuat
          blastDirection: -pi / 2,
          // Konfeti diarahkan ke atas
          colors: [
            Colors.red,
            Colors.blue,
            Colors.green,
            Colors.yellow
          ], // Warna-warna konfeti
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer
        ?.cancel(); // Menghentikan timer jika masih berjalan untuk mencegah memory leak
    _confettiController
        .dispose(); // Membersihkan controller konfeti untuk mencegah penggunaan memori berlebih
    super
        .dispose(); // Memanggil metode dispose dari parent class untuk memastikan widget dibersihkan dengan benar
  }
}
