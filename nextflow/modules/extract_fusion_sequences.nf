process extract_fusion_sequences {

    tag "$sample"
    publishDir "${params.outdir}/${sample}", mode: 'copy'
    conda "bioconda::bbmap=39.52 gxx_linux-64"

    input:
    tuple val(sample), path(txt), path(fasta)

    output:
    tuple val(sample), path("${txt.baseName}.fusions.fa")

    script:
    """
    g++ -std=c++11 -O3 -o extract_seq_from_fasta "${params.JAFFA_path}/src/extract_seq_from_fasta.c++"

    awk '{print \$1}' $txt > ids.temp
    reformat.sh \
        in=$fasta \
        out=stdout.fasta \
        fastawrap=0 \
    | extract_seq_from_fasta ids.temp \
        > ${txt.baseName}.fusions.fa

    rm ids.temp
    """
}
