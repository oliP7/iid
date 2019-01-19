public enum DataColors {
    GREY (142, 142, 147),
    TEXTCOLOR (0,0,0),
    MASSCOLOR (229, 170, 112),
    FOUND(135, 206, 235),
    FALL(0, 127, 255),
    CHARTFOUND (88, 86, 214),
    CHARTFALL(255, 59, 48),
    GREEN(76, 217, 100),
    LIGHTBLUE (0, 153, 204);

    private final int r;
    private final int g;
    private final int b;
    private final String rgb;

    private DataColors(final int r,final int g,final int b) {
        this.r = r;
        this.g = g;
        this.b = b;
        this.rgb = r + ", " + g + ", " + b;
    }

    public String getRGB() {
        return rgb;
    }
    public int getARGB(){
        return 0xFF000000 | ((r << 16) & 0x00FF0000) | ((g << 8) & 0x0000FF00) | b;
    }
}
