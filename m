Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02EBC192747
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 12:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgCYLgz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 07:36:55 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:49370 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgCYLgz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 07:36:55 -0400
X-AuditID: c0a8fbf4-489ff70000004419-3a-5e7b4254a412
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id CE.D1.17433.4524B7E5; Wed, 25 Mar 2020 12:36:52 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Wed, 25 Mar 2020 12:36:47 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "brendanhiggins@google.com" <brendanhiggins@google.com>,
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
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAAMuoCAAaNYgA==
Date:   Wed, 25 Mar 2020 11:36:46 +0000
Message-ID: <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
         <20200324103557.GH1922688@smile.fi.intel.com>
In-Reply-To: <20200324103557.GH1922688@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <85534FA46F1BC646A64DFADFA82589B4@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf0wTZxzGfe+udwf29CiYvlbNQhdndBn+YJnvFuYYW5ZTl2XLssQsA3aO
        kzYrLbm2DGGJDKebJWT8rl6KsLIKY43Q1qyoNGuwLjiTdjonSmCTSZyQDZmorLLp7rgp/HXP
        vc/z+T73Jt+jcV2YMtBmq0MQrbzFSKYS0a65wDPv5FUWbPoyE3l6/CSqrXZjKHnnFkD1X6xH
        F6404qh5bJxE7uYfAfIkPiXQYKCXQG2xuAbt7+ghUc3kapRI9FLo3qXPMdT0TyeGfjrlIdFM
        bQwg39AFDHl8gwTq6HwK9YZmMfTniJtAByIxCkXcxzTo/GkHammNUCgUbMbR0O1hDEUeJAkU
        +WUGoO//SoLcJzj/UT/gTnx9FeNOSqMU9210LdcedHKhrg1cR/8ExgW7D5FcwzGvhhu53E9y
        U/E4xQ0eniO4Om8UcEfPvcV91+qnuBvuM9ib6e8uzdnNO8reNhdbN257f6nJ69WW3lteHg40
        YFUgutwFUmjIPgt7mmcoF0ildezPAA5LMUJ9GQTwcPQk6QI0TbI50HWVUoAMdie8P3UFKBmc
        bafh/m8a5oElbJSA07/XYkoqnd0Ou369qFGJHbDzYIRUdR5sDH02nyHYtbCrOoQrmmHfgL5e
        P6FoHXsAg7fGtIpOYV+A16XEfDNg18BDVVPzLM7qYfDGrEa9Agu/6k/gql4BJ64/+P88E4Zn
        jxPKBXB2Pew5tVFFc+Gky0eqOhM21YxR6iekwXNHxok6oJcWNUgLtLSIlhbR0iK6HWi6ASzh
        zZZi3iFszhIFZ5ZoM5XIjw9sJUGgLuKdPvBwYPsAwGgwAFbSmHEF8+TWygLdst22or0m3m4q
        FJ0WwT4AII0bM5iQUF6gY4r4vRWCaHtkraIJo55ZN1afr2OVrg8FoVQQH7mradoImb5ceWia
        KBQL5XvMFseCjdEpyvBUQ4ZdsBYJIu90mAqVXSm0y8uiWFq5t2GbjDP2Ur5EPlXRH8DTdN1E
        qxenY60+L64jrDarYNAzq16Wo6wSNTmtj4smgZ4GxnTm75dkVyv/jY/nTMoVmFxRLH2kVDj4
        BctQBQy3LXfLspaYk1vrx+fWVESz/drAc3ePHxm+1hIPZ7+XjO+5ePNMX0t0aof/xP0XvbGH
        iVfOj6y7nF3m//dSTsGW/vCuNi687/WWm92dNVV5nrSK55s+yW87PV05FMhpH82tG92UfXba
        z3/86m+Ny6q35NsmYsxOxvDHtX27+s6unD34mpGwm/jNG3DRzv8HaiO7FEoEAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gQW5keSwNCg0KT24gVHVlLCAyMDIwLTAzLTI0IGF0IDEyOjM1ICswMjAwLCBBbmR5IFNo
ZXZjaGVua28gd3JvdGU6DQo+IE9uIFR1ZSwgTWFyIDI0LCAyMDIwIGF0IDExOjUwOjI0QU0gKzAy
MDAsIEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gPiBPbiBUdWUsIE1hciAyNCwgMjAyMCBhdCAx
MDozMjoxOUFNICswMjAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6DQo+ID4gPiArI2luY2x1ZGUg
PGxpbnV4L2FjcGkuaD4NCj4gPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiANCj4gPiBJ
IGRpZG4ndCBmaW5kIGFueSBldmlkZW5jZSBvZiB1c2Ugb2YgdGhvc2UgdHdvLCBvdGhlcndpc2Us
IG1pc3NlZA0KPiA+IHByb3BlcnR5LmgNCj4gPiBhbmQgcGVyaGFwcyBtb2RfZGV2aWNldGFibGUu
aC4NCj4gDQo+IC4uLg0KPiANCj4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKG9mLCBiZDk5OTV4
X29mX21hdGNoKTsNCj4gPiA+ICtNT0RVTEVfREVWSUNFX1RBQkxFKGFjcGksIGJkOTk5NXhfYWNw
aV9tYXRjaCk7DQo+IA0KPiBJIGhhdmUgdG8gYWRkIHNpbmNlIHlvdSBhcmUgdXNpbmcgdGhvc2Ug
bWFjcm9zIHdpdGhvdXQgaWZkZWZmZXJ5LCB5b3UNCj4gc2hvdWxkDQo+IGdldCB3YXJuaW5nIGlu
ICFBQ1BJIGFuZC9vciAhT0YgY2FzZXMuDQo+IA0KPiBTbywgZHJvcCB0aG9zZSBvZl9tYXRjaF9w
dHIoKSAvIEFDUElfUFRSKCkgYW5kIHRodXMgYWJvdmUgaGVhZGVycy4NCg0KU29ycnkgYnV0IEkg
ZG9uJ3QgZm9sbG93IDovIEkgZGlkIGRyb3Agd2hvbGUgQUNQSSB0YWJsZSBhcyB0aGUgYmF0dGVy
eQ0KaW5mb3JtYXRpb24gaXMgbm90IGZldGNoZWQgZnJvbSBBQ1BJIGFueXdheXMuIEJ1dCBJIGRv
bid0IGtub3cgd2hhdCB5b3UNCm1lYW4gYnkgZHJvcHBpbmcgdGhlIG9mX21hdGNoX3B0cj8gSSBm
b3Igc3VyZSBuZWVkIHRoZSBvZl9kZXZpY2VfaWQgYXMNCmluIG1hbnkgY2FzZXMgYm90aCB0aGUg
ZGV2aWNlIG1hdGNoaW5nIGFuZCBtb2R1bGUgbWF0Y2hpbmcgYXJlIGRvbmUNCmJhc2VkIG9uICBv
Zl9tYXRjaF90YWJsZSBhbmQgb2ZfZGV2aWNlX2lkLg0KDQpJIGFkbWl0IEkgZGlkbid0IHRyeSBj
b21waWxpbmcgdGhlICFPRiBjb25maWcuIEFyZSB5b3Ugc3VnZ2VzdGluZyBJDQpzaG91bGQgcHV0
IHRoZSBvZl9kZXZpY2VfaWQgYXJyYXkgYW5kIHBvcHVsYXRpbmcgdGhlIG9mX21hdGNoX3RhYmxl
IGluDQojaWZkZWYgQ09ORklHX09GPyBPciBtYXliZSB5b3Ugc3VnZ2VzdCB0aGF0IEkgd2lsbCBw
dXQgb2ZfZGV2aWNlX2lkDQphcnJheSBpbiAjaWZkZWYgQ09ORklHX09GIGFuZCB1c2Ugb2ZfbWF0
Y2hfcHRyKCkgd2hlbiBwb3B1bGF0aW5nIHRoZQ0Kb2ZfbWF0Y2hfdGFibGUgcG9pbnRlcj8gSSBn
dWVzcyB0aGF0IHdvdWxkIG1ha2Ugc2Vuc2UuIEknbGwgZG8gdGhhdCAtDQpjYW4geW91IHBsZWFz
ZSBleHBsYWluIGlmIHRoaXMgd2FzIG5vdCB3aGF0IHlvdSBtZWFudC4NCg0KQnIsDQogICAgTWF0
dGkNCg==
