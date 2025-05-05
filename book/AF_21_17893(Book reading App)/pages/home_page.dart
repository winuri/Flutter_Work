import 'package:flutter/material.dart';
import 'current_reading_list_page.dart';
import 'completed_books_page.dart';
import 'book_details_page.dart';
import 'add_book_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  final List<Map<String, String>> trendingBooks = [
   {
      'title': 'Atomic Habits',
      'author': 'James Clear',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/91bYsX41DVL.jpg',
      'description': 'Atomic Habits explains how small, consistent changes in behavior can lead to significant improvements in life. It combines scientific research with practical strategies for habit formation, emphasizing identity-based habits and systems over goals. This book helps readers understand and implement powerful routines to build lasting success.',
      'rating': '4.8'
    },
    {
      'title': 'The Alchemist',
      'author': 'Paulo Coelho',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/71aFt4+OTOL.jpg',
      'description': 'The Alchemist follows Santiago, a shepherd boy who dreams of a treasure in Egypt. His journey teaches him about listening to his heart, following his dreams, and trusting the universe. The story beautifully conveys messages about destiny, perseverance, and the wisdom found in seeking one’s personal legend.' ,     
          'rating': '4.7'
    },

    {
      'title': 'Rich Dad Poor Dad',
      'author': 'Robert T. Kiyosaki',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/81bsw6fnUiL.jpg',
      'description': 'Kiyosaki contrasts the financial philosophies of his two "dads" to highlight principles of financial independence. He stresses the importance of investing, understanding assets and liabilities, and gaining financial education. The book challenges conventional ideas about work, income, and wealth, offering practical advice for achieving long-term financial success.',
      
      'rating': '4.6'
    },
    {
      'title': 'Think and Grow Rich',
      'author': 'Napoleon Hill',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/71UypkUjStL.jpg',
      'description': 'A classic personal development book, it outlines key success principles based on interviews with wealthy individuals. Hill emphasizes the power of thoughts, goal-setting, desire, and persistence. The book provides a blueprint for turning dreams into reality and continues to inspire readers to achieve financial and personal success.',
      'rating': '4.7'
    },
    {
      'title': '1984',
      'author': 'George Orwell',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/71kxa1-0mfL.jpg',
      'description': '1984 is a chilling portrayal of a dystopian future under constant surveillance and authoritarian control. Orwell presents a society where freedom and truth are suppressed, exposing the dangers of totalitarianism. The novel explores themes of identity, censorship, and resistance, leaving a lasting impact on political and literary thought.',
      'rating': '4.8'
    },
    {
      'title': 'To Kill a Mockingbird',
      'author': 'Harper Lee',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/81gepf1eMqL.jpg',
      'description': 'This novel explores racial injustice in the American South through the eyes of young Scout Finch. Her father, Atticus, defends a Black man accused of rape. The book combines innocence, moral growth, and the fight for justice in a deeply moving narrative about prejudice and human compassion.',
      'rating': '4.9'
    },
    {
      'title': 'Sapiens',
      'author': 'Yuval Noah Harari',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/713jIoMO3UL.jpg',
      'description': 'Sapiens chronicles the history of humankind, from early Homo sapiens to modern civilization. Harari explores biology, culture, and economics, shedding light on how societies evolved. It’s a compelling synthesis of science and storytelling that encourages readers to question our past, present, and future as a species.',
      'rating': '4.6'
    },
    {
      'title': 'Becoming',
      'author': 'Michelle Obama',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/81h2gWPTYJL.jpg',
      'description': 'In this powerful memoir, Michelle Obama shares her journey from a modest upbringing to becoming the First Lady of the United States. With honesty and grace, she recounts her struggles and triumphs, offering inspiration and insight into her life, values, and belief in the power of resilience.',
      'rating': '4.9'
    },
    {
      'title': 'The Power of Now',
      'author': 'Eckhart Tolle',
      'image': 'https://images-na.ssl-images-amazon.com/images/I/71aFt4+OTOL._AC_UL600_SR600,600_.jpg',
      'description': 'This spiritual guide urges readers to live fully in the present moment. Tolle provides tools for overcoming the ego and finding inner peace by letting go of past regrets and future anxieties. The book blends Eastern philosophy and mindfulness practices, leading to spiritual awakening and transformation.',
      'rating': '4.7'
      
    },

    
  ];

  final List<Map<String, String>> completedBooks = [];
  final List<Map<String, String>> currentReadingBooks = [];

  void _addBook(String title, String author, String description, String rating, String image) {
    setState(() {
      trendingBooks.add({
        'title': title,
        'author': author,
        'description': description,
        'rating': rating,
        'image': image,
      });
    });
  }

  void _addToCurrentReading(Map<String, String> book) {
    setState(() {
      if (!currentReadingBooks.any((b) => b['title'] == book['title'])) {
        currentReadingBooks.add(book);
      }
    });
  }

  void _markAsCompleted(Map<String, String> book) {
    setState(() {
      if (!completedBooks.any((b) => b['title'] == book['title'])) {
        completedBooks.add(book);
        currentReadingBooks.removeWhere((b) => b['title'] == book['title']);
      }
    });
  }

  List<Widget> get _pages => [
        _buildHomeContent(),
        CurrentReadingListPage(currentReadingBooks: currentReadingBooks),
        CompletedBooksPage(completedBooks: completedBooks),
        ProfilePage(),
      ];

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _buildHomeContent() {
    final filteredBooks = trendingBooks
        .where((book) => book['title']!.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (value) => setState(() => _searchQuery = value),
            decoration: InputDecoration(
              hintText: 'Search books...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          Text('Trending Books', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          _buildBookGrid(filteredBooks),
        ],
      ),
    );
  }

  Widget _buildBookGrid(List<Map<String, String>> books) {
    return Expanded(
      child: books.isEmpty
          ? Center(child: Text('No books found'))
          : GridView.builder(
              itemCount: books.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.6,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final book = books[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BookDetailsPage(
                          book: book,
                          onAddToReading: () {
                            _addToCurrentReading(book);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${book['title']} added to Current Reading!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          },
                          onMarkAsCompleted: () {
                            _markAsCompleted(book);
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${book['title']} marked as Completed!'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(book['image']!, height: 160, fit: BoxFit.cover),
                      ),
                      SizedBox(height: 8),
                      Text(book['title']!, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(book['author']!, style: TextStyle(color: Colors.grey)),
                      Text('⭐ ${book['rating']}', style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                );
              },
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Tracker'),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddBookPage(onBookSaved: _addBook)),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.logout, size: 30),
            onPressed: _logout,
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        selectedItemColor: const Color.fromARGB(255, 72, 49, 149),
        unselectedItemColor: const Color.fromARGB(179, 45, 61, 181),
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Reading'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Completed'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'Profile'),
        ],
      ),
    );
  }
}
