library(rentrez) # load rentrez package

ncbi_ids <- c("HQ433692.1","HQ433694.1","HQ433691.1") # make a vector of unique
# identifiers for the NCBI files we want

Bburg<-entrez_fetch(db = "nuccore", id = ncbi_ids, rettype = "fasta") # pass these
# unique identifiers to the NCBI nucleotide database (nuccore) and get the data
# files in FASTA format

str(Bburg)
print(Bburg)

# Get rid of whitespace and split the string from NCBI into a vector, each component
# containing a different sequence
Bburg2 <- gsub("\\n*","",Bburg)
Bburg2 <- strsplit(Bburg2, ">")
Bburg2 <- unlist(Bburg2)
Bburg2 <- Bburg2[grepl("\\w+", Bburg2)] # keep only non-empty vectors

# Loop through each sequence in the vector, take out the id and make it the
# sequence's name in the vector, remove all other info but the sequence
Bseqs <- c()
for (i in 1:length(Bburg2)){
  Bseqs[i] <- gsub("HQ.*sequence", "", Bburg2[i])
  names(Bseqs)[i] <- gsub(" Borrelia.*", "", Bburg2[i])
}

write.csv(Bseqs, file="Sequences.csv")
