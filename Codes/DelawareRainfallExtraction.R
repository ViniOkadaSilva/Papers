delaware_rainfall <- 
  function(shapefile, rainfall, id, initial_year = 1900, final_year=2017, 
           level="month", var = "mean", point = "yes")
{
  require(terra)
  require(raster)
  require(sf)
  require(exactextractr)
  library(dplyr)
  library(tidyr)
  require(svMisc)
    
  shapefile <- st_transform(shapefile, crs = st_crs(rainfall))
  raster_beg <- (initial_year - 1900)*12 + 1
  raster_end <- (final_year - 1900)*12 + 12
  
  placeholder <- st_drop_geometry(shapefile[id])
  
  j = -1
  
  if (point == "yes")
  {
    for (i in seq(raster_beg,raster_end,1))
    {
      if(i %% 12 == 1)
      {
        j = j + 1
        placeholder <- cbind(placeholder, terra::extract(raster::rotate(rainfall[[i]]), shapefile, method = 'simple'))
        colnames(placeholder)[i - raster_beg + (length(id)+1)] <- paste0(i %% 12, "_", initial_year + j)
      }
      
      else
      {
        placeholder <- cbind(placeholder, terra::extract(raster::rotate(rainfall[[i]]), shapefile, method = 'simple'))
        colnames(placeholder)[i - raster_beg + (length(id)+1)] <- paste0(i %% 12, "_", initial_year + j)
      }
      progress(i)  
    }
  }
  
  else
  {
  for (i in seq(raster_beg,raster_end,1))
  {
    if(i %% 12 == 1)
  {
    j = j + 1
    placeholder <- cbind(placeholder, exact_extract(raster::rotate(rainfall[[i]]), shapefile, 'mean', progress = FALSE))
    colnames(placeholder)[i - raster_beg + (length(id)+1)] <- paste0(i %% 12, "_", initial_year + j)
  }
  
    else
  {
    placeholder <- cbind(placeholder, exact_extract(raster::rotate(rainfall[[i]]), shapefile, 'mean', progress = FALSE))
    colnames(placeholder)[i - raster_beg + (length(id)+1)] <- paste0(i %% 12, "_", initial_year + j)
  }
  progress(i)  
  }
  }
  
  clean <- placeholder %>% gather(key,value, -c(1:length(id))) %>% separate(key, into = c("month","year"), sep = "_")
  clean$month <- as.numeric(clean$month)
  clean$year <- as.numeric(clean$year)
  clean$month <- ifelse(clean$month == 0, 12, clean$month)
  
  if(level == 'year')
  {
    clean <- clean %>% group_by_at(vars(one_of(c(id, "year")))) %>% dplyr::summarise(total_rain = sum(value))
  }
  
  return(clean)
}