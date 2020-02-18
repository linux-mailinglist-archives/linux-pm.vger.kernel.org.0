Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1860D162179
	for <lists+linux-pm@lfdr.de>; Tue, 18 Feb 2020 08:23:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbgBRHXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 18 Feb 2020 02:23:45 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:64016 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgBRHXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 18 Feb 2020 02:23:45 -0500
X-AuditID: c0a8fbf4-489ff70000004419-60-5e4b90ff5c3c
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 0D.8D.17433.FF09B4E5; Tue, 18 Feb 2020 08:23:43 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Tue, 18 Feb 2020 08:23:39 +0100
From:   "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
To:     "broonie@kernel.org" <broonie@kernel.org>
CC:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>,
        "sre@kernel.org" <sre@kernel.org>,
        "Laine, Markus" <Markus.Laine@fi.rohmeurope.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Thread-Topic: [RFC PATCH 2/3] power: (regmap:) Add linear_range helper
Thread-Index: AQHV4At5sLPMospsI0G2S3c08J9KoagWS84AgADGiACAA3X4gIAADG2AgAXzFoA=
Date:   Tue, 18 Feb 2020 07:23:38 +0000
Message-ID: <208a81c87e944c69d95da85d7fd0f3ea2bd61547.camel@fi.rohmeurope.com>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20200211190614.GP4543@sirena.org.uk>
         <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
         <20200214114749.GB4827@sirena.org.uk>
         <375c7756fca56de4f2f85d1a1a4e0b01dadc290b.camel@fi.rohmeurope.com>
In-Reply-To: <375c7756fca56de4f2f85d1a1a4e0b01dadc290b.camel@fi.rohmeurope.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <08DBE84724581D40814E2FDDE1264D17@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf0gTURzn3d3O88flOWd7rR/QIKL8VdAfJ0kIVsxMK8OiyNnVLrdym91u
        YgWxiqRtRdOyH2NWpFKIGC0HalqxFlqiKWGZFWVKpUQFCvZ73eOq+df7vO/n14P3pXClk9RQ
        JovICxauVEvGEPeu//Cnhj25+mWBYCpbMzJGspdDfQr27M9rGPuk3Ueyk6dCgG14NoCxvoZu
        gj3eGYpie26LWdG6pktNQNfmfRWl8zc6Sd3Lpx2kbtK/YKNie2zmLk4s32wqsaSv2hlrfFup
        KeuPr3hzbZx0AF+8C0RTkFkB+1w9CheIoZTMIICBW7V/L90A9r85AVyAokgmE7qeRyGDikmF
        Nd/rSKTBmWoCfnG3EYhIZNbA6rFBXBathQ+PDODIq2LyYfNoMoIEswj+7C1HClqa+pqdQK46
        gsPm3rACEdHMBjjU/YREGDDzodPxCUMYZ9TQ/25aIT+agfUdj3EZJ8Hx0d9/51rY+W2EQF04
        swTeaE+XYRasP7dFTlkIz7pHouQnJMCHF8cID5jtnVHgjZi9EbN3htk7w3wFKBoBNHOm0hJO
        5JenCbw9TbAazdKx22r2A/lrp1pBOJgTBBgFgmAOhWmT6MrsXL1y1i6r4YCRsxmLBXspbwsC
        SOFaFZ2rXqdX0gbuwEFesP6j5lKEVk0vHqkqUjKoax/Pl/HCP3YeRWkhnXJaCk0Q+BK+Yo+p
        VIzQGBWNwmM0KhtvMfACZxeNxWg3im3SciAqTurNQXbaVsaZpalsfQSSKc947VWcCtU2XMWV
        hMVq4TVqmkZSBkmNdsv/ogmgpoA2UQ6Kk/b7f86EVIFJFeICHaoQuQilcYDzgdEPaVV0bbo+
        692Or5sq9xo6pz6fOZqReH+D2bZ6cuvKOuuhcCI5GkhRLerqPJWin46vP8N99A4MuwfvFBcU
        Zrc9X9xzIZz24uavte79h8Y8rV0Tpry7ysP3FmZ05Yewmuy8rG3VOXEtQ0Wr+x4UtKx3iK89
        B9+fLJw30bh7+FiVlrAZueVLccHG/QHBGMn1nAMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TW9ybmluZyBNYXJrLA0KDQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTQ6MzIgKzAyMDAsIE1hdHRp
IFZhaXR0aW5lbiB3cm90ZToNCj4gT24gRnJpLCAyMDIwLTAyLTE0IGF0IDExOjQ3ICswMDAwLCBN
YXJrIEJyb3duIHdyb3RlOg0KPiA+IE9uIFdlZCwgRmViIDEyLCAyMDIwIGF0IDA2OjU2OjM3QU0g
KzAwMDAsIFZhaXR0aW5lbiwgTWF0dGkgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIDIwMjAtMDItMTEg
YXQgMTk6MDYgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+ID4gPiA+IA0KPiA+IA0KPiA+IEl0
IGlzIGEgYml0IGJ1dCBJIHRoaW5rIHRoYXQncyBzb2x2YWJsZSB3aXRoIHNvbWUgcmVmYWN0b3Jp
bmcgaW4NCj4gPiBwbGFjZQ0KPiA+IChlZywgcHVzaGluZyB0aGluZ3MgaW50byBhIHNtYWxsZXIg
c3RydWN0IGVtYmVkZGVkIGluIHRoZSBtYWluDQo+ID4gcmVndWxhdG9yDQo+ID4gb25lIGFuZCB0
aGVuIG1vdmluZyB0aGVtIG91dCkuICBJIG1pZ2h0IGxvb2sgYXQgaXQgbXlzZWxmIGlmIG5vYm9k
eQ0KPiA+IGVsc2UNCj4gPiBnZXRzIHRvIGl0IGZpcnN0Li4uDQo+IA0KPiBJIG5lZWQgc29tZXRo
aW5nIGxpa2UgdGhpcyBpbiBvcmRlciB0byBjb252ZXJ0IEJEOTk5NTQgY3VycmVudCBhbmQNCj4g
dm9sdGFnZSB2YWx1ZXMgdG8gcmVnaXN0ZXIgdmFsdWVzLiBJIHdpbGwgaGFwcGlseSB1c2Ugd2hh
dC1ldmVyIHlvdQ0KPiBkbw0KPiBwdWxsIHRvZ2V0aGVyIC0gYnV0IGlmIHlvdSBkb24ndCBmZWVs
IGxpa2UgZG9pbmcgaXQgbm93IEkgbWlnaHQgbG9vaw0KPiBhdA0KPiB0aGUgcmVndWxhdG9yIHBh
cnQgd2hpbGUgSSBhbSB3b3JraW5nIHdpdGggQkQ5OTk1NCBhbnl3YXlzLiBQbGVhc2UNCj4ganVz
dA0KPiBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtZSB0byBzZWUgaWYgSSBjYW4gcHVsbCB0aGUg
cmFuZ2Ugc3R1ZmYgb3V0DQo+IG9mDQo+IHJlZ3VsYXRvciBhcmVhLg0KDQpKdXN0IHRvIGF2b2lk
IGR1cGxpY2F0ZSB3b3JrIC0gSSBzdGFydGVkIHdvcmtpbmcgd2l0aCB0aGlzLiBQbGVhc2UgbGV0
DQptZSBrbm93IGlmIHlvdSBhcmUgYWxyZWFkeSB3b3JraW5nIG9uIGl0IHNvIEkgYW0gbm90IGRv
aW5nIHRoaXMgaW4NCnZhaW4uDQoNCkJ5IHRoZSB3YXkgLSBkbyB5b3UgaGF2ZSBzb21lIG5pY2Ug
dGVzdCBjYXNlcyBmb3IgcmVndWxhdG9ycyBoaWRkZW4NCnNvbWV3aGVyZT8gSWYgc28sIGRvIHlv
dSB0aGluayB5b3UgY291bGQgc2hhcmUgdGhlbT8gSSBzdXJlIGhhdmUgc29tZQ0KZm9yIEJENzE4
eDcgYnV0IHRoZXkgYXJlIHNvbWV3aGF0IGNsdW1zeSBhbmQgcmVxdWlyZSBzcGVjaWFsIEhXLiAo
SSd2ZQ0KbmV2ZXIgbGlrZWQgdW5pdC10ZXN0cyBidXQgSSBtdXN0IGFkbWl0IHRoZXJlIGFyZSBz
b21lIHNwZWNpZmljIGNhc2VzDQp3aGVyZSB0aGV5IHdvdWxkIGJlIHByZXR0eSB1c2FibGUpLg0K
DQpCZXN0IFJlZ2FyZHMsDQoJTWF0dGkgVmFpdHRpbmVuDQo=
