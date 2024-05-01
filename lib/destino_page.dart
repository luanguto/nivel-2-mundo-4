import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart'; 

class DestinoPage extends StatelessWidget {
  final String imageUrl;
  final String nome;
  final String descricao;
  final String telefone;

  const DestinoPage({
    Key? key,
    required this.imageUrl,
    required this.nome,
    required this.descricao,
    this.telefone = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nome),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Image.network(imageUrl, height: 320, fit: BoxFit.cover),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                descricao,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: <Widget>[
                TextButton.icon(
                  icon: const Icon(Icons.phone),
                  label: const Text('Ligar'),
                  onPressed: telefone.isNotEmpty ? () => _launchPhone(context, telefone) : null,
                ),
                TextButton.icon(
                  icon: const Icon(Icons.map),
                  label: const Text('Rotas'),
                  onPressed: () => _launchMap(context, nome),
                ),
                TextButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('Compartilhar'),
                  onPressed: () => _shareDestination(context),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildStarRating(),
                  TextButton.icon(
                    icon: const Icon(Icons.book_online),
                    label: const Text('Reservar'),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStarRating() {
    int rating = 5;  
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: Colors.amber,
        );
      }),
    );
  }

  void _launchPhone(BuildContext context, String phone) async {
    final url = 'tel:$phone';
    if (!await launch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível fazer a ligação')),
      );
    }
  }

  void _launchMap(BuildContext context, String placeName) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$placeName';
    if (!await launch(url)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Não foi possível abrir o mapa')),
      );
    }
  }

  void _shareDestination(BuildContext context) {
    Clipboard.setData(ClipboardData(text: "Confira este destino: $nome - $descricao. Mais informações: $imageUrl"));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Informações do destino copiadas para a área de transferência!')),
    );
  }
}
