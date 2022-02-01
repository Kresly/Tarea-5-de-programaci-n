library(climatol)

##1.Generar un diagrama de Walter y Lieth con la data de datcli, este debe llevar de título “Estación Campo de Marte”, a una altitud de 80 msnm durante el año 2017, con los meses simbolizados por números. Las temperaturas deberán visualizarse de color verde; las precipitaciones, en naranja; los meses de congelación segura, en azul y los de congelación probable, en celeste. No trazar una línea suplementaria de precipitación.

#Primero llamamos a la data

data(datcli)

setwd("C:/Users/IMPERIO/Music/Documents/climatol") # Generamos un directorio

#Usando la función diagwl, se plotea el diagrama

diagwl(datcli,"Estación Campo de Marte",80, "Año 2017", mlab="1", pcol="orange",tcol="green",sfcol="blue",pfcol="light blue",shem=FALSE, p3line= FALSE)

##2.Recrea minuciosamente el siguiente diagrama de la rosa de los vientos (pista: col=rainbow(8)).

#Llamamos a la data
data(windfr)

#Ploteamos

rosavent(windfr,fnum=6,fint=2, flab=1 , ang= (3*pi)/8, col=rainbow(8),uni="km/s")

##3.Convertir la data diaria de tmax en una data de medias mensuales. Posteriormente, homogeneizar dichos datos mensuales con una normalización por estandarización y gráficos de medias anuales y correcciones aplicadas en el análisis exploratorio de datos (utilizar dos decimales).

#Llamamos a la data

data(tmax)

write.table(dat, "Tmax_2001-2003.dat", row.names=FALSE, col.names=FALSE)
write.table(est.c, "Tmax_2001-2003.est", row.names=FALSE, col.names=FALSE)

#Covertimos a una data de medias mensuales

dd2m('Tmax', 2001, 2003, ndec=2 , valm=2)

Tmax_m <- read.table('Tmax-m_2001-2003.dat', header = FALSE)

homogen('Tmax', 2001, 2003, suf='m', nm=12, std=3, ndec=2, gp=3, expl=TRUE)


## 4. Recortar la data mensual de Ptest desde 1965 hasta 2005. Homogeneizar dicha data mediante clústers o áreas rectangulares, con un ancho de superposición de 0, mediante una estandarización y con gráficos de totales anuales en el análisis exploratorio de datos. Mostrar las medias de las series homogeneizadas en un archivo Excel que, además, mencione los totales anuales y los datos de la latitud, longitud y nombre de cada estación (utilizar dos decimales).

#Llamamos a la data

data(Ptest)

write.table(dat, 'Ptest_1951-2010.dat', row.names = F,col.names = F)
write.table(est.c , 'Ptest_1951-2010.est',row.names = F, col.names = F)

#Recortamos el database (.dat)

datsubset('Ptest', 1951, 2010, 1965, 2005, 1)

# Homogenizamos

homogsplit('Ptest', 1965, 2005, 2, 39,0, 0, std = 3, nm = 12,ndec = 2, gp = 4,expl = TRUE)

# Mostrando las series de las medias homogenizadas
dahstat('Ptest', 1965, 2005, stat="me", ndc=3, vala=1, estcol=c(1,2,5))


## 5. Con la data homogenizada del ejercicio anterior (si no se ha realizado, iniciar homogeneizando tal cual
#se menciona en el ejercicio 4) plotear un gráfico de calor con las medias de precipitación mensual de
#acuerdo con la latitud y longitud, este debe abarcar desde el punto 2.1°E 39.1°N hasta el punto 3.5°E
#40°N, con una separación de 0.001 entre líneas. Además, debe tener un título principal y etiquetado en
#ambos ejes. Adicionalmente, plotear un mapa de la zona del mundo en cuestión encima de dicho gráfico
#(use col=rainbow(100)).

#Primero con el database homogenizado creamos un archivo grillado y usaresmos dahgrid’:

# install.packages("sp", dependencies = T)
library(sp)
grilla<-expand.grid(x=seq(2.1,3.5,0.001),y=seq(39.1,40,0.001))
coordinates(grilla)<-~ x+y
dahgrid('Ptest', 1965, 2005, grid=grilla)

# Mi versión de R es muy antiguo y me sale error ( Warning message:
#package ‘sp’ was built under R version 4.1.2) 
# cuando corro library (sp)
