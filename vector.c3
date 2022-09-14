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

fn void Vec3.normalize(Vec3* this)
{
    double magnitude = $$sqrt((this.x * this.x) + (this.y * this.y) + (this.z * this.z));
   
    this.x = this.x / magnitude;
    this.y = this.y / magnitude;
    this.z = this.z / magnitude;
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