Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A6919C614
	for <lists+linux-pm@lfdr.de>; Thu,  2 Apr 2020 17:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbgDBPjw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Apr 2020 11:39:52 -0400
Received: from mailgate1.rohmeurope.com ([87.129.152.131]:44200 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388916AbgDBPjw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2020 11:39:52 -0400
X-AuditID: c0a8fbf4-489ff70000004419-87-5e860746f190
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 73.47.17433.647068E5; Thu,  2 Apr 2020 17:39:50 +0200 (CEST)
Received: from WILL-MAIL001.REu.RohmEu.com ([fe80::2915:304f:d22c:c6ba]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0487.000; Thu, 2 Apr 2020 17:39:49 +0200
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "brendanhiggins@google.com" <brendanhiggins@google.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "talgi@mellanox.com" <talgi@mellanox.com>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
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
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "skhan@linuxfoundation.org" <skhan@linuxfoundation.org>,
        "zaslonko@linux.ibm.com" <zaslonko@linux.ibm.com>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "uwe@kleine-koenig.org" <uwe@kleine-koenig.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v7 04/10] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Thread-Topic: [PATCH v7 04/10] lib/test_linear_ranges: add a test for the
 'linear_ranges'
Thread-Index: AQHWB1c4b3nN1Ux6yEinb5I8a1VXN6hi3q0AgAD00ICAAKifAIABXY+A
Date:   Thu, 2 Apr 2020 15:39:48 +0000
Message-ID: <bfb0093dc6fa5adb4f262f144585f7c937bd57c6.camel@fi.rohmeurope.com>
References: <cover.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
         <285da2166eadc1d46667dd9659d8dae74d28b0b9.1585656143.git.matti.vaittinen@fi.rohmeurope.com>
         <CAFd5g460hY9uOtwicWHK2rhgLdL+gStbKGmLN5KLWi5JXDQEog@mail.gmail.com>
         <4f915b8b8bee36a61ebea62ebf34c61845170ad5.camel@fi.rohmeurope.com>
         <CAFd5g44gBrNti5Y_ctQKOE1_pWX3NAdTji1uH8m6dGj+tsJCew@mail.gmail.com>
In-Reply-To: <CAFd5g44gBrNti5Y_ctQKOE1_pWX3NAdTji1uH8m6dGj+tsJCew@mail.gmail.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [62.78.225.252]
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F811E985B94B43959F1BBA38351B82@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwTZxzH89xd7w70zFnQPmM4Y6MYXKaSsORZZgwzGbn9s4jLYtQInnLQ
        ztKS65Wh2x9kvGzCyMosVhtAB9ZX3mxVFKh20MzilMJQEVdJGhxZSUYmkDFS4nbHofDP83yf
        5/t8nu/vSX4PjWu9VBJtNEuCaOZNejKe8F+Ked7LpCqyt191rUJ1bc0kqv7GiaGovRegmh9S
        0eDTkziqjbwgkbN2AKC6UBmBgtfaCXQ20K9BpU1tJKqaSEahUDuF/nn0HYYc8xcxNNRZR6Lp
        6gBA7uFBDNW5gwRqupiC2r2zGPor7CRQuS9AIZ/zggb92iWhU/U+Cnk9tTgannqGId+rOQL5
        RqcB+uXlHMhYzzU3NAPu+uURjLvtek5xN/2buHMeG+e9tIVr6o5inOfKCZL78UKjhgs/6Sa5
        yf5+iguejhGcvdEPuIa+LO5ufTPFjTt7sd0J+1fsOMxLRZ8Z883bdh5aYbBP/U4UPsOL/z1V
        RpWAB3gliKMhmw5bQxGsEsTTWvYJgC03PaS6uAdgMPhcdmiaZHfAyhFKARLZD+F8yfeEcgZn
        Kxj42OFeMBLY/bBl6E+gHjoAz4SvLepM6A9PLqQR7Ebo8J4nFM2wn8LhB+VADZvD4N8PyxaM
        ODYLlrfMk4oG7Dp4omQSUzTO6qBnfFajls3C892hxSesgdGxV4v7G2DHbCuhFI2zqbCtc5uK
        ZsBYh4NQ9QboqIpQag2rYd+ZF4QdrHUtS3At0a5ltGsZ7VpGnwOaKwAW8EZTPi8JaVtFwbZV
        tBgK5OmIpcAD1PabuQX+6/mkB2A06AFv0Zh+DWOMlGdrVx225B4z8FZDjmgzCdYeAGlcn8h8
        dFr2mFz+2HFBtLy23qYJvY7ZHKk5qGWVrKOCUCiIr91kmtZDJousyNauFoV8oTjPaJKWbIyO
        Uy6PT0q0CuZcQeRtkiFHaZAcq9whirVSzq0AMs5YC/kCeVdF74M02h6tb8Tp3+Ya5DFQ727E
        tYTZYhaSdEyORgZYBTDYzG/iJoCOBvoE5ohSzUr5J765bUIOwuSgx8WlSpDEL1lJJQClZG/a
        aazKyywquvsuvNHVGm4bWz+bMeLvnRj48v373pmjyc49MynS9NjHsa/3Dtzx8U//KB1t+XYj
        ZcFPpqec7QB9H2weHNsV7Q6889UXefeYn6M111PX4frxh+2+YbDrp+PYJN4lDRVO3Yk9KgpW
        m0Z3xzr37GNx9+eWdN1Ll56wGvi0Lbho5f8H2k/4kkYEAAA=
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBXZWQsIDIwMjAtMDQtMDEgYXQgMTE6NDggLTA3MDAsIEJyZW5kYW4gSGlnZ2lucyB3cm90
ZToNCj4gT24gV2VkLCBBcHIgMSwgMjAyMCBhdCAxOjQ1IEFNIFZhaXR0aW5lbiwgTWF0dGkNCj4g
PE1hdHRpLlZhaXR0aW5lbkBmaS5yb2htZXVyb3BlLmNvbT4gd3JvdGU6DQo+IA0KPiBBYnNvbHV0
ZWx5ISBXb3VsZCB5b3UgYmUgaW50ZXJlc3RlZCBpbiBqb2luaW5nIG91ciBtYWlsaW5nIGxpc3Q6
DQo+IA0KPiBodHRwczovL2dyb3Vwcy5nb29nbGUuY29tL2cva3VuaXQtZGV2DQo+IA0KDQpTdXJl
IDopIEhvdz8gVGhlIGxpbmsgZ2F2ZSBtZSA0MDQuLi4NCg0KQmVzdCBSZWdhcmRzLA0KCU1hdHRp
DQo=
