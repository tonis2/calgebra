
import calgebra;
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


  // Cross products
 {
    Vec3 vec = Vec3{2, 3, 4};
    Vec3 vec2 = Vec3{5, 6, 7};
    Vec3 cross = vec3::cross(vec, vec2);
    assert(cross.x == -3);
    assert(cross.y == 6);
    assert(cross.z == -3);
 }
 
 // Adding
 {
   Vec3 vec1 = Vec3{5, 9, -10};
   Vec3 vec2 = Vec3{17, -3, -2};
   Vec3 total = vec3::add(vec1, vec2);
   assert(total.x == 22);
   assert(total.y == 6);
   assert(total.z == -12);

 }


  // Subtract
 {
   Vec3 vec1 = Vec3{18, 5, 3};
   Vec3 vec2 = Vec3{10, 9, -10};
   Vec3 total = vec3::subtract(vec1, vec2);
   assert(total.x == 8);
   assert(total.y == -4);
   assert(total.z == 13);
 }

 /*
 * Matrix functions
 */

  {
    Mat4x4 identity = mat4::identity();
    Mat4x4 result = Mat4x4 { 
        {
            { 1, 0, 0, 0 },
            { 0, 1, 0, 0 },
            { 0, 0, 1, 0 },
            { 0, 0, 0, 1 },
        }
        };

    assert(result.isEqual(identity)); 
  }

  {
    Mat4x4 translate = mat4::fromTranslate(Vec3{2,3,4});
    Mat4x4 result = Mat4x4 { 
              {{ 1, 0, 0, 0 },
               { 0, 1, 0, 0 },
               { 0, 0, 1, 0 },
               { 2, 3, 4, 1 }}
            };

    assert(result.isEqual(translate)); 
  }

  {
    Mat4x4 translate = mat4::fromTranslate(Vec3{2,3,2}).translate(Vec3{2, 3, 4});
    Mat4x4 result = Mat4x4 {
              {{ 1, 0, 0, 0 },
               { 0, 1, 0, 0 },
               { 0, 0, 1, 0 },
               { 4, 6, 6, 1 }}
            };

    assert(result.isEqual(translate)); 
  }

  // {
  //   Mat4x4 translate = mat4::lookAt(Vec3{0,0,-4}, Vec3{0,0,0}, Vec3{0,1,0});
  //   Mat4x4 result = Mat4x4 {
  //             {{ -1, 0, 0, 0 },
  //              { 0, 1, 0, 0 },
  //              { 0, 0, -1, 0 },
  //              { 0, 0, -4, 1 }}
  //           };

  //   assert(result.isEqual(translate)); 
  // }

  {
    Mat4x4 translate = mat4::perspective(45, 1.75, 0.1, 1000);
    Mat4x4 result = Mat4x4 {
              {{ 1.379551, 0, 0, 0 },
               { 0, 2.414214, 0, 0 },
               { 0, 0, -1.000200, -1 },
               { 0, 0, -0.200020, 0 }}
            };

    assert(result.isEqual(translate)); 
  }


  
  return 0;
}