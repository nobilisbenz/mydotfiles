local ls = require("luasnip") --{{{
local s = ls.s --> snippet
local i = ls.i --> insert node
local t = ls.t --> text node

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

local group = vim.api.nvim_create_augroup("C++ Snippets", { clear = true })
local file_pattern = "*.cpp"

local function cs(trigger, nodes, opts) --{{{
  local snippet = s(trigger, nodes)
  local target_table = snippets

  local pattern = file_pattern
  local keymaps = {}

  if opts ~= nil then
    -- check for custom pattern
    if opts.pattern then
      pattern = opts.pattern
    end

    -- if opts is a string
    if type(opts) == "string" then
      if opts == "auto" then
        target_table = autosnippets
      else
        table.insert(keymaps, { "i", opts })
      end
    end

    -- if opts is a table
    if opts ~= nil and type(opts) == "table" then
      for _, keymap in ipairs(opts) do
        if type(keymap) == "string" then
          table.insert(keymaps, { "i", keymap })
        else
          table.insert(keymaps, keymap)
        end
      end
    end

    -- set autocmd for each keymap
    if opts ~= "auto" then
      for _, keymap in ipairs(keymaps) do
        vim.api.nvim_create_autocmd("BufEnter", {
          pattern = pattern,
          group = group,
          callback = function()
            vim.keymap.set(keymap[1], keymap[2], function()
              ls.snip_expand(snippet)
            end, { noremap = true, silent = true, buffer = true })
          end,
        })
      end
    end
  end

  table.insert(target_table, snippet) -- insert snippet into appropriate table
end --}}}

-- Start Refactoring --
----------------------------------
--cs( -- {} snippet{{{
--	"{",
--	fmt(
--		[[
--{{
--	{}
--}}
--]],
--		{
--			i(0, ""),
--		}
--	)
--) --}}}
----------------------------------

cs( -- all snippets snippet{{{
  "snips",
  fmt(
    [[
/*
snips
beg
minimal
for
read
vect
all
readvec
sort
pb
graph
tree
rootedtree
0rootedtree
gcd
binpow
inv
fft
sufarr
aho
cht
segtree
centroid
sparse
decart
fenwick
fenwick2d
modular
table
dsu
deb
*/
{}
  ]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( --{{{
  "beg",
  fmt(
    [[
#ifdef ONPC
    #define _GLIBCXX_DEBUG
#endif
#include <bits/stdc++.h>
#define sz(a) ((int)((a).size()))
#define char unsigned char
 
using namespace std;
// mt19937 rnd(239);
mt19937 rnd(chrono::steady_clock::now().time_since_epoch().count());
 
typedef long long ll;
typedef long double ld;
 
int solve() {{
    {}
    return 0;
}}
 
int32_t main() {{
    ios::sync_with_stdio(0);
    cin.tie(0);
    int TET = 1e9;
    //cin >> TET;
    for (int i = 1; i <= TET; i++) {{
        if (solve()) {{
            break;
        }}
        #ifdef ONPC
            cout << "__________________________" << endl;
        #endif
    }}
    #ifdef ONPC
        cerr << endl << "finished in " << clock() * 1.0 / CLOCKS_PER_SEC << " sec" << endl;
    #endif
}}
  ]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {} snippet{{{
  "minimal",
  fmt(
    [[
#include <bits/stdc++.h>
 
using namespace std;
typedef long long ll;
 
int32_t main() {{
    {}
}}
  ]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- For Loop snippet{{{
  "for",
  fmt(
    [[
for (int {} = 0; {} < {}; {}++){{
	{}
}}
{}
    ]],
    {
      i(1, "i"),
      rep(1),
      c(2, { i(1, "num"), i(1, "N"), sn(1, { i(1, "arr"), t(".length") }) }),
      rep(1),
      i(3, "// TODO:"),
      i(4),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {} snippet{{{
  "read",
  fmt(
    [[
{} {};
if (!(cin >> {})) {{
    return 1;
}}
{}
  ]],
    {
      --c(1, {i(1,"int"),i(1,"string")}),
      i(1, "int"),
      --c(2, {i(1,"num"),i(1,"name")}),
      i(2, "n"),
      rep(2),
      i(3, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {vector} snippet{{{
  "vect",
  fmt(
    [[
vector<{}> {};{}
]],
    {
      i(1, "int"),
      i(2, "arr"),
      i(3, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {all} snippet{{{
  "all",
  fmt(
    [[
{}.begin(), {}.end(){}
]],
    {
      i(1, "arr"),
      rep(1),
      i(2, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {read vector} snippet{{{
  "readvec",
  fmt(
    [[
vector<{}> {}({});
for ({} &val : {}) {{
    cin >> val;
}}
{}
]],
    {
      i(1, "int"),
      i(2, "arr"),
      i(3, "n"),
      rep(1),
      rep(2),
      i(4, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- sort snippet{{{
  "sort",
  fmt(
    [[
sort({}.begin(), {}.end());{}
]],
    {
      i(1, "arr"),
      rep(1),
      i(2, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {push_back} snippet{{{
  "pb",
  fmt(
    [[
push_back({});{}
]],
    {
      i(1, ""),
      i(2, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {read graph} snippet{{{
  "graph",
  fmt(
    [[
const int N = ;
 
vector<int> g[N];
int used[N];
 
int solve() {{
    int n;
    if (!(cin >> n)) {{
        return 1;
    }}
    int m;
    cin >> m;
    for (int i = 0; i < n; i++) {{
        used[i] = 0;
        g[i].clear();
    }}
    for (int i = 0; i < m; i++) {{
        int x, y;
        cin >> x >> y;
        x--;
        y--;
        g[x].push_back(y);
        g[y].push_back(x);
    }}
    {}
    return 1;
}}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {read tree} snippet{{{
  "tree",
  fmt(
    [[
const int N = ;
 
vector<int> g[N];
int used[N];
 
int solve() {{
    int n;
    if (!(cin >> n)) {{
        return 1;
    }}
    for (int i = 0; i < n; i++) {{
        used[i] = 0;
        g[i].clear();
    }}
    for (int i = 1; i < n; i++) {{
        int x, y;
        cin >> x >> y;
        x--;
        y--;
        g[x].push_back(y);
        g[y].push_back(x);
    }}
    {}
    return 1;
}}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {read rooted tree} snippet{{{
  "rootedtree",
  fmt(
    [[
const int N = ;
 
vector<int> g[N];
int used[N], pr[N];
 
int solve() {{
    int n;
    if (!(cin >> n)) {{
        return 1;
    }}
    int root = -1;
    for (int i = 0; i < n; i++) {{
        used[i] = 0;
        g[i].clear();
    }}
    for (int i = 0; i < n; i++) {{
        int p;
        cin >> p;
        if (p == -1) {{
            root = i;
            continue;
        }}
        p--;
        g[p].push_back(i);
        pr[i] = p;
    }}
    {}
    return 1;
}}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {read rooted in first vertex tree} snippet{{{
  "0rootedtree",
  fmt(
    [[
const int N = ;
 
vector<int> g[N];
int used[N], pr[N];
 
int solve() {{
    int n;
    if (!(cin >> n)) {{
        return 1;
    }}
    for (int i = 0; i < n; i++) {{
        used[i] = 0;
        g[i].clear();
    }}
    for (int i = 1; i < n; i++) {{
        int p;
        cin >> p;
        p--;
        g[p].push_back(i);
        pr[i] = p;
    }}
    {}
    return 1;
}}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {gcd} snippet{{{
  "gcd",
  fmt(
    [[
template<typename T>
T gcd(T a, T b) {{
    while (a) {{
        b %= a;
        swap(a, b);
    }}
    return b;
}}
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- binpow snippet{{{
  "binpow",
  fmt(
    [[
template<typename T>
T binpow(T a, T b) {{
    T ans = 1;
    while (b) {{
        if (b & 1) {{
            ans = 1LL * ans * a % MOD;
        }}
        a = 1LL * a * a % MOD;
        b >>= 1;
    }}
    return ans;
}}
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {any mod inverse} snippet{{{
  "inv",
  fmt(
    [[
ll inv(ll a, ll m) {{
    if (a == 1) {{
        return 1;
    }}
    return (1LL - inv(m % a, a) * m) / a + m;
}}
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {FFT} snippet{{{
  "fft",
  fmt(
    [[
namespace fft {{
    struct cmpl {{
        double x, y;
        cmpl() {{
            x = y = 0;
        }}
        cmpl(double x, double y) : x(x), y(y) {{}}
        inline cmpl conjugated() const {{
            return cmpl(x, -y);
        }}
    }};
    inline cmpl operator+(cmpl a, cmpl b) {{
        return cmpl(a.x + b.x, a.y + b.y);
    }}
    inline cmpl operator-(cmpl a, cmpl b) {{
        return cmpl(a.x - b.x, a.y - b.y);
    }}
    inline cmpl operator*(cmpl a, cmpl b) {{
        return cmpl(a.x * b.x - a.y * b.y, a.x * b.y + a.y * b.x);
    }}
 
    int base = 1; // current power of two (2^base >= n)
    vector<cmpl> roots = {{{{0, 0}}, {{1, 0}}}}; // complex roots of 1 (with bases from 1 to base), 1-based indexing
    vector<int> rev = {{0, 1}}; // rev[i] = reversed bit representation of i
    const double PI = static_cast<double>(acosl(-1.0));
 
    void ensure_base(int nbase) {{ // if base < nbase increase it
        if (nbase <= base) {{
            return;
        }}
        rev.resize(1 << nbase);
        for (int i = 1; i < (1 << nbase); i++) {{
            rev[i] = (rev[i >> 1] >> 1) + ((i & 1) << (nbase - 1));
        }}
        roots.resize(1 << nbase);
        while (base < nbase) {{
            double angle = 2 * PI / (1 << (base + 1));
            for (int i = 1 << (base - 1); i < (1 << base); i++) {{
                roots[i << 1] = roots[i];
                double angle_i = angle * (2 * i + 1 - (1 << base));
                roots[(i << 1) + 1] = cmpl(cos(angle_i), sin(angle_i));
            }}
            base++;
        }}
    }}
 
    void fft(vector<cmpl>& a, int n = -1) {{
        if (n == -1) {{
            n = (int) a.size();
        }}
        assert((n & (n - 1)) == 0); // ensure that n is a power of two
        int zeros = __builtin_ctz(n);
        ensure_base(zeros);
        int shift = base - zeros;
        for (int i = 0; i < n; i++) {{
            if (i < (rev[i] >> shift)) {{
                swap(a[i], a[rev[i] >> shift]);
            }}
        }}
        for (int k = 1; k < n; k <<= 1) {{
            for (int i = 0; i < n; i += 2 * k) {{
                for (int j = 0; j < k; j++) {{
                    cmpl z = a[i + j + k] * roots[j + k];
                    a[i + j + k] = a[i + j] - z;
                    a[i + j] = a[i + j] + z;
                }}
            }}
        }}
    }}
 
    vector<cmpl> fa, fb;
 
    vector<long long> square(const vector<int>& a) {{
        if (a.empty()) {{
            return {{}};
        }}
        int need = (int) a.size() + (int) a.size() - 1;
        int nbase = 1;
        while ((1 << nbase) < need) {{
            nbase++;
        }}
        ensure_base(nbase);
        int sz = 1 << nbase;
        if ((sz >> 1) > (int) fa.size()) {{
            fa.resize(sz >> 1);
        }}
        for (int i = 0; i < (sz >> 1); i++) {{
            int x = (2 * i < (int) a.size() ? a[2 * i] : 0);
            int y = (2 * i + 1 < (int) a.size() ? a[2 * i + 1] : 0);
            fa[i] = cmpl(x, y);
        }}
        fft(fa, sz >> 1);
        cmpl r(1.0 / (sz >> 1), 0.0);
        for (int i = 0; i <= (sz >> 2); i++) {{
            int j = ((sz >> 1) - i) & ((sz >> 1) - 1);
            cmpl fe = (fa[i] + fa[j].conjugated()) * cmpl(0.5, 0);
            cmpl fo = (fa[i] - fa[j].conjugated()) * cmpl(0, -0.5);
            cmpl aux = fe * fe + fo * fo * roots[(sz >> 1) + i] * roots[(sz >> 1) + i];
            cmpl tmp = fe * fo;
            fa[i] = r * (aux.conjugated() + cmpl(0, 2) * tmp.conjugated());
            fa[j] = r * (aux + cmpl(0, 2) * tmp);
        }}
        fft(fa, sz >> 1);
        vector<long long> res(need);
        for (int i = 0; i < need; i++) {{
            res[i] = llround(i % 2 == 0 ? fa[i >> 1].x : fa[i >> 1].y);
        }}
        return res;
    }}
    
    // interface
 
    vector<long long> multiply(const vector<int>& a, const vector<int>& b) {{
        if (a.empty() || b.empty()) {{
            return {{}};
        }}
        if (a == b) {{
            return square(a);
        }}
        int need = (int) a.size() + (int) b.size() - 1;
        int nbase = 1;
        while ((1 << nbase) < need) nbase++;
        ensure_base(nbase);
        int sz = 1 << nbase;
        if (sz > (int) fa.size()) {{
            fa.resize(sz);
        }}
        for (int i = 0; i < sz; i++) {{
            int x = (i < (int) a.size() ? a[i] : 0);
            int y = (i < (int) b.size() ? b[i] : 0);
            fa[i] = cmpl(x, y);
        }}
        fft(fa, sz);
        cmpl r(0, -0.25 / (sz >> 1));
        for (int i = 0; i <= (sz >> 1); i++) {{
            int j = (sz - i) & (sz - 1);
            cmpl z = (fa[j] * fa[j] - (fa[i] * fa[i]).conjugated()) * r;
            fa[j] = (fa[i] * fa[i] - (fa[j] * fa[j]).conjugated()) * r;
            fa[i] = z;
        }}
        for (int i = 0; i < (sz >> 1); i++) {{
            cmpl A0 = (fa[i] + fa[i + (sz >> 1)]) * cmpl(0.5, 0);
            cmpl A1 = (fa[i] - fa[i + (sz >> 1)]) * cmpl(0.5, 0) * roots[(sz >> 1) + i];
            fa[i] = A0 + A1 * cmpl(0, 1);
        }}
        fft(fa, sz >> 1);
        vector<long long> res(need);
        for (int i = 0; i < need; i++) {{
        res[i] = llround(i % 2 == 0 ? fa[i >> 1].x : fa[i >> 1].y);
        }}
        return res;
    }}
 
    vector<int> multiply_mod(const vector<int>& a, const vector<int>& b, int m) {{
        if (a.empty() || b.empty()) {{
            return {{}};
        }}
        int need = (int) a.size() + (int) b.size() - 1;
        int nbase = 0;
        while ((1 << nbase) < need) {{
            nbase++;
        }}
        ensure_base(nbase);
        int sz = 1 << nbase;
        if (sz > (int) fa.size()) {{
            fa.resize(sz);
        }}
        for (int i = 0; i < (int) a.size(); i++) {{
            int x = (a[i] % m + m) % m;
            fa[i] = cmpl(x & ((1 << 15) - 1), x >> 15);
        }}
        fill(fa.begin() + a.size(), fa.begin() + sz, cmpl{{0, 0}});
        fft(fa, sz);
        if (sz > (int) fb.size()) {{
            fb.resize(sz);
        }}
        if (a == b) {{
            copy(fa.begin(), fa.begin() + sz, fb.begin());
        }} else {{
            for (int i = 0; i < (int) b.size(); i++) {{
                int x = (b[i] % m + m) % m;
                fb[i] = cmpl(x & ((1 << 15) - 1), x >> 15);
            }}
            fill(fb.begin() + b.size(), fb.begin() + sz, cmpl{{0, 0}});
            fft(fb, sz);
        }}
        double ratio = 0.25 / sz;
        cmpl r2(0, -1);
        cmpl r3(ratio, 0);
        cmpl r4(0, -ratio);
        cmpl r5(0, 1);
        for (int i = 0; i <= (sz >> 1); i++) {{
            int j = (sz - i) & (sz - 1);
            cmpl a1 = (fa[i] + fa[j].conjugated());
            cmpl a2 = (fa[i] - fa[j].conjugated()) * r2;
            cmpl b1 = (fb[i] + fb[j].conjugated()) * r3;
            cmpl b2 = (fb[i] - fb[j].conjugated()) * r4;
            if (i != j) {{
                cmpl c1 = (fa[j] + fa[i].conjugated());
                cmpl c2 = (fa[j] - fa[i].conjugated()) * r2;
                cmpl d1 = (fb[j] + fb[i].conjugated()) * r3;
                cmpl d2 = (fb[j] - fb[i].conjugated()) * r4;
                fa[i] = c1 * d1 + c2 * d2 * r5;
                fb[i] = c1 * d2 + c2 * d1;
            }}
            fa[j] = a1 * b1 + a2 * b2 * r5;
            fb[j] = a1 * b2 + a2 * b1;
        }}
        fft(fa, sz);
        fft(fb, sz);
        vector<int> res(need);
        for (int i = 0; i < need; i++) {{
            long long aa = llround(fa[i].x);
            long long bb = llround(fb[i].x);
            long long cc = llround(fa[i].y);
            res[i] = static_cast<int>((aa + ((bb % m) << 15) + ((cc % m) << 30)) % m);
        }}
        return res;
    }}
}}  // namespace fft
/*
use these:
vector<int> multiply_mod(const vector<int>& a, const vector<int>& b, int m)
vector<ll> square(const vector<int>& a)
vector<ll> multiply(const vector<int>& a, const vector<int>& b) // (if a == b it uses square)
*/
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {suffix array} snippet{{{
  "sufarr",
  fmt(
    [[
const char C = 'a' - 1; // before first letter // change
const char maxchar = 'z'; // change
 
vector<int> suffarray(string s) {{ // without $ at the end
    vector<int> p, c, pn, cn, cnt;
    int n = (int)s.size();
    c.assign(n, 0);
    for (int i = 0; i < n; i++) {{
        c[i] = s[i] - C;
    }}
    for (int j = 0; j <= (maxchar - C); j++) {{
        for (int i = 0; i < n; i++) {{
            if (c[i] == j) {{
                p.push_back(i);
            }}
        }}
    }}
    int maxc = c[p.back()];
    pn.resize(n);
    for (int k = 0; (1 << k) <= 2 * n; k++) {{
        for (int i = 0; i < n; i++) {{
            pn[i] = ((p[i] -  (1 << k)) % n + n) % n;
        }}
        cnt.assign(maxc + 3, 0);
        for (int i = 0; i < n; i++) {{
            cnt[c[i] + 1]++;
        }}
        for (int i = 1; i <= maxc + 2; i++) {{
            cnt[i] += cnt[i - 1];
        }}
        for (int i = 0; i < n; i++) {{
            p[cnt[c[pn[i___++] = pn[i];
        }}
        cn.assign(n, 0);
        cn[p[0__ = 1;
        for (int i = 1; i < n; i++) {{
            if (c[p[i__ == c[p[i - 1__ && c[(p[i] + (1 << k)) % n] == c[(p[i - 1] + (1 << k)) % n]) {{
                cn[p[i__ = cn[p[i - 1__;
            }} else {{
                cn[p[i__ = cn[p[i - 1__ + 1;
            }}
        }}
        maxc = cn[p.back()];
        c = cn;
    }}
    return p;
}}
 
vector<int> findlcp(string s, vector<int> p) {{
    vector<int> lcp, mem;
    int n = (int)s.size();
    mem.resize(n);
    for (int i = 0; i < n; i++) {{
        mem[p[i__ = i;
    }}
    lcp.assign(n, 0);
    for (int i = 0; i < n; i++) {{
        if (i > 0) {{
            lcp[mem[i__ = max(lcp[mem[i - 1__ - 1, 0);
        }}
        if (mem[i] == n - 1) {{
            continue;
        }}
        while (max(i, p[mem[i] + 1]) + lcp[mem[i__ < n && s[i + lcp[mem[i___ == s[p[mem[i] + 1] + lcp[mem[i___) {{
            lcp[mem[i__++;
        }}
    }}
    return lcp;
    {}
}}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {aho-corasik} snippet{{{
  "aho",
  fmt(
    [[
struct aho {{
    vector<vector<int> > g, gr;
    vector<string> str;
    int root;
    int sz;
    vector<ll> ending;
    vector<int> link;
    char firstlet;
    int numlet = 0;
 
    aho():
        g(),
        gr(),
        str(),
        root(0),
        sz(0),
        ending(),
        link() {{}}
 
    aho(vector<string> q, char firlet = 'a') {{ // change
        firstlet = firlet;
        sz = q.size();
        str = q;
        g.clear();
        gr.clear();
        ending.clear();
        link.clear();
        root = 0;
        ending.assign(1, 0);
        numlet = 0;
        for (int i = 0; i < q.size(); i++) {{
            for (int j = 0; j < q[i].size(); j++) {{
                numlet = q[i][j] - firstlet;
            }}
        }}
        numlet++;
        g.push_back(vector<int>(numlet, -1));
        for (int i = 0; i < q.size(); i++) {{
            int v = root;
            for (int j = 0; j < q[i].size(); j++) {{
                if (g[v][q[i][j] - firstlet] == -1) {{
                    g[v][q[i][j] - firstlet] = g.size();
                    g.push_back(vector<int>(numlet, -1));
                    ending.push_back(0);
                }}
                v = g[v][q[i][j] - firstlet];
            }}
            ending[v]++;
        }}
        link.assign(g.size(), -1);
        link[root] = root;
        queue<int> que;
        que.push(root);
        while (que.size()) {{
            int v = que.front();
            que.pop();
            for (int i = 0; i < numlet; i++) {{
                if (g[v][i] == -1) {{
                    if (v == root) {{
                        g[v][i] = v;
                    }} else {{
                        g[v][i] = g[link[v__[i];
                    }}
                }}
                else {{
                    que.push(g[v][i]);
                    if (v == root) {{
                        link[g[v][i__ = v;
                    }} else {{
                        link[g[v][i__ = g[link[v__[i];
                    }}
                }}
        }}
        gr.resize(g.size());
        for (int i = 0; i < g.size(); i++) {{
            if (i != root) {{
                gr[link[i__.push_back(i);
            }}
        }}
        dfslink(root);
    }}
 
    void dfslink(int v) {{
        for (int u : gr[v]) {{
            ending[u] += ending[v];
            dfslink(u);
        }}
    }}
 
    ll find(string s) {{ // change
        ll ans = 0;
        int v = root;
        for (int i = 0; i < s.size(); i++) {{
            v = g[v][s[i] - firstlet];
            ans += ending[v];
        }}
        return ans;
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {convex hull trick} snippet{{{
  "cht",
  fmt(
    [[
typedef long long integer;
 
struct Line {{
    integer k, b;
    Line():
        k(0),
        b(0) {{}}
    Line(integer k, integer b):
        k(k),
        b(b) {{}}
 
    ld operator()(ld x) {{
        return x * (ld)k + (ld)b;
    }}
}};
 
const integer INF = 2e18; // change
 
struct CHT {{
    vector<Line> lines;
    bool mini; // cht on minimum
 
    ld f(Line l1, Line l2) {{
        return (ld)(l1.b - l2.b) / (ld)(l2.k - l1.k);
    }}
 
    void addLine(integer k, integer b) {{
        if (!mini) {{
            k = -k;
            b = -b;
        }}
        Line l(k, b);
        while (lines.size() > 1) {{
            if (lines.back().k == k) {{
                if (lines.back().b > b) {{
                    lines.pop_back();
                }} else {{
                    break;
                }}
                continue;
            }}
            ld x1 = f(lines.back(), l);
            ld x2 = f(lines.back(), lines[lines.size() - 2]);
            if (x1 > x2) {{
                break;
            }}
            lines.pop_back();
        }}
        if (!lines.size() || lines.back().k != k) {{
            lines.push_back(l);
        }}
    }}
 
    CHT(vector<pair<integer, integer> > v, bool ok = 1) {{ // change
        mini = ok;
        lines.clear();
        for (int i = 0; i < v.size(); i++) {{
            addLine(v[i].first, v[i].second);
        }}
    }}
 
    integer getmin(integer x) {{ //find of integer!
        if (!lines.size()) {{
            return (mini ? INF : -INF);
        }}
        int l = 0, r = lines.size();
        while (r - l > 1) {{
            int mid = (r + l) / 2;
            if (f(lines[mid], lines[mid - 1]) <= (ld)x) {{
                l = mid;
            }} else {{
                r = mid;
            }}
        }}
        integer ans = lines[l].k * x + lines[l].b;
        return (mini ? ans : -ans);
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {segment tree} snippet{{{
  "segtree",
  fmt(
    [[
struct SegmentTree {{
    // TO CHANGE
 
    struct Node {{ // set default values
        ...
 
        template<typename T>
        void apply(int l, int r, T val) {{ // update value and save push
            ...
        }}
    }};
 
    Node merge(const Node& left, const Node& right) {{
        ...
    }}
 
    void push(int v, int l, int r) {{
        if (tree[v].??? != ...) {{
            int mid = (r + l) >> 1;
            int vl = v + 1, vr = v + ((mid - l) << 1);
            tree[vl].apply(l, mid, tree[v].???);
            tree[vr].apply(mid, r, tree[v].???);
            tree[v].??? = ...;
        }}
    }}
 
    // DEFAULT PART
 
    vector<Node> tree;
    int n;
 
    template<typename T>
    void build(int v, int l, int r, const vector<T>& arr) {{
        if (l + 1 == r) {{
            tree[v].apply(l, r, arr[l]);
            return;
        }}
        int mid = (r + l) >> 1;
        int vl = v + 1, vr = v + ((mid - l) << 1);
        build(vl, l, mid, arr);
        build(vr, mid, r, arr);
        tree[v] = merge(tree[vl], tree[vr]);
    }}
 
    void build(int v, int l, int r) {{
        if (l + 1 == r) {{
            return;
        }}
        int mid = (r + l) >> 1;
        int vl = v + 1, vr = v + ((mid - l) << 1);
        build(vl, l, mid);
        build(vr, mid, r);
        tree[v] = merge(tree[vl], tree[vr]);
    }}
 
    Node find(int v, int l, int r, int ql, int qr) {{
        if (ql <= l && r <= qr) {{
            return tree[v];
        }}
        push(v, l, r);
        int mid = (r + l) >> 1;
        int vl = v + 1, vr = v + ((mid - l) << 1);
        if (qr <= mid) {{
            return find(vl, l, mid, ql, qr);
        }} else if (ql >= mid) {{
            return find(vr, mid, r, ql, qr);
        }} else {{
            return merge(find(vl, l, mid, ql, qr), find(vr, mid, r, ql, qr));
        }}
    }}
 
    template<typename T>
    void update(int v, int l, int r, int ql, int qr, const T& newval) {{
        if (ql <= l && r <= qr) {{
            tree[v].apply(l, r, newval);
            return;
        }}
        push(v, l, r);
        int mid = (r + l) >> 1;
        int vl = v + 1, vr = v + ((mid - l) << 1);
        if (ql < mid) {{
            update(vl, l, mid, ql, qr, newval);
        }}
        if (qr > mid) {{
            update(vr, mid, r, ql, qr, newval);
        }}
        tree[v] = merge(tree[vl], tree[vr]);
    }}
 
    int find_first(int v, int l, int r, int ql, int qr, const function<bool(const Node&)>& predicate) {{
        if (!predicate(tree[v])) {{
            return -1;
        }}
        if (l + 1 == r) {{
            return l;
        }}
        push(v, l, r);
        int mid = (r + l) >> 1;
        int vl = v + 1, vr = v + ((mid - l) << 1);
        if (ql < mid) {{
            int lans = find_first(vl, l, mid, ql, qr, predicate);
            if (lans != -1) {{
                return lans;
            }}
        }}
        if (qr > mid) {{
            int rans = find_first(vr, mid, r, ql, qr, predicate);
            if (rans != -1) {{
                return rans;
            }}
        }}
        return -1;
    }}
 
    // INTERFACE
 
    SegmentTree(int n) : n(n) {{ // build from size with default values
        tree.resize(2 * n - 1);
        build(0, 0, n);
    }}
 
    template<typename T>
    SegmentTree(const vector<T>& arr) {{ // build from vector
        n = arr.size();
        tree.resize(2 * n - 1);
        build(0, 0, n, arr);
    }}
 
    Node find(int ql, int qr) {{ // find value on [ql, qr)
        return find(0, 0, n, ql, qr);
    }}
 
    Node find(int qi) {{ // find value of position qi
        return find(0, 0, n, qi);
    }}
 
    template<typename T>
    void update(int ql, int qr, const T& newval) {{ // update [ql, qr) with newval
        update(0, 0, n, ql, qr, newval);
    }}
 
    template<typename T>
    void update(int qi, const T& newval) {{ // update position qi with newval
        update(0, 0, n, qi, qi + 1, newval);
    }}
 
    int find_first(int ql, int qr, const function<bool(const Node&)>& predicate) {{ // find first index on [ql, qr) that satisfies predicate or -1 if none
        return find_first(0, 0, n, ql, qr, predicate);
    }}
 
    int find_first(int ql, const function<bool(const Node&)>& predicate) {{ // find first index >= ql that satisfies predicate or -1 if none
        return find_first(0, 0, n, ql, n, predicate);
    }}
 
    int find_first(const function<bool(const Node&)>& predicate) {{ // find first index that satisfies predicate or -1 if none
        return find_first(0, 0, n, 0, n, predicate);
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {centroid decomposition} snippet{{{
  "centroid",
  fmt(
    [[
const int MAXN = ;
 
vector<int> g[MAXN], used, p, d;
 
int cnt;
 
int dfs(int v, int pr) {{
    cnt++;
    d[v] = 1;
    for (int u : g[v]) {{
        if (!used[u] && u != pr) {{
            d[v] += dfs(u, v);
        }}
    }}
    return d[v];
}}
 
int centroid(int v) {{
    cnt = 0;
    dfs(v, -1);
    int pr = -1;
    while (true) {{
        int z = -1;
        for (int u : g[v]) {{
            if (!used[u] && u != pr && d[u] * 2 >= cnt) {{
                z = u;
            }}
        }}
        if (z == -1) {{
            break;
        }}
        pr = v;
        v = z;
    }}
    return v;
}}
 
void go(int v, int pr) {{
    v = centroid(v);
    p[v] = pr;
    used[v] = 1;
 
    for (int u : g[v]) {{
        if (!used[u]) {{
            go(u, v);
        }}
    }}
}}
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {sparse table} snippet{{{
  "sparse",
  fmt(
    [[
template<typename T>
struct SparseTable {{
    vector<vector<T>> sparse;
    function<T(const T&, const T&)> accum_func;
 
    SparseTable(const vector<T>& arr, const function<T(const T&, const T&)>& func) : accum_func(func) {{
        int n = arr.size();
        int logn = 32 - __builtin_clz(n);
        sparse.resize(logn, vector<T>(n));
        sparse[0] = arr;
        for (int lg = 1; lg < logn; lg++) {{
            for (int i = 0; i + (1 << lg) <= n; i++) {{
                sparse[lg][i] = accum_func(sparse[lg - 1][i], sparse[lg - 1][i + (1 << (lg - 1))]);
            }}
        }}
    }}
 
    T find(int l, int r) {{ // [l, r)
        int cur_log = 31 - __builtin_clz(r - l);
        return accum_func(sparse[cur_log][l], sparse[cur_log][r - (1 << cur_log)]);
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {treap} snippet{{{
  "decart",
  fmt(
    [[
struct Node {{
    int x;
    ll y;
    int sz;
    Node *left;
    Node *right;
    Node(int x = 0):
        x(x),
        y((ll)rnd()),
        sz(1),
        left(NULL),
        right(NULL) {{}}
}};
 
int sz(Node *v) {{
    return (v == NULL ? 0 : v->sz);
}}
 
Node* upd(Node *v) {{
    if (v != NULL) {{
        v->sz = 1 + sz(v->left) + sz(v->right);
    }}
    return v;
}}
 
Node* merge(Node *l, Node *r) {{
    if (l == NULL) {{
        return r;
    }}
    if (r == NULL) {{
        return l;
    }}
    if (l->y < r->y) {{
        l = merge(l, r->left);
        r->left = l;
        r = upd(r);
        return r;
    }}
    r = merge(l->right, r);
    l->right = r;
    l = upd(l);
    return l;
}}
 
pair<Node*, Node*> keySplit(Node *v, int key) {{ // l's keys <= key, r's keys > key
    if (v == NULL) {{
        return {{v, v}};
    }}
    if (v->x <= key) {{
        auto a = keySplit(v->right, key);
        v->right = a.first;
        v = upd(v);
        return {{v, a.second}};
    }}
    auto a = keySplit(v->left, key);
    v->left = a.second;
    v = upd(v);
    return {{a.first, v}};
}}
 
pair<Node*, Node*> sizeSplit(Node *v, int siz) {{ // l's size is siz
    if (!v) {{
        return {{v, v}};
    }}
    if (sz(v->left) >= siz) {{
        auto a = sizeSplit(v->left, siz);
        v->left = a.second;
        v = upd(v);
        return {{a.first, v}};
    }}
    auto a = sizeSplit(v->right, siz - sz(v->left) - 1);
    v->right = a.first;
    v = upd(v);
    return {{v, a.second}};
}}
 
void gogo(Node *v) {{
    if (v == NULL) {{
        return;
    }}
    gogo(v->left);
    cerr << v->x << endl;
    gogo(v->right);
}}
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {Fenwick tree} snippet{{{
  "fenwick",
  fmt(
    [[
struct Fenwick {{
    vector<ll> tree;
    int n;
 
    Fenwick(int n) : n(n) {{
        tree.assign(n, 0);
    }}
 
    void point_add(int pos, ll val) {{
        for (; pos < n; pos |= (pos + 1)) {{
            tree[pos] += val;
        }}
    }}
 
    ll find_sum(int r) {{ // [0, r]
        ll ans = 0;
        for (; r >= 0; r = (r & (r + 1)) - 1) {{
            ans += tree[r];
        }}
        return ans;
    }}
 
    ll find_sum(int l, int r) {{ // [l, r)
        return find_sum(r - 1) - find_sum(l - 1);
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {2D Fenwick tree} snippet{{{
  "Fenwick2D",
  fmt(
    [[
struct Fenwick2D {{
    vector<vector<ll>> tree;
    int n, m;
 
    Fenwick2D(int n, int m) : n(n), m(m) {{
        tree.assign(n, vector<ll>(m, 0));
    }}
 
    void point_add(int posx, int posy, ll val) {{
        for (int x = posx; x < n; x |= (x + 1)) {{
            for (int y = posy; y < m; y |= (y + 1)) {{
                tree[x][y] += val;
            }}
        }}
    }}
 
    ll find_sum(int rx, int ry) {{ // [0, rx] x [0, ry]
        ll ans = 0;
        for (int x = rx; x >= 0; x = (x & (x + 1)) - 1) {{
            for (int y = ry; y >= 0; y = (y & (y + 1)) - 1) {{
                ans += tree[x][y];
            }}
        }}
        return ans;
    }}
 
    ll find_sum(int lx, int rx, int ly, int ry) {{ // [lx, rx) x [ly, ry)
        return find_sum(rx - 1, ry - 1) - find_sum(rx - 1, ly - 1) - find_sum(lx - 1, ry - 1) + find_sum(lx - 1, ly - 1);
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {modular arithmetics} snippet{{{
  "modular",
  fmt(
    [[
template<int MODULO>
struct ModularInt {{
    int value;
 
    ModularInt(ll llvalue) : value(llvalue % MODULO) {{
        if (value < 0) {{
            value += MODULO;
        }}
    }}
 
    ModularInt(const ModularInt<MODULO>& other) : value(other.value) {{}}
 
    inline void operator+=(ModularInt<MODULO> other) {{
        value += other.value;
        if (value >= MODULO) {{
            value -= MODULO;
        }}
    }}
 
    inline ModularInt<MODULO> operator+(ModularInt<MODULO> other) const {{
        return ModularInt<MODULO>(value + other.value >= MODULO ? value + other.value - MODULO : value + other.value);
    }}
 
    inline void operator-=(ModularInt<MODULO> other) {{
        value -= other.value;
        if (value < 0) {{
            value += MODULO;
        }}
    }}
 
    inline ModularInt<MODULO> operator-(ModularInt<MODULO> other) const {{
        return ModularInt<MODULO>(value - other.value < 0 ? value - other.value + MODULO : value - other.value);
    }}
 
    inline ModularInt<MODULO> operator-() const {{
        return ModularInt<MODULO>(value == 0 ? value : MODULO - value);
    }}
 
    inline ModularInt<MODULO>& operator++() {{
        ++value;
        if (value == MODULO) {{
            value = 0;
        }}
        return *this;
    }}
 
    inline ModularInt<MODULO> operator++(int) {{
        ModularInt<MODULO> old(*this);
        ++value;
        if (value == MODULO) {{
            value = 0;
        }}
        return old;
    }}
 
    inline ModularInt<MODULO>& operator--() {{
        --value;
        if (value == -1) {{
            value = MODULO - 1;
        }}
        return *this;
    }}
 
    inline ModularInt<MODULO> operator--(int) {{
        ModularInt<MODULO> old(*this);
        --value;
        if (value == -1) {{
            value = MODULO - 1;
        }}
        return old;
    }}
 
    inline ModularInt<MODULO> operator*(ModularInt<MODULO> other) const {{
        return ModularInt<MODULO>(1LL * value * other.value);
    }}
 
    inline void operator*=(ModularInt<MODULO> other) {{
        value = 1LL * value * other.value % MODULO;
    }}
 
    friend ModularInt<MODULO> binpow(ModularInt<MODULO> a, ll bll) {{
        if (a.value == 0) {{
            return ModularInt<MODULO>(bll == 0 ? 1 : 0);
        }}
        int b = bll % (MODULO - 1);
        int ans = 1;
        while (b) {{
            if (b & 1) {{
                ans = 1LL * ans * a % MODULO;
            }}
            a = 1LL * a * a % MODULO;
            b >>= 1;
        }}
        return ModularInt<MODULO>(ans);
    }}
 
    inline ModularInt<MODULO> inv() const {{
        return binpow(*this, MODULO - 2);
    }}
 
    inline ModularInt<MODULO> operator/(ModularInt<MODULO> other) const {{
        return (*this) * other.inv();
    }}
 
    inline void operator/=(ModularInt<MODULO> other) {{
        value = 1LL * value * other.inv().value % MODULO;
    }}
 
    inline bool operator==(ModularInt<MODULO> other) const {{
        return value == other.value;
    }}
 
    inline bool operator!=(ModularInt<MODULO> other) const {{
        return value != other.value;
    }}
 
    explicit operator int() const {{
        return value;
    }}
 
    explicit operator bool() const {{
        return value;
    }}
 
    explicit operator long long() const {{
        return value;
    }}
 
    friend istream& operator>>(istream& inp, const ModularInt<MODULO>& mint) {{
        inp >> mint.value;
        return inp;
    }}
 
    friend ostream& operator<<(ostream& out, const ModularInt<MODULO>& mint) {{
        out << mint.value;
        return out;
    }}
}};
 
const int MOD = ;
 
typedef ModularInt<MOD> MInt;
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {table graph} snippet{{{
  "table",
  fmt(
    [[
int dx[] = {{0, 1, 0, -1}};
int dy[] = {{1, 0, -1, 0}};
int n, m; // DON'T MAKE THEM IN MAIN
 
bool check(int x, int y) {{
    return x >= 0 && x < n && y >= 0 && y < m;
}}
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {Disjoint Set Union} snippet{{{
  "dsu",
  fmt(
    [[
struct DSU {{
    vector<int> pr;
    int n;
 
    DSU(int n) : n(n) {{
        pr.resize(n);
        iota(pr.begin(), pr.end(), 0);
    }}
 
    inline int findpr(int v) {{
        return (v == pr[v] ? v : (pr[v] = findpr(pr[v])));
    }}
 
    inline bool unite(int v, int u) {{
        v = findpr(v);
        u = findpr(u);
        if (u == v) {{
            return false;
        }} else {{
            pr[v] = u;
            return true;
        }}
    }}
}};
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

----------------------------------
cs( -- {debug output} snippet{{{
  "deb",
  fmt(
    [[
#ifdef ONPC
    void debug_print(string s) {{
        cerr << "\"" << s << "\"";
    }}
 
    void debug_print(const char* s) {{
        debug_print((string)s);
    }}
 
    void debug_print(bool val) {{
        cerr << (val ? "true" : "false");
    }}
 
    void debug_print(int val) {{
        cerr << val;
    }}
 
    void debug_print(ll val) {{
        cerr << val;
    }}
 
    template<typename F, typename S>
    void debug_print(pair<F, S> val) {{
        cerr << "(";
        debug_print(val.first);
        cerr << ", ";
        debug_print(val.second);
        cerr << ")";
    }}
 
    void debug_print(vector<bool> val) {{
        cerr << "{{";
        bool first = true;
        for (bool x : val) {{
            if (!first) {{
                cerr << ", ";
            }} else {{
                first = false;
            }}
            debug_print(x);
        }}
        cerr << "}}";
    }}
 
    template<typename T>
    void debug_print(T val) {{
        cerr << "{{";
        bool first = true;
        for (const auto &x : val) {{
            if (!first) {{
                cerr << ", ";
            }} else {{
                first = false;
            }}
            debug_print(x);
        }}
        cerr << "}}";
    }}
 
    void debug_print_collection() {{
        cerr << endl;
    }}
 
    template<typename First, typename... Args>
    void debug_print_collection(First val, Args... args) {{
        cerr << " ";
        debug_print(val);
        debug_print_collection(args...);
    }}
 
#define debug(...) cerr << "@@@ " << #__VA_ARGS__ << " ="; debug_print_collection(__VA_ARGS__);
 
#else
    #define debug(...) 
#endif
{}
]],
    {
      i(0, ""),
    }
  )
) --}}}
----------------------------------

-- End Refactoring --

return snippets, autosnippets
