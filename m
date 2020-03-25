Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00DAE192593
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 11:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgCYK3p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 06:29:45 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:47664 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgCYK3o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 06:29:44 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Mar 2020 06:29:43 EDT
X-AuditID: c0a8fbf4-473ff70000004419-ec-5e7b2f11fcf7
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id E5.71.17433.11F2B7E5; Wed, 25 Mar 2020 11:14:41 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Wed, 25 Mar 2020 11:14:35 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davidgow@google.com" <davidgow@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "yamada.masahiro@socionext.com" <yamada.masahiro@socionext.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "bp@suse.de" <bp@suse.de>,
        "mhiramat@kernel.org" <mhiramat@kernel.org>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "uwe@kleine-koenig.org" <uwe@kleine-koenig.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Thread-Topic: [PATCH v6 09/10] power: supply: Support ROHM bd99954 charger
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAARjYCAABHKgIABdcUA
Date:   Wed, 25 Mar 2020 10:14:35 +0000
Message-ID: <f3490f4e7900e463540330665ecf99737070fedd.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
         <03f7053576e60632d7ac3bc074afe5d8d63e3714.camel@fi.rohmeurope.com>
         <20200324115653.GI1922688@smile.fi.intel.com>
In-Reply-To: <20200324115653.GI1922688@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <95FE951F5583494DB6C37EDE94106DDA@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1AUVRzv7e7tPtCt5YC510WYV9poCNL0x6txir9qrdGJUWccZwJXWTkC
        7pi9PUX5I8KDySNHROnq5u5wjvg5BOedJSGnzHnVETMQlYBlCWEO0ASmFEM42C6bwl/72e/n
        13sz3wdJfRdjhAUWWZQsQpGJjqd6WxaDWxIyynK2Ln6eij2d7TQ+WeEi8MLcLMCnT23CQ6Nn
        SFw3fovGrrrvAPYMOigcOx+gcH10QIePN3TSuHo6BQ8OBhj8z48fEPjs/WYC/9DtofG9k1GA
        G0eGCOxpjFG4oXkjDoTmCfznDReFK8NRBoddTTrcf0nGH3nDDA4F60g8cvcnAoeXFigc/vUe
        wF//tQCy1vHtvnbAX2i9TvBfun9h+C96N/DngnY+1LKZb+iZIvhg2wmar23y6/gbwz00PzMw
        wPCxjxcpvsbfC3hfXzZ/xdvO8LddV4m3E/et2XZAkA/vKsi3ZLy6f405NvI7UdKhL20MOuhy
        cCfBCeIg4l5CQ61OQsV67hpAgfPPOUG8gmMALU34FQJCmtuGnNcZVZPEvYX+nRkFqobkfBBN
        9H2vU38e4yIUqg/5lpMSue2o5aZKqI43UXNVmNbw66jCESXVUIrbgH47VaaOWW4n+qzCQWrF
        /QR6v9IDVCKOewVdc9QtZwLuaXSifGYZk5wBBW/P67QbcOjTnkFSw8loamLp//l6dHG+g1K7
        SG4T6uzO0KxZaCz8M63h9ehs9TijnSEB9X1yi6oBBveqBveK273K7V7ldq9ynwO6NoCKhYKi
        fEEWM9Ml0Z4uWc3FyuegtTgItE2c6wIPItsjgIAgAp6EhCmZdaWV5egfP2DNO2oWbOZcyV4k
        2iIAQdKUxIbE0hw9myccPSZK1ofUU5AyGdjnx0+/o+fUrkJRLBGlh2wKhCbEOtTQBEnMF0sP
        FRTJKzQB49TweGOSTbTkiZJgl8256q7k2pRlUam1Sq8rXbGzthKhWJlq1m/BC7BmyusnYdTb
        6Cf1lMVqEY0GtmmLIuVUqdlueVQ0DQwQmBLZnSq7VnmOj3KmlQpCqch3H1ErZGGFMpYD4u8n
        Us58NXvhvcz7naPv7kmtv3wzraX2w2xMO3HyN9aUB8NtW4/vXrh05WDX4uE70osdkbnJSCDL
        V1X2bOueyavxtd69gns4jZRh4NiOqsqlyW5jqyG8TgqM7XvNko4KrdV5XalySUV2IbX/jWea
        +3MmzMa7u/4Yk+lZ5sjLHdBE2cxC5mZSsgn/AayVSkJLBAAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBUdWUsIDIwMjAtMDMtMjQgYXQgMTM6NTYgKzAyMDAsIGFuZHJpeS5zaGV2Y2hlbmtvQGxp
bnV4LmludGVsLmNvbQ0Kd3JvdGU6DQo+IE9uIFR1ZSwgTWFyIDI0LCAyMDIwIGF0IDEwOjUzOjA5
QU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTAzLTI0
IGF0IDExOjUwICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6DQo+ID4gPiBPbiBUdWUsIE1h
ciAyNCwgMjAyMCBhdCAxMDozMjoxOUFNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+
IA0KPiAuLi4NCj4gDQo+ID4gPiA+ICsJZm9yIChpID0gZmZzKHRtcCk7IGk7IGkgPSBmZnModG1w
KSkgew0KPiA+ID4gDQo+ID4gPiBOSUggb2YgZm9yX2VhY2hfc2V0X2JpdCgpLg0KPiA+IA0KPiA+
IFdoYXQgZG9lcyB0aGUgTklIIHN0YW5kIGZvcj8NCj4gDQo+IE5vdCBJbnZlbnRlZCBIZXJlIHN5
bmRyb21lIDotKQ0KDQpBaC4gSSBkZWZpbml0ZWx5IHBsZWFkIGd1aWx0eSBmb3IgdGhhdCBpbiBn
ZW5lcmFsLiBPciBldmVuIE5JQk0gKE5vdA0KSW52ZW50ZWQgQnkgTWUpIDpdIEJ1dCBhdCB0aGlz
IHRpbWUgZm9yX2VhY2hfc2V0X2JpdCgpIGp1c3QgZGlkbid0IGNvbWUNCnRvIG15IG1pbmQgLSBh
bmQgSSB1c2VkIGZmcygpIC0gZXZlbiB0aG91Z2ggdGhhdCdzIG5vdCBpbnZlbnRlZCBieSBtZQ0K
ZWl0aGVyIDspDQoNCkkganVzdCBtb2RpZmllZCB0aGUgZHJpdmVyIHRvIHVzZSBmb3JfZWFjaF9z
ZXRfYml0KCkgYW5kIHlvdSB3ZXJlDQpjb3JyZWN0LiBSZXN1bHQgaXMgX211Y2hfIHByZXR0aWVy
LiBUaGFua3MhIFRoYXQnbGwgYmUgZml4ZWQgaW4gdjcuDQoNCj4gLi4uDQo+IA0KPiA+ID4gPiAr
CWlmICghZGV2LT5wbGF0Zm9ybV9kYXRhKSB7DQo+ID4gPiANCj4gPiA+IGRldl9nZXRfcGxhdGRh
dGEoKQ0KPiA+ID4gDQo+ID4gPiA+ICsJCXJldCA9IGJkOTk5NXhfZndfcHJvYmUoYmQpOw0KPiA+
ID4gPiArCQlpZiAocmV0IDwgMCkgew0KPiA+ID4gPiArCQkJZGV2X2VycihkZXYsICJDYW5ub3Qg
cmVhZCBkZXZpY2UNCj4gPiA+ID4gcHJvcGVydGllcy5cbiIpOw0KPiA+ID4gPiArCQkJcmV0dXJu
IHJldDsNCj4gPiA+ID4gKwkJfQ0KPiA+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiA+ICsJCXJldHVy
biAtRU5PREVWOw0KPiA+ID4gDQo+ID4gPiBTbywgZXhpc3RpbmcgcGxhdGZvcm0gZGF0YSBsZWFk
cyB0byBhbiBlcnJvcj8hDQo+ID4gDQo+ID4gWWVzLiBBcyBjdXJyZW50bHkgd2Ugb25seSB1c2Ug
RFQuIElmIHNvbWVvbmUgbmVlZHMgcGxhdGRhdGEgdGhleQ0KPiA+IG5lZWQNCj4gPiB0byBpbXBy
b3ZlIHRoZSBkcml2ZXINCj4gDQo+IEkgdGhpbmsgdGhlIGlkZWEgdG8gYXZvaWQgcGxhdGZvcm0g
ZGF0YSBpbiBuZXcgY29kZSBhcyBtdWNoIGFzDQo+IHBvc3NpYmxlLg0KPiBBbmQgaXQncyB1bnVz
dWFsIHRvIGhhdmUgc29tZWJvZHkgdG8gdXNlIHRoaXMgZHJpdmVyIHdpdGgNCj4gcGxhdGZvcm1f
ZGF0YSBzZXQuDQo+IFdoeSBub3Qgc2ltcGxlIGlnbm9yZSBpdD8NCg0KQmVjYXVzZSBpZiBzb21l
b25lIF9pc18gdXNpbmcgcGxhdGZvcm0gZGF0YSBoZXJlIChhbmQgd2Ugc3RpbGwgcHJvdmlkZQ0K
dGhpcyBtZWNoYW5pc20pIC0gdGhlbiB3ZSBzaG91bGQgaW5mb3JtIGhpbSB0aGF0IGhlJ3MgZG9p
bmcgc29tZXRoaW5nDQp3aGljaCBpcyBub3QgY29ycmVjdC4NCg0KQmVzdCBSZWdhcmRzDQoJTWF0
dGkNCg==
