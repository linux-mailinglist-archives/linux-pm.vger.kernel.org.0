Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0E11165943
	for <lists+linux-pm@lfdr.de>; Thu, 20 Feb 2020 09:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgBTIek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Feb 2020 03:34:40 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:54414 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgBTIek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Feb 2020 03:34:40 -0500
X-AuditID: c0a8fbf4-473ff70000004419-ff-5e4e449e3033
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id E2.55.17433.E944E4E5; Thu, 20 Feb 2020 09:34:38 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Thu, 20 Feb 2020 09:34:34 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>
CC:     "rafael@kernel.org" <rafael@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: [RFC PATCH v3 3/8] drivers: base: add linear ranges helpers
Thread-Topic: [RFC PATCH v3 3/8] drivers: base: add linear ranges helpers
Thread-Index: AQHV58BcZJpQgU8ZXUak5RlY2LGYvqgjo9cAgAANCYA=
Date:   Thu, 20 Feb 2020 08:34:33 +0000
Message-ID: <1eaaa72f167e370cc2875dfa43ee0198ec7d0cfc.camel@fi.rohmeurope.com>
References: <cover.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <1f6cb9fb9dbc429dc48110f18ad3a8c0c40196c6.1582182989.git.matti.vaittinen@fi.rohmeurope.com>
         <2f0755df-4bc6-c53d-edea-45bc99e6a47b@infradead.org>
In-Reply-To: <2f0755df-4bc6-c53d-edea-45bc99e6a47b@infradead.org>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A415A209DAF1BE4E82B744B915D72122@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPJsWRmVeSWpSXmKPExsVyYMXvTbrzXPziDPausbSY+vAJm8X8I+dY
        LZoXr2ez+Halg8ni8q45bBafe48wWiy9fpHJYs7SEywWc79MZbZ4e2c6i0Xr3iPsFqd3lzjw
        eKyZt4bRY+esu+wem1doeWxa1cnmsX/uGnaPz5vkAtiiuG2SEkvKgjPT8/TtErgzPn1+yVRw
        h7Ni8f+pLA2Mezi7GDk5JARMJNp3H2brYuTiEBK4yijRf/0eM4RzglFi+rS7TF2MHBxsAjYS
        XTfZQRpEBHIkVk/qA2tgFnjEInF8Rg8bSEJYwENi74xXTBBFnhJb7sxmhbCtJM6+PQXWzCKg
        KjF7bhuYzSvgJ/G4tRdq821GidYLnWDNnAKOEhsnTwJrZhSQlehseAcWZxYQl9j07DsrxNkC
        Ekv2nGeGsEUlXj7+BxVXktj78yELyNHMApoS63fpQ5gOEg/Os0FMUZSY0v0Q6gRBiZMzn7BM
        YBSbhWTBLITmWQjNs5A0z0LSvICRdRWjRG5iZk56YkmqoV5RaqleUX5GLpBKzs/dxAiJ8C87
        GP8f8jzEyMTBeIhRkoNJSZR3hohfnBBfUn5KZUZicUZ8UWlOavEhRgkOZiURXjUeoBxvSmJl
        VWpRPkxKmoNFSZxX/eHEWCEBkF3ZqakFqUUwWRkODiUJ3kRnoEbBotT01Iq0zJwShDQTByfI
        cC4pkeLUvJTUosTSkox4UPKILwamD5AUD9De/w4ge4sLEnOBohCtpxi1OSa8nLuImePI3KWL
        mIVY8vLzUqXEecucgEoFQEozSvPgFr1iFOdgVBLmXQ+S5QGmerg5r4BWMAGteC/sA7KiJBEh
        JdXA6JBQ81nh5XP7AL+PMwLZF/FvPxTqGJH4c1fr/Mnz3eWiIhtnSTKsTZjJs2/FRKm9de1V
        i4zr7v66vDagZLZPwIxk5l0pFrIZTY/n1dc3hcz8sPWAy7tjTdXnjC9+mrzefpareyaj6O4d
        xq1PNUVb1u2tvCt0ecWqlLVbVvAlHFEx774Yu/SthRJLcUaioRZzUXEiAC5psxSyAwAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhhbmtzIGZvciB0YWtpbmcgYSBsb29rIGF0IHRoaXMgUmFuZHkgOikgSGlnaGx5IGFwcHJlY2lh
dGVkLg0KDQpPbiBXZWQsIDIwMjAtMDItMTkgYXQgMjM6NDcgLTA4MDAsIFJhbmR5IER1bmxhcCB3
cm90ZToNCj4gSGksDQo+IEhlcmUgYXJlIHNvbWUga2VybmVsLWRvYyBjb21tZW50cyBmb3IgeW91
Og0KDQpJIGFncmVlZCB3aXRoIGFsbCB0aGUgY29tbWVudHMgLSBJJ2xsIGZpeCB0aGVtIGZvciBu
ZXh0IHZlcnNpb24uDQoNCj4gT24gMi8xOS8yMCAxMTozNSBQTSwgTWF0dGkgVmFpdHRpbmVuIHdy
b3RlOg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2Jhc2UvS2NvbmZpZyAgICAgICAgIHwgICAzICsN
Cj4gPiAgZHJpdmVycy9iYXNlL01ha2VmaWxlICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMv
YmFzZS9saW5lYXJfcmFuZ2VzLmMgfCAyNDYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L2xpbmVhcl9yYW5nZS5oIHwgIDQ4ICsrKysr
KysNCj4gPiAgNCBmaWxlcyBjaGFuZ2VkLCAyOTggaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9iYXNlL2xpbmVhcl9yYW5nZXMuYw0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9saW51eC9saW5lYXJfcmFuZ2UuaA0KPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL2Jhc2UvbGluZWFyX3Jhbmdlcy5jDQo+ID4gYi9kcml2ZXJzL2Jhc2UvbGluZWFyX3Jh
bmdlcy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAu
LjVmYTNiOTZiZjJiOA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysgYi9kcml2ZXJzL2Jhc2Uv
bGluZWFyX3Jhbmdlcy5jDQoNCg0KQmVzdCBSZWdhcmRzLA0KCU1hdHRpIFZhaXR0aW5lbg0K
