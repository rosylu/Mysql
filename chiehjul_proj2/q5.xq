xquery version "3.1";

<results>
{
    let $bk := doc("books.xml")
    let $all_author := $bk//author/name

    for $author_1 in $all_author, $author_2 in $author_1/../following-sibling::node()/name

    
    let $co_book := 
        for $a1_book in $author_1/../book/title, $a2_book in $author_2/../book/title
        where data($a1_book) = data($a2_book) 
        return $a1_book/..
    
    where data($author_1) != data($author_2) and count($co_book) >1

    return 
        <pair>
            {$author_1}
            {$author_2}
            {$co_book}

        </pair>
}
</results>
