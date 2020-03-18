Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA4AE189D33
	for <lists+linux-pm@lfdr.de>; Wed, 18 Mar 2020 14:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCRNme (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Mar 2020 09:42:34 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:57846 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgCRNmd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Mar 2020 09:42:33 -0400
X-AuditID: c0a8fbf4-473ff70000004419-3b-5e7225483a44
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id CC.AF.17433.845227E5; Wed, 18 Mar 2020 14:42:32 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Wed, 18 Mar 2020 14:42:28 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 3/9] drivers: base: add linear ranges helpers
Thread-Topic: [PATCH v4 3/9] drivers: base: add linear ranges helpers
Thread-Index: AQHV67kCB0CncXH1kEONhjkrsWrLkKhOZHcAgAAJdgA=
Date:   Wed, 18 Mar 2020 13:42:26 +0000
Message-ID: <910505f6a38298707fc27b135e49a7e2a941fb88.camel@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <01ac2439f9d33ae405999065c5d28c368bad4a28.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <20200318130838.GB2769584@kroah.com>
In-Reply-To: <20200318130838.GB2769584@kroah.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <63C6FE4FD93C984BA3828A277BE2A644@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0gTYRjm291ut+nFNVd+rZI8k0pJG1QcoWFQsQJLkiKi1DMvZ+2Xt3NY
        /TMrxR8UKko1XJo6iTlWLDA1s1grZpIVmVZUZEqhgiBKRT+su12mf33P9z7P8z7vx/fiiPoy
        psULzDzLmRkjhanQBzd++jfq47msTSUuJV0/MobRjcEBOX2+5SZGfx0sl9EvuxsweuZiENDu
        4RcyusEdQmnXbD1Cl94LKuj+u3xahN57zQv0Xc73Cr3fU4Hp77u8Cv2MPyZDfiQiJZfh7ZkF
        +ebk7TkRhq6+UWD9nFw87SsFDhBKqgRKHJKb4cXeOlklUOFq8hWAv2uDmHQJAVhf+UO44DhG
        psDKNwrRoCFTYU1bFSJqEPIDCr+8uxYmosidsK73eVivIXfBpmFe0m+Db2p9YQlKxsP+cp9c
        xAS5D5a0Tf7L6gew9deHMKEkdXCg3SkTMSBXwwrHVBgjZDT0f/4ml6YmYWvPM0TCy+D46Ny/
        eiy8882HijMg5AZ4sztZsqYJM3RiEo6FdVUjCmmGpbDv6hhaDZY7FyU4F9zORW7nIrdzkbsJ
        yD0AmpgCYz7Ds7okji1K4iwGk3Act5j8QPro2U7wJ7AnAGQ4CIAVuIxaRswMFWapl+Ra8k4b
        GJshmysysrYAgDhCaYiWQkuWmshjTp9hOcs8tRJHqWhi3UjNMTUpZp1iWSvLzbOrcJyCxNG1
        XJZ6Kcfms8UnCoz8Ai3DlWJzlVZjY815LMcU8YZscT+ybcKCiFSkkNsr2gmblTEJVcn6BCTi
        1eOuZgQPutzNiBo1W8ysNpoYihOkpCg1FJn/B02AaBxQUcQnSmAjhW3/32dCiJAJEcW3xKfZ
        eGaB0jrAquRPh6rhlRj7j4fXT1rHm6dTHqdm3l6jSjpofFqP7G8/UDYca5wEH1VT6Wf7LZap
        0cLc7w6g3WrYN8e3V8Um9Jns9oxzta4LHYfNOaH3/Mcj36nXe51luwrLEffgmPflo3Tas8PY
        s7tre7Cj0XGJSPe8XRnQHXa5O3q2xCWup1CbgdElIJyN+QuFx0LhqgMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gR3JlZywNCg0KT24gV2VkLCAyMDIwLTAzLTE4IGF0IDE0OjA4ICswMTAwLCBHcmVnIEty
b2FoLUhhcnRtYW4gd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDI1LCAyMDIwIGF0IDEwOjUzOjAxQU0g
KzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBNYW55IGRldmljZXMgaGF2ZSBjb250
cm9sIHJlZ2lzdGVycyB3aGljaCBjb250cm9sIHNvbWUgbWVhc3VyYWJsZQ0KPiA+IHByb3BlcnR5
LiBPZnRlbiBhIHJlZ2lzdGVyIGNvbnRhaW5zIGNvbnRyb2wgZmllbGQgc28gdGhhdCBjaGFuZ2Ug
aW4NCj4gPiB0aGlzIGZpZWxkIGNhdXNlcyBsaW5lYXIgY2hhbmdlIGluIHRoZSBjb250cm9sbGVk
IHByb3BlcnR5LiBJdCBpcw0KPiA+IG5vdA0KPiA+IGEgcmFyZSBjYXNlIHRoYXQgdXNlciB3YW50
cyB0byBnaXZlICdtZWFuaW5nZnVsJyBjb250cm9sIHZhbHVlcyBhbmQNCj4gPiBkcml2ZXIgbmVl
ZHMgdG8gY29udmVydCB0aGVtIHRvIHJlZ2lzdGVyIGZpZWxkIHZhbHVlcy4gRXZlbiBtb3JlDQo+
ID4gb2Z0ZW4gdXNlciB3YW50cyB0byAnc2VlJyB0aGUgY3VycmVudGx5IHNldCB2YWx1ZSAtIGFn
YWluIGluDQo+ID4gbWVhbmluZ2Z1bCB1bml0cyAtIGFuZCBkcml2ZXIgbmVlZHMgdG8gY29udmVy
dCB0aGUgdmFsdWVzIGl0IHJlYWRzDQo+ID4gZnJvbSByZWdpc3RlciB0byB0aGVzZSBtZWFuaW5n
ZnVsIHVuaXRzLiBFeGFtcGxlcyBvZiB0aGlzIGluY2x1ZGU6DQo+ID4gDQo+ID4gLSByZWd1bGF0
b3JzLCB2b2x0YWdlL2N1cnJlbnQgY29uZmlndXJhdGlvbnMNCj4gPiAtIHBvd2VyLCB2b2x0YWdl
L2N1cnJlbnQgY29uZmlndXJhdGlvbnMNCj4gPiAtIGNsayg/KSBOQ09zDQo+ID4gDQo+ID4gYW5k
IG1heWJlIG90aGVycyBJIGNhbid0IHRoaW5rIG9mIHJpZ2h0IG5vdy4NCj4gPiANCj4gPiBQcm92
aWRlIGEgbGluZWFyX3JhbmdlIGhlbHBlciB3aGljaCBjYW4gZG8gY29udmVyc2lvbiBmcm9tIHVz
ZXINCj4gPiB2YWx1ZQ0KPiA+IHRvIHJlZ2lzdGVyIHZhbHVlICdzZWxlY3RvcicuDQo+ID4gDQo+
ID4gVGhlIGlkZWEgaGVyZSBpcyBzdG9sZW4gZnJvbSByZWd1bGF0b3IgZnJhbWV3b3JrIGFuZCBw
YXRjaGVzDQo+ID4gcmVmYWN0b3JpbmcNCj4gPiB0aGUgcmVndWxhdG9yIGhlbHBlcnMgdG8gdXNl
IHRoaXMgYXJlIGZvbGxvd2luZy4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0
dGluZW4gPG1hdHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiAtLS0NCj4gPiAN
Cj4gPiBDaGFuZ2VzIHNpbmNlIHJmYy12MzoNCj4gPiAgIC0gS2VybmVsZG9jIGZpeGVzDQo+ID4g
ICAtIENvcnJlY3RlZCBjb21taXQgbWVzc2FnZSB0eXBvIG1lYW5pbmdmdWxsID0+IG1lYW5pbmdm
dWwNCj4gPiANCj4gPiAgZHJpdmVycy9iYXNlL0tjb25maWcgICAgICAgICB8ICAgMyArDQo+ID4g
IGRyaXZlcnMvYmFzZS9NYWtlZmlsZSAgICAgICAgfCAgIDEgKw0KPiA+ICBkcml2ZXJzL2Jhc2Uv
bGluZWFyX3Jhbmdlcy5jIHwgMjQ2DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gDQo+IFdoeSBpbiBkcml2ZXJzL2Jhc2UvID8NCj4gDQo+IFdoeSBub3QgaW4gbGli
LyA/DQoNCkkgd2FzIHBvbmRlcmluZyB3aGljaCBvZiB0aGVzZSB3b3VsZCBiZSBiZXR0ZXIuIEkg
ZGVjaWRlZCB0byBkbyB3aXRoDQpkcml2ZXJzL2Jhc2UgYmVjYXVzZSAtIGluIGl0J3MgY3VycmVu
dCBmb3JtIC0gdGhpcyBpcyByZWFsbHkgYSBkcml2ZXINCnJlbGF0ZWQgc3R1ZmYuIEkgc2VlIGl0
IHNvbWVob3cgaW4gc2FtZSBwb3NpdGlvbiBhcyByZWdtYXAgY29kZSAtDQphbHRob3VnaCB0aGlz
IGlzIGp1c3QgYSB0aW55IGhlbHBlciBjb21wYXJlZCB0byByZWdtYXAuIEJ1dCB0aGlzIGFsc28N
CmhhcyBwcmV0dHkgZHJpdmVyIHNwZWNpZmljIGF1ZGllbmNlIDopDQoNCkFuZC4uLiBJIG11c3Qg
YWRtaXQgSSBsaWtlIHRoaW5ncyB3aGljaCBJIGtub3cuIEFuZCBJIGhhdmUgYmVlbiBkb2luZw0K
ZHJpdmVyIGRldmVsb3BtZW50IGFuZCAia25vdyIgYSBmZXcgb2YgdGhlIGRyaXZlciByZWxhdGVk
IGNvbGxlYWd1ZXMgLQ0KaGVuY2Ugd29ya2luZyB3aXRoIHRoZW0gaXMgZWFzaWVyIGZvciBtZSA7
KSBHZXR0aW5nIHRvIGtub3cgdGhlDQpjb2xsZWFndWVzIG1haW50YWluaW5nIGxpYiBpcyBhIGJp
dCBzY2FyeSA6XSBZZXAsIEknbSBGaW5uaXNoIGlmIHlvdQ0KaGFwcGVuIHRvIHdvbmRlciB3aHkg
Z2V0dGluZyB0byBrbm93IHBlb3BsZSBpcyBzY2FyeSB4RA0KDQo+IA0KPiA+ICBpbmNsdWRlL2xp
bnV4L2xpbmVhcl9yYW5nZS5oIHwgIDQ4ICsrKysrKysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAy
OTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9iYXNlL2xp
bmVhcl9yYW5nZXMuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9saW5l
YXJfcmFuZ2UuaA0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvS2NvbmZpZyBi
L2RyaXZlcnMvYmFzZS9LY29uZmlnDQo+ID4gaW5kZXggNWYwYmM3NGQyNDA5Li42MzZiNmZhOGU0
OTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9iYXNlL0tjb25maWcNCj4gPiArKysgYi9kcml2
ZXJzL2Jhc2UvS2NvbmZpZw0KPiA+IEBAIC0yMDksNCArMjA5LDcgQEAgY29uZmlnIEdFTkVSSUNf
QVJDSF9UT1BPTE9HWQ0KPiA+ICAJICBhcHByb3ByaWF0ZSBzY2FsaW5nLCBzeXNmcyBpbnRlcmZh
Y2UgZm9yIHJlYWRpbmcgY2FwYWNpdHkNCj4gPiB2YWx1ZXMgYXQNCj4gPiAgCSAgcnVudGltZS4N
Cj4gPiAgDQo+ID4gK2NvbmZpZyBMSU5FQVJfUkFOR0VTDQo+ID4gKwl0cmlzdGF0ZQ0KPiANCj4g
Tm8gaGVscCB0ZXh0IGF0IGFsbD8/Pw0KDQpZZXMuIFRoZSBsaW5lYXIgcmFuZ2VzIGhhcyBubyBt
ZWFuaW5nIHRvIGJlIGVuYWJsZWQgYWxvbmUuIEl0IG9ubHkNCnBsYXlzIGEgcm9sZSBpZiBpdCBp
cyB1c2VkIGJ5IHNvbWUgZHJpdmVyL3N1YnN5c3RlbS4gQW5kDQpkcml2ZXJzL3N1YnN5c3RlbXMg
c2hvdWxkIGRvDQpzZWxlY3QgTElORUFSX1JBTkdFUy4gU28gc2hvd2luZyBoZWxwIGluIGFueSBj
b25maWcgdG9vbCBpcyBub3QgbmVlZGVkLg0KVGhpcyBzaG91bGQgYWN0dWFsbHkgbm90IGJlIHZp
c2libGUgaW4gbWVudWNvbmZpZyBvciBvdGhlcnMuIEkgdGhpbmsgSQ0KaGF2ZSBzZWVuIGEgZmV3
IGV4YW1wbGVzIGxpa2UgdGhpcy4NCg0KQXl3YXlzLCBJIGhhdmUgbm8gb2JlamN0aW9ucyB0byBh
ZGRpbmcgc29tZSB0ZXh0IGlmIGFic29sdXRlbHkgbmVlZGVkLg0KQW55IHN1Z2dlc3Rpb25zIGZv
ciBhIHRleHQgcG9saXRlbHkgc2F5aW5nIC0gInBsZWFzZSwgcHJldGVuZCBJIGFtIG5vdA0KaGVy
ZSIgLSBhcmUgd2VsY29tZSA6KSAoQWx0aG91Z2gsIEkgdGhpbmsgdGhpcyByZWFsbHkgZG9lcyBu
b3QgbmVlZA0KaGVscCB0ZXh0KS4NCg0KPiANCj4gPiArRVhQT1JUX1NZTUJPTChsaW5lYXJfcmFu
Z2VfdmFsdWVzX2luX3JhbmdlKTsNCj4gDQo+IEVYUE9SVF9TWU1CT0xfR1BMKCkgZm9yIGFsbCBv
ZiB0aGVzZT8gIEkgaGF2ZSB0byBhc2suLi4NCg0KSSBwZXJzb25hbGx5IGhhdmUgbm8gb2JqZWN0
aW9ucyB0b3dhcmRzIEVYUE9SVF9TWU1CT0xfR1BMLiBJIGd1ZXNzDQpyZWd1bGF0b3IgaGVscGVy
cyBhbmQgdGhlIHBvd2VyIHN1cHBseSBtb2R1bGVzIHdoaWNoIHVzZSB0aGlzIGFyZSBHUEwNCm1v
ZHVsZXMuIElmIG5vIG90aGVyIChiZXR0ZXIpIG9waW5pb25zLCB0aGVuIEkgY2FuIGNoYW5nZSB0
aGlzIGluIG5leHQNCnZlcnNpb24uIFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0IC0gSSBkaWRu
J3QgZXZlbiB0aGluayBhYm91dCBpdC4NCg0KPiANCj4gPiBAQCAtMCwwICsxLDQ4IEBADQo+ID4g
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovDQo+IA0KPiBB
cmUgeW91IHN1cmUgYWJvdXQgdGhlICJvciBsYXRlciI/ICBBZ2FpbiwgSSBoYXZlIHRvIGFzay4N
Cg0KTm8uIElmIHlvdSB3YW50IHRvIGVkdWNhdGUgbWUgb24gdGhpcyB0b3BpYyAtIG9yIHBvaW50
IGEgbGluayB0byBzb21lDQpuaWNlIGV4cGxhbmF0aW9uIHdoeSB0byBub3QgdXNlICJsYXRlciIg
LSBwcmV0dHkgcGxlYXNlLiBJIHdvdWxkIGxpa2UNCnRvIGxlYXJuIDopDQoNCj4gDQo+ID4gKy8q
IENvcHlyaWdodCAoQykgMjAyMCBST0hNIFNlbWljb25kdWN0b3JzICovDQo+ID4gKw0KPiA+ICsj
aWZuZGVmIExJTkVBUl9SQU5HRV9IDQo+ID4gKyNkZWZpbmUgTElORUFSX1JBTkdFX0gNCj4gPiAr
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC90eXBlcy5oPg0KPiANCj4gV2h5IGlzIHRoaXMgbmVlZGVk
Pw0KDQpJIHRoaW5rIGl0IHdhcyB0aGUgYm9vbCB0eXBlIHdoaWNoIHdhcyBtaXNzaW5nIHdpdGhv
dXQgdGhpcy4gQXQgbGVhc3QNCm9uIG15IEFSTSBnY2MgdG9vbGNoYWluLg0KDQpCZXN0IFJlZ2Fy
ZHMNCglNYXR0aSBWYWl0dGluZW4NCg==
