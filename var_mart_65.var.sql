create table VAR_MART_DB.TEMP0 as select a.validation_status as validation_status_2025,a.source_id as source_id_2025,a.ancestral_allele as ancestral_allele_2025,a.name as name_2025,a.class_attrib_id as class_attrib_id_2025,a.variation_id as variation_id_2025_key,a.somatic as somatic_2025 from VAR_DB.variation as a where VAR_ID_COND_a
create index I_0 on VAR_MART_DB.TEMP0(source_id_2025);
create table VAR_MART_DB.TEMP1 as select a.*,b.description as description_2021,b.name as name_2021,b.version as version_2021,b.type as type_2021 from VAR_MART_DB.TEMP0 as a left join VAR_DB.source as b on a.source_id_2025=b.source_id;
drop table VAR_MART_DB.TEMP0;
alter table VAR_MART_DB.TEMP1 drop column source_id_2025;
create index I_1 on VAR_MART_DB.TEMP1(name_2021);
create index I_2 on VAR_MART_DB.TEMP1(name_2025);
create index I_3 on VAR_MART_DB.TEMP1(validation_status_2025);
rename table VAR_MART_DB.TEMP1 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main;
create index I_4 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_id_2025_key);
create table VAR_MART_DB.TEMP2 as select a.variation_id_2025_key from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_5 on VAR_MART_DB.TEMP2(variation_id_2025_key);
create table VAR_MART_DB.TEMP3 as select a.*,b.risk_allele_freq_in_controls as risk_allele_freq_in_controls_2035,b.associated_variant_risk_allele as associated_variant_risk_allele_2035,b.associated_gene as associated_gene_2035,b.study_id as study_id_2035,b.variation_names as variation_names_2035,b.p_value as p_value_2035,b.variation_annotation_id as variation_annotation_id_2035,b.phenotype_id as phenotype_id_2035 from VAR_MART_DB.TEMP2 as a inner join VAR_DB.variation_annotation as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP2;
create index I_6 on VAR_MART_DB.TEMP3(phenotype_id_2035);
create table VAR_MART_DB.TEMP4 as select a.*,b.description as description_2033,b.name as name_2033 from VAR_MART_DB.TEMP3 as a inner join VAR_DB.phenotype as b on a.phenotype_id_2035=b.phenotype_id;
drop table VAR_MART_DB.TEMP3;
create index I_6_2 on VAR_MART_DB.TEMP4(study_id_2035);
create table VAR_MART_DB.TEMP4_2 as select a.*,b.description as description_20100,b.external_reference as external_reference_20100,b.name as name_20100,b.source_id as source_id_20100,b.study_type as study_type_20100,b.url as url_20100 from VAR_MART_DB.TEMP4 as a inner join VAR_DB.study as b on a.study_id_2035=b.study_id;
DROP TABLE VAR_MART_DB.TEMP4;
create index I_7 on VAR_MART_DB.TEMP4_2(source_id_20100);
create table VAR_MART_DB.TEMP5 as select a.*,b.description as description_2021,b.name as name_2021,b.type as type_2021 from VAR_MART_DB.TEMP4_2 as a inner join VAR_DB.source as b on a.source_id_20100=b.source_id;
drop table VAR_MART_DB.TEMP4_2;
create index I_8 on VAR_MART_DB.TEMP5(variation_id_2025_key);
create table VAR_MART_DB.TEMP6 as select a.variation_id_2025_key,b.source_id_20100,b.description_2021,b.variation_annotation_id_2035,b.phenotype_id_2035,b.risk_allele_freq_in_controls_2035,b.name_2033,b.study_id_2035,b.associated_variant_risk_allele_2035,b.description_2033,b.name_2021,b.associated_gene_2035,b.name_20100,b.description_20100,b.url_20100,b.external_reference_20100,b.study_type_20100,b.variation_names_2035,b.p_value_2035,b.type_2021 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP5 as b on a.variation_id_2025_key=b.variation_id_2025_key;
drop table VAR_MART_DB.TEMP5;
#alter table VAR_MART_DB.TEMP6 drop column source_id_20100;
alter table VAR_MART_DB.TEMP6 drop column variation_annotation_id_2035;
alter table VAR_MART_DB.TEMP6 drop column phenotype_id_2035;
rename table VAR_MART_DB.TEMP6 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_annotation__dm;
create index I_9 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_annotation__dm(variation_id_2025_key);
alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (variation_annotation_bool integer default 0);
update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set variation_annotation_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_annotation__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.description_2021 is null and b.risk_allele_freq_in_controls_2035 is null and b.name_2033 is null and b.study_id_2035 is null and b.associated_variant_risk_allele_2035 is null and b.description_2033 is null and b.name_2021 is null and b.associated_gene_2035 is null and b.study_type_20100 is null and b.variation_names_2035 is null and b.p_value_2035 is null));
create index I_10 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_annotation_bool);
#create table VAR_MART_DB.TEMP7 as select a.source_id as source_id_2021,a.description as description_2021,a.name as name_2021,a.version as version_2021 from VAR_DB.source as a where a.source_id='1';
#create index I_11 on VAR_MART_DB.TEMP7(source_id_2021);
#create table VAR_MART_DB.TEMP8 as select a.*,b.subsnp_id as subsnp_id_2030,b.name as name_2030,b.moltype as moltype_2030,b.variation_id as variation_id_2025_key,b.variation_synonym_id as variation_synonym_id_2030 from VAR_MART_DB.TEMP7 as a left join VAR_DB.variation_synonym as b on a.source_id_2021=b.source_id;
#drop table VAR_MART_DB.TEMP7;
#create index I_12 on VAR_MART_DB.TEMP8(variation_id_2025_key);
#create table VAR_MART_DB.TEMP10 as select a.* from VAR_MART_DB.TEMP8 as a inner join VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP8;
#create index I_13 on VAR_MART_DB.TEMP10(variation_id_2025_key);
#create table VAR_MART_DB.TEMP11 as select a.variation_id_2025_key,b.description_2021,b.source_id_2021,b.version_2021,b.name_2021,b.subsnp_id_2030,b.moltype_2030,b.variation_synonym_id_2030,b.name_2030 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP10 as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP10;
#alter table VAR_MART_DB.TEMP11 drop column subsnp_id_2030;
#create index I_14 on VAR_MART_DB.TEMP11(name_2021);
#create index I_15 on VAR_MART_DB.TEMP11(name_2030);
#rename table VAR_MART_DB.TEMP11 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Ensembl__dm;
#create index I_16 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Ensembl__dm(variation_id_2025_key);
#alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (variation_synonym_Ensembl_bool integer default 0);
#update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set variation_synonym_Ensembl_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Ensembl__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.description_2021 is null and b.source_id_2021 is null and b.version_2021 is null and b.name_2021 is null and b.moltype_2030 is null and b.variation_synonym_id_2030 is null and b.name_2030 is null));
#create index I_17 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_synonym_Ensembl_bool);
#create table VAR_MART_DB.TEMP12 as select a.source_id as source_id_2021,a.description as description_2021,a.name as name_2021,a.version as version_2021 from VAR_DB.source as a where a.source_id='2';
#create index I_18 on VAR_MART_DB.TEMP12(source_id_2021);
#create table VAR_MART_DB.TEMP13 as select a.*,b.subsnp_id as subsnp_id_2030,b.name as name_2030,b.moltype as moltype_2030,b.variation_id as variation_id_2025_key,b.variation_synonym_id as variation_synonym_id_2030 from VAR_MART_DB.TEMP12 as a left join VAR_DB.variation_synonym as b on a.source_id_2021=b.source_id;
#drop table VAR_MART_DB.TEMP12;
#create index I_19 on VAR_MART_DB.TEMP13(variation_id_2025_key);
#create table VAR_MART_DB.TEMP15 as select a.* from VAR_MART_DB.TEMP13 as a inner join VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP13;
#create index I_20 on VAR_MART_DB.TEMP15(variation_id_2025_key);
#create table VAR_MART_DB.TEMP16 as select a.variation_id_2025_key,b.description_2021,b.source_id_2021,b.version_2021,b.name_2021,b.subsnp_id_2030,b.moltype_2030,b.variation_synonym_id_2030,b.name_2030 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP15 as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP15;
#alter table VAR_MART_DB.TEMP16 drop column subsnp_id_2030;
#create index I_21 on VAR_MART_DB.TEMP16(name_2021);
#create index I_22 on VAR_MART_DB.TEMP16(name_2030);
#rename table VAR_MART_DB.TEMP16 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Perlegen__dm;
#create index I_23 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Perlegen__dm(variation_id_2025_key);
#alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (variation_synonym_Perlegen_bool integer default 0);
#update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set variation_synonym_Perlegen_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Perlegen__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.description_2021 is null and b.source_id_2021 is null and b.version_2021 is null and b.name_2021 is null and b.moltype_2030 is null and b.variation_synonym_id_2030 is null and b.name_2030 is null));
#create index I_24 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_synonym_Perlegen_bool);
#create table VAR_MART_DB.TEMP17 as select a.source_id as source_id_2021,a.description as description_2021,a.name as name_2021,a.version as version_2021 from VAR_DB.source as a where a.source_id='4';
#create index I_25 on VAR_MART_DB.TEMP17(source_id_2021);
#create table VAR_MART_DB.TEMP18 as select a.*,b.subsnp_id as subsnp_id_2030,b.name as name_2030,b.moltype as moltype_2030,b.variation_id as variation_id_2025_key,b.variation_synonym_id as variation_synonym_id_2030 from VAR_MART_DB.TEMP17 as a left join VAR_DB.variation_synonym as b on a.source_id_2021=b.source_id;
#drop table VAR_MART_DB.TEMP17;
#create index I_26 on VAR_MART_DB.TEMP18(variation_id_2025_key);
#create table VAR_MART_DB.TEMP20 as select a.* from VAR_MART_DB.TEMP18 as a inner join VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP18;
#create index I_27 on VAR_MART_DB.TEMP20(variation_id_2025_key);
#create table VAR_MART_DB.TEMP21 as select a.variation_id_2025_key,b.description_2021,b.source_id_2021,b.version_2021,b.name_2021,b.subsnp_id_2030,b.moltype_2030,b.variation_synonym_id_2030,b.name_2030 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP20 as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP20;
#alter table VAR_MART_DB.TEMP21 drop column subsnp_id_2030;
#create index I_28 on VAR_MART_DB.TEMP21(name_2021);
#create index I_29 on VAR_MART_DB.TEMP21(name_2030);
#rename table VAR_MART_DB.TEMP21 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Nordborg__dm;
#create index I_30 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Nordborg__dm(variation_id_2025_key);
#alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (variation_synonym_Nordborg_bool integer default 0);
#update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set variation_synonym_Nordborg_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_synonym_Nordborg__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.description_2021 is null and b.source_id_2021 is null and b.version_2021 is null and b.name_2021 is null and b.moltype_2030 is null and b.variation_synonym_id_2030 is null and b.name_2030 is null));
#create index I_31 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_synonym_Nordborg_bool);
create table VAR_MART_DB.TEMP22 as select a.variation_id_2025_key from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_32 on VAR_MART_DB.TEMP22(variation_id_2025_key);
create table VAR_MART_DB.TEMP23 as select a.*,b.population_genotype_id as population_genotype_id_2016,b.allele_1 as allele_1_2016,b.allele_2 as allele_2_2016,b.sample_id as sample_id_2016,b.frequency as frequency_2016,b.count as count_2016 from VAR_MART_DB.TEMP22 as a inner join VAR_DB.MTMP_population_genotype as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP22;
create index I_33 on VAR_MART_DB.TEMP23(sample_id_2016);
create table VAR_MART_DB.TEMP24 as select a.*,b.description as description_2019,b.name as name_2019,b.size as size_2019 from VAR_MART_DB.TEMP23 as a inner join VAR_DB.sample as b on a.sample_id_2016=b.sample_id;
drop table VAR_MART_DB.TEMP23;
create index I_34 on VAR_MART_DB.TEMP24(variation_id_2025_key);
create table VAR_MART_DB.TEMP25 as select a.variation_id_2025_key,b.size_2019,b.sample_id_2016,b.name_2019,b.frequency_2016,b.description_2019,b.population_genotype_id_2016,concat(b.allele_1_2016,'|',b.allele_2_2016) as allele from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP24 as b on a.variation_id_2025_key=b.variation_id_2025_key;
drop table VAR_MART_DB.TEMP24;
alter table VAR_MART_DB.TEMP25 drop column sample_id_2016;
alter table VAR_MART_DB.TEMP25 drop column population_genotype_id_2016;
rename table VAR_MART_DB.TEMP25 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__population_genotype__dm;
create index I_35 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__population_genotype__dm(variation_id_2025_key);
alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (population_genotype_bool integer default 0);
update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set population_genotype_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__population_genotype__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.size_2019 is null and b.name_2019 is null and b.frequency_2016 is null and b.description_2019 is null and b.allele is null));
create index I_36 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(population_genotype_bool);
create table VAR_MART_DB.TEMP26 as select a.variation_id_2025_key from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_37 on VAR_MART_DB.TEMP26(variation_id_2025_key);
create table VAR_MART_DB.TEMP27 as select a.*,b.subsnp_id as subsnp_id_2023,b.allele_1 as allele_1_2023,b.allele_2 as allele_2_2023,b.sample_id as sample_id_2023 from VAR_MART_DB.TEMP26 as a inner join VAR_DB.tmp_individual_genotype_single_bp as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP26;
create index I_38 on VAR_MART_DB.TEMP27(sample_id_2023);
create table VAR_MART_DB.TEMP29 as select a.*,b.description as description_2019,b.name as name_2019,b.display as display_2019,b.size as size_2019 from VAR_MART_DB.TEMP27 as a inner join VAR_DB.sample as b on a.sample_id_2023=b.sample_id;
drop table VAR_MART_DB.TEMP27;
create table VAR_MART_DB.TEMP30 as select name_2019,allele_2_2023,size_2019,sample_id_2023,display_2019,description_2019,variation_id_2025_key,subsnp_id_2023,allele_1_2023,concat(allele_1_2023, '|', allele_2_2023) as allele from VAR_MART_DB.TEMP29;
drop table VAR_MART_DB.TEMP29;
create index I_39 on VAR_MART_DB.TEMP30(variation_id_2025_key);
create table VAR_MART_DB.TEMP31 as select a.variation_id_2025_key,b.size_2019,b.display_2019,b.subsnp_id_2023,b.name_2019,b.description_2019,b.allele,b.allele_2_2023,b.sample_id_2023,b.allele_1_2023 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP30 as b on a.variation_id_2025_key=b.variation_id_2025_key;
drop table VAR_MART_DB.TEMP30;
DISTINCT_POLY CREATE_THEN_INSERT VAR_MART_DB.TEMP32 select distinct name_2019,allele,size_2019,sample_id_2023,display_2019,description_2019,variation_id_2025_key from VAR_MART_DB.TEMP31 where VAR_KEY_COND
drop table VAR_MART_DB.TEMP31;
create index I_40 on VAR_MART_DB.TEMP32(name_2019);
rename table VAR_MART_DB.TEMP32 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__poly__dm;
create index I_41 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__poly__dm(variation_id_2025_key);
create table VAR_MART_DB.TEMP33 as select a.variation_id_2025_key from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_42 on VAR_MART_DB.TEMP33(variation_id_2025_key);
create table VAR_MART_DB.TEMP34 as select a.*,b.variation_set_id as variation_set_id_2078 from VAR_MART_DB.TEMP33 as a inner join VAR_DB.variation_set_variation as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP33;
create index I_43 on VAR_MART_DB.TEMP34(variation_set_id_2078);
create table VAR_MART_DB.TEMP35 as select a.*,b.description as description_2077,b.name as name_2077 from VAR_MART_DB.TEMP34 as a inner join VAR_DB.variation_set as b on a.variation_set_id_2078=b.variation_set_id;
drop table VAR_MART_DB.TEMP34;
create index I_44 on VAR_MART_DB.TEMP35(variation_id_2025_key);
create table VAR_MART_DB.TEMP36 as select a.variation_id_2025_key,b.description_2077,b.name_2077,b.variation_set_id_2078 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP35 as b on a.variation_id_2025_key=b.variation_id_2025_key;
drop table VAR_MART_DB.TEMP35;
rename table VAR_MART_DB.TEMP36 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_set_variation__dm;
create index I_45 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_set_variation__dm(variation_id_2025_key);
alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (variation_set_variation_bool integer default 0);
update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set variation_set_variation_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_set_variation__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.description_2077 is null and b.name_2077 is null and b.variation_set_id_2078 is null));
create index I_46 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_set_variation_bool);
create table VAR_MART_DB.TEMP37 as select a.variation_id_2025_key from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_47 on VAR_MART_DB.TEMP37(variation_id_2025_key);
create table VAR_MART_DB.TEMP38 as select a.*,b.subsnp_id as subsnp_id_2010,b.allele_1 as allele_1_2010,b.allele_2 as allele_2_2010,b.sample_id as sample_id_2010 from VAR_MART_DB.TEMP37 as a inner join VAR_DB.individual_genotype_multiple_bp as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP37;
create index I_48 on VAR_MART_DB.TEMP38(sample_id_2010);
create table VAR_MART_DB.TEMP40 as select a.*,b.description as description_2019,b.name as name_2019,b.display as display_2019,b.size as size_2019 from VAR_MART_DB.TEMP38 as a inner join VAR_DB.sample as b on a.sample_id_2010=b.sample_id;
drop table VAR_MART_DB.TEMP38;
create table VAR_MART_DB.TEMP41 as select name_2019,allele_2_2010,size_2019,sample_id_2010,display_2019,description_2019,variation_id_2025_key,subsnp_id_2010,allele_1_2010,concat(allele_1_2010, '|', allele_2_2010) as allele from VAR_MART_DB.TEMP40;
drop table VAR_MART_DB.TEMP40;
create index I_49 on VAR_MART_DB.TEMP41(variation_id_2025_key);
create table VAR_MART_DB.TEMP42 as select a.variation_id_2025_key,b.size_2019,b.display_2019,b.name_2019,b.allele_2_2010,b.subsnp_id_2010,b.description_2019,b.allele_1_2010,b.allele,b.sample_id_2010 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP41 as b on a.variation_id_2025_key=b.variation_id_2025_key;
drop table VAR_MART_DB.TEMP41;
create table VAR_MART_DB.TEMP43 as select distinct name_2019,allele,size_2019,sample_id_2010,display_2019,description_2019,variation_id_2025_key from VAR_MART_DB.TEMP42;
drop table VAR_MART_DB.TEMP42;
create index I_50 on VAR_MART_DB.TEMP43(name_2019);
rename table VAR_MART_DB.TEMP43 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__mpoly__dm;
create index I_51 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__mpoly__dm(variation_id_2025_key);
create table VAR_MART_DB.TEMP44 as select a.variation_id_2025_key from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_52 on VAR_MART_DB.TEMP44(variation_id_2025_key);
#create table VAR_MART_DB.TEMP45 as select a.*,b.* from VAR_MART_DB.TEMP44 as a inner join VAR_DB.strain_gtype_poly as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP44;
#create index I_53 on VAR_MART_DB.TEMP45(variation_id_2025_key);
#create table VAR_MART_DB.TEMP46 as select a.variation_id_2025_key,b.* from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a left join VAR_MART_DB.TEMP45 as b on a.variation_id_2025_key=b.variation_id_2025_key;
#drop table VAR_MART_DB.TEMP45;
#rename table VAR_MART_DB.TEMP45 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__strain_gtype_poly__dm;
#create index I_54 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__strain_gtype_poly__dm(variation_id_2025_key);
#alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (strain_gtype_poly_bool integer default 0);
#update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set strain_gtype_poly_bool=(select case count(1) when 0 then null else 1 end from VAR_MART_DB.SPECIES_ABBREV_eg_snp__strain_gtype_poly__dm b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.count = 0));
#create index I_55 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(strain_gtype_poly_bool);
# PRE_VFM
create table VAR_MART_DB.TEMP47 as select a.* from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main as a;
create index I_56 on VAR_MART_DB.TEMP47(variation_id_2025_key);
create table VAR_MART_DB.TEMP48 as select a.*,b.validation_status as validation_status_2026,b.variation_feature_id as variation_feature_id_2026_key,b.seq_region_id as seq_region_id_2026,b.flags as flags_2026,b.variation_name as variation_name_2026,b.seq_region_start as seq_region_start_2026,b.source_id as source_id_2026,b.map_weight as map_weight_2026,b.seq_region_end as seq_region_end_2026,b.allele_string as allele_string_2026,b.seq_region_strand as seq_region_strand_2026 from VAR_MART_DB.TEMP47 as a left join VAR_DB.variation_feature as b on a.variation_id_2025_key=b.variation_id;
drop table VAR_MART_DB.TEMP47;
create index I_57 on VAR_MART_DB.TEMP48(source_id_2026);
create table VAR_MART_DB.TEMP49 as select a.*,b.description as description_2021_r1,b.name as name_2021_r1,b.version as version_2021_r1 from VAR_MART_DB.TEMP48 as a left join VAR_DB.source as b on a.source_id_2026=b.source_id;
drop table VAR_MART_DB.TEMP48;
create index I_58 on VAR_MART_DB.TEMP49(seq_region_id_2026);
create table VAR_MART_DB.TEMP50 as select a.*,b.name as name_1059,b.coord_system_id as coord_system_id_1059 from VAR_MART_DB.TEMP49 as a left join CORE_DB.seq_region as b on a.seq_region_id_2026=b.seq_region_id;
drop table VAR_MART_DB.TEMP49;
create index I_59 on VAR_MART_DB.TEMP50(seq_region_id_2026);
create table VAR_MART_DB.TEMP52 as select a.*,b.name as name_2034 from VAR_MART_DB.TEMP50 as a left join VAR_DB.seq_region as b on a.seq_region_id_2026=b.seq_region_id;
drop table VAR_MART_DB.TEMP50;
alter table VAR_MART_DB.TEMP52 drop column coord_system_id_1059;
alter table VAR_MART_DB.TEMP52 drop column source_id_2026;
create index I_60 on VAR_MART_DB.TEMP52(seq_region_start_2026);
create index I_61 on VAR_MART_DB.TEMP52(validation_status_2026);
create index I_62 on VAR_MART_DB.TEMP52(name_2025);
create index I_63 on VAR_MART_DB.TEMP52(name_1059);
create index I_64 on VAR_MART_DB.TEMP52(name_2021_r1);
rename table VAR_MART_DB.TEMP52 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main;
create index I_65 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main(variation_id_2025_key);
create index I_66 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main(variation_feature_id_2026_key);
alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main add column (variation_feature_count integer default 0);
update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main a set variation_feature_count=(select count(1) from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main b where a.variation_id_2025_key=b.variation_id_2025_key and not (b.description_2021 is null and b.description_2021_r1 is null and b.version_2021_r1 is null and b.flags_2026 is null and b.seq_region_start_2026 is null and b.validation_status_2026 is null and b.variation_feature_id_2026_key is null and b.validation_status_2025 is null and b.version_2021 is null and b.name_2034 is null and b.name_2021 is null and b.seq_region_id_2026 is null and b.name_2025 is null and b.seq_region_end_2026 is null and b.allele_string_2026 is null and b.seq_region_strand_2026 is null and b.variation_name_2026 is null and b.name_1059 is null and b.name_2021_r1 is null and b.ancestral_allele_2025 is null and b.map_weight_2026 is null));
create index I_67 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main(variation_feature_count);
alter table VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main add column (variation_feature_count integer default 0);
update VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main a set variation_feature_count=(select max(variation_feature_count) from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation__main b where a.variation_id_2025_key=b.variation_id_2025_key);
create index I_68 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main(variation_feature_count);
create table VAR_MART_DB.TEMP53 as select a.seq_region_id as seq_region_id_1020,a.source as source_1020,a.seq_region_start as seq_region_start_1020,a.status as status_1020,a.analysis_id as analysis_id_1020,a.biotype as biotype_1020,a.display_xref_id as display_xref_id_1020,a.gene_id as gene_id_1020,a.seq_region_strand as seq_region_strand_1020,a.seq_region_end as seq_region_end_1020,a.canonical_annotation as canonical_annotation_1020 from CORE_DB.gene as a;
create index I_69 on VAR_MART_DB.TEMP53(gene_id_1020);
create table VAR_MART_DB.TEMP56 as select a.*,b.stable_id as stable_id_1023 from VAR_MART_DB.TEMP53 as a inner join CORE_DB.gene_stable_id as b on a.gene_id_1020=b.gene_id;
drop table VAR_MART_DB.TEMP53;
create index I_70 on VAR_MART_DB.TEMP56(gene_id_1020);
create table VAR_MART_DB.TEMP57 as select a.*,b.seq_region_id as seq_region_id_1064,b.transcript_id as transcript_id_1064,b.status as status_1064,b.seq_region_start as seq_region_start_1064,b.analysis_id as analysis_id_1064,b.biotype as biotype_1064,b.display_xref_id as display_xref_id_1064,b.seq_region_end as seq_region_end_1064,b.seq_region_strand as seq_region_strand_1064 from VAR_MART_DB.TEMP56 as a inner join CORE_DB.transcript as b on a.gene_id_1020=b.gene_id;
drop table VAR_MART_DB.TEMP56;
create index I_71 on VAR_MART_DB.TEMP57(transcript_id_1064);
create table VAR_MART_DB.TEMP60 as select a.*,b.stable_id as stable_id_1066 from VAR_MART_DB.TEMP57 as a inner join CORE_DB.transcript_stable_id as b on a.transcript_id_1064=b.transcript_id;
drop table VAR_MART_DB.TEMP57;
create index I_72 on VAR_MART_DB.TEMP60(stable_id_1066);
create table VAR_MART_DB.TEMP61 as select a.*,b.variation_feature_id as variation_feature_id_2026_key,b.cds_end as cds_end_2090,b.transcript_variation_id as transcript_variation_id_2090,b.cdna_end as cdna_end_2090,b.cds_start as cds_start_2090,b.mart_consequence_type as mart_consequence_type_2090,b.pep_allele_string as pep_allele_string_2090,b.cdna_start as cdna_start_2090,b.translation_end as translation_end_2090,b.translation_start as translation_start_2090, b.polyphen_prediction as polyphen_prediction_2090, b.sift_prediction as sift_prediction_2090, b.allele_string as allele_string_2090 from VAR_MART_DB.TEMP60 as a inner join VAR_DB.MTMP_transcript_variation as b on a.stable_id_1066=b.feature_stable_id;
drop table VAR_MART_DB.TEMP60;
create index I_73 on VAR_MART_DB.TEMP61(variation_feature_id_2026_key);
create table VAR_MART_DB.TEMP62 as select a.* from VAR_MART_DB.TEMP61 as a inner join VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main as b on a.variation_feature_id_2026_key=b.variation_feature_id_2026_key;
drop table VAR_MART_DB.TEMP61;
create index I_74 on VAR_MART_DB.TEMP62(variation_feature_id_2026_key);
create table VAR_MART_DB.TEMP63 as select a.variation_feature_id_2026_key,b.seq_region_end_1064,b.cdna_end_2090,b.pep_allele_string_2090,b.transcript_id_1064,b.seq_region_strand_1020,b.seq_region_start_1064,b.gene_id_1020,b.biotype_1020,b.status_1020,b.translation_start_2090,b.cds_end_2090,b.stable_id_1066,b.cdna_start_2090,b.seq_region_id_1020,b.status_1064,b.transcript_variation_id_2090,b.seq_region_strand_1064,b.display_xref_id_1020,b.source_1020,b.stable_id_1023,b.mart_consequence_type_2090,b.seq_region_start_1020,b.seq_region_id_1064,b.display_xref_id_1064,b.analysis_id_1064,b.translation_end_2090,b.cds_start_2090,b.analysis_id_1020,b.biotype_1064,b.seq_region_end_1020,b.canonical_annotation_1020,b.allele_string_2090,b.polyphen_prediction_2090,b.sift_prediction_2090 from VAR_MART_DB.SPECIES_ABBREV_eg_snp__variation_feature__main as a left join VAR_MART_DB.TEMP62 as b on a.variation_feature_id_2026_key=b.variation_feature_id_2026_key;
drop table VAR_MART_DB.TEMP62;
alter table VAR_MART_DB.TEMP63 drop column seq_region_id_1020;
alter table VAR_MART_DB.TEMP63 drop column seq_region_id_1064;
alter table VAR_MART_DB.TEMP63 drop column analysis_id_1064;
alter table VAR_MART_DB.TEMP63 drop column analysis_id_1020;
create index I_75 on VAR_MART_DB.TEMP63(translation_start_2090);
create index I_76 on VAR_MART_DB.TEMP63(mart_consequence_type_2090);
rename table VAR_MART_DB.TEMP63 to VAR_MART_DB.SPECIES_ABBREV_eg_snp__mart_transcript_variation__dm;
create index I_77 on VAR_MART_DB.SPECIES_ABBREV_eg_snp__mart_transcript_variation__dm(variation_feature_id_2026_key);
