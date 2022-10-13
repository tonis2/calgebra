module vec2;

struct Vec2 {
    double x;
    double y;
}


fn double[2] Vec2.toArray(Vec2* this)
{
    return double[2]{this.x, this.y};
}


fn Vec2 Vec2.add(Vec2* first, Vec2* second)
{
    return Vec2 {first.x + second.x, first.y + second.y};
}

fn Vec2 Vec2.subtract(Vec2* first, Vec2* second)
{
    return Vec2 {first.x - second.x, first.y - second.y};
}


fn Vec2 Vec2.multiply(Vec2* first, Vec2* second)
{
    return Vec2 {first.x * second.x, first.y * second.y};
}

fn Vec2 Vec2.divide(Vec2* first, Vec2* second)
{
    return Vec2 {first.x / second.x, first.y / second.y};
}


fn double Vec2.dot(Vec2* first, Vec2* second)
{
    return (first.x * second.x) + (first.y * second.y);
}

fn Vec2 Vec2.normalize(Vec2* this)
{
    double magnitude = this.len();
   
    double x = this.x / magnitude;
    double y = this.y / magnitude;

    return Vec2 {x, y };
}

fn double Vec2.len(Vec2* this) {
    return $$sqrt(this.dot(this));
}

fn double Vec2.distance(Vec2* this, Vec2 target) {
    return $$sqrt((this.x - this.y) * (this.x - this.y) + (target.x - target.y) * (target.x - target.y));
}


fn Vec2 Vec2.rotate(Vec2* this, float f) {
    float cs = $$cos(f);
	float sn = $$sin(f);
    return Vec2 {this.x * cs - this.y * sn, this.x * sn + this.y * cs};
}


