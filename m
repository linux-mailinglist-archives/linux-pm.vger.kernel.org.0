Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AB781678CD
	for <lists+linux-pm@lfdr.de>; Fri, 21 Feb 2020 09:52:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgBUIwh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Feb 2020 03:52:37 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:61440 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726930AbgBUIwg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Feb 2020 03:52:36 -0500
X-AuditID: c0a8fbf4-473ff70000004419-f9-5e4f9a52c61a
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id B6.69.17433.25A9F4E5; Fri, 21 Feb 2020 09:52:34 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Fri, 21 Feb 2020 09:52:30 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
Thread-Topic: [RFC PATCH v2 2/5] dt_bindings: ROHM BD99954 Charger
Thread-Index: AQHV4wmFTXdRcLHQD0CUbuLOwEiFn6ghWyIAgADEoQCAAl8sgIAA0r4A
Date:   Fri, 21 Feb 2020 08:52:29 +0000
Message-ID: <caa199d4ba76b210d7d0f0b6881d9a32cf2ca3a9.camel@fi.rohmeurope.com>
References: <cover.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <104b5ef63c2ad4771503d9e6618bf427721042c3.1581597365.git.matti.vaittinen@fi.rohmeurope.com>
         <20200218202122.GA599@bogus>
         <1da3415507c216d09eb72c30ad915bc139d2ff3d.camel@fi.rohmeurope.com>
         <CAL_Jsq+x+5RCT0L5HGocdSOuve2qm5JvqSYXAwDbJ4qP9wr9TA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+x+5RCT0L5HGocdSOuve2qm5JvqSYXAwDbJ4qP9wr9TA@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1759D1CBF27F5942AB15CF08CA71111D@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsVyYMXvTbpBs/zjDK71mlpMffiEzWL+kXOs
        FlP+LGeyuLxrDpvF594jjBZLr19kspiz9ASLxf89O9gtTu8uceD0WDNvDaPHzll32T02repk
        87hzbQ+bx+dNcgGsUdw2SYklZcGZ6Xn6dgncGb9P7WYsOKVccWDCT+YGxitKXYycHBICJhJL
        Fr1g7GLk4hASuMoo0bZxOjuEc4JRYv2B90AOBwebgI1E1012kAYRAXWJhasfMoPUMAtMYpH4
        /OkuI0hCWMBRou16PytEkZPErkuXoGw3iV9vjoPZLAKqEpfWnwMbxCvgJ3F9yi1WiGUXmSTO
        /r/EBJLgFAiUmPblHhuIzSggK9HZ8A4sziwgLrHp2XdWiLMFJJbsOc8MYYtKvHz8DyquJLH3
        50MWkKOZBTQl1u/Sh2h1kDi6/yQbhK0oMaX7IdQNghInZz5hmcAoNgvJhlkI3bOQdM9C0j0L
        SfcCRtZVjBK5iZk56YklqYZ6RamlekX5GblAKjk/dxMjJH6/7GD8f8jzECMTB+MhRkkOJiVR
        XsU+/zghvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIrxqPH5xQrwpiZVVqUX5MClpDhYlcV71hxNj
        hQRAdmWnphakFsFkZTg4lCR4i2cCDRUsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgH
        JZD4YmAKAUnxAO09MQOonbe4IDEXKArReorRkGPCy7mLmDk2z10KJI+ASCGWvPy8VClx3gCQ
        fQIgDRmleXDrXjGKczAqCfPOBBnHA0zqcNNeAS1iAlr0XtgHZFFJIkJKqoExQd6W42tu7LWo
        LA3jqY9OtUbYlO3/53lzp4CCkeH1r8xbZzHfqbO5UjZzTXEjz6kkO9f/BWZblogtmlTqlzn5
        NN/covshq2VPXVra5sfN6XE7uNVV1OrMA4a02aKCM1qqpiy7pXL4a3FMSGyXSfvEfs3Jh1h3
        dz/UKEvY9bVi4dyLz/jk1moosRRnJBpqMRcVJwIAZdjgcqcDAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TW9ybmluZyBhZ2FpbiBSb2IsDQoNCk9uIFRodSwgMjAyMC0wMi0yMCBhdCAxNDoxOCAtMDYwMCwg
Um9iIEhlcnJpbmcgd3JvdGU6DQo+IE9uIFdlZCwgRmViIDE5LCAyMDIwIGF0IDI6MDUgQU0gVmFp
dHRpbmVuLCBNYXR0aQ0KPiA8TWF0dGkuVmFpdHRpbmVuQGZpLnJvaG1ldXJvcGUuY29tPiB3cm90
ZToNCj4gPiBNb3JuaW5nIFJvYiwNCj4gPiANCj4gPiBPbiBUdWUsIDIwMjAtMDItMTggYXQgMTQ6
MjEgLTA2MDAsIFJvYiBIZXJyaW5nIHdyb3RlOg0KPiA+ID4gT24gRnJpLCAxNCBGZWIgMjAyMCAw
OTozNjo0NyArMDIwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ID4gPiBUaGUgUk9ITSBC
RDk5OTU0IGlzIGEgQmF0dGVyeSBNYW5hZ2VtZW50IExTSSBmb3IgMS00IGNlbGwNCj4gPiA+ID4g
TGl0aGl1bS0NCj4gPiA+ID4gSW9uDQo+ID4gPiA+IHNlY29uZGFyeSBiYXR0ZXJ5LiBJbnRlbmRl
ZCB0byBiZSB1c2VkIGluIHNwYWNlLWNvbnN0cmFpbnQNCj4gPiA+ID4gZXF1aXBtZW50IHN1Y2gN
Cj4gPiA+ID4gYXMgTG93IHByb2ZpbGUgTm90ZWJvb2sgUEMsIFRhYmxldHMgYW5kIG90aGVyIGFw
cGxpY2F0aW9ucy4NCj4gPiA+ID4gQkQ5OTk1NA0KPiA+ID4gPiBwcm92aWRlcyBhIER1YWwtc291
cmNlIEJhdHRlcnkgQ2hhcmdlciwgdHdvIHBvcnQgQkMxLjINCj4gPiA+ID4gZGV0ZWN0aW9uDQo+
ID4gPiA+IGFuZCBhDQo+ID4gPiA+IEJhdHRlcnkgTW9uaXRvci4NCj4gPiA+ID4gDQo+ID4gPiA+
IERvY3VtZW50IHRoZSBEVCBiaW5kaW5ncyBmb3IgQkQ5OTk1NA0KPiA+ID4gPiANCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogTWF0dGkgVmFpdHRpbmVuIDwNCj4gPiA+ID4gbWF0dGkudmFpdHRpbmVu
QGZpLnJvaG1ldXJvcGUuY29tPg0KPiA+ID4gPiAtLS0NCj4gPiA+ID4gDQo+ID4gSXQgYWxzbyBs
b29rcyBsaWtlIHRoZSAnY29yZSBiaW5kaW5ncycgbGlrZSByZWd1bGF0b3JzIHVzZQ0KPiA+IHNp
bmd1bGFyLg0KPiA+IEhlbmNlIEknbGwgbGVhdmUgdGhpcyB0byBzaW5ndWxhciBmb3IgdjMgZXZl
biB0aG91Z2ggaXQgZmFpbHMgdGhlDQo+ID4gdmFsaWRhdGlvbiAtIHBsZWFzZSBsZXQgbWUga25v
dyBpZiB0aGlzIHdhcyB3cm9uZyBjaG9pY2Ugb3IgaWYgeW91DQo+ID4gc3BvdA0KPiA+IGFueSBv
dGhlciBvZGRpdGllcyB0aGVyZS4gSSBjYW4ndCBzZWUgd2hhdCBlbHNlIGl0IGNvdWxkIGJlIGJ1
dCBmb3INCj4gPiBzb21lIHJlYXNvbiBJIHN0aWxsIGZpbmQgdGhpcyB5YW1sIHRlcnJpYmx5IGhh
cmQgOigNCj4gPiANCj4gPiBIbW0uLiBJIHdvbmRlciBpZiBJIGhhdmUgc29tZSBvbGQgY2hlY2tl
ciB0b29scyBpbnN0YWxsZWQgYW5kIHVzZWQNCj4gPiBvbg0KPiA+IG15IFBDPyBJIGFsc28gZ2V0
IHZhbGlkYXRpb24gZmFpbHVyZXMgZm9yIHRoZSBleGFtcGxlIHNjaGVtYXMgOi8NCj4gDQo+IFlv
dSBkbyBoYXZlIHRvIHN0YXkgdXAgdG8gZGF0ZS4NCg0KVWguIFNvIGl0IHNlZW1zLg0KSSB1cGRh
dGVkIHRoZSBtdWx0aXBsZU9mIHdhcyByZWNvZ25pemVkIG5vdy4gSSBhbHNvIGdvdCBuaWNlIHdh
cm5pbmcNCmFib3V0IG1pc3NpbmcgI3NpemUtY2VsbHMgYW5kICNhZGRyZXNzLWNlbGxzIGZvciB0
aGUgaTJjIGJ1cy4gSXQga2luZA0Kb2YgaXMgb3V0IG9mIHRoZSBzY29wZSBvZiB0aGUgY2hhcmdl
ciBiaW5kaW5nICh3aGljaCBzaG91bGQganVzdCBzaXQgaW4NCnRoZSBidXMpIGJ1dCB0aGUgd2Fy
bmluZyB3YXMgY2xlYXIgZW5vdWdoIHNvIEkgdW5kZXJzdG9vZCB3aGF0IGl0IHdhcw0KYWJvdXQu
IE5pY2Ugam9iLCB0aGFua3MuDQoNCkkganVzdCB3b25kZXIgaWYgaXQgd291bGQgYmUgYmlnIHRh
c2sgdG8gYWRkIHZlcnNpb24gcXVlcnkgKGxpa2UgZHQtDQpkb2MtdmFsaWRhdGUgLS12ZXJzaW9u
KSB0byB0aGUgdG9vbGluZ3MgYW5kIGluY2x1ZGUgInJlcXVpcmVkIHZlcnNpb24iDQppbiBrZXJu
ZWwgbWFrZWZpbGVzIHNvIHRoYXQgdGhlICdkdF9iaW5kaW5nX2NoZWNrJyBtYWtlIHRhcmdldCBj
b3VsZA0Kd2FybiBpZiBvbmUgdXNlcyB0b28gb2xkIHZlcnNpb24/IChJZ25vcmFudCBjLWNvZGVy
cyBsaWtlIG1lIG1heSBub3QNCmtub3cgdGhlIGR0LXNjaGVtYSB0b29saW5nIGlzIG5vdCBpbmNs
dWRlZCBpbiBrZXJuZWwgc2NyaXB0cyBhbmQgbmVlZHMNCnRvIGJlIHVwZGF0ZWQgb24gaG9zdCBQ
Qy4pIEp1c3QgYSBzdWdnZXN0aW9uIHdoaWNoIG1pZ2h0IHJlZHVjZSBlcnJvcnMNCmJlZm9yZSBw
YXRjaCBzdWJtaXNzaW9ucy4NCg0KPiA+ID4gd2FybmluZzogbm8gc2NoZW1hIGZvdW5kIGluIGZp
bGU6DQo+ID4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvc3VwcGx5
L3JvaG0sYmQ5OTk1eC55YW1sDQo+ID4gPiAvYnVpbGRzL3JvYmhlcnJpbmcvbGludXgtZHQtDQo+
ID4gPiByZXZpZXcvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bvd2VyL3N1cHBs
eS9yb2htLGJkOTk5NQ0KPiA+ID4geC55YQ0KPiA+ID4gbWw6IGlnbm9yaW5nLCBlcnJvciBwYXJz
aW5nIGZpbGUNCj4gPiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5
L3NpbXBsZS0NCj4gPiA+IGZyYW1lYnVmZmVyLmV4YW1wbGUuZHRzOjIxLjE2LTM3LjExOiBXYXJu
aW5nDQo+ID4gPiAoY2hvc2VuX25vZGVfaXNfcm9vdCk6DQo+ID4gPiAvZXhhbXBsZS0wL2Nob3Nl
bjogY2hvc2VuIG5vZGUgbXVzdCBiZSBhdCByb290IG5vZGUNCj4gPiA+IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9zdXBwbHkvcm9obSxiZDk5OTV4LnlhbWw6DQo+ID4g
PiAgIHdoDQo+ID4gPiBpbGUgc2Nhbm5pbmcgYSBzaW1wbGUga2V5DQo+ID4gPiAgIGluICI8dW5p
Y29kZSBzdHJpbmc+IiwgbGluZSAyOSwgY29sdW1uIDMNCj4gPiA+IGNvdWxkIG5vdCBmaW5kIGV4
cGVjdGVkICc6Jw0KPiA+ID4gICBpbiAiPHVuaWNvZGUgc3RyaW5nPiIsIGxpbmUgMzAsIGNvbHVt
biAxDQo+IA0KPiBUaG91Z2ggdGhpcyBpcyBqdXN0IGluY29ycmVjdCBZQU1MIGFuZCB0aGUgdG9v
bCB2ZXJzaW9uIHNob3VsZG4ndA0KPiBtYXR0ZXIuDQoNClllcy4gVGhhdCBzaG91bGQgYmUgZml4
ZWQgbm93LiBBbmQgdjQgd2lsbCBhbHNvIGhhdmUgdGhlIG11bHRpcGxlT2YNCnVuY29tbWVudGVk
IGFuZCAjc2l6ZS1jZWxscyBhbmQgI2FkZHJlc3MtY2VsbHMgZm9yIHRoZSBpMmMgYnVzIGFkZGVk
Lg0KSSdsbCB3YWl0IGZvciBhIHdoaWxlIGZvciBvdGhlcnMgdG8gZ2l2ZSBmZWVkYmFjayBmcm9t
IHRoZSBzZXJpZXMNCmJlZm9yZSBzZW5kaW5nIGl0IG91dCB0aG91Z2guIFRoYW5rcyBmb3IgdGhl
IGhlbHAhDQoNCi0tTWF0dGkNCg0K
