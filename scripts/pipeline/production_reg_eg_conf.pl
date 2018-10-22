#!/usr/bin/env perl
# Copyright [1999-2015] Wellcome Trust Sanger Institute and the EMBL-European Bioinformatics Institute
# Copyright [2016-2018] EMBL-European Bioinformatics Institute
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#      http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Release Coordinator, please update this file before starting every release
# and check the changes back into GIT for everyone's benefit.

# Things that normally need updating are:
#
# 1. Release number
# 2. Check the name prefix of all databases
# 3. Possibly add entries for core databases that are still on genebuilders' servers

use strict;
use warnings;
use Bio::EnsEMBL::Utils::ConfigRegistry;
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;
use Bio::EnsEMBL::Taxonomy::DBSQL::TaxonomyDBAdaptor;

# -------------------------CORE DATABASES--------------------------------------

# Before the official EG handover, the core databases are usually on the a production server:
Bio::EnsEMBL::Registry->load_registry_from_url('mysql://ensro@mysql-eg-prod-2:4239/95');
# Then they are moved to the staging server:
#Bio::EnsEMBL::Registry->load_registry_from_url('mysql://ensro@mysql-eg-staging-1.ebi.ac.uk:4160/95');
#Bio::EnsEMBL::Registry->load_registry_from_url('mysql://ensro@mysql-ens-vertannot-staging:4573/95');

# clarify which version of yeast to use
Bio::EnsEMBL::Registry->remove_DBAdaptor('saccharomyces_cerevisiae', 'core'); # deregister old version
Bio::EnsEMBL::DBSQL::DBAdaptor->new(
     -host => 'mysql-ens-vertannot-staging',
     -user => 'ensro',
     -port => 4573,
     -species => 'saccharomyces_cerevisiae',
     -group => 'core',
     -dbname => 'saccharomyces_cerevisiae_core_95_4',
 );

#-------------------------HOMOLOGY DATABASES-----------------------------------

# Members
# Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#     -host => 'mysql-ens-compara-prod-2',
#     -user => 'ensadmin',
#     -pass => $ENV{'ENSADMIN_PSW'},
#     -port => 4522,
#     -species => 'compara_members',
#     -dbname => 'waakanni_load_members_94',
# );

# Individual pipeline database for ProteinTrees:
# Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#      -host => 'mysql-ens-compara-prod-1',
#      -user => 'ensadmin',
#      -pass => $ENV{'ENSADMIN_PSW'},
#      -port => 4485,
#      -species => 'compara_ptrees',
#      -dbname => 'waakanni_protein_trees_93',
# );

# ------------------------- LASTZ DATABASES: -----------------------------------

#Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#    -host => 'mysql-ens-compara-prod-3',
#    -user => 'ensadmin',
#    -pass => $ENV{'ENSADMIN_PSW'},
#    -port => 4523,
#    -species => 'plants_lastz_mtru',
#    -dbname => 'carlac_eg_lastz_plants_mtru_ref',
#);

# SYNTENIES
# mysql-ens-compara-prod-2.ebi.ac.uk:4522/waakanni_plants_synteny_94
#Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#    -host => 'mysql-ens-compara-prod-2',
#    -user => 'ensadmin',
#    -pass => $ENV{'ENSADMIN_PSW'},
#    -port => 4522,
#    -species => 'plants_synteny',
#    -dbname => 'waakanni_plants_synteny_94',
#);

# ----------------------HOMOLOGY DATABASES---------------------------

# Protein tree production database
#Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#    -host => 'mysql-ens-compara-prod-4',
#    -user => 'ensadmin',
#    -pass => $ENV{'ENSADMIN_PSW'},
#    -port => 4401,
#    -species => 'plants_ptrees',
#    -dbname => 'carlac_plants_prottrees_41_94_B ',
#);

# ----------------------COMPARA DATABASES---------------------------

# Compara Master database:
Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
    -host => 'mysql-ens-compara-prod-5',
    -user => 'ensadmin',
    -pass => $ENV{'ENSADMIN_PSW'},
    -port => 4615,
    -species => 'compara_master',
    -dbname => 'ensembl_compara_master_plants',
);

# previous release database on one of Compara servers:
Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
    -host => 'mysql-ens-compara-prod-5',
    -user => 'ensadmin',
    -pass => $ENV{'ENSADMIN_PSW'},
    -port => 4615,
    -species => 'compara_prev',
    -dbname => 'ensembl_compara_plants_41_94',
);

# current release database on one of Compara servers:
#Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#    -host => 'mysql-ens-compara-prod-2',
#    -user => 'ensadmin',
#    -pass => $ENV{'ENSADMIN_PSW'},
#    -port => 4522,
#    -species => 'compara_curr',
#    -dbname => 'ensembl_compara_plants_41_94',
#);

# ensembl production (maintained by production team):
Bio::EnsEMBL::DBSQL::DBAdaptor->new(
    -host => 'mysql-ens-sta-1',
    -user => 'ensro',
    -port => 4519,
    -species => 'ensembl_production',
    -dbname => 'ensembl_production_95',
    -group => 'production',
);

# NCBI taxonomy database (also maintained by production team):
Bio::EnsEMBL::Taxonomy::DBSQL::TaxonomyDBAdaptor->new(
    -host => 'mysql-ens-sta-1',
    -user => 'ensro',
    -port => 4519,
    -group => 'taxonomy',
    -species => 'ncbi_taxonomy',
    -dbname => 'ncbi_taxonomy',
);


1;
