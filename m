Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCB1176F74
	for <lists+linux-pm@lfdr.de>; Tue,  3 Mar 2020 07:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbgCCGas (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Mar 2020 01:30:48 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:46618 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCGar (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 3 Mar 2020 01:30:47 -0500
X-AuditID: c0a8fbf4-489ff70000004419-5f-5e5df9915af7
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id CC.14.17433.199FD5E5; Tue,  3 Mar 2020 07:30:41 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Tue, 3 Mar 2020 07:30:36 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [PATCH v4 2/9] dt_bindings: ROHM BD99954 Charger
Thread-Topic: [PATCH v4 2/9] dt_bindings: ROHM BD99954 Charger
Thread-Index: AQHV67jwOgfOqLnOL02wK8uJQtWO/ag11amAgACMowA=
Date:   Tue, 3 Mar 2020 06:30:36 +0000
Message-ID: <057de5b908c61f5217ebe3639f5a0c155512be5b.camel@fi.rohmeurope.com>
References: <cover.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <7aa7f2646077228924d596edbc4d076a787d9312.1582617178.git.matti.vaittinen@fi.rohmeurope.com>
         <20200302220717.GA6981@bogus>
In-Reply-To: <20200302220717.GA6981@bogus>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <82BD96DE276D55449FAC83E27238C78C@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sa0gUQRxvdvf29tSt8XyN19MrkBQ1wQ9LWEj2uCgrMAiKU1fdvMO7Pdk7
        QwvqKMxnqZSFp2dlmlaSaZGmQiqCPSAxDUuIMqPSxIqzfFTabpuPT/Ob+b1mmD+Fqy+RGsrI
        2ziBZ01a0o1or/3VEFI8rY/bNFzkzZQMfSCZK13PFcyZ6/Uk87M/B2P6WspJxnWuCzDVA70Y
        U179mGCcEyU4M9fWrGSetdqi3HV1FXVA99DxRqlrvJVL6h4565Q6V+OaA4rD7pGJrO1YrDGF
        D9ua4G64/8OOp82YM/qm+zA7KErNAyoKwQhkf3damQfcKDV8CVDNjV9A3nQDdPrmCyIPUBQJ
        I1Hea6Vk8IaB6NrtIVzS4HCcQJOuKkIivOAW1DE1Ssqiraj3ay0h483o7myOQsoh4AaUX6qX
        IA33oQtNJrmqC6C3D1wKSa6CQajwfA0uYQBXo1z7OCZhHPqhxo+TCvnSEFW19eAy9kEjw7P/
        zwNQ0+Sdf1fG4UZU3xImW6PQx4Z8IOMAdDF/6N9TaOiJnpR+IIqAr2NJg2PR7VjidixxO5a4
        rwLFLYDMrNGUwtq48FCBSw8VLAazuCRZzI1A/ueJZjDXubsTYBToBP4UpvWhv+3Xx6mXJ1qS
        Mw2s1RAvpJs4aydAFK71pmNUR+LUdDKbeZwTLPPUSorQ+tGBQ8V6NZS6UjkujRPm2VUUpUV0
        +6QY6ilwKVzGUaPJtkhjlEoKd9N4Wzk+mRPYdJshXhqPeKs4HxLlIfYWT4l22prGmsVT2foU
        BFNFI85KnOpyVlfiaoK38JzGj04oFKVQkhrS+YWiUeBHAa0X7ZSCPMRhX8gZFSswsaLgk/Q0
        q41dpDR2cCK2n89N3etyN95Tnm29wJ9b0Q0TMm6qLq/Xje2pWLajILYsZKW+jJ+w+R/c+RnL
        3RYws+t772BWSa8jOvrP+9/c2KqO/HXlLhJfNhASY/iTk3CwxkMDvxzyyM5enhF+MfNIZGtO
        2cnk/sHtvvbVyuFTEVlJxT14ycyr0uC1WXNbtITVwIYH4YKV/QtTirFVqQMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gUm9iLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXchDQoNCk9uIE1vbiwgMjAyMC0wMy0w
MiBhdCAxNjowNyAtMDYwMCwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFR1ZSwgRmViIDI1LCAy
MDIwIGF0IDEwOjUyOjMyQU0gKzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiBUaGUg
Uk9ITSBCRDk5OTU0IGlzIGEgQmF0dGVyeSBNYW5hZ2VtZW50IExTSSBmb3IgMS00IGNlbGwgTGl0
aGl1bS0NCj4gPiBJb24NCj4gPiBzZWNvbmRhcnkgYmF0dGVyeS4gSW50ZW5kZWQgdG8gYmUgdXNl
ZCBpbiBzcGFjZS1jb25zdHJhaW50DQo+ID4gZXF1aXBtZW50IHN1Y2gNCj4gPiBhcyBMb3cgcHJv
ZmlsZSBOb3RlYm9vayBQQywgVGFibGV0cyBhbmQgb3RoZXIgYXBwbGljYXRpb25zLiBCRDk5OTU0
DQo+ID4gcHJvdmlkZXMgYSBEdWFsLXNvdXJjZSBCYXR0ZXJ5IENoYXJnZXIsIHR3byBwb3J0IEJD
MS4yIGRldGVjdGlvbg0KPiA+IGFuZCBhDQo+ID4gQmF0dGVyeSBNb25pdG9yLg0KPiA+IA0KPiA+
IERvY3VtZW50IHRoZSBEVCBiaW5kaW5ncyBmb3IgQkQ5OTk1NA0KPiA+IA0KPiA+IFNpZ25lZC1v
ZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF0dGkudmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29t
Pg0KPiA+IC0tLQ0KPiA+IA0KPiA+IENoYW5nZXMgZnJvbSByZmMtdjM6DQo+ID4gICAtIHVuY29t
bWVudCBtdWx0aXBsZU9mDQo+ID4gICAtIGFkZCBhZGRyZXNzIGFuZCBzaXplIGNlbGxzIHByb3Bl
cnRpZXMgdG8gZXhhbXBsZSBJMkMgbm9kZQ0KPiA+IA0KPiA+ICAuLi4vYmluZGluZ3MvcG93ZXIv
c3VwcGx5L3JvaG0sYmQ5OTk1eC55YW1sICAgfCAxNTUNCj4gPiArKysrKysrKysrKysrKysrKysN
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1NSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2Rl
IDEwMDY0NA0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBw
bHkvcm9obSxiZDk5OTV4LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0DQo+ID4gYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3JvaG0sYmQ5OTk1eC55YW1s
DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5L3Jv
aG0sYmQ5OTk1eC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwMDAwMDAuLjU0NzQwMzc3M2VjNQ0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysNCj4gPiBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvcm9obSxiZDk5
OTV4LnlhbWwNCj4gPiBAQCAtMCwwICsxLDE1NSBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlDQo+ID4gKyVZQU1MIDEuMg0KPiA+
ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wb3dlci9zdXBw
bHkvcm9obSxiZDk5OTV4LnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFJPSE0gQkQ5OTk1
NCBCYXR0ZXJ5IGNoYXJnZXIgZHJpdmVyDQo+IA0KPiBCaW5kaW5ncyBhcmUgZm9yIGgvdyBkZXZp
Y2VzLCBub3QgZHJpdmVycy4NClJpZ2h0LiBJJ2xsIGNoYW5nZSB0aGlzLg0KDQo+IA0KPiA+ICsN
Cj4gPiArbWFpbnRhaW5lcnM6DQo+ID4gKyAgLSBNYXR0aSBWYWl0dGluZW4gPG1hdHRpLnZhaXR0
aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiArICAtIE1hcmt1cyBMYWluZSA8bWFya3VzLmxh
aW5lQGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+ICsgIC0gTWlra28gTXV0YW5lbiA8bWlra28ubXV0
YW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOiB8DQo+ID4g
KyAgVGhlIFJPSE0gQkQ5OTk1NCBpcyBhIEJhdHRlcnkgTWFuYWdlbWVudCBMU0kgZm9yIDEtNCBj
ZWxsDQo+ID4gTGl0aGl1bS1Jb24NCj4gPiArICBzZWNvbmRhcnkgYmF0dGVyeSBpbnRlbmRlZCB0
byBiZSB1c2VkIGluIHNwYWNlLWNvbnN0cmFpbnQNCj4gPiBlcXVpcG1lbnQgc3VjaA0KPiA+ICsg
IGFzIExvdyBwcm9maWxlIE5vdGVib29rIFBDLCBUYWJsZXRzIGFuZCBvdGhlciBhcHBsaWNhdGlv
bnMuDQo+ID4gQkQ5OTk1NA0KPiA+ICsgIHByb3ZpZGVzIGEgRHVhbC1zb3VyY2UgQmF0dGVyeSBD
aGFyZ2VyLCB0d28gcG9ydCBCQzEuMiBkZXRlY3Rpb24NCj4gPiBhbmQgYQ0KPiA+ICsgIEJhdHRl
cnkgTW9uaXRvci4NCj4gPiArDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBh
dGlibGU6DQo+ID4gKyAgICBjb25zdDogcm9obSxiZDk5OTV4LWNoYXJnZXINCj4gDQo+IFlvdSBj
YW4gZHJvcCAnLWNoYXJnZXInIGlmIHRoZSB3aG9sZSBjaGlwIGlzIGEgY2hhcmdlciBJQy4gSWYg
aXQgaXMNCj4gbm90LCANCj4gdGhlbiB5b3VyIGV4YW1wbGUgaXMgd3JvbmcuDQo+IA0KPiBZb3Ug
dXNlIEJEOTk5NTQgZWxzZXdoZXJlLCB1c2UgdGhhdCBoZXJlIHRvby4gV2UgZG9uJ3QgZG8gd2ls
ZGNhcmRzDQo+IGluIA0KPiBjb21wYXRpYmxlIHN0cmluZ3MuDQoNCk1ha2VzIHNlbnNlLiBBbmQg
dGhpcyBjaGlwIGlzIGEgY2hhcmdlci4NCg0KPiANCj4gPiArIw0KPiA+ICsjICAgIFRoZSBiYXR0
ZXJ5IGNoYXJnaW5nIHByb2ZpbGUgb2YgQkQ5OTk1NC4NCj4gPiArIw0KPiA+ICsjICAgIEN1cnZl
ICgxKSByZXByZXNlbnRzIGNoYXJnaW5nIGN1cnJlbnQuDQo+ID4gKyMgICAgQ3VydmUgKDIpIHJl
cHJlc2VudHMgYmF0dGVyeSB2b2x0YWdlLg0KPiA+ICsjDQo+ID4gKyMgICAgVGhlIEJEOTk5NTQg
ZGF0YSBzaGVldCBkaXZpZGVzIGNoYXJnaW5nIHRvIHRocmVlIHBoYXNlcy4NCj4gPiArIyAgICBh
KSBUcmlja2xlLWNoYXJnZSB3aXRoIGNvbnN0YW50IGN1cnJlbnQgKDgpLg0KPiA+ICsjICAgIGIp
IHByZS1jaGFyZ2Ugd2l0aCBjb25zdGFudCBjdXJyZW50ICg2KQ0KPiA+ICsjICAgIGMpIGZhc3Qt
Y2hhcmdlIHdpdGg6DQo+ID4gKyMgICAgICAgRmlyc3QgYSBjb25zdGFudCBjdXJyZW50ICg1KSBw
aGFzZSAoQ0MpDQo+ID4gKyMgICAgICAgVGhlbiBjb25zdGFudCB2b2x0YWdlIChDVikgcGhhc2Ug
KGFmdGVyIHRoZSBiYXR0ZXJ5DQo+ID4gdm9sdGFnZSBoYXMgcmVhY2hlZA0KPiA+ICsjICAgICAg
IHRhcmdldCBsZXZlbCAtIHVudGlsIGNoYXJnaW5nIGN1cnJlbnQgaGFzIGRyb3BwZWQgdG8NCj4g
PiB0ZXJtaW5hdGlvbg0KPiA+ICsjICAgICAgIGxldmVsICg3KQ0KPiA+ICsjDQo+ID4gKyMgICAg
IFYgXiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgXg0KPiA+IEkNCj4gPiArIyAgICAgICAuICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAuDQo+ID4gKyMgICAgICAgLiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgLg0KPiA+ICsjICg0KS0g
LS4tIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gICsrKysrKysrKysrKysrKysrKysrKysrKysr
Ky4NCj4gPiArIyAgICAgICAuICAgICAgICAgICAgICAgICAgICAgICAgICAgIC8gICAgICAgICAg
ICAgICAgICAgICAgICAgICAuDQo+ID4gKyMgICAgICAgLiAgICAgICAgICAgICAgICAgICAgICsr
KysrKy8rKyAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLQ0KPiA+IC0uLSAtICg1KQ0KPiA+ICsjICAg
ICAgIC4gICAgICAgICAgICAgICAgICAgICArICAgIC8gICsgICAgICAgICAgICAgICAgICAgICAg
ICAgIC4NCj4gPiArIyAgICAgICAuICAgICAgICAgICAgICAgICAgICAgKyAgIC0gICAtLSAgICAg
ICAgICAgICAgICAgICAgICAgICAuDQo+ID4gKyMgICAgICAgLiAgICAgICAgICAgICAgICAgICAg
ICsgIC0gICAgICsgICAgICAgICAgICAgICAgICAgICAgICAgLg0KPiA+ICsjICAgICAgIC4gICAg
ICAgICAgICAgICAgICAgICArLi0gICAgICAtOiAgICAgICAgICAgICAgICAgICAgICAgIC4NCj4g
PiArIyAgICAgICAuICAgICAgICAgICAgICAgICAgICAuKyAgICAgICAgICtgICAgICAgICAgICAg
ICAgICAgICAgICAuDQo+ID4gKyMgICAgICAgLiAgICAgICAgICAgICAgICAgIC4tICsgICAgICAg
fCBgLyAgICAgICAgICAgICAgICAgICAgICAgLg0KPiA+ICsjICAgICAgIC4gICAgICAgICAgICAg
ICAuLiIgICArICAgICAgICAgIC46ICAgICAgICAgICAgICAgICAgICAgIC4NCj4gPiArIyAgICAg
ICAuICAgICAgICAgICAgIC0iICAgICAgKyAgICAgICAgICAgLS0gICAgICAgICAgICAgICAgICAg
ICAuDQo+ID4gKyMgICAgICAgLiAgICAoMikgIC4uLiIgICAgICAgICsgICAgICAgfCAgICA6LSAg
ICAgICAgICAgICAgICAgICAgLg0KPiA+ICsjICAgICAgIC4gICAgLi4uIiIgICAgICAgICAgICAr
ICAgICAgICAgICAgIC06ICAgICAgICAgICAgICAgICAgIC4NCj4gPiArIyAoMyktIC0uLS4iIi0g
LSAtIC0gLSsrKysrKysrKyAtIC0gLSAtIC0gLSAtLjotIC0gLSAtIC0gLSAtIC0gLQ0KPiA+IC4t
IC0gKDYpDQo+ID4gKyMgICAgICAgLiAgICAgICAgICAgICArICAgICAgICAgICAgICAgICAgICAg
ICBgOi4gICAgICAgICAgICAgICAgLg0KPiA+ICsjICAgICAgIC4gICAgICAgICAgICAgKyAgICAg
ICAgICAgICAgIHwgICAgICAgICAtOiAgICAgICAgICAgICAgIC4NCj4gPiArIyAgICAgICAuICAg
ICAgICAgICAgICsgICAgICAgICAgICAgICAgICAgICAgICAgICAtOiAgICAgICAgICAgICAuDQo+
ID4gKyMgICAgICAgLiAgICAgICAgICAgICArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAu
LiAgICAgICAgICAgLg0KPiA+ICsjICAgICAgIC4gICAoMSkgICAgICAgKyAgICAgICAgICAgICAg
IHwgICAgICAgICAgICAgICAiKysrLSAtIC0NCj4gPiAtLi0gLSAoNykNCj4gPiArIyAgICAgICAt
KysrKysrKysrKysrKystIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gLSAtIC0gKyAtIC0gLQ0K
PiA+IC4tIC0gKDgpDQo+ID4gKyMgICAgICAgLiAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICsgICAgICAgLQ0KPiA+ICsjICAgICAgIC0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiArKysrKysrKystLT4NCj4g
PiArIyAgICAgICB8ICAgICAgICAgICAgIHwgICAgICAgfCAgIENDICAgfCAgICAgIENWICAgICAg
ICAgfA0KPiA+ICsjICAgICAgIHwgLS10cmlja2xlLS0gfCAtcHJlLSB8IC0tLS0tLS0tLWZhc3Qt
LS0tLS0tLS0tLSB8DQo+ID4gKyMNCj4gPiArIyAgIFRoZSBjaGFyZ2VyIHVzZXMgdGhlIGZvbGxv
d2luZyBiYXR0ZXJ5IHByb3BlcnRpZXMNCj4gPiArIyAtIHRyaWNrbGUtY2hhcmdlLWN1cnJlbnQt
bWljcm9hbXA6DQo+ID4gKyMgICAgIEN1cnJlbnQgdXNlZCBhdCB0cmlja2xlLWNoYXJnZSBwaGFz
ZSAoOCBpbiBhYm92ZSBjaGFydCkNCj4gPiArIyAgICAgbWluaW11bTogNjQwMDANCj4gPiArIyAg
ICAgbWF4aW11bTogMTAyNDAwMA0KPiA+ICsjICAgICBtdWx0aXBsZU9mOiA2NDAwMA0KPiANCj4g
V2h5IGlzIGFsbCBvZiB0aGlzIGNvbW1lbnRlZCBvdXQgc3RpbGw/DQoNCkJlY2F1c2UgdGhlc2Ug
d2lsbCBub3QgbGl2ZSBpbiBjaGFyZ2VyIG5vZGUgb3IgZGVzY3JpYmUgdGhlIGNoYXJnZXIuDQpU
aGVzZSBhcmUgdGhlIGJhdHRlcnkgcHJvcGVydGllcy4gVXNlZCBpbiBiYXR0ZXJ5IG5vZGUgaWYg
c3RhdGljDQpiYXR0ZXJ5IG5vZGUgaXMgdXNlZCBpbnN0ZWFkIG9mIGZldGNoaW5nIHRoZSBpbmZv
cm1hdGlvbiBmcm9tIHNtYXJ0DQpiYXR0ZXJ5LiBFZywgdGhlc2UgYXJlIGRvY3VtZW50ZWQgaW4g
YmF0dGVyeS50eHQgU28gdGhpcyBpcyBub3QNCnJlbGV2YW50IHJlZ2FyZGluZyBkZXNjcmliaW5n
IHRoZSBjaGFyZ2VyIC0gYnV0IHRoZXNlIGFyZSB2ZXJ5IHJlbGV2YW50DQpmb3Igb25lIHdobyBj
b21wb3NlcyBEVCBmb3IgYmF0dGVyeSBhbmQgY2hhcmdlci4gU28gSSBqdXN0IHdhbnRlZCB0bw0K
c29tZWhvdyBkb2N1bWVudCB0aGUgYmF0dGVyeSBiaW5kaW5ncyB3aGljaCB0aGlzIGNoYXJnZXIg
b2JleXMuDQoNCkVnLiBUaGVzZSBjb21tZW50ZWQgb3V0IHByb3BlcnRpZXMgYXJlIHVzZWQgZnJv
bSBiYXR0ZXJ5IG5vZGUgd2hpY2ggaXMNCnJlZmVyZW5jZWQgYnkgbW9uaXRvcmVkLWJhdHRlcnkg
cHJvcGVydHkuIChJIGFsbW9zdCBoZWFyIHlvdSB0ZWxsaW5nIG1lDQp0aGF0IHdoZXRoZXIgdGhl
c2UgcHJvcGVydGllcyBhcmUgdXNlZCBieSBjaGFyZ2VyIGRyaXZlciBvciBub3QgaXMNCnNvZnR3
YXJlIGJlaGF2aW91ciBhbmQgc2hvdWxkIG5vdCBiZSBpbiBIVyBkZXNjcmlwdGlvbiAtIHdoaWNo
IGlzIHRydWUNCi0gYnV0IGFzIEkgc2FpZCwgdGhpcyBpcyB2ZXJ5IHJlbGV2YW50IGZvciBvbmUg
d2hvIGNvbXBvc2VzIERUIC0gYW5kDQp0aGlzIG9uZSB3aWxsIGhvcGVmdWxseSBiZSByZWFkaW5n
IHRoZSBiaW5kaW5nIGRvY3MuIEhlbmNlIGNvbW1lbnQNCmJsb2NrIG5vdCAicHJvcGVyIiBkZXNj
cmlwdGlvbikuDQoNCj4gDQo+ID4gKyMgLSBwcmVjaGFyZ2UtY3VycmVudC1taWNyb2FtcDoNCj4g
PiArIyAgICAgQ3VycmVudCB1c2VkIGF0IHByZS1jaGFyZ2UgcGhhc2UgKDYgaW4gYWJvdmUgY2hh
cnQpDQo+ID4gKyMgICAgIG1pbmltdW06IDY0MDAwDQo+ID4gKyMgICAgIG1heGltdW06IDEwMjQw
MDANCj4gPiArIyAgICAgbXVsdGlwbGVPZjogNjQwMDANCj4gPiArIyAtIGNvbnN0YW50LWNoYXJn
ZS1jdXJyZW50LW1heC1taWNyb2FtcA0KPiA+ICsjICAgICBDdXJyZW50IHVzZWQgYXQgZmFzdCBj
aGFyZ2UgY29uc3RhbnQgY3VycmVudCBwaGFzZSAoNSBpbg0KPiA+IGFib3ZlIGNoYXJ0KQ0KPiA+
ICsjICAgICBtaW5pbXVtOiA2NDAwMA0KPiA+ICsjICAgICBtYXhpbXVtOiAxMDI0MDAwDQo+ID4g
KyMgICAgIG11bHRpcGxlT2Y6IDY0MDAwDQo+ID4gKyMgLSBjb25zdGFudC1jaGFyZ2Utdm9sdGFn
ZS1tYXgtbWljcm92b2x0DQo+ID4gKyMgICAgIFRoZSBjb25zdGFudCB2b2x0YWdlIHVzZWQgaW4g
ZmFzdCBjaGFyZ2luZyBwaGFzZSAoNCBpbiBhYm92ZQ0KPiA+IGNoYXJ0KQ0KPiA+ICsjICAgICBt
aW5pbXVtOiAyNTYwMDAwDQo+ID4gKyMgICAgIG1heGltdW06IDE5MjAwMDAwDQo+ID4gKyMgICAg
IG11bHRpcGxlT2Y6IDE2MDAwDQo+ID4gKyMgLSBwcmVjaGFyZ2UtdXBwZXItbGltaXQtbWljcm92
b2x0DQo+ID4gKyMgICAgIGNoYXJnaW5nIG1vZGUgaXMgY2hhbmdlZCBmcm9tIHRyaWNrbGUgY2hh
cmdpbmcgdG8gcHJlLQ0KPiA+IGNoYXJnaW5nDQo+ID4gKyMgICAgIHdoZW4gYmF0dGVyeSB2b2x0
YWdlIGV4Y2VlZHMgdGhpcyBsaW1pdCB2b2x0YWdlICgzIGluIGFib3ZlDQo+ID4gY2hhcnQpDQo+
ID4gKyMgICAgIG1pbmltdW06IDIwNDgwMDANCj4gPiArIyAgICAgbWF4aW11bTogMTkyMDAwMDAN
Cj4gPiArIyAgICAgbXVsdGlwbGVPZjogNjQwMDANCj4gPiArIyAtIHJlLWNoYXJnZS12b2x0YWdl
LW1pY3Jvdm9sdA0KPiA+ICsjICAgICBtaW5pbXVtOiAyNTYwMDAwDQo+ID4gKyMgICAgIG1heGlt
dW06IDE5MjAwMDAwDQo+ID4gKyMgICAgIG11bHRpcGxlT2Y6IDE2MDAwDQo+ID4gKyMgICAgIHJl
LWNoYXJnaW5nIGlzIGF1dG9tYXRpY2FsbHkgc3RhcnRlZCB3aGVuIGJhdHRyeSBoYXMgYmVlbg0K
PiA+IGRpc2NoYXJnaW5nDQo+ID4gKyMgICAgIHRvIHRoZSBwb2ludCB3aGVyZSB0aGUgYmF0dGVy
eSB2b2x0YWdlIGRyb3BzIGJlbG93IHRoaXMNCj4gPiBsaW1pdA0KPiA+ICsjIC0gb3Zlci12b2x0
YWdlLXRocmVzaG9sZC1taWNyb3ZvbHQNCj4gPiArIyAgICAgYmF0dGVyeSBpcyBleHBlY3RlZCB0
byBiZSBmYXVsdHkgaWYgYmF0dGVyeSB2b2x0YWdlIGV4Y2VlZHMNCj4gPiB0aGlzIGxpbWl0Lg0K
PiA+ICsjICAgICBDaGFyZ2VyIHdpbGwgdGhlbiBlbnRlciB0byBhICJiYXR0ZXJ5IGZhdWx0eSIg
LXN0YXRlDQo+ID4gKyMgICAgIG1pbmltdW06IDI1NjAwMDANCj4gPiArIyAgICAgbWF4aW11bTog
MTkyMDAwMDANCj4gPiArIyAgICAgbXVsdGlwbGVPZjogMTYwMDANCj4gPiArIyAtIGNoYXJnZS10
ZXJtLWN1cnJlbnQtbWljcm9hbXANCj4gPiArIyAgICAgbWluaW11bTogMA0KPiA+ICsjICAgICBt
YXhpbXVtOiAxMDI0MDAwDQo+ID4gKyMgICAgIG11bHRpcGxlT2Y6IDY0MDAwDQo+ID4gKyMgICAg
IGEgY2hhcmdlIGN5Y2xlIHRlcm1pbmF0ZXMgd2hlbiB0aGUgYmF0dGVyeSB2b2x0YWdlIGlzIGFi
b3ZlDQo+ID4gcmVjaGFyZ2UNCj4gPiArIyAgICAgdGhyZXNob2xkLCBhbmQgdGhlIGN1cnJlbnQg
aXMgYmVsb3cgdGhpcyBzZXR0aW5nICg3IGluIGFib3ZlDQo+ID4gY2hhcnQpDQo+ID4gKyMgICBT
ZWUgYWxzbw0KPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBw
bHkvYmF0dGVyeS50eHQNCj4gPiArDQo+ID4gKyAgbW9uaXRvcmVkLWJhdHRlcnk6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgcGhhbmRsZSBvZiBiYXR0ZXJ5IGNoYXJhY3Rlcmlz
dGljcyBkZXZpY2V0cmVlIG5vZGUNCj4gPiArDQo+ID4gKyAgcm9obSx2c3lzLXJlZ3VsYXRpb24t
bWljcm92b2x0Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IHN5c3RlbSBzcGVjaWZpYyBsb3dlciBs
aW1pdCBmb3Igc3lzdGVtIHZvbHRhZ2UuDQo+ID4gKyAgICBtaW5pbXVtOiAyNTYwMDAwDQo+ID4g
KyAgICBtYXhpbXVtOiAxOTIwMDAwMA0KPiA+ICsgICAgbXVsdGlwbGVPZjogNjQwMDANCj4gPiAr
DQo+ID4gKyAgcm9obSx2YnVzLWlucHV0LWN1cnJlbnQtbGltaXQtbWljcm9hbXA6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjogc3lzdGVtIHNwZWNpZmljIFZCVVMgaW5wdXQgY3VycmVudCBsaW1pdCAo
aW4NCj4gPiBtaWNyb2FtcHMpLg0KPiA+ICsgICAgbWluaW11bTogMzIwMDANCj4gPiArICAgIG1h
eGltdW06IDE2MzUyMDAwDQo+ID4gKyAgICBtdWx0aXBsZU9mOiAzMjAwMA0KPiA+ICsNCj4gPiAr
ICByb2htLHZjYy1pbnB1dC1jdXJyZW50LWxpbWl0LW1pY3JvYW1wOg0KPiA+ICsgICAgZGVzY3Jp
cHRpb246IHN5c3RlbSBzcGVjaWZpYyBWQ0MvVkFDUCBpbnB1dCBjdXJyZW50IGxpbWl0IChpbg0K
PiA+IG1pY3JvYW1wcykuDQo+ID4gKyAgICBtaW5pbXVtOiAzMjAwMA0KPiA+ICsgICAgbWF4aW11
bTogMTYzNTIwMDANCj4gPiArICAgIG11bHRpcGxlT2Y6IDMyMDAwDQo+ID4gKw0KPiA+ICtyZXF1
aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsg
IC0gfA0KPiA+ICsgICAgaTJjIHsNCj4gPiArICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsN
Cj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgICBjaGFyZ2VyQDkg
ew0KPiA+ICsgICAgICAgICAgICBjb21wYXRpYmxlID0gInJvaG0sYmQ5OTk1eC1jaGFyZ2VyIjsN
Cj4gPiArICAgICAgICAgICAgbW9uaXRvcmVkLWJhdHRlcnkgPSA8JmJhdHRlcnk+Ow0KPiA+ICsg
ICAgICAgICAgICByZWcgPSA8MHg5PjsNCj4gPiArICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVu
dCA9IDwmZ3BpbzE+Ow0KPiA+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDI5IDg+Ow0KPiA+
ICsgICAgICAgICAgICByb2htLHZzeXMtcmVndWxhdGlvbi1taWNyb3ZvbHQgPSA8ODk2MDAwMD47
DQo+ID4gKyAgICAgICAgICAgIHJvaG0sdmJ1cy1pbnB1dC1jdXJyZW50LWxpbWl0LW1pY3JvYW1w
ID0gPDE0NzIwMDA+Ow0KPiA+ICsgICAgICAgICAgICByb2htLHZjYy1pbnB1dC1jdXJyZW50LWxp
bWl0LW1pY3JvYW1wID0gPDE0NzIwMDA+Ow0KPiA+ICsgICAgICAgIH07DQo+ID4gKyAgICB9Ow0K
PiA+IC0tIA0KPiA+IDIuMjEuMA0KPiA+IA0KPiA+IA0KPiA+IC0tIA0KPiA+IE1hdHRpIFZhaXR0
aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNCj4gPiBST0hNIFNlbWljb25kdWN0b3JzLCBGaW5s
YW5kIFNXREMNCj4gPiBLaXZpaGFyanVubGVua2tpIDFFDQo+ID4gOTAyMjAgT1VMVQ0KPiA+IEZJ
TkxBTkQNCj4gPiANCj4gPiB+fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJlbmUgRGVzY2Fy
dGVzLiBKdXN0IHRoZW4gaGUgdmFuaXNoZWQNCj4gPiB+fn4NCj4gPiBTaW1vbiBzYXlzIC0gaW4g
TGF0aW4gcGxlYXNlLg0KPiA+IH5+fiAibm9uIGNvZ2l0byBtZSIgZGl4aXQgUmVuZSBEZXNjYXJ0
ZSwgZGVpbmRlIGV2YW5lc2Nhdml0IH5+fg0KPiA+IFRoYW5rcyB0byBTaW1vbiBHbGFzcyBmb3Ig
dGhlIHRyYW5zbGF0aW9uID1dIA0KDQo=
