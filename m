Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 584EE16A5F9
	for <lists+linux-pm@lfdr.de>; Mon, 24 Feb 2020 13:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727426AbgBXMU1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Feb 2020 07:20:27 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:62798 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgBXMU1 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Feb 2020 07:20:27 -0500
X-AuditID: c0a8fbf4-473ff70000004419-86-5e53bf889afe
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 53.8E.17433.88FB35E5; Mon, 24 Feb 2020 13:20:24 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Mon, 24 Feb 2020 13:20:12 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "sbkim73@samsung.com" <sbkim73@samsung.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "wens@csie.org" <wens@csie.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rf@opensource.cirrus.com" <rf@opensource.cirrus.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "b.zolnierkie@samsung.com" <b.zolnierkie@samsung.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "milo.kim@ti.com" <milo.kim@ti.com>,
        "agross@kernel.org" <agross@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "andrei.stefanescu@microchip.com" <andrei.stefanescu@microchip.com>,
        "support.opensource@diasemi.com" <support.opensource@diasemi.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>
Subject: Re: [RFC PATCH v3 4/8] regulator: rename regulator_linear_range to
 linear_range
Thread-Topic: [RFC PATCH v3 4/8] regulator: rename regulator_linear_range to
 linear_range
Thread-Index: AQHV58Bw3BR2Lobf/kermjlWXvyueKgqMeKAgAAHZAA=
Date:   Mon, 24 Feb 2020 12:20:11 +0000
Message-ID: <d66373944b9afa9e2387d7bf95deb9d997906396.camel@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <f66749295e07448012c80c2054b1f14506d17d76.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <20200224115349.GD6215@sirena.org.uk>
In-Reply-To: <20200224115349.GD6215@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7667C38386FA7740BDE72887EC73452E@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tb0wTZxzH89xd747ibY+1yCPub5fFiOGf+uLJQogme3HbkmnGiyVugFc4
        KbG05Noa2Zs1w27SRUAZwipVBBoZENGyTAVKXdNlYB1dB1SMzqQrMdNkkGHFAU52107h1f3u
        +f75PC9+D0tqLjBZbJXJKkomwaij1dT1nhVvznF/cWn+D6u78UR8hcINC50kvtw2oMIJ9w0K
        h/xzFG6JzdJ4yuEF+FxwQoXrugZoHA5fYvDi1HECe+NRFT7p/4XBk0PtNJ6siwB8pruRwo9O
        BAFuC48S2HMrQuAvju3C7Z4xCl9YviiL834VdidaSBxpC5PY4QsyONKTIHBo2Ip9jgiJ/VPv
        46VAmNjzOt9/th/wi49PUfz8jIPhL/3Rp+J7FvL4a67fGd7bW0/zd6MjNO939zP8YPfn/N1/
        PIBvbV8FfMP3vYD/eeYKwT/yvrb/5QPphXrBeqS4qtKUV3Qw3dDdllHTkH50NvqUsYM/1U6Q
        xiK4G/XdmaGcQM1q4DRAk+5jIPUzBlDr/VbSCViWhoXIeZtRAlqYg1qWu2jFQ8JlDj2eeKJS
        hE3wAJq7EqQVvxZ+ghyNh1P+d9DZrtGkhYJvo/HBWLKSgx+if1ffTaFuArR4ejrZnwZ3ossz
        p5N+AF9F9fY5QplJmIm891MoBCHqHgmTqTkDPYg/+/9ch3xLMUrpJ+F2NDCUl4ruQcP2eyA1
        v4m++TqWRHFwIxr/dpZqAptd6wiutbRrXdq1Lu1al+4Aql6AqoUqY6VgFQtyJdGWK5kN1fKn
        3FztBanFS1wFq4H3AoBgQQBsYQldBqf2FpdqXtKbK2oNgsVQJtmMoiUAEEvqtNwH4KNSDVch
        1H4mSubn0laW0mVy22InSzRQYR0WxRpReq6+wrI6xMV8culGSawUjx6qMlrXZIJNU8rVWVqL
        aKoQJcFmNZQp21FmkddDkTbI3M3Dcpyz1AjV8mkqegPsYJseuDtJNuj2dJIaymQ2iVmZXP2o
        bIWK1WAzvQA9BJks0G3iFpR7bJBf34uehzKCkBFvsfsVhFVYk7LsQK/5bf5Ts62vSN8y7zwX
        iv1kJLNzDy1amOjHJy66Coo6/oruaN6S8Fj/3lo8XapvivOFX9bubT7fHIJPtu9cao0P7WuX
        6mD+CvjunnH5oKD9MXT1iHbEcHNXdmPwq6e+kvzEeEflG+XPfCX8nUZP/hm9vXzf3pyxwQ7L
        r6ZT6us6ymIQCrJJySL8B5/2GPU6BAAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gTWFyaywNCg0KT24gTW9uLCAyMDIwLTAyLTI0IGF0IDExOjUzICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiBPbiBUaHUsIEZlYiAyMCwgMjAyMCBhdCAwOTozNjoxMEFNICswMjAwLCBN
YXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gUmVuYW1lIHRoZSAicmVndWxhdG9yX2xpbmVhcl9y
YW5nZSIgdG8gbW9yZSBnZW5lcmljIGxpbmVhcl9yYW5nZQ0KPiA+IGFzIGEgZmlyc3Qgc3RlcCB0
b3dhcmRzIGNvbnZlcnRpbmcgdGhlICJyZWd1bGF0b3JfbGluZWFyX3JhbmdlIg0KPiA+IHRvIGNv
bW1vbiBoZWxwZXJzLg0KPiANCj4gRG9lc24ndCB0aGlzIGludHJvZHVjZSBhIGJ1aWxkIGJyZWFr
IHdoZW4gYXBwbGllZCBieSBpdHNlbGY/ICBQYXRjaGVzDQo+IHNob3VsZCBiZSBiaXNlY3RhYmxl
LCBpZiB5b3Ugd2FudCB0byBzcGxpdCB0aGluZ3MgdXAgeW91IHNob3VsZA0KPiBpbnRyb2R1Y2Ug
dGhlIG5ldyBBUEkgdGhlbiB1c2UgaXQuDQoNClVoLCBJIG5lZWQgdG8gZG91YmxlIGNoZWNrIGJ1
dCB0aGlzIHNob3VsZG4ndCBjYXVzZSBidWlsZCBicmVhayBhcyBvbmx5DQp0aGUgbmFtZSBvZiB0
aGUgc3RydWN0IGlzIGNoYW5nZWQgLSBhbmQgSSBpbnRlbmRlZCB0byBjaGFuZ2UgaXQgYm90aCBp
bg0KcmVndWxhdG9yIGhlYWRlciBhbmQgaW4gYWxsIG9mIHRoZSBkcml2ZXJzIHVzaW5nIGl0IGF0
IHNhbWUgdGltZS4gT3INCmRpZCBJIGRvIHNvbWUgYnJhaW5mYXJ0IGhlcmU/DQoNCkkganVzdCB3
YW50ZWQgdG8gbWluaW1pemUgdGhlIGNoYW5nZXMgaW4gcGF0Y2ggd2l0aCB0aGUgd2lkZXN0DQph
dWRpZW5jZS4NCg0KT2gsIGFmdGVyIHJlYmFzaW5nIHRvIGxpbnV4ICA1LjYtcmMyIEkgc2VlIHRo
YXQgdGhlcmUgYXJlIGZldyBuZXcgdXNlcnMNCm9mIHJlZ3VsYXRvcl9saW5lYXJfcmFuZ2UgKEkg
c2hvdWxkIGhhdmUga25vd24gdGhhdC4uLikgLSBuYXR1YXJsbHkgYWxsDQpvZiB0aGUgdXNlcnMg
bmVlZCB0byBiZSBjb3ZlcmVkIGJlZm9yZSBhcHBseWluZyB0aGlzLg0KDQpCciwNCglNYXR0aSBW
YWl0dGluZW4NCg==
