Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4681163EA4
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 09:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgBSIOO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 03:14:14 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:48860 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726156AbgBSIOO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 03:14:14 -0500
X-AuditID: c0a8fbf4-473ff70000004419-7a-5e4cee545b91
Received: from smtp.reu.rohmeu.com (will-cas001.reu.rohmeu.com [192.168.251.177])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 67.71.17433.45EEC4E5; Wed, 19 Feb 2020 09:14:12 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS001.REu.RohmEu.com ([fe80::d57e:33d0:7a5d:f0a6%16]) with mapi id
 14.03.0439.000; Wed, 19 Feb 2020 09:14:12 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "sre@kernel.org" <sre@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
Subject: Re: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Thread-Topic: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Thread-Index: AQHV4At5sLPMospsI0G2S3c08J9KoagWS84AgADGiACAA3X4gIAADG2AgAXzFoCAAGvLAIABNKQA
Date:   Wed, 19 Feb 2020 08:14:11 +0000
Message-ID: <b0237802eed73451f85835c6bd1164411b901778.camel@fi.rohmeurope.com>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20200211190614.GP4543@sirena.org.uk>
         <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
         <20200214114749.GB4827@sirena.org.uk>
         <375c7756fca56de4f2f85d1a1a4e0b01dadc290b.camel@fi.rohmeurope.com>
         <208a81c87e944c69d95da85d7fd0f3ea2bd61547.camel@fi.rohmeurope.com>
         <20200218134926.GH4232@sirena.org.uk>
In-Reply-To: <20200218134926.GH4232@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AD085D8B43F6284F8DE9A4B85FB79458@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphk+LIzCtJLcpLzFFi42I5sOL3Rt2Qdz5xBgtXm1lMffiEzWL+kXOs
        FlP+LGeyuLxrDpvF594jjBZLr19kspiz9ASLReveI+wWp3eXOHB6rJm3htFj56y77B6bVnWy
        edy5tofN4/MmuQDWKG6bpMSSsuDM9Dx9uwTujG9vnzMXdAlU7G/9ydTAeIW/i5GTQ0LAROLt
        zU/MXYxcHEICVxklrh9dwQjhnGCUWLb5PGsXIwcHm4CNRNdNdpAGEQFdiam/FrOB1DALTGKR
        2HH+NzNIQljAVWLSk6vMEEVuEicbLzKD9IoIREkc73cGCbMIqEpMaVvMAmLzCvhJvHy7nw3E
        FhL4wCzRvFEOxOYUMJI43bcPrIZRQFais+EdE4jNLCAusenZd1aIowUkluw5zwxhi0q8fPwP
        Kq4ksffnQxaQtcwCmhLrd+lDtDpIXDm3lxnCVpSY0v2QHeIEQYmTM5+wTGAUm4VkwyyE7llI
        umch6Z6FpHsBI+sqRoncxMyc9MSSVEO9otRSvaL8jFwglZyfu4kRErtfdjD+P+R5iJGJg/EQ
        oyQHk5Io76d7PnFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHi9xb3ihHhTEiurUovyYVLSHCxK
        4rzqDyfGCgmA7MpOTS1ILYLJynBwKEnwfngDNFSwKDU9tSItM6cEIc3EwQkynEtKpDg1LyW1
        KLG0JCMelDzii4HpAyTFA7R38Sugdt7igsRcoChE6ylGbY4JL+cuYuY4MnfpImYhlrz8vFQp
        cd7fr4FKBUBKM0rz4Ba9YhTnYFQS5vV7C5TlASZxuDmvgFYwAa14Lwy2oiQRISXVwGizWFdU
        vNWYU3hO5t5lS5dHyDKZzna1tCu4MnV30YrJm/azJS65JOBd99u4x71cWkhN5FZr4lX1d61+
        5vdN9gio1Zcpt328qzNNv7Vrl7v72vW7ry2cKrOtslCgoXzO/tcT/O799OYRTTleKRVXdWS9
        xYtvrvIPSo6beiQyxbaYTqlwrv/5VImlOCPRUIu5qDgRAF08iwifAwAA
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGVsbG8gTWFyaywNCg0KT24gVHVlLCAyMDIwLTAyLTE4IGF0IDEzOjQ5ICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiBPbiBUdWUsIEZlYiAxOCwgMjAyMCBhdCAwNzoyMzozOEFNICswMDAwLCBW
YWl0dGluZW4sIE1hdHRpIHdyb3RlOg0KPiANCj4gPiBCeSB0aGUgd2F5IC0gZG8geW91IGhhdmUg
c29tZSBuaWNlIHRlc3QgY2FzZXMgZm9yIHJlZ3VsYXRvcnMgaGlkZGVuDQo+ID4gc29tZXdoZXJl
PyBJZiBzbywgZG8geW91IHRoaW5rIHlvdSBjb3VsZCBzaGFyZSB0aGVtPyBJIHN1cmUgaGF2ZQ0K
PiA+IHNvbWUNCj4gPiBmb3IgQkQ3MTh4NyBidXQgdGhleSBhcmUgc29tZXdoYXQgY2x1bXN5IGFu
ZCByZXF1aXJlIHNwZWNpYWwgSFcuDQo+ID4gKEkndmUNCj4gPiBuZXZlciBsaWtlZCB1bml0LXRl
c3RzIGJ1dCBJIG11c3QgYWRtaXQgdGhlcmUgYXJlIHNvbWUgc3BlY2lmaWMNCj4gPiBjYXNlcw0K
PiA+IHdoZXJlIHRoZXkgd291bGQgYmUgcHJldHR5IHVzYWJsZSkuDQo+IA0KPiBZb3UgY2FuJ3Qg
cmVhbGx5IHJ1biB0ZXN0cyBvbiBhY3R1YWwgcmVndWxhdG9yIGRyaXZlcnMgb3V0c2lkZSBvZg0K
PiB0ZXN0DQo+IHJpZ3MgYXMgdGhleSdyZSBraW5kIG9mIGltcG9ydGFudCB0byB0aGUgc3lzdGVt
IHRoZXkncmUgcnVubmluZyBpbi4NCg0KUmlnaHQuIEkgd2FzIHRoaW5raW5nIG9mIHNvbWUgdGVz
dHMgd2hpY2ggd291bGQgb25seSBiZSB0ZXN0aW5nIHRoZQ0KdnNlbCBsb2dpYyBieSBmZWVkaW5n
IHRlc3QgcmFuZ2VzIHRvIGZ1bmN0aW9ucyBhbmQgdmVyaWZ5aW5nIHRoZQ0KcmVzdWx0aW5nIHNl
bGVjdG9ycy92b2x0YWdlcyB3ZXJlIGNvcnJlY3QuIFVuaXQgdGVzdCBzdHlsZSB0aGluZyB3aGVy
ZQ0KcGFydCBvZiB0aGUgY29kZSBpcyBzdHViYmVkIG91dCBhbmQgcmVzdCBpcyBjb21waWxlZCBp
bnRvIGEgdGVzdA0KZXhlY3V0YWJsZS4gSSBrbm93IHNvbWUgcGVvcGxlIGRvIHN1Y2ggKGFuZCBJ
IHVzdWFsbHkgZG9uJ3Qgc2VlIHRoZQ0KZWZmb3J0L2JlbmVmaXQgcmF0aW8gdG8gYmUgdG9vIGdy
ZWF0IHRoZXJlIC0gYWx0aG91Z2ggdGhlcmUgYXJlIGNhc2VzDQp3aGVyZSBzdWNoIHRlc3RzIGNh
biBiZSBiZW5lZmljaWFsKS4gU28gSSBkZWNpZGVkIHRvIGFzayBpZiB5b3UgYXJlIG9uZQ0Kb2Yg
dGhvc2Ugd2hvIGRvIHN1Y2ggdGVzdGluZyBhbmQgaGFwcGVuZWQgdG8gaGF2ZSBzdWNoIGZvciBy
ZWd1bGF0b3INCmZ1bmN0aW9ucy4gQnV0IHRoaXMgaXMgY2xlYXIgbm93Lg0KDQpJJ2xsIHRyeSBy
dW5uaW5nIHNvbWUgdGVzdHMgb24gQkQ3MTg0NyBicmVhay1vdXQgYm9hcmQgYXQgdGhlIGVuZCBv
Zg0KUkZDIHBoYXNlIC0gYnV0IEkgZG8gYXBwcmVjaWF0ZSBhbGwgdGhlIHRlc3Rpbmcgb24gb3Ro
ZXIgc3lzdGVtcyBhcw0Kd2VsbCEgVG91Y2hpbmcgdGhlIHJlZ3VsYXRvciBjb3JlIGlzIGEgYml0
IHNjYXJ5IGFzIGl0IGNhbiByZXN1bHQgLi4uDQpwcm9ibGVtcyA6Lw0KDQpCZXN0IFJlZ2FyZHMN
CglNYXR0aSBWYWl0dGluZW4NCg==
