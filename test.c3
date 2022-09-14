import vector;
import std;


fn int main() {


  /*
  * Test Vec3
  */

  Vec3 vec = Vec3{3, 1, 2};

  assert(vec.x == 3);
  assert(vec.y == 1);
  assert(vec.z == 2);

  vec.normalize();

  double x = 0.801784;

  io::printf("%f\n", vec.x);
  io::printf("%f\n", x);
  io::printf("%d\n", vec.x == x);

  assert(vec.x == x);

  
  // assert(vec.y == 0.267261);
  // assert(vec.z == 0.534522);

  return 0;
}