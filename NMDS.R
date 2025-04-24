library(vegan)
library(ggplot2)
library(ggforce)

data <- read.csv("Braid_burn_biota.csv", header = TRUE)

Invert <- data[, -1] 
Invert[is.na(Invert)] <- 0  


nmds_result <- metaMDS(Invert, distance = "bray", k = 2, trymax = 100)

site_scores <- as.data.frame(scores(nmds_result, display = "sites"))

site_scores$Location <- data$Location

nmds_result$stress

# stress plot to assess NMDS fit
stressplot(nmds_result)

# NMDS Plot with ggplot2
ggplot(site_scores, aes(x = NMDS1, y = NMDS2, color = Location)) +
  geom_point(size = 4, alpha = 0.8) +  # Larger points with transparency
  geom_mark_ellipse(aes(fill = Location), alpha = 0.2, color = NA) +  # Ellipses for groups
  scale_color_manual(values = c("Inside" = "darkblue", "Outside" = "darkred")) +  # Custom colors
  scale_fill_manual(values = c("Inside" = "lightblue", "Outside" = "pink")) +
  labs(x = "NMDS1", y = "NMDS2") +
  theme_minimal(base_size = 14) +
  theme(legend.position = "right", plot.title = element_text(hjust = 0.5, face = "bold"))