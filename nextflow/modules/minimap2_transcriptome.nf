process minimap2_transcriptome {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "bioconda::minimap2=2.17"

    input:
    tuple val(sample), path(fasta)

    output:
    tuple val(sample), path("${sample}.paf")

    script:
    """
    minimap2 \
        -t ${params.threads} \
        -x map-ont -c \
        ${params.transFasta} \
        $fasta > ${sample}.paf
    """
}
