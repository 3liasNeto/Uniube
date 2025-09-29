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

interface CombatEntity {
    GameEntityStats getStats();
    String getName();
    int attack();
    int defend(int damage);
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

    public int getDefesa() { return defesa; }
    public int getForca() { return forca; }
    public int getVida() { return vida; }
}


class GameEntityStats {
    private int vida;
    private int vidaMaxima;
    private int forca;
    private int defesa;
    private int xp;

    public GameEntityStats(int vida, int forca, int defesa, int xp) {
        this.vida = vida;
        this.vidaMaxima = vida;
        this.forca = forca;
        this.defesa = defesa;
        this.xp = xp;
    }

    public int getVida() { return vida; }
    public void setVida(int vida) { this.vida = vida; }
    public int getVidaMaxima() { return vidaMaxima; }
    public int getForca() { return forca; }
    public int getDefesa() { return defesa; }
    public int getXp() { return xp; }
    public void setXp(int xp) { this.xp = xp; }

    public void restaurarVidaTotal() { this.vida = this.vidaMaxima; }

    public void levelUp(double increase) {
        this.xp++;
        this.vidaMaxima += (int) (this.vidaMaxima * increase);
        this.vida = this.vidaMaxima;
        this.forca += (int) (this.forca * increase);
        this.defesa += (int) (this.defesa * increase);
    }

    public String showStats() {
        return "HP: " + this.vida + "(" + this.vidaMaxima + ")" +
                " | FORCA: " + this.forca +
                " | DEFESA: " + this.defesa +
                " | XP: " + this.xp;
    }

}

class Player implements CombatEntity {
    private String name;
    private Race race;
    private GameEntityStats stats;

    public Player(String name, Race race) {
        this.name = name;
        this.race = race;
        this.stats = new GameEntityStats(
                race.getVida(), race.getForca(), race.getDefesa(), 1
        );
    }

    public void levelUp(double increase) {
        Logger.success("✨ PARABÉNS! " + this.name + " subiu para o nível " + (this.stats.getXp() + 1) + "!");
        stats.levelUp(increase);
    }

    @Override
    public GameEntityStats getStats() { return stats; }

    @Override
    public String getName() { return name + " (" + race.name() + ")"; }

    @Override
    public int attack() {
        int critico = (Math.random() < 0.2) ? 2 : 1;
        int damage = this.stats.getForca() * critico;
        Logger.action("⚔️ " + this.getName() + " atacou causando " + damage + " de dano" + (critico > 1 ? " (CRÍTICO!)" : ""));
        return damage;
    }

    @Override
    public int defend(int damage) {
            int reduction = (int) (this.stats.getDefesa() * 0.25);

            int finalDamage = Math.max(0, damage - reduction);

            this.stats.setVida(this.stats.getVida() - finalDamage);

            Logger.warning("🛡️ " + this.getName() + " defendeu e recebeu " + finalDamage + " de dano!");

            return (this.stats.getVida() <= 0) ? 1 : 0;
    }
}

class Enemy implements CombatEntity {
    private Race race;
    private GameEntityStats stats;

    public Enemy(int playerLevel, double increase) {
        Race[] races = Race.values();
        this.race = races[new Random().nextInt(races.length)];

        int xp = (int) (Math.random() * (playerLevel + 3) + 1);
        int vida = (int) (race.getVida() + (race.getVida() * (xp * increase)));
        int forca = (int) (race.getForca() + (race.getForca() * (xp * increase)));
        int defesa = (int) (race.getDefesa() + (race.getDefesa() * (xp * increase)));

        this.stats = new GameEntityStats(vida, forca, defesa, xp);
    }

    @Override
    public GameEntityStats getStats() { return stats; }

    @Override
    public String getName() { return "Inimigo " + race.name(); }

    @Override
    public int attack() {
        int critico = (Math.random() < 0.15) ? 2 : 1;
        int damage = this.stats.getForca() * critico;
        Logger.danger("😈 " + this.getName() + " atacou com " + damage + " de dano" + (critico > 1 ? " (CRÍTICO!)" : ""));
        return damage;
    }

    @Override
    public int defend(int damage) {
        int reduction = (int) (this.stats.getDefesa() * 0.25);

        int finalDamage = Math.max(0, damage - reduction);

        this.stats.setVida(this.stats.getVida() - finalDamage);

        Logger.warning("🛡️ " + this.getName() + " defendeu e recebeu " + finalDamage + " de dano!");

        return (this.stats.getVida() <= 0) ? 1 : 0;
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
        while (player.getStats().getVida() > 0 && enemy.getStats().getVida() > 0) {
            System.out.println("Voce: " + player.getStats().showStats()  +
                    "\nInimigo: " + enemy.getStats().showStats());
            System.out.println("[1] Atacar | [2] Defender | [3] Fugir");
            int escolha = scanner.nextInt();

            if (escolha == 1) {
                int dano = player.attack();
                if (enemy.defend(dano) == 1) {
                    Logger.success("🎉 Você derrotou o " + enemy.getName() + "!");
                    player.levelUp(0.2);
                    return true;
                }
            } else if (escolha == 2) {
                Logger.info("Você se prepara para defender!");
            } else if (escolha == 3) {
                Logger.warning("🏃 Você fugiu da batalha!");
                return false;
            }

            int danoInimigo = enemy.attack();
            if (player.defend(danoInimigo) == 1) {
                Logger.danger("💀 Você foi derrotado!");
                System.exit(0);
            }
        }
        return false;
    }
}

class Game {
    private Player player;

    public void start() {
        Scanner scanner = new Scanner(System.in);
        Logger.info("🏰 Bem-vindo ao RPG GAME 2000!");

        System.out.print("Digite o nome do seu personagem: ");
        String name = scanner.nextLine();

        System.out.print("Escolha sua raça (HUMANO, ORC, ELFO, ANAO): ");
        Race race = Race.valueOf(scanner.nextLine().toUpperCase());

        player = new Player(name, race);
        Logger.success("✨ Personagem criado: " + player.getStats().showStats());

        while (true) {
            Enemy enemy = new Enemy(player.getStats().getXp(), 0.2);
            new Battle(player, enemy).start();
        }
    }
}

public class Main {
    public static void main(String[] args) {
        new Game().start();
    }
}
