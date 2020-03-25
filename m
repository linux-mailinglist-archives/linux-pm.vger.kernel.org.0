Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A22F192484
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 10:48:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCYJr7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 05:47:59 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:46540 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgCYJr6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 05:47:58 -0400
X-AuditID: c0a8fbf4-473ff70000004419-f9-5e7b28cc592b
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 0B.41.17433.CC82B7E5; Wed, 25 Mar 2020 10:47:56 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Wed, 25 Mar 2020 10:47:50 +0100
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
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAARjYCAAYAWgA==
Date:   Wed, 25 Mar 2020 09:47:50 +0000
Message-ID: <97385135400386d174bc1e63e67313efa18ebcca.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
         <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
In-Reply-To: <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E6E863193A06FA439E5D3A2D6A5BA3F2@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUwbZRz3ubveHbAztxuzz3Amcsk2wewFZ9wTsyzLtg83jQ7HInGG4m0c
        LRFa1hcFiaayN16ElQkya2EE5EVEgSvixFYb0kzmDF3ZlI1smA6ilkmN2yIgyrzj3ODT83v+
        v7fnw/+hca6PSqLzzHbJahbzeTKeCHTMyxt/eKLEsOWmnIA83V0kqiqtx9Dc3T8AqjmVgsJX
        38dRXWSSRL3h7zBUX3cJIE/oGIGGensIdDY4rEOzV04T6GhLN4kqp9aiUKiHQn9dKcNQ7T/t
        GLo84CHRnaogQK2jYQx5WocI1NK+HvV4ZzA0fb2eQMf9QQr569t06OLXdvRBg59CXrkOR6O3
        xzDkX5gjkH/8DkDn/5wDO5OF4yP/kkJXYxcQ+j65hglfuW9QQn9gndAkOwRvR6rQ4otigtxZ
        Tgqn25p1wvWffKQQGx6mhKEz84Tgag4AofHCS8K3DV1UeuLBhO2HRPsbGXlG8+YdryWYjsoZ
        hbNckbP/G50TnOMqAE1D9mnoqk2tAPE0x/4IYFXNuE67DAFYN3GGUkUkux1WXFNgHJ3IPg//
        jl0FqgZnfQwsmw5iKrGK3Qs7fh7RaaLnYPsJP6nhXXCi+t7inGDXQTkysqhn2Behr3cWaGVu
        DN6+fBFTy+LYfbCzn1Y1gH0Mljtji3qc1UP5l5nFHMiy8GNfCNfwahidWPh/ngy/nPmcUGNw
        NgV2D2zWrDvhjeinOg0nw9rKCKU9YSW88OEk4QKPuJc1uJfc7mVu9zK3e5m7Ceg6ASwQ8/KN
        ol1K22SVHJusFlOBchy2FMhA28K758C9wb2DAKPBIFhDY/xqJnNDiYF7+JAlp9gk2kzZVke+
        ZBsEkMb5RMYrFRk4JkcsfkuyWu5Tj9IEr2c2RGqyOFbtel2SCiXrfXYtTfOQsa9XQldaJaNU
        lJuXb1+iMTpODY9PSrRJ5hzJKjrspmx1O7Jtynqo1Aqlt0e1M7ZCsUCZatbvwZO0K9rQjNPB
        htZmnCPMFrOUpGeM6vNZVWpymB8UTQE9DfhVzK9q0ArlKz7ImVIqMKXC6H5TrbCLS1SSE1Tv
        23U2c/d703uisZvvfHYqNiYZHvJWXQr0HSxum3z2VqjpZJNv2w7D+Ef8kT0Z2xpTjuUK6Qe2
        cPLWsopXXs1aeDv+mQMtT80fCdx6oTqcW956eONvo+WZJZEsZ4x6fIB3ESc9nvNpwTY9P1b6
        7ok06XdDePeaLypfHkjfv7V0f6w4xhM2k5iWiltt4n94vvXARwQAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMDMtMjQgYXQgMTI6NTMgKzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90
ZToNCj4gSGVsbG8gQW5keSwNCj4gDQo+IEkgZG8gYWdyZWUgd2l0aCBtb3N0IG9mIHRoZSB0aGlu
Z3MgeW91IHBvaW50ZWQgb3V0LiBJIGRpZG4ndCBjb21tZW50DQo+IHRoZW0uDQo+IA0KPiBPbiBU
dWUsIDIwMjAtMDMtMjQgYXQgMTE6NTAgKzAyMDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4g
PiBPbiBUdWUsIE1hciAyNCwgMjAyMCBhdCAxMDozMjoxOUFNICswMjAwLCBNYXR0aSBWYWl0dGlu
ZW4gd3JvdGU6DQo+ID4gPiBUaGUgUk9ITSBCRDk5OTU0IGlzIGEgQmF0dGVyeSBNYW5hZ2VtZW50
IExTSSBmb3IgMS00IGNlbGwNCj4gPiA+IExpdGhpdW0tDQo+ID4gPiBJb24NCj4gPiA+IHNlY29u
ZGFyeSBiYXR0ZXJ5IGludGVuZGVkIHRvIGJlIHVzZWQgaW4gc3BhY2UtY29uc3RyYWludA0KPiA+
ID4gZXF1aXBtZW50DQo+ID4gPiBzdWNoDQo+ID4gPiBhcyBMb3cgcHJvZmlsZSBOb3RlYm9vayBQ
QywgVGFibGV0cyBhbmQgb3RoZXIgYXBwbGljYXRpb25zLg0KPiA+ID4gQkQ5OTk1NA0KPiA+ID4g
cHJvdmlkZXMgYSBEdWFsLXNvdXJjZSBCYXR0ZXJ5IENoYXJnZXIsIHR3byBwb3J0IEJDMS4yIGRl
dGVjdGlvbg0KPiA+ID4gYW5kIGENCj4gPiA+IEJhdHRlcnkgTW9uaXRvci4NCj4gPiANCj4gPiA+
ICsJZG8gew0KPiA+ID4gKwkJcmV0ID0gcmVnbWFwX2ZpZWxkX3JlYWQoYmQtDQo+ID4gPiA+cm1h
cF9maWVsZHNbRl9PVFBMRF9TVEFURV0sIA0KPiA+ID4gJnN0YXRlKTsNCj4gPiA+ICsJCWlmIChy
ZXQpDQo+ID4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiA+ICsNCj4gPiA+ICsJCW1zbGVlcCgxMCk7
DQo+ID4gPiArCX0gd2hpbGUgKHN0YXRlID09IDAgJiYgLS1yc3RfY2hlY2tfY291bnRlcik7DQo+
ID4gDQo+ID4gcmVnbWFwX3JlYWRfcG9sbF90aW1lb3V0KCkgZXhpc3RzLCBidXQgSSBzZWUgeW91
IHVzZSBpdCBmb3IgZmllbGQuDQo+ID4gUGVyaGFwcyBpdCdzDQo+ID4gYSB0aW1lIHRvIGludHJv
ZHVjZSBzaW1pbGFyIGhlbHBlciBmb3IgZmllbGQgcG9sbGluZy4NCj4gVGhpcyBzZXJpZXMgaXMg
YWdhaW4gZ2V0dGluZyBsZW5ndGh5Li4uIEknbGwgc2VlIGlmIEkgYWRkIHN1Y2ggYW4gQVBJDQo+
IGluIHRoaXMgc2VyaWVzLiBJJ3ZlIGxlYXJuZWQgdGhhdCBhZGRpbmcgY2hhbmdlcyB3aWxsIGlu
Y3JlYXNlIHRoZQ0KPiB0aW1lDQo+IGl0IHRha2VzIHRvIHB1c2ggdGhlIHNlcmllcyB0aHJvdWdo
LiBJdCBtaWdodCBiZSBtb3JlIHJldmlld2VyDQo+IGZyaWVuZGx5DQo+IHRvIGFkZCBpdCBpbiBv
d24gcGF0Y2ggd2l0aCBsaW1pdGVkIHJldmlldyBhdWRpZW5jZSAoYXMgd291bGQgYmUgdGhlDQo+
IHBhdGNoIDEwLzEwIGluIHRoaXMgc2VyaWVzKS4gQnV0IEkgdGhpbmsgeW91ciBwb2ludCBpcyB2
YWxpZC4NCg0KSSB0b29rIGEgcGVlayBhdCByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQoKS4gTmlj
ZSBBUEkgLSBhbmQgaWYgd2Ugd2VyZQ0KdG8gY3JlYXRlIHNpbWlsYXIgZm9yIGZpZWxkcywgd2Ug
c2hvdWxkIHByb2JhYmx5IG1ha2UgYmVoYXZpb3VyDQppZGVudGljYWwgdG8gcmVnbWFwX3JlYWRf
cG9sbF90aW1lb3V0KCkuIEkgc2VlDQpyZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQoKSBpcyB1c2lu
ZyBocnRpbWVycyBmb3IgdGltZW91dCAtIHdoaWNoIGlzDQpvdmVya2lsbCBmb3IgdGhlIEJEOTk5
NTQgbmVlZHMuIEknZCByYXRoZXIga2VlcCB0aGUgbXNsZWVwIGhlcmUuDQoNCkJyLA0KCU1hdHRp
DQo=
