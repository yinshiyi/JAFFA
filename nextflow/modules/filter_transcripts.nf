process filter_transcripts {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "gxx_linux-64"

    input:
    tuple val(sample), path(paf)

    output:
    tuple val(sample), path("${paf.baseName}.txt")

    script:
    """
    g++ -std=c++11 -O3 -o process_transcriptome_align_table "${params.JAFFA_path}/src/process_transcriptome_align_table.c++"

    process_transcriptome_align_table \
        $paf \
        ${params.gapSize} \
        ${params.transTable} \
        '${params.anno_prefix}' \
        > ${paf.baseName}.txt
    """
}
