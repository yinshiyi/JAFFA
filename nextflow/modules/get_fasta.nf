process get_fasta {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "bioconda::bbmap=39.52"

    input:
    tuple val(sample), path(reads)

    output:
    tuple val(sample), path("${sample}.fasta")

    script:
    """
    reformat.sh ignorebadquality=t \
        in=$reads \
        out=${sample}.fasta \
        threads=${params.threads}
    """
}
