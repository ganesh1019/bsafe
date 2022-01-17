package tests;

import org.junit.Assert;
import org.junit.Test;

import java.io.*;
public class BSafeTests {

    @Test
    public void test1() {
        System.out.println("Tests for BSafe Application - TEST 1");
        System.out.println("Running Tests...");
        Assert.assertEquals(2+2,4);
    }
    @Test
    public void test2() {
        System.out.println("Tests for BSafe Application - TEST 2");
        System.out.println("Running Tests...");
        Assert.assertEquals(2+3,5);
    }

    @Test
    public void test3() {
        System.out.println("Tests for BSafe Application - TEST 3");
        System.out.println("Running Tests...");
        Assert.assertEquals(2+6,8);
    }


}
