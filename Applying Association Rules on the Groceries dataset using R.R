#Applying association rules on the Groceries dataset
#there are many algorithms that 
#apply Mining Association Rules and Frequent Itemsets Apriori,Fpgrowth ,eclat
#we will use Apriori


#arules base package with data structures, mining algorithms (APRIORI)
#install.packages("arules")  
#install.packages("arulesViz") # for visualization
#install.packages("ggplot2")
library(arulesViz)


#call to read data Groceries
library(arules)

data("Groceries")

#assign data
trans <- transactions(Groceries)  # m <- Groceries


trans  # run to see info about data 
trans@itemInfo       # info about items
trans@itemsetInfo    # the transaction data     first it will be 0 "no itemset created yet"


inspect(head(trans,5)) # the first 5 transactions
image(head(trans,40))  # how item appear in transactions (just 40 transaction)


help("apriori")   # run to see its description

ar <- apriori(trans,parameter =list(support=0.01,confidence=.5,minlen=1,maxlen=10,target="rules"))

ar@quality  # the info (support,confidence,lift) of the frequenct itemsets
ar@quality$confidence>.52  # the True or false of itemsets of its confidence >.52

bestitemsets <- ar[quality(ar)$confidence>.52]  # the number of true itemsets 
inspect(bestitemsets) # the itemsets where its confidence >.52 

bestitemsets_SortedbyLift <- sort(bestitemsets,by="lift")
inspect(bestitemsets_SortedbyLift)

ar@info #the info of algorthm parameters selected  

# this mean that if the customer buy citrus fruit and root vegetables  then its confidence by  0.5862069 to buy also other vegetables


plot(bestitemsets_SortedbyLift, method="graph")
