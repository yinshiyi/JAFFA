process report_3_gene_fusions {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "gxx_linux-64"

    input:
    tuple val(sample),
          path(summary),
          path(txt)

    output:
    tuple val(sample),
          path("${sample}.3gene_summary"),
          path("${sample}.3gene_reads")

    script:
    """
    g++ -std=c++11 -O3 -o make_3_gene_fusion_table "${params.JAFFA_path}/src/make_3_gene_fusion_table.c++"

    make_3_gene_fusion_table \
        $summary \
        $txt \
        ${sample}.3gene_reads > ${sample}.3gene_summary
    """
}
