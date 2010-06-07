= json-syck - syck �𗘗p���������������� JSON �p�[�T

  * Author: �݂�ނ� ���䂫 ((<URL:mailto:miyamuko@gmail.com>))
  * Home URL: ((<URL:http://miyamuko.s56.xrea.com/xyzzy/json-syck/intro.htm>))
  * Version: 0.1.1


== NAME

json-syck - syck �𗘗p���������������� JSON �p�[�T


== SYNOPSIS

  (require "json-syck")
  (use-package :json-syck)

  (json-load
   "{\"title\":\"\\u306f\\u3066\\u306a\\u30b9\\u30bf\\u30fc\\u65e5\\u8a18\",
     \"uri\":\"http://d.hatena.ne.jp/hatenastar/\",
     \"star_count\":\"75630\"}")
  ;;=> (("title" . "�͂ĂȃX�^�[���L") 
  ;;    ("uri" . "http://d.hatena.ne.jp/hatenastar/")
  ;;    ("star_count" . 75630))


== DESCRIPTION

json-syck �� ((<syck|URL:http://code.whytheluckystiff.net/syck/>))
�𗘗p���� JSON �p�[�T�ł��B

�A�v���P�[�V�����͈ȉ��̃R�[�h��ǉ����邱�Ƃ� json-syck �𗘗p���邱�Ƃ��ł��܂��B

  (in-package :you-application-package)
  (require "json-syck")
  (use-package :json-syck)


== INSTALL

=== NetInstaller �ŃC���X�g�[��

(1) NetInstaller �� yaml-syck �� json-syck ���C���X�g�[�����܂��B

=== NetInstaller ���g�킸�ɃC���X�g�[��

(1) �ȉ��̃A�[�J�C�u���_�E�����[�h���܂��B

    * ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/yaml-syck.zip>))
    * ((<URL:http://miyamuko.s56.xrea.com/xyzzy/archives/json-syck.zip>))

(2) �A�[�J�C�u��W�J���āA$XYZZY �z���Ƀt�@�C�����R�s�[���܂��B


== MODULE

=== DEPENDS

json-syck �͈ȉ��̃��W���[���Ɉˑ����Ă��܂��B

  * ((<yaml-syck|URL:http://miyamuko.s56.xrea.com/xyzzy/json-syck/intro.htm>))

=== PACKAGE

json-syck �͈ȉ��̃p�b�P�[�W�𗘗p���Ă��܂��B

  * json-syck

nickname �͂���܂���B

=== EXPORT

json-syck �͈ȉ��̃V���{���� export ���Ă��܂��B

  * json-syck �p�b�P�[�W

    [API]
    * ((< json-load >))

    [�o�[�W����]
    * ((< json-syck-version >))

    [��O]
    * ((<json-simple-error>))
    * ((<json-parse-error>))


=== CONDITION

json-syck �Œ�`���Ă����O�̌p���֌W�͈ȉ��̂Ƃ���ł��B

* simple-error
  * ((< json-simple-error >))
    * ((< json-parse-error >))

--- json-simple-error

    json-syck �֘A�̂��ׂė�O�̐e�R���f�B�V�����B

--- json-parse-error

    JSON �̃p�[�X�G���[�������������ɒʒm������O�B


=== VARIABLE

�Ȃ��B


=== COMMAND

�Ȃ��B


=== FUNCTION

--- json-load

    call-seq:
        (json-load str [options...])  =>  S expression

    JSON �e�L�X�g��ǂݍ��� S ���ɕϊ����܂��B

    * ���� str �ɂ� JSON �𕶎���Ŏw�肵�܂��B
    * ������ȊO���w�肵���ꍇ�� type-error ��O��ʒm���܂�
    * ���� options �̓p�[�T�I�v�V�������w�肵�܂��B
      �p�[�T�I�v�V������ �L�[���[�h���X�g�Ŏw�肵�܂��B

    �ȉ��̃I�v�V�������w��\�ł��B

    * ((< null >))
    * ((< true >))
    * ((< false >))
    * ((< seq >))
    * ((< map >))
    * ((< hash-table-test >))

    : null
        JSON �� null �ɑΉ����� lisp �̒l���w�肵�܂��B

        �f�t�H���g�l�� nil �ł��B

          (json-load "name: null" :null :json-null)
          ;; => (("name" . :json-null))

    : true
        JSON �� true �ɑΉ����� lisp �̒l���w�肵�܂��B

        �f�t�H���g�l�� t �ł��B

          (json-load "xyzzy: true" :true :json-true)
          ;; => (("xyzzy" . :json-true))

    : false
        JSON �� false �ɑΉ����� lisp �̒l���w�肵�܂��B

        �f�t�H���g�l�� nil �ł��B

          (json-load "xyzzy: false" :false :json-false)
          ;; => (("xyzzy" . :json-false))

    : seq
        JSON �� Arrays �̃}�b�s���O���@���w�肵�܂��B

        * ������ :sexp �܂��� :array ���w�肵�܂��B
        * :sexp ���w�肵���ꍇ�̓��X�g�Ƀ}�b�s���O���܂��B
        * :array ���w�肵���ꍇ�͔z��Ƀ}�b�s���O���܂��B

        �f�t�H���g�l��:sexp �ł��B

          (json-load "[1, 2, 3]" :seq :sexp)
          ;; => (1 2 3)

          (json-load "[1, 2, 3]" :seq :array)
          ;; => #(1 2 3)

    : map
        JSON �� Objects �̃}�b�s���O���@���w�肵�܂��B

        * ������ :sexp �܂��� :hash-table ���w�肵�܂��B
        * :sexp ���w�肵���ꍇ�͊֘A���X�g�Ƀ}�b�s���O���܂��B
        * :hash-table ���w�肵���ꍇ�� hashtable �Ƀ}�b�s���O���܂��B

        �f�t�H���g�l��:sexp �ł��B

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

        ((<hash-table-test>)) ���Q�Ƃ��Ă��������B

    : hash-table-test
        hash-table �̃e�X�g�֐����w�肵�܂��B

        * ((<map>)) �� :hash-table ���w�肵���Ƃ��̂ݗL���ȃI�v�V�����ł��B
        * �w��\�Ȋ֐��� eq, eql, equal, equalp �ł��B

        �f�t�H���g�� equal �ł��B

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

    json-syck (�{���C�u�����̂���) �̃o�[�W������Ԃ��܂��B

    �o�[�W������ major.minor.teeny �Ƃ����`���ł��B
    ���ꂼ��̔ԍ��͕K�� 1 ���ɂ���̂ŁA�ȉ��̂悤�ɔ�r���邱�Ƃ��ł��܂�
    (Ruby �Ɠ����ł� :-)�B

        (if (string<= "1.1.0" (json-syck-version))
            (1.1.0 �ȍ~�ŗL���ȏ���)
          (1.1.0 ���O�̃o�[�W�����ł̏���))


== LIMITATIONS

* JSON �`���ł� dump �̓T�|�[�g���Ă��܂���B


== KNOWN BUGS

* yaml-syck �܂��� syck ���̂̃o�O�ɂ�� xyzzy ���ƃN���b�V������\��������̂�
  auto-save-buffers ���g���Ă��������B�B�B


== TODO

* sexp->json �_���v�̃T�|�[�g (emitter)
* syck.dll �ŃG���[�ɂȂ��Ă� xyzzy ���Ɨ����Ȃ��悤�ɂ���
* �o�b�t�@���� load
* �X�g���[������ load


== AUTHOR

�݂�ނ� ���䂫 (((<URL:mailto:miyamuko (at) gmail.com>)))


== SEE ALSO

  : RFC 4627 The application/json Media Type for JavaScript Object Notation (JSON)
        ((<URL:http://tools.ietf.org/html/rfc4627>))

  : JSON �̏Љ�
        ((<URL:http://www.json.org/json-ja.html>))


== COPYRIGHT

json-syck �� MIT/X ���C�Z���X�ɂ��������ė��p�\�ł��B

See json-syck/docs/MIT-LICENSE for full license.


== NEWS

<<<NEWS.rd
