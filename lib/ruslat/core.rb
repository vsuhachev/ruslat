# coding: utf-8

module Ruslat
  # (c) 2008 Andrey V. Lukyanov (e-mail: land@long.yar.ru)
  # License: I grant anyone the right to use this program
  # for any purpose, without any conditions.
  #
  # см. http://tapemark.narod.ru/ruslat.html
  #
  # Обозначения:
  # * RUSLAT - #rus_to_lat
  # * LATRUS - #lat_to_rus
  # * CASECORRECT - #case_correct
  # * LCORRECT - #typo_correct
  #
  # RUSLAT перекодирует кириллицу в латиницу.
  #
  # LATRUS перекодирует латиницу в кириллицу.
  #
  # Круговое преобразование RUSLAT+LATRUS восстанавливает исходный русский
  # текст, причём в любом случае полностью восстанавливается также
  # распределение заглавных и строчных букв.
  #
  # Однако преобразование LATRUS+RUSLAT не обязательно восстанавливает исходный
  # текст в латинице.
  #
  # Скрипт RUSLAT не рассчитан на обработку текста, в котором перепутаны
  # русские и латинские буквы (например: а/a, с/c, р/p, у/y и т. п.); в этом
  # случае надо предварительно пропустить текст через скрипт LCORRECT.
  #
  # CASECORRECT исправляет в латинице регистр букв в словах, которые целиком
  # должны быть написаны заглавными буквами (например, АЛЁША → ALYoShA →
  # ALYOSHA). Обычно применяется преобразование RUSLAT+CASECORRECT. Следует
  # учитывать, что изменяется регистр не только в том тексте, который
  # изначально был написан русскими буквами, но и там, где изначально была
  # латиница, поэтому CASECORRECT не следует применять к текстам программ.
  # Кроме того, при круговом преобразовании RUSLAT+CASECORRECT+LATRUS исходный
  # русский текст не полностью восстанавливается (состав букв будет полностью
  # совпадать, но регистр букв может поменяться). CASECORRECT рассчитан на GNU
  # sed, в других вариантах sed он может не работать.
  #
  # Если в вашей системе используется кодировка, в которой нет значка номера
  # (например, КОИ-8), то надо закомментировать или удалить последнюю строку в
  # RUSLAT и первую строку замены в LATRUS (т. е. те строки, где есть №/Nh).
  module Core
    # Russian to Latin converter
    def rus_to_lat(string)
      string.dup.tap do |str|
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьй([аоуАОУ])/, '\1jy\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ьй([аоуАОУ])/, '\1Jy\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЙ([аоуАОУ])/, '\1jY\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЙ([аоуАОУ])/, '\1JY\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьйе/, '\1jye')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЙе/, '\1jYe')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьйЕ/, '\1jyE')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЙЕ/, '\1jYE')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ьйе/, '\1Jye')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЙе/, '\1JYe')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬйЕ/, '\1JyE')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЙЕ/, '\1JYE')

        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])й([аоуАОУ])/, '\1y\2')
        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])й([аоуАОУ])/, '\1y\2')
        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])Й([аоуАОУ])/, '\1Y\2')
        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])Й([аоуАОУ])/, '\1Y\2')

        str.gsub!(/([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])й([аоуАОУ])/, '\1y\2')
        str.gsub!(/([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])Й([аоуАОУ])/, '\1Y\2')
        str.gsub!(/^й([аоуАОУ])/, 'y\1')
        str.gsub!(/^Й([аоуАОУ])/, 'Y\1')

        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])йе/, '\1ye')
        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])Йе/, '\1Ye')
        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])йЕ/, '\1yE')
        str.gsub!(/([аеёийоуъыьэюяАЕЁИЙОУЪЫЬЭЮЯEe])ЙЕ/, '\1YE')

        str.gsub!(/([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])йе/, '\1ye')
        str.gsub!(/([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])Йе/, '\1Ye')
        str.gsub!(/([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])йЕ/, '\1yE')
        str.gsub!(/([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])ЙЕ/, '\1YE')
        str.gsub!(/^йе/, 'ye')
        str.gsub!(/^Йе/, 'Ye')
        str.gsub!(/^йЕ/, 'yE')
        str.gsub!(/^ЙЕ/, 'YE')

        str.gsub!(/йэ/, 'йeh')
        str.gsub!(/Йэ/, 'Йeh')
        str.gsub!(/йЭ/, 'йEh')
        str.gsub!(/ЙЭ/, 'ЙEH')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])й/, '\1ih')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Й/, '\1Ih')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ье/, '\1je')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ье/, '\1Je')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЕ/, '\1jE')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЕ/, '\1JE')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьё/, '\1jo')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ьё/, '\1Jo')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЁ/, '\1jO')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЁ/, '\1JO')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ью/, '\1ju')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ью/, '\1Ju')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЮ/, '\1jU')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЮ/, '\1JU')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ья/, '\1ja')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ья/, '\1Ja')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ьЯ/, '\1jA')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ЬЯ/, '\1JA')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ь([бвгджзийклмнпрстфхцчшщБВГДЖЗИЙКЛМНПРСТФХЦЧШЩ])/, '\1j\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ь([бвгджзийклмнпрстфхцчшщБВГДЖЗИЙКЛМНПРСТФХЦЧШЩ])/, '\1J\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ь$/, '\1j')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ь$/, '\1J')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ь([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])/, '\1j\2')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ь([^абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯeEyY])/, '\1J\2')
        str.gsub!(/ь/, 'jh')
        str.gsub!(/Ь/, 'Jh')

        str.gsub!(/й/, 'j')
        str.gsub!(/Й/, 'J')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])е/, '\1e')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Е/, '\1E')
        str.gsub!(/е/, 'je')
        str.gsub!(/Е/, 'Je')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ё/, '\1yo')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ё/, '\1Yo')
        str.gsub!(/ё/, 'jo')
        str.gsub!(/Ё/, 'Jo')

        str.gsub!(/ы([аоуэАОУЭ])/, 'yh\1')
        str.gsub!(/Ы([аоуэАОУЭ])/, 'Yh\1')
        str.gsub!(/ы/, 'y')
        str.gsub!(/Ы/, 'Y')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])э/, '\1eh')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Э/, '\1Eh')
        str.gsub!(/э/, 'e')
        str.gsub!(/Э/, 'E')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])ю/, '\1yu')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Ю/, '\1Yu')
        str.gsub!(/ю/, 'ju')
        str.gsub!(/Ю/, 'Ju')

        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])я/, '\1ya')
        str.gsub!(/([бвгджзклмнпрстфхцчшщБВГДЖЗКЛМНПРСТФХЦЧШЩ])Я/, '\1Ya')
        str.gsub!(/я/, 'ja')
        str.gsub!(/Я/, 'Ja')

        str.gsub!(/ж/, 'zh')
        str.gsub!(/ч/, 'ch')
        str.gsub!(/ш/, 'sh')
        str.gsub!(/щ/, 'xh')
        str.gsub!(/Ж/, 'Zh')
        str.gsub!(/Ч/, 'Ch')
        str.gsub!(/Ш/, 'Sh')
        str.gsub!(/Щ/, 'Xh')

        str.tr!('абвгдзиклмнопрстуфхцъАБВГДЗИКЛМНОПРСТУФХЦЪ', 'abvgdziklmnoprstufxcqABVGDZIKLMNOPRSTUFXCQ')

        str.gsub!(/№/, 'Nh')
      end
    end

    # Latin to Russian converter
    def lat_to_rus(string)
      string.dup.tap do |str|
        str.gsub!(/[nN][hH]/, '№')
        str.gsub!(/e[hH]/, 'э')
        str.gsub!(/E[hH]/, 'Э')
        str.gsub!(/i[hH]/, 'й')
        str.gsub!(/I[hH]/, 'Й')
        str.gsub!(/j[hH]/, 'ь')
        str.gsub!(/J[hH]/, 'Ь')
        str.gsub!(/y[hH]/, 'ы')
        str.gsub!(/Y[hH]/, 'Ы')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])ja/, '\1ья')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])jA/, '\1ьЯ')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Ja/, '\1Ья')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])JA/, '\1ЬЯ')
        str.gsub!(/j[aA]/, 'я')
        str.gsub!(/J[aA]/, 'Я')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])je/, '\1ье')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])jE/, '\1ьЕ')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Je/, '\1Ье')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])JE/, '\1ЬЕ')
        str.gsub!(/j[eE]/, 'е')
        str.gsub!(/J[eE]/, 'Е')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])ji/, '\1ьи')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])jI/, '\1ьИ')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Ji/, '\1Ьи')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])JI/, '\1ЬИ')
        str.gsub!(/ji/, 'йи')
        str.gsub!(/jI/, 'йИ')
        str.gsub!(/Ji/, 'Йи')
        str.gsub!(/JI/, 'ЙИ')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])jo/, '\1ьё')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])jO/, '\1ьЁ')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Jo/, '\1Ьё')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])JO/, '\1ЬЁ')
        str.gsub!(/j[oO]/, 'ё')
        str.gsub!(/J[oO]/, 'Ё')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])ju/, '\1ью')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])jU/, '\1ьЮ')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Ju/, '\1Ью')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])JU/, '\1ЬЮ')
        str.gsub!(/j[uU]/, 'ю')
        str.gsub!(/J[uU]/, 'Ю')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])y[aA]/, '\1я')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Y[aA]/, '\1Я')
        str.gsub!(/ya/, 'йа')
        str.gsub!(/yA/, 'йА')
        str.gsub!(/Ya/, 'Йа')
        str.gsub!(/YA/, 'ЙА')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])y[eE]/, '\1е')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Y[eE]/, '\1Е')
        str.gsub!(/ye/, 'йе')
        str.gsub!(/yE/, 'йЕ')
        str.gsub!(/Ye/, 'Йе')
        str.gsub!(/YE/, 'ЙЕ')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])y[oO]/, '\1ё')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Y[oO]/, '\1Ё')
        str.gsub!(/yo/, 'йо')
        str.gsub!(/yO/, 'йО')
        str.gsub!(/Yo/, 'Йо')
        str.gsub!(/YO/, 'ЙО')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])y[uU]/, '\1ю')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])Y[uU]/, '\1Ю')
        str.gsub!(/yu/, 'йу')
        str.gsub!(/yU/, 'йУ')
        str.gsub!(/Yu/, 'Йу')
        str.gsub!(/YU/, 'ЙУ')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])e/, '\1е')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])E/, '\1Е')
        str.gsub!(/e/, 'э')
        str.gsub!(/E/, 'Э')

        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])j/, '\1ь')
        str.gsub!(/([bcdfghklmnprstvwxzBCDFGHKLMNPRSTVWXZ])J/, '\1Ь')
        str.gsub!(/j/, 'й')
        str.gsub!(/J/, 'Й')

        str.gsub!(/c[hH]/, 'ч')
        str.gsub!(/s[hH]/, 'ш')
        str.gsub!(/x[hH]/, 'щ')
        str.gsub!(/z[hH]/, 'ж')

        str.gsub!(/C[hH]/, 'Ч')
        str.gsub!(/S[hH]/, 'Ш')
        str.gsub!(/X[hH]/, 'Щ')
        str.gsub!(/Z[hH]/, 'Ж')

        str.tr!('abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', 'абцдэфгхийклмнопърстуввхызАБЦДЭФГХИЙКЛМНОПЪРСТУВВХЫЗ')
      end
    end

    # Case correct, example: АЛЁША (rus_to_lat)→ ALYoShA (case_correct)→ ALYOSHA
    def case_correct(string)
      string.dup.tap do |str|
        str.gsub!(/([A-Z])h([A-Z])/) { |s| s.upcase }
        str.gsub!(/J([aeou])([A-Z])/) { |s| s.upcase }

        str.gsub!(/([A-Z])([A-Z])h/) { |s| s.upcase }
        str.gsub!(/([A-Z])J([aeou])/) { |s| s.upcase }
        str.gsub!(/([BCDFGHKLMNPRSTVWXZ])Y([aeou])/) { |s| s.upcase }

        str.gsub!(/([A-Z])h\s+([A-Z][A-Z])/) { |s| s.upcase }
        str.gsub!(/J([aeou])\s+([A-Z][A-Z])/) { |s| s.upcase }
        str.gsub!(/([BCDFGHKLMNPRSTVWXZ])Y([aeou])\s+([A-Z][A-Z])/) { |s| s.upcase }
      end
    end

    # Typo correct replaces 'cyrillic-look-like' latin symbols to cyrillic ones
    def typo_correct(string)
      string.tr('acekopuxyABCEHKMOPTXY', 'асекорихуАВСЕНКМОРТХУ')
    end
  end
end
