module vector;
import std;

struct Vec2 {
    double x;
    double y;
}

struct Vec3 {
    double x;
    double y;
    double z;
}

struct Vec4 {
    double x;
    double y;
    double z;
    double w;
}

fn Vec3 Vec3.up(Vec3* this)
{
    return Vec3 {0, 1, 0};
}

fn Vec3 Vec3.normalize(Vec3* this)
{
    double magnitude = this.len();
   
    double x = this.x / magnitude;
    double y = this.y / magnitude;
    double z = this.z / magnitude;

    return Vec3 {x, y, z};
}

fn Vec3 Vec3.zero(Vec3* this)
{
    return Vec3 {0, 0, 0};
}

fn Vec3 Vec3.forward(Vec3* this)
{
    return Vec3 {0, 0, 1};
}

fn Vec3 Vec3.back(Vec3* this)
{
    return Vec3 {0, 0, -1};
}

fn Vec3 Vec3.cross(Vec3* first, Vec3* second)
{
    double result_x = (first.y * second.z) - (first.z * second.y);
    double result_y = (first.z * second.x) - (first.x * second.z);
    double result_z = (first.x * second.y) - (first.y * second.x);

    return Vec3 {result_x, result_y, result_z};
}

fn double Vec3.len(Vec3* this) {
    return $$sqrt(this.dot(this));
}

fn double Vec3.dot(Vec3* first, Vec3* second)
{
    return (first.x * second.x) + (first.y * second.y) + (first.z * second.z);
}

fn Vec3 Vec3.add(Vec3* first, Vec3* second)
{
    return Vec3 {first.x + second.x, first.y + second.y, first.z + second.z};
}

fn Vec3 Vec3.subtract(Vec3* first, Vec3* second)
{
    return Vec3 {first.x - second.x, first.y - second.y, first.z - second.z};
}