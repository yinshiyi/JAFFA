process minimap2_genome {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "bioconda::minimap2=2.17"

    input:
    tuple val(sample), path(fasta)

    output:
    tuple val(sample),
          path("${sample}_genome.psl")

    script:
    """
    minimap2 \
        -t ${params.threads} \
        -x splice -c \
        ${params.genomeFasta} \
        $fasta > ${sample}_genome.paf

    grep \$'\\t+\\t' ${sample}_genome.paf | \
    awk -F'\\t' -v OFS="\\t" '{ print \$4-\$3,0,0,0,0,0,0,0,\$5,\$1,\$2,\$3,\$4,\$6,\$7,\$8,\$9,2,"100,"\$4-\$3-100",",\$3","\$3+100",",\$8","\$9-\$4+\$3+100"" }' > ${sample}_genome.psl

    grep \$'\\t-\\t' ${sample}_genome.paf | \
    awk -F'\\t' -v OFS="\\t" '{ print \$4-\$3,0,0,0,0,0,0,0,\$5,\$1,\$2,\$3,\$4,\$6,\$7,\$8,\$9,2,"100,"\$4-\$3-100",", \$2-\$4","\$2-\$4+100",", \$8","\$9-\$4+\$3+100"" }' >> ${sample}_genome.psl
    """
}
