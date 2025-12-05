import java.util.Random;
import java.util.Scanner;

class Logger {
    public static final String RESET = "\u001B[0m";
    public static final String RED = "\u001B[31m";
    public static final String GREEN = "\u001B[32m";
    public static final String YELLOW = "\u001B[33m";
    public static final String CYAN = "\u001B[36m";
    public static final String PURPLE = "\u001B[35m";

    public static void info(String msg) {
        System.out.println(CYAN + msg + RESET);
    }

    public static void success(String msg) {
        System.out.println(GREEN + msg + RESET);
    }

    public static void warning(String msg) {
        System.out.println(YELLOW + msg + RESET);
    }

    public static void danger(String msg) {
        System.out.println(RED + msg + RESET);
    }

    public static void action(String msg) {
        System.out.println(PURPLE + msg + RESET);
    }
}

enum Race {
    HUMANO(100, 70, 70),
    ELFO(80, 120, 50),
    ANAO(120, 80, 100),
    ORC(150, 90, 100);

    Race(int vida, int forca, int defesa) {
        this.vida = vida;
        this.forca = forca;
        this.defesa = defesa;
    }

    private final int vida;
    private final int forca;
    private final int defesa;

    public int getDefesa() {
        return defesa;
    }

    public int getForca() {
        return forca;
    }

    public int getVida() {
        return vida;
    }
}

abstract class BaseEntity {
    private String name;
    private Race race;
    private int vida;
    private int vidaMaxima;
    private int forca;
    private int defesa;
    private int xp;

    public BaseEntity(String name, Race race, int vida, int forca, int defesa, int xp) {
        this.name = name;
        this.race = race;
        this.vida = vida;
        this.vidaMaxima = vida;
        this.forca = forca;
        this.defesa = defesa;
        this.xp = xp;
    }

    public int getVida() {
        return vida;
    }

    public void setVida(int vida) {
        this.vida = vida;
    }

    public int getVidaMaxima() {
        return vidaMaxima;
    }

    public int getForca() {
        return forca;
    }

    public int getDefesa() {
        return defesa;
    }

    public int getXp() {
        return xp;
    }

    public void setXp(int xp) {
        this.xp = xp;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return this.name;
    }

    public String getRaceName() {
        return this.race.name();
    }

    public String getNameAndRaceName() {
        return this.name + "(" + this.race.name() + ")";
    }

    // * Actions
    public void restaurarVidaTotal() {
        this.vida = this.vidaMaxima;
    }

    public void levelUp(double increase) {
        this.xp++;
        this.vidaMaxima += (int) (this.vidaMaxima * increase);
        this.vida = this.vidaMaxima;
        this.forca += (int) (this.forca * increase);
        this.defesa += (int) (this.defesa * increase);
        Logger.success("✨ PARABÉNS! " + this.name + " subiu para o nível " + this.xp + "!");
    }

    public String showStats() {
        return "HP: " + this.vida + "(" + this.vidaMaxima + ")" +
                " | FORCA: " + this.forca +
                " | DEFESA: " + this.defesa +
                " | XP: " + this.xp;
    }

    public int attack() {
        int critico = (Math.random() < 0.2) ? 2 : 1;
        int damage = this.forca * critico;
        Logger.action("⚔️ " + this.name + " atacou causando " + damage + " de dano" + (critico > 1 ? " (CRÍTICO!)" : ""));
        return damage;
    }

    public int defend(int damage) {
        int reduction = (int) (this.defesa * 0.25);

        int finalDamage = Math.max(0, damage - reduction);

        this.setVida(this.vida - finalDamage);

        Logger.warning("🛡️ " + this.name + " defendeu e recebeu " + finalDamage + " de dano!");

        return (this.vida <= 0) ? 1 : 0;
    }

}

class Player extends BaseEntity {
    public Player(String name, Race race, int xp) {
        super(name, race, race.getVida(), race.getForca(), race.getDefesa(), xp);
    }
}

class EnemyData {
    Race race;
    int vida;
    int forca;
    int defesa;
    int xp;

    public EnemyData(Race race, int vida, int forca, int defesa, int xp) {
        this.race = race;
        this.vida = vida;
        this.forca = forca;
        this.defesa = defesa;
        this.xp = xp;
    }
}

class Enemy extends BaseEntity {
    public Enemy(EnemyData data) {
        super(data.race.name(), data.race, data.vida, data.forca, data.defesa, data.xp);
    }
}

class Battle {
    private Player player;
    private Enemy enemy;

    public Battle(Player player, Enemy enemy) {
        this.player = player;
        this.enemy = enemy;
    }

    public boolean start() {
        Scanner scanner = new Scanner(System.in);

        Logger.info("🔥 Um " + enemy.getName() + " apareceu!");
        while (player.getVida() > 0 && enemy.getVida() > 0) {
            System.out.println("Voce: " + player.showStats() +
                    "\nInimigo: " + enemy.showStats());
            System.out.println("[1] Atacar | [2] Defender | [3] Fugir");
            int escolha = scanner.nextInt();
            boolean playerDefend = new Random().nextBoolean();

            int enemyChoice = new Random().nextInt(2) + 1;
            boolean enemyDefend = enemyChoice == 2 && new Random().nextBoolean();


            if (escolha == 1) {
                int dano = enemyDefend ? (player.attack()/2) : player.attack();
                if (enemy.defend(dano) == 1) {
                    Logger.success("🎉 Você derrotou o " + enemy.getName() + "!");
                    player.levelUp(0.2);
                    return true;
                }
            } else if (escolha == 2) {
                Logger.info("Você se prepara para defender" + (playerDefend ? " e DEFESA CRITICA!" : " normal.") );
            } else if (escolha == 3) {
                Logger.warning("🏃 Você fugiu da batalha!");
                return false;
            }

            if (enemyChoice == 1) {
                int danoInimigo = playerDefend ? enemy.attack() / 2 : enemy.attack();
                if( player.defend(danoInimigo) == 1) {
                    Logger.danger("💀 Você foi derrotado!");
                    System.exit(0);
                }
            } else if (enemyChoice == 2){
                Logger.info("O Inimigo se prepara para defender!"+ (enemyDefend ? " e DEFESA CRITICA!" : " normal.") );
            }
        }
        return false;
    }
}

class Game {
    private Player player;

    private EnemyData generateEnemyParams(int playerLevel, double increase) {
        Race[] races = Race.values();
        Race enemyRace = races[new Random().nextInt(races.length)];

        int xp = new Random().nextInt((playerLevel + 3)) + playerLevel;
        int vida = (int) (enemyRace.getVida() + (enemyRace.getVida() * (xp * increase)));
        int forca = (int) (enemyRace.getForca() + (enemyRace.getForca() * (xp * increase)));
        int defesa = (int) (enemyRace.getDefesa() + (enemyRace.getDefesa() * (xp * increase)));
        return new EnemyData(enemyRace, vida, forca, defesa, xp);
    }

    public void start() {
        double statsIncrease = .2;
        Scanner scanner = new Scanner(System.in);
        Logger.info("🏰 Bem-vindo ao RPG GAME 2000!");

        System.out.print("Digite o nome do seu personagem: ");
        String name = scanner.nextLine();

        System.out.print("Escolha sua raça (HUMANO, ORC, ELFO, ANAO): ");
        Race race = Race.valueOf(scanner.nextLine().toUpperCase());

        player = new Player(name, race, 1);
        Logger.success("✨ Personagem criado: " + player.showStats());

        while (true) {
            Enemy enemy = new Enemy(generateEnemyParams(player.getXp(), statsIncrease));
            new Battle(player, enemy).start();
        }
    }
}

public class Main {
    public static void main(String[] args) {
        new Game().start();
    }
}
