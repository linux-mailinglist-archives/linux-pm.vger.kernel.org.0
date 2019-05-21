Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE46A24EE6
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2019 14:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfEUMY3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 May 2019 08:24:29 -0400
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:54890 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfEUMY3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 May 2019 08:24:29 -0400
X-AuditID: c0a8fbf4-501ff700000014c1-05-5ce3edfb5f31
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 81.5F.05313.BFDE3EC5; Tue, 21 May 2019 14:24:27 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Tue, 21 May 2019 14:24:21 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "Haikola, Heikki" <Heikki.Haikola@fi.rohmeurope.com>,
        "Okada, Koki" <Koki.Okada@fi.rohmeurope.com>
Subject: Re: [PATCH v14 0/8] support ROHM BD70528 PMIC
Thread-Topic: [PATCH v14 0/8] support ROHM BD70528 PMIC
Thread-Index: AQHVAMcZ2S9oIqrnW0ecnOWL7FvEJaZ1ZiIAgAALIoCAAAvhAA==
Date:   Tue, 21 May 2019 12:24:20 +0000
Message-ID: <ee483dcc519f89ee5413832833bc61e9a32c315f.camel@fi.rohmeurope.com>
References: <cover.1556787930.git.matti.vaittinen@fi.rohmeurope.com>
         <3a78cc77499d5027f527be51a7c40f6c5d70338c.camel@fi.rohmeurope.com>
         <20190521114149.GG3274@piout.net>
In-Reply-To: <20190521114149.GG3274@piout.net>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AAC4464FFDE1E446A5B4B52FFE129B7F@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTdxjH97v3IjePAvIbviRc4h/TCIOQ8YshyjQkt5gsJEQTt2Z4yEmb
        0ZdcWwPjD6tRFHwJEoyzKTAMbAh1tZ1LhIECQ9LBMmUog4zN1FYJTkADarQNesep8Nd97/k+
        n+f7XPIcg+sXqFTGZHFIskUs46k4orct6t8SnQkbPplsI1DLyF0aHZ/9gUYLDUMEOheKUKhp
        4E8S3Xt2E6Dnd05gqD72I4aenvqPRD83xQAa7fJQaP70AECDHXcoNP7TdRpFmv/AUOvfIxjy
        tAYJNDKUj471DNBoccxPoOFfHSg8vYjnrRG8jV4gzI0fo4VGb6XQ6f6XFgLt1ZQwOdZNCZe8
        XlLofOGihfONLzFhPrChIO7LVbnFouNgoanUkrFt3yrjzOhrYLumK2++MUe7wHe6GqBjIJcN
        Ixef4DUgjtFzYwD+X/uc1F6CAIZaYlgNYBiKy4U1E7QKJHE7YeOtKkLtwblnOjhWO0WoRiL3
        KbzZdYPQmnLgL8FJXNM74F9NEUzVBLcR+l8NLvWw3Bfw1YPA22QfgHdvt5KqoePS4ZPZ2SUN
        uPWw2jW7BONcCgw8fEFqa3OwpfsWrulkOB1efFvnYc/LEKEujXMfQ19XhobmwbPn6ihNp8H6
        kyFa2yEB/n4hQtSCNe4VCe5l2r2Cdq+g3Svo7wHZDqBZNJWVig4pM12WnOmy1WhWHvut5gDQ
        7mbhGnjd/3k/4BjAx7PRybBBT4oH7RXmfvARg/HJ7OkMpfRhsbWkwijajUWys0yy9wPI4HwS
        Ozx036BnS8SKbyXZ+s5ayxB8Chvt6jPoOTX5G0mySfI7dx3D8JAllFvVJ8hSqVR+wFTmWLYx
        RqcOj0tNskuWEkkWnQ5jkXouRXblXlQrXsm98ljBWbtNNCtVDR0Cm5nei6EGnJnpm2rA9YTF
        apFSU1haTeLUVqPT8j7oEUhRvjeRnVMHxSu/0vs5j5QITIlYTy9FOMRlK9UFCp2b9qzOD7io
        rZf27D7i+cC/yxfLT9+4LphtGgk11111tE3oY5m5qLX8a5+r5bNKT96++q/Sooln/MlXmoK3
        6+Ztv90LLxbXHs6SKvNz+L3hgkP7Ozyk7XFWe1rH5aebKzsKd1Z1JhgWCrb46q/mZE/tHc0+
        XzV99P7E9up/6s6c4Am7UczchMt28Q1YkxBbBwQAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gQWxleGFuZHJlLA0KDQpPbiBUdWUsIDIwMTktMDUtMjEgYXQgMTM6NDEgKzAyMDAsIEFs
ZXhhbmRyZSBCZWxsb25pIHdyb3RlOg0KPiBPbiAyMS8wNS8yMDE5IDExOjAxOjUzKzAwMDAsIFZh
aXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gSGVsbG8gQWxsLA0KPiA+IA0KPiA+IE9uIFRodSwg
MjAxOS0wNS0wMiBhdCAxMjoxMSArMDMwMCwgTWF0dGkgVmFpdHRpbmVuIHdyb3RlOg0KPiA+ID4g
UGF0Y2ggc2VyaWVzIGludHJvZHVjaW5nIHN1cHBvcnQgZm9yIFJPSE0gQkQ3MDUyOCBQTUlDDQo+
ID4gPiANCj4gPiANCj4gPiBKdXN0IHRob3VnaHQgSSdkIGFzayBpZiB0aGVyZSdzIGFueSBjaGFu
Y2VzIHRvIGdldCB0aGlzIHNlcmllcyBpbg0KPiA+IDUuMj8NCj4gPiBJdCBzZWVtcyB0byBtZSB0
aGUgV0RUIHBhcnQgKHBhdGNoIDgpIHdhcyBhbHJlYWR5IG1lcmdlZCBpbiBidXQNCj4gPiByZXN0
IG9mDQo+ID4gdGhlIHBhdGNoZXMgc2VlbSB0byBiZSBpbiBsaW1ibyBzb21ld2hlcmUgOikNCj4g
PiANCj4gPiBJIGd1ZXNzIG1vc3Qgb2YgdGhlIHBhdGNoZXMgaGF2ZSByZWxldmFudCBhY2tzIC0g
c28gd29uZGVyIGlmIHRoZQ0KPiA+IHJlc3QNCj4gPiBjYW4gZ28gdGhyb3VnaCBMZWUncyB0cmVl
PyBJIGFkbWl0IEkgYW0gZ2V0dGluZyBzbGlnaHRseSBpbXBhdGllbnQNCj4gPiAtDQo+ID4gc29y
cnkgZm9yIHRoYXQgOl0NCj4gPiANCj4gDQo+IE5vcGUsIHRoZSA1LjIgbWVyZ2Ugd2luZG93cyBp
cyBjbG9zZWQuIFRoaXMgd2lsbCBoYXZlIHRvIHdhaXQgZm9yDQo+IDUuMy4NCg0KT2gsIHRoYXQn
cyB1bmZvcnR1bmF0ZSA6KCBUaGFua3MgZm9yIHRoZSByZXBseSB0aG91Z2guDQoNCkJlc3QgUmVn
YXJkcw0KCU1hdHRpIFZhaXR0aW5lbg0KDQo=
