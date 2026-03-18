process make_fasta_reads_table {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'

    input:
    tuple val(sample), path(txt)

    output:
    tuple val(sample), path("${txt.baseName}.reads")

    script:
    """
    echo -e "transcript\tbreak_min\tbreak_max\tfusion_genes\tspanning_pairs\tspanning_reads" \
        > ${txt.baseName}.reads

    awk 'BEGIN {OFS="\t"} { print \$1, \$2, \$3, \$4, 0, 1 }' $txt \
        | sort -u >> ${txt.baseName}.reads
    """
}
