module calgebra::mat4;
import calgebra::vec3;
import calgebra::vec4;
import calgebra;
import std::math;
import std::io;

fn float round(float value) {
  return $$ceil(value * 100) / 100;
}


fn float toRadians(float value) {
    return value * math::PI / 180;
}

struct Mat4x4 {
    float[4][4] data;
}

fn Mat4x4 identity() {
    return Mat4x4 {
        {
            { 1, 0, 0, 0 },
            { 0, 1, 0, 0 },
            { 0, 0, 1, 0 },
            { 0, 0, 0, 1 },
        }
        };
}

fn Mat4x4 zero() {
    return Mat4x4 {
        {
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
        }
        };
}


fn Vec4 Mat4x4.mulByVec4(Mat4x4* this, Vec4 v) {
   float x = (this.data[0][0] * v.x) + (this.data[1][0] * v.y) + (this.data[2][0] * v.z) + (this.data[3][0] * v.w);
   float y = (this.data[0][1] * v.x) + (this.data[1][1] * v.y) + (this.data[2][1] * v.z) + (this.data[3][1] * v.w);
   float z = (this.data[0][2] * v.x) + (this.data[1][2] * v.y) + (this.data[2][2] * v.z) + (this.data[3][2] * v.w);
   float w = (this.data[0][3] * v.x) + (this.data[1][3] * v.y) + (this.data[2][3] * v.z) + (this.data[3][3] * v.w);

   return Vec4 { x, y, z, w};
}


fn bool Mat4x4.isEqual(Mat4x4 this, Mat4x4 other) {
    bool equal = true;

    foreach (column, value: this.data) 
        {
            foreach (row, value2: this.data[column]) { 
                // For debugging
                // io::printf("Col: %d, Row: %d, first %f second %f\n", column + 1, row + 1, this.data[column][row], other.data[column][row]);
                if (round(this.data[column][row]) !=  round(other.data[column][row])) {
                    equal = false;
                };
            }
        }
    return equal;
}

fn Mat4x4 fromTranslate(Vec3 axis) {
    Mat4x4 result = identity();
    result.data[3][0] = axis.x;
    result.data[3][1] = axis.y;
    result.data[3][2] = axis.z;

    return result;
}

fn Mat4x4 Mat4x4.translate(Mat4x4 this, Vec3 axis) {
    Mat4x4 translate = fromTranslate(axis);
    return this.mul(translate);
}

fn Mat4x4 projection(float width, float height, float depth) {
    return Mat4x4{
        {
            { 2 / width, 0, 0, 0 },
            { 0, -2 / height, 0, 0 },
            { 0, 0, 2 / depth, 0 },
            { -1, 1, 0, 1 },
        }
    };
}


fn Mat4x4 perspective(float fovy_in_degrees, float aspect_ratio, float near, float far) {
    float f = 1.0 / (float)calgebra::tan(toRadians(fovy_in_degrees) / 2);

    float range_inv = (float)(1.0 / (double)(near - far));

    return Mat4x4 {
        {
            { f / aspect_ratio, 0, 0, 0 },
            { 0, f, 0, 0 },
            { 0, 0, (near + far) * range_inv, -1 },
            { 0, 0, far * near * range_inv  * 2, 0 },
        }
    };
}

fn Mat4x4 orthographic(float left, float right, float bottom, float top, float near, float far) {
    float lr =  1 / (left - right);
    float bt =  1 / (bottom - top);
    float nf =  1 / (near - far);

    return Mat4x4 {
        {
            { -2 * lr, 0, 0, 0 },
            { 0, -2 * bt, 0, 0 },
            { 0, 0, 2 * nf, 0 },
            { (left + right) * lr, (top + bottom) * bt, (far + near) * nf, 0 },
        }
    };
}


fn Mat4x4 lookAt(Vec3 eye, Vec3 target, Vec3 upDir) {
    Vec3 forward = vec3::subtract(target, eye).normalize();
    Vec3 left = vec3::cross(forward, upDir).normalize();
    Vec3 up = vec3::cross(forward, left);

    return Mat4x4{{ 
                    { left.x, up.x, forward.x, 0},
                    { left.y, up.y, forward.y, 0},
                    { left.z, up.z, forward.z, 0},
                    { -vec3::dot(left, eye), -vec3::dot(up, eye), vec3::dot(forward, eye), 1 }
                  }};
}


fn Mat4x4 fromRotate(float angle_in_degrees, Vec3 axis) {
    Mat4x4 result = identity();

    Vec3 norm_axis = axis.normalize();

    float sin_theta = $$sin(toRadians(angle_in_degrees));
    float cos_theta = $$cos(toRadians(angle_in_degrees));
    float cos_value = 1 - cos_theta;

    float x = norm_axis.x;
    float y = norm_axis.y;
    float z = norm_axis.z;

    result.data[0][0] = (x * x * cos_value) + cos_theta;
    result.data[0][1] = (x * y * cos_value) + (z * sin_theta);
    result.data[0][2] = (x * z * cos_value) - (y * sin_theta);

    result.data[1][0] = (y * x * cos_value) - (z * sin_theta);
    result.data[1][1] = (y * y * cos_value) + cos_theta;
    result.data[1][2] = (y * z * cos_value) + (x * sin_theta);

    result.data[2][0] = (z * x * cos_value) + (y * sin_theta);
    result.data[2][1] = (z * y * cos_value) - (x * sin_theta);
    result.data[2][2] = (z * z * cos_value) + cos_theta;

    return result;
}

fn void Mat4x4.rotate(Mat4x4* this, float angle_in_degrees, Vec3 axis) {
    Vec3 norm_axis = axis.normalize();

    float sin_theta = $$sin(toRadians(angle_in_degrees));
    float cos_theta = $$cos(toRadians(angle_in_degrees));
    float cos_value = 1 - cos_theta;

    float x = norm_axis.x;
    float y = norm_axis.y;
    float z = norm_axis.z;

    this.data[0][0] = (x * x * cos_value) + cos_theta;
    this.data[0][1] = (x * y * cos_value) + (z * sin_theta);
    this.data[0][2] = (x * z * cos_value) - (y * sin_theta);

    this.data[1][0] = (y * x * cos_value) - (z * sin_theta);
    this.data[1][1] = (y * y * cos_value) + cos_theta;
    this.data[1][2] = (y * z * cos_value) + (x * sin_theta);

    this.data[2][0] = (z * x * cos_value) + (y * sin_theta);
    this.data[2][1] = (z * y * cos_value) - (x * sin_theta);
    this.data[2][2] = (z * z * cos_value) + cos_theta;
}


fn Mat4x4 fromScale(Vec3 scale) {
   Mat4x4 result = identity();
   result.data[0][0] = scale.x;
   result.data[1][1] = scale.y;
   result.data[2][2] = scale.z;
   return result;
}

fn Mat4x4 rotateWith(Mat4x4 value, float angle_in_degrees, Vec3 axis) {
    Vec3 norm_axis = axis.normalize();

    float sin_theta = $$sin(toRadians(angle_in_degrees));
    float cos_theta = $$cos(toRadians(angle_in_degrees));
    float cos_value = 1 - cos_theta;

    float x = norm_axis.x;
    float y = norm_axis.y;
    float z = norm_axis.z;

    value.data[0][0] = (x * x * cos_value) + cos_theta;
    value.data[0][1] = (x * y * cos_value) + (z * sin_theta);
    value.data[0][2] = (x * z * cos_value) - (y * sin_theta);

    value.data[1][0] = (y * x * cos_value) - (z * sin_theta);
    value.data[1][1] = (y * y * cos_value) + cos_theta;
    value.data[1][2] = (y * z * cos_value) + (x * sin_theta);

    value.data[2][0] = (z * x * cos_value) + (y * sin_theta);
    value.data[2][1] = (z * y * cos_value) - (x * sin_theta);
    value.data[2][2] = (z * z * cos_value) + cos_theta;

    return value;
}


fn Mat4x4 mul(Mat4x4 left, Mat4x4 right) {
        Mat4x4 result = identity();

        foreach (column, value: result.data) 
        {
            foreach (row, value2: result.data[column]) {
                float sum = 0;

                foreach (left_column, value3: left.data) {
                    sum += left.data[left_column][row] * right.data[column][left_column];   
                }

                result.data[column][row] = sum;
            }
        }

        return result;
}


fn Mat4x4 Mat4x4.mul(Mat4x4 this, Mat4x4 right) {
    return mul(this, right);
}