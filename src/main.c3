
import calgebra;
import std;

fn double round(double value) {
  return $$ceil(value * 100) / 100;
}

fn int main() {

  calgebra::vec3::Vec3 vec = calgebra::vec3::Vec3{1.5, 2.6, 3.7};

  double len = vec.len();
  calgebra::vec3::Vec3 normal = vec.normalize();

  double x = 0.801784;

  io::printf("%f\n", normal.x);
  io::printf("%f\n", x);
  io::printf("%d\n", normal.x == x);

  return 0;
}