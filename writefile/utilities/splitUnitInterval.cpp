#include<iostream>

int main(int argc, char* argv[]){
  const double XMIN = 0.0;
  const double XMAX = 1.0;
  int       nely;

  std::cout << "Enter the number of elements in the wall normal direction: nely = ";
  std::cin >> nely;

  double dx = (XMAX - XMIN)/(nely);

  for(int i = 0; i <= nely; i++){
    std::cout << XMIN + i*dx << " ";
  }
  std::cout << std::endl;
}
