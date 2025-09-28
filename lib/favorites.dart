/*
// Favorites Tab
  Widget buildFavorites() {
    final filtered = favorites
        .where((d) => d["place"].toLowerCase().contains(searchQuery))
        .toList();

    if (favorites.isEmpty) {
      return const Center(
        child: Text(
          "No favorites yet.",
          style: TextStyle(color: Colors.black54, fontSize: 16),
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.7,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        return buildDestinationCard(filtered[index]);
      },
    );
  }
*/
