library(pheatmap)
data(iris)

# Make a heatmap
rownames(iris) <- paste0("r", 1:nrow(iris))
p1 <- pheatmap(iris[, 1:4], annotation_row = iris[,5, drop=FALSE])

# Explicitly compute the tree and verify it's equal to the one on the plot
dmat_ref <- dist(iris[,1:4])
#tree <- hclust(dmat)
#identical(tree$height, p1$tree_row$height)


dmat <- read.table("DMat-0.99.tsv", header = FALSE, sep = "")

clades <- list("Myxococcus macrosporus strain HW-1",
                   "Myxococcus fulvus 124B02",
                   "Myxococcus xanthus DK 1622, complete sequence",
                   "Myxococcus xanthus DZ2 contig_000087",
                   "Myxococcus hansupus strain contaminant ex DSM 436 chromosome",
                   "Myxococcus stipitatus DSM 14675, complete sequence",
                   "Myxococcus_xanthus_DZF1_Myxococcus xanthus DZF1 contig_000001",
                   "Myxococcus macrosporus DSM 14697 chromosome",
                   "Myxococcus xanthus strain GH3.5.6c2 chromosome",
                   "Myxococcus xanthus strain GH5.1.9c20 chromosome",
                   "Myxococcus xanthus strain KF3.2.8c11 chromosome",
                   "Myxococcus xanthus strain KF4.3.9c1 chromosome",
                   "Myxococcus xanthus strain MC3.3.5c16 chromosome",
                   "Myxococcus xanthus strain MC3.5.9c15 chromosome",
                   "Myxococcus sp. CA006 NODE_100_length_34744_cov_19.7234_ID_7380",
                   "Myxococcus sp. CA005 NODE_100_length_30728_cov_24.3724_ID_4905",
                   "Myxococcus sp. AB025B NODE_100_length_30452_cov_29.68",
                   "Myxococcus sp. CA010 NODE_100_length_34222_cov_52.7579_ID_6370",
                   "Myxococcus sp. AB022 NODE_100_length_33074_cov_66.633_ID_5435",
                   "Myxococcus sp. AB036A NODE_100_length_33643_cov_40.8453_ID_5699",
                   "Myxococcus sp. AB056 NODE_100_length_29952_cov_53.054_ID_4823",
                   "Myxococcus sp. AM401 NODE_1000_length_389_cov_0.80916",
                   "Myxococcus virescens strain NBRC 100334 sequence001",
                   "Myxococcus fulvus strain NBRC 100333 sequence001",
                   "Myxococcus sp. CA027 NODE_102_length_43945_cov_31.8838_ID_48546",
                   "Pyxidicoccus caerfyrddinensis strain CA032A",
                   "Pyxidicoccus trucidator strain CA060A",
                   "Myxococcus sp. AB053B NODE_100_length_465_cov_15.6686",
                   "Myxococcus sp. AM301 NODE_1000_length_341_cov_13.5748",
                   "Myxococcus sp. CA023 NODE_100_length_33880_cov_58.1775",
                   "Myxococcus sp. CA018 NODE_100_length_26425_cov_5.48563",
                   "Pyxidicoccus fallax strain DSM 14698",
                   "Myxococcus xanthus strain AB023 NODE_100_length_28526_cov_52.9202",
                   "Myxococcus xanthus strain AM003 NODE_100_length_34689_cov_36.6424",
                   "Myxococcus xanthus strain CA029 NODE_100_length_34095_cov_41.7558",
                   "Myxococcus xanthus strain AM005 NODE_100_length_31581_cov_48.6092",
                   "Pyxidicoccus fallax strain CA059B",
                   "Myxococcus sp. CA033 NODE_101_length_405_cov_0.683453",
                   "Myxococcus sp. CA039A NODE_100_length_31669_cov_26.8079",
                   "Myxococcus sp. CA051A NODE_100_length_381_cov_0.598425",
                   "Myxococcus sp. CA056 NODE_10_length_345653_cov_24.4611",
                   "Myxococcus sp. CA040A NODE_10_length_366312_cov_25.8198",
                   "Myxococcus sp. AM010 NODE_100_length_28083_cov_60.3151_ID_5984",
                   "Myxococcus sp. AM011 NODE_100_length_34964_cov_38.2647",
                   "Myxococcus sp. AM009 NODE_100_length_30064_cov_74.1389",
                   "Myxococcus sp. AM001 NODE_1000_length_471_cov_2.43023",
                   "Myxococcus virescens strain DSM 2260",
                   "Myxococcus xanthus strain DSM 16526",
                   "Myxococcus fulvus strain DSM 16525")

# Plot the distance matrix with the previous tree
pheatmap(as.matrix(dmat), 
         #clustering_distance_rows = dmat,
         #clustering_distance_cols = dmat
         cluster_rows = TRUE,
         cluster_cols = TRUE, clustering_distance_rows = "euclidean",
         clustering_distance_cols = "euclidean",
         labels_row = clades,
         labels_col = clades
         )
#head(dmat)
