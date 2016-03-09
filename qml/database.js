//.pragma library
.import QtQuick.LocalStorage 2.0 as LS

function getDatabase() {

    var db = LS.LocalStorage.openDatabaseSync("Beerware", "", "Beerware LS Database", 100000,
                function(db) {
                    db.changeVersion("","0.8.2")
                    db.transaction(function(tx){
                        tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER), PRIMARY KEY (name, category, rating) ON CONFLICT REPLACE');
                    })
                });

    db = LS.LocalStorage.openDatabaseSync("Beerware", "", "Beerware LS Database", 100000);

    if (db.version === "0.8") {
        db.changeVersion("0.8","0.8.2",function(tx)
            {
            console.log("version 0.8 ==> 0.8.2")
            tx.executeSql('DROP TABLE beers')
            tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER), PRIMARY KEY (name, category, rating) ON CONFLICT REPLACE');
            });
    }
    if (db.version === "0.8.1") {
        db.changeVersion("0.8.1","0.8.2",function(tx)
            {
            console.log("version 0.8.1 ==> 0.8.2");
            tx.executeSql('DROP TABLE beers');
            tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER), PRIMARY KEY (name, category, rating) ON CONFLICT REPLACE');
            });
    }

    db = LS.LocalStorage.openDatabaseSync("Beerware", "0.8.2", "Beerware LS Database", 100000);
    db.transaction(function(tx) {
         tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER, PRIMARY KEY (name, category, rating) ON CONFLICT REPLACE)');
    });

 /*   var db = LS.openDatabaseSync("Beerware", "", "Beerware LS Database", 100000,
      function(db) {
          db.changeVersion("0.8.1","0.8.2")
          db.transaction(function(tx){
              tx.executeSql('DROP TABLE beers');
              tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER), PRIMARY KEY (name, category, rating) ON CONFLICT REPLACE');
          })
      });

    db = LS.openDatabaseSync("Beerware", "0.8.2", "Beerware LS Database", 100000)
    db.transaction(function(tx) {
         tx.executeSql('CREATE TABLE IF NOT EXISTS beers(name TEXT, category TEXT, rating INTEGER, PRIMARY KEY (name, category, rating) ON CONFLICT REPLACE)');
    });*/

    return db;
}

function getUID()
{
    var date = new Date();
    // 2016-[0-11]-[1-31]-[unix seconds]
    var uid = date.getFullYear() + '-' + date.getMonth() + '-' + date.getDate() + '-' + date.getTime();

    return uid;
};

function loadBeers(){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('SELECT * FROM beers');
        for (var i = 0; i < rs.rows.length; i++) {
           root.addBeer(rs.rows.item(i).rowid, rs.rows.item(i).name, rs.rows.item(i).category, rs.rows.item(i).rating);
        }
    })
}

function saveBeer(name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR IGNORE INTO beers VALUES (?,?,?)', [name, category, rating]);
    })
}

function changeBeer(rowid, name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('REPLACE INTO beers VALUES (?,?,?,?)', [rowid, name, category, rating]);
    })
}

function removeBeer(rowid){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM beers WHERE rowid=?' , [rowid]);
    })
}
