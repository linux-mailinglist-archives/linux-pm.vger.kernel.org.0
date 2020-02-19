Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BEF4163E65
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 09:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbgBSIFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 03:05:17 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:48616 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSIFR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 03:05:17 -0500
X-AuditID: c0a8fbf4-473ff70000004419-44-5e4cec3b9e36
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 1F.61.17433.B3CEC4E5; Wed, 19 Feb 2020 09:05:15 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Wed, 19 Feb 2020 09:05:14 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
Thread-Topic: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
Thread-Index: AQHV4wmFTXdRcLHQD0CUbuLOwEiFn6ghWyIAgADEoQA=
Date:   Wed, 19 Feb 2020 08:05:13 +0000
Message-ID: <1da3415507c216d09eb72c30ad915bc139d2ff3d.camel@fi.rohmeurope.com>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <104b5ef63c2ad4771503d9e6618bf427721042c3.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <20200218202122.GA599@bogus>
In-Reply-To: <20200218202122.GA599@bogus>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5273CCB71B442745BCB3EEAD3DE67A9D@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01SWUwTQRjO7G7bKbBmKWhHiiZuNF6xBcPDihf6QlWCJkQfTAQXWSlKW7It
        AsZofTGKgkeoCRUPjgbk8KhRoZZIKihqggcgMQG0SMpRxQSMSjTqbhehT/PNfNefzA9xVak8
        BuaYrBxvYnNpeRjRVvfLtWb955T0uK/9GsbuG5Yz19u7ZEzZ71qM6XZXyJmpknbAOPveYEyF
        s5Ng/nqaFczLR9Ykpb7xWiPQtzgGFHpX/Rm5vv+dR66fci3eJdsbviGTtR5Jy8k26TbtDzcE
        PrwBeTfiCp85S2U2YNMVAyVEVALqeV2lKAZhUEX1AlTytF4mXToBah/xEMUAQjm1ARW/V4iG
        aGo5qmzw4aIGpy4RyHYzIBeJKGoLOtV3XiaJtiL327czOBE1DXuDGoJahmpedxEiJqlUNPWg
        aabsCUA9k4Fgg5JaiQYC34NmQC1CZ2wTmIhxSo1c/h8yaWwK1Xhe4RKej8Y+/Zl5p1HrtC84
        NC7k3HbrJGsSqun9opDwElR21qeQZohEz8uHiQtggSOkwTHndoS4HSFuR4j7BpDVA2Rkc3Kz
        WSsXr+W5fC1vNhiF44DZ6ALS/35rBn+927wAg8ALFkKMnk9ODqakq+ZlmrOKDKzFkMHn53IW
        L0AQp6PJHert6Soyiy06yvHm/5QGErSaXO67uE9FiV2HOS6P4/+zsRDSiDwREEIjeS6bKzyY
        k2udozGoFMPDYqItnCmL49l8qyFDXJAMi7AhIhUh9FaPC3bSkscahVfJ+gKshhfGrlbhsP2q
        swpXESaziYtRk/dGBSklSg35ptmicaCGgI4ir4hBEcKSz+aMCxWYUPE1KlhhZeeoGBs451w/
        +XjP0N2dE/42u6bxzkBcbbmuYLU7me4YKtdV9B6vg1REwubOBNNDy+WuA4neFbLWW0c197Wn
        7SfDNxX4htdSg1lLqn/ybi4tofWjanA/rx+JS106PardFr6uqGN3UsG0X1N7kU+2v/J3d1em
        aA81h21pwKzOho3HWmLbaMJiYONX4byF/QcP7sfqoQMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TW9ybmluZyBSb2IsDQoNCk9uIFR1ZSwgMjAyMC0wMi0xOCBhdCAxNDoyMSAtMDYwMCwgUm9iIEhl
cnJpbmcgd3JvdGU6DQo+IE9uIEZyaSwgMTQgRmViIDIwMjAgMDk6MzY6NDcgKzAyMDAsIE1hdHRp
IFZhaXR0aW5lbiB3cm90ZToNCj4gPiBUaGUgUk9ITSBCRDk5OTU0IGlzIGEgQmF0dGVyeSBNYW5h
Z2VtZW50IExTSSBmb3IgMS00IGNlbGwgTGl0aGl1bS0NCj4gPiBJb24NCj4gPiBzZWNvbmRhcnkg
YmF0dGVyeS4gSW50ZW5kZWQgdG8gYmUgdXNlZCBpbiBzcGFjZS1jb25zdHJhaW50DQo+ID4gZXF1
aXBtZW50IHN1Y2gNCj4gPiBhcyBMb3cgcHJvZmlsZSBOb3RlYm9vayBQQywgVGFibGV0cyBhbmQg
b3RoZXIgYXBwbGljYXRpb25zLiBCRDk5OTU0DQo+ID4gcHJvdmlkZXMgYSBEdWFsLXNvdXJjZSBC
YXR0ZXJ5IENoYXJnZXIsIHR3byBwb3J0IEJDMS4yIGRldGVjdGlvbg0KPiA+IGFuZCBhDQo+ID4g
QmF0dGVyeSBNb25pdG9yLg0KPiA+IA0KPiA+IERvY3VtZW50IHRoZSBEVCBiaW5kaW5ncyBmb3Ig
QkQ5OTk1NA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGku
dmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+IC0tLQ0KPiA+IA0KPiA+IEl0IHdvdWxk
IHByb2JhYmx5IGJlIG5pY2UgaWYgdGhlIGNoYXJnZXIgRFQgYmluZGluZyB5YW1sIGNvdWxkDQo+
ID4gc29tZWhvdw0KPiA+IGJlIGxpc3RpbmcgYW5kIGV2YWx1YXRpbmcgcHJvcGVydGllcyB0aGF0
IGl0IGNhbiB1c2UgZnJvbSBzdGF0aWMNCj4gPiBiYXR0ZXJ5DQo+ID4gbm9kZXMgLSBhbmQgcGVy
aGFwcyBzb21lIHdhcm5pbmcgY291bGQgYmUgZW1pdHRlZCBpZiB1bnN1cHBvcnRlZA0KPiA+IHBy
b3BlcnRpZXMgYXJlIGdpdmVuIGZyb20gYmF0dGVyeSBub2Rlcyg/KSBKdXN0IHNvbWUgdGhpbmtp
bmcgaGVyZS4NCj4gPiBXaGF0IGlmIHRoZSBjaGFyZ2VyIGlnbm9yZXMgZm9yIGV4YW1wbGUgdGhl
IGN1cnJlbnQgbGltaXRzIGZyb20NCj4gPiBiYXR0ZXJ5DQo+ID4gbm9kZSAoSSBhbSBub3Qgc3Vy
ZSBidXQgSSB0aGluayBhIGZldyBtYXkgaWdub3JlKSAtIEkgZ3Vlc3MgaXQNCj4gPiB3b3VsZCBi
ZQ0KPiA+IG5pY2UgdG8gZ2l2ZSBhIG51ZGdlIHRvIGEgcGVyc29uIHdobyBhZGRlZCB0aG9zZSBw
cm9wZXJ0aWVzIGluIGhpcw0KPiA+IERUDQo+ID4gaWYgdGhleSB3b24ndCBoYXZlIGFueSBpbXBh
Y3Q/IEFueSB0aG91Z2h0cz8NCj4gPiANCj4gPiAgLi4uL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9y
b2htLGJkOTk5NXgueWFtbCAgIHwgMTY3DQo+ID4gKysrKysrKysrKysrKysrKysrDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAxNjcgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQN
Cj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3JvaG0s
YmQ5OTk1eC55YW1sDQo+ID4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21h
a2UgZHRfYmluZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCg0KT3VjaCAuLi4gc29ycnkuIFRo
ZXJlIGlzIHNvbWUgbGVmdG92ZXIgYmxvY2sgZnJvbSBhbm90aGVyIHRleHQgYmFzZWQNCmJpbmRp
bmcgZG9jdW1lbnQgd2hpY2ggSSB1c2VkIGFzIGFuIGV4YW1wbGUgd2hpbGUgd3JpdGluZyBvdXQg
dGhlDQpiYXR0ZXJ5IHBhcmFtZXRlcnMgQkQ5OTk1NCB1c2VzLg0KDQpUaGVyZSdzIHR3byBvdGhl
ciBoaWNjdXBzIHdoZW4gSSB0cnkgcnVubmluZyBtYWtlIGR0X2JpbmRpbmdfY2hlY2suIEkNCmFz
c3VtZSB0aGV5IGFyZSBmYWxzZSBwb3NpdGl2ZXMuDQoNCjxTSURFIE5PVEU+DQpBbHRob3VnaC4u
LiBCYWNrIGluIG15IE5va2lhIGRheXMgSSBqb2luZWQgaW4gYSB0cmFpbmVyLXRyYWluaW5nLiBJ
IGhhZA0KZXhjZWxsZW50IEJyaXRpc2ggY29hY2ggLSBHcmFoYW0gaWYgSSByZW1lbWJlciBjb3Jy
ZWN0bHkgLSB3aG8gdG9sZCB1cw0KbmV2ZXIgdG8gYXNzdW1lLiBIZSBleHBsYWluZWQgd2hlcmUg
d29yZCBhc3MtdS1tZSBjb21lcyBmcm9tLiBJIGNhbg0Kc3RpbGwgaGVhciBoaXMgdmVyeSBCcml0
aXNoIGFjY2VudDogIkl0IG1ha2VzIGFuIGFzcyBvdXQgb2YgdSBhbmQgbWUiLg0KSSBzdGlsbCBk
byBzbyB0aG91Z2guIEknbSBub3QgbGVhcm5pbmcgZWFzaWx5IGl0IHNlZW1zLg0KPC9TSURFIE5P
VEU+DQoNCjEuIEl0IHNlZW1zIHRvIG1lIHRoZSBtdWx0aXBsZU9mOiBpcyBub3QgcmVjb2duaXpl
ZC4gSSBndWVzcyBpdA0Kc2hvdWxkKD8pIEkgd2lsbCBjb21tZW50IGl0IG91dCBpbiB2MyB0aG91
Z2ggdW50aWwgSSBnZXQgY29uZmlybWF0aW9uDQppdCBzaG91bGQgd29yay4NCg0KMi4gc2NoZW1h
IHZhbGlkYXRpb24gZm9yOg0KDQogIHJvaG0sdnN5cy1yZWd1bGF0aW9uLW1pY3Jvdm9sdDoNCiAg
ICBkZXNjcmlwdGlvbjogc3lzdGVtIHNwZWNpZmljIGxvd2VyIGxpbWl0IGZvciBzeXN0ZW0gdm9s
dGFnZS4NCiAgICBtaW5pbXVtOiAyNTYwMDAwDQogICAgbWF4aW11bTogMTkyMDAwMDANCiAgICAj
bXVsdGlwbGVPZjogNjQwMDANCg0KZmFpbHMuIEJ1dCB3aGVuIEkgY2hhbmdlIHRoaXMgdG8NCiAg
cm9obSx2c3lzLXJlZ3VsYXRpb24tbWljcm92b2x0czogKHBsdXJhbCkNCml0IHNlZW1zIHRvIGJl
IHBhc3NpbmcgdGhlIHZhbGlkYXRpb24uIEEgZ2l0IGdyZXAgdW5kZXINCkRvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncyByZXZlYWxzIHRoYXQgYm90aCBwbHVyYWwgYW5kIHNpbmd1bGFy
DQphcmUgdXNlZCAtIGJ1dCB0aGUgc2luZ3VsYXIgc2VlbXMgdG8gYmUgZmFyIG1vcmUgcG9wdWxh
ciB0aGFuIHBsdXJhbC4NCkl0IGFsc28gbG9va3MgbGlrZSB0aGUgJ2NvcmUgYmluZGluZ3MnIGxp
a2UgcmVndWxhdG9ycyB1c2Ugc2luZ3VsYXIuDQpIZW5jZSBJJ2xsIGxlYXZlIHRoaXMgdG8gc2lu
Z3VsYXIgZm9yIHYzIGV2ZW4gdGhvdWdoIGl0IGZhaWxzIHRoZQ0KdmFsaWRhdGlvbiAtIHBsZWFz
ZSBsZXQgbWUga25vdyBpZiB0aGlzIHdhcyB3cm9uZyBjaG9pY2Ugb3IgaWYgeW91IHNwb3QNCmFu
eSBvdGhlciBvZGRpdGllcyB0aGVyZS4gSSBjYW4ndCBzZWUgd2hhdCBlbHNlIGl0IGNvdWxkIGJl
IGJ1dCBmb3INCnNvbWUgcmVhc29uIEkgc3RpbGwgZmluZCB0aGlzIHlhbWwgdGVycmlibHkgaGFy
ZCA6KA0KDQpIbW0uLiBJIHdvbmRlciBpZiBJIGhhdmUgc29tZSBvbGQgY2hlY2tlciB0b29scyBp
bnN0YWxsZWQgYW5kIHVzZWQgb24NCm15IFBDPyBJIGFsc28gZ2V0IHZhbGlkYXRpb24gZmFpbHVy
ZXMgZm9yIHRoZSBleGFtcGxlIHNjaGVtYXMgOi8NCg0KPiB3YXJuaW5nOiBubyBzY2hlbWEgZm91
bmQgaW4gZmlsZToNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1
cHBseS9yb2htLGJkOTk5NXgueWFtbA0KPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtDQo+
IHJldmlldy9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3Jv
aG0sYmQ5OTk1eC55YQ0KPiBtbDogaWdub3JpbmcsIGVycm9yIHBhcnNpbmcgZmlsZQ0KPiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9zaW1wbGUtDQo+IGZyYW1lYnVm
ZmVyLmV4YW1wbGUuZHRzOjIxLjE2LTM3LjExOiBXYXJuaW5nIChjaG9zZW5fbm9kZV9pc19yb290
KToNCj4gL2V4YW1wbGUtMC9jaG9zZW46IGNob3NlbiBub2RlIG11c3QgYmUgYXQgcm9vdCBub2Rl
DQo+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvcm9obSxi
ZDk5OTV4LnlhbWw6ICB3aA0KPiBpbGUgc2Nhbm5pbmcgYSBzaW1wbGUga2V5DQo+ICAgaW4gIjx1
bmljb2RlIHN0cmluZz4iLCBsaW5lIDI5LCBjb2x1bW4gMw0KPiBjb3VsZCBub3QgZmluZCBleHBl
Y3RlZCAnOicNCj4gICBpbiAiPHVuaWNvZGUgc3RyaW5nPiIsIGxpbmUgMzAsIGNvbHVtbiAxDQo+
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9NYWtlZmlsZToxMjogcmVjaXBlIGZv
ciB0YXJnZXQNCj4gJ0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBw
bHkvcm9obSxiZDk5OTV4LmV4YW1wbGUuDQo+IGR0cycgZmFpbGVkDQo+IG1ha2VbMV06ICoqKg0K
PiBbRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9yb2htLGJk
OTk5NXguZXhhbXBsZS4NCj4gZHRzXSBFcnJvciAxDQo+IE1ha2VmaWxlOjEyNjM6IHJlY2lwZSBm
b3IgdGFyZ2V0ICdkdF9iaW5kaW5nX2NoZWNrJyBmYWlsZWQNCj4gbWFrZTogKioqIFtkdF9iaW5k
aW5nX2NoZWNrXSBFcnJvciAyDQo+IA0KPiBTZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9y
Zy9wYXRjaC8xMjM3OTAyDQo+IFBsZWFzZSBjaGVjayBhbmQgcmUtc3VibWl0Lg0KDQpJIGhhdmUg
dGhlIFJGQyB2MyBhbG1vc3QgZmluaXNoZWQuIEhvcGUgdG8gZmluZCB0aGUgdGltZSB0byBmaW5p
c2ggYW5kDQpzdWJtaXQgaXQgc3RpbGwgdG9kYXkgOikNCg0KVGhhbmtzIGFuZCByZWdhcmRzDQoJ
TWF0dGkNCg0K
