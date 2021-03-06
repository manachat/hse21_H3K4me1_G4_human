# hse21_H3K4me1_G4_human

Тип клеток: HCT116  
Гистоновая метка ENCFF699ABD https://www.encodeproject.org/files/ENCFF699ABD/  
Гистоновая метка ENCFF931YSQ https://www.encodeproject.org/files/ENCFF931YSQ/  

### Обрезаем первые 5 столбцов в исходных файлах:  
```
zcat ENCFF699ABD.bed.gz  |  cut -f1-5 > H3K4me1_HCT116_ENCFF699ABD_hg38.bed  
```

### Конвертируем из hg38 в hg19 с помощью liftOver, в файле prefix.txt описываем префиксы меток:  
```
cat ../prefix.txt | xargs -tI{} liftOver {}_hg38.bed hg38ToHg19.over.chain.gz {}_hg19.bed {}_unmapped_hg19.bed  
```

### Строим гистограммы распределения длин пик (length_hist.R)  
![alt text](pictures/len_hist_H3K4me1_HCT116_ENCFF699ABD_hg38.bed.png)
![alt text](pictures/len_hist_H3K4me1_HCT116_ENCFF699ABD_hg19.bed.png)
![alt text](pictures/len_hist_H3K4me1_HCT116_ENCFF931YSQ_hg38.bed.png)
![alt text](pictures/len_hist_H3K4me1_HCT116_ENCFF931YSQ_hg19.bed.png)  

### В полученных файлах отрезаем все пики длиннее 5000 оснований (filter.sh)  
![alt text](pictures/len_hist_H3K4me1_HCT116_ENCFF699ABD_hg19_filtered.png)  
![alt text](pictures/len_hist_H3K4me1_HCT116_ENCFF931YSQ_hg19_filtered.png)  
### Строим pie-чарты фильтрованных наборов с помощью ChIPseeker (chip_seeker.R)  

ENCFF699ABD:  
![alt text](pictures/chip_seeker_H3K4me1_HCT116_ENCFF699ABD_hg19_filtered.bed_plotAnnoPie.png)  
ENCFF931YSQ:  
![alt text](pictures/chip_seeker_H3K4me1_HCT116_ENCFF931YSQ_hg19_filtered.bed_plotAnnoPie.png)  

### Сливаем 2 файла с метками в один
```
cat *_filtered.bed | sort -k1,1 -k2,2n > H3K4me1_HCT116_merged_hg19.bed  
```
### Проверяем объединение в геномном браузере
![alt text](pictures/marks_union.png)

### Создаем единый файл с квадруплексами
```
zcat *.gz | sort -k1,1 -k2,2n | bedtools merge > G4_merged.bed
```

### Строим графики для участков (G4_description.R)  
![alt text](pictures/len_hist_G4.png)

![alt text](pictures/G4_plotAnnoPie.png)

### Создаем пересечение вторичной структуры с метками  
```
bedtools intersect -a G4_merged.bed -b H3K4me1_HCT116_merged_hg19.bed > H3K4me1_HCT116_intersect_G4.bed
```
### Cтроим графики распределения длин и расположения аннотированных участков (G4_intersection.R)  
![alt text](pictures/len_hist_G4_intersection.png)

![alt text](pictures/G4_intersection_plotAnnoPie.png)

### Находим в геномном браузере участки пересечения с генами chr1:874,190-879,216 (session.txt)
![alt text](pictures/intersected_regions.png)  

### Аннотируем пересечения вторичных структур с ближайшими генами. (ChIPpeakAnno.R)  
Получаем 10005 аннотированных участков, из которых уникальными являются 5334. (wc -l)  

### Проведем GO анализ в pantherDB. Результаты сохраним в файл pantherdb_GO_analysis.txt. Результаты 10 самых значимых процессов
![alt text](pictures/panther_GO.png)  
