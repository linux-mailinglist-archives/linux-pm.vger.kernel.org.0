Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40E99153F6A
	for <lists+linux-pm@lfdr.de>; Thu,  6 Feb 2020 08:54:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbgBFHyh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Feb 2020 02:54:37 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:48088 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbgBFHyh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Feb 2020 02:54:37 -0500
X-AuditID: c0a8fbf4-279ff70000001e6c-d2-5e3bc63bd422
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id ED.98.07788.B36CB3E5; Thu,  6 Feb 2020 08:54:35 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Thu, 6 Feb 2020 08:54:25 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>
CC:     "sre@kernel.org" <sre@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Thread-Topic: [RFC PATCH v2 09/10] power: supply: Initial support for ROHM
 BD70528 PMIC charger block
Thread-Index: AQHUtJ37F9J3F5izh0ixQskYfWqxuaXElbMAgAAxfs2CS0QlgA==
Date:   Thu, 6 Feb 2020 07:54:24 +0000
Message-ID: <bf72c35353dc2442794ab5cf19c7074abaccea9d.camel@fi.rohmeurope.com>
References: <20190125110600.GA29332@localhost.localdomain>
         <CACRpkdYTCgXo8FeitEfRujeWdshnsR3Kn57cKUZsA3CsZ5Cnrw@mail.gmail.com>
         <20190128135354.GA4156@localhost.localdomain>
         <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
In-Reply-To: <CACRpkdZDOJJ6qSS8fkqQsgmchDWATfhTP=TZATwt6-Z_WQXpJQ@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <53F2AE8303AFFD4B88660F5285B2BCAE@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOKsWRmVeSWpSXmKPExsVyYMXvTbrWx6zjDKa+FbWY8mc5k8Xn3iOM
        Fq17j7BbnN5d4sDisWlVJ5vHnWt72Dw+b5ILYI7itklKLCkLzkzP07dL4M74NW8Xc8EZx4rj
        C9qYGhi/2HcxcnJICJhIdN1sYe5i5OIQErjKKHF3yQMo5zijxLbnT9i7GDk42ARsgKrYQRpE
        BCwlDp+YwwJSwyzQySjxdOkFsISwQJrEurWtUEXpEjvv3WOBsJ0kJm/bzwZiswioSGz5M5EJ
        xOYV8JO4eXsRE8Sy34wSZy/tBWvgFAiUeD5vJlgDo4CsRGfDO7AGZgFxiU3PvrNCnC0gsWTP
        eWYIW1Ti5eN/UHElib0/H7KAHM0soCmxfpc+RKuDxORTm1khbEWJKd0P2SFuEJQ4OfMJywRG
        sVlINsxC6J6FpHsWku5ZSLoXMLKuYpTITczMSU8sSTXUK0ot1SvKz8gFUsn5uZsYIZH3ZQfj
        /0OehxiZOBgPMUpyMCmJ8nLUWscJ8SXlp1RmJBZnxBeV5qQWH2KU4GBWEuE9r28ZJ8SbklhZ
        lVqUD5OS5mBREudVfzgxVkgAZFd2ampBahFMVoaDQ0mCN+0o0FDBotT01Iq0zJwShDQTByfI
        cC4pkeLUvJTUosTSkox4UAKJLwamEJAUD9DeApB23uKCxFygKETrKUZzjgkv5y5i5th5dB6Q
        PLlqCZA8MnfpImYhlrz8vFQpcd78I0BtAiBtGaV5cEtfMYpzMCoJ87aDDOUBpma4ma+A1jEB
        rZP2tgBZV5KIkJJqYAx5u0u4LPbrnRXTBI294u7Mv1Zg8D7P+F71IUGe4jyV8+mVulyay5tv
        zlVRjJBYeFEv8Uz19U9nI9UaT7yZ1Gcr43Yu1zbrfVe1Okub2v8XvGuXqKacW2YseuLjJKFN
        s/qmPP3hpLH36eKQy9ujeY2PBCdnf20z+O4qMovvqhHPFU2JKQ8EWJRYijMSDbWYi4oTAaHK
        IiCKAwAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGkgZGVlIEhvIFBlZXBzIQ0KDQpJIHN0YXJ0ZWQgd29ya2luZyBmb3IgYSBkcml2ZXIgZm9yIFJP
SE0gQkQ5OTk1NCBjaGFyZ2VyIGNoaXAgYW5kIGVuZGVkDQp1cCB3cml0aW5nIHRoZSBsaW5lYXIg
cmFuZ2UgY29kZSBvbmNlIGFnYWluLiBBbmQgdGhhdCByZW1pbmRlZCBtZSBvZg0KdGhpcyB5ZWFy
IG9sZCBkaXNjdXNzaW9uIDopDQoNCk9uIE1vbiwgMjAxOS0wMS0yOCBhdCAxNTo0NiArMDEwMCwg
TGludXMgV2FsbGVpaiB3cm90ZToNCj4gT24gTW9uLCBKYW4gMjgsIDIwMTkgYXQgMjo1NCBQTSBN
YXR0aSBWYWl0dGluZW4NCj4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4gd3Jv
dGU6DQo+IA0KPiA+ID4gVGhlc2UgY2hhcmdpbmcgZHJpdmVycyBhcmUgZ3Jvd2luZyB3aWxkLiBU
aGlzIGlzIHN0YXJ0aW5nIHRvIGdldA0KPiA+ID4gb3V0DQo+ID4gPiBvZiBoYW5kLCB3ZSBuZWVk
IHNvbWUgbW9yZSBmcmFtZXdvcmsgZm9yIHByb3Blcmx5IGhhbmRsaW5nDQo+ID4gPiBjaGFyZ2lu
Zw0KPiA+ID4gc3RhdGUgbWFjaGluZXMgdGhlIGtlcm5lbC4gTm90IHNwZWNpZmljYWxseSB5b3Vy
IHByb2JsZW0sIGJ1dA0KPiA+ID4gd2hlbiB3b3JraW5nIG9uIHRoZSBkcml2ZXIgdHJ5IHRvIGtl
ZXAgZ2VuZXJpYyBzdXBwb3J0IGluIG1pbmQuDQo+ID4gDQo+ID4gSSBmb3Igc3VyZSBjYW4gdHJ5
IC0gYnV0IGFzIHRoZSBwb3dlciBzdWJzeXN0ZW0gaXMgcXVpdGUgbmV3IHRvIG1lDQo+ID4gLSBh
bnkNCj4gPiBzcGVjaWZpYyBpdGVtcyB5b3Ugd291bGQgbGlrZSBtZSB0byByZWFsbHkgcGF5IGF0
dGVudGlvbj8NCj4gDQo+IFNvIEkgYW0gbm90IHNheWluZyB5b3UgaGF2ZSB0byBkbyB0aGlzIG9y
IGFueXRoaW5nLCBidXQgSSB0aGluaw0KPiB3aGF0IHdlIG5lZWQgaXMgYSBnZW5lcmljIHN0YXRl
IG1hY2hpbmUgYW5kIHBvbGljeSBlbmdpbmUNCj4gZm9yIGNoYXJnaW5nLCB3aGVyZSBkaWZmZXJl
bnQgY2hhcmdpbmcgZHJpdmVycyBqdXN0IHBsdWcgaW4uDQoNClRoZSBCRDk5OTU0IGNoYXJnZXIg
YXMgd2VsbCBhcyB0aGUgQkQ3MDUyOCBjaGFyZ2VyIChhbmQgQkQ3MTgyOCBjaGFyZ2VyDQotIHdo
aWNoIEkgaGF2ZSBub3QgeWV0IHN1bWl0dGVkIGluLXRyZWUgYXMgaXQgaGFzIGEgdHVuZWQtdG8t
d29yay13aXRoLQ0Kb25seS1vbmUtYmF0dGVyeSBmdWVsLWdhdWdlIGFsZ29yaXRobSkgZG8gbm90
IG5lZWQgbXVjaCBvZiBTVyBjb250cm9sDQpmb3IgdGhlIHN0YXRlIG1hY2hpbmUuIEJhc2ljYWxs
eSB0aGUgU1cgbW9zdGx5IG5lZWRzIHRvIHNldCB0aGUNCnZvbHRhZ2UvY3VycmVudCB0aHJlc2hv
bGRzIHdoaWNoIG1hdGNoIHRoZSBzeXN0ZW0gSFcgZGVzaWduIGFuZCB0aGUNCmJhdHRlcnkuIE15
IGN1cnJlbnQgaWRlYSBpcyB0byBicmluZyB0aGVzZSBmcm9tIERUIC0gaWYgdGhpcyBpcyBhIHdh
eQ0KdG8gZ28sIHRoZW4gSSBjYW4gdHJ5IHNlZWluZyBob3cgbXVjaCBjb21tb24gRFQtcGFyc2lu
Zy9iaW5kaW5nIG5hbWluZw0KSSBjYW4gdXNlIGZvciB0aGVzZSBST0hNIGNoYXJnZXJzLi4uDQoN
Cj4gVGhleSBhbGwgc2VlbSB0byBoYXZlIHRyaWNrbGUgYW5kIGZhc3QgY2hhcmdpbmcsIFVTQiBw
aHkNCj4gaW50ZXJhY3Rpb24gYW5kIEFDIHBsdWcgaW50ZXJhY3Rpb24gb2Ygc29tZSBraW5kIGZv
ciBkZXRlY3RpbmcNCj4gdGhvc2UgYW5kIGluIHNvbWUgY2FzZXMgdGVtcGVyYXR1cmUgZGV0ZWN0
aW9uIGRpcmVjdGx5DQo+IG9yIHVzaW5nIGFuIEFEQy4NCg0KWWVzLiBUaGF0J3MgcHJldHR5IG11
Y2ggd2hhdCB0aGVzZSBST0hNIGNoaXBzIGhhdmUuIEJ1dCBTVyBtb3N0bHkgbmVlZHMNCnRvIHNl
dCB0aGUgbGltaXQgdmFsdWVzIC0gaXQgZG9lcyBub3QgbmVlZCB0byBwYXJ0aWNpcGF0ZSBpbiBz
dGF0ZQ0KY2hhbmdpbmcgYW5kIG1vc3Qgb2YgdGhlc2UgdGhpbmdzIGFyZSBhbHNvIHNvbWV0aGlu
ZyB1c2VycyBkbyBub3QgY2FyZQ0KKEkgZ3Vlc3MpLiBGdWVsIGdhdWdpbmcgaXMgb3RoZXIgdG9w
aWMgYnV0IEknbSBub3QgcGxhbm5pbmcgdG8NCmltcGxlbWVudCBpdCBmb3IgaW4tdHJlZSBkcml2
ZXJzIGF0IGxlYXN0IGZvciBub3cgOi8gDQoNClRoZSB0aGluZyB0aGF0IGNvbWVzIHRvIChteSkg
bWluZCBpcyBqdXN0IGEgY29tbW9uIERUIHByb3BlcnRpZXMgZm9yDQppbnB1dCBjdXJyZW50L3Zv
bHRhZ2UgbGltaXRzLCBiYXR0ZXJ5IHZvbHRhZ2VzIGZvciBzd2l0Y2hpbmcgdG8gbmV4dA0KY2hh
cmdpbmcgc3RhdGUsIGN1cnJlbnQgdmFsdWVzIGZvciBkaWZmZXJlbnQgY2hhcmdpbmcgc3RhdGVz
IC0gYW5kDQpwYXJzaW5nIG9mIHRoZXNlIHByb3BlcnRpZXMuDQoNCkkndmUgc2VlbiBzb21lIGNv
bW1lbnRzIGFib3V0IERUIG5vdCBiZWluZyBhIGdvb2QgcGxhY2UgZm9yIGJhdHRlcnkNCnNwZWNp
ZmljIHByb3BlcnRpZXMgYXMgYmF0dGVyaWVzIG1heSBiZSByZXBsYWNlZCB3aXRoIGFub3RoZXIg
aGF2aW5nDQpkaWZmZXJlbnQgdHlwZSAtIGJ1dCBJIGRvbid0IHRoaW5rIHRoaXMgaXMgdmFsaWQg
cHJvYmxlbSBmb3IgbWFueSBvZg0KdGhlIGRldmljZXMgdG9kYXkuIE9mIGNvdXJzZSBzb21lIGRl
dmljZXMgbWF5IGhhdmUgYmF0dGVyaWVzIHRoYXQgY2FuDQpiZSBjaGFuZ2VkIC0gYnV0IG1hbnkg
ZG9uJ3QgLSBhbmQgZm9yIHRob3NlIGl0IGlzIHBlcmZlY3RseSBPayB0byBoYXZlDQpiYXR0ZXJ5
IGRhdGEgZGVmaW5lZCBpbiBEVCwgcmlnaHQ/DQoNCkZpcnN0IHRob3VnaHQgaXMgdGhhdCBzZXR0
aW5nIHRoZXNlIHZhbHVlcyBuZWVkcyB0byBiZSBkb25lIGJ5IGRyaXZlcg0KKGFzIGl0J3MgY2hp
cCBzcGVjaWZpYykgLSBhbmQgdGhhdCB0aGUgcG93ZXItc3VwcGx5IGZyYW1ld29yayBkb2VzIG5v
dA0KbmVlZCB0byBrbm93IGFueXRoaW5nIGFib3V0IHRoaXMgLSBpdCBjb3VsZCBqdXN0IHByb3Zp
ZGUgb2YtaGVscGVyIGZvcg0KcGFyc2luZyB0aGUgRFQuIFRoYXQgd291bGQgYmUgc2ltcGxlIGFu
ZCBubyBjYWxsYmFja3Mgd291bGQgYmUgbmVlZGVkLg0KDQpCdXQgLi4uIGRvIHdlIG5lZWQgdG8g
cHJvdmlkZSBhIHdheSBmb3IgdXNlci1zcGFjZSB0byBjb25maWd1cmUgdGhlc2UNCnNldHRpbmdz
IGluc3RlYWQgb2YgdGhlIERUPyBPciBhbnkgb3RoZXIgcG9zc2libGUgc291cmNlcyBmb3IgdGhp
cw0KaW5mb3JtYXRpb24/DQoNCklmIHRoaXMgaXMgbmVlZGVkIC0gdGhlbiB3ZSBwcm9iYWJseSB3
b3VsZCB3YW50IHRvIGhhdmUgdGhlIGNhbGxiYWNrcy4NCkluZGl2aWR1YWwgZHJpdmVyIHdvdWxk
IG5vdCBuZWVkIHRvIGNhcmUgd2hlcmUgdGhlIGNvbmZpZ3VyYXRpb24gY29tZXMNCmZyb20gLSBp
dCB3b3VsZCBqdXN0IHByb3ZpZGUgY2FsbGJhY2sgYW5kIGxlYXZlIGl0IHRvIHBvd2VyLXN1cHBs
eQ0KZnJhbWV3b3JrIHRvIGNoZWNrIGlmIHRoZSBsaW1pdHMgYXJlIGluIERUIG9yIGNvbWUgZnJv
bSB1c2VyLXNwYWNlIG9yDQpzb21lIG90aGVyIHNvdXJjZS4NCg0KVGhpcyBpcyBqdXN0IHNvbWUg
aW5pdGlhbCB0aGlua2luZyAtIGN1cnJlbnRseSBJIGhhdmUgc2V0IG9mIGdvb2Qgb2xkDQpyb2ht
LGJsYWhibGFoLW1pY3Jvdm9sdHMgYW5kIHJvaG0sYmxhaGJsYWgtbWljcm9hbXAgY2hhcmdlciBz
cGVjaWZpYw0KcHJvcGVydGllcyBhbmQgcGFyc2luZyBjb2RlIGlzIGdldHRpbmcgaW4tZHJpdmVy
Li4uIEJ1dCBJIHdvdWxkIGxpa2UgdG8NCmhlYXIgYWJvdXQgYW55IHRob3VnaHRzIHRoaXMgbWF5
IGludm9rZS4NCg0KPiBXZSBoYXZlIGEgYnVuY2ggb2YgZHJpdmVycyB3aXRoIHNvZnR3YXJlLWNv
bnRyb2xsZWQgY2hhcmdpbmc6DQo+IGFiODUwMCoNCj4gYXhwMjg4Kg0KPiBldGMuDQo+IA0KPiBJ
ZiB3ZSBjb3VsZCBnZXQganVzdCB0d28gZHJpdmVycyB0byBzaGFyZSBzb21lIGNoYW5naW5nDQo+
IGluZnJhc3RydWN0dXJlIHdlIHdvdWxkIGhhdmUgYSBzdGFydC4NCg0KSG1tLiBJZiBjaGFuZ2lu
ZyBtZWFucyBzdGF0ZSBjaGFuZ2VzIC0gdGhlbiB0aGVzZSBST0hNIGNoaXBzIHByb2JhYmx5DQpw
bGF5IG5vIHJvbGUgaGVyZSBhcyB0aGVyZSB0aGUgSFcgZG9lcyBtb3N0IG9mIHRoZSBzdGF0ZSBj
aGFuZ2VzDQphdXRvbm9tb3VzbHkuIChBRkFJUiwgaXQncyBiZWVuIGEgd2hpbGUgc2luY2UgSSBs
b29rZWQgdGhlIG90aGVyIGJ1dA0KQkQ5OTk1NCkuDQoNCj4gPiA+IElmIEknbSBub3QgbWlzdGFr
ZW4gdGhpcyBpcyB5ZXQgYW5vdGhlciBpbnN0YW5jZSBvZiBsaW5lYXINCj4gPiA+IGludGVycG9s
YXRpb24NCj4gPiA+IGZyb20gYSB0YWJsZT8NCj4gPiANCj4gPiAibGluZWFyIGludGVycG9sYXRp
b24gZnJvbSBhIHRhYmxlIiBpcyByZWFsbHkgbm90IHBhcnQgb2YgbXkNCj4gPiB2b2NhYnVsYXJ5
IDpdIEJ1dCBJIGd1ZXNzIHlvdSBrbm93IHRoZSBSRUdVTEFUT1JfTElORUFSX1ZPTFRBR0UgLQ0K
PiA+IG1hY3JvPw0KPiA+IEkgYm9ycm93ZWQgdGhlIGlkZWEgZnJvbSB0aGVyZS4uLg0KPiANCj4g
SSdtIHJlZmVycmluZyB0byB0aGlzIGVzc2VudGlhbGx5Og0KPiBodHRwczovL2VuLndpa2lwZWRp
YS5vcmcvd2lraS9MaW5lYXJfaW50ZXJwb2xhdGlvbg0KPiANCj4gV2hhdCBtYW55IGNoYXJnaW5n
IGRyaXZlcnMgdGVuZHMgdG8gZG8gaXM6DQo+IC0gTG9vayB1cCB3aGVyZSBJIGFtIGluIGEgdGFi
bGUsIHNheSBiZXR3ZWVuIHJvdyA0IGFuZCA1DQo+IC0gRm9yIHgtYXhpcyBuLi5uKzEsIGludGVy
cG9sYXRlIHktYXhpcyBiZXR3ZWVuDQo+ICAgdGhlIHZhbHVlcyBmb3VuZCBmb3IgeD0xIGFuZCB4
PW4rMSB1c2luZw0KPiAgIGNvbW1vbiBsaW5lYXIgaW50ZXJwb2xhdGlvbi4NCj4gDQo+ID4gPiBX
ZSByZWFsbHkgbmVlZCB0byB0aGluayBhYm91dCBhYnN0cmFjdGluZyB0aGlzLiBMYXN0IHRpbWUg
dGhpcw0KPiA+ID4gZHVwbGljYXRpb24gYXBwZWFyZWQgSSBzdWdnZXN0ZWQgYWRkaW5nIGxpbmVh
ciBpbnRlcnBvbGF0aW9uDQo+ID4gPiBwcmltaXRpdmVzIHRvOg0KPiA+ID4gaW5jbHVkZS9saW51
eC9maXhwLWFyaXRoLmgNCj4gPiANCj4gPiAuLi4gSSByZWFsbHkgdGhpbmsgYSBnZW5lcmljIGhl
bHBlciBmb3IgdGhpcyB3b3VsZCBiZSB1c2VmdWxsLg0KPiANCj4gSW5kZWVkLg0KDQpBbmQgSSBh
bSBhZ2FpbiBkb2luZyB0aGUgdmFsdWUgbG9va3VwIGNvZGUgaGVyZS4gSSBhZ2FpbiBoYXZlDQp2
b2x0YWdlL2N1cnJlbnQgcmVnaXN0ZXJzIHdoZXJlIHdyaXRpbmcgdmFsdWUgbiAod2hlcmUgbiBp
cyBpbiBhIHJhbmdlDQowLC4uLixOKSB3aWxsIGNhdXNlIHZvbHRhZ2UgVnRvIGJlIHNldCBWID0g
VjAgKyBuKihWc3RlcCkuIChPa2F5LCBuIGNhbg0Kc3RhcnQgZnJvbSBzb21ldGhpbmcgZWxzZSB0
aGFuIDAgdG9vIC0gYnV0IEkganVzdCB3YW50ZWQgdG8gZXhwbGFpbiB0aGUNCmlkZWEpLiBTbyBJ
IGFtIGFnYWluIHdyaXRpbmcgYSBsb29rLXVwIGNvZGUgdG8gbWF0Y2ggInNlbGVjdG9yIiBuIHRv
IGENCnZhbHVlIFYgb3IgYSB2YWx1ZSBWIHRvIGEgc2VsZWN0b3Igbi4gVGhpcyBpcyByZXF1aXJl
ZCBmb3IgZXhhbXBsZSB3aGVuDQpJIGNvbnZlcnQgdm9sdGFnZS9jdXJyZW50IERUIHZhbHVlcyB0
byByZWdpc3RlciB2YWx1ZXMuDQoNClNvIC4uLiBJZiBJIGV4dHJhY3QgdGhlIGxpbmVhcl9yYW5n
ZSBjb2RlIGZyb20gQkQ3MDUyOCBkcml2ZXIgKGl0DQpzaG91bGQgYmUgdXNhYmxlIGZvciB0aGUg
QkQ5OTk1NCBhcyBzdWNoKSAtIHNob3VsZCBJIHBsYWNlIGl0IHRvIHNvbWUNCmNvbW1vbiBoZWFk
ZXIvbGliPyAoVGhpcyBpcyBwbGFpbiBpbnRlZ2VyIG1hdGhzIHNvIEkgZG9uJ3QgbGlrZSB0aGUN
CmlkZWEgb2YgcGxhY2luZyBpdCBpbiBmaXhwLWFyaXRoLmgpLiBJIHdvdWxkIGFzc3VtZSB0aGVy
ZSBpcyBxdWl0ZSBhDQpmZXcgY2hpcHMgd2l0aCByZWdpc3RlcnMgd2hlcmUgaW5jcmVtZW50IG9m
IDEgaW4gcmVnaXN0ZXIgbWVhbnMgZml4ZWQNCmluY3JlbWVudCBpbiBzb21lIHBoeXNpY2FsIHZh
bHVlIChjdXJyZW50LCB2b2x0YWdlLCBzb21ldGhpbmcgZWxzZSwuLi4pDQpzbyBoYXZpbmcgdGhp
cyBjb2RlIGluIHNvbWUgcm9obS1oZWxwZXJzLmMgYW5kIGludGVybmFsIGhlYWRlciBpcw0Kc3Vi
b3B0aW1hbCAoYnV0IEkgY2FuIGRvIHRoYXQgdG9vKS4NCg0KQW55IGd1aWRhbmNlIG9yIHN1Z2dl
c3Rpb25zPw0KDQpCciwNCglNYXR0aSBWYWl0dGluZW4NCg0K
