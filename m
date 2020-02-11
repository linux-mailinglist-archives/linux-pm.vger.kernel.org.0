Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E10715906C
	for <lists+linux-pm@lfdr.de>; Tue, 11 Feb 2020 14:53:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728667AbgBKNxG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 11 Feb 2020 08:53:06 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:57018 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbgBKNxG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 11 Feb 2020 08:53:06 -0500
X-AuditID: c0a8fbf4-279ff70000001e6c-45-5e42b1c0db7a
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 80.B6.07788.0C1B24E5; Tue, 11 Feb 2020 14:53:04 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Tue, 11 Feb 2020 14:52:58 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Thread-Topic: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Thread-Index: AQHUtJ37F9J3F5izh0ixQskYfWqxuaXElbMAgAAxfs2CS0QlgIAGokgAgAAOIICAAYTjAIAACoYA
Date:   Tue, 11 Feb 2020 13:52:58 +0000
Message-ID: <2cd8fb44f0fe65c3654ba1f1d49aa30e1894ada5.camel@fi.rohmeurope.com>
References: <20190125110600.GA29332@localhost.localdomain>
         <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
         <20190128135354.GA4156@localhost.localdomain>
         <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
         <bf72c35353dc2442794ab5cf19c7074abaccea9d.camel@fi.rohmeurope.com>
         <CACRpkdaxJ-xM4Tak=C1Y_e9xy1KK21v93fhtUdh+TH=-Nx30zg@mail.gmail.com>
         <17e9b06aa05b81e22a37c198d59f76d362e288ea.camel@fi.rohmeurope.com>
         <CACRpkdbr3HCeX4_0x2EHtT7skphHFwk=eP4zuQqArN4RNaaXVQ@mail.gmail.com>
In-Reply-To: <CACRpkdbr3HCeX4_0x2EHtT7skphHFwk=eP4zuQqArN4RNaaXVQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <60BF5C92B6F2404EBE4E7866FC191B6B@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsVyYMXvTboHNjrFGTRsMrB4c3w6k8WUP8uZ
        LD73HmG0aN17hN3i9O4SB1aPTas62TzuXNvD5vF+31U2j8+b5AJYorhtkhJLyoIz0/P07RK4
        Mxb8nM1UcEGxYkfLddYGxgcKXYycHBICJhI33q5lBrGFBK4ySsxvCOti5AKyTzBKnDvTxNjF
        yMHBJmAj0XWTHaRGRCBN4tXnHYwgNcwC3YwSb3efBEsIAyXWrW2FKkqX2HnvHgtIr4hAlMSC
        f+UgJouAqsSNV+UgFbwCfhIL/i9jg1g1nUXib+txsFZOgUCJru5mJhCbUUBWorPhHZjNLCAu
        senZd1aImwUkluw5zwxhi0q8fPwPKq4ksffnQ7C1zAKaEut36UO0OkgsvDGbFcJWlJjS/ZAd
        4gZBiZMzn7BMYBSbhWTDLITuWUi6ZyHpnoWkewEj6ypGidzEzJz0xJJUQ72i1FK9ovyMXCCV
        nJ+7iRESh192MP4/5HmIkYmD8RCjJAeTkihvwGqnOCG+pPyUyozE4oz4otKc1OJDjBIczEoi
        vJbSjnFCvCmJlVWpRfkwKWkOFiVxXvWHE2OFBEB2ZaemFqQWwWRlODiUJHjV1gMNFSxKTU+t
        SMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAeljvhiYPIASfEA7RXbANTOW1yQmAsUhWg9xWjO
        MeHl3EXMHDuPzgOSJ1ctAZJH5i5dxCzEkpeflyolznsBpE0ApC2jNA9u6StGcQ5GJWFeC5As
        DzBRw818BbSOCWjddRMHkHUliQgpqQZGm8Iey2efPT8ZTmPQjGw6K955duXJ+jj/u18vTA1c
        Y5AUpPLuPn82481Vn2SnG53K2Syzpn0r39ZCQd9e9k/MffFH/kwrmb3ksVu2/E2b1bc9Yxim
        F9Ssauib0XreN+xoe1VXSWR185rQL9PXPnEw7ZtqzcFywPjclrWaDsdzmP4Fm14R+rtDiaU4
        I9FQi7moOBEAPDZOnJEDAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gTGludXMsDQoNCk9uIFR1ZSwgMjAyMC0wMi0xMSBhdCAxNDoxNSArMDEwMCwgTGludXMg
V2FsbGVpaiB3cm90ZToNCj4gT24gTW9uLCBGZWIgMTAsIDIwMjAgYXQgMzowMyBQTSBWYWl0dGlu
ZW4sIE1hdHRpDQo+IDxNYXR0aS5WYWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+IHdyb3RlOg0K
PiA+IE9uIE1vbiwgMjAyMC0wMi0xMCBhdCAxNDoxMiArMDEwMCwgTGludXMgV2FsbGVpaiB3cm90
ZToNCj4gPiA+IElmIGRpZmZlcmVudCBkZXZpY2VzIGhhdmUgZGlmZmVyZW50IGJhdHRlcmllcyB0
aGVuIHRoZSBib290DQo+ID4gPiBsb2FkZXINCj4gPiA+IGNvdWxkIGlkZWFsbHkgcGF0Y2ggdGhl
IERUIHdpdGggdGhlIHJpZ2h0IGJhdHRlcnkuIFRoaXMgd2FzIHRoZQ0KPiA+ID4gc29sdXRpb24N
Cj4gPiA+IGFkdm9jYXRlZCBmb3IgZGV2aWNlcyB3aXRoIGRpZmZlcmVudCBkaXNwbGF5IHBhbmVs
cywgdG8gYQ0KPiA+ID4gcXVlc3Rpb24NCj4gPiA+IGZyb20gSGFucyBkZSBHb2VkZSBhdCBvbmUg
cG9pbnQgSUlSQy4NCj4gPiANCj4gPiBIbW0uIFRoaXMgc291bmRzIHNpbXBsZXIgdGhhbiBhZGRp
bmcgYnVuY2ggb2YgY2hhcmdlciBkcml2ZXJzIGluDQo+ID4gYm9vdA0KPiA+IGxvYWRlci4gT1RP
SCwgaWYgYm9vdCBsb2FkZXIgY2FuIGRldGVjdCB0aGUgdHlwZSBvZiB0aGUgYmF0dGVyeSwNCj4g
PiB0aGVuIEkNCj4gPiBzZWUgd2h5IGxpbnV4IGNvdWxkbid0PyBBbmQgaWYgdHlwZSBvZiBiYXR0
ZXJ5IGNhbiBiZSBoYXJkLWNvZGVkIGluDQo+ID4gYm9vdCwgdGhlbiBJIGRvbid0IHNlZSB3aHkg
aXQgY291bGRuJ3QgYmUgaGFyZC1jb2RlZCBpbiBEVC4gQnV0DQo+ID4gdGhpcw0KPiA+IGFsbCBn
b2VzIGZhciBiZXlvbmQgbXkgYXJlYSBvZiBleHBlcnRpY2UgOykNCj4gDQo+IEl0J3MgYSBncmF5
IGFyZWEuDQo+IA0KPiBUaGUgYm9vdCBsb2FkZXIsIGFzIHdlbGwgYXMgdGhlIGtlcm5lbCwgY2Fu
IGRldGVjdCB0aGUgcHJlc2VuY2Ugb2YNCj4gc29tZSBzcGVjaWZpYyBiYXR0ZXJ5IGFuZCBzY3Jl
ZW4gdXNpbmcgZS5nLiBwcm9iaW5nIHdpdGggaTJjDQo+IGFkZHJlc3NlcyBvciBieSByZWFkaW5n
IEdQSU8gbGluZXMgb3Igc29tZSBvdGhlciBtYWdpYyBudW1iZXINCj4gc3VjaCBhcyB0aGUgc2Vy
aWFsIG51bWJlciBvZiB0aGUgZGV2aWNlLg0KPiANCj4gVGhlIGtlcm5lbCBkb2VzIGhhdmUgc2lt
aWxhciBjb2RlIGluIHNvbWUgcGxhY2VzLiBBbHNvIHRoZQ0KPiBmdW5jdGlvbiB3aGVyZSB3ZSBl
bnRlciBpcyBtb2R1bGUgaXMgZGVjZXB0aXZlbHkgbmFtZWQgInByb2JlKCkiLg0KPiANCj4gU28g
YXQgc29tZSBwb2ludCBpdCB3YXMgY29tbW9uIHByYWN0aWNlIGZvciB0aGUga2VybmVsIHRvIGRv
IHRoaXMuDQoNCkhtLiBJIHRoaW5rIEkndmUgc2VlbiBzb21lIGkyYyBkcml2ZXJzIGRvaW5nIGNv
b2wgcHJvYmluZyB0byBkZXRlY3QgaWYNCmNvbm5lY3RlZCBkZWN2aWNlIGlzIHdoYXQgaXQgaXMg
ZXhwZWN0ZWQgdG8gYmUgOikgU28gdGhpcyBkaWRuJ3QgcmVhbGx5DQpjb21lIGFzIHN1cnByaXpl
IHRvIG1lIDopDQoNCj4gQWZ0ZXIgdGhlIGludHJvZHVjdGlvbiBvZiBkZXZpY2UgdHJlZSwgdGhl
cmUgaGFzIGJlZW4gc29tZSBwdXNoYmFjaw0KPiBmcm9tIGJvb3QgYXJjaGl0ZWN0dXJlIHBlb3Bs
ZSAodGhpcyBpcyB0aGUgbmFtZSBmb3IgcGVvcGxlIGRvaW5nDQo+IHRoaW5raW5nIGFyb3VuZCBE
VCwgQUNQSSwgVUVGSSBhbmQgVS1Cb290KSB0aGF0IHRoaXMga2luZCBvZiBmdW5ueQ0KPiBwcm9i
aW5nIGNvZGUgc2hvdWxkIGJlIGRvbmUgaW4gdGhlIGJvb3QgbG9hZGVyLCB0aGVuIHRoZSBib290
IGxvYWRlcg0KPiBuZWVkIHRvIGZpZ3VyZSBvdXQgaG93IHRoZSBkZXZpY2UgdHJlZSBzaG91bGQg
YWN0dWFsbHkgbG9vaywNCj4gY29uc3RydWN0DQo+IGl0IGFuZCBwYXNzIHRoZSByZXN1bHQgdG8g
dGhlIGtlcm5lbC4gVGhpcyB3b3JrcyBmb3IgYW55dGhpbmcgdGhhdA0KPiBkZXRlY3RhYmxlIGFu
ZCBub3QgaG90LXBsdWdnZWQuDQoNCkFoLiBJIGRpZG4ndCBrbm93IGFib3V0IHRoaXMgcHVzaC4g
QmVzaWRlcywgdGhpcyBtYXkgZmFsbCBhcGFydCB3aGVuDQpob3QtcGx1ZyBjb21lcyB0byBwbGF5
IDovDQoNCkFsdGhvdWdoLCBJIG9uY2Ugd29ya2VkIHdpdGggYSBkZXZpY2UgdGhhdCBoYWQgcGx1
Z2dhYmxlIGNhcmRzIC0gZWFjaA0Kb2YgdGhlIGRpZmZlcmVudCB0eXBlIG9mIGNhcmRzIGhhZCBh
IGR0LWJpbmFyeSBibG9iIG9uIG9uLWJvYXJkIGVlcHJvbQ0KZGVzY3JpYmluZyB0aGUgY29udGVu
dHMgb2YgdGhpcyBjYXJkIC0gYW5kIHdoZW4gdGhlIGNhcmQgd2FzIHBsdWdnZWQgaW4NCnRoZSBw
cm9jZXNzb3Igd2FzIHJlYWRpbmcgdGhlIEVFUFJPTSBhbmQgZGlkIG92ZXJsYXkgbWVyZ2luZyBv
ZiB0aGUNCmZvdW5kIGR0LWJsb2IuIFRoYXQgbWFkZSBkZXZpY2VzIG9uIHBsdWdnZWQgY2FyZCBk
ZXRlY3RlZCBhbmQgdXNhYmxlLg0KSWYgY2FyZCB3YXMgcmVtb3ZlZCB0aGUgZHQtb3ZlcmxheSB3
YXMgcmVtb3ZlZC4uLiBPaCwgdGhhdCB3YXMgYSBmYW5jeQ0KcHJvamVjdCBhbGwgaW4gYWxsIDop
DQoNCj4gQXMgd2UgYXJlIGluIHBhcmFsbGVsLCBlc3BlY2lhbGx5IG9uIHRoZSBBUk0gYXJjaGl0
ZWN0dXJlcywgcHVzaGluZw0KPiBhICJzaW5nbGUga2VybmVsIGltYWdlIiBjb25jZXB0IHRoaXMg
bWFrZXMgYSBsb3Qgb2Ygc2Vuc2UsIHNvIHdlDQo+IGtlZXAgZG93biB0aGUgbnVtYmVyIG9mIGZ1
bm55IHByb2JpbmcgY29kZSBpbiB0aGF0IHNpbmdsZSBrZXJuZWwNCj4gaW1hZ2UuDQo+IA0KPiBN
YXliZSB3ZSBzaG91bGQgYWN0dWFsbHkgd3JpdGUgdGhpcyB1cCBzb21ld2hlcmUuIChPciBpdCBp
cyBhbHJlYWR5PykNCj4gSSBvbmx5IHBpY2tlZCB0aGUgYWJvdmUgdXAgZnJvbSBtaXNjIGNvbnZl
cnNhdGlvbnMuDQoNCldlbGwsIHRoYXQgd291bGQgYmUgaGVscGZ1bCAtIGFzc3VtaW5nIHRoZSBy
ZWFkZXIgaXMgYWJsZSB0byBsb29rIHVwDQp0aGUgZG9jdW1lbnRhdGlvbiAtIEkga25vdyB0aGF0
IHNvbWUgcGVvcGxlIGZhaWwgb24gdGhpcyBvY2Nhc2lvbmFsbHkNCiphaGVtKg0KDQpBbnl3YXlz
LCB0aGFua3MgZm9yIHRoZSBleHBsYW5hdGlvbiENCg0KQmVzdCBSZWdhcmRzDQoJTWF0dGkgVmFp
dHRpbmVuDQo=
