#include<bits/stdc++.h>
#include<stdlib.h>
using namespace std;

int main(int argc, char **argv) {
    freopen("rawout", "r", stdin);
    freopen("out.pgm", "w", stdout);
    int n = 24, m = 7;
    int a, b;
    cin >> a >> b;
    cout << "P2\n" << n - 2 << ' ' << m - 2 << "\n255\n";
    for(int i = 0; i < m - 2; i++) {
        for(int j = 0; j < n; j++) {
            int aa;
            cin >> aa;
            if(j - n < -3) {
                cout << aa << '\t';
            }	
        }
        cout << '\n';
    }
}

//sed -i -e 's/\//0/g' ./rawout
