pragma Singleton
import QtQuick 2.0
import QtQuick.LocalStorage 2.0


ListModel {

    property var _db: {
        var db = LocalStorage.openDatabaseSync("Beerware", "", "Beerware LS Database", 100000,
                    function(db) {
                        db.changeVersion("", "0.8.2");
                        db.transaction(function(tx) {
                            tx.executeSql('CREATE TABLE IF NOT EXISTS beers(uID INTEGER PRIMARY KEY, name TEXT, category TEXT, rating INTEGER, UNIQUE (name, category, rating) ON CONFLICT REPLACE)');
                        });
                    });

        if (db.version === "0.8") {
            db.changeVersion("0.8", "0.8.2", function(tx) {
                tx.executeSql('CREATE TABLE IF NOT EXISTS beers2(uID INTEGER PRIMARY KEY, name TEXT, category TEXT, rating INTEGER, UNIQUE (name, category, rating) ON CONFLICT REPLACE)');
                var rs = tx.executeSql('SELECT * FROM beers');
                for (var i = 0; i < rs.rows.length; ++i) {
                    var name = rs.rows.item(i).name;
                    var category = rs.rows.item(i).category;
                    var rating = rs.rows.item(i).rating;
                    var ins = tx.executeSql('INSERT INTO beers2 VALUES(NULL, ?, ?, ?)', [name,category,rating]);
                }
                tx.executeSql('DROP TABLE beers')
                tx.executeSql('ALTER TABLE beers2 RENAME TO beers');
            });
        }

        return db;
    }

    function saveBeer(name, category, rating) {
        _db.transaction(function(tx) {
            var result = tx.executeSql('INSERT OR IGNORE INTO beers VALUES (NULL, ?, ?, ?)', [name, category, rating]);
            if (result.rowsAffected) {
                append({
                           "uID": parseInt(result.insertId),
                           "name": name,
                           "category": category,
                           "rating": rating
                       });
            }
        });
    }

    function changeBeer(uID, name, category, rating) {
        _db.transaction(function(tx) {
            tx.executeSql('REPLACE INTO beers VALUES (?, ?, ?, ?)', [uID, name, category, rating]);
            // This need when one changes beer so it's equal to another
            // in this case two beers merge and we need to update view
            var result = tx.executeSql('SELECT Count(*) AS count FROM beers');
            if (result.rows[0].count !== count) {
                _select();
            }
        });
    }

    function removeBeer(index) {
        _db.transaction(function(tx) {
            tx.executeSql('DELETE FROM beers WHERE uID=(?)', get(index).uID);
        });
        remove(index);
    }

    function _select() {
        clear();
        _db.transaction(function(tx) {
            var rows = tx.executeSql('SELECT * FROM beers').rows;
            for (var i = 0; i < rows.length; ++i) {
                var beer = rows.item(i);
                append({
                           "uID": beer.uID,
                           "name": beer.name,
                           "category": beer.category,
                           "rating": beer.rating
                       });
            }
        });
    }

    Component.onCompleted: _select()
}
