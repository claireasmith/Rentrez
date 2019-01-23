library(rentrez) # load rentrez into session

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") # make a vector of unique
# identifiers for the NCBI files we want

Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") # pass these
# unique identifiers to the NCBI nucleotide database (nuccore) and get the data
# files in FASTA format

# Get rid of whitespace and split the string from NCBI into a vector, each component
# containing a different sequence
test <- gsub("\\n*","",Bburg)
test <- strsplit(test, ">")
test <- unlist(test)
test <- test[grepl("\\w+", test)] # keep only non-empty vectors

# Loop through each sequence in the vector, take out the id and make it the
# sequence's name in the vector, remove all other info but the sequence
bseqs <- c()
for (i in 1:length(test)){
  bseqs[i] <- gsub("HQ.*sequence", "", test[i])
  names(bseqs)[i] <- gsub(" Borrelia.*", "", test[i])
}

write.csv(bseqs, file="Sequences.csv")
