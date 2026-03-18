process make_count_table {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "bioconda::minimap2=2.17"

    input:
    tuple val(sample), path(paf)

    output:
    tuple val(sample), path("${sample}.counts")

    script:
    """
    g++ -std=c++11 -O3 -o make_count_table "${params.JAFFA_path}/src/make_count_table.c++"
    cat ${paf} |\
        cut -f1,6 |\
        make_count_table ${params.transTable} ${params.anno_prefix} > "${sample}.counts"
    """
}

