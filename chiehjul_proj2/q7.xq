xquery version "3.1";


let $bk := doc("books_forq7.xml")

let $all_book_title := distinct-values($bk//book/title)

let $distinct_book :=
    for $book_title in $all_book_title
    let $author_list := 
        for $author in $bk//author[book[title=$book_title]]/name
        return 
            <author>
                {$author}
            </author>
    return
        <book year="{$bk//book[title=$book_title][1]/@year}">
            {$author_list}
            {$bk//book[title=$book_title][1]/title}
            {$bk//book[title=$book_title][1]/price}
        </book>

return 
    <biblio>
        {$distinct_book}
    </biblio>