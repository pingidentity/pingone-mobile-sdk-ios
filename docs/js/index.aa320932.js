/*!
 * This source file is part of the Swift.org open source project
 *
 * Copyright (c) 2021 Apple Inc. and the Swift project authors
 * Licensed under Apache License v2.0 with Runtime Library Exception
 *
 * See https://swift.org/LICENSE.txt for license information
 * See https://swift.org/CONTRIBUTORS.txt for Swift project authors
 */
(function() {
    var e = {
        1970: function(e, t, n) {
            "use strict";
            n.d(t, {
                Z: function() {
                    return u
                }
            });
            var r = function() {
                var e = this
                  , t = e._self._c;
                return t("SVGIcon", {
                    staticClass: "close-icon",
                    attrs: {
                        viewBox: "0 0 14 14",
                        themeId: "close"
                    }
                }, [t("path", {
                    attrs: {
                        d: "M12.73,0l1.27,1.27-5.74,5.73,5.72,5.72-1.27,1.27-5.72-5.72L1.28,13.99,.01,12.72,5.72,7.01,0,1.28,1.27,.01,6.99,5.73,12.73,0Z"
                    }
                })])
            }
              , o = []
              , i = n(9742)
              , a = {
                name: "CloseIcon",
                components: {
                    SVGIcon: i.Z
                }
            }
              , s = a
              , l = n(1001)
              , c = (0,
            l.Z)(s, r, o, !1, null, null, null)
              , u = c.exports
        },
        8785: function(e, t, n) {
            "use strict";
            n.d(t, {
                Z: function() {
                    return u
                }
            });
            var r = function() {
                var e = this
                  , t = e._self._c;
                return t("SVGIcon", {
                    staticClass: "inline-chevron-right-icon",
                    attrs: {
                        viewBox: "0 0 14 14",
                        themeId: "inline-chevron-right"
                    }
                }, [t("path", {
                    attrs: {
                        d: "M2.964 1.366l0.649-0.76 7.426 6.343-7.423 6.445-0.655-0.755 6.545-5.683-6.542-5.59z"
                    }
                })])
            }
              , o = []
              , i = n(9742)
              , a = {
                name: "InlineChevronRightIcon",
                components: {
                    SVGIcon: i.Z
                }
            }
              , s = a
              , l = n(1001)
              , c = (0,
            l.Z)(s, r, o, !1, null, null, null)
              , u = c.exports
        },
        9742: function(e, t, n) {
            "use strict";
            n.d(t, {
                Z: function() {
                    return u
                }
            });
            var r = function() {
                var e = this
                  , t = e._self._c;
                return t("svg", {
                    staticClass: "svg-icon",
                    attrs: {
                        "aria-hidden": "true",
                        xmlns: "http://www.w3.org/2000/svg",
                        "xmlns:xlink": "http://www.w3.org/1999/xlink"
                    }
                }, [e.themeOverrideURL ? t("use", {
                    attrs: {
                        href: `${e.themeOverrideURL}#${e.themeId}`,
                        width: "100%",
                        height: "100%"
                    }
                }) : e._t("default")], 2)
            }
              , o = []
              , i = n(9089)
              , a = {
                name: "SVGIcon",
                props: {
                    themeId: {
                        type: String,
                        required: !1
                    },
                    iconUrl: {
                        type: String,
                        default: null
                    }
                },
                computed: {
                    themeOverrideURL: ({iconUrl: e, themeId: t})=>e || (0,
                    i.$8)(["theme", "icons", t], void 0)
                }
            }
              , s = a
              , l = n(1001)
              , c = (0,
            l.Z)(s, r, o, !1, null, "3434f4d2", null)
              , u = c.exports
        },
        7441: function(e, t, n) {
            "use strict";
            n(647);
            var r = n(144)
              , o = n(7152)
              , i = n(8345)
              , a = function() {
                var e = this
                  , t = e._self._c;
                return t("div", {
                    class: {
                        fromkeyboard: e.fromKeyboard,
                        hascustomheader: e.hasCustomHeader
                    },
                    attrs: {
                        id: "app"
                    }
                }, [t("div", {
                    attrs: {
                        id: e.AppTopID
                    }
                }), e.isTargetIDE ? e._e() : t("a", {
                    attrs: {
                        href: "#main",
                        id: "skip-nav"
                    }
                }, [e._v(e._s(e.$t("accessibility.skip-navigation")))]), t("InitialLoadingPlaceholder"), e._t("header", (function() {
                    return [e.enablei18n ? t("SuggestLang") : e._e(), e.hasCustomHeader ? t("custom-header", {
                        attrs: {
                            "data-color-scheme": e.preferredColorScheme
                        }
                    }) : e._e()]
                }
                ), {
                    isTargetIDE: e.isTargetIDE
                }), t("div", {
                    attrs: {
                        id: e.baseNavStickyAnchorId
                    }
                }), e._t("default", (function() {
                    return [t("router-view", {
                        staticClass: "router-content"
                    }), e.hasCustomFooter ? t("custom-footer", {
                        attrs: {
                            "data-color-scheme": e.preferredColorScheme
                        }
                    }) : e.isTargetIDE ? e._e() : t("Footer", {
                        scopedSlots: e._u([{
                            key: "default",
                            fn: function({className: n}) {
                                return [e.enablei18n ? t("div", {
                                    class: n
                                }, [t("LocaleSelector")], 1) : e._e()]
                            }
                        }])
                    })]
                }
                ), {
                    isTargetIDE: e.isTargetIDE
                }), e._t("footer", null, {
                    isTargetIDE: e.isTargetIDE
                })], 2)
            }
              , s = []
              , l = n(4030)
              , c = n(9804)
              , u = function() {
                var e = this
                  , t = e._self._c;
                return t("footer", {
                    staticClass: "footer"
                }, [t("div", {
                    staticClass: "row"
                }, [t("ColorSchemeToggle")], 1), e._t("default", null, {
                    className: "row"
                })], 2)
            }
              , d = []
              , m = function() {
                var e = this
                  , t = e._self._c;
                return t("fieldset", {
                    staticClass: "color-scheme-toggle",
                    attrs: {
                        role: "radiogroup"
                    }
                }, [t("legend", {
                    staticClass: "visuallyhidden"
                }, [e._v(e._s(e.$t("color-scheme.select")))]), e._l(e.options, (function(n) {
                    return t("label", {
                        key: n
                    }, [t("input", {
                        attrs: {
                            type: "radio"
                        },
                        domProps: {
                            checked: n == e.preferredColorScheme,
                            value: n
                        },
                        on: {
                            input: e.setPreferredColorScheme
                        }
                    }), t("div", {
                        staticClass: "text"
                    }, [e._v(e._s(e.$t(`color-scheme.${n}`)))])])
                }
                ))], 2)
            }
              , p = []
              , h = {
                name: "ColorSchemeToggle",
                data: ()=>({
                    appState: l["default"].state
                }),
                computed: {
                    options: ({supportsAutoColorScheme: e})=>[c.Z.light, c.Z.dark, ...e ? [c.Z.auto] : []],
                    preferredColorScheme: ({appState: e})=>e.preferredColorScheme,
                    supportsAutoColorScheme: ({appState: e})=>e.supportsAutoColorScheme
                },
                methods: {
                    setPreferredColorScheme: e=>{
                        l["default"].setPreferredColorScheme(e.target.value)
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
            }
              , f = h
              , g = n(1001)
              , v = (0,
            g.Z)(f, m, p, !1, null, "0c0360ce", null)
              , b = v.exports
              , w = {
                name: "Footer",
                components: {
                    ColorSchemeToggle: b
                }
            }
              , y = w
              , S = (0,
            g.Z)(y, u, d, !1, null, "f1d65b2a", null)
              , C = S.exports
              , _ = function() {
                var e = this
                  , t = e._self._c;
                return e.loaded ? e._e() : t("div", {
                    staticClass: "InitialLoadingPlaceholder",
                    attrs: {
                        id: "loading-placeholder"
                    }
                })
            }
              , E = []
              , k = {
                name: "InitialLoadingPlaceholder",
                data() {
                    return {
                        loaded: !1
                    }
                },
                created() {
                    const e = ()=>{
                        this.loaded = !0
                    }
                    ;
                    this.$router.onReady(e, e)
                }
            }
              , A = k
              , P = (0,
            g.Z)(A, _, E, !1, null, "35c356b6", null)
              , L = P.exports
              , T = n(1716)
              , j = n(9089);
            function x(e, t) {
                return e && "object" === typeof e && Object.prototype.hasOwnProperty.call(e, t) && "string" === typeof e[t]
            }
            function I(e, t, n, r) {
                if (!t || "object" !== typeof t || r && (x(t, "light") || x(t, "dark"))) {
                    let o = t;
                    if (x(t, r) && (o = t[r]),
                    "object" === typeof o)
                        return;
                    n[e] = o
                } else
                    Object.entries(t).forEach((([t,o])=>{
                        const i = [e, t].join("-");
                        I(i, o, n, r)
                    }
                    ))
            }
            function N(e, t="light") {
                const n = {}
                  , r = e || {};
                return I("-", r, n, t),
                n
            }
            var $ = n(2717)
              , O = function() {
                var e = this
                  , t = e._self._c;
                return e.displaySuggestLang ? t("div", {
                    staticClass: "suggest-lang"
                }, [t("div", {
                    staticClass: "suggest-lang__wrapper"
                }, [t("router-link", {
                    staticClass: "suggest-lang__link",
                    attrs: {
                        to: e.getLocaleParam(e.preferredLocale),
                        lang: e.getCodeForSlug(e.preferredLocale)
                    },
                    nativeOn: {
                        click: function(t) {
                            return e.setPreferredLocale(e.preferredLocale)
                        }
                    }
                }, [e._v(e._s(e.$i18n.messages[e.preferredLocale]["view-in"])), t("InlineChevronRightIcon", {
                    staticClass: "icon-inline"
                })], 1), t("div", {
                    staticClass: "suggest-lang__close-icon-wrapper"
                }, [t("button", {
                    staticClass: "suggest-lang__close-icon-button",
                    attrs: {
                        "aria-label": e.$t("continue-viewing")
                    },
                    on: {
                        click: function(t) {
                            return e.setPreferredLocale(e.$i18n.locale)
                        }
                    }
                }, [t("CloseIcon", {
                    staticClass: "icon-inline"
                })], 1)])], 1)]) : e._e()
            }
              , R = []
              , D = n(8785)
              , Z = n(1970)
              , q = n(2412)
              , U = n(9030)
              , V = {
                name: "SuggestLang",
                components: {
                    InlineChevronRightIcon: D.Z,
                    CloseIcon: Z.Z
                },
                computed: {
                    preferredLocale: ()=>{
                        const e = l["default"].state.preferredLocale;
                        if (e)
                            return e;
                        const t = q.find((e=>{
                            const t = e.code.split("-")[0]
                              , n = window.navigator.language.split("-")[0];
                            return n === t
                        }
                        ));
                        return t ? t.slug : null
                    }
                    ,
                    displaySuggestLang: ({preferredLocale: e, $i18n: t})=>e && t.locale !== e
                },
                methods: {
                    setPreferredLocale: e=>{
                        l["default"].setPreferredLocale(e)
                    }
                    ,
                    getCodeForSlug: U.dZ,
                    getLocaleParam: U.KP
                }
            }
              , B = V
              , M = (0,
            g.Z)(B, O, R, !1, null, "c2dca0ae", null)
              , H = M.exports
              , W = function() {
                var e = this
                  , t = e._self._c;
                return t("div", {
                    staticClass: "locale-selector"
                }, [t("select", {
                    attrs: {
                        "aria-label": e.$t("select-language")
                    },
                    domProps: {
                        value: e.$i18n.locale
                    },
                    on: {
                        change: e.updateRouter
                    }
                }, e._l(e.locales, (function({slug: n, name: r, code: o}) {
                    return t("option", {
                        key: n,
                        attrs: {
                            lang: o
                        },
                        domProps: {
                            value: n
                        }
                    }, [e._v(" " + e._s(r) + " ")])
                }
                )), 0), t("ChevronThickIcon", {
                    staticClass: "icon-inline"
                })], 1)
            }
              , F = []
              , J = function() {
                var e = this
                  , t = e._self._c;
                return t("SVGIcon", {
                    staticClass: "chevron-thick-icon",
                    attrs: {
                        viewBox: "0 0 14 10.5",
                        themeId: "chevron-thick"
                    }
                }, [t("path", {
                    attrs: {
                        d: "M12.43,0l1.57,1.22L7,10.5,0,1.23,1.58,0,7,7,12.43,0Z"
                    }
                })])
            }
              , K = []
              , G = n(9742)
              , z = {
                name: "ChevronThickIcon",
                components: {
                    SVGIcon: G.Z
                }
            }
              , X = z
              , Y = (0,
            g.Z)(X, J, K, !1, null, null, null)
              , Q = Y.exports
              , ee = {
                name: "LocaleSelector",
                components: {
                    ChevronThickIcon: Q
                },
                methods: {
                    updateRouter({target: {value: e}}) {
                        this.$router.push((0,
                        U.KP)(e)),
                        l["default"].setPreferredLocale(e),
                        (0,
                        U.jk)(e, this)
                    }
                },
                computed: {
                    availableLocales: ()=>l["default"].state.availableLocales,
                    locales: ({availableLocales: e})=>q.filter((({code: t})=>e.includes(t)))
                }
            }
              , te = ee
              , ne = (0,
            g.Z)(te, W, F, !1, null, "d21858a2", null)
              , re = ne.exports
              , oe = {
                name: "CoreApp",
                components: {
                    Footer: C,
                    InitialLoadingPlaceholder: L,
                    SuggestLang: H,
                    LocaleSelector: re
                },
                provide() {
                    return {
                        isTargetIDE: this.isTargetIDE,
                        performanceMetricsEnabled: "true" === {
                            NODE_ENV: "production",
                            VUE_APP_TITLE: "Documentation",
                            BASE_URL: "{{BASE_PATH}}/"
                        }.VUE_APP_PERFORMANCE_ENABLED
                    }
                },
                data() {
                    return {
                        AppTopID: $.$,
                        appState: l["default"].state,
                        fromKeyboard: !1,
                        isTargetIDE: "ide" === {
                            NODE_ENV: "production",
                            VUE_APP_TITLE: "Documentation",
                            BASE_URL: "{{BASE_PATH}}/"
                        }.VUE_APP_TARGET,
                        themeSettings: j.S3,
                        baseNavStickyAnchorId: T.EA
                    }
                },
                computed: {
                    currentColorScheme: ({appState: e})=>e.systemColorScheme,
                    preferredColorScheme: ({appState: e})=>e.preferredColorScheme,
                    availableLocales: ({appState: e})=>e.availableLocales,
                    CSSCustomProperties: ({currentColorScheme: e, preferredColorScheme: t, themeSettings: n})=>N(n.theme, t === c.Z.auto ? e : t),
                    hasCustomHeader: ()=>!!window.customElements.get("custom-header"),
                    hasCustomFooter: ()=>!!window.customElements.get("custom-footer"),
                    enablei18n: ({availableLocales: e})=>(0,
                    j.$8)(["features", "docs", "i18n", "enable"], !1) && e.length > 1
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
                            this.detachStylesFromRoot(e),
                            this.attachStylesToRoot(e)
                        }
                    }
                },
                async created() {
                    window.addEventListener("keydown", this.onKeyDown),
                    this.$bridge.on("navigation", this.handleNavigationRequest),
                    this.enableThemeSettings && Object.assign(this.themeSettings, await (0,
                    j.Kx)()),
                    window.addEventListener("pageshow", this.syncPreferredColorScheme),
                    this.$once("hook:beforeDestroy", (()=>{
                        window.removeEventListener("pageshow", this.syncPreferredColorScheme)
                    }
                    ))
                },
                mounted() {
                    (document.querySelector(".footer-current-year") || {}).innerText = (new Date).getFullYear(),
                    this.attachColorSchemeListeners()
                },
                beforeDestroy() {
                    this.fromKeyboard ? window.removeEventListener("mousedown", this.onMouseDown) : window.removeEventListener("keydown", this.onKeyDown),
                    this.$bridge.off("navigation", this.handleNavigationRequest),
                    this.detachStylesFromRoot(this.CSSCustomProperties)
                },
                methods: {
                    onKeyDown() {
                        this.fromKeyboard = !0,
                        window.addEventListener("mousedown", this.onMouseDown),
                        window.removeEventListener("keydown", this.onKeyDown)
                    },
                    onMouseDown() {
                        this.fromKeyboard = !1,
                        window.addEventListener("keydown", this.onKeyDown),
                        window.removeEventListener("mousedown", this.onMouseDown)
                    },
                    handleNavigationRequest(e) {
                        this.$router.push(e)
                    },
                    attachColorSchemeListeners() {
                        if (!window.matchMedia)
                            return;
                        const e = window.matchMedia("(prefers-color-scheme: dark)");
                        e.addListener(this.onColorSchemePreferenceChange),
                        this.$once("hook:beforeDestroy", (()=>{
                            e.removeListener(this.onColorSchemePreferenceChange)
                        }
                        )),
                        this.onColorSchemePreferenceChange(e)
                    },
                    onColorSchemePreferenceChange({matches: e}) {
                        const t = e ? c.Z.dark : c.Z.light;
                        l["default"].setSystemColorScheme(t)
                    },
                    attachStylesToRoot(e) {
                        const t = document.body;
                        Object.entries(e).filter((([,e])=>Boolean(e))).forEach((([e,n])=>{
                            t.style.setProperty(e, n)
                        }
                        ))
                    },
                    detachStylesFromRoot(e) {
                        const t = document.body;
                        Object.entries(e).forEach((([e])=>{
                            t.style.removeProperty(e)
                        }
                        ))
                    },
                    syncPreferredColorScheme() {
                        l["default"].syncPreferredColorScheme()
                    }
                }
            }
              , ie = oe
              , ae = (0,
            g.Z)(ie, a, s, !1, null, "3742c1d7", null)
              , se = ae.exports;
            class le {
                constructor() {
                    this.$send = ()=>{}
                }
                send(e) {
                    this.$send(e)
                }
            }
            class ce {
                constructor() {
                    const {webkit: {messageHandlers: {bridge: e={}}={}}={}} = window;
                    this.bridge = e;
                    const {postMessage: t=(()=>{}
                    )} = e;
                    this.$send = t.bind(e)
                }
                send(e) {
                    this.$send(e)
                }
            }
            class ue {
                constructor(e=new le) {
                    this.backend = e,
                    this.listeners = {}
                }
                send(e) {
                    this.backend.send(e)
                }
                receive(e) {
                    this.emit(e.type, e.data)
                }
                emit(e, t) {
                    this.listeners[e] && this.listeners[e].forEach((e=>e(t)))
                }
                on(e, t) {
                    this.listeners[e] || (this.listeners[e] = new Set),
                    this.listeners[e].add(t)
                }
                off(e, t) {
                    this.listeners[e] && this.listeners[e].delete(t)
                }
            }
            var de = {
                install(e, t) {
                    let n;
                    n = t.performanceMetricsEnabled || "ide" === t.appTarget ? new ce : new le,
                    e.prototype.$bridge = new ue(n)
                }
            };
            function me(e) {
                return `custom-${e}`
            }
            function pe(e) {
                return class extends HTMLElement {
                    constructor() {
                        super();
                        const t = this.attachShadow({
                            mode: "open"
                        })
                          , n = e.content.cloneNode(!0);
                        t.appendChild(n)
                    }
                }
            }
            function he(e) {
                const t = me(e)
                  , n = document.getElementById(t);
                n && window.customElements.define(t, pe(n))
            }
            function fe(e, t={
                names: ["header", "footer"]
            }) {
                const {names: n} = t;
                e.config.ignoredElements = /^custom-/,
                n.forEach(he)
            }
            function ge(e, t) {
                const {value: n=!1} = t;
                e.style.display = n ? "none" : ""
            }
            var ve = {
                hide: ge
            };
            function be(e, {performanceMetrics: t=!1}={}) {
                e.config.productionTip = !1,
                e.use(fe),
                e.directive("hide", ve.hide),
                e.use(de, {
                    appTarget: {
                        NODE_ENV: "production",
                        VUE_APP_TITLE: "Documentation",
                        BASE_URL: "{{BASE_PATH}}/"
                    }.VUE_APP_TARGET,
                    performanceMetricsEnabled: t
                }),
                window.bridge = e.prototype.$bridge,
                e.config.performance = t
            }
            var we = n(4589)
              , ye = n(5381)
              , Se = n(5657)
              , Ce = n(3208)
              , _e = n(2449);
            const Ee = 10;
            function ke(e) {
                const {name: t} = e
                  , n = t.includes(we.J_);
                return n ? Ee : 0
            }
            function Ae() {
                const {location: e} = window;
                return e.pathname + e.search + e.hash
            }
            function Pe() {
                const e = Math.max(document.documentElement.clientWidth || 0, window.innerWidth || 0);
                return e < ye.kB.nav.small.maxWidth ? T.L$ : T.RS
            }
            async function Le(e, t, n) {
                if (n)
                    return await this.app.$nextTick(),
                    n;
                if (e.meta && e.meta.preventScrolling)
                    return !1;
                if (e.hash) {
                    const {name: t, query: n, hash: r} = e
                      , o = t.includes(we.J_)
                      , i = !!n.changes
                      , a = Pe()
                      , s = o && i ? a : 0
                      , l = a + s + ke(e)
                      , c = "ide" === {
                        NODE_ENV: "production",
                        VUE_APP_TITLE: "Documentation",
                        BASE_URL: "{{BASE_PATH}}/"
                    }.VUE_APP_TARGET ? 0 : l;
                    return {
                        selector: (0,
                        Ce.sj)(r),
                        offset: {
                            x: 0,
                            y: c
                        }
                    }
                }
                return !(0,
                _e.Lp)(e, t) && {
                    x: 0,
                    y: 0
                }
            }
            async function Te() {
                let e = window.sessionStorage.getItem("scrollPosition");
                if (e) {
                    try {
                        e = JSON.parse(e)
                    } catch (t) {
                        return void console.error("Error parsing scrollPosition from sessionStorage", t)
                    }
                    Ae() === e.location && (await (0,
                    Se.J)(2),
                    window.scrollTo(e.x, e.y))
                }
            }
            function je() {
                window.location.hash || sessionStorage.setItem("scrollPosition", JSON.stringify({
                    x: window.pageXOffset,
                    y: window.pageYOffset,
                    location: Ae()
                }))
            }
            var xe = function() {
                var e = this
                  , t = e._self._c;
                return t("GenericError")
            }
              , Ie = []
              , Ne = function() {
                var e = this
                  , t = e._self._c;
                return t("div", {
                    staticClass: "generic-error"
                }, [t("div", {
                    staticClass: "container"
                }, [t("h1", {
                    staticClass: "title error-content"
                }, [e._v(e._s(e.message || e.$t("error.unknown")))]), e._t("default")], 2)])
            }
              , $e = []
              , Oe = {
                name: "GenericError",
                props: {
                    message: {
                        type: String,
                        required: !1
                    }
                }
            }
              , Re = Oe
              , De = (0,
            g.Z)(Re, Ne, $e, !1, null, "1f05d9ec", null)
              , Ze = De.exports
              , qe = {
                name: "ServerError",
                components: {
                    GenericError: Ze
                },
                created() {
                    l["default"].setAllLocalesAreAvailable()
                }
            }
              , Ue = qe
              , Ve = (0,
            g.Z)(Ue, xe, Ie, !1, null, null, null)
              , Be = Ve.exports
              , Me = function() {
                var e = this
                  , t = e._self._c;
                return t("GenericError", {
                    attrs: {
                        message: e.$t("error.not-found")
                    }
                }, [e._t("default")], 2)
            }
              , He = []
              , We = {
                name: "NotFound",
                components: {
                    GenericError: Ze
                },
                created() {
                    l["default"].setAllLocalesAreAvailable()
                }
            }
              , Fe = We
              , Je = (0,
            g.Z)(Fe, Me, He, !1, null, null, null)
              , Ke = Je.exports
              , Ge = [{
                path: "/tutorials/:id",
                name: "tutorials-overview",
                component: ()=>Promise.all([n.e(295), n.e(843)]).then(n.bind(n, 5199))
            }, {
                path: "/tutorials/:id/*",
                name: "topic",
                component: ()=>Promise.all([n.e(295), n.e(842), n.e(162)]).then(n.bind(n, 4104))
            }, {
                path: "/documentation/*",
                name: we.J_,
                component: ()=>Promise.all([n.e(295), n.e(976), n.e(842), n.e(982)]).then(n.bind(n, 9185))
            }, {
                path: "*",
                name: we.vL,
                component: Ke
            }, {
                path: "*",
                name: we.Rp,
                component: Be
            }];
            const ze = [{
                pathPrefix: "/:locale?",
                nameSuffix: "-locale"
            }];
            function Xe(e, t=[], n=ze) {
                return n.reduce(((n,r)=>n.concat(e.filter((e=>!t.includes(e.name))).map((e=>({
                    ...e,
                    path: r.pathPrefix + e.path,
                    name: e.name + r.nameSuffix
                }))))), [])
            }
            const Ye = [...Ge, ...Xe(Ge, [we.vL, we.Rp])];
            function Qe(e={}) {
                const t = new i.Z({
                    mode: "history",
                    base: j.FH,
                    scrollBehavior: Le,
                    ...e,
                    routes: e.routes || Ye
                });
                return t.onReady((()=>{
                    "scrollRestoration"in window.history && (window.history.scrollRestoration = "manual"),
                    Te()
                }
                )),
                "ide" !== {
                    NODE_ENV: "production",
                    VUE_APP_TITLE: "Documentation",
                    BASE_URL: "{{BASE_PATH}}/"
                }.VUE_APP_TARGET && t.onError((e=>{
                    const {route: n={
                        path: "/"
                    }} = e;
                    t.replace({
                        name: "server-error",
                        params: [n.path]
                    })
                }
                )),
                window.addEventListener("unload", je),
                t
            }
            var et = n(7788);
            function tt(e=et) {
                const {defaultLocale: t, messages: n, dateTimeFormats: r={}} = e
                  , i = new o.Z({
                    dateTimeFormats: r,
                    locale: t,
                    fallbackLocale: t,
                    messages: n
                });
                return i
            }
            r["default"].use(be),
            r["default"].use(i.Z),
            r["default"].use(o.Z),
            document.documentElement.classList.remove("no-js"),
            new r["default"]({
                router: Qe(),
                render: e=>e(se),
                i18n: tt()
            }).$mount("#app")
        },
        2717: function(e, t, n) {
            "use strict";
            n.d(t, {
                $: function() {
                    return r
                }
            });
            const r = "app-top"
        },
        9804: function(e, t) {
            "use strict";
            t["Z"] = {
                auto: "auto",
                dark: "dark",
                light: "light"
            }
        },
        1265: function(e, t) {
            "use strict";
            t["Z"] = {
                eager: "eager",
                lazy: "lazy"
            }
        },
        1716: function(e, t, n) {
            "use strict";
            n.d(t, {
                EA: function() {
                    return i
                },
                L$: function() {
                    return o
                },
                MenuLinkModifierClasses: function() {
                    return s
                },
                RS: function() {
                    return r
                },
                Yj: function() {
                    return a
                }
            });
            const r = 52
              , o = 48
              , i = "nav-sticky-anchor"
              , a = "nav-open-navigator"
              , s = {
                noClose: "noclose"
            }
        },
        4589: function(e, t, n) {
            "use strict";
            n.d(t, {
                J_: function() {
                    return i
                },
                Rp: function() {
                    return o
                },
                vL: function() {
                    return r
                }
            });
            const r = "not-found"
              , o = "server-error"
              , i = "documentation-topic"
        },
        7788: function(e, t, n) {
            "use strict";
            n.r(t),
            n.d(t, {
                defaultLocale: function() {
                    return s
                },
                messages: function() {
                    return l
                }
            });
            var r = JSON.parse('{"view-in":"View in English","continue-viewing":"Continue viewing in English","language":"Language","video":{"title":"Video","replay":"Replay","play":"Play","pause":"Pause","watch":"Watch intro video","description":"Content description: {alt}","custom-controls":"Video with custom controls."},"tutorials":{"title":"Tutorial | Tutorials","step":"Step {number}","submit":"Submit","next":"Next","preview":{"title":"No Preview | Preview | Previews","no-preview-available-step":"No preview available for this step."},"nav":{"chapters":"Chapters","current":"Current {thing}"},"assessment":{"check-your-understanding":"Check Your Understanding","success-message":"Great job, you\'ve answered all the questions for this tutorial.","answer-result":"Answer {answer} is {result}","correct":"correct","incorrect":"incorrect","next-question":"Next question","legend":"Possible answers"},"project-files":"Project files","estimated-time":"Estimated Time","sections":{"chapter":"Chapter {number}"},"question-of":"Question {index} of {total}","section-of":"{number} of {total}","overriding-title":"{newTitle} with {title}","time":{"format":"{number} {minutes}","minutes":{"full":"minute | minutes | {count} minutes","short":"min | mins"},"hours":{"full":"hour | hours"}}},"documentation":{"title":"Documentation","nav":{"breadcrumbs":"Breadcrumbs","menu":"Menu","open-menu":"Open Menu","close-menu":"Close Menu"},"current-page":"Current page is {title}","card":{"learn-more":"Learn More","read-article":"Read article","start-tutorial":"Start tutorial","view-api":"View API collection","view-symbol":"View symbol","view-sample-code":"View sample code"},"view-more":"View more"},"declarations":{"hide-other-declarations":"Hide other declarations","show-all-declarations":"Show all declarations"},"aside-kind":{"beta":"Beta","experiment":"Experiment","important":"Important","note":"Note","tip":"Tip","warning":"Warning","deprecated":"Deprecated"},"change-type":{"added":"Added","modified":"Modified","deprecated":"Deprecated"},"verbs":{"hide":"Hide","show":"Show","close":"Close"},"sections":{"attributes":"Attributes","title":"Section {number}","on-this-page":"On this page","topics":"Topics","default-implementations":"Default Implementations","relationships":"Relationships","see-also":"See Also","declaration":"Declaration","details":"Details","parameters":"Parameters","possible-values":"Possible Values","parts":"Parts","availability":"Availability","resources":"Resources"},"metadata":{"details":{"name":"Name","key":"Key","type":"Type"},"beta":{"legal":"This documentation refers to beta software and may be changed.","software":"Beta Software"},"default-implementation":"Default implementation provided. | Default implementations provided."},"availability":{"introduced-and-deprecated":"Introduced in {name} {introducedAt} and deprecated in {name} {deprecatedAt}","available-on":"Available on {name} {introducedAt} and later"},"more":"More","less":"Less","api-reference":"API Reference","filter":{"title":"Filter","search":"Search","search-symbols":"Search symbols in {technology}","suggested-tags":"Suggested tag | Suggested tags","selected-tags":"Selected tag | Selected tags","add-tag":"Add tag","tag-select-remove":"Tag. Select to remove from list.","navigate":"To navigate the symbols, press Up Arrow, Down Arrow, Left Arrow or Right Arrow","siblings-label":"{number-siblings} of {total-siblings} symbols inside {parent-siblings}","parent-label":"{number-siblings} of {total-siblings} symbols inside {parent-siblings} containing one symbol | {number-siblings} of {total-siblings} symbols inside {parent-siblings} containing {number-parent} symbols","reset-filter":"Reset Filter","tags":{"sample-code":"Sample Code","tutorials":"Tutorials","articles":"Articles","web-service-endpoints":"Web Service Endpoints","hide-deprecated":"Hide Deprecated"}},"navigator":{"title":"Documentation Navigator","open-navigator":"Open Documentation Navigator","close-navigator":"Close Documentation Navigator","no-results":"No results found.","no-children":"No data available.","error-fetching":"There was an error fetching the data.","items-found":"No items were found | 1 item was found | {number} items were found. Tab back to navigate through them.","navigator-is":"Navigator is {state}","state":{"loading":"loading","ready":"ready"}},"tab":{"request":"Request","response":"Response"},"required":"Required","parameters":{"default":"Default","minimum":"Minimum","maximum":"Maximum","possible-types":"Type | Possible types","possible-values":"Value | Possible Values"},"content-type":"Content-Type: {value}","read-only":"Read-only","error":{"unknown":"An unknown error occurred.","image":"Image failed to load","not-found":"The page you\'re looking for can\'t be found."},"color-scheme":{"select":"Select a color scheme preference","auto":"Auto","dark":"Dark","light":"Light"},"accessibility":{"strike":{"start":"start of stricken text","end":"end of stricken text"},"code":{"start":"start of code block","end":"end of code block"},"skip-navigation":"Skip Navigation","in-page-link":"in page link"},"select-language":"Select the language for this page","icons":{"clear":"Clear","web-service-endpoint":"Web Service Endpoint","search":"Search"},"formats":{"parenthesis":"({content})","colon":"{content}: "},"quicknav":{"button":{"label":"Open Quick Navigation","title":"Click or type / for quick navigation"},"preview-unavailable":"Preview unavailable"},"mentioned-in":"Mentioned in","pager":{"roledescription":"content slider","page":{"label":"content page {index} of {count}"},"control":{"navigate-previous":"navigate to previous page of content","navigate-next":"navigate to next page of content"}},"links-grid":{"label":"grid of links"}}')
              , o = JSON.parse('{"view-in":"以中文查看","continue-viewing":"继续以中文查看","language":"语言","video":{"replay":"重新播放","play":"播放","pause":"暂停","watch":"观看介绍视频"},"tutorials":{"title":"教程","step":"第 {number} 步","submit":"提交","next":"下一步","preview":{"title":"无预览 | 预览","no-preview-available-step":"这一步没有预览。"},"nav":{"chapters":"章节","current":"当前{thing}"},"assessment":{"check-your-understanding":"检查你的理解程度","success-message":"很棒，你回答了此教程的所有问题。","answer-result":"答案{answer}是{result}","correct":"正确","incorrect":"错误","next-question":"下一个问题","legend":"可能的答案"},"project-files":"项目文件","estimated-time":"预计时间","sections":{"chapter":"第 {number} 章"},"question-of":"第 {index} 个问题（共 {total} 个）","section-of":"{number}/{total}","overriding-title":"{newTitle}{title}","time":{"format":"{number} {minutes}","minutes":{"full":"分钟 | {count} 分钟","short":"分钟"},"hours":{"full":"小时"}}},"documentation":{"title":"文档","nav":{"breadcrumbs":"面包屑导航","menu":"菜单","open-menu":"打开菜单","close-menu":"关闭菜单"},"current-page":"当前页面为：{title}","card":{"learn-more":"进一步了解","read-article":"阅读文章","start-tutorial":"开始教程","view-api":"查看 API 集合","view-symbol":"查看符号","view-sample-code":"查看示例代码"},"view-more":"查看更多"},"aside-kind":{"beta":"Beta 版","experiment":"试验","important":"重要事项","note":"注","tip":"提示","warning":"警告","deprecated":"已弃用"},"change-type":{"added":"已添加","modified":"已修改","deprecated":"已弃用"},"verbs":{"hide":"隐藏","show":"显示","close":"关闭"},"sections":{"title":"第 {number} 部分","on-this-page":"在此页面上","topics":"主题","default-implementations":"默认实现","relationships":"关系","see-also":"另请参阅","declaration":"声明","details":"详细信息","parameters":"参数","possible-values":"可能值","parts":"部件","availability":"可用性","resources":"资源"},"metadata":{"details":{"name":"名称","key":"密钥","type":"类型"},"beta":{"legal":"此文档涉及 Beta 版软件且可能会改动。","software":"Beta 版软件"},"default-implementation":"提供默认实现。| 提供默认实现方法。"},"availability":{"introduced-and-deprecated":"{name} {introducedAt} 中引入，{name} {deprecatedAt} 中弃用","available-on":"{name} {introducedAt} 及更高版本中可用"},"more":"更多","less":"更少","api-reference":"API 参考","filter":{"title":"过滤","search":"搜索","search-symbols":"在 {technology} 搜索符号","suggested-tags":"建议标签","selected-tags":"所选标签","add-tag":"添加标签","tag-select-remove":"标签。选择以从列表中移除。","navigate":"若要导航符号，请按下上箭头、下箭头、左箭头或右箭头。","siblings-label":"{parent-siblings} 内含 {number-siblings} 个符号（共 {total-siblings} 个）","parent-label":"{parent-siblings} 内含 {number-siblings} 个符号（共 {total-siblings} 个）包含一个符号 | {parent-siblings} 内含 {number-siblings} 个符号（共 {total-siblings} 个）包含 {number-parent} 个符号","reset-filter":"还原过滤条件"},"navigator":{"title":"文档导航器","open-navigator":"打开文档导航器","close-navigator":"关闭文档导航器","no-results":"未找到结果。","no-children":"无可用数据。","error-fetching":"获取数据时出错。","items-found":"未找到任何项目 | 找到 1 个项目 | 找到 {number} 个项目。按下 Tab 键导航。","navigator-is":"导航器{state}","state":{"loading":"正在载入","ready":"准备就绪"},"tags":{"hide-deprecated":"隐藏已弃用"}},"tab":{"request":"请求","response":"回复"},"required":"必需","parameters":{"default":"默认","minimum":"最小值","maximum":"最大值","possible-types":"类型 | 可能类型","possible-values":"值 | 可能值"},"content-type":"内容类型：{value}","read-only":"只读","error":{"unknown":"出现未知错误。","image":"图像无法载入","not-found":"找不到你所查找的页面。"},"color-scheme":{"select":"选择首选颜色方案","auto":"自动","dark":"深色","light":"浅色"},"accessibility":{"strike":{"start":"删除线文本开始","end":"删除线文本结束"},"code":{"start":"代码块开头","end":"代码块结尾"},"skip-navigation":"跳过导航","in-page-link":"在页面链接中"},"select-language":"选择此页面的语言","icons":{"clear":"清除","web-service-endpoint":"网络服务端点","search":"搜索"},"formats":{"parenthesis":"({content})","colon":"{content}： "},"quicknav":{"button":{"label":"打开快速导航","title":"点按或键入 / 进行快速导航"},"preview-unavailable":"预览不可用"}}')
              , i = JSON.parse('{"view-in":"日本語で表示","continue-viewing":"日本語で表示を続ける","language":"言語","video":{"replay":"リプレイ","play":"再生","pause":"一時停止","watch":"概要のビデオを観る"},"tutorials":{"title":"チュートリアル | チュートリアル","step":"手順{number}","submit":"送信","next":"次へ","preview":{"title":"プレビューなし | プレビュー | プレビュー","no-preview-available-step":"この手順では利用可能なプレビューがありません。"},"nav":{"chapters":"章","current":"現在の{thing}"},"assessment":{"check-your-understanding":"理解度を確認する","success-message":"よくできました。このチュートリアルの問題にすべて解答しました。","answer-result":"解答{answer}は{result}です","correct":"正解","incorrect":"不正解","next-question":"次の問題","legend":"解答例"},"project-files":"プロジェクトファイル","estimated-time":"予測時間","sections":{"chapter":"{number}章"},"question-of":"{total}問中の{index}問","section-of":"{total}件中の{number}件","overriding-title":"{title}の{newTitle}","time":{"format":"{number} {minutes}","minutes":{"full":"分 | 分 | {count}分","short":"分 | 分"},"hours":{"full":"時間 | 時間"}}},"documentation":{"title":"ドキュメント","nav":{"breadcrumbs":"パンくずリスト","menu":"メニュー","open-menu":"メニューを開く","close-menu":"メニューを閉じる"},"current-page":"現在のページは{title}です","card":{"learn-more":"詳しい情報","read-article":"記事を読む","start-tutorial":"チュートリアルを開始","view-api":"APIのコレクションを表示","view-symbol":"記号を表示","view-sample-code":"サンプルコードを表示"},"view-more":"さらに表示"},"aside-kind":{"beta":"ベータ版","experiment":"試験運用版","important":"重要","note":"注意","tip":"ヒント","warning":"警告","deprecated":"非推奨"},"change-type":{"added":"追加","modified":"変更","deprecated":"非推奨"},"verbs":{"hide":"非表示","show":"表示","close":"閉じる"},"sections":{"title":"セクション{number}","on-this-page":"このページの内容","topics":"トピック","default-implementations":"デフォルト実装","relationships":"関連項目","see-also":"参照","declaration":"宣言","details":"詳細","parameters":"パラメータ","possible-values":"使用できる値","parts":"パーツ","availability":"利用可能","resources":"リソース"},"metadata":{"details":{"name":"名前","key":"キー","type":"タイプ"},"beta":{"legal":"このドキュメントはベータ版のソフトウェアのもので、変更される可能性があります。","software":"ベータ版ソフトウェア"},"default-implementation":"デフォルト実装あり。| デフォルト実装あり。"},"availability":{"introduced-and-deprecated":"{name} {introducedAt}で導入され、{name} {deprecatedAt}で非推奨になりました","available-on":"{name} {introducedAt}以降で使用できます"},"more":"さらに表示","less":"表示を減らす","api-reference":"APIリファレンス","filter":{"title":"フィルタ","search":"検索","search-symbols":"{technology}でシンボルを検索","suggested-tags":"提案されたタグ | 提案されたタグ","selected-tags":"選択したタグ | 選択したタグ","add-tag":"タグを追加","tag-select-remove":"タグ。選択してリストから削除します。","navigate":"シンボルを移動するには、上下左右の矢印キーを押します。","siblings-label":"{total-siblings}個中{number-siblings}個のシンボルが{parent-siblings}の中にあります","parent-label":"{total-siblings}個中{number-siblings}個のシンボルが1個のシンボルを含む{parent-siblings}の中にあります | {total-siblings}個中{number-siblings}個のシンボルが{number-parent}個のシンボルを含む{parent-siblings}の中にあります","reset-filter":"フィルタをリセット"},"navigator":{"title":"ドキュメントナビゲータ","open-navigator":"ドキュメントナビゲータを開く","close-navigator":"ドキュメントナビゲータを閉じる","no-results":"結果が見つかりません。","no-children":"使用できるデータがありません。","error-fetching":"データを取得する際にエラーが起きました。","items-found":"項目が見つかりません | 1個の項目が見つかりました | {number}個の項目が見つかりましたTabキーを押すと項目をナビゲートできます。","navigator-is":"ナビゲータは{state}です","state":{"loading":"読み込み中","ready":"準備完了"},"tags":{"hide-deprecated":"非推奨の項目を非表示"}},"tab":{"request":"リクエスト","response":"レスポンス"},"required":"必須","parameters":{"default":"デフォルト","minimum":"最小","maximum":"最大","possible-types":"タイプ | 使用できるタイプ","possible-values":"値 | 使用できる値"},"content-type":"Content-Type: {value}","read-only":"読み出し専用","error":{"unknown":"原因不明のエラーが起きました。","image":"イメージを読み込めませんでした","not-found":"探しているページが見つかりません。"},"color-scheme":{"select":"カラースキーム環境設定を選択","auto":"自動","dark":"ダーク","light":"ライト"},"accessibility":{"strike":{"start":"取り消し線テキストの開始","end":"取り消し線テキストの終了"},"code":{"start":"コードブロックの開始","end":"コードブロックの終了"},"skip-navigation":"ナビゲーションをスキップ","in-page-link":"ページ内リンク"},"select-language":"このページの言語を選択","icons":{"clear":"消去","web-service-endpoint":"Webサービスのエンドポイント","search":"検索"},"formats":{"parenthesis":"（{content}）","colon":"{content}: "},"quicknav":{"button":{"label":"クイックナビゲーションを開く","title":"クリックするか「/」を入力すると素早く移動します"},"preview-unavailable":"プレビューできません"}}')
              , a = JSON.parse('{"view-in":"한국어로 보기","continue-viewing":"한국어로 계속 보기","language":"언어","video":{"replay":"다시 재생","play":"재생","pause":"일시 정지","watch":"소개 비디오 시청하기"},"tutorials":{"title":"튜토리얼 | 튜토리얼","step":"{number}단계","submit":"제출","next":"다음","preview":{"title":"미리보기 없음 | 미리보기 | 미리보기","no-preview-available-step":"이 단계에서는 사용 가능한 미리보기가 없습니다."},"nav":{"chapters":"챕터","current":"현재 {thing}"},"assessment":{"check-your-understanding":"얼마나 이해했는지 확인하기","success-message":"잘 하셨습니다. 이 튜토리얼에 대한 모든 질문에 답하셨습니다.","answer-result":"답 {answer}은(는) {result}입니다.","correct":"정답","incorrect":"오답","next-question":"다음 질문","legend":"가능한 답"},"project-files":"프로젝트 파일","estimated-time":"예상 시간","sections":{"chapter":"{number}챕터"},"question-of":"총 {total}개 중 {index}번째 질문","section-of":"{total} 중 {number}","overriding-title":"{title}의 {newTitle}","time":{"format":"{number}{minutes}","minutes":{"full":"분 | 분 | {count}분","short":"분 | 분"},"hours":{"full":"시간 | 시간"}}},"documentation":{"title":"문서","nav":{"breadcrumbs":"브레드크럼","menu":"메뉴","open-menu":"메뉴 열기","close-menu":"메뉴 닫기"},"current-page":"현재 {title} 페이지","card":{"learn-more":"더 알아보기","read-article":"문서 읽기","start-tutorial":"튜토리얼 시작","view-api":"API 모음 보기","view-symbol":"기호 보기","view-sample-code":"샘플 코드 보기"},"view-more":"더 보기"},"aside-kind":{"beta":"베타","experiment":"실험","important":"중요","note":"참고","tip":"팁","warning":"경고","deprecated":"제거됨"},"change-type":{"added":"추가됨","modified":"수정됨","deprecated":"제거됨"},"verbs":{"hide":"가리기","show":"보기","close":"닫기"},"sections":{"title":"{number}섹션","on-this-page":"이 페이지에서","topics":"주제","default-implementations":"기본 구현","relationships":"관계","see-also":"추가 정보","declaration":"선언","details":"세부사항","parameters":"매개변수","possible-values":"가능한 값","parts":"파트","availability":"사용 가능 여부","resources":"리소스"},"metadata":{"details":{"name":"이름","key":"키","type":"유형"},"beta":{"legal":"이 문서는 베타 소프트웨어에 대해서 다루고 있으며, 변경될 수 있습니다.","software":"베타 소프트웨어"},"default-implementation":"기본 구현 제공됨. | 기본 구현 제공됨."},"availability":{"introduced-and-deprecated":"{name} {introducedAt}에서 소개되었고 {name} {deprecatedAt}에서 제거됨","available-on":"{name} {introducedAt} 이상에서 사용할 수 있음"},"more":"더 보기","less":"간략히","api-reference":"API 참조","filter":{"title":"필터","search":"검색","search-symbols":"{technology}에서 기호 찾기","suggested-tags":"권장 태그 | 권장 태그","selected-tags":"선택한 태그 | 선택한 태그","add-tag":"태그 추가","tag-select-remove":"태그. 목록에서 제거하려면 선택하십시오.","navigate":"기호를 탐색하려면 위쪽 화살표, 아래쪽 화살표, 왼쪽 화살표 또는 오른쪽 화살표를 누르십시오.","siblings-label":"{parent-siblings} 내의 총 {total-siblings}개의 기호 중 {number-siblings}개","parent-label":"한 개의 기호를 포함하는 {parent-siblings} 내의 총 {total-siblings}개의 기호 중 {number-siblings}개 | {number-parent}개의 기호를 포함하는 {parent-siblings} 내의 총 {total-siblings}개의 기호 중 {number-siblings}개","reset-filter":"필터 재설정"},"navigator":{"title":"문서 탐색기","open-navigator":"문서 탐색기 열기","close-navigator":"문서 탐색기 닫기","no-results":"결과 찾을 수 없습니다.","no-children":"사용 가능한 데이터가 없습니다.","error-fetching":"데이터를 가져오는 동안 오류가 발생했습니다.","items-found":"항목을 찾을 수 없음 | 1개의 항목 발견됨 | {number}개의 항목이 발견됨. 다시 탭하여 탐색하십시오.","navigator-is":"내비게이터가 {state}입니다.","state":{"loading":"로드 중","ready":"준비 완료 상태"},"tags":{"hide-deprecated":"제거된 항목 가리기"}},"tab":{"request":"요청","response":"응답"},"required":"필수 사항","parameters":{"default":"기본","minimum":"최소","maximum":"최대","possible-types":"유형 | 가능한 유형","possible-values":"값 | 가능한 값"},"content-type":"콘텐츠 유형: {value}","read-only":"읽기 전용","error":{"unknown":"알 수 없는 오류가 발생했습니다.","image":"이미지를 로드하는 데 실패함","not-found":"해당 페이지를 찾을 수 없습니다."},"color-scheme":{"select":"색상 모드 환경설정 선택","auto":"자동","dark":"다크","light":"라이트"},"accessibility":{"strike":{"start":"취소선이 그어진 텍스트 시작","end":"취소선이 그어진 텍스트 종료"},"code":{"start":"코드 블록 시작","end":"코드 블록 종료"},"skip-navigation":"탐색 건너뛰기","in-page-link":"페이지 링크에서"},"select-language":"이 페이지의 언어 선택","icons":{"clear":"지우기","web-service-endpoint":"웹 서비스 엔드포인트","search":"검색"},"formats":{"parenthesis":"({content})","colon":"{content}: "},"quicknav":{"button":{"label":"빠른 이동 열기","title":"클릭하거나 /를 입력하여 빠르게 이동"},"preview-unavailable":"미리보기 사용할 수 없음"}}');
            const s = "en-US"
              , l = {
                "en-US": r,
                "zh-CN": o,
                "ja-JP": i,
                "ko-KR": a
            }
        },
        4030: function(e, t, n) {
            "use strict";
            var r = n(9804)
              , o = n(1265)
              , i = n(5394)
              , a = n(2412);
            const s = "undefined" !== typeof window.matchMedia && [r.Z.light, r.Z.dark, "no-preference"].some((e=>window.matchMedia(`(prefers-color-scheme: ${e})`).matches))
              , l = s ? r.Z.auto : r.Z.light;
            t["default"] = {
                state: {
                    imageLoadingStrategy: "ide" === {
                        NODE_ENV: "production",
                        VUE_APP_TITLE: "Documentation",
                        BASE_URL: "{{BASE_PATH}}/"
                    }.VUE_APP_TARGET ? o.Z.eager : o.Z.lazy,
                    preferredColorScheme: i.Z.preferredColorScheme || l,
                    preferredLocale: i.Z.preferredLocale,
                    supportsAutoColorScheme: s,
                    systemColorScheme: r.Z.light,
                    availableLocales: []
                },
                reset() {
                    this.state.imageLoadingStrategy = "ide" === {
                        NODE_ENV: "production",
                        VUE_APP_TITLE: "Documentation",
                        BASE_URL: "{{BASE_PATH}}/"
                    }.VUE_APP_TARGET ? o.Z.eager : o.Z.lazy,
                    this.state.preferredColorScheme = i.Z.preferredColorScheme || l,
                    this.state.supportsAutoColorScheme = s,
                    this.state.systemColorScheme = r.Z.light
                },
                setImageLoadingStrategy(e) {
                    this.state.imageLoadingStrategy = e
                },
                setPreferredColorScheme(e) {
                    this.state.preferredColorScheme = e,
                    i.Z.preferredColorScheme = e
                },
                setAllLocalesAreAvailable() {
                    const e = a.map((e=>e.code));
                    this.state.availableLocales = e
                },
                setAvailableLocales(e=[]) {
                    this.state.availableLocales = e
                },
                setPreferredLocale(e) {
                    this.state.preferredLocale = e,
                    i.Z.preferredLocale = this.state.preferredLocale
                },
                setSystemColorScheme(e) {
                    this.state.systemColorScheme = e
                },
                syncPreferredColorScheme() {
                    i.Z.preferredColorScheme && i.Z.preferredColorScheme !== this.state.preferredColorScheme && (this.state.preferredColorScheme = i.Z.preferredColorScheme)
                }
            }
        },
        5947: function(e, t, n) {
            "use strict";
            function r(e) {
                return e.reduce(((e,t)=>(t.traits.includes("dark") ? e.dark.push(t) : e.light.push(t),
                e)), {
                    light: [],
                    dark: []
                })
            }
            function o(e) {
                const t = ["1x", "2x", "3x"];
                return t.reduce(((t,n)=>{
                    const r = e.find((e=>e.traits.includes(n)));
                    return r ? t.concat({
                        density: n,
                        src: r.url,
                        size: r.size
                    }) : t
                }
                ), [])
            }
            function i(e) {
                const t = "/"
                  , n = new RegExp(`${t}+`,"g");
                return e.join(t).replace(n, t)
            }
            function a(e) {
                const {baseUrl: t} = window
                  , n = Array.isArray(e) ? i(e) : e;
                return n && "string" === typeof n && !n.startsWith(t) && n.startsWith("/") ? i([t, n]) : n
            }
            function s(e) {
                return e ? e.startsWith("/") ? e : `/${e}` : e
            }
            function l(e) {
                return e ? `url('${a(e)}')` : void 0
            }
            function c(e) {
                return new Promise(((t,n)=>{
                    const r = new Image;
                    r.src = e,
                    r.onerror = n,
                    r.onload = ()=>t({
                        width: r.width,
                        height: r.height
                    })
                }
                ))
            }
            n.d(t, {
                AH: function() {
                    return a
                },
                Jf: function() {
                    return s
                },
                RY: function() {
                    return c
                },
                T8: function() {
                    return d
                },
                XV: function() {
                    return r
                },
                eZ: function() {
                    return l
                },
                u: function() {
                    return o
                }
            });
            const u = {
                landscape: "landscape",
                portrait: "portrait",
                square: "square"
            };
            function d(e, t) {
                return e && t ? e < t ? u.portrait : e > t ? u.landscape : u.square : null
            }
        },
        5381: function(e, t, n) {
            "use strict";
            n.d(t, {
                L3: function() {
                    return r
                },
                fr: function() {
                    return s
                },
                kB: function() {
                    return i
                },
                lU: function() {
                    return o
                }
            });
            const r = {
                xlarge: "xlarge",
                large: "large",
                medium: "medium",
                small: "small"
            }
              , o = {
                default: "default",
                nav: "nav"
            }
              , i = {
                [o.default]: {
                    [r.xlarge]: {
                        minWidth: 1920,
                        contentWidth: 1536
                    },
                    [r.large]: {
                        minWidth: 1251,
                        contentWidth: 980
                    },
                    [r.medium]: {
                        minWidth: 736,
                        maxWidth: 1068,
                        contentWidth: 692
                    },
                    [r.small]: {
                        minWidth: 320,
                        maxWidth: 735,
                        contentWidth: 280
                    }
                },
                [o.nav]: {
                    [r.large]: {
                        minWidth: 1024
                    },
                    [r.medium]: {
                        minWidth: 768,
                        maxWidth: 1023
                    },
                    [r.small]: {
                        minWidth: 320,
                        maxWidth: 767
                    }
                }
            }
              , a = {
                [r.small]: 0,
                [r.medium]: 1,
                [r.large]: 2
            };
            function s(e, t) {
                return a[e] > a[t]
            }
        },
        9030: function(e, t, n) {
            "use strict";
            n.d(t, {
                KP: function() {
                    return c
                },
                dZ: function() {
                    return s
                },
                jk: function() {
                    return u
                }
            });
            var r = n(2412)
              , o = n(7788)
              , i = n(3465);
            const a = r.reduce(((e,t)=>({
                ...e,
                [t.slug]: t.code
            })), {});
            function s(e) {
                return a[e]
            }
            function l(e) {
                return !!a[e]
            }
            function c(e) {
                return {
                    params: {
                        locale: e === o.defaultLocale ? void 0 : e
                    }
                }
            }
            function u(e=o.defaultLocale, t={}) {
                if (!l(e))
                    return;
                t.$i18n.locale = e;
                const n = s(e);
                (0,
                i.e)(n)
            }
        },
        5657: function(e, t, n) {
            "use strict";
            function r(e) {
                let t = null
                  , n = e - 1;
                const r = new Promise((e=>{
                    t = e
                }
                ));
                return requestAnimationFrame((function e() {
                    n -= 1,
                    n <= 0 ? t() : requestAnimationFrame(e)
                }
                )),
                r
            }
            function o(e) {
                return new Promise((t=>{
                    setTimeout(t, e)
                }
                ))
            }
            n.d(t, {
                J: function() {
                    return r
                },
                X: function() {
                    return o
                }
            })
        },
        3465: function(e, t, n) {
            "use strict";
            n.d(t, {
                X: function() {
                    return u
                },
                e: function() {
                    return d
                }
            });
            var r = n(9089)
              , o = n(2449);
            const i = (0,
            r.$8)(["meta", "title"], "Documentation")
              , a = ({title: e, description: t, url: n, currentLocale: r})=>[{
                name: "description",
                content: t
            }, {
                property: "og:locale",
                content: r
            }, {
                property: "og:site_name",
                content: i
            }, {
                property: "og:type",
                content: "website"
            }, {
                property: "og:title",
                content: e
            }, {
                property: "og:description",
                content: t
            }, {
                property: "og:url",
                content: n
            }, {
                property: "og:image",
                content: (0,
                o.HH)("/developer-og.jpg")
            }, {
                name: "twitter:image",
                content: (0,
                o.HH)("/developer-og-twitter.jpg")
            }, {
                name: "twitter:card",
                content: "summary_large_image"
            }, {
                name: "twitter:description",
                content: t
            }, {
                name: "twitter:title",
                content: e
            }, {
                name: "twitter:url",
                content: n
            }]
              , s = e=>[e, i].filter(Boolean).join(" | ")
              , l = e=>{
                const {content: t} = e
                  , n = e.property ? "property" : "name"
                  , r = e[n]
                  , o = document.querySelector(`meta[${n}="${r}"]`);
                if (o && t)
                    o.setAttribute("content", t);
                else if (o && !t)
                    o.remove();
                else if (t) {
                    const t = document.createElement("meta");
                    t.setAttribute(n, e[n]),
                    t.setAttribute("content", e.content),
                    document.getElementsByTagName("head")[0].appendChild(t)
                }
            }
              , c = e=>{
                document.title = e
            }
            ;
            function u({title: e, description: t, url: n, currentLocale: r}) {
                const o = s(e);
                c(o),
                a({
                    title: o,
                    description: t,
                    url: n,
                    currentLocale: r
                }).forEach((e=>l(e)))
            }
            function d(e) {
                document.querySelector("html").setAttribute("lang", e)
            }
        },
        5394: function(e, t, n) {
            "use strict";
            var r = n(7247);
            const o = {
                preferredColorScheme: "developer.setting.preferredColorScheme",
                preferredLocale: "developer.setting.preferredLocale",
                preferredLanguage: "docs.setting.preferredLanguage"
            }
              , i = {
                preferredColorScheme: "docs.setting.preferredColorScheme"
            };
            t["Z"] = Object.defineProperties({}, Object.keys(o).reduce(((e,t)=>({
                ...e,
                [t]: {
                    get: ()=>{
                        const e = i[t]
                          , n = r.mr.getItem(o[t]);
                        return e ? n || r.mr.getItem(e) : n
                    }
                    ,
                    set: e=>r.mr.setItem(o[t], e)
                }
            })), {}))
        },
        7247: function(e, t, n) {
            "use strict";
            n.d(t, {
                mr: function() {
                    return a
                },
                tO: function() {
                    return l
                },
                y7: function() {
                    return c
                }
            });
            const r = "developer.setting.";
            function o(e=localStorage) {
                return {
                    getItem: t=>{
                        try {
                            return e.getItem(t)
                        } catch (n) {
                            return null
                        }
                    }
                    ,
                    setItem: (t,n)=>{
                        try {
                            e.setItem(t, n)
                        } catch (r) {}
                    }
                    ,
                    removeItem: t=>{
                        try {
                            e.removeItem(t)
                        } catch (n) {}
                    }
                }
            }
            function i(e) {
                return {
                    get: (t,n)=>{
                        const o = JSON.parse(e.getItem(r + t));
                        return null !== o ? o : n
                    }
                    ,
                    set: (t,n)=>e.setItem(r + t, JSON.stringify(n)),
                    remove: t=>e.removeItem(r + t)
                }
            }
            const a = o(window.localStorage)
              , s = o(window.sessionStorage)
              , l = i(a)
              , c = i(s)
        },
        3208: function(e, t, n) {
            "use strict";
            n.d(t, {
                HA: function() {
                    return a
                },
                RL: function() {
                    return u
                },
                Xv: function() {
                    return s
                },
                ZQ: function() {
                    return d
                },
                hr: function() {
                    return c
                },
                id: function() {
                    return m
                },
                sj: function() {
                    return l
                }
            });
            n(8269);
            const r = /(?:\s+|[`"<>])/g
              , o = /^-+/
              , i = /["'&<>]/g;
            function a(e) {
                return e.trim().replace(r, "-").replace(o, "").toLowerCase()
            }
            function s(e) {
                const t = e=>({
                    '"': "&quot;",
                    "'": "&apos;",
                    "&": "&amp;",
                    "<": "&lt;",
                    ">": "&gt;"
                }[e] || e);
                return e.replace(i, t)
            }
            function l(e) {
                return e.replace(/#(.*)/, ((e,t)=>`#${CSS.escape(t)}`))
            }
            function c(e) {
                return e.replace(/[.*+\-?^${}()|[\]\\]/g, "\\$&")
            }
            function u(e) {
                let t, n;
                const r = "\\s*"
                  , o = " "
                  , i = e.trim()
                  , a = i.length;
                if (!a)
                    return o;
                const s = [];
                for (t = 0; t < a; t += 1)
                    n = i[t],
                    "\\" === n ? (s.push(`${0 === t ? "" : r}${n}`),
                    s.push(i[t + 1]),
                    t += 1) : 0 === t ? s.push(n) : n !== o && s.push(`${r}${n}`);
                return s.join("")
            }
            function d(e, t, n=0) {
                return `${e.slice(0, n)}${t}${e.slice(n)}`
            }
            function m(e) {
                const t = e.split(/(?:\r?\n)+/);
                return t[0]
            }
        },
        9089: function(e, t, n) {
            "use strict";
            function r(e, t, n) {
                let r, o = e, i = t;
                for ("string" === typeof i && (i = [i]),
                r = 0; r < i.length; r += 1) {
                    if ("undefined" === typeof o[i[r]])
                        return n;
                    o = o[i[r]]
                }
                return o
            }
            n.d(t, {
                FH: function() {
                    return a
                },
                Kx: function() {
                    return s
                },
                $8: function() {
                    return l
                },
                S3: function() {
                    return i
                }
            });
            var o = n(2449);
            const i = {
                meta: {},
                theme: {},
                features: {}
            }
              , {baseUrl: a} = window;
            async function s() {
                const e = (0,
                o.HH)("/theme-settings.json");
                return fetch(e).then((e=>e.json())).catch((()=>({})))
            }
            const l = (e,t)=>r(i, e, t)
        },
        2449: function(e, t, n) {
            "use strict";
            n.d(t, {
                Lp: function() {
                    return s
                },
                Q2: function() {
                    return a
                },
                WN: function() {
                    return l
                },
                Ex: function() {
                    return i
                },
                HH: function() {
                    return c
                }
            });
            var r = n(5947)
              , o = {
                input: "input",
                tags: "tags"
            };
            function i(e={}) {
                return Object.entries(e).reduce(((e,[t,n])=>n ? e.concat(`${encodeURIComponent(t)}=${encodeURIComponent(n)}`) : e), []).join("&")
            }
            function a(e, {changes: t, language: n, context: r}={}) {
                const [o,a] = e.split("#")
                  , s = o.match(/\?.*/)
                  , l = i({
                    changes: t,
                    language: n,
                    context: r
                })
                  , c = s ? "&" : "?"
                  , u = a ? o : e
                  , d = l ? `${c}${l}` : ""
                  , m = a ? `#${a}` : "";
                return `${u}${d}${m}`
            }
            function s(e, t) {
                const {query: {changes: n, [o.input]: r, [o.tags]: i, ...a}={}} = e
                  , {query: {changes: s, [o.input]: l, [o.tags]: c, ...u}={}} = t;
                return e.name === t.name && JSON.stringify({
                    path: e.path,
                    query: a
                }) === JSON.stringify({
                    path: t.path,
                    query: u
                })
            }
            function l(e, t=window.location.href) {
                return new URL((0,
                r.AH)(e),t)
            }
            function c(e, t) {
                return l(e, t).href
            }
        },
        647: function(e, t, n) {
            n.p = window.baseUrl
        },
        2412: function(e) {
            "use strict";
            e.exports = JSON.parse('[{"code":"en-US","name":"English","slug":"en-US"},{"code":"zh-CN","name":"简体中文","slug":"zh-CN"},{"code":"ja-JP","name":"日本語","slug":"ja-JP"},{"code":"ko-KR","name":"한국어","slug":"ko-KR"}]')
        }
    }
      , t = {};
    function n(r) {
        var o = t[r];
        if (void 0 !== o)
            return o.exports;
        var i = t[r] = {
            exports: {}
        };
        return e[r].call(i.exports, i, i.exports, n),
        i.exports
    }
    n.m = e,
    function() {
        var e = [];
        n.O = function(t, r, o, i) {
            if (!r) {
                var a = 1 / 0;
                for (u = 0; u < e.length; u++) {
                    r = e[u][0],
                    o = e[u][1],
                    i = e[u][2];
                    for (var s = !0, l = 0; l < r.length; l++)
                        (!1 & i || a >= i) && Object.keys(n.O).every((function(e) {
                            return n.O[e](r[l])
                        }
                        )) ? r.splice(l--, 1) : (s = !1,
                        i < a && (a = i));
                    if (s) {
                        e.splice(u--, 1);
                        var c = o();
                        void 0 !== c && (t = c)
                    }
                }
                return t
            }
            i = i || 0;
            for (var u = e.length; u > 0 && e[u - 1][2] > i; u--)
                e[u] = e[u - 1];
            e[u] = [r, o, i]
        }
    }(),
    function() {
        n.n = function(e) {
            var t = e && e.__esModule ? function() {
                return e["default"]
            }
            : function() {
                return e
            }
            ;
            return n.d(t, {
                a: t
            }),
            t
        }
    }(),
    function() {
        var e, t = Object.getPrototypeOf ? function(e) {
            return Object.getPrototypeOf(e)
        }
        : function(e) {
            return e.__proto__
        }
        ;
        n.t = function(r, o) {
            if (1 & o && (r = this(r)),
            8 & o)
                return r;
            if ("object" === typeof r && r) {
                if (4 & o && r.__esModule)
                    return r;
                if (16 & o && "function" === typeof r.then)
                    return r
            }
            var i = Object.create(null);
            n.r(i);
            var a = {};
            e = e || [null, t({}), t([]), t(t)];
            for (var s = 2 & o && r; "object" == typeof s && !~e.indexOf(s); s = t(s))
                Object.getOwnPropertyNames(s).forEach((function(e) {
                    a[e] = function() {
                        return r[e]
                    }
                }
                ));
            return a["default"] = function() {
                return r
            }
            ,
            n.d(i, a),
            i
        }
    }(),
    function() {
        n.d = function(e, t) {
            for (var r in t)
                n.o(t, r) && !n.o(e, r) && Object.defineProperty(e, r, {
                    enumerable: !0,
                    get: t[r]
                })
        }
    }(),
    function() {
        n.f = {},
        n.e = function(e) {
            return Promise.all(Object.keys(n.f).reduce((function(t, r) {
                return n.f[r](e, t),
                t
            }
            ), []))
        }
    }(),
    function() {
        n.u = function(e) {
            return "js/" + ({
                82: "highlight-js-json-js",
                113: "highlight-js-markdown-js",
                133: "highlight-js-llvm-js",
                162: "topic",
                176: "highlight-js-shell-js",
                213: "highlight-js-diff-js",
                217: "highlight-js-custom-swift",
                392: "highlight-js-scss-js",
                393: "highlight-js-bash-js",
                435: "highlight-js-python-js",
                490: "highlight-js-xml-js",
                527: "highlight-js-swift-js",
                546: "highlight-js-c-js",
                596: "highlight-js-php-js",
                621: "highlight-js-cpp-js",
                623: "highlight-js-ruby-js",
                637: "highlight-js-objectivec-js",
                642: "highlight-js-custom-markdown",
                645: "highlight-js-perl-js",
                788: "highlight-js-java-js",
                814: "highlight-js-javascript-js",
                843: "tutorials-overview",
                864: "highlight-js-css-js",
                878: "highlight-js-http-js",
                982: "documentation-topic"
            }[e] || e) + "." + {
                82: "2a1856ba",
                113: "a2f456af",
                133: "26121771",
                162: "ab787ebd",
                176: "0ad5b20f",
                213: "4db9a783",
                217: "738731d1",
                295: "6966d4c1",
                337: "274a8ccc",
                392: "adcd11a2",
                393: "702f0c5c",
                427: "3c1b9c17",
                435: "60354774",
                490: "0d78f903",
                527: "bdd5bff5",
                546: "063069d3",
                596: "c458ffa4",
                621: "458a9ae4",
                623: "7272231f",
                637: "74dea052",
                642: "78c9f6ed",
                645: "da6eda82",
                788: "4fe21e94",
                814: "dfc9d16d",
                842: "e644dd3b",
                843: "27a4787e",
                864: "bfc4251f",
                878: "f78e83c2",
                976: "37a8b278",
                982: "07d2e14d"
            }[e] + ".js"
        }
    }(),
    function() {
        n.miniCssF = function(e) {
            return "css/" + ({
                162: "topic",
                843: "tutorials-overview",
                982: "documentation-topic"
            }[e] || e) + "." + {
                162: "d3630284",
                295: "875b8dab",
                427: "ee43802d",
                843: "ddd5b228",
                982: "47a08486"
            }[e] + ".css"
        }
    }(),
    function() {
        n.g = function() {
            if ("object" === typeof globalThis)
                return globalThis;
            try {
                return this || new Function("return this")()
            } catch (e) {
                if ("object" === typeof window)
                    return window
            }
        }()
    }(),
    function() {
        n.o = function(e, t) {
            return Object.prototype.hasOwnProperty.call(e, t)
        }
    }(),
    function() {
        var e = {}
          , t = "swift-docc-render:";
        n.l = function(r, o, i, a) {
            if (e[r])
                e[r].push(o);
            else {
                var s, l;
                if (void 0 !== i)
                    for (var c = document.getElementsByTagName("script"), u = 0; u < c.length; u++) {
                        var d = c[u];
                        if (d.getAttribute("src") == r || d.getAttribute("data-webpack") == t + i) {
                            s = d;
                            break
                        }
                    }
                s || (l = !0,
                s = document.createElement("script"),
                s.charset = "utf-8",
                s.timeout = 120,
                n.nc && s.setAttribute("nonce", n.nc),
                s.setAttribute("data-webpack", t + i),
                s.src = r),
                e[r] = [o];
                var m = function(t, n) {
                    s.onerror = s.onload = null,
                    clearTimeout(p);
                    var o = e[r];
                    if (delete e[r],
                    s.parentNode && s.parentNode.removeChild(s),
                    o && o.forEach((function(e) {
                        return e(n)
                    }
                    )),
                    t)
                        return t(n)
                }
                  , p = setTimeout(m.bind(null, void 0, {
                    type: "timeout",
                    target: s
                }), 12e4);
                s.onerror = m.bind(null, s.onerror),
                s.onload = m.bind(null, s.onload),
                l && document.head.appendChild(s)
            }
        }
    }(),
    function() {
        n.r = function(e) {
            "undefined" !== typeof Symbol && Symbol.toStringTag && Object.defineProperty(e, Symbol.toStringTag, {
                value: "Module"
            }),
            Object.defineProperty(e, "__esModule", {
                value: !0
            })
        }
    }(),
    function() {
        n.p = "{{BASE_PATH}}/"
    }(),
    function() {
        var e = function(e, t, n, r) {
            var o = document.createElement("link");
            o.rel = "stylesheet",
            o.type = "text/css";
            var i = function(i) {
                if (o.onerror = o.onload = null,
                "load" === i.type)
                    n();
                else {
                    var a = i && ("load" === i.type ? "missing" : i.type)
                      , s = i && i.target && i.target.href || t
                      , l = new Error("Loading CSS chunk " + e + " failed.\n(" + s + ")");
                    l.code = "CSS_CHUNK_LOAD_FAILED",
                    l.type = a,
                    l.request = s,
                    o.parentNode.removeChild(o),
                    r(l)
                }
            };
            return o.onerror = o.onload = i,
            o.href = t,
            document.head.appendChild(o),
            o
        }
          , t = function(e, t) {
            for (var n = document.getElementsByTagName("link"), r = 0; r < n.length; r++) {
                var o = n[r]
                  , i = o.getAttribute("data-href") || o.getAttribute("href");
                if ("stylesheet" === o.rel && (i === e || i === t))
                    return o
            }
            var a = document.getElementsByTagName("style");
            for (r = 0; r < a.length; r++) {
                o = a[r],
                i = o.getAttribute("data-href");
                if (i === e || i === t)
                    return o
            }
        }
          , r = function(r) {
            return new Promise((function(o, i) {
                var a = n.miniCssF(r)
                  , s = n.p + a;
                if (t(a, s))
                    return o();
                e(r, s, o, i)
            }
            ))
        }
          , o = {
            826: 0
        };
        n.f.miniCss = function(e, t) {
            var n = {
                162: 1,
                295: 1,
                427: 1,
                843: 1,
                982: 1
            };
            o[e] ? t.push(o[e]) : 0 !== o[e] && n[e] && t.push(o[e] = r(e).then((function() {
                o[e] = 0
            }
            ), (function(t) {
                throw delete o[e],
                t
            }
            )))
        }
    }(),
    function() {
        var e = {
            826: 0
        };
        n.f.j = function(t, r) {
            var o = n.o(e, t) ? e[t] : void 0;
            if (0 !== o)
                if (o)
                    r.push(o[2]);
                else if (427 != t) {
                    var i = new Promise((function(n, r) {
                        o = e[t] = [n, r]
                    }
                    ));
                    r.push(o[2] = i);
                    var a = n.p + n.u(t)
                      , s = new Error
                      , l = function(r) {
                        if (n.o(e, t) && (o = e[t],
                        0 !== o && (e[t] = void 0),
                        o)) {
                            var i = r && ("load" === r.type ? "missing" : r.type)
                              , a = r && r.target && r.target.src;
                            s.message = "Loading chunk " + t + " failed.\n(" + i + ": " + a + ")",
                            s.name = "ChunkLoadError",
                            s.type = i,
                            s.request = a,
                            o[1](s)
                        }
                    };
                    n.l(a, l, "chunk-" + t, t)
                } else
                    e[t] = 0
        }
        ,
        n.O.j = function(t) {
            return 0 === e[t]
        }
        ;
        var t = function(t, r) {
            var o, i, a = r[0], s = r[1], l = r[2], c = 0;
            if (a.some((function(t) {
                return 0 !== e[t]
            }
            ))) {
                for (o in s)
                    n.o(s, o) && (n.m[o] = s[o]);
                if (l)
                    var u = l(n)
            }
            for (t && t(r); c < a.length; c++)
                i = a[c],
                n.o(e, i) && e[i] && e[i][0](),
                e[i] = 0;
            return n.O(u)
        }
          , r = self["webpackChunkswift_docc_render"] = self["webpackChunkswift_docc_render"] || [];
        r.forEach(t.bind(null, 0)),
        r.push = t.bind(null, r.push.bind(r))
    }();
    var r = n.O(void 0, [998], (function() {
        return n(7441)
    }
    ));
    r = n.O(r)
}
)();
