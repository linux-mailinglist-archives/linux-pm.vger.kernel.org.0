Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 304311657DD
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 07:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgBTGjx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 01:39:53 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:51500 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbgBTGjx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 01:39:53 -0500
X-AuditID: c0a8fbf4-489ff70000004419-88-5e4e29b700e4
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 7F.B4.17433.7B92E4E5; Thu, 20 Feb 2020 07:39:51 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Thu, 20 Feb 2020 07:39:47 +0100
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
Subject: Re: [RFC PATCH v2 1/5] dt-bindings: battry: add new battery
 parameters
Thread-Topic: [RFC PATCH v2 1/5] dt-bindings: battry: add new battery
 parameters
Thread-Index: AQHV4wiVRSTh4ChKOkWsr1/4uJRaLagi5sCAgACzfQA=
Date:   Thu, 20 Feb 2020 06:39:46 +0000
Message-ID: <58877fefa9e4792779284575e9f0aa561d646c2e.camel@fi.rohmeurope.com>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <205c01fe0555fe89226521a89a5b20933578780d.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <20200219195719.GA3096@bogus>
In-Reply-To: <20200219195719.GA3096@bogus>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <65D94085E6608940B9177ED7B24787B0@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42I5sOL3Jt3tmn5xBlOmilpMffiEzWL+kXOs
        FlP+LGeyuLxrDpvF594jjBZLr19kspiz9ASLxf89O9gtTu8uceD0WDNvDaPHzll32T02repk
        87hzbQ+bx+dNcgGsUdw2SYklZcGZ6Xn6dgncGTNefWUrOKdX0fvyKGsD4xbdLkZODgkBE4lF
        k0+xdjFycQgJXGWUWLp/ATuEc4JRorP5E5DDwcEmYCPRdZMdpEFEQF1i4eqHzCA1zAKTWCQa
        Vr5mA6kRFgiU6JlWCFETJNE3+TgzhG0l0b/1GhuIzSKgKnH5yDJGEJtXwE/i16lFULuOMEr8
        OPUAbAGngJbEu523wBoYBWQlOhveMYHYzALiEpuefWeFuFpAYsme88wQtqjEy8f/oOJKEnt/
        PmQBuYdZQFNi/S59iFYHiaMzP7FC2IoSU7ofskPcIChxcuYTlgmMYrOQbJiF0D0LSfcsJN2z
        kHQvYGRdxSiRm5iZk55YkmqoV5RaqleUn5ELpJLzczcxQqL3yw7G/4c8DzEycTAeYpTkYFIS
        5Z0h4hcnxJeUn1KZkVicEV9UmpNafIhRgoNZSYRXjQcox5uSWFmVWpQPk5LmYFES51V/ODFW
        SABkV3ZqakFqEUxWhoNDSYJXUwOoUbAoNT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx6U
        PuKLgQkEJMUDtFdLFWRvcUFiLlAUovUUozbHhJdzFzFzHJm7dBGzEEtefl6qlDhvEsgmAZDS
        jNI8uEWvGMU5GJWEeSeAZHmAaRxuziugFUxAK94L+4CsKElESEk1MDrKfHpsGCusf/9W/MX3
        6U5zPDqCLp3Z1atY/3JR7MStm0tXmDs4XduRdaotku36//Lz2zdeSvimlfbwgzHPxjNn59cs
        S/xXvXG+4nWlD+v3nFWv1N2n9VGnbqqjh0OR0QqHaYE5DTGdblfl9nIfXqXWOu1cTcRthq5r
        5c0u+W9lN67K/dl367QSS3FGoqEWc1FxIgCVPDBWoAMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gUm9iLA0KDQpPbiBXZWQsIDIwMjAtMDItMTkgYXQgMTM6NTcgLTA2MDAsIFJvYiBIZXJy
aW5nIHdyb3RlOg0KPiBPbiBGcmksIEZlYiAxNCwgMjAyMCBhdCAwOTozMDowNUFNICswMjAwLCBN
YXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gQWRkOg0KPiA+IA0KPiA+ICAtIHRyaWNrbGVjaGFy
Z2UtY3VycmVudC1taWNyb2FtcDoNCj4gPiANCj4gPiBTb21lIGNoYXJnZXJzIGhhdmUgMyBjaGFy
Z2luZyBzdGFnZXMuIEZpcnN0IG9uZSB3aGVuIGJhdHRlcnkgaXMNCj4gPiBhbG1vc3QNCj4gPiBl
bXB0eSBpcyBvZnRlbiBjYWxsZWQgYXMgdHJpY2tsZS1jaGFyZ2UuIExhc3Qgc3RhdGUgd2hlbiBi
YXR0ZXJ5DQo+ID4gaGFzIGJlZW4NCj4gPiAid29rZW4gdXAiIGlzIHVzdWFsbHkgY2FsbGVkIGFz
IGZhc3QtY2hhcmdlLiBJbiBhZGRpdGlvbiB0byB0aGlzDQo+ID4gc29tZQ0KPiA+IGNoYXJnZXJz
IGhhdmUgYSAnbWlkZGxlIHN0YXRlJyB3aGljaCBST0hNIEJEOTk5NTQgZGF0YS1zaGVldA0KPiA+
IGRlc2NyaWJlcyBhcw0KPiA+IHByZS1jaGFyZ2UuIFNvbWUgYmF0dGVyaWVzIGNhbiBiZW5lZml0
IGZyb20gdGhpcyAzLXBoYXNlIGNoYXJnaW5nDQo+ID4gW2NpdGF0aW9uIG5lZWRlZF0uDQo+IA0K
PiBGb3IgY2FyIGJhdHRlcmllcyBhdCBsZWFzdCwgdHJpY2tsZSBjaGFyZ2UgaXMgdG8ga2VlcCBi
YXR0ZXJ5IGZ1bGwuDQo+IEJ1dCANCj4gbWF5YmUgaW4gdGhhdCBjb250ZXh0LCBpdCB3b3VsZCBi
ZSAnY2hhcmdlLXRlcm0tY3VycmVudC1taWNyb2FtcCcuDQo+IA0KPiBJJ20ganVzdCBjb25jZXJu
ZWQgdGhhdCB3ZSBlbmQgdXAgd2l0aCBtdWx0aXBsZSBwcm9wZXJ0aWVzIHRoYXQgbWVhbg0KPiB0
aGUgDQo+IHNhbWUgdGhpbmcuIEkgdGhpbmsgeW91J3JlIG9rYXkgaGVyZS4NCg0KV2hpbGUgSSB3
YXMgZG9pbmcgdGhpcyBJIHRvb2sgYSBxdWljayBsb29rIGluIGZldyBvdGhlciBiaW5kaW5nIGRv
Y3MNCnVuZGVyIHBvd2VyL3N1cHBseS4gVW5mb3J0dW5hdGVseSBteSBrbm93bGVkZ2UgYWJvdXQg
YmF0dGVyaWVzIGFuZA0KY2hhcmdlcnMgaXMgcmVhbGx5IGxpbWl0ZWQgLSBidXQgSSBoYWQgYSBm
ZWVsaW5nIHRoYXQgd2UgYWxyZWFkeSBub3cNCmhhdmUgYnVuY2ggb2YgdmVuZG9yIHNwZWNpZmlj
IHByb3BlcnRpZXMgZm9yIHNhbWUgdGhpbmdzLiBTbyBJIGFjdHVhbGx5DQpob3BlIHRoYXQgYWRk
aW5nIGdlbmVyaWMgb25lcyB3aWxsIGRlY3JlYXNlIHRoZSBiaXJ0aCByYXRlIG9mIHZlbmRvcg0K
c3BlY2lmaWMgb25lcyA7KQ0KDQo+ID4gSW50cm9kdWNlIHRyaWNrbGVjaGFyZ2UtY3VycmVudC1t
aWNyb2FtcCBzbyB0aGF0IGJhdHRlcmllcyBjYW4gZ2l2ZQ0KPiA+IGNoYXJnaW5nIGN1cnJlbnQg
bGltaXQgZm9yIGFsbCB0aHJlZSBzdGF0ZXMuDQo+ID4gDQo+ID4gIC0gcHJlY2hhcmdlLXVwcGVy
LWxpbWl0LW1pY3Jvdm9sdDoNCj4gPiANCj4gPiBXaGVuIGJhdHRlcnkgdm9sdGFnZSBoYXMgcmVh
Y2hlZCBjZXJ0YWluIGxpbWl0IHdlIGNoYW5nZSBmcm9tDQo+ID4gdHJpY2tsZS1jaGFyZ2UgdG8g
bmV4dCBjaGFyZ2luZyBzdGF0ZSAocHJlLWNoYXJnZSBmb3IgQkQ5OTk1NCkuDQo+ID4gQWxsb3cN
Cj4gPiBiYXR0ZXJ5IHRvIHNwZWNpZnkgdGhpcyBsaW1pdC4NCj4gPiANCj4gPiAgLSByZS1jaGFy
Z2Utdm9sdGFnZS1taWNyb3ZvbHQ6DQo+ID4gDQo+ID4gQWxsb3cgZ2l2aW5nIGEgYmF0dGVyeSBz
cGVjaWZpYyB2b2x0YWdlIGxpbWl0IGZvciBjaGFyZ2VycyB3aGljaA0KPiA+IGNhbg0KPiA+IGF1
dG9tYXRpY2FsbHkgcmUtc3RhcnQgY2hhcmdpbmcgd2hlbiBiYXR0ZXJ5IGhhcyBkaXNjaGFyZ2hl
ZCBkb3duDQo+ID4gdG8NCj4gPiB0aGlzIGxpbWl0Lg0KPiA+IA0KPiA+IC0gb3Zlci12b2x0YWdl
LXRocmVzaG9sZC1taWNyb3ZvbHQNCj4gPiANCj4gPiBBbGxvdyBzcGVjaWZ5aW5nIHZvbHRhZ2Ug
dGhyZXNob2xkIGFmdGVyIHdoaWNoIHRoZSBiYXR0ZXJ5IGlzDQo+ID4gYXNzdW1lZCB0bw0KPiA+
IGJlIGZhdWx0eS4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYXR0aSBWYWl0dGluZW4gPG1h
dHRpLnZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4NCj4gPiAtLS0NCj4gPiAgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9iYXR0ZXJ5LnR4dCB8IDYNCj4g
PiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+
IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dl
ci9zdXBwbHkvYmF0dGVyeS50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wb3dlci9zdXBwbHkvYmF0dGVyeS50eHQNCj4gPiBpbmRleCA1YzkxM2Q0Y2YzNmMuLjdk
YTA0NDI3M2UwOCAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvcG93ZXIvc3VwcGx5L2JhdHRlcnkudHh0DQo+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBseS9iYXR0ZXJ5LnR4dA0KPiA+IEBAIC0xMSwx
NSArMTEsMjEgQEAgZGlmZmVyZW50IHR5cGUuIFRoaXMgcHJldmVudHMgdW5wcmVkaWN0YWJsZSwN
Cj4gPiBwb3RlbnRpYWxseSBoYXJtZnVsLA0KPiA+ICBiZWhhdmlvciBzaG91bGQgYSByZXBsYWNl
bWVudCB0aGF0IGNoYW5nZXMgdGhlIGJhdHRlcnkgdHlwZSBvY2N1cg0KPiA+ICB3aXRob3V0IGEg
Y29ycmVzcG9uZGluZyB1cGRhdGUgdG8gdGhlIGR0Yi4NCj4gPiAgDQo+ID4gK1BsZWFzZSBub3Rl
IHRoYXQgbm90IGFsbCBjaGFyZ2VyIGRyaXZlcnMgcmVzcGVjdCBhbGwgb2YgdGhlDQo+ID4gcHJv
cGVydGllcy4NCj4gPiArDQo+ID4gIFJlcXVpcmVkIFByb3BlcnRpZXM6DQo+ID4gICAtIGNvbXBh
dGlibGU6IE11c3QgYmUgInNpbXBsZS1iYXR0ZXJ5Ig0KPiA+ICANCj4gPiAgT3B0aW9uYWwgUHJv
cGVydGllczoNCj4gPiArIC0gb3Zlci12b2x0YWdlLXRocmVzaG9sZC1taWNyb3ZvbHQ6IGJhdHRl
cnkgb3Zlci12b2x0YWdlIGxpbWl0DQo+ID4gKyAtIHJlLWNoYXJnZS12b2x0YWdlLW1pY3Jvdm9s
dDogbGltaXQgdG8gYXV0b21hdGljYWxseSBzdGFydA0KPiA+IGNoYXJnaW5nIGFnYWluDQo+ID4g
ICAtIHZvbHRhZ2UtbWluLWRlc2lnbi1taWNyb3ZvbHQ6IGRyYWluZWQgYmF0dGVyeSB2b2x0YWdl
DQo+ID4gICAtIHZvbHRhZ2UtbWF4LWRlc2lnbi1taWNyb3ZvbHQ6IGZ1bGx5IGNoYXJnZWQgYmF0
dGVyeSB2b2x0YWdlDQo+ID4gICAtIGVuZXJneS1mdWxsLWRlc2lnbi1taWNyb3dhdHQtaG91cnM6
IGJhdHRlcnkgZGVzaWduIGVuZXJneQ0KPiA+ICAgLSBjaGFyZ2UtZnVsbC1kZXNpZ24tbWljcm9h
bXAtaG91cnM6IGJhdHRlcnkgZGVzaWduIGNhcGFjaXR5DQo+ID4gKyAtIHRyaWNrbGVjaGFyZ2Ut
Y3VycmVudC1taWNyb2FtcDogY3VycmVudCBmb3IgdHJpY2tsZS1jaGFyZ2UNCj4gPiBwaGFzZQ0K
PiANCj4gdHJpY2tsZS1jaGFyZ2UtLi4uDQoNCk9rLiBJJ2xsIGNoYW5nZSB0aGlzDQoNCj4gDQo+
ID4gICAtIHByZWNoYXJnZS1jdXJyZW50LW1pY3JvYW1wOiBjdXJyZW50IGZvciBwcmUtY2hhcmdl
IHBoYXNlDQo+ID4gKyAtIHByZWNoYXJnZS11cHBlci1saW1pdC1taWNyb3ZvbHQ6IGxpbWl0IHdo
ZW4gdG8gY2hhbmdlIHRvDQo+ID4gY29uc3RhbnQgY2hhcmdpbmcNCj4gPiAgIC0gY2hhcmdlLXRl
cm0tY3VycmVudC1taWNyb2FtcDogY3VycmVudCBmb3IgY2hhcmdlIHRlcm1pbmF0aW9uDQo+ID4g
cGhhc2UNCj4gPiAgIC0gY29uc3RhbnQtY2hhcmdlLWN1cnJlbnQtbWF4LW1pY3JvYW1wOiBtYXhp
bXVtIGNvbnN0YW50IGlucHV0DQo+ID4gY3VycmVudA0KPiA+ICAgLSBjb25zdGFudC1jaGFyZ2Ut
dm9sdGFnZS1tYXgtbWljcm92b2x0OiBtYXhpbXVtIGNvbnN0YW50IGlucHV0DQo+ID4gdm9sdGFn
ZQ0KPiA+IC0tIA0KPiA+IDIuMjEuMA0KPiA+IA0KPiA+IA0KPiA+IC0tIA0KPiA+IE1hdHRpIFZh
aXR0aW5lbiwgTGludXggZGV2aWNlIGRyaXZlcnMNCj4gPiBST0hNIFNlbWljb25kdWN0b3JzLCBG
aW5sYW5kIFNXREMNCj4gPiBLaXZpaGFyanVubGVua2tpIDFFDQo+ID4gOTAyMjAgT1VMVQ0KPiA+
IEZJTkxBTkQNCj4gPiANCj4gPiB+fn4gIkkgZG9uJ3QgdGhpbmsgc28sIiBzYWlkIFJlbmUgRGVz
Y2FydGVzLiBKdXN0IHRoZW4gaGUgdmFuaXNoZWQNCj4gPiB+fn4NCj4gPiBTaW1vbiBzYXlzIC0g
aW4gTGF0aW4gcGxlYXNlLg0KPiA+IH5+fiAibm9uIGNvZ2l0byBtZSIgZGl4aXQgUmVuZSBEZXNj
YXJ0ZSwgZGVpbmRlIGV2YW5lc2Nhdml0IH5+fg0KPiA+IFRoYW5rcyB0byBTaW1vbiBHbGFzcyBm
b3IgdGhlIHRyYW5zbGF0aW9uID1dIA0KDQo=
