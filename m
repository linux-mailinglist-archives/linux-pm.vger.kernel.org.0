Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4DB192A54
	for <lists+linux-pm@lfdr.de>; Wed, 25 Mar 2020 14:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgCYNri (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 25 Mar 2020 09:47:38 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:52290 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727340AbgCYNri (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2020 09:47:38 -0400
X-AuditID: c0a8fbf4-489ff70000004419-fc-5e7b60f7f1eb
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id B4.52.17433.7F06B7E5; Wed, 25 Mar 2020 14:47:35 +0100 (CET)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0487.000; Wed, 25 Mar 2020 14:47:29 +0100
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
Thread-Index: AQHWAbbAyLpT1a+wPEGvvo/J38Wk46hXbxYAgAAMuoCAAaNYgIAACT8AgAAOHACAAAWfgIAAAGUAgAAHJoA=
Date:   Wed, 25 Mar 2020 13:47:28 +0000
Message-ID: <57ef569e704eaebfd4a83a29c51c75eb1c1f3438.camel@fi.rohmeurope.com>
References: <cover.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <1bf2431b80489ae412e774519a92616a9aa2bcca.1584977512.git.matti.vaittinen@fi.rohmeurope.com>
         <20200324095024.GE1922688@smile.fi.intel.com>
         <20200324103557.GH1922688@smile.fi.intel.com>
         <4d75bfeab55c04cc3ca751cf7c364c812848e9ed.camel@fi.rohmeurope.com>
         <20200325120956.GW1922688@smile.fi.intel.com>
         <d533c18dcd7b4d4ca453661b3f9495a840b3313b.camel@fi.rohmeurope.com>
         <20200325132033.GY1922688@smile.fi.intel.com>
         <20200325132158.GZ1922688@smile.fi.intel.com>
In-Reply-To: <20200325132158.GZ1922688@smile.fi.intel.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E36ECA1B0B4C24FA837BDCC3ECEEFE2@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf2wTZRjHee+ud7fBmVs77OtEDRcRgQiSaPLKFuQf46GRyAjxR2TdjR3r
        4taOa6v7gbowBTckbpOtWNputmydWNhojbCyylLqsk1dBQYbZmgWyEybUOJYVkYnetcK21/v
        932/z/f5vG/yvDSu7qVy6FKDWZQMQhlHZhL9XcnTzyUKawqeb/3pJWTv9pLo8H4rhuZmbgPU
        9OUadHH8Kxy1TN4kkbXlN4DskU8JNHi6h0Bt4REVqnN3k+hQbAWKRHooNDv6OYaOzHswdDlg
        J9Gdw2GAOsYuYsjeMUggt+cZ1ONPYOjWhJVAnwXDFApaO1Xo53Nm1OoIUsjva8HR2PTvGAre
        nyNQ8I87AA38PQe2PMV7nV7Af//tNYzvtV2n+B/6V/HtPgvv71rLu/uiGO87UU/yzZ0uFT9x
        tY/k4yMjFD94NEnwja5+wDuHtvPnHV6Kn7JewN7UvLs0r0gwf7CjtMSwYXPhUv2PVidRYcus
        rDvnwmvB3YwGkEFD9gV4ZnwGU7SavQLggeQbDSBT1oMAdt69RzYAmibZPNhwjVJqstnX4b34
        OFBqcNZJwxtDl1TKZgkbImCb35nqpGG3wq4/FUNJvAY9B4JkWhfB0X8OpjTBroJD4cspzbDb
        YJN/ikyTjxPwm9BwyshgN8FEuzelAfsErK+NpwA4q4W+qYQq/QQWHu+L4Gm9HEZv3P//fCU8
        kzhFKC/A2TWwO7AhHd0Ck9d7qbReCY8cmqTSd8iCQ1/fJBqB1raIYFtI2xalbYvStkXpdqA6
        AWC5UFpWIpjFjesl0bJeMurL5WW3sdwH0qM4cxb8G9oaAhgNQuAxGuOWM6++V1OgfqTIWFyl
        F0x6nWQpE00hAGmcy2b8YmWBmikWqqpFyfjAepwmOC2zerJpl5pVWO+LYoUoPXBX0DQHmXmd
        3DRLEkvEyj2lZeYFG6MzlOaZOdkm0VAsSoLFrNcpw6IzydOiWMtk7kH5v6gZU4VQLp+mo8Ng
        Hd0YdbhwOuzocOFqwmA0iDla5qpCYpVSvcXwEBQDWhpwGuYjxV0m/8eHfWIyApMRJbYPFYRZ
        WLByakHe2xOFTw8E+ldXBmKO5tiTNZcGrnh+7Rbf+eRCNcEkN+tyl0x/rJrP1xxr9u2323+5
        XV2jD7+8qe6LF/Pb/5qNP1rtyrIMe7goXtv2inu689l6Q946mpjYtu+7vbd2t46rTPGiwN7o
        rqrpXN9bY7NNEfF8Yqdm32i+e08ud/akY4AjTHph41pcMgn/AdserCVMBAAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcGF0aWVuY2UgQW5keSwNCg0KT24gV2VkLCAyMDIwLTAzLTI1IGF0IDE1
OjIxICswMjAwLCBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20NCndyb3RlOg0KPiBP
biBXZWQsIE1hciAyNSwgMjAyMCBhdCAwMzoyMDozM1BNICswMjAwLCANCj4gYW5kcml5LnNoZXZj
aGVua29AbGludXguaW50ZWwuY29tIHdyb3RlOg0KPiA+IE9uIFdlZCwgTWFyIDI1LCAyMDIwIGF0
IDAxOjAwOjIxUE0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gQnV0IHdoeT8N
Cj4gPiANCj4gPiBZb3UgcmVhbGx5IHVnbGlmeSB0aGUgY29kZSB3aXRoIGlmZGVmZmVyeSwgbWFr
ZSBhIGRlcGVuZGVuY3kgdG8gT0YNCj4gPiAoeWVzLCB5b3UNCj4gPiB3aWxsIGhhdmUgdG8gaGF2
ZSBvZi5oIGluY2x1ZGUpIG9ubHkgYmVjYXVzZSBvZiB0aGF0IHNpbGx5DQo+ID4gbWFjcm8gYW5k
IHNhdmUgNjQgYnl0ZXMgb2YgbWVtb3J5IGZvb3RwcmludC4NCj4gDQo+IEFuZCBvbiB0b3Agb2Yg
dGhhdCBmb3IgIU9GIGNvbmZpZ3VyYXRpb24geW91IHByZXZlbnQgeW91ciBkcml2ZXIgdG8NCj4g
YmUgdXNhYmxlLg0KPiAoQ29uc2lkZXIgUFJQMDAwMSBBQ1BJIGNhc2UsIGZvciBleGFtcGxlKQ0K
PiANCg0KQW5kIGhlcmUgSSByZXZlYWxlZCBteSBpZ25vcmFuY2Ugd2hhdCBjb21lcyB0byBBQ1BJ
IHdvcmxkIDopIEkgZGlkbid0DQprbm93IHRoZXJlIGlzIGEgd2F5IHRvIHV0aWxpemUgRFQgY29t
cGF0aWJsZXMgZnJvbSBBQ1BJLg0KDQpBbm90aGVyIG1pc3Rha2UgSSBkaWQgd2FzIGFzc3VtaW5n
IHRoYXQgdGhlIG9mX2RldmljZV9pZCB3b3VsZCByZXNpZGUNCmluIG9mLmguIFRoYW5rcyBmb3Ig
dGhlIGd1aWRhbmNlIC0gSSBkbyBhZ3JlZSB3aXRoIHlvdS4gSSdsbCBkcm9wIGJvdGgNCnRoZSBp
ZmRlZiBhbmQgb2ZfbWF0Y2hfcHRyKCkuDQoNCkJyLA0KCU1hdHRpDQo=
