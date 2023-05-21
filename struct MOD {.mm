struct MOD {
	int64_t v; explicit operator int64_t() const { return v % mod; }
	MOD() { v = 0; }
	MOD(int64_t _v) {
		v = (-mod < _v && _v < mod) ? _v : _v % mod;
		if (v < 0) v += mod;
	}
	friend bool operator==(const MOD& a, const MOD& b) {
		return a.v == b.v;
	}
	friend bool operator!=(const MOD& a, const MOD& b) {
		return !(a == b);
	}
	friend bool operator<(const MOD& a, const MOD& b) {
		return a.v < b.v;
	}

	MOD& operator+=(const MOD& m) {
		if ((v += m.v) >= mod) v -= mod;
		return *this;
	}
	MOD& operator-=(const MOD& m) {
		if ((v -= m.v) < 0) v += mod;
		return *this;
	}
	MOD& operator*=(const MOD& m) {
		v = v * m.v % mod; return *this;
	}
	MOD& operator/=(const MOD& m) { return (*this) *= inv(m); }
	friend MOD pow(MOD a, int64_t p) {
		MOD ans = 1; assert(p >= 0);
		for (; p; p /= 2, a *= a) if (p & 1) ans *= a;
		return ans;
	}
	friend MOD inv(const MOD& a) {
		assert(a.v != 0);
		return pow(a, mod - 2);
	}

	MOD operator-() const { return MOD(-v); }
	MOD& operator++() { return *this += 1; }
	MOD& operator--() { return *this -= 1; }
	MOD operator++(int32_t) { MOD temp; temp.v = v++; return temp; }
	MOD operator--(int32_t) { MOD temp; temp.v = v--; return temp; }
	friend MOD operator+(MOD a, const MOD& b) { return a += b; }
	friend MOD operator-(MOD a, const MOD& b) { return a -= b; }
	friend MOD operator*(MOD a, const MOD& b) { return a *= b; }
	friend MOD operator/(MOD a, const MOD& b) { return a /= b; }
	friend ostream& operator<<(ostream& os, const MOD& m) {
		os << m.v; return os;
	}
	friend istream& operator>>(istream& is, MOD& m) {
		int64_t x; is >> x;
		m.v = x;
		return is;
	}
	friend void __print(const MOD &x) {
		cerr << x.v;
	}
};

vector<MOD> fct(maxn, 1), invf(maxn, 1);
void calc_fact() {
    for(int i = 1 ; i < maxn ; i++) {
        fct[i] = fct[i - 1] * i;
    }
    invf.back() = MOD(1) / fct.back();
    for(int i = maxn - 1 ; i ; i--)
        invf[i - 1] = i * invf[i];
}
 
MOD choose(int n, int r) { // choose r elements out of n elements
    if(r > n)   return MOD(0);
    assert(r <= n);
    return fct[n] * invf[r] * invf[n - r];
}
 
MOD place(int n, int r) { // x1 + x2 ---- xr = n and limit value of xi >= n
    assert(r > 0);
    return choose(n + r - 1, r - 1);
}