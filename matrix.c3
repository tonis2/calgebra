module matrix;
 
struct Mat4x4 {
    [4][4]int data;
}

fn Mat4x4 Mat4x4.identity(Mat4x4* this)
{
    return Mat4x4 {
        {
            { 1, 0, 0, 0 },
            { 0, 1, 0, 0 },
            { 0, 0, 1, 0 },
            { 0, 0, 0, 1 },
        }
        };
}

fn Mat4x4 Mat4x4.zero(Mat4x4* this)
{
    return Mat4x4 {
        {
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
            { 0, 0, 0, 0 },
        }
        };
}