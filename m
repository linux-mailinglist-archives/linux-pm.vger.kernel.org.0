Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2F190B55
	for <lists+linux-pm@lfdr.de>; Tue, 24 Mar 2020 11:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgCXKqC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 24 Mar 2020 06:46:02 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:61998 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgCXKqC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Mar 2020 06:46:02 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 24 Mar 2020 06:46:01 EDT
X-AuditID: c0a8fbf4-473ff70000004419-8b-5e79e1633674
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 2E.BD.17433.361E97E5; Tue, 24 Mar 2020 11:30:59 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Tue, 24 Mar 2020 11:30:54 +0100
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
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAAAaoCAAArrAA==
Date:   Tue, 24 Mar 2020 10:30:53 +0000
Message-ID: <e9d1cdafb6b048147eae318e0d6843601442725a.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
         <20200324095153.GF1922688@smile.fi.intel.com>
In-Reply-To: <20200324095153.GF1922688@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BE73F2C85064547B8F97E281684098C@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TbVBUVRjH59x79t7Dy22uK8pptQ9saSMGZtHMqaHGmj5cc8oa8oOZSxe5
        7JL7wuyLQVMTyZKI44gvhCwLbiCCtgksjhjtjrizo0ANK2gBzq5KMU3gQL6NG1HUXq4Kn87/
        nP/ze/7Ph+cgWn2W1aBCs12ymkWjlkmEPa2zvowdYyW65wfLMom7zcuQ/btrKDJz/09ADh5Y
        QwZHDtOkemycIR2DlyhSU30ZEHfYCUlvRzskx0IDKvLX1UOQlDW1MWTf5EoSDrez5MHVCooc
        +aeFIle63Qy5tz8ESPPwIEXczb2QNLWsJu2dMYpMRWogKQ+EWBKoOaEiP/5gJ1/XB1jS6aum
        yfDdaxQJzM1AErh+D5CLd2bAhjShfOhfRvA2eIFw5uQoJXzvirLC2Z5VgsfnEDpb04Um/wQl
        +E7tZYRDJxpVQuQXPyNMDwywQu/RWShUNfYAoaHvPeF8vZd9N+WDpOw80b4rp1BvXvfaR0mG
        qF9XdA0VO6eisBT4USVIQJjPwrfqLtOVIBGp+Z8BLrv9B1AuvQCP9nlUlQAhhs/GlaOsDKTw
        m/Df0yPzNTTv53DFVIiSjaX8Rtx6Y0ilFL2FW74KMIp+A58ed87DkF+Fa7taoKw5/h08W/fl
        w+RyCgf3zMwDCfwr+NvwdVrWgH8K7y2dng+g+VTs+z2mUsbm8XF/mFb0Mjzx29zD9zTcFTsN
        5aFpfg1u616noBtw4MBhqOg0fGTfGKvMsAT31Y7DKrDctSjBtUC7FtGuRbRrEe0BqlMAm8RC
        o160S+szrZIj02oxmOLHDovJB5Q9vH8O/BfcGAQUAkHwJKK0y7iPb5bo1E/kWfJLDKLNkGt1
        GCVbEGBEa1O4TqlYp+byxZJPJavlkbUCQW0q9+zYwe1qXs7aKUlFkvWRuxIhLeZy5KZLrJJe
        Ki4oNNoXbAolyM0TNSk2yZwvWUWH3ZAr70euLb4gspUcz90s45ytSDTFXxW0H6xFVRP1jTQK
        1Tc30mpotpglTSpnlEt5udTgMD8OmgSpCGiXckWymxz/jI/7TMYjqHiE3vWJHGEXFyxNKfj8
        9cgZsS5ni/D+yBcfvvTgTuQuE4tqnBkdGT/t8T/NdI1HoicvmZ7pF8+/ulOf7X4h4bu65KGq
        7U23n9td8E2W/jjtTZoObRmIOWzHbvarq2E4yzO8CRWsfXvrjTfNSc7N58S8Cyu26Tz5L++6
        ld59xffixK/L5z7bNloR7qplLjZc0EKbQVyfTltt4v+caEJkSQQAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gQW5keSwNCg0KVGhhbmtzIGZvciB0YWtpbmcgdGhlIHRpbWUgYW5kIHJldmlld2luZyB0
aGlzIDopIEFwcHJlY2lhdGVkLg0KDQpPbiBUdWUsIDIwMjAtMDMtMjQgYXQgMTE6NTEgKzAyMDAs
IEFuZHkgU2hldmNoZW5rbyB3cm90ZToNCj4gT24gVHVlLCBNYXIgMjQsIDIwMjAgYXQgMTE6NTA6
MjRBTSArMDIwMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiA+IE9uIFR1ZSwgTWFyIDI0LCAy
MDIwIGF0IDEwOjMyOjE5QU0gKzAyMDAsIE1hdHRpIFZhaXR0aW5lbiB3cm90ZToNCj4gPiA+ICtz
dGF0aWMgaW50IGJkOTk5NXhfZ2V0X3Byb3BfYmF0dF9wcmVzZW50KHN0cnVjdCBiZDk5OTV4X2Rl
dmljZQ0KPiA+ID4gKmJkKQ0KPiA+ID4gK3sNCj4gPiA+ICsJaW50IHJldCwgdG1wOw0KPiA+ID4g
Kw0KPiA+ID4gKwlyZXQgPSByZWdtYXBfZmllbGRfcmVhZChiZC0+cm1hcF9maWVsZHNbRl9CQVRU
RU1QXSwgJnRtcCk7DQo+ID4gPiArCWlmIChyZXQpDQo+ID4gPiArCQlyZXR1cm4gZmFsc2U7DQo+
ID4gPiArDQo+ID4gPiArCXJldHVybiAodG1wICE9IEJBVFRfT1BFTikgPyB0cnVlIDogZmFsc2U7
DQo+ID4gDQo+ID4gQyAxMDEgKEkgc2F3IHNvbWV3aGVyZSBjb2NjaW5lbGxlIHNjcmlwdCBmb3Ig
dGhpcyk6DQo+ID4gDQo+ID4gCXJldHVybiB0bXAgIT0gQkFUVF9PUEVOOw0KPiA+IA0KPiA+ID4g
K30NCj4gDQo+IEFoLCBhbmQgZXZlbiBtb3JlLiBNaXN0eXBlIG9mIGZ1bmN0aW9uIGFuZCByZXR1
cm4gdmFsdWUuDQo+IA0KUmlnaHQuIEFuZCBzYW1lIGlzIGRvbmUgaW4gcmV0dXJuIGFib3ZlLiBJ
J2xsIGZpeCB0aGlzLg0K
