Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84951192911
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 14:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbgCYNAb (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 09:00:31 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:51274 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCYNAb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 09:00:31 -0400
X-AuditID: c0a8fbf4-473ff70000004419-13-5e7b55ec4e15
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 9D.22.17433.CE55B7E5; Wed, 25 Mar 2020 14:00:28 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Wed, 25 Mar 2020 14:00:22 +0100
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
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAAMuoCAAaNYgIAACT8AgAAOHAA=
Date:   Wed, 25 Mar 2020 13:00:21 +0000
Message-ID: <d533c18dcd7b4d4ca453661b3f9495a840b3313b.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
         <20200324103557.GH1922688@smile.fi.intel.com>
         <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
         <20200325120956.GW1922688@smile.fi.intel.com>
In-Reply-To: <20200325120956.GW1922688@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8458127121B9DC4B8A7B83B56FAB4226@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wbZRjH995d7w62mlsp9l2HIl22Baab80fyahYz/cMcbjFsczHRCLvJ
        SZvBlVxbBacRt0loKxEcXaVCWcr4IWkstOgYtKzWSkBN6yayoTglI4sFh3FbhjCyecdtg7/u
        uef7/Tzf902el8Y1/ZSeNglWXhS4UgOZTkQ7bwUf+3v/4cLHxy5tQk0BP4lqj7gxNH/jH4Dq
        P8lF5y4ex5FrcopEbtdPADUljxFouKebQC3xhAodbQ2QyDmdhZLJbgrdHK3BUMNiB4Z+7m8i
        0fXaOEBtF85hqKltmECtHZtQd2gOQ1cn3AT6KBKnUMTdrkI/DFjRieYIhUJBF44uXPsVQ5Hb
        8wSKXLoO0NC/82BnNuv3+gHb+8U4xp7x/E6xX0c3sieDNjbUmce2hlMYG+yyk+yn7T4VOzEW
        JtnZRIJihz+7RbB1vihgvSN72LPNfoq94v4WK8h4bfWOg5z17X2mEmHbcwdWG/3xo1R5e06F
        L1KvqgJ9jzhAGg2Zp2Br6D+VA6TTGuYXALt6W+7+DAM4FR4nHYCmSWYHdIxTMqBldsGF2YtA
        9uCMl4aXR84vAauYGAFbQl5MdmUw+bDzD1mQiZdgR3WEVOqXof9aIyHXBLMR2n+0A7lWS317
        9TFKSV7E4J2Id8mUxjwLA8nBJRNgHoL2qtmlAJzRweCVOZVyBwaeCidxpc6Eqcu37/Zz4Om5
        Lwn5BjiTCwP92xR0J2ypcRBKnQMbnJOUcoa1cKRxiqgDOs+KBM8y7VlBe1bQnhX0SaDqArCM
        M5WWcFZ++1aRt20VzcYy6fOmuSwIlF280QfuxPJjAKNBDKyjMUOmOrTncKHmgYPm4kojZzEW
        ibZS3hIDkMYNWnWIryjUqIu5ynd50XxPWk8TBp1682T9GxpGzjrE8+W8eE/NomkDVDtfkYau
        FfkSvuItU6l1WcboNHl4ul5r4YViXuRsVmORvC1FFmldZGmNlPv+PglXW8q5MqmroN+DLXRd
        qtmH0/HmNh+uIQSzwOt16s/lJEa2Gm3C/aBpoKOBIUN9Vh60RnqQ9+dMSxGYFFHieUeOsHLL
        kr4KRD+cyTux5eH12q/CA9nZ1XZOwFKLtQszxxNObTg/pwdUOT94cTwvt/0mufCoVfWE++nM
        Iwc2DG42few/PzGU9WdBz0xP6sycftXrv32HvbeuczS98sm+idreQ42uUSHa9uDA7qn604GG
        /VcDib2eGteru/96IVk8+M0GNMSOFex6/hkDYTFy2/Nw0cL9D9Cl1mZNBAAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

V2VsbCwgR29vZCBtb3JuaW5nIEFuZHkgOikNCg0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDE0OjA5
ICswMjAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20NCndyb3RlOg0KPiBPbiBX
ZWQsIE1hciAyNSwgMjAyMCBhdCAxMTozNjo0NkFNICswMDAwLCBWYWl0dGluZW4sIE1hdHRpIHdy
b3RlOg0KPiA+IE9uIFR1ZSwgMjAyMC0wMy0yNCBhdCAxMjozNSArMDIwMCwgQW5keSBTaGV2Y2hl
bmtvIHdyb3RlOg0KPiA+ID4gT24gVHVlLCBNYXIgMjQsIDIwMjAgYXQgMTE6NTA6MjRBTSArMDIw
MCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+ID4gPiBPbiBUdWUsIE1hciAyNCwgMjAyMCBh
dCAxMDozMjoxOUFNICswMjAwLCBNYXR0aSBWYWl0dGluZW4NCj4gPiA+ID4gd3JvdGU6DQo+ID4g
PiA+ID4gKyNpbmNsdWRlIDxsaW51eC9hY3BpLmg+DQo+ID4gPiA+ID4gKyNpbmNsdWRlIDxsaW51
eC9vZi5oPg0KPiA+ID4gPiANCj4gPiA+ID4gSSBkaWRuJ3QgZmluZCBhbnkgZXZpZGVuY2Ugb2Yg
dXNlIG9mIHRob3NlIHR3bywgb3RoZXJ3aXNlLA0KPiA+ID4gPiBtaXNzZWQNCj4gPiA+ID4gcHJv
cGVydHkuaA0KPiA+ID4gPiBhbmQgcGVyaGFwcyBtb2RfZGV2aWNldGFibGUuaC4NCj4gDQo+IC4u
Lg0KPiANCj4gPiA+ID4gPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYmQ5OTk1eF9vZl9tYXRj
aCk7DQo+ID4gPiA+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUoYWNwaSwgYmQ5OTk1eF9hY3BpX21h
dGNoKTsNCj4gPiA+IA0KPiA+ID4gSSBoYXZlIHRvIGFkZCBzaW5jZSB5b3UgYXJlIHVzaW5nIHRo
b3NlIG1hY3JvcyB3aXRob3V0IGlmZGVmZmVyeSwNCj4gPiA+IHlvdQ0KPiA+ID4gc2hvdWxkDQo+
ID4gPiBnZXQgd2FybmluZyBpbiAhQUNQSSBhbmQvb3IgIU9GIGNhc2VzLg0KPiA+ID4gDQo+ID4g
PiBTbywgZHJvcCB0aG9zZSBvZl9tYXRjaF9wdHIoKSAvIEFDUElfUFRSKCkgYW5kIHRodXMgYWJv
dmUNCj4gPiA+IGhlYWRlcnMuDQo+ID4gDQo+ID4gU29ycnkgYnV0IEkgZG9uJ3QgZm9sbG93IDov
IEkgZGlkIGRyb3Agd2hvbGUgQUNQSSB0YWJsZSBhcyB0aGUNCj4gPiBiYXR0ZXJ5DQo+ID4gaW5m
b3JtYXRpb24gaXMgbm90IGZldGNoZWQgZnJvbSBBQ1BJIGFueXdheXMuDQo+IA0KPiBPa2F5LCBs
ZXQncyBmb3JnZXQgdGhlbiBhYm91dCBBQ1BJIGJpdHMuDQo+IA0KPiA+IEJ1dCBJIGRvbid0IGtu
b3cgd2hhdCB5b3UNCj4gPiBtZWFuIGJ5IGRyb3BwaW5nIHRoZSBvZl9tYXRjaF9wdHI/DQo+IA0K
PiBMaXRlcmFsbHkgZG8gbm90IHVzZSB0aGlzIG1hY3JvLiBPdGhlcndpc2UgeW91IG1ha2UgYSBk
ZXBlbmRlbmN5IHRvDQo+IE9GIHdoaWNoDQo+IHNob3VsZCBiZSB0aGVuIGluIHRoZSBLY29uZmln
IGxpa2UNCj4gDQo+IAlkZXBlbmQgb24gT0YgfHwgQ09NUElMRV9URVNUDQo+IA0KDQpIbW0uLi4g
V2h5IGlzIHRoYXQ/IEluIG9mLmggd2UgaGF2ZSAjaWZuZGVmIENPTkZJR19PRiBzZWN0aW9uIHdo
aWNoDQpkZWZpbmVzOg0KDQojZGVmaW5lIG9mX21hdGNoX3B0cihfcHRyKQlOVUxMDQoNClNvLCB0
aGlzIG1hY3JvIGlzIHdlbGwgZGVmaW5lZCBldmVuIGlmICFDT05GSUdfT0YsIHJpZ2h0Pw0KDQoN
Cj4gYnV0IGluIHRoaXMgY2FzZSB5b3Ugd2lsbCBnZXQgY29tcGlsZXIgd2FybmluZyB3aXRob3V0
IHVnbHkgaWZkZWZmZXJ5DQo+IGFyb3VuZA0KPiBPRiBJRCB0YWJsZSAoYXMgeW91IHBvaW50ZWQg
YmVsb3cgeW91IGRpZG4ndCB0ZXN0IHRoYXQgc2NlbmFyaW8pLg0KPiANCj4gPiBJIGZvciBzdXJl
IG5lZWQgdGhlIG9mX2RldmljZV9pZCBhcw0KPiA+IGluIG1hbnkgY2FzZXMgYm90aCB0aGUgZGV2
aWNlIG1hdGNoaW5nIGFuZCBtb2R1bGUgbWF0Y2hpbmcgYXJlIGRvbmUNCj4gPiBiYXNlZCBvbiAg
b2ZfbWF0Y2hfdGFibGUgYW5kIG9mX2RldmljZV9pZC4NCj4gPiANCj4gPiBJIGFkbWl0IEkgZGlk
bid0IHRyeSBjb21waWxpbmcgdGhlICFPRiBjb25maWcuIEFyZSB5b3Ugc3VnZ2VzdGluZyBJDQo+
ID4gc2hvdWxkIHB1dCB0aGUgb2ZfZGV2aWNlX2lkIGFycmF5IGFuZCBwb3B1bGF0aW5nIHRoZSBv
Zl9tYXRjaF90YWJsZQ0KPiA+IGluDQo+ID4gI2lmZGVmIENPTkZJR19PRj8gT3IgbWF5YmUgeW91
IHN1Z2dlc3QgdGhhdCBJIHdpbGwgcHV0IG9mX2RldmljZV9pZA0KPiA+IGFycmF5IGluICNpZmRl
ZiBDT05GSUdfT0YgYW5kIHVzZSBvZl9tYXRjaF9wdHIoKSB3aGVuIHBvcHVsYXRpbmcNCj4gPiB0
aGUNCj4gPiBvZl9tYXRjaF90YWJsZSBwb2ludGVyPyBJIGd1ZXNzIHRoYXQgd291bGQgbWFrZSBz
ZW5zZS4gSSdsbCBkbyB0aGF0DQo+ID4gLQ0KPiA+IGNhbiB5b3UgcGxlYXNlIGV4cGxhaW4gaWYg
dGhpcyB3YXMgbm90IHdoYXQgeW91IG1lYW50Lg0KPiANCj4gT25lIG9mIHVzIG5lZWRzIGEgbW9y
bmluZyBjb3ZmZWZlLCBJIHRoaW5rIDotKQ0KDQpTbyBpbiAhQ09ORklHX09GIGNhc2Ugd2Ugd2ls
bCBoYXZlDQoub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIoYmQ5OTk1eF9vZl9tYXRjaCks
DQpwcmVwcm9jZXNzZWQgdG8gZm9ybQ0KLm9mX21hdGNoX3RhYmxlID0gTlVMTCwNCg0KcmlnaHQ/
IFNvIHdpdGggdGhpcyBtYWNybyB3ZSBjYW4gb21pdCBpbnRyb2R1Y3Rpb24gb2YgYmQ5OTk1eF9v
Zl9tYXRjaA0Kd2hlbiAhQ09ORklHX09GIC0gbWVhbmluZyB3ZSBvbmx5IGJ1aWxkICNpZmRlZmZl
cnkgYXJvdW5mIHRoZSBtYXRjaA0KdGFibGUgYW5kIG5vdCBhcm91bmQgdGhpcyBhc3NpZ25tZW50
Lg0KDQpTbyBJJ2xsIGp1c3QgZG8gDQoNCiNpZmRlZiBDT05GSUdfT0YgICANCnN0YXRpYyBjb25z
dCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIGJkOTk5NXhfb2ZfbWF0Y2hbXSA9IHsNCiAgICAgICAgeyAu
Y29tcGF0aWJsZSA9ICJyb2htLGJkOTk5NTQiLCB9LA0KICAgICAgICB7IH0NCn07ICAgICAgICAg
IA0KTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYmQ5OTk1eF9vZl9tYXRjaCk7DQojZW5kaWYNCg0K
YW5kIGxldCB0aGUNCiNkZWZpbmUgb2ZfbWF0Y2hfcHRyKF9wdHIpCU5VTEwNCmZpeCBhc3NpZ25t
ZW50DQoub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIoYmQ5OTk1eF9vZl9tYXRjaCksDQoN
CndoZW4gIUNPTkZJR19PRi4NCg0KQnIsDQoJTWF0dGkNCg==
