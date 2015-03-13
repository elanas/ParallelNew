// import java.util.concurrent.*;
// import java.util.Random.*;
import java.util.concurrent.ThreadLocalRandom;
import java.io.FileWriter;


public class CoinFlip implements Runnable {

    int thread_id;
    int numThreadFlips;
    int numHeads;
    static int totalHeads;

    public void run ()
    {
        //System.out.println ( thread_id + ": Running thread with " + numThreadFlips + " flips." );
        for (int x = 0; x < numThreadFlips; x++) {
            if(flip() == 0) {
                numHeads++;
            }
        }
        increment(numHeads);
    }

    public int getHeads() {
        return numHeads;
    }

    public static synchronized void increment(int n) {
        totalHeads += n;
    }

    public int flip() {
        ThreadLocalRandom random = ThreadLocalRandom.current(); 
        return random.nextInt(2);
    }

    public CoinFlip(int id, int numThreadFlips) {
        this.thread_id = id;
        this.numThreadFlips = numThreadFlips;
        this.numHeads = 0;
    }

    public static void main (String [] args) {

        FileWriter f = null;

        try {
            f = new FileWriter("startup.csv", true);
            // f.append("Time, Test");
        } catch (Exception e) {
            System.out.println("file exception");
        }

        if(args.length != 2) {
            System.out.println("\nUsage: CoinFlip #thread #iterations\n");
            return;
        }

        int numThreads = Integer.parseInt(args[0]);
        int numFlips = Integer.parseInt(args[1]);
        Thread [] threads;

        threads = new Thread[numThreads];

        int d = numFlips/numThreads;
        int r = numFlips%numThreads;

        long t1 = System.currentTimeMillis();


        for(int x = 0; x < numThreads; x++) {
            int threadFlips = d;
            if (x < r) {
                threadFlips++;
            }

            threads[x] = new Thread(new CoinFlip(x+1, threadFlips));
            threads[x].start();
        }
        
        int heads = 0;

        for (int x = 0; x < threads.length; x ++) {
            try {
                // heads += threads[x].getHeads();
                threads[x].join();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        long t2 = System.currentTimeMillis() - t1;

        System.out.println("\n" + totalHeads + " heads in " + numFlips + " coin tosses.");
        System.out.println("Total elapsed time: " + t2 + "ms");

        try {
            f.append(Long.toString(t2) + "\n");
            f.flush();
            f.close();

        } catch (Exception e) {

        }
    }
}
