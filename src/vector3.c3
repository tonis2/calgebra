module calgebra::vec3;

struct Vec3 {
    float x;
    float y;
    float z;
}


fn float[3] Vec3.toArray(Vec3* this)
{
    return float[3]{this.x, this.y, this.z};
}

fn Vec3 up()
{
    return Vec3 {0, 1, 0};
}

fn Vec3 Vec3.normalize(Vec3* this)
{
    float magnitude = this.len();

    if (magnitude > 0.00001) {
        float x = this.x / magnitude;
        float y = this.y / magnitude;
        float z = this.z / magnitude;
        return Vec3 {x, y, z};
    } else {
        return Vec3{ 0, 0, 0 };
    }
}

fn Vec3 zero()
{
    return Vec3 {0, 0, 0};
}

fn Vec3 forward(Vec3* this)
{
    return Vec3 {0, 0, 1};
}

fn Vec3 back(Vec3* this)
{
    return Vec3 {0, 0, -1};
}

fn Vec3 cross(Vec3 first, Vec3 second)
{
    float result_x = (first.y * second.z) - (first.z * second.y);
    float result_y = (first.z * second.x) - (first.x * second.z);
    float result_z = (first.x * second.y) - (first.y * second.x);

    return Vec3 {result_x, result_y, result_z};
}

fn float Vec3.len(Vec3 this) {
    return $$sqrt(dot(this, this));
}

fn float dot(Vec3 first, Vec3 second)
{
    return (first.x * second.x) + (first.y * second.y) + (first.z * second.z);
}

fn Vec3 add(Vec3 first, Vec3 second)
{
    return Vec3 {first.x + second.x, first.y + second.y, first.z + second.z};
}

fn Vec3 subtract(Vec3 first, Vec3 second)
{
    return Vec3 {first.x - second.x, first.y - second.y, first.z - second.z};
}

fn Vec3 Vec3.multiply(Vec3 first, Vec3 second)
{
    return Vec3 {first.x * second.x, first.y * second.y, first.z * second.z};
}

fn Vec3 Vec3.divide(Vec3 first, Vec3 second)
{
    return Vec3 {first.x / second.x, first.y / second.y, first.z / second.z};
}
