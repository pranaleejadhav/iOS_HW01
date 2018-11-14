# iOS_HW01
iOS Table View Sections - Expand &amp; Collapse


Part 1 : Apps View Controller The  interface  should  be  created  to  match  the  UI  presented  in  Figure  1(b).  The requirements are as follows: 

1.You  should  use  connect  to  the  provided  api  to  retrieve  the  JSON  information provided. The api url is http://dev.theappsdr.com/apis/apps.json

2.All communication with the API should be performed asynchronously and should use a child thread. 

3.The list should display a section for each category, and under each category should display  the  items  retrieved  for  this  category.  The  title  of  each  section  should  match the title of the category. 

4.There are three different cell types based on the following requirements: 
  a.If for an item the “otherImage” and “summary” are null then display the simple row shown in Figure 1(a). 
  b.If  for  an  item  the  “otherImage”  is  not  null  and  the  “summary”  is  null  then  display the large image based row shown in Figure 1(b). 
  c.If  for  an  item  the  “otherImage”  is  null  and  the  “summary”  is  not  null  then  display the summary based based row shown in Figure 1(b). 

5.All  image  loading  should  be  performed  using  the  SDWebImage  library. You  can  use AlamoFire for making the HTTP connections.
