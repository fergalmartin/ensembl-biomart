=head1 LICENSE

Copyright [1999-2014] EMBL-European Bioinformatics Institute
and Wellcome Trust Sanger Institute

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

=cut


=pod

=head1 NAME

Bio::EnsEMBL::EGPipeline::PipeConfig::VariationMart_conf

=head1 DESCRIPTION

Configuration for running the Variation Mart pipeline, which
constructs a mart database from core and variation databases.

=head1 Author

James Allen

=cut

package Bio::EnsEMBL::EGPipeline::PipeConfig::VariationMart_conf;

use strict;
use warnings;

use base ('Bio::EnsEMBL::EGPipeline::PipeConfig::EGGeneric_conf');

sub default_options {
  my ($self) = @_;
  return {
    %{$self->SUPER::default_options},
    
    pipeline_name         => 'variation_mart_'.$self->o('ensembl_release'),
    drop_mart_db          => 0,
    drop_mart_tables      => 0,
    mtmp_tables_exist     => 0,
    always_skip_genotypes => [],
    never_skip_genotypes  => [],
    tmp_dir               => '/tmp',
    drop_mtmp             => 1,
    snp_indep_tables      => [],
    mart_db_name          => $self->o('division_name').'_snp_mart_'.$self->o('eg_release'),
    sample_threshold      => 0,
    populate_mart_rc_name => 'normal',
    snp_cull_tables       => [],
    optimize_tables       => 0,
    skip_meta_data        => 0,
    population_threshold  => 100,
    
    previous_mart => {
      -driver => $self->o('hive_driver'),
      -host   => $self->o('host'),
      -port   => $self->o('port'),
      -user   => $self->o('user'),
      -dbname => undef,
    },
    
    species      => [],
    antispecies  => [],
    division     => [],
    run_all      => 0,
    copy_species => [],
    copy_all     => 0,
    
    partition_size => 100000,
    
    # The following are required for building MTMP tables.
    variation_import_lib => $self->o('ensembl_cvs_root_dir').
      '/ensembl-variation/scripts/import',
    
    variation_feature_script => $self->o('ensembl_cvs_root_dir').
      '/ensembl-variation/scripts/misc/mart_variation_effect.pl',

    variation_mtmp_script => $self->o('ensembl_cvs_root_dir').
      '/ensembl-variation/scripts/misc/create_MTMP_tables.pl',
    
    # Mart tables are mostly independent in that their construction does not
    # rely on other mart tables. The only execption are the *_feature__main
    # tables, which contain all of the columns in the *_variation__main tables.
    
    # snp_indep_tables should be defined in an inheriting module

    snp_som_indep_tables => [
      'snp_som__variation__main',
      'snp_som__population_genotype__dm',
      'snp_som__variation_annotation__dm',
      'snp_som__variation_citation__dm',
      'snp_som__variation_set_variation__dm',
      'snp_som__variation_synonym__dm',
    ],

    snp_dep_tables => [
      'snp__variation_feature__main',
      'snp__mart_transcript_variation__dm',
      'snp__motif_feature_variation__dm',
      'snp__regulatory_feature_variation__dm',
    ],

    snp_som_dep_tables => [
      'snp_som__variation_feature__main',
      'snp_som__mart_transcript_variation__dm',
      'snp_som__motif_feature_variation__dm',
      'snp_som__regulatory_feature_variation__dm',
    ],

    sv_indep_tables => [
      'structvar__structural_variation__main',
      'structvar__structural_variation_annotation__dm',
      'structvar__supporting_structural_variation__dm',
      'structvar__variation_set_structural_variation__dm',
      'structvar__phenotype__dm',
    ],

    sv_som_indep_tables => [
      'structvar_som__structural_variation__main',
      'structvar_som__structural_variation_annotation__dm',
      'structvar_som__supporting_structural_variation__dm',
      'structvar_som__variation_set_structural_variation__dm',
      'structvar_som__phenotype__dm',
    ],

    sv_dep_tables => [
      'structvar__structural_variation_feature__main',
    ],

    sv_som_dep_tables => [
      'structvar_som__structural_variation_feature__main',
    ],

    # snp_cull_tables should be defined in an inheriting module

    snp_som_cull_tables => {
      'snp_som__population_genotype__dm'     => 'name_2019',
      'snp_som__variation_annotation__dm'    => 'name_2021',
      'snp_som__variation_citation__dm'      => 'authors_20137',
      'snp_som__variation_set_variation__dm' => 'name_2077',
      'snp_som__variation_synonym__dm'       => 'name_2030',
    },
    
    sv_cull_tables => {
      'structvar__structural_variation_annotation__dm'    => 'name_2019',
      'structvar__supporting_structural_variation__dm',   => 'supporting_structural_variation_id_20116',
      'structvar__variation_set_structural_variation__dm' => 'name_2077',
      'structvar__phenotype__dm'                          => 'phenotype_name',
    },

    sv_som_cull_tables => {
      'structvar_som__structural_variation_annotation__dm'    => 'name_2019',
      'structvar_som__supporting_structural_variation__dm',   => 'supporting_structural_variation_id_20116',
      'structvar_som__variation_set_structural_variation__dm' => 'name_2077',
      'structvar_som__phenotype__dm'                          => 'phenotype_name',
    },
    
    tables_dir => $self->o('eg_biomart_root_dir').'/var_mart/tables',
    
    # The following are required for adding metadata.
    scripts_lib => $self->o('eg_biomart_root_dir').'/scripts',
    
    generate_names_script => $self->o('eg_biomart_root_dir').
      '/scripts/generate_names.pl',
    
    generate_template_script => $self->o('eg_biomart_root_dir').
      '/scripts/generate_template.pl',
    
    template_template => $self->o('eg_biomart_root_dir').
      '/scripts/templates/variation_template_template.xml',
    
    dataset_template => $self->o('eg_biomart_root_dir').
      '/scripts/templates/dataset_variation_template.xml',
    
    generate_sv_template_script => $self->o('eg_biomart_root_dir').
      '/scripts/generate_structvar_template.pl',
    
    template_sv_template => $self->o('eg_biomart_root_dir').
      '/scripts/templates/structvar_template_template.xml',
    
    dataset_sv_template => $self->o('eg_biomart_root_dir').
      '/scripts/templates/dataset_structvar_template.xml',
    
  };
}

# Force an automatic loading of the registry in all workers.
sub beekeeper_extra_cmdline_options {
  my $self = shift;
  return "-reg_conf ".$self->o("registry");
}

# Ensures that species output parameter gets propagated implicitly.
sub hive_meta_table {
  my ($self) = @_;
  
  return {
    %{$self->SUPER::hive_meta_table},
    'hive_use_param_stack'  => 1,
  };
}

sub pipeline_analyses {
  my ($self) = @_;
  
  my $final_flow;
  if ($self->o('skip_meta_data')) {
    $final_flow = 'AnalyzeTables';
  } else {
    $final_flow = 'AddMetaData';
  }
  
  return [
    {
      -logic_name      => 'InitialiseMartDB',
      -module          => 'Bio::EnsEMBL::EGPipeline::VariationMart::InitialiseMartDB',
      -input_ids       => [ {} ],
      -parameters      => {
                            mart_db_name => $self->o('mart_db_name'),
                            drop_mart_db => $self->o('drop_mart_db'),
                          },
      -max_retry_count => 0,
      -rc_name         => 'normal',
      -flow_into       => {
                            '1->A' => ['ScheduleSpecies'],
                            'A->1' => [$final_flow],
                          },
      -meadow_type     => 'LOCAL',
    },

    {
      -logic_name      => 'ScheduleSpecies',
      -module          => 'Bio::EnsEMBL::EGPipeline::Common::RunnableDB::EGSpeciesFactory',
      -parameters      => {
                            species     => $self->o('species'),
                            antispecies => $self->o('antispecies'),
                            division    => $self->o('division'),
                            run_all     => $self->o('run_all'),
                          },
      -max_retry_count => 0,
      -rc_name         => 'normal',
      -flow_into       => {
                            '4' => 'DropMartTables'
                          },
      -meadow_type     => 'LOCAL',
    },

    {
      -logic_name        => 'DropMartTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::DropMartTables',
      -parameters        => {
                              drop_mart_tables => $self->o('drop_mart_tables'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 5,
      -rc_name           => 'normal',
      -flow_into         => ['CopyOrGenerate'],
    },

    {
      -logic_name        => 'CopyOrGenerate',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CopyOrGenerate',
      -parameters        => {
                              mtmp_tables_exist     => $self->o('mtmp_tables_exist'),
                              copy_species          => $self->o('copy_species'),
                              copy_all              => $self->o('copy_all'),
                              sample_threshold      => $self->o('sample_threshold'),
                              population_threshold  => $self->o('population_threshold'),
                              always_skip_genotypes => $self->o('always_skip_genotypes'),
                              never_skip_genotypes  => $self->o('never_skip_genotypes'),
                              division_name         => $self->o('division_name'),
                            },
      -max_retry_count   => 0,
      -rc_name           => 'normal',
      -flow_into         => {
                              '3->B' => ['CreateMTMPTables'],
                              '4'    => ['CopyMart'],
                              'B->5' => ['GenerateMart'],
                            },
      -meadow_type       => 'LOCAL',
    },

    {
      -logic_name        => 'CreateMTMPTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CreateMTMPTables',
      -parameters        => {
                              drop_mtmp                => $self->o('drop_mtmp'),
                              variation_import_lib     => $self->o('variation_import_lib'),
                              variation_feature_script => $self->o('variation_feature_script'),
                              variation_mtmp_script    => $self->o('variation_mtmp_script'),
                              registry                 => $self->o('registry'),
                              tmp_dir                  => $self->o('tmp_dir'),
                              division_name            => $self->o('division_name'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 5,
      -can_be_empty      => 1,
      -rc_name           => '16Gb_mem_16Gb_tmp',
    },

    {
      -logic_name        => 'CopyMart',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CopyMart',
      -parameters        => {
                              previous_mart => $self->o('previous_mart'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 5,
      -can_be_empty      => 1,
      -rc_name           => '16Gb_mem_16Gb_tmp',
    },

    {
      -logic_name        => 'GenerateMart',
      -module            => 'Bio::EnsEMBL::Hive::RunnableDB::Dummy',
      -parameters        => {},
      -max_retry_count   => 0,
      -can_be_empty      => 1,
      -rc_name           => 'normal',
      -flow_into         => {
                              '1->A' => ['CreateMartTables'],
                              'A->1' => ['CullMartTables'],
                            },
      -meadow_type       => 'LOCAL',
    },

    {
      -logic_name        => 'CreateMartTables',
      -module            => 'Bio::EnsEMBL::Hive::RunnableDB::Dummy',
      -parameters        => {},
      -max_retry_count   => 0,
      -rc_name           => 'normal',
      -flow_into         => {
                              '1->A' => ['CreateIndependentTables'],
                              'A->1' => ['AggregatedData'],
                            },
      -meadow_type       => 'LOCAL',
    },

    {
      -logic_name        => 'CreateIndependentTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CreateMartTables',
      -parameters        => {
                              snp_tables        => $self->o('snp_indep_tables'),
                              snp_som_tables   => $self->o('snp_som_indep_tables'),
                              sv_tables         => $self->o('sv_indep_tables'),
                              sv_som_tables         => $self->o('sv_som_indep_tables'),
                              tables_dir        => $self->o('tables_dir'),
                              variation_feature => 0,
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -flow_into         => {
                              '1->A' => ['PartitionTables'],
                              'A->1' => ['CreateMartIndexes'],
                            },
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'CreateDependentTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CreateMartTables',
      -parameters        => {
                              snp_tables        => $self->o('snp_dep_tables'),
                              snp_som_tables        => $self->o('snp_som_dep_tables'),
                              sv_tables         => $self->o('sv_dep_tables'),
                              sv_som_tables     => $self->o('sv_som_dep_tables'),
                              tables_dir        => $self->o('tables_dir'),
                              variation_feature => 1,
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -flow_into         => {
                              '1->A' => ['PartitionTables'],
                              'A->1' => ['CreateMartIndexes'],
                            },
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'PartitionTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::PartitionTables',
      -parameters        => {
                              partition_size => $self->o('partition_size'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -flow_into         => ['PopulateMart'],
      -rc_name           => 'normal',
      -meadow_type       => 'LOCAL',
    },

    {
      -logic_name        => 'PopulateMart',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::PopulateMart',
      -parameters        => {
                              tables_dir => $self->o('tables_dir'),
                            },
      -max_retry_count   => 3,
      -analysis_capacity => 100,
      -rc_name           => $self->o('populate_mart_rc_name'),
    },

    {
      -logic_name        => 'AggregatedData',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::AggregatedData',
      -parameters        => {
                              snp_tables        => $self->o('snp_indep_tables'),
                              snp_som_tables   => $self->o('snp_som_indep_tables'),
                              sv_tables         => $self->o('sv_indep_tables'),
                              sv_som_tables         => $self->o('sv_som_indep_tables'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -flow_into         => ['CreateDependentTables'],
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'CreateMartIndexes',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CreateMartIndexes',
      -parameters        => {
                              tables_dir => $self->o('tables_dir'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'CullMartTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::CullMartTables',
      -parameters        => {
                              snp_cull_tables => $self->o('snp_cull_tables'),
                              snp_som_cull_tables => $self->o('snp_som_cull_tables'), 
                              sv_cull_tables  => $self->o('sv_cull_tables'),
                              sv_som_cull_tables => $self->o('sv_som_cull_tables'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'AddMetaData',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::AddMetaData',
      -parameters        => {
                              scripts_lib              => $self->o('scripts_lib'),
                              generate_names_script    => $self->o('generate_names_script'),
                              generate_template_script => $self->o('generate_template_script'),
                              template_template        => $self->o('template_template'),
                              dataset_template         => $self->o('dataset_template'),
                              ensembl_release          => $self->o('ensembl_release'),
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -can_be_empty      => 1,
      -flow_into         => ['AddSVMetaData'],
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'AddSVMetaData',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::AddMetaData',
      -parameters        => {
                              scripts_lib              => $self->o('scripts_lib'),
                              generate_names_script    => $self->o('generate_names_script'),
                              generate_template_script => $self->o('generate_sv_template_script'),
                              template_template        => $self->o('template_sv_template'),
                              dataset_template         => $self->o('dataset_sv_template'),
                              ensembl_release          => $self->o('ensembl_release'),
                              dataset_name             => 'structvar',
                              dataset_main             => 'structural_variation__main',
                              description              => 'structural variations',
                            },
      -max_retry_count   => 0,
      -analysis_capacity => 10,
      -can_be_empty      => 1,
      -flow_into         => ['AnalyzeTables'],
      -rc_name           => 'normal',
    },

    {
      -logic_name        => 'AnalyzeTables',
      -module            => 'Bio::EnsEMBL::EGPipeline::VariationMart::AnalyzeTables',
      -parameters        => {
                              optimize_tables => $self->o('optimize_tables'),
                            },
      -max_retry_count   => 0,
      -rc_name           => 'normal',
    },

  ];
}

1;
