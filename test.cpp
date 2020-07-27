#include<bits/stdc++.h>
using namespace std;

#define REP(i, n) for(int i = 0; i < n; i++)

int main(){
    int a[7][4];
    REP(i, 7) REP(j, 4)	cin>>a[i][j];
    int w[3][3] = {{1, 2, 1}, {2, 4, 2}, {1, 2, 1}};
    REP(i, 5){
        REP(j, 2){
            REP(k, 3){
                REP(l, 3){
                    if(!(k==0 && l==0)) a[i][j] += w[k][l]*a[i+k][j+l];
                }
            }
            a[i][j] /= 16;
        }
    }
    for(int i = 0; i < 5; i++){
        for(int j = 0; j < 2; j++){
            cout<<a[i][j]<<" ";
        }
        cout<<'\n';
    }
}
