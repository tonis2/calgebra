import vector;
import std;

fn double round(double value) {
  return $$ceil(value * 100) / 100;
}

fn int main() {

  /*
  * Test Vec3
  */

  Vec3 vec = Vec3{1.5, 2.6, 3.7};

  double len = vec.len();

  assert(round(len) == 4.770000);

  Vec3 normal = vec.normalize();

  double x = 0.801784;

  io::printf("%f\n", normal.x);
  io::printf("%f\n", x);
  io::printf("%d\n", normal.x == x);

  
  // assert(vec.y == 0.267261);
  // assert(vec.z == 0.534522);

  return 0;
}