xquery version "3.1";

<results>
{
    let $bk := doc("books.xml")

    for $b in $bk//book
    order by $b/price/xs:integer(.)
    return $b
}
</results>