//.pragma library
.import QtQuick.LocalStorage 2.0 as LS

function getDatabase() {

    var db = LS.LocalStorage.openDatabaseSync("Beerware", "", "Beerware LS Database", 100000,
                function(db) {
                    db.changeVersion("","0.8.2")
                    db.transaction(function(tx){
                        tx.executeSql('CREATE TABLE IF NOT EXISTS beers(uID INTEGER PRIMARY KEY, name TEXT, category TEXT, rating INTEGER, UNIQUE (name, category, rating) ON CONFLICT REPLACE)');
                    })
                });

    db = LS.LocalStorage.openDatabaseSync("Beerware", "", "Beerware LS Database", 100000);

    if (db.version === "0.8") {
        db.changeVersion("0.8","0.8.2",function(tx)
            {
            tx.executeSql('CREATE TABLE IF NOT EXISTS beers2(uID INTEGER PRIMARY KEY, name TEXT, category TEXT, rating INTEGER, UNIQUE (name, category, rating) ON CONFLICT REPLACE)');
            var rs = tx.executeSql('SELECT * FROM beers');
            for (var i=0; i<rs.rows.length; ++i) {
                var name = rs.rows.item(i).name;
                var category = rs.rows.item(i).category;
                var rating = rs.rows.item(i).rating;
                var ins = tx.executeSql('INSERT INTO beers2 VALUES(NULL, ?, ?, ?)',[name,category,rating]);
            }
            tx.executeSql('DROP TABLE beers')
            tx.executeSql('ALTER TABLE beers2 RENAME TO beers');
            });
    }

    db = LS.LocalStorage.openDatabaseSync("Beerware", "0.8.2", "Beerware LS Database", 100000,
        function(db) {
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS beers(uID INTEGER PRIMARY KEY, name TEXT, category TEXT, rating INTEGER, UNIQUE (name, category, rating) ON CONFLICT REPLACE)');
            })
        });

    return db;
}

function loadBeers(){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM beers');
        for (var i = 0; i < rs.rows.length; i++) {
           root.addBeer(rs.rows.item(i).uID, rs.rows.item(i).name, rs.rows.item(i).category, rs.rows.item(i).rating);
        }
    })
}

function saveBeer(name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR IGNORE INTO beers VALUES (NULL, ?, ?, ?)', [name, category, rating]);
    })
}

function changeBeer(uID, name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('REPLACE INTO beers VALUES (?, ?,?,?)', [uID, name, category, rating]);
    })
}

function removeBeer(uID){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM beers WHERE uID=(?)' , uID);
    })
}
