import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:exploremundo/destino_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore Mundo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Destino> destinos = [];
  List<Destino> displayedDestinos = [];
  List<Destino> carouselDestinos = [
    Destino(nome: "Suiça", descricao: "A Suiça é um país montanhoso na Europa Central.", imageUrl: "https://eurodicas.com.br/wp-content/uploads/2021/04/bandeira-da-suica.jpg"),
    Destino(nome: "Brasil", descricao: "O Brasil é o maior país da América do Sul.", imageUrl: "https://s1.static.brasilescola.uol.com.br/be/2024/02/bandeira-do-brasil-hasteada-em-texto-sobre-curiosidades-sobre-o-brasil.jpg"),
    Destino(nome: "Alemanha", descricao: "A Alemanha é um país da Europa Central.", imageUrl: "https://super.abril.com.br/wp-content/uploads/2023/02/SI_448_ORCL_deutschland_site.jpg"),
  ];

  @override
  void initState() {
    super.initState();
    destinos = getDestinos();
    displayedDestinos = destinos;
  }

  List<Destino> getDestinos() {
    return [
      Destino(nome: "Paris", descricao: "A cidade luz e capital da França.", imageUrl: "https://s.rfi.fr/media/display/c49a71fe-3296-11ed-89e6-005056a97e36/w:1280/p:4x3/000_326Y7KL.jpg"),
      Destino(nome: "Tóquio", descricao: "Conhecida por sua torre e a mistura de tradição com modernidade.", imageUrl: "https://designculture.com.br/wp-content/uploads/2016/11/Fotolia_72848283_Subscription_Monthly_M.jpg"),
      Destino(nome: "Nova York", descricao: "A cidade que nunca dorme, famosa por sua paisagem urbana.", imageUrl: "https://www.segueviagem.com.br/wp-content/uploads/2021/12/Estados-Unidos-Nova-York-shutterstock_248799484.jpg"),
      Destino(nome: "Rio de Janeiro", descricao: "Famosa pelo Cristo Redentor e suas praias paradisíacas.", imageUrl: "https://jpimg.com.br/uploads/2023/05/turismo-no-rio-de-janeiro-veja-o-que-visitar-na-cidade-maravilhosa.jpg"),
      Destino(nome: "Londres", descricao: "Capital do Reino Unido, com uma rica história e cultura.", imageUrl: "https://luniverstours.com/wp-content/uploads/2021/08/guia-brasileiro-em-londres-guia-em-londres-passeios-em-londres-1.jpeg"),
      Destino(nome: "Sydney", descricao: "Famosa pela Ópera de Sydney e pela ponte da baía de Sydney.", imageUrl: "https://upload.wikimedia.org/wikipedia/commons/a/a0/Sydney_Australia._%2821339175489%29.jpg"),
      Destino(nome: "Roma", descricao: "Cidade eterna, lar do Coliseu e da Cidade do Vaticano.", imageUrl: "https://catracalivre.com.br/wp-content/uploads/2019/12/istock-1058422764-910x607.jpg"),
      Destino(nome: "Cairo", descricao: "Conhecida pelas pirâmides e esfinge de Gizé.", imageUrl: "https://touristjourney.com/wp-content/uploads/2020/03/cairo-1980350_1920-1-1024x783.jpg"),
      Destino(nome: "Pequim", descricao: "Capital da China, com uma longa história e cultura rica.", imageUrl: "https://i0.wp.com/blogandarilho.com.br/wp-content/uploads/2017/12/pequim-Cidade-Proibida-1.jpg?fit=800%2C437&ssl=1"),
      Destino(nome: "Istambul", descricao: "Ponte entre a Europa e a Ásia, com uma rica herança cultural.", imageUrl: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ4IEvrDfMaVUaSZXQMFOrGgrtiihxDClIiNeSPgW47Zw&s"),
      Destino(nome: "Bangkok", descricao: "Capital da Tailândia, conhecida por seus templos e mercados.", imageUrl: "https://a.cdn-hotels.com/gdcs/production172/d459/3af9262b-3d8b-40c6-b61d-e37ae1aa90aa.jpg"),
    ];
  }

  void updateSearchQuery(String newQuery) {
  if (newQuery.isEmpty) {
    displayedDestinos = List.from(destinos); 
  } else {
    displayedDestinos = destinos.where((destino) {
      return destino.nome.toLowerCase().contains(newQuery.toLowerCase());
    }).toList();
  }
  setState(() {});
}

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Explore Mundo'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.map), text: "Destinos"),
              Tab(icon: Icon(Icons.card_travel), text: "Pacotes"),
              Tab(icon: Icon(Icons.contact_mail), text: "Contato"),
              Tab(icon: Icon(Icons.info_outline), text: "Sobre Nós"),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(displayedDestinos),
                );
              },
            ),
          ],
        ),
        body: TabBarView(
          children: [
            buildDestinationsTab(context),
            buildPackagesTab(),
            buildContactTab(),
            buildAboutUsTab(),
          ],
        ),
      ),
    );
  }

  Widget buildDestinationsTab(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 200.0,
              aspectRatio: 16/9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
            ),
            items: carouselDestinos.map((destino) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DestinoPage(
                          imageUrl: destino.imageUrl,
                          nome: destino.nome,
                          descricao: destino.descricao,
                        )),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: NetworkImage(destino.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 20),
        buildDestinationList(context),
      ],
    );
  }
  Widget buildPackagesTab() {
  return ListView(
    children: [
      _buildPackageTile(
        title: "Pacote de Viagem: Europa",
        subtitle: "Explore as capitais europeias em 10 dias.",
        thumbnailUrl: "https://cdn.panrotas.com.br/portal-panrotas-statics/media-files-cache/312723/dc84d2a6998ced1b8370b2cd31fd347feuropa/0,0,1640,924/full,0.32/0/default.png",
        destinations: ["Paris", "Londres", "Roma"],
      ),
      _buildPackageTile(
        title: "Pacote de Viagem: Ásia",
        subtitle: "Descubra as maravilhas da Ásia em uma viagem inesquecível.",
        thumbnailUrl: "https://donaarquiteta.com.br/wp-content/uploads/2018/08/continente-asia.jpg",
        destinations: ["Tóquio", "Bangkok", "Pequim"],
      ),
      _buildPackageTile(
        title: "Pacote de Viagem: América do Sul",
        subtitle: "Explore a diversidade da América do Sul em 15 dias.",
        thumbnailUrl: "https://www.daninoce.com.br/wp-content/uploads/2017/11/5-ilhas-e-arquipelagos-incriveis-para-conhecer-na-america-do-sul-viagem-dani-noce-imagem-destaque-960x625.jpg",
        destinations: ["Rio de Janeiro", "Buenos Aires", "Machu Picchu"],
      ),
    ],
  );
}

Widget _buildPackageTile({
  required String title,
  required String subtitle,
  required String thumbnailUrl,
  required List<String> destinations,
}) {
  return ListTile(
    leading: Container(
      width: 100,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        image: DecorationImage(
          image: NetworkImage(thumbnailUrl),
          fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(title),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(subtitle),
        SizedBox(height: 4),
        Text("Destinos Incluídos:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: destinations.map((destination) {
            return Row(
              children: [
                Icon(Icons.location_on, size: 16),
                SizedBox(width: 4),
                Text(destination),
              ],
            );
          }).toList(),
        ),
      ],
    ),
    onTap: () {},
  );
}

  Widget buildContactTab() {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.email),
          title: Text("Email"),
          subtitle: Text("contato@exploremundo.com"),
        ),
        ListTile(
          leading: Icon(Icons.phone),
          title: Text("Telefone"),
          subtitle: Text("+55 11 99999-9999"),
        ),
        ListTile(
          leading: Icon(Icons.location_on),
          title: Text("Endereço"),
          subtitle: Text("Rua Aventura, 123, Rio de Janeiro, Brasil"),
        ),
      ],
    );
  }

  Widget buildAboutUsTab() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Sobre Nós",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            "Explore Mundo é um aplicativo dedicado a trazer as melhores experiências de viagem aos nossos usuários. Fundado em 2024, nós ajudamos a conectar aventuras memoráveis com exploradores apaixonados.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget buildDestinationList(BuildContext context) {
    return Column(
      children: displayedDestinos.map((destino) {
        return ListTile(
          leading: Container(
            width: 100,
            height: 60,
            child: Image.network(destino.imageUrl, fit: BoxFit.cover),
          ),
          title: Text(destino.nome),
          subtitle: Text(destino.descricao),
          trailing: const Icon(Icons.arrow_forward),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DestinoPage(
                imageUrl: destino.imageUrl,
                nome: destino.nome,
                descricao: destino.descricao,
              )),
            );
          },
        );
      }).toList(),
    );
  }
}

class Destino {
  final String nome;
  final String descricao;
  final String imageUrl;

  Destino({required this.nome, required this.descricao, required this.imageUrl});
}

class CustomSearchDelegate extends SearchDelegate {
  final List<Destino> filteredDestinos;

  CustomSearchDelegate(this.filteredDestinos);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final queryLower = query.toLowerCase();
    final results = filteredDestinos.where((d) => d.nome.toLowerCase().contains(queryLower)).toList();
    return ListView(
      children: results.map((destino) => ListTile(
        title: Text(destino.nome),
        subtitle: Text(destino.descricao),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DestinoPage(
            imageUrl: destino.imageUrl,
            nome: destino.nome,
            descricao: destino.descricao,
          )));
        },
      )).toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final queryLower = query.toLowerCase();
    final suggestions = filteredDestinos.where((d) => d.nome.toLowerCase().contains(queryLower)).toList();
    return ListView(
      children: suggestions.map((destino) => ListTile(
        title: Text(destino.nome),
      )).toList(),
    );
  }
}
