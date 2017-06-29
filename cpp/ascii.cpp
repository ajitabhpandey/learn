/**
 * ascii.cpp
 * Program to print all capital and small alphabets using their ascii values
 * Ajitabh Pandey
*/
#include<iostream>
using namespace std;


int main() {
  for (int i=65,j=97;i<(65+26), j<(97+26);i++,j++) {
    cout << i << " => " << (char) i << "\t" << j << " => " << (char) j << "\n";
  }

  return 0;
}
