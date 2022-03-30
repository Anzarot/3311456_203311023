/*
factory Genre.fromJson(Map<String, dynamic> json) {
List<String> monthlyGenresRaw =[];

for(int i=0;i<json['items'].length;i++) {
for (int j = 0; j < json['items'][i].length; j++) {
monthlyGenresRaw.add(json['items'][i][j]);
}
}
List<String> uniqueGenres= monthlyGenresRaw.toSet().toList();
List<Genre> monthlyGenresTally = [];
uniqueGenres.forEach((element) {
Genre newGenre = new Genre(element);
monthlyGenresTally.add(newGenre);
});

for(int i=0;i<monthlyGenresTally.length;i++){
for(int j=0;j<monthlyGenresRaw.length;j++){
if(monthlyGenresTally[i].genreName==monthlyGenresRaw[j]){
monthlyGenresTally[i].genreTally++;
}
}
}
String tallyjson = jsonEncode(monthlyGenresTally);
*/