# frozen_string_literal: true

# RubyModuleの作成
array_module = RubyModule.find_or_create_by!(name: 'Array')
hash_module = RubyModule.find_or_create_by!(name: 'Hash')
string_module = RubyModule.find_or_create_by!(name: 'String')
enumerable_module = RubyModule.find_or_create_by!(name: 'Enumerable')
numeric_module = RubyModule.find_or_create_by!(name: 'Numeric')
file_module = RubyModule.find_or_create_by!(name: 'File')
dir_module = RubyModule.find_or_create_by!(name: 'Dir')
time_module = RubyModule.find_or_create_by!(name: 'Time')
date_module = RubyModule.find_or_create_by!(name: 'Date')

# RubyMethodの作成

# Arrayメソッド
[
  {
    name: 'map',
    description: '配列の各要素に対してブロックを評価し、その結果を含む新しい配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/map.html',
    class_name: 'Array'
  },
  {
    name: 'select',
    description: '配列の各要素に対してブロックを評価し、その結果が真である要素のみを含む新しい配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/select.html',
    class_name: 'Array'
  },
  {
    name: 'reject',
    description: '配列の各要素に対してブロックを評価し、その値が偽りであった要素を集めた新しい配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/reject.html',
    class_name: 'Array'
  },
  {
    name: 'each',
    description: '配列の各要素に対してブロックを評価します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/each.html',
    class_name: 'Array'
  },
  {
    name: 'compact',
    description: '自身からnilを取り除いた配列を生成して返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/compact.html',
    class_name: 'Array'
  },
  {
    name: 'flatten',
    description: '多次元配列を平坦化した新しい配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/flatten.html',
    class_name: 'Array'
  },
  {
    name: 'uniq',
    description: '配列から重複した要素を取り除いた新しい配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/uniq.html',
    class_name: 'Array'
  },
  {
    name: 'sort',
    description: '配列の内容をソートします。要素同士の比較は<=>演算子を使って行います。sortはソートされた配列を生成して返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/sort.html',
    class_name: 'Array'
  },
  {
    name: 'reverse',
    description: '自身の要素を逆順に並べた新しい配列を生成して返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/reverse.html',
    class_name: 'Array'
  },
  {
    name: 'include?',
    description: '配列がvalと==で等しい要素を持つ時に真を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/include=3f.html',
    class_name: 'Array'
  },
  {
    name: 'join',
    description: '配列の要素を文字列に変換し、引数で指定された区切り文字で連結した文字列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/join.html',
    class_name: 'Array'
  },
  {
    name: 'push',
    description: '配列の末尾に要素を追加します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Array/i/push.html',
    class_name: 'Array'
  }
].each do |method_data|
  array_module.ruby_methods.create!(method_data)
end

# Hashメソッド
[
  {
    name: 'merge',
    description: 'ハッシュをotherと統合した結果を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/merge.html',
    class_name: 'Hash'
  },
  {
    name: 'keys',
    description: 'ハッシュの全てのキーを含む配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/keys.html',
    class_name: 'Hash'
  },
  {
    name: 'values',
    description: 'ハッシュの全ての値を含む配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/values.html',
    class_name: 'Hash'
  },
  {
    name: 'has_key?',
    description: 'ハッシュがkeyをキーとして持つ時真を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/has_key=3f.html',
    class_name: 'Hash'
  },
  {
    name: 'delete',
    description: 'keyに対応する要素を取り除きます。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/delete.html',
    class_name: 'Hash'
  },
  {
    name: 'each',
    description: 'ハッシュのキーと値を引数としてブロックを評価します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/each.html',
    class_name: 'Hash'
  },
  {
    name: 'invert',
    description: '値からキーへのハッシュを作成して返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/invert.html',
    class_name: 'Hash'
  },
  {
    name: 'select',
    description: 'key, valueのペアについてブロックを評価し，真となるペアだけを含むハッシュを生成して返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/select.html',
    class_name: 'Hash'
  },
  {
    name: 'fetch',
    description: 'keyに関連づけられた値を返します。キーが見つからない場合は、引数defaultが与えられていればその値を、ブロックが与えられていればそのブロックを評価した値を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/fetch.html',
    class_name: 'Hash'
  },
  {
    name: 'transform_values',
    description: 'ハッシュの各値に対してブロックを評価し、その結果を値とする新しいハッシュを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Hash/i/transform_values.html',
    class_name: 'Hash'
  }
].each do |method_data|
  hash_module.ruby_methods.create!(method_data)
end

# Stringメソッド
[
  {
    name: 'split',
    description: '文字列をpatternで分割し、結果を文字列の配列で返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/split.html',
    class_name: 'String'
  },
  {
    name: 'gsub',
    description: '文字列中のpatternにマッチする部分全てを、replacementで置き換えた文字列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/gsub.html',
    class_name: 'String'
  },
  {
    name: 'chomp',
    description: 'selfの末尾からrsで指定する改行コードを取り除いた文字列を生成して返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/chomp.html',
    class_name: 'String'
  },
  {
    name: 'strip',
    description: '文字列の先頭と末尾の空白文字を全て取り除いた新しい文字列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/strip.html',
    class_name: 'String'
  },
  {
    name: 'upcase',
    description: '文字列の内容を全て大文字に変換した新しい文字列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/upcase.html',
    class_name: 'String'
  },
  {
    name: 'downcase',
    description: '文字列の内容を全て小文字に変換した新しい文字列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/downcase.html',
    class_name: 'String'
  },
  {
    name: 'include?',
    description: '文字列がotherを含む場合にtrueを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/include=3f.html',
    class_name: 'String'
  },
  {
    name: 'start_with?',
    description: 'selfの先頭がprefixesのいずれかであるときtrueを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/start_with=3f.html',
    class_name: 'String'
  },
  {
    name: 'end_with?',
    description: 'selfの末尾がstrsのいずれかであるときtrueを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/String/i/end_with=3f.html',
    class_name: 'String'
  }
].each do |method_data|
  string_module.ruby_methods.create!(method_data)
end

# Enumerableメソッド
[
  {
    name: 'any?',
    description: 'ブロックを評価して真になる要素があれば真を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/any=3f.html',
    class_name: 'Enumerable'
  },
  {
    name: 'all?',
    description: '全ての要素に対してブロックを評価した結果が全て真である場合に真を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/all=3f.html',
    class_name: 'Enumerable'
  },
  {
    name: 'none?',
    description: 'ブロックを指定しない場合は、Enumerableオブジェクトのすべての要素が偽であれば真を返します。そうでなければ偽を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/none=3f.html',
    class_name: 'Enumerable'
  },
  {
    name: 'count',
    description: 'レシーバの要素数を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/count.html',
    class_name: 'Enumerable'
  },
  {
    name: 'find',
    description: '要素に対してブロックを評価した値が真になった最初の要素を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/find.html',
    class_name: 'Enumerable'
  },
  {
    name: 'inject',
    description: 'リストのたたみこみ演算を行います。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/inject.html',
    class_name: 'Enumerable'
  },
  {
    name: 'map',
    description: '各要素に対してブロックを評価した結果を含む配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/map.html',
    class_name: 'Enumerable'
  },
  {
    name: 'select',
    description: 'ブロックを評価して真となる要素を全て含む配列を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/select.html',
    class_name: 'Enumerable'
  },
  {
    name: 'reduce',
    description: '畳み込み演算を行います。初期値と各要素を順番にブロックに渡し、ブロックの戻り値を次の計算の初期値として渡します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/reduce.html',
    class_name: 'Enumerable'
  },
  {
    name: 'each_with_index',
    description: '各要素とそのインデックスをブロックに渡して評価します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/each_with_index.html',
    class_name: 'Enumerable'
  },
  {
    name: 'group_by',
    description: 'ブロックの評価結果をキー、対応する要素の配列を値とするハッシュを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Enumerable/i/group_by.html',
    class_name: 'Enumerable'
  }
].each do |method_data|
  enumerable_module.ruby_methods.create!(method_data)
end

# Numericメソッド
[
  {
    name: 'to_s',
    description: '数値を文字列に変換します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Numeric/i/to_s.html',
    class_name: 'Numeric'
  },
  {
    name: 'to_i',
    description: '数値を整数に変換します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Numeric/i/to_i.html',
    class_name: 'Numeric'
  },
  {
    name: 'to_f',
    description: '数値を浮動小数点数に変換します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Numeric/i/to_f.html',
    class_name: 'Numeric'
  },
  {
    name: 'abs',
    description: '数値の絶対値を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Numeric/i/abs.html',
    class_name: 'Numeric'
  },
  {
    name: 'round',
    description: '四捨五入した結果を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Numeric/i/round.html',
    class_name: 'Numeric'
  }
].each do |method_data|
  numeric_module.ruby_methods.create!(method_data)
end

# Fileメソッド
[
  {
    name: 'open',
    description: 'ファイルをオープンします。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/File/s/open.html',
    class_name: 'File'
  },
  {
    name: 'read',
    description: 'ファイルの内容を読み込みます。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/File/s/read.html',
    class_name: 'File'
  },
  {
    name: 'write',
    description: 'ファイルに書き込みます。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/IO/i/write.html',
    class_name: 'File'
  },
  {
    name: 'exist?',
    description: 'ファイルが存在する場合にtrueを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/FileTest/m/exist=3f.html',
    class_name: 'File'
  },
  {
    name: 'dirname',
    description: 'ファイルパスのディレクトリ部分を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/File/s/dirname.html',
    class_name: 'File'
  },
  {
    name: 'basename',
    description: 'ファイルパスのファイル名部分を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/File/s/basename.html',
    class_name: 'File'
  }
].each do |method_data|
  file_module.ruby_methods.create!(method_data)
end

# Dirメソッド
[
  {
    name: 'glob',
    description: 'パターンにマッチするファイル名を配列として返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Dir/s/glob.html',
    class_name: 'Dir'
  },
  {
    name: 'chdir',
    description: 'カレントディレクトリを変更します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Dir/s/chdir.html',
    class_name: 'Dir'
  },
  {
    name: 'pwd',
    description: 'カレントディレクトリのフルパスを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Dir/s/pwd.html',
    class_name: 'Dir'
  },
  {
    name: 'mkdir',
    description: 'ディレクトリを作成します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Dir/s/mkdir.html',
    class_name: 'Dir'
  }
].each do |method_data|
  dir_module.ruby_methods.create!(method_data)
end

# Timeメソッド
[
  {
    name: 'now',
    description: '現在時刻を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Time/s/now.html',
    class_name: 'Time'
  },
  {
    name: 'strftime',
    description: '時刻を指定されたフォーマットの文字列に変換します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Time/i/strftime.html',
    class_name: 'Time'
  },
  {
    name: 'to_i',
    description: ' 1970-01-01 00:00:00 UTCからの経過秒数を整数で返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Time/i/to_i.html',
    class_name: 'Time'
  },
  {
    name: 'year',
    description: '年を整数で返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Time/i/year.html',
    class_name: 'Time'
  },
  {
    name: 'month',
    description: '月を1から12の整数で返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Time/i/month.html',
    class_name: 'Time'
  }
].each do |method_data|
  time_module.ruby_methods.create!(method_data)
end

# Dateメソッド
[
  {
    name: 'today',
    description: '現在の日付を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Date/s/today.html',
    class_name: 'Date'
  },
  {
    name: 'parse',
    description: '日付文字列をパースしてDateオブジェクトを返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Date/s/parse.html',
    class_name: 'Date'
  },
  {
    name: 'strftime',
    description: '日付を指定されたフォーマットの文字列に変換します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Date/i/strftime.html',
    class_name: 'Date'
  },
  {
    name: 'next',
    description: '翌日の日付を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Date/i/next.html',
    class_name: 'Date'
  },
  {
    name: 'prev',
    description: '前日の日付を返します。',
    official_url: 'https://docs.ruby-lang.org/ja/latest/method/Date/i/prev.html',
    class_name: 'Date'
  }
].each do |method_data|
  date_module.ruby_methods.create!(method_data)
end
