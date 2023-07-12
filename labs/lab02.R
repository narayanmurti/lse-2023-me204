#### Part 1 ####
library(tidyverse)
library(xml2)

df <- read_csv('Dec_lsoa_grocery.csv')

#### Part 2: working with XML ####

#select cols
selected_cols <- c("area_id", "fat", "saturate", "salt", "protein", "sugar", 
                   "carb", "fibre", "alcohol")
df[selected_cols]


#create root node ... xml tag on top. its the root of the tree. called 'data'.
#   tesco_data_xml <- xml_new_root("data", .encoding = "UTF-8")
#   tesco_data_xml

#the encoding is not compulsory.. see:
temp <- xml_new_root("data")
temp


#extract the first row of df
#   row1 <- df %>% slice(1)

#create a new XML node using same new_root function. this time the node has 
#an attribute, area_id, which we pull from row 1 of our data frame
#   area_node <- xml_new_root("area", area_id = row1 %>% pull(area_id))
#   area_node

#add children nodes to the area node. selected[-1] because we want to omit area_id since we
#already added it... so its index is 1 so we remove it that way.
#   for(nutrient_name in selected_cols[-1]){
 #    xml_add_child(area_node, nutrient_name, row1 %>% pull(nutrient_name))
#   }
area_node

#now to finish making this file, have to put the area node as a child of data node
#   xml_add_child(tesco_data_xml, area_node)
#   tesco_data_xml

#now save the file

#write_xml(tesco_data_xml, "sample_tesco_data.xml")




#since I want to do this a bunch of times, we need to make a function with an 
#input as row, since row is the only thing changing in the code between entries
#function:
get_area_node <- function(row){
  row <- data.frame(row) #just making sure R knows that its a dataframe!
  nutrients_node <- xml_new_root("nutrients")
  
  for(nutrient_name in selected_cols[-1]){
    xml_add_child(nutrients_node, nutrient_name, row %>% pull(nutrient_name))
  }
  area_node <- xml_new_root("area", area_id = row %>% pull(area_id))
  xml_add_child(area_node, nutrients_node)
  return(area_node)
}


#### part 3: multiple rows ####
#comment out the above code to make a fresh xml each time

tesco_data_xml <- xml_new_root("data", .encoding = "UTF-8")
for(i in 1:10){
  rown <- df %>% slice(i)
  xml_add_child(tesco_data_xml, get_area_node(rown))
}

tesco_data_xml


#write new file
write_xml(tesco_data_xml, "large_sample.xml")



#### Part 4: Heirarchal ####
#added the nutrients node to the get_area_node func and had to swtich around the 
#order of when i added it to the child of area node!! you have to work from the top of the
#tree down to the base (inside out) ... so have to do all the insides into nutrient,
#THEN at the end add that whole nutrients node to area. then the heirarchy looks clean 
#and as we want it.


