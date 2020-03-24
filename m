Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D785190BFE
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 12:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCXLIS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 07:08:18 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:62720 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbgCXLIS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 07:08:18 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 07:08:17 EDT
X-AuditID: c0a8fbf4-489ff70000004419-0d-5e79e69b5007
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id F6.DD.17433.B96E97E5; Tue, 24 Mar 2020 11:53:15 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Tue, 24 Mar 2020 11:53:09 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Gary.Hook@amd.com" <Gary.Hook@amd.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "changbin.du@intel.com" <changbin.du@intel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "bp@suse.de" <bp@suse.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        "uwe@kleine-koenig.org" <uwe@kleine-koenig.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Thread-Topic: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAARjYA=
Date:   Tue, 24 Mar 2020 10:53:09 +0000
Message-ID: <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
In-Reply-To: <20200324095024.GE1922688@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B22C55CE6217F46BCF049734AECBDDD@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxjH895d7w7ktrNU+9q5JdTgFFQ0bMubxTm2ZNmpiXHxjy3LhB1y
        UDba4rXVYszGfrgoRC1OLNbCGFhB7SxtCW7abow0A0Vh/BjgomOM1gwSixtklel0d54Kf73f
        9/0+3+fz/PG8NK4OUjq62GQVRBNfoieTifbmu4HVJ26W5a6tH9Ygt89LooOfOjE0OzMFUNXh
        lahv5EscVY9FSeTv68SQs/pngNy9nxOoy99CoK8iPSp0Z/AIgT5r9JGocnIp6u1todA/g/sx
        dPReE4YGLrhJNH0wApBnuA9Dbk8XgRqblqOWYAJDt647CbQvHKFQ2HlKhbovWtGx2jCFgoFq
        HA3//SuGwvdnCRT+bRqgn/6aBTlp3L7+/0jOW+cFXOvpaxj3nesGxbW1p3P1ARsXbM7gGkMT
        GBc4c4DkjpxqUHHXh0IkF+/pobiumrsE52hoB1zdpbe4H2q91FbNuwvW5/PWXduKi0xZG95f
        YKiOJZVeXm1/MG0sB62rKkASDdkXYHz0T1UFSKbV7C8Afj+UeHTpAtB32k9WAJom2fWw4hol
        BzTsZvhvfATINTgbYuD+WxFMNlLZjbB5tF+lFG2CTV+ESUW/DOOdDiBrgk2H3pmrhKwZdguM
        fnOCUmCDAIb6ruCykSQF+gduP2wE2GfhgfL4QwDOamHgZkKljM3Ck6FeXNGL4MT4/UfvafB8
        4hwhD42zK6HvQpYic+D5yk1KlzR4tHKMUkZYCC8djxIOsNg1D+CaC7vmwq55Yde8cD1QnQHQ
        yBeXFPFWYd0aUbCtEc0Go3TsMBsDQFnCmW/Bg46NHQCjQQdYQmP6RYx2vCxX/VS+uaDMwFsM
        eaKtRLB0AEjjeg0TFOy5aqaAL9sjiObH1jM0odcyz49VbVezMutDQSgVxMfuUprWQ4aUVl29
        UBSKBHthcYl1zsboJLl5sk5jEUwFgsjbrIY8eTnyLNJ2yFaKxHXFpDhjKeWN0qsSvQwyacdE
        bQNOR2o9DbiaMJlNgk7LMDKJlUsNNtMT0CTQ0kCfyuyNSm6K9BOf9JmUEJiEKHLtlhFWfs7S
        lYNtnmOrpk5672T6yO623fmWnNfW1rQOTLwxGnv9cOory3UvDZ3r/jobOg9l+z/KdC32ba/K
        WhIbyn7uHdHhtI/v3LtiZ3NVxq6Yv23q9oYrNYXuj5Pfs7/pefuTG5WvjpjPPn3IUde5dXDP
        jy/uSP+j8Gx+4uqK48tal2ku3kv5fXO7tzP6gZ6wGPh1Gbho4f8HQZAdvUYEAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpIZWxsbyBBbmR5LA0KDQpJIGRvIGFncmVlIHdpdGggbW9zdCBvZiB0aGUgdGhpbmdzIHlvdSBw
b2ludGVkIG91dC4gSSBkaWRuJ3QgY29tbWVudA0KdGhlbS4NCg0KT24gVHVlLCAyMDIwLTAzLTI0
IGF0IDExOjUwICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+IE9uIFR1ZSwgTWFyIDI0
LCAyMDIwIGF0IDEwOjMyOjE5QU0gKzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBU
aGUgUk9ITSBCRDk5OTU0IGlzIGEgQmF0dGVyeSBNYW5hZ2VtZW50IExTSSBmb3IgMS00IGNlbGwg
TGl0aGl1bS0NCj4gPiBJb24NCj4gPiBzZWNvbmRhcnkgYmF0dGVyeSBpbnRlbmRlZCB0byBiZSB1
c2VkIGluIHNwYWNlLWNvbnN0cmFpbnQgZXF1aXBtZW50DQo+ID4gc3VjaA0KPiA+IGFzIExvdyBw
cm9maWxlIE5vdGVib29rIFBDLCBUYWJsZXRzIGFuZCBvdGhlciBhcHBsaWNhdGlvbnMuIEJEOTk5
NTQNCj4gPiBwcm92aWRlcyBhIER1YWwtc291cmNlIEJhdHRlcnkgQ2hhcmdlciwgdHdvIHBvcnQg
QkMxLjIgZGV0ZWN0aW9uDQo+ID4gYW5kIGENCj4gPiBCYXR0ZXJ5IE1vbml0b3IuDQo+IC4uLg0K
PiANCj4gPiArI2luY2x1ZGUgPGxpbnV4L2FjcGkuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29m
Lmg+DQo+IA0KPiBJIGRpZG4ndCBmaW5kIGFueSBldmlkZW5jZSBvZiB1c2Ugb2YgdGhvc2UgdHdv
LCBvdGhlcndpc2UsIG1pc3NlZA0KPiBwcm9wZXJ0eS5oDQo+IGFuZCBwZXJoYXBzIG1vZF9kZXZp
Y2V0YWJsZS5oLg0KPiANCg0KSSdsbCBjaGVjayB0aGlzLCB0aGFua3MuDQoNCj4gDQo+ID4gKwku
Y2FjaGVfdHlwZSA9IFJFR0NBQ0hFX1JCVFJFRSwNCj4gPiArDQo+ID4gKwkucmFuZ2VzID0gcmVn
bWFwX3JhbmdlX2NmZywNCj4gPiArCS5udW1fcmFuZ2VzID0gQVJSQVlfU0laRShyZWdtYXBfcmFu
Z2VfY2ZnKSwNCj4gPiArCS52YWxfZm9ybWF0X2VuZGlhbiA9IFJFR01BUF9FTkRJQU5fTElUVExF
LA0KPiA+ICsJLndyX3RhYmxlID0gJmJkOTk5NXhfd3JpdGVhYmxlX3JlZ3MsDQo+ID4gKwkudm9s
YXRpbGVfdGFibGUgPSAmYmQ5OTk1eF92b2xhdGlsZV9yZWdzLA0KPiA+ICt9Ow0KPiANCj4gLi4u
DQo+IA0KPiA+ICsjZGVmaW5lIElESTBUX0JJVCAweDENCj4gDQo+IEluIGNvbnRlbXBvcmFyeSB3
b3JsZCBzb21lYm9keSBjYW4gYmUgb2ZmZW5kZWQgKG5vdCBtZSkuDQoNClllYWguIEFuZCB3aGVu
IHNvbWVvbmUgZ2V0cyBvZmZlbmRlZCBhbmQgY29tcGxhaW5zIEkgd2lsbCBjaGFuZ2UgdGhpcw0K
OikgQW5kIG1heWJlIGV4cGxhaW4gdG8gaGltL2hlciB3aHkgSSB0aGluayB0aGlzIGlzIGFuIGlk
aW90IGJpdC4NCkJlc2lkZXMsIGl0IGRlc2NyaWJlcyB0aGUgYml0IHF1aXRlIHdlbGwuDQoNCj4g
Li4uDQo+IA0KPiA+ICsJCS8qDQo+ID4gKwkJICogdGhlIGFjdHVhbCByYW5nZSA6IDI1NjAgdG8g
MTkyMDAgbVYuIE5vIG1hdHRlciB3aGF0DQo+ID4gdGhlDQo+IA0KPiB0IC0+IFQNCj4gDQo+ID4g
KwkJICogcmVnaXN0ZXIgc2F5cw0KPiA+ICsJCSAqLw0KPiA+ICsJCXZhbC0+aW50dmFsID0gbWF4
KHZhbC0+aW50dmFsLCAyNTYwKTsNCj4gPiArCQl2YWwtPmludHZhbCA9IG1pbih2YWwtPmludHZh
bCwgMTkyMDApOw0KPiANCj4gY2xhbXBfdmFsKCkNCg0KVGhhbmtzISBJIGRpZG4ndCBrbm93IG9m
IHRoaXMuIEkgbGVhcm5lZCBzb21ldGhpbmcgYWdhaW4gOikNCg0KPiAuLi4NCj4gDQo+ID4gKwlm
b3IgKGkgPSBmZnModG1wKTsgaTsgaSA9IGZmcyh0bXApKSB7DQo+IA0KPiBOSUggb2YgZm9yX2Vh
Y2hfc2V0X2JpdCgpLg0KDQpXaGF0IGRvZXMgdGhlIE5JSCBzdGFuZCBmb3I/DQpBbnl3YXlzLCBJ
IGFncmVlLiBUaGlzIGlzIHByb2JhYmx5IGJldHRlciBpZiBJIHVzZSBmb3JfZWFjaF9zZXRfYml0
KCkNCg0KPiANCj4gPiArCWRvIHsNCj4gPiArCQlyZXQgPSByZWdtYXBfZmllbGRfcmVhZChiZC0+
cm1hcF9maWVsZHNbRl9PVFBMRF9TVEFURV0sIA0KPiA+ICZzdGF0ZSk7DQo+ID4gKwkJaWYgKHJl
dCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gKwkJbXNsZWVwKDEwKTsNCj4gPiAr
CX0gd2hpbGUgKHN0YXRlID09IDAgJiYgLS1yc3RfY2hlY2tfY291bnRlcik7DQo+IA0KPiByZWdt
YXBfcmVhZF9wb2xsX3RpbWVvdXQoKSBleGlzdHMsIGJ1dCBJIHNlZSB5b3UgdXNlIGl0IGZvciBm
aWVsZC4NCj4gUGVyaGFwcyBpdCdzDQo+IGEgdGltZSB0byBpbnRyb2R1Y2Ugc2ltaWxhciBoZWxw
ZXIgZm9yIGZpZWxkIHBvbGxpbmcuDQoNClRoaXMgc2VyaWVzIGlzIGFnYWluIGdldHRpbmcgbGVu
Z3RoeS4uLiBJJ2xsIHNlZSBpZiBJIGFkZCBzdWNoIGFuIEFQSQ0KaW4gdGhpcyBzZXJpZXMuIEkn
dmUgbGVhcm5lZCB0aGF0IGFkZGluZyBjaGFuZ2VzIHdpbGwgaW5jcmVhc2UgdGhlIHRpbWUNCml0
IHRha2VzIHRvIHB1c2ggdGhlIHNlcmllcyB0aHJvdWdoLiBJdCBtaWdodCBiZSBtb3JlIHJldmll
d2VyIGZyaWVuZGx5DQp0byBhZGQgaXQgaW4gb3duIHBhdGNoIHdpdGggbGltaXRlZCByZXZpZXcg
YXVkaWVuY2UgKGFzIHdvdWxkIGJlIHRoZQ0KcGF0Y2ggMTAvMTAgaW4gdGhpcyBzZXJpZXMpLiBC
dXQgSSB0aGluayB5b3VyIHBvaW50IGlzIHZhbGlkLg0KDQo+IC4uLg0KPiANCj4gPiArc3RhdGlj
IGNvbnN0IHN0cnVjdCBsaW5lYXJfcmFuZ2UgaW5wdXRfY3VycmVudF9saW1pdF9yYW5nZXNbXSA9
IHsNCj4gPiArCXsNCj4gPiArCQkubWluID0gMCwNCj4gPiArCQkuc3RlcCA9IDMyMDAwLA0KPiA+
ICsJCS5taW5fc2VsID0gMHgwLA0KPiANCj4gUGVyaGFwcyAweDAwMCB0byBtYXRjaCBtYXhfc2Vs
IHdpZHRoLiBTYW1lIGFwcGxpZXMgdG8gb3RoZXIgcGxhY2VzLg0KDQpJIGRvbid0IHJlYWxseSBz
ZWUgdGhlIHZhbHVlIG9mIHRoaXMgc3VnZ2VzdGlvbi4NCg0KPiA+ICsJCS5tYXhfc2VsID0gMHgx
ZmYsDQo+ID4gKwl9LA0KPiA+ICt9Ow0KPiANCj4gLi4uDQo+IA0KPiA+ICsJLyoNCj4gPiArCSAq
ICB0aGUgcG93ZXJfc3VwcGx5X2dldF9iYXR0ZXJ5X2luZm8gZG9lcyBub3Qgc3VwcG9ydCBnZXR0
aW5nDQo+ID4gdmFsdWVzDQo+IA0KPiB0IC0+IFQNCj4gQWxzbyB3aGVuIHdlIHJlZmVyIHRvIGZ1
bmN0aW9uIHVzZSAoKSBzdWZmaXguDQo+IA0KPiA+ICsJICogZnJvbSBBQ1BJLiBMZXQncyBmaXgg
aXQgaWYgcmVxdWlyZWQgOikNCj4gPiArCSAqLw0KPiANCj4gQW5kIHllcywgZ29vZCBxdWVzdGlv
biB3aHkgeW91IHNpbXBsZSBkbyBub3QgZml4IGl0IHRoZXJlPw0KPiANCg0KQmVjYXVzZSBJIGRv
bid0IG5lZWQgQUNQSSBhdCB0aGUgbW9tZW50IGFuZCBiZWNhdXNlIEkgd291bGQgbGlrZSB0bw0K
bGltaXQgdGhlIHNpemUgb2YgYWxyZWFkeSBsZW5ndGh5IHNlcmllcy4gDQoNCj4gLi4uDQo+IA0K
PiA+ICtzdGF0aWMgaW50IGJkOTk5NXhfcHJvYmUoc3RydWN0IGkyY19jbGllbnQgKmNsaWVudCwN
Cj4gPiArCQkJIGNvbnN0IHN0cnVjdCBpMmNfZGV2aWNlX2lkICppZCkNCj4gDQo+IENhbiB5b3Ug
c3dpdGNoIHRvIC0+cHJvYmVfbmV3KCkgKE5vdGUsIGl0IGRvZXNuJ3QgbWVhbiB5b3UgbmVlZCB0
bw0KPiBkcm9wIEnCskMgSUQgdGFibGUpDQoNCkkgY2FuLiBUaGFua3MuDQoNCj4gDQo+IC4uLg0K
PiANCj4gPiArCWlmICghZGV2LT5wbGF0Zm9ybV9kYXRhKSB7DQo+IA0KPiBkZXZfZ2V0X3BsYXRk
YXRhKCkNCj4gDQo+ID4gKwkJcmV0ID0gYmQ5OTk1eF9md19wcm9iZShiZCk7DQo+ID4gKwkJaWYg
KHJldCA8IDApIHsNCj4gPiArCQkJZGV2X2VycihkZXYsICJDYW5ub3QgcmVhZCBkZXZpY2UNCj4g
PiBwcm9wZXJ0aWVzLlxuIik7DQo+ID4gKwkJCXJldHVybiByZXQ7DQo+ID4gKwkJfQ0KPiA+ICsJ
fSBlbHNlIHsNCj4gPiArCQlyZXR1cm4gLUVOT0RFVjsNCj4gDQo+IFNvLCBleGlzdGluZyBwbGF0
Zm9ybSBkYXRhIGxlYWRzIHRvIGFuIGVycm9yPyENCg0KWWVzLiBBcyBjdXJyZW50bHkgd2Ugb25s
eSB1c2UgRFQuIElmIHNvbWVvbmUgbmVlZHMgcGxhdGRhdGEgdGhleSBuZWVkDQp0byBpbXByb3Zl
IHRoZSBkcml2ZXINCg0KPiA+ICsjaWZuZGVmIEJEOTk5NTRfQ0hBUkdFUl9IDQo+ID4gKyNkZWZp
bmUgQkQ5OTk1NF9DSEFSR0VSX0gNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAu
aD4NCj4gDQo+IEl0IGlzIG5vdCB0aGUgaGVhZGVyIHlvdSBoYXZlIHVzZXJzIGZvci4NCj4gUHJv
cGVyIG9uZSBzaG91bGQgYmUgYml0cy5oLg0KDQpIdWg/IHN0cnVjdCByZWdfZmllbGQgaXMgaW4g
cmVnbWFwLmgsIHJpZ2h0Pw0KDQpCciwNCglNYXR0aSBWYWl0dGluZW4NCg==
