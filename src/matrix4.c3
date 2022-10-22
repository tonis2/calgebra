module calgebra::mat4;
import calgebra::vec3;
import calgebra::vec4;
import std::math;

fn double toRadians(double value) {
    return value * math::PI / 180;
}

macro tan(x) = $$sin(x) / $$cos(x);
 
struct Mat4x4 {
    double[4][4] data;
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
   double x = (this.data[0][0] * v.x) + (this.data[1][0] * v.y) + (this.data[2][0] * v.z) + (this.data[3][0] * v.w);
   double y = (this.data[0][1] * v.x) + (this.data[1][1] * v.y) + (this.data[2][1] * v.z) + (this.data[3][1] * v.w);
   double z = (this.data[0][2] * v.x) + (this.data[1][2] * v.y) + (this.data[2][2] * v.z) + (this.data[3][2] * v.w);
   double w = (this.data[0][3] * v.x) + (this.data[1][3] * v.y) + (this.data[2][3] * v.z) + (this.data[3][3] * v.w);

   return Vec4 { x, y, z, w};
}


fn Mat4x4 fromTranslate(Vec3 axis) {
    Mat4x4 result = identity();
    result.data[3][0] = axis.x;
    result.data[3][1] = axis.y;
    result.data[3][2] = axis.z;

    return result;
}


fn Mat4x4 perspective(double fovy_in_degrees, double aspect_ratio, double z_near, double z_far) {
    Mat4x4 result = identity();

    double f = 1 / tan(toRadians(fovy_in_degrees) * 0.5);

    result.data[0][0] = f / aspect_ratio;
    result.data[1][1] = f;
    result.data[2][2] = (z_near + z_far) / (z_near - z_far);
    result.data[2][3] = -1;
    result.data[3][2] = 2 * z_far * z_near / (z_near - z_far);
    result.data[3][3] = 0;

    return result;
}

fn Mat4x4 orthographic(double left, double right, double bottom, double top, double z_near, double z_far) {
    Mat4x4 result = zero();

    result.data[0][0] = 2 / (right - left);
    result.data[1][1] = 2 / (top - bottom);
    result.data[2][2] = 2 / (z_near - z_far);
    result.data[3][3] = 1;

    result.data[3][0] = (left + right) / (left - right);
    result.data[3][1] = (bottom + top) / (bottom - top);
    result.data[3][2] = (z_far + z_near) / (z_near - z_far);

    return result;
}


fn Mat4x4 Mat4x4.lookAt(Mat4x4* this, Vec3 eye, Vec3 target, Vec3 up) {
    Vec3 f = Vec3.subtract(target, eye).normalize();
    Vec3 s = vec3::cross(f, up).normalize();
    Vec3 u = vec3::cross(s, f);

    Mat4x4 result;
    result.data[0][0] = s.x;
    result.data[0][1] = u.x;
    result.data[0][2] = -f.x;
    result.data[0][3] = 0;

    result.data[1][0] = s.y;
    result.data[1][1] = u.y;
    result.data[1][2] = -f.y;
    result.data[1][3] = 0;

    result.data[2][0] = s.z;
    result.data[2][1] = u.z;
    result.data[2][2] = -f.z;
    result.data[2][3] = 0;

    result.data[3][0] = -vec3::dot(s, eye);
    result.data[3][1] = -vec3::dot(u, eye);
    result.data[3][2] = vec3::dot(f, eye);
    result.data[3][3] = 1;

    return result;
}


fn Mat4x4 fromRotation(double angle_in_degrees, Vec3 axis) {
    Mat4x4 result = identity();

    Vec3 norm_axis = axis.normalize();

    double sin_theta = $$sin(toRadians(angle_in_degrees));
    double cos_theta = $$cos(toRadians(angle_in_degrees));
    double cos_value = 1 - cos_theta;

    double x = norm_axis.x;
    double y = norm_axis.y;
    double z = norm_axis.z;

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

fn void Mat4x4.rotate(Mat4x4* this, double angle_in_degrees, Vec3 axis) {
    Vec3 norm_axis = axis.normalize();

    double sin_theta = $$sin(toRadians(angle_in_degrees));
    double cos_theta = $$cos(toRadians(angle_in_degrees));
    double cos_value = 1 - cos_theta;

    double x = norm_axis.x;
    double y = norm_axis.y;
    double z = norm_axis.z;

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

fn Mat4x4 rotateWith(Mat4x4 value, double angle_in_degrees, Vec3 axis) {
    Vec3 norm_axis = axis.normalize();

    double sin_theta = $$sin(toRadians(angle_in_degrees));
    double cos_theta = $$cos(toRadians(angle_in_degrees));
    double cos_value = 1 - cos_theta;

    double x = norm_axis.x;
    double y = norm_axis.y;
    double z = norm_axis.z;

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
                double sum = 0;

                foreach (left_column, value3: left.data) {
                    sum += left.data[left_column][row] * right.data[column][left_column];   
                }

                result.data[column][row] = sum;
            }
        }

        return result;
}