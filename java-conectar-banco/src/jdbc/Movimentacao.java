package jdbc;

public class Movimentacao {
    private int movimentacaoID;
    private String tipoFluxo;
    private String motivo;
    private int quantidade;
    private float valorTotal;

    public Movimentacao(int movimentacaoID, String tipoFluxo, String motivo, int quantidade, float valorTotal) {
        this.movimentacaoID = movimentacaoID;
        this.tipoFluxo = tipoFluxo;
        this.motivo = motivo;
        this.quantidade = quantidade;
        this.valorTotal = valorTotal;
    }

    public int getMovimentacaoID(){
        return movimentacaoID;
    }
    public String getTipoFluxo(){
        return tipoFluxo;
    }
    public String getMotivo(){
        return motivo;
    }
    public int getQuantidade(){
        return quantidade;
    }
    public float getValorTotal(){
        return valorTotal;
    }
}
