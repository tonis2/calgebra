module calgebra::vec2;

struct Vec2 {
    float x;
    float y;
}


fn float[2] Vec2.toArray(Vec2* this)
{
    return float[2]{this.x, this.y};
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


fn float Vec2.dot(Vec2* first, Vec2* second)
{
    return (first.x * second.x) + (first.y * second.y);
}

fn Vec2 Vec2.normalize(Vec2* this)
{
    float magnitude = this.len();
   
    float x = this.x / magnitude;
    float y = this.y / magnitude;

    return Vec2 {x, y };
}

fn float Vec2.len(Vec2* this) {
    return $$sqrt(this.dot(this));
}

fn float Vec2.distance(Vec2* this, Vec2 target) {
    return $$sqrt((this.x - this.y) * (this.x - this.y) + (target.x - target.y) * (target.x - target.y));
}


fn Vec2 Vec2.rotate(Vec2* this, float f) {
    float cs = $$cos(f);
	float sn = $$sin(f);
    return Vec2 {this.x * cs - this.y * sn, this.x * sn + this.y * cs};
}


