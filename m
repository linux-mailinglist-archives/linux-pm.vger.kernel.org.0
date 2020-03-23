Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1284218FE18
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 20:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgCWTvT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 15:51:19 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:44950 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbgCWTvT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 15:51:19 -0400
X-Greylist: delayed 13829 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Mar 2020 15:51:17 EDT
X-AuditID: c0a8fbf4-489ff70000004419-a3-5e78d82b0671
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id D9.6B.17433.B28D87E5; Mon, 23 Mar 2020 16:39:23 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Mon, 23 Mar 2020 16:39:03 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v4 3/9] drivers: base: add linear ranges helpers
Thread-Topic: [PATCH v4 3/9] drivers: base: add linear ranges helpers
Thread-Index: AQHV67kCB0CncXH1kEONhjkrsWrLkKhOZHcAgAAJdgCAAAJXAIAH+feA
Date:   Mon, 23 Mar 2020 15:39:02 +0000
Message-ID: <97be7d2176108a6ea0ff5dcd6c7bfbba65074414.camel@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <01ac2439f9d33ae405999065c5d28c368bad4a28.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <20200318130838.GB2769584@kroah.com>
         <910505f6a38298707fc27b135e49a7e2a941fb88.camel@fi.rohmeurope.com>
         <20200318135052.GA2804430@kroah.com>
In-Reply-To: <20200318135052.GA2804430@kroah.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <333A3739B0DC9049BACF549E2C4C47DD@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHO/fe3Z1NF9e55clKcBZRkiVE3A8a0hvrS/RCVGaua17dmNvs
        bqtlL1gRzFVkZFYjS12GruloFaW9yZrQCnrRmfpBY2VCZSFmCb1Y93or9+k85/n//8/vwHkg
        rqwmk6HBbGM5M1OiIeVEe+OP64vSex35SzraU+iz0UGSvhx6JqGPevwk/S3ixOiutosk/eVk
        CNANPS8x+mLDY4KuGTuL08fuh6T007u2nDit75IPaFvd/VJtwFtBah/W+KTaL4GU9ZLcuKwC
        xrZnk6HYvHj5zjh95fcRSalrieO6p58sB8MZLiCDiFqKXp9oAy4gh0qqG6DQ6GFCvDwG6FKw
        lnQBCEkqC7n6pEJARWWj01eP44IHpwYI5Gz6hAtCIrUKVT14MelXUatRbY9N9K9B3t5zhNAm
        qHnogjdbaCuodehIRxgTUa0YGm3vIwVBRmWigch5TKgBNQdVlH+erHEqCQWGxiXioyl05d5z
        XKzV6P3bib/9VHR7vGWShVMLkL9tsRjNQdWjlwmxTkVVx6NS8Q0JKHxhkKgEM9wxBPdU2h2T
        dsek3THpWiDxAmRiDCXFjI3NzOBYewZn0Zv4Y5fFFADiP4/dAb+Da4MAgyAIZkJMo1Ywrxz5
        yukFlsJ9esaq13H2EtYaBAjiGpXiBstrikJmXxnLWf5JsyChSVLMj57eoaQElpFlS1nunzob
        Qg1SNAtDEzi2mHUUGUpsUzIGZcJwebLKypoLWY6x2/Q6YT10Vn4/BCme5yZ2C1xrKWPiu2L0
        CUiHle9r6nEYqmmox5WE2WJmk5MUuh7eSglWvd38H/QBJEGgSVSoBTWeX/b/cz7wCIxHFLv3
        CggbMyUll4PV21pu5prCc8eNfemDhzY0n4rX32baIxVD8Z32jQuM5/0TKzx1iTO2D28qi8Bf
        nQMRT65nOH8ozedsnrPl57S2JvnOrDonE3i0e/qylakT3s6vt37nvXKmNHa9eZdQWN140G/c
        fyBv7NpW9cdATloVoEdk0ZHw5kD6GbfxMyyKaAirnslciHNW5g+lfbc7qQMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gR3JlZywNCg0KT24gV2VkLCAyMDIwLTAzLTE4IGF0IDE0OjUwICswMTAwLCBncmVna2hA
bGludXhmb3VuZGF0aW9uLm9yZyB3cm90ZToNCj4gT24gV2VkLCBNYXIgMTgsIDIwMjAgYXQgMDE6
NDI6MjZQTSArMDAwMCwgVmFpdHRpbmVuLCBNYXR0aSB3cm90ZToNCj4gPiBIZWxsbyBHcmVnLA0K
PiA+IA0KPiA+IE9uIFdlZCwgMjAyMC0wMy0xOCBhdCAxNDowOCArMDEwMCwgR3JlZyBLcm9haC1I
YXJ0bWFuIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBGZWIgMjUsIDIwMjAgYXQgMTA6NTM6MDFBTSAr
MDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ID4gPiBNYW55IGRldmljZXMgaGF2ZSBj
b250cm9sIHJlZ2lzdGVycyB3aGljaCBjb250cm9sIHNvbWUNCj4gPiA+ID4gbWVhc3VyYWJsZQ0K
PiA+ID4gPiBwcm9wZXJ0eS4gT2Z0ZW4gYSByZWdpc3RlciBjb250YWlucyBjb250cm9sIGZpZWxk
IHNvIHRoYXQNCj4gPiA+ID4gY2hhbmdlIGluDQo+ID4gPiA+IHRoaXMgZmllbGQgY2F1c2VzIGxp
bmVhciBjaGFuZ2UgaW4gdGhlIGNvbnRyb2xsZWQgcHJvcGVydHkuIEl0DQo+ID4gPiA+IGlzDQo+
ID4gPiA+IG5vdA0KPiA+ID4gPiBhIHJhcmUgY2FzZSB0aGF0IHVzZXIgd2FudHMgdG8gZ2l2ZSAn
bWVhbmluZ2Z1bCcgY29udHJvbCB2YWx1ZXMNCj4gPiA+ID4gYW5kDQo+ID4gPiA+IGRyaXZlciBu
ZWVkcyB0byBjb252ZXJ0IHRoZW0gdG8gcmVnaXN0ZXIgZmllbGQgdmFsdWVzLiBFdmVuDQo+ID4g
PiA+IG1vcmUNCj4gPiA+ID4gb2Z0ZW4gdXNlciB3YW50cyB0byAnc2VlJyB0aGUgY3VycmVudGx5
IHNldCB2YWx1ZSAtIGFnYWluIGluDQo+ID4gPiA+IG1lYW5pbmdmdWwgdW5pdHMgLSBhbmQgZHJp
dmVyIG5lZWRzIHRvIGNvbnZlcnQgdGhlIHZhbHVlcyBpdA0KPiA+ID4gPiByZWFkcw0KPiA+ID4g
PiBmcm9tIHJlZ2lzdGVyIHRvIHRoZXNlIG1lYW5pbmdmdWwgdW5pdHMuIEV4YW1wbGVzIG9mIHRo
aXMNCj4gPiA+ID4gaW5jbHVkZToNCj4gPiA+ID4gDQo+ID4gPiA+IC0gcmVndWxhdG9ycywgdm9s
dGFnZS9jdXJyZW50IGNvbmZpZ3VyYXRpb25zDQo+ID4gPiA+IC0gcG93ZXIsIHZvbHRhZ2UvY3Vy
cmVudCBjb25maWd1cmF0aW9ucw0KPiA+ID4gPiAtIGNsayg/KSBOQ09zDQo+ID4gPiA+IA0KPiA+
ID4gPiBhbmQgbWF5YmUgb3RoZXJzIEkgY2FuJ3QgdGhpbmsgb2YgcmlnaHQgbm93Lg0KPiA+ID4g
PiANCj4gPiA+ID4gUHJvdmlkZSBhIGxpbmVhcl9yYW5nZSBoZWxwZXIgd2hpY2ggY2FuIGRvIGNv
bnZlcnNpb24gZnJvbSB1c2VyDQo+ID4gPiA+IHZhbHVlDQo+ID4gPiA+IHRvIHJlZ2lzdGVyIHZh
bHVlICdzZWxlY3RvcicuDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGUgaWRlYSBoZXJlIGlzIHN0b2xl
biBmcm9tIHJlZ3VsYXRvciBmcmFtZXdvcmsgYW5kIHBhdGNoZXMNCj4gPiA+ID4gcmVmYWN0b3Jp
bmcNCj4gPiA+ID4gdGhlIHJlZ3VsYXRvciBoZWxwZXJzIHRvIHVzZSB0aGlzIGFyZSBmb2xsb3dp
bmcuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPA0K
PiA+ID4gPiBtYXR0aS52YWl0dGluZW5AZmkucm9obWV1cm9wZS5jb20+DQo+ID4gPiA+IC0tLQ0K
PiA+ID4gPiANCj4gPiA+ID4gQ2hhbmdlcyBzaW5jZSByZmMtdjM6DQo+ID4gPiA+ICAgLSBLZXJu
ZWxkb2MgZml4ZXMNCj4gPiA+ID4gICAtIENvcnJlY3RlZCBjb21taXQgbWVzc2FnZSB0eXBvIG1l
YW5pbmdmdWxsID0+IG1lYW5pbmdmdWwNCj4gPiA+ID4gDQo+ID4gPiA+ICBkcml2ZXJzL2Jhc2Uv
S2NvbmZpZyAgICAgICAgIHwgICAzICsNCj4gPiA+ID4gIGRyaXZlcnMvYmFzZS9NYWtlZmlsZSAg
ICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9iYXNlL2xpbmVhcl9yYW5nZXMuYyB8IDI0
Ng0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gDQo+
ID4gPiBXaHkgaW4gZHJpdmVycy9iYXNlLyA/DQo+ID4gPiANCj4gPiA+IFdoeSBub3QgaW4gbGli
LyA/DQo+ID4gDQo+ID4gSSB3YXMgcG9uZGVyaW5nIHdoaWNoIG9mIHRoZXNlIHdvdWxkIGJlIGJl
dHRlci4gSSBkZWNpZGVkIHRvIGRvDQo+ID4gd2l0aA0KPiA+IGRyaXZlcnMvYmFzZSBiZWNhdXNl
IC0gaW4gaXQncyBjdXJyZW50IGZvcm0gLSB0aGlzIGlzIHJlYWxseSBhDQo+ID4gZHJpdmVyDQo+
ID4gcmVsYXRlZCBzdHVmZi4gSSBzZWUgaXQgc29tZWhvdyBpbiBzYW1lIHBvc2l0aW9uIGFzIHJl
Z21hcCBjb2RlIC0NCj4gPiBhbHRob3VnaCB0aGlzIGlzIGp1c3QgYSB0aW55IGhlbHBlciBjb21w
YXJlZCB0byByZWdtYXAuIEJ1dCB0aGlzDQo+ID4gYWxzbw0KPiA+IGhhcyBwcmV0dHkgZHJpdmVy
IHNwZWNpZmljIGF1ZGllbmNlIDopDQo+ID4gDQo+ID4gQW5kLi4uIEkgbXVzdCBhZG1pdCBJIGxp
a2UgdGhpbmdzIHdoaWNoIEkga25vdy4gQW5kIEkgaGF2ZSBiZWVuDQo+ID4gZG9pbmcNCj4gPiBk
cml2ZXIgZGV2ZWxvcG1lbnQgYW5kICJrbm93IiBhIGZldyBvZiB0aGUgZHJpdmVyIHJlbGF0ZWQN
Cj4gPiBjb2xsZWFndWVzIC0NCj4gPiBoZW5jZSB3b3JraW5nIHdpdGggdGhlbSBpcyBlYXNpZXIg
Zm9yIG1lIDspIEdldHRpbmcgdG8ga25vdyB0aGUNCj4gPiBjb2xsZWFndWVzIG1haW50YWluaW5n
IGxpYiBpcyBhIGJpdCBzY2FyeSA6XSBZZXAsIEknbSBGaW5uaXNoIGlmDQo+ID4geW91DQo+ID4g
aGFwcGVuIHRvIHdvbmRlciB3aHkgZ2V0dGluZyB0byBrbm93IHBlb3BsZSBpcyBzY2FyeSB4RA0K
PiA+IA0KPiA+ID4gPiAgaW5jbHVkZS9saW51eC9saW5lYXJfcmFuZ2UuaCB8ICA0OCArKysrKysr
DQo+ID4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDI5OCBpbnNlcnRpb25zKCspDQo+ID4gPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9iYXNlL2xpbmVhcl9yYW5nZXMuYw0KPiA+ID4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbGluZWFyX3JhbmdlLmgNCj4gPiA+ID4g
DQo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvS2NvbmZpZyBiL2RyaXZlcnMvYmFz
ZS9LY29uZmlnDQo+ID4gPiA+IGluZGV4IDVmMGJjNzRkMjQwOS4uNjM2YjZmYThlNDk5IDEwMDY0
NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvS2NvbmZpZw0KPiA+ID4gPiArKysgYi9kcml2
ZXJzL2Jhc2UvS2NvbmZpZw0KPiA+ID4gPiBAQCAtMjA5LDQgKzIwOSw3IEBAIGNvbmZpZyBHRU5F
UklDX0FSQ0hfVE9QT0xPR1kNCj4gPiA+ID4gIAkgIGFwcHJvcHJpYXRlIHNjYWxpbmcsIHN5c2Zz
IGludGVyZmFjZSBmb3IgcmVhZGluZw0KPiA+ID4gPiBjYXBhY2l0eQ0KPiA+ID4gPiB2YWx1ZXMg
YXQNCj4gPiA+ID4gIAkgIHJ1bnRpbWUuDQo+ID4gPiA+ICANCj4gPiA+ID4gK2NvbmZpZyBMSU5F
QVJfUkFOR0VTDQo+ID4gPiA+ICsJdHJpc3RhdGUNCj4gPiA+IA0KPiA+ID4gTm8gaGVscCB0ZXh0
IGF0IGFsbD8/Pw0KPiA+IA0KPiA+IFllcy4gVGhlIGxpbmVhciByYW5nZXMgaGFzIG5vIG1lYW5p
bmcgdG8gYmUgZW5hYmxlZCBhbG9uZS4gSXQgb25seQ0KPiA+IHBsYXlzIGEgcm9sZSBpZiBpdCBp
cyB1c2VkIGJ5IHNvbWUgZHJpdmVyL3N1YnN5c3RlbS4gQW5kDQo+ID4gZHJpdmVycy9zdWJzeXN0
ZW1zIHNob3VsZCBkbw0KPiA+IHNlbGVjdCBMSU5FQVJfUkFOR0VTLiBTbyBzaG93aW5nIGhlbHAg
aW4gYW55IGNvbmZpZyB0b29sIGlzIG5vdA0KPiA+IG5lZWRlZC4NCj4gPiBUaGlzIHNob3VsZCBh
Y3R1YWxseSBub3QgYmUgdmlzaWJsZSBpbiBtZW51Y29uZmlnIG9yIG90aGVycy4gSQ0KPiA+IHRo
aW5rIEkNCj4gPiBoYXZlIHNlZW4gYSBmZXcgZXhhbXBsZXMgbGlrZSB0aGlzLg0KPiA+IA0KPiA+
IEF5d2F5cywgSSBoYXZlIG5vIG9iZWpjdGlvbnMgdG8gYWRkaW5nIHNvbWUgdGV4dCBpZiBhYnNv
bHV0ZWx5DQo+ID4gbmVlZGVkLg0KPiA+IEFueSBzdWdnZXN0aW9ucyBmb3IgYSB0ZXh0IHBvbGl0
ZWx5IHNheWluZyAtICJwbGVhc2UsIHByZXRlbmQgSSBhbQ0KPiA+IG5vdA0KPiA+IGhlcmUiIC0g
YXJlIHdlbGNvbWUgOikgKEFsdGhvdWdoLCBJIHRoaW5rIHRoaXMgcmVhbGx5IGRvZXMgbm90IG5l
ZWQNCj4gPiBoZWxwIHRleHQpLg0KPiANCj4gVGhpcyBraW5kIG9mIGltcGxpZXMgaXQgbmVlZHMg
dG8gYmUgaW4gbGliLyB0aGF0IHdheSB0aGUgbmVlZGVkIGNvZGUNCj4gbGlua3MgaXQgYW5kIGFs
bCBzaG91bGQgYmUgZmluZS4NCg0KU2lnaC4gSSBzb21laG93IGd1ZXNzZWQgdGhpcyB3YXMgY29t
aW5nLi4uIFdlbGwsIEkgaGFkIHRvIHRyeSBhbnl3YXlzDQo6KSBQbGVhc2UganVzdCBpZ25vcmUg
djUgLSBJIGRpZCBzZW5kIGl0IHByaW9yIHJlY2VpdmluZyB5b3VyIGNvbW1lbnRzLg0KSSBhbSBh
Ym91dCB0byBzZW5kIHY2IHdoaWNoIHdpbGwgY29udGFpbiB0aGUgY2hhbmdlcyB5b3Ugc3VnZ2Vz
dGVkLg0KTGV0J3Mgc2VlIGhvdyBwZW9wbGUgd2hvIGxvb2sgdGhpbmdzIHRoYXQgZ28gdW5kZXIg
bGliLyB3aWxsIHNlZSB0aGlzLg0KDQpCciwNCiAgIE1hdHRpIFZhaXR0aW5lbg0KDQo=
