//.pragma library
.import QtQuick.LocalStorage 2.0 as LS

function getDatabase() {
    var DB = LS.LocalStorage.openDatabaseSync("Beerware", "0.8.1", "Beerware L Database", 10000);

    if(DB.version == '0.8.1') {
        DB.transaction(function(tx) {
             tx.executeSql('CREATE TABLE IF NOT EXISTS beers(uid LONGVARCHAR UNIQUE, name TEXT, category TEXT, rating INTEGER)');
        })
    } else if(DB.version != '0.8.1') {
        DB.changeVersion('0.8', '0.8.1', function(tx) {
            tx.executeSql('DROP TABLE beers');
            tx.executeSql('CREATE TABLE IF NOT EXISTS beers(uid LONGVARCHAR UNIQUE, name TEXT, category TEXT, rating INTEGER)');
        });
    }

    return DB;
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
           root.addBeer(rs.rows.item(i).uid, rs.rows.item(i).name, rs.rows.item(i).category, rs.rows.item(i).rating);
        }
    })
}

function saveBeer(uid, name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('INSERT OR REPLACE INTO beers VALUES (?,?,?,?)', [uid, name, category, rating]);
    })
}

function changeBeer(uid, name, category, rating){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('REPLACE INTO beers VALUES (?,?,?,?)', [uid, name, category, rating]);
    })
}

function removeBeer(uid){
    var DB = getDatabase();

    DB.transaction(function(tx) {
        var rs = tx.executeSql('DELETE FROM beers WHERE uid=?' , [uid]);
    })
}
