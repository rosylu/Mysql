xquery version "3.1";

let $bk := doc("books.xml")
(:let $all_category := $bk//category:)
let $all_book_title := distinct-values($bk//book/title)

let $distinct_book :=
    for $book_title in $all_book_title
    return
        $bk//book[title=$book_title][1]
            

let $glo_avg := avg($distinct_book/price/xs:integer(.))
let $glo_avg :=  
    <global_average>
        {$glo_avg}
    </global_average>
    
let $cat_group :=
    for $book_title in $all_book_title

    let $book := $bk//book[title=$book_title][1]
    let $cat := $book/category
    
    group by $cat
    where avg($book/price) > $glo_avg
    return 
        <category id ="{$cat}">
            <category_average> {avg($book/price)} </category_average>
            {$book[price = max($book/price)]}
        </category>
    
    
return
    <results>
        {$glo_avg}
        {$cat_group}
    </results>

