xquery version "3.1";

<results>
{
    let $bk := doc("books.xml")
    let $bk_jeff := $bk//author[name = "Jeff"]/book/title

    for $bk_jeff_tit in $bk_jeff
    let $author := $bk//author[./book/title = $bk_jeff_tit]/name
    where count($author)>1
    return 
        <book>
            {$bk_jeff_tit}
            {$author}
        </book>
}
</results> 
