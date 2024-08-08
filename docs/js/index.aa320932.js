/*!
 * This source file is part of the Swift.org open source project
 * 
 * Copyright (c) 2021 Apple Inc. and the Swift project authors
 * Licensed under Apache License v2.0 with Runtime Library Exception
 * 
 * See https://swift.org/LICENSE.txt for license information
 * See https://swift.org/CONTRIBUTORS.txt for Swift project authors
 */
(function(e) {
    function t(t) {
        for (var n, i, c = t[0], a = t[1], h = t[2], l = 0, u = []; l < c.length; l++) i = c[l], Object.prototype.hasOwnProperty.call(r, i) && r[i] && u.push(r[i][0]), r[i] = 0;
        for (n in a) Object.prototype.hasOwnProperty.call(a, n) && (e[n] = a[n]);
        d && d(t);
        while (u.length) u.shift()();
        return s.push.apply(s, h || []), o()
    }

    function o() {
        for (var e, t = 0; t < s.length; t++) {
            for (var o = s[t], n = !0, i = 1; i < o.length; i++) {
                var c = o[i];
                0 !== r[c] && (n = !1)
            }
            n && (s.splice(t--, 1), e = a(a.s = o[0]))
        }
        return e
    }
    var n = {},
        i = {
            index: 0
        },
        r = {
            index: 0
        },
        s = [];

    function c(e) {
        return a.p + "js/" + ({
            "documentation-topic~topic~tutorials-overview": "documentation-topic~topic~tutorials-overview",
            "documentation-topic~topic": "documentation-topic~topic",
            "documentation-topic": "documentation-topic",
            topic: "topic",
            "tutorials-overview": "tutorials-overview",
            "highlight-js-bash": "highlight-js-bash",
            "highlight-js-c": "highlight-js-c",
            "highlight-js-cpp": "highlight-js-cpp",
            "highlight-js-css": "highlight-js-css",
            "highlight-js-custom-markdown": "highlight-js-custom-markdown",
            "highlight-js-custom-swift": "highlight-js-custom-swift",
            "highlight-js-diff": "highlight-js-diff",
            "highlight-js-http": "highlight-js-http",
            "highlight-js-java": "highlight-js-java",
            "highlight-js-javascript": "highlight-js-javascript",
            "highlight-js-json": "highlight-js-json",
            "highlight-js-llvm": "highlight-js-llvm",
            "highlight-js-markdown": "highlight-js-markdown",
            "highlight-js-objectivec": "highlight-js-objectivec",
            "highlight-js-perl": "highlight-js-perl",
            "highlight-js-php": "highlight-js-php",
            "highlight-js-python": "highlight-js-python",
            "highlight-js-ruby": "highlight-js-ruby",
            "highlight-js-scss": "highlight-js-scss",
            "highlight-js-shell": "highlight-js-shell",
            "highlight-js-swift": "highlight-js-swift",
            "highlight-js-xml": "highlight-js-xml"
        } [e] || e) + "." + {
            "documentation-topic~topic~tutorials-overview": "5b27b87b",
            "chunk-384ef189": "bb1ed903",
            "documentation-topic~topic": "900fc80c",
            "documentation-topic": "2ed269e3",
            topic: "bb695832",
            "tutorials-overview": "2cadc732",
            "chunk-2d0d3105": "cd72cc8e",
            "highlight-js-bash": "1b52852f",
            "highlight-js-c": "d1db3f17",
            "highlight-js-cpp": "eaddddbe",
            "highlight-js-css": "75eab1fe",
            "highlight-js-custom-markdown": "7cffc4b3",
            "highlight-js-custom-swift": "5cda5c20",
            "highlight-js-diff": "62d66733",
            "highlight-js-http": "163e45b6",
            "highlight-js-java": "8326d9d8",
            "highlight-js-javascript": "acb8a8eb",
            "highlight-js-json": "471128d2",
            "highlight-js-llvm": "6100b125",
            "highlight-js-markdown": "90077643",
            "highlight-js-objectivec": "bcdf5156",
            "highlight-js-perl": "757d7b6f",
            "highlight-js-php": "cc8d6c27",
            "highlight-js-python": "c214ed92",
            "highlight-js-ruby": "f889d392",
            "highlight-js-scss": "62ee18da",
            "highlight-js-shell": "dd7f411f",
            "highlight-js-swift": "84f3e88c",
            "highlight-js-xml": "9c3688c7"
        } [e] + ".js"
    }

    function a(t) {
        if (n[t]) return n[t].exports;
        var o = n[t] = {
            i: t,
            l: !1,
            exports: {}
        };
        return e[t].call(o.exports, o, o.exports, a), o.l = !0, o.exports
    }
    a.e = function(e) {
        var t = [],
            o = {
                "documentation-topic~topic~tutorials-overview": 1,
                "chunk-384ef189": 1,
                "documentation-topic~topic": 1,
                "documentation-topic": 1,
                topic: 1,
                "tutorials-overview": 1
            };
        i[e] ? t.push(i[e]) : 0 !== i[e] && o[e] && t.push(i[e] = new Promise((function(t, o) {
            for (var n = "css/" + ({
                    "documentation-topic~topic~tutorials-overview": "documentation-topic~topic~tutorials-overview",
                    "documentation-topic~topic": "documentation-topic~topic",
                    "documentation-topic": "documentation-topic",
                    topic: "topic",
                    "tutorials-overview": "tutorials-overview",
                    "highlight-js-bash": "highlight-js-bash",
                    "highlight-js-c": "highlight-js-c",
                    "highlight-js-cpp": "highlight-js-cpp",
                    "highlight-js-css": "highlight-js-css",
                    "highlight-js-custom-markdown": "highlight-js-custom-markdown",
                    "highlight-js-custom-swift": "highlight-js-custom-swift",
                    "highlight-js-diff": "highlight-js-diff",
                    "highlight-js-http": "highlight-js-http",
                    "highlight-js-java": "highlight-js-java",
                    "highlight-js-javascript": "highlight-js-javascript",
                    "highlight-js-json": "highlight-js-json",
                    "highlight-js-llvm": "highlight-js-llvm",
                    "highlight-js-markdown": "highlight-js-markdown",
                    "highlight-js-objectivec": "highlight-js-objectivec",
                    "highlight-js-perl": "highlight-js-perl",
                    "highlight-js-php": "highlight-js-php",
                    "highlight-js-python": "highlight-js-python",
                    "highlight-js-ruby": "highlight-js-ruby",
                    "highlight-js-scss": "highlight-js-scss",
                    "highlight-js-shell": "highlight-js-shell",
                    "highlight-js-swift": "highlight-js-swift",
                    "highlight-js-xml": "highlight-js-xml"
                } [e] || e) + "." + {
                    "documentation-topic~topic~tutorials-overview": "1099452b",
                    "chunk-384ef189": "7ede1ea3",
                    "documentation-topic~topic": "fccbd76c",
                    "documentation-topic": "29351f99",
                    topic: "726a35dc",
                    "tutorials-overview": "2a582c39",
                    "chunk-2d0d3105": "31d6cfe0",
                    "highlight-js-bash": "31d6cfe0",
                    "highlight-js-c": "31d6cfe0",
                    "highlight-js-cpp": "31d6cfe0",
                    "highlight-js-css": "31d6cfe0",
                    "highlight-js-custom-markdown": "31d6cfe0",
                    "highlight-js-custom-swift": "31d6cfe0",
                    "highlight-js-diff": "31d6cfe0",
                    "highlight-js-http": "31d6cfe0",
                    "highlight-js-java": "31d6cfe0",
                    "highlight-js-javascript": "31d6cfe0",
                    "highlight-js-json": "31d6cfe0",
                    "highlight-js-llvm": "31d6cfe0",
                    "highlight-js-markdown": "31d6cfe0",
                    "highlight-js-objectivec": "31d6cfe0",
                    "highlight-js-perl": "31d6cfe0",
                    "highlight-js-php": "31d6cfe0",
                    "highlight-js-python": "31d6cfe0",
                    "highlight-js-ruby": "31d6cfe0",
                    "highlight-js-scss": "31d6cfe0",
                    "highlight-js-shell": "31d6cfe0",
                    "highlight-js-swift": "31d6cfe0",
                    "highlight-js-xml": "31d6cfe0"
                } [e] + ".css", r = a.p + n, s = document.getElementsByTagName("link"), c = 0; c < s.length; c++) {
                var h = s[c],
                    l = h.getAttribute("data-href") || h.getAttribute("href");
                if ("stylesheet" === h.rel && (l === n || l === r)) return t()
            }
            var u = document.getElementsByTagName("style");
            for (c = 0; c < u.length; c++) {
                h = u[c], l = h.getAttribute("data-href");
                if (l === n || l === r) return t()
            }
            var d = document.createElement("link");
            d.rel = "stylesheet", d.type = "text/css", d.onload = t, d.onerror = function(t) {
                var n = t && t.target && t.target.src || r,
                    s = new Error("Loading CSS chunk " + e + " failed.\n(" + n + ")");
                s.code = "CSS_CHUNK_LOAD_FAILED", s.request = n, delete i[e], d.parentNode.removeChild(d), o(s)
            }, d.href = r;
            var g = document.getElementsByTagName("head")[0];
            g.appendChild(d)
        })).then((function() {
            i[e] = 0
        })));
        var n = r[e];
        if (0 !== n)
            if (n) t.push(n[2]);
            else {
                var s = new Promise((function(t, o) {
                    n = r[e] = [t, o]
                }));
                t.push(n[2] = s);
                var h, l = document.createElement("script");
                l.charset = "utf-8", l.timeout = 120, a.nc && l.setAttribute("nonce", a.nc), l.src = c(e);
                var u = new Error;
                h = function(t) {
                    l.onerror = l.onload = null, clearTimeout(d);
                    var o = r[e];
                    if (0 !== o) {
                        if (o) {
                            var n = t && ("load" === t.type ? "missing" : t.type),
                                i = t && t.target && t.target.src;
                            u.message = "Loading chunk " + e + " failed.\n(" + n + ": " + i + ")", u.name = "ChunkLoadError", u.type = n, u.request = i, o[1](u)
                        }
                        r[e] = void 0
                    }
                };
                var d = setTimeout((function() {
                    h({
                        type: "timeout",
                        target: l
                    })
                }), 12e4);
                l.onerror = l.onload = h, document.head.appendChild(l)
            } return Promise.all(t)
    }, a.m = e, a.c = n, a.d = function(e, t, o) {
        a.o(e, t) || Object.defineProperty(e, t, {
            enumerable: !0,
            get: o
        })
    }, a.r = function(e) {
        "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
            value: "Module"
        }), Object.defineProperty(e, "__esModule", {
            value: !0
        })
    }, a.t = function(e, t) {
        if (1 & t && (e = a(e)), 8 & t) return e;
        if (4 & t && "object" === typeof e && e && e.__esModule) return e;
        var o = Object.create(null);
        if (a.r(o), Object.defineProperty(o, "default", {
                enumerable: !0,
                value: e
            }), 2 & t && "string" != typeof e)
            for (var n in e) a.d(o, n, function(t) {
                return e[t]
            }.bind(null, n));
        return o
    }, a.n = function(e) {
        var t = e && e.__esModule ? function() {
            return e["default"]
        } : function() {
            return e
        };
        return a.d(t, "a", t), t
    }, a.o = function(e, t) {
        return Object.prototype.hasOwnProperty.call(e, t)
    }, a.p = "{{BASE_PATH}}/", a.oe = function(e) {
        throw console.error(e), e
    };
    var h = window["webpackJsonp"] = window["webpackJsonp"] || [],
        l = h.push.bind(h);
    h.push = t, h = h.slice();
    for (var u = 0; u < h.length; u++) t(h[u]);
    var d = l;
    s.push([0, "chunk-vendors"]), o()
})({
    0: function(e, t, o) {
        e.exports = o("f161")
    },
    "002d": function(e, t, o) {
        "use strict";
        o.d(t, "a", (function() {
            return s
        })), o.d(t, "c", (function() {
            return c
        })), o.d(t, "g", (function() {
            return l
        })), o.d(t, "b", (function() {
            return u
        })), o.d(t, "d", (function() {
            return d
        })), o.d(t, "h", (function() {
            return g
        })), o.d(t, "f", (function() {
            return f
        })), o.d(t, "e", (function() {
            return m
        }));
        o("e7a5");
        const n = /(?:\s+|[`"<>])/g,
            i = /^-+/,
            r = /["'&<>]/g;

        function s(e) {
            return e.trim().replace(n, "-").replace(i, "").toLowerCase()
        }

        function c(e) {
            const t = e => ({
                '"': "&quot;",
                "'": "&apos;",
                "&": "&amp;",
                "<": "&lt;",
                ">": "&gt;"
            } [e] || e);
            return e.replace(r, t)
        }
        const a = {
                zero: "zero",
                one: "one",
                two: "two",
                few: "few",
                many: "many",
                other: "other"
            },
            h = {
                cardinal: "cardinal",
                ordinal: "ordinal"
            };

        function l(e, t) {
            const {
                cardinal: o
            } = h, {
                one: n,
                other: i
            } = a, r = "en", s = 1 === t ? n : i;
            if (!e[r] || !e[r][s]) throw new Error("No default choices provided to pluralize using default locale " + r);
            let c = r,
                l = s;
            if ("Intl" in window && "PluralRules" in window.Intl) {
                const n = navigator.languages ? navigator.languages : [navigator.language],
                    i = new Intl.PluralRules(n, {
                        type: o
                    }),
                    r = i.select(t),
                    s = i.resolvedOptions().locale;
                e[s] && e[s][r] && (c = s, l = r)
            }
            return e[c][l]
        }

        function u(e) {
            return e.replace(/#(.*)/, (e, t) => "#" + CSS.escape(t))
        }

        function d(e) {
            return e.replace(/[.*+\-?^${}()|[\]\\]/g, "\\$&")
        }

        function g(e) {
            let t, o;
            const n = "\\s*",
                i = " ",
                r = e.trim(),
                s = r.length;
            if (!s) return i;
            const c = [];
            for (t = 0; t < s; t += 1) o = r[t], "\\" === o ? (c.push(`${0===t?"":n}${o}`), c.push(r[t + 1]), t += 1) : 0 === t ? c.push(o) : o !== i && c.push(`${n}${o}`);
            return c.join("")
        }

        function f(e, t, o = 0) {
            return `${e.slice(0,o)}${t}${e.slice(o)}`
        }

        function m(e) {
            const t = e.split(/(?:\r?\n)+/);
            return t[0]
        }
    },
    "2de0": function(e, t, o) {
        "use strict";
        o("fb1e")
    },
    3908: function(e, t, o) {
        "use strict";

        function n(e) {
            let t = null,
                o = e - 1;
            const n = new Promise(e => {
                t = e
            });
            return requestAnimationFrame((function e() {
                o -= 1, o <= 0 ? t() : requestAnimationFrame(e)
            })), n
        }

        function i(e) {
            return new Promise(t => {
                setTimeout(t, e)
            })
        }
        o.d(t, "b", (function() {
            return n
        })), o.d(t, "a", (function() {
            return i
        }))
    },
    4009: function(e, t, o) {
        "use strict";
        o.d(t, "a", (function() {
            return n
        }));
        const n = "app-top"
    },
    "48b1": function(e, t, o) {
        "use strict";
        o("e487")
    },
    "5c0b": function(e, t, o) {
        "use strict";
        o("9c0c")
    },
    "5d2d": function(e, t, o) {
        "use strict";
        o.d(t, "a", (function() {
            return s
        })), o.d(t, "c", (function() {
            return a
        })), o.d(t, "b", (function() {
            return h
        }));
        const n = "developer.setting.";

        function i(e = localStorage) {
            return {
                getItem: t => {
                    try {
                        return e.getItem(t)
                    } catch (o) {
                        return null
                    }
                },
                setItem: (t, o) => {
                    try {
                        e.setItem(t, o)
                    } catch (n) {}
                },
                removeItem: t => {
                    try {
                        e.removeItem(t)
                    } catch (o) {}
                }
            }
        }

        function r(e) {
            return {
                get: (t, o) => {
                    const i = JSON.parse(e.getItem(n + t));
                    return null !== i ? i : o
                },
                set: (t, o) => e.setItem(n + t, JSON.stringify(o)),
                remove: t => e.removeItem(n + t)
            }
        }
        const s = i(window.localStorage),
            c = i(window.sessionStorage),
            a = r(s),
            h = r(c)
    },
    6131: function(e, t, o) {
        "use strict";
        o("f8ba")
    },
    "613f": function(e, t, o) {},
    "63b8": function(e, t, o) {
        "use strict";
        o.d(t, "b", (function() {
            return n
        })), o.d(t, "c", (function() {
            return i
        })), o.d(t, "a", (function() {
            return r
        })), o.d(t, "d", (function() {
            return c
        }));
        const n = {
                large: "large",
                medium: "medium",
                small: "small"
            },
            i = {
                default: "default",
                nav: "nav"
            },
            r = {
                [i.default]: {
                    [n.large]: {
                        minWidth: 1069,
                        contentWidth: 980
                    },
                    [n.medium]: {
                        minWidth: 736,
                        maxWidth: 1068,
                        contentWidth: 692
                    },
                    [n.small]: {
                        minWidth: 320,
                        maxWidth: 735,
                        contentWidth: 280
                    }
                },
                [i.nav]: {
                    [n.large]: {
                        minWidth: 1024
                    },
                    [n.medium]: {
                        minWidth: 768,
                        maxWidth: 1023
                    },
                    [n.small]: {
                        minWidth: 320,
                        maxWidth: 767
                    }
                }
            },
            s = {
                [n.small]: 0,
                [n.medium]: 1,
                [n.large]: 2
            };

        function c(e, t) {
            return s[e] > s[t]
        }
    },
    6842: function(e, t, o) {
        "use strict";

        function n(e, t, o) {
            let n, i = e,
                r = t;
            for ("string" === typeof r && (r = [r]), n = 0; n < r.length; n += 1) {
                if ("undefined" === typeof i[r[n]]) return o;
                i = i[r[n]]
            }
            return i
        }
        o.d(t, "d", (function() {
            return i
        })), o.d(t, "a", (function() {
            return r
        })), o.d(t, "b", (function() {
            return s
        })), o.d(t, "c", (function() {
            return c
        }));
        const i = {
                meta: {},
                theme: {},
                features: {}
            },
            {
                baseUrl: r
            } = window;
        async function s() {
            const e = new URL(r + "theme-settings.json", window.location.href);
            return fetch(e.href).then(e => e.json()).catch(() => ({}))
        }
        const c = (e, t) => n(i, e, t)
    },
    7138: function(e, t, o) {
        "use strict";
        o("813c")
    },
    "748c": function(e, t, o) {
        "use strict";
        o.d(t, "e", (function() {
            return i
        })), o.d(t, "a", (function() {
            return r
        })), o.d(t, "d", (function() {
            return s
        })), o.d(t, "c", (function() {
            return c
        })), o.d(t, "f", (function() {
            return a
        })), o.d(t, "b", (function() {
            return h
        }));
        var n = o("6842");

        function i(e) {
            return e.reduce((e, t) => (t.traits.includes("dark") ? e.dark.push(t) : e.light.push(t), e), {
                light: [],
                dark: []
            })
        }

        function r(e) {
            const t = ["1x", "2x", "3x"];
            return t.reduce((t, o) => {
                const n = e.find(e => e.traits.includes(o));
                return n ? t.concat({
                    density: o,
                    src: n.url,
                    size: n.size
                }) : t
            }, [])
        }

        function s(e) {
            const t = "/",
                o = new RegExp(t + "+", "g");
            return e.join(t).replace(o, t)
        }

        function c(e) {
            return e && "string" === typeof e && !e.startsWith(n["a"]) && e.startsWith("/") ? s([n["a"], e]) : e
        }

        function a(e) {
            return e ? `url('${c(e)}')` : void 0
        }

        function h(e) {
            return new Promise((t, o) => {
                const n = new Image;
                n.src = e, n.onerror = o, n.onload = () => t({
                    width: n.width,
                    height: n.height
                })
            })
        }
    },
    "813c": function(e, t, o) {},
    "821b": function(e, t, o) {
        "use strict";
        t["a"] = {
            auto: {
                label: "Auto",
                value: "auto"
            },
            dark: {
                label: "Dark",
                value: "dark"
            },
            light: {
                label: "Light",
                value: "light"
            }
        }
    },
    "942d": function(e, t, o) {
        "use strict";
        o.d(t, "b", (function() {
            return n
        })), o.d(t, "c", (function() {
            return i
        })), o.d(t, "e", (function() {
            return r
        })), o.d(t, "d", (function() {
            return s
        })), o.d(t, "a", (function() {
            return c
        }));
        const n = 52,
            i = 48,
            r = "nav-sticky-anchor",
            s = "nav-open-navigator",
            c = {
                noClose: "noclose"
            }
    },
    9895: function(e, t, o) {
        "use strict";
        o.d(t, "b", (function() {
            return n
        })), o.d(t, "a", (function() {
            return i
        }));
        const n = "not-found",
            i = "documentation-topic"
    },
    "9c0c": function(e, t, o) {},
    a5c6: function(e, t, o) {
        "use strict";
        o("613f")
    },
    d26a: function(e, t, o) {
        "use strict";
        o.d(t, "c", (function() {
            return r
        })), o.d(t, "b", (function() {
            return s
        })), o.d(t, "a", (function() {
            return c
        })), o.d(t, "d", (function() {
            return a
        }));
        var n = o("748c"),
            i = {
                input: "input",
                tags: "tags"
            };

        function r(e = {}) {
            return Object.entries(e).reduce((e, [t, o]) => o ? e.concat(`${encodeURIComponent(t)}=${encodeURIComponent(o)}`) : e, []).join("&")
        }

        function s(e, {
            changes: t,
            language: o,
            context: n
        } = {}) {
            const [i, s] = e.split("#"), c = i.match(/\?.*/), a = r({
                changes: t,
                language: o,
                context: n
            }), h = c ? "&" : "?", l = s ? i : e, u = a ? `${h}${a}` : "", d = s ? "#" + s : "";
            return `${l}${u}${d}`
        }

        function c(e, t) {
            const {
                query: {
                    changes: o,
                    [i.input]: n,
                    [i.tags]: r,
                    ...s
                } = {}
            } = e, {
                query: {
                    changes: c,
                    [i.input]: a,
                    [i.tags]: h,
                    ...l
                } = {}
            } = t;
            return e.name === t.name && JSON.stringify({
                path: e.path,
                query: s
            }) === JSON.stringify({
                path: t.path,
                query: l
            })
        }

        function a(e, t = window.location.origin) {
            return new URL(Object(n["c"])(e), t).href
        }
    },
    d369: function(e, t, o) {
        "use strict";
        var n = o("5d2d");
        const i = {
                preferredColorScheme: "developer.setting.preferredColorScheme",
                preferredLanguage: "docs.setting.preferredLanguage"
            },
            r = {
                preferredColorScheme: "docs.setting.preferredColorScheme"
            };
        t["a"] = Object.defineProperties({}, Object.keys(i).reduce((e, t) => ({
            ...e,
            [t]: {
                get: () => {
                    const e = r[t],
                        o = n["a"].getItem(i[t]);
                    return e ? o || n["a"].getItem(e) : o
                },
                set: e => n["a"].setItem(i[t], e)
            }
        }), {}))
    },
    dd18: function(e, t, o) {
        "use strict";
        t["a"] = {
            eager: "eager",
            lazy: "lazy"
        }
    },
    e425: function(e, t, o) {
        "use strict";
        var n = o("821b"),
            i = o("dd18"),
            r = o("d369");
        const s = "undefined" !== typeof window.matchMedia && [n["a"].light.value, n["a"].dark.value, "no-preference"].some(e => window.matchMedia(`(prefers-color-scheme: ${e})`).matches),
            c = s ? n["a"].auto : n["a"].light;
        t["a"] = {
            state: {
                imageLoadingStrategy: i["a"].lazy,
                preferredColorScheme: r["a"].preferredColorScheme || c.value,
                supportsAutoColorScheme: s,
                systemColorScheme: n["a"].light.value
            },
            setImageLoadingStrategy(e) {
                this.state.imageLoadingStrategy = e
            },
            setPreferredColorScheme(e) {
                this.state.preferredColorScheme = e, r["a"].preferredColorScheme = e
            },
            setSystemColorScheme(e) {
                this.state.systemColorScheme = e
            },
            syncPreferredColorScheme() {
                r["a"].preferredColorScheme && r["a"].preferredColorScheme !== this.state.preferredColorScheme && (this.state.preferredColorScheme = r["a"].preferredColorScheme)
            }
        }
    },
    e487: function(e, t, o) {},
    ed96: function(e, t, o) {
        o.p = window.baseUrl
    },
    f161: function(e, t, o) {
        "use strict";
        o.r(t);
        o("ed96");
        var n = o("2b0e"),
            i = o("8c4f"),
            r = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return o("div", {
                    class: {
                        fromkeyboard: e.fromKeyboard,
                        hascustomheader: e.hasCustomHeader
                    },
                    attrs: {
                        id: "app"
                    }
                }, [o("div", {
                    attrs: {
                        id: e.AppTopID
                    }
                }), o("a", {
                    attrs: {
                        href: "#main",
                        id: "skip-nav"
                    }
                }, [e._v("Skip Navigation")]), o("InitialLoadingPlaceholder"), e._t("header", (function() {
                    return [e.hasCustomHeader ? o("custom-header", {
                        attrs: {
                            "data-color-scheme": e.preferredColorScheme
                        }
                    }) : e._e()]
                }), {
                    isTargetIDE: e.isTargetIDE
                }), o("div", {
                    attrs: {
                        id: e.baseNavStickyAnchorId
                    }
                }), e._t("default", (function() {
                    return [o("router-view", {
                        staticClass: "router-content"
                    }), e.hasCustomFooter ? o("custom-footer", {
                        attrs: {
                            "data-color-scheme": e.preferredColorScheme
                        }
                    }) : e.isTargetIDE ? e._e() : o("Footer")]
                }), {
                    isTargetIDE: e.isTargetIDE
                }), e._t("footer", null, {
                    isTargetIDE: e.isTargetIDE
                })], 2)
            },
            s = [],
            c = o("e425"),
            a = o("821b"),
            h = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return o("footer", {
                    staticClass: "footer"
                }, [o("div", {
                    staticClass: "row"
                }, [o("ColorSchemeToggle")], 1)])
            },
            l = [],
            u = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return o("div", {
                    staticClass: "color-scheme-toggle",
                    attrs: {
                        "aria-label": "Select a color scheme preference",
                        role: "radiogroup"
                    }
                }, e._l(e.options, (function(t) {
                    return o("label", {
                        key: t.value
                    }, [o("input", {
                        attrs: {
                            type: "radio"
                        },
                        domProps: {
                            checked: t.value == e.preferredColorScheme,
                            value: t.value
                        },
                        on: {
                            input: e.setPreferredColorScheme
                        }
                    }), o("div", {
                        staticClass: "text"
                    }, [e._v(e._s(t.label))])])
                })), 0)
            },
            d = [],
            g = {
                name: "ColorSchemeToggle",
                data: () => ({
                    appState: c["a"].state
                }),
                computed: {
                    options: ({
                        supportsAutoColorScheme: e
                    }) => [a["a"].light, a["a"].dark, ...e ? [a["a"].auto] : []],
                    preferredColorScheme: ({
                        appState: e
                    }) => e.preferredColorScheme,
                    supportsAutoColorScheme: ({
                        appState: e
                    }) => e.supportsAutoColorScheme
                },
                methods: {
                    setPreferredColorScheme: e => {
                        c["a"].setPreferredColorScheme(e.target.value)
                    }
                },
                watch: {
                    preferredColorScheme: {
                        immediate: !0,
                        handler(e) {
                            document.body.dataset.colorScheme = e
                        }
                    }
                }
            },
            f = g,
            m = (o("6131"), o("2877")),
            p = Object(m["a"])(f, u, d, !1, null, "8890c4d6", null),
            j = p.exports,
            v = {
                name: "Footer",
                components: {
                    ColorSchemeToggle: j
                }
            },
            w = v,
            b = (o("2de0"), Object(m["a"])(w, h, l, !1, null, "72f2e2dc", null)),
            y = b.exports,
            S = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return e.loaded ? e._e() : o("div", {
                    staticClass: "InitialLoadingPlaceholder",
                    attrs: {
                        id: "loading-placeholder"
                    }
                })
            },
            E = [],
            C = {
                name: "InitialLoadingPlaceholder",
                data() {
                    return {
                        loaded: !1
                    }
                },
                created() {
                    const e = () => {
                        this.loaded = !0
                    };
                    this.$router.onReady(e, e)
                }
            },
            _ = C,
            P = (o("48b1"), Object(m["a"])(_, S, E, !1, null, "35c356b6", null)),
            T = P.exports,
            k = o("942d"),
            O = o("6842");

        function A(e, t) {
            return e && "object" === typeof e && Object.prototype.hasOwnProperty.call(e, t) && "string" === typeof e[t]
        }

        function I(e, t, o, n) {
            if (!t || "object" !== typeof t || n && (A(t, "light") || A(t, "dark"))) {
                let i = t;
                if (A(t, n) && (i = t[n]), "object" === typeof i) return;
                o[e] = i
            } else Object.entries(t).forEach(([t, i]) => {
                const r = [e, t].join("-");
                I(r, i, o, n)
            })
        }

        function L(e, t = "light") {
            const o = {},
                n = e || {};
            return I("-", n, o, t), o
        }
        var x = o("4009"),
            D = {
                name: "CoreApp",
                components: {
                    Footer: y,
                    InitialLoadingPlaceholder: T
                },
                provide() {
                    return {
                        isTargetIDE: this.isTargetIDE,
                        performanceMetricsEnabled: "true" === Object({
                            NODE_ENV: "production",
                            VUE_APP_TITLE: "Documentation",
                            BASE_URL: "{{BASE_PATH}}/"
                        }).VUE_APP_PERFORMANCE_ENABLED
                    }
                },
                data() {
                    return {
                        AppTopID: x["a"],
                        appState: c["a"].state,
                        fromKeyboard: !1,
                        isTargetIDE: "ide" === Object({
                            NODE_ENV: "production",
                            VUE_APP_TITLE: "Documentation",
                            BASE_URL: "{{BASE_PATH}}/"
                        }).VUE_APP_TARGET,
                        themeSettings: O["d"],
                        baseNavStickyAnchorId: k["e"]
                    }
                },
                computed: {
                    currentColorScheme: ({
                        appState: e
                    }) => e.systemColorScheme,
                    preferredColorScheme: ({
                        appState: e
                    }) => e.preferredColorScheme,
                    CSSCustomProperties: ({
                        currentColorScheme: e,
                        preferredColorScheme: t,
                        themeSettings: o
                    }) => L(o.theme, t === a["a"].auto.value ? e : t),
                    hasCustomHeader: () => !!window.customElements.get("custom-header"),
                    hasCustomFooter: () => !!window.customElements.get("custom-footer")
                },
                props: {
                    enableThemeSettings: {
                        type: Boolean,
                        default: !0
                    }
                },
                watch: {
                    CSSCustomProperties: {
                        immediate: !0,
                        handler(e) {
                            this.detachStylesFromRoot(e), this.attachStylesToRoot(e)
                        }
                    }
                },
                async created() {
                    window.addEventListener("keydown", this.onKeyDown), this.$bridge.on("navigation", this.handleNavigationRequest), this.enableThemeSettings && Object.assign(this.themeSettings, await Object(O["b"])()), window.addEventListener("pageshow", this.syncPreferredColorScheme), this.$once("hook:beforeDestroy", () => {
                        window.removeEventListener("pageshow", this.syncPreferredColorScheme)
                    })
                },
                mounted() {
                    (document.querySelector(".footer-current-year") || {}).innerText = (new Date).getFullYear(), this.attachColorSchemeListeners()
                },
                beforeDestroy() {
                    this.fromKeyboard ? window.removeEventListener("mousedown", this.onMouseDown) : window.removeEventListener("keydown", this.onKeyDown), this.$bridge.off("navigation", this.handleNavigationRequest), this.detachStylesFromRoot(this.CSSCustomProperties)
                },
                methods: {
                    onKeyDown() {
                        this.fromKeyboard = !0, window.addEventListener("mousedown", this.onMouseDown), window.removeEventListener("keydown", this.onKeyDown)
                    },
                    onMouseDown() {
                        this.fromKeyboard = !1, window.addEventListener("keydown", this.onKeyDown), window.removeEventListener("mousedown", this.onMouseDown)
                    },
                    handleNavigationRequest(e) {
                        this.$router.push(e)
                    },
                    attachColorSchemeListeners() {
                        if (!window.matchMedia) return;
                        const e = window.matchMedia("(prefers-color-scheme: dark)");
                        e.addListener(this.onColorSchemePreferenceChange), this.$once("hook:beforeDestroy", () => {
                            e.removeListener(this.onColorSchemePreferenceChange)
                        }), this.onColorSchemePreferenceChange(e)
                    },
                    onColorSchemePreferenceChange({
                        matches: e
                    }) {
                        const t = e ? a["a"].dark : a["a"].light;
                        c["a"].setSystemColorScheme(t.value)
                    },
                    attachStylesToRoot(e) {
                        const t = document.body;
                        Object.entries(e).filter(([, e]) => Boolean(e)).forEach(([e, o]) => {
                            t.style.setProperty(e, o)
                        })
                    },
                    detachStylesFromRoot(e) {
                        const t = document.body;
                        Object.entries(e).forEach(([e]) => {
                            t.style.removeProperty(e)
                        })
                    },
                    syncPreferredColorScheme() {
                        c["a"].syncPreferredColorScheme()
                    }
                }
            },
            $ = D,
            N = (o("5c0b"), o("a5c6"), Object(m["a"])($, r, s, !1, null, "0a4c340a", null)),
            R = N.exports;
        class U {
            constructor() {
                this.$send = () => {}
            }
            send(e) {
                this.$send(e)
            }
        }
        class M {
            constructor() {
                const {
                    webkit: {
                        messageHandlers: {
                            bridge: e = {}
                        } = {}
                    } = {}
                } = window;
                this.bridge = e;
                const {
                    postMessage: t = (() => {})
                } = e;
                this.$send = t.bind(e)
            }
            send(e) {
                this.$send(e)
            }
        }
        class B {
            constructor(e = new U) {
                this.backend = e, this.listeners = {}
            }
            send(e) {
                this.backend.send(e)
            }
            receive(e) {
                this.emit(e.type, e.data)
            }
            emit(e, t) {
                this.listeners[e] && this.listeners[e].forEach(e => e(t))
            }
            on(e, t) {
                this.listeners[e] || (this.listeners[e] = new Set), this.listeners[e].add(t)
            }
            off(e, t) {
                this.listeners[e] && this.listeners[e].delete(t)
            }
        }
        var W = {
            install(e, t) {
                let o;
                o = t.performanceMetricsEnabled || "ide" === t.appTarget ? new M : new U, e.prototype.$bridge = new B(o)
            }
        };

        function V(e) {
            return "custom-" + e
        }

        function q(e) {
            return class extends HTMLElement {
                constructor() {
                    super();
                    const t = this.attachShadow({
                            mode: "open"
                        }),
                        o = e.content.cloneNode(!0);
                    t.appendChild(o)
                }
            }
        }

        function F(e) {
            const t = V(e),
                o = document.getElementById(t);
            o && window.customElements.define(t, q(o))
        }

        function H(e, t = {
            names: ["header", "footer"]
        }) {
            const {
                names: o
            } = t;
            e.config.ignoredElements = /^custom-/, o.forEach(F)
        }

        function K(e, t) {
            const {
                value: o = !1
            } = t;
            e.style.display = o ? "none" : ""
        }
        var G = {
            hide: K
        };

        function z(e, {
            performanceMetrics: t = !1
        } = {}) {
            e.config.productionTip = !1, e.use(H), e.directive("hide", G.hide), e.use(W, {
                appTarget: Object({
                    NODE_ENV: "production",
                    VUE_APP_TITLE: "Documentation",
                    BASE_URL: "{{BASE_PATH}}/"
                }).VUE_APP_TARGET,
                performanceMetricsEnabled: t
            }), window.bridge = e.prototype.$bridge, e.config.performance = t
        }
        var J = o("9895"),
            Y = o("63b8"),
            X = o("3908"),
            Q = o("002d"),
            Z = o("d26a");
        const ee = 10;

        function te(e) {
            const {
                name: t
            } = e, o = t.includes(J["a"]);
            return o ? ee : 0
        }

        function oe() {
            const {
                location: e
            } = window;
            return e.pathname + e.search + e.hash
        }

        function ne() {
            const e = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0);
            return e < Y["a"].nav.small.maxWidth ? k["c"] : k["b"]
        }
        async function ie(e, t, o) {
            if (o) return await this.app.$nextTick(), o;
            if (e.hash) {
                const {
                    name: t,
                    query: o,
                    hash: n
                } = e, i = t.includes(J["a"]), r = !!o.changes, s = ne(), c = i && r ? s : 0, a = s + c + te(e), h = "ide" === Object({
                    NODE_ENV: "production",
                    VUE_APP_TITLE: "Documentation",
                    BASE_URL: "{{BASE_PATH}}/"
                }).VUE_APP_TARGET ? 0 : a;
                return {
                    selector: Object(Q["b"])(n),
                    offset: {
                        x: 0,
                        y: h
                    }
                }
            }
            return !Object(Z["a"])(e, t) && {
                x: 0,
                y: 0
            }
        }
        async function re() {
            let e = window.sessionStorage.getItem("scrollPosition");
            if (e) {
                try {
                    e = JSON.parse(e)
                } catch (t) {
                    return void console.error("Error parsing scrollPosition from sessionStorage", t)
                }
                oe() === e.location && (await Object(X["b"])(2), window.scrollTo(e.x, e.y))
            }
        }

        function se() {
            window.location.hash || sessionStorage.setItem("scrollPosition", JSON.stringify({
                x: window.pageXOffset,
                y: window.pageYOffset,
                location: oe()
            }))
        }
        var ce = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return o("GenericError")
            },
            ae = [],
            he = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return o("div", {
                    staticClass: "generic-error"
                }, [o("div", {
                    staticClass: "container"
                }, [o("h1", {
                    staticClass: "title error-content"
                }, [e._v(e._s(e.message))]), e._t("default")], 2)])
            },
            le = [],
            ue = {
                name: "GenericError",
                props: {
                    message: {
                        type: String,
                        default: "An unknown error occurred."
                    }
                }
            },
            de = ue,
            ge = (o("7138"), Object(m["a"])(de, he, le, !1, null, "790053de", null)),
            fe = ge.exports,
            me = {
                name: "ServerError",
                components: {
                    GenericError: fe
                }
            },
            pe = me,
            je = Object(m["a"])(pe, ce, ae, !1, null, null, null),
            ve = je.exports,
            we = function() {
                var e = this,
                    t = e.$createElement,
                    o = e._self._c || t;
                return o("GenericError", {
                    attrs: {
                        message: "The page you’re looking for can’t be found."
                    }
                }, [e._t("default")], 2)
            },
            be = [],
            ye = {
                name: "NotFound",
                components: {
                    GenericError: fe
                }
            },
            Se = ye,
            Ee = Object(m["a"])(Se, we, be, !1, null, null, null),
            Ce = Ee.exports,
            _e = [{
                path: "/tutorials/:id",
                name: "tutorials-overview",
                component: () => Promise.all([o.e("documentation-topic~topic~tutorials-overview"), o.e("tutorials-overview")]).then(o.bind(null, "f025"))
            }, {
                path: "/tutorials/:id/*",
                name: "topic",
                component: () => Promise.all([o.e("documentation-topic~topic~tutorials-overview"), o.e("documentation-topic~topic"), o.e("topic")]).then(o.bind(null, "3213"))
            }, {
                path: "/documentation/*",
                name: J["a"],
                component: () => Promise.all([o.e("documentation-topic~topic~tutorials-overview"), o.e("chunk-384ef189"), o.e("documentation-topic~topic"), o.e("documentation-topic")]).then(o.bind(null, "f8ac"))
            }, {
                path: "*",
                name: J["b"],
                component: Ce
            }, {
                path: "*",
                name: "server-error",
                component: ve
            }];

        function Pe(e = {}) {
            const t = new i["a"]({
                mode: "history",
                base: O["a"],
                scrollBehavior: ie,
                ...e,
                routes: e.routes || _e
            });
            return t.onReady(() => {
                "scrollRestoration" in window.history && (window.history.scrollRestoration = "manual"), re()
            }), "ide" !== Object({
                NODE_ENV: "production",
                VUE_APP_TITLE: "Documentation",
                BASE_URL: "{{BASE_PATH}}/"
            }).VUE_APP_TARGET && t.onError(e => {
                const {
                    route: o = {
                        path: "/"
                    }
                } = e;
                t.replace({
                    name: "server-error",
                    params: [o.path]
                })
            }), window.addEventListener("unload", se), t
        }
        n["default"].use(z), n["default"].use(i["a"]), new n["default"]({
            router: Pe(),
            render: e => e(R)
        }).$mount("#app")
    },
    f8ba: function(e, t, o) {},
    fb1e: function(e, t, o) {}
});
*/
