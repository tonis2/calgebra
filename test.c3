import vec2;
import vec3;
import vec4;
import mat4;
import std;

fn double round(double value) {
  return $$ceil(value * 100) / 100;
}

fn int main() {

  // Vec3 vec = Vec3{1.5, 2.6, 3.7};

  // double len = vec.len();



  // Vec3 normal = vec.normalize();

  // double x = 0.801784;

  // io::printf("%f\n", normal.x);
  // io::printf("%f\n", x);
  // io::printf("%d\n", normal.x == x);

 // Magnitude

 {
  Vec3 vec = Vec3{1.5, 2.6, 3.7};
  double len = vec.len();
  assert(round(len) == 4.770000);
 }


 // Adding
 {
   Vec3 vec1 = Vec3{5, 9, -10};
   Vec3 vec2 = Vec3{17, -3, -2};
   Vec3 total = vec1.add(&vec2);
   assert(total.x == 22);
   assert(total.y == 6);
   assert(total.z == -12);

 }


  // Subtract
 {
   Vec3 vec1 = Vec3{18, 5, 3};
   Vec3 vec2 = Vec3{10, 9, -10};
   Vec3 total = vec1.subtract(vec2);
   assert(total.x == 8);
   assert(total.y == -4);
   assert(total.z == 13);
 }

 /*
 * Matrix fuctions
 */

  Mat4x4 identity = mat4::identity();
  Mat4x4 ortho = mat4::orthographic(0, 600, 0, 600, 0.1, 100);
  Mat4x4 result = mat4::mul(identity, ortho);

  io::printf("%d \n", result.data[3][2]);
  
  return 0;
}