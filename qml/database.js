//.pragma library
.import QtQuick.LocalStorage 2.0 as LS

function getDatabase() {
    return LS.LocalStorage.openDatabaseSync("Beerware", "0.8", "Beerware LocalStorage Database", 10000);
}

function loadBeers(){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER)');

        var rs = tx.executeSql('SELECT * FROM beers');
        for (var i = 0; i < rs.rows.length; i++) {
           root.addBeer(rs.rows.item(i).name, rs.rows.item(i).category, rs.rows.item(i).rating);
        }
    })
}

function saveBeer(name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO beers VALUES (?,?,?);', [name, category, rating]);
    })
}

function removeBeer(name, category){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM beers WHERE name=? AND category=?;' , [name, category]);
    })
}
