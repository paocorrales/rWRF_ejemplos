library(reticulate)
wrf <- import("wrf")
ncdf <- import("netCDF4")

# La función lee un archivo wrfout, calcula  el mucape usando la librería wrf-py y guarda un nuevo archivo .nc con el campo resultante.

mucape <- function(file_in, file_out) {

  ncfile <-  ncdf$Dataset(file_in)
  cape <- wrf$g_cape$get_2dcape(ncfile)

  xarray_array_out <-  cape$copy(deep = "True")
  xarray_array_out$attrs['coordinates'] <- NULL

  xarray_array_out$attrs['projection'] = as.character(xarray_array_out$attrs['projection']$projection)

  xarray_array_out$to_netcdf(path = file_out,
                             mode = "w",
                             engine = "netcdf4")
  return(file_out)
}
