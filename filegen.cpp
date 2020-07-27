#include<bits/stdc++.h>
using namespace std;

int main() {
    freopen("in.pgm", "r", stdin);
    freopen("out.txt", "w", stdout);
    char type;
    int r, c;
    int maxn; 
    int a[256][256];
    cin >> type >> type;
    cin >> c >> r;
    cin >> maxn;
    for (int i = 0; i < r; ++i) 
        for (int j = 0; j < c; ++j) 
            cin >> a[i][j];

    cout << c << "\t" << r << "\t";	
    for (int i = 0; i < r; ++i) 
        for (int j = 0; j < c; ++j) 
            cout << a[i][j] << '\t';
}
