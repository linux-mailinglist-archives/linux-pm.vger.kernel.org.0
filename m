Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E411CCD1B
	for <lists+linux-pm@lfdr.de>; Sun, 10 May 2020 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgEJSwD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 10 May 2020 14:52:03 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:43870 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbgEJSwD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 10 May 2020 14:52:03 -0400
X-AuditID: c0a8fbf4-473ff70000004419-75-5eb84d51c019
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id D5.36.17433.15D48BE5; Sun, 10 May 2020 20:52:01 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Sun, 10 May 2020 20:51:53 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "sebastian.reichel@collabora.com" <sebastian.reichel@collabora.com>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v12 00/11] Support ROHM BD99954 charger IC
Thread-Topic: [PATCH v12 00/11] Support ROHM BD99954 charger IC
Thread-Index: AQHWJU7PJ3Z/Wwfk3U+H3drETuWBPqihXU2AgAAur4A=
Date:   Sun, 10 May 2020 18:51:53 +0000
Message-ID: <501265638c16ffa06a77be37e1feeb2c9cb732bb.camel@fi.rohmeurope.com>
References: <cover.1588944082.git.matti.vaittinen@fi.rohmeurope.com>
         <20200510160445.6fg2v7jug2vlepkv@earth.universe>
In-Reply-To: <20200510160445.6fg2v7jug2vlepkv@earth.universe>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0EBFE37509FB5543A95BEB02E3824F45@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SW0wTQRSGmd1tO6WsDgVkwAvaxBg0gBAiG6LIk9Yb0eiTRnCRtUVKS7at
        giERDIjUK6kaacAggtcEZFWojQ/agAFjIERFNEVTICA3XySI1qC7rgpP88355z//SeZAUjun
        iIa5ZhvHm1mTThlMPbsTEOL27HJnrq+4r2F6+50kc8U/rGRm3pwhmNeeGiXz9Xw7YGoaOylm
        YCIjXaV3DzQA/RPXgEpfJ9j1wr1Kpf6rsGK3Yr9mYzZrO7Y312BOSDukMbY0B5QFHlToHJxW
        loAy5ABqiFEyFgYuKhwgGGpRH8AztycJ+dIJ8OPBq6QDQKhEG7HjvUrCcLQVV1/WS14SvSRw
        RZVF4jCUhm+M9gKJw9Fm7Ju9QMmcittP/1BKTKHV2H2ulJSYRhl4usf3h7WoEP+cqv/zRo02
        YVdpFyExQMtxZckXQs6KxMLIN4U8M8INT3tImSPw2NDc3/oq3PatiZLGJFEsbvYkyJiOPU07
        5C6r8OWzfpU8QSjuqh6mLoElrgUBrnmza97sWmB2LTDXAcU9gPPZXJOBtXGJ8Txnj+ctxnzx
        OGzJF4D8n9Nu8Mu7zQsICLwgChK6CDo1xJ2pXZRtySkyslZjFm83cVYvwJDUhdNVhY8ytXQO
        W3SC4y3/pKWQ0kXSa/xVB7VIysrjuAKO/6cug1CHaXqn2DSU5wxc4ZFck21eJqBaah4cHW7l
        zDkcz9ptxixpN7Ks4nJIUoiY279DtNPWAjZfrMrWl2AdvDRWW0/C9trGelJLmS1mLjqS7n3e
        lqlF0lOj3fw/aBxEQqALo/ukOULEpf7fZ1yMIMQI/2irFGFj56XoEuC9e636Zt2+hJyHzp2J
        Hd3uoOagjxcmPsz4umN8qqSyO2Waxa6SiFflcQ8Nowc8PWpDUcr1pBc4j3wQp69fORKTwidv
        954r3hCYaj267Pu7FjjZ8dk5G2O5dbKGqXIIn9zOxlfJeUFb9MXHk8pP9S3va2lqbfM40dvA
        UGesL6pdR1mNbOJakreyvwG7mUcZkQMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGEgbG90IFNlYmFzdGlhbiBhbmQgTWFyayENCg0KT24gU3VuLCAyMDIwLTA1LTEwIGF0
IDE4OjA0ICswMjAwLCBTZWJhc3RpYW4gUmVpY2hlbCB3cm90ZToNCj4gSGksDQo+IA0KPiBPbiBG
cmksIE1heSAwOCwgMjAyMCBhdCAwNjozODoxN1BNICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3Jv
dGU6DQo+ID4gUGxlYXNlIG5vdGUgdGhhdCB0aGlzIHNlcmllcyBzaG91bGQgYmUgYXBwbGllZCB0
byB0d28gdHJlZXMuDQo+ID4gUGF0Y2hlcw0KPiA+IDEtNCAob3IgMS01IGFzIHN1Z2dlc3RlZCBi
eSBTZWJhc3RpYW4pIHNob3VsZCBnbyB0byByZWd1bGF0b3IgdHJlZS4NCj4gPiBQZXJoYXBzIE1h
cmsgY2FuIHByb3ZpZGUgYW4gaW1tdXRhYmxlIGJyYW5jaCB0byBTZWJhc3RpYW4/IFJlc3Qgb2YN
Cj4gPiB0aGUNCj4gPiBwYXRjaGVzIGNhbiB0aGVuIGdvIHRvIHBvd2VyLXN1cHBseSB0cmVlLg0K
PiANCj4gVGhhbmtzLCBJIG1lcmdlZCB0aGUgcHVsbC1yZXF1ZXN0IGZyb20gTWFyayBhbmQgcXVl
dWVkIHBhdGNoZXMgNS0xMS4NCj4gDQoNCkkgdGhpbmsgaXQncyBmYWlyIHRvIHBvaW50IG91dCBh
bHNvIGZvciBTZWJhc3RpYW4gdGhhdCBNYXJrIHNwb3R0ZWQgYQ0KY29tcGlsZSB0aW1lIHdhcm5p
bmcgZnJvbSBsaW5lYXJfcmFuZ2VzIHdoZW4gaXQgaXMgY29tcGlsZWQgYXMgYQ0KbW9kdWxlLiBU
aGlzIGlzIG9ubHkgb2NjdXJyaW5nIHdoZW4gbGluZWFyX3JhbmdlcyBpcyBjb21waWxlZCBhcyBh
DQptb2R1bGUuIEFuZCB0aGF0IHJlcXVpcmVzIENPTkZJR19SRUdVTEFUT1IgdG8gYmUgbiBhbmQg
bGluZWFyX3Jhbmdlcw0KdGVzdCB0byBiZSBtLiBJIGd1ZXNzIHRoaXMgaXMgdW5saWtlbHkgYXMg
SSB0aGluayBlbmFibGluZw0KbGluZWFyX3JhbmdlcyB0ZXN0IGNvZGUgaXMgbm90IGNvbW1vbiBm
b3Igc2V0dXBzIHRoYXQgYXJlIG5vdCB1c2luZw0KbGluZWFyIHJhbmdlcyAtIGJ1dCBmb3Igc3Vy
ZSBzb21lIHRlc3Qgc2V0dXAgaGl0cyB0aGlzIHNvbWV3aGVyZS4NCg0KUHJvYmxlbSBpcyB0aGF0
IGxpbmVhcl9yYW5nZXMgY2FuIGJlIGNvbXBpbGVkIGFzIG1vZHVsZSAoaXQncyB0cmlzdGF0ZWQN
CmluIEtjb25maWcpIGJ1dCBkb2VzIG5vdCBkZWNsYXJlIE1PRFVMRV9MSUNFTkNFIG1hY3JvLg0K
DQpJIHNlbnQgdGhpcyBpbmNyZW1lbnRhbCBwYXRjaCB3aGljaCBzaG91bGQgZml4IHRoZSBpc3N1
ZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA1MDkxNTE1MTkuR0E3MTAwQGxv
Y2FsaG9zdC5sb2NhbGRvbWFpbi8NCg0KIC0gYnV0IGRvZXMgYXBwbHlpbmcgaXQgdG8gZWl0aGVy
IHBvd2VyLXN1cHBseSBvciByZWd1bGF0b3IgY2F1c2UgYQ0KY29uZmxpY3Q/DQoNCkkganVzdCB3
YW50ZWQgdG8gcG9pbnQgdGhpcyBvdXQgLSBzb3JyeSBmb3IgdGhlIHRyb3VibGUhIEFuZCBwbGVh
c2UgbGV0DQptZSBrbm93IGlmIHlvdSB3aXNoIG1lIHRvIHNlbmQgc29tZSBvdGhlciBmaXguIEkg
d2lsbCBnbGFkbHkgZG8gc28gYW5kDQpjb3JyZWN0IG15IGJ1Z3MgOikNCg0KLS1NYXR0aQ0KDQo=
