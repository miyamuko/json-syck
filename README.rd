= json-syck - syck を利用したそこそこ速い JSON パーサ

  * Author: みやむこ かつゆき ((<URL:mailto:miyamuko@gmail.com>))
  * Home URL: ((<URL:http://miyamuko.s56.xrea.com/xyzzy/json-syck/intro.htm>))
  * Version: 0.1.1


== NAME

json-syck - syck を利用したそこそこ速い JSON パーサ


== SYNOPSIS

  (require "json-syck")
  (use-package :json-syck)

  (json-load
   "{\"title\":\"\\u306f\\u3066\\u306a\\u30b9\\u30bf\\u30fc\\u65e5\\u8a18\",
     \"uri\":\"http://d.hatena.ne.jp/hatenastar/\",
     \"star_count\":\"75630\"}")
  ;;=> (("title" . "はてなスター日記") 
  ;;    ("uri" . "http://d.hatena.ne.jp/hatenastar/")
  ;;    ("star_count" . 75630))


== DESCRIPTION

json-syck は ((<syck|URL:http://code.whytheluckystiff.net/syck/>))
を利用した JSON パーサです。

アプリケーションは以下のコードを追加することで json-syck を利用することができます。

  (in-package :you-application-package)
  (require "json-syck")
  (use-package :json-syck)


== INSTALL

=== NetInstaller でインストール

(1) NetInstaller で yaml-syck と json-syck をインストールします。

=== NetInstaller を使わずにインストール

(1) 以下のアーカイブをダウンロードします。

    * ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/yaml-syck.zip>))
    * ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/json-syck.zip>))

(2) アーカイブを展開して、$XYZZY 配下にファイルをコピーします。


== MODULE

=== DEPENDS

json-syck は以下のモジュールに依存しています。

  * ((<yaml-syck|URL:http://miyamuko.s56.xrea.com/xyzzy/json-syck/intro.htm>))

=== PACKAGE

json-syck は以下のパッケージを利用しています。

  * json-syck

nickname はありません。

=== EXPORT

json-syck は以下のシンボルを export しています。

  * json-syck パッケージ

    [API]
    * ((< json-load >))

    [バージョン]
    * ((< json-syck-version >))

    [例外]
    * ((<json-simple-error>))
    * ((<json-parse-error>))


=== CONDITION

json-syck で定義している例外の継承関係は以下のとおりです。

* simple-error
  * ((< json-simple-error >))
    * ((< json-parse-error >))

--- json-simple-error

    json-syck 関連のすべて例外の親コンディション。

--- json-parse-error

    JSON のパースエラーが発生した時に通知される例外。


=== VARIABLE

なし。


=== COMMAND

なし。


=== FUNCTION

--- json-load

    call-seq:
        (json-load str [options...])  =>  S expression

    JSON テキストを読み込み S 式に変換します。

    * 引数 str には JSON を文字列で指定します。
    * 文字列以外を指定した場合は type-error 例外を通知します
    * 引数 options はパーサオプションを指定します。
      パーサオプションは キーワードリストで指定します。

    以下のオプションを指定可能です。

    * ((< null >))
    * ((< true >))
    * ((< false >))
    * ((< seq >))
    * ((< map >))
    * ((< hash-table-test >))

    : null
        JSON の null に対応する lisp の値を指定します。

        デフォルト値は nil です。

          (json-load "name: null" :null :json-null)
          ;; => (("name" . :json-null))

    : true
        JSON の true に対応する lisp の値を指定します。

        デフォルト値は t です。

          (json-load "xyzzy: true" :true :json-true)
          ;; => (("xyzzy" . :json-true))

    : false
        JSON の false に対応する lisp の値を指定します。

        デフォルト値は nil です。

          (json-load "xyzzy: false" :false :json-false)
          ;; => (("xyzzy" . :json-false))

    : seq
        JSON の Arrays のマッピング方法を指定します。

        * 引数は :sexp または :array を指定します。
        * :sexp を指定した場合はリストにマッピングします。
        * :array を指定した場合は配列にマッピングします。

        デフォルト値は:sexp です。

          (json-load "[1, 2, 3]" :seq :sexp)
          ;; => (1 2 3)

          (json-load "[1, 2, 3]" :seq :array)
          ;; => #(1 2 3)

    : map
        JSON の Objects のマッピング方法を指定します。

        * 引数は :sexp または :hash-table を指定します。
        * :sexp を指定した場合は関連リストにマッピングします。
        * :hash-table を指定した場合は hashtable にマッピングします。

        デフォルト値は:sexp です。

          (json-load "{xyzzy: common lisp, emacs: emacs lisp}" :map :sexp)
          ;; => (("xyzzy" . "common lisp") ("emacs" . "emacs lisp"))

          (setf h (json-load "{xyzzy: common lisp, emacs: emacs lisp}" :map :hash-table))
          ;; => #<hashtable 52893588>
          (gethash "xyzzy" h)
          ;; => "common lisp"
          ;;    t
          (gethash "emacs" h)
          ;; => "emacs lisp"
          ;;    t

        ((<hash-table-test>)) も参照してください。

    : hash-table-test
        hash-table のテスト関数を指定します。

        * ((<map>)) に :hash-table を指定したときのみ有効なオプションです。
        * 指定可能な関数は eq, eql, equal, equalp です。

        デフォルトは equal です。

          (setf h (json-load "{name: hogehoge}" :map :hash-table))
          ;; => #<hashtable 52893564>
          (hash-table-test h)
          ;; => equal
          (gethash "name" h)
          ;; => "hogehoge"
          ;;    t
          (gethash "NaME" h)
          ;; => nil
                nil

          (setf h (json-load "{name: hogehoge}" :map :hash-table :hash-table-test #'equalp))
          ;; => #<hashtable 52893180>
          (hash-table-test h)
          ;; => equalp
          (gethash "name" h)
          ;; => "hogehoge"
          ;;    t
          (gethash "NaME" h)
          ;; => "hogehoge"
          ;;    t


--- json-syck-version

    call-seq:
        (json-syck-version)  =>  "majar.minor.teeny"

    json-syck (本ライブラリのこと) のバージョンを返します。

    バージョンは major.minor.teeny という形式です。
    それぞれの番号は必ず 1 桁にするので、以下のように比較することができます
    (Ruby と同じです :-)。

        (if (string<= "1.1.0" (json-syck-version))
            (1.1.0 以降で有効な処理)
          (1.1.0 より前のバージョンでの処理))


== LIMITATIONS

* JSON 形式での dump はサポートしていません。


== KNOWN BUGS

* yaml-syck または syck 自体のバグにより xyzzy ごとクラッシュする可能性があるので
  auto-save-buffers を使ってください。。。


== TODO

* sexp->json ダンプのサポート (emitter)
* syck.dll でエラーになっても xyzzy ごと落ちないようにする
* バッファから load
* ストリームから load


== AUTHOR

みやむこ かつゆき (((<URL:mailto:miyamuko (at) gmail.com>)))


== SEE ALSO

  : RFC 4627 The application/json Media Type for JavaScript Object Notation (JSON)
        ((<URL:http://tools.ietf.org/html/rfc4627>))

  : JSON の紹介
        ((<URL:http://www.json.org/json-ja.html>))


== COPYRIGHT

json-syck は MIT/X ライセンスにしたがって利用可能です。

See json-syck/docs/MIT-LICENSE for full license.


== NEWS

<<<NEWS.rd
