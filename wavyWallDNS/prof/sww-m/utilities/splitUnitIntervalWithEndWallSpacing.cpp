#include<iostream>
#include<cmath>

int main(int argc, char* argv[]){
  int       nely;

  std::cout << "Enter the number of elements in the wall normal direction: nely = ";
  std::cin >> nely;

  double dtheta = M_PI/(nely);

  for(int i = 0; i <= nely; i++){
    std::cout << (1.0 - cos(i*dtheta))/2.0 << " ";
  }
  std::cout << std::endl;
}
