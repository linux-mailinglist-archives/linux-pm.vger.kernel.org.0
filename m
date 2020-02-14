Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30F215D770
	for <lists+linux-pm@lfdr.de>; Fri, 14 Feb 2020 13:32:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728036AbgBNMc0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 14 Feb 2020 07:32:26 -0500
Received: from mailgate1.rohmeurope.com ([178.15.145.194]:46058 "EHLO
        mailgate1.rohmeurope.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgBNMc0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2020 07:32:26 -0500
X-AuditID: c0a8fbf4-279ff70000001e6c-3f-5e4693575a8a
Received: from smtp.reu.rohmeu.com (will-cas002.reu.rohmeu.com [192.168.251.178])
        by mailgate1.rohmeurope.com (Symantec Messaging Gateway) with SMTP id 05.BE.07788.753964E5; Fri, 14 Feb 2020 13:32:23 +0100 (CET)
Received: from WILL-MAIL002.REu.RohmEu.com ([fe80::e0c3:e88c:5f22:d174]) by
 WILL-CAS002.REu.RohmEu.com ([fe80::fc24:4cbc:e287:8659%12]) with mapi id
 14.03.0439.000; Fri, 14 Feb 2020 13:32:11 +0100
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
Thread-Index: AQHV4At5sLPMospsI0G2S3c08J9KoagWS84AgADGiACAA3X4gIAADG2A
Date:   Fri, 14 Feb 2020 12:32:10 +0000
Message-ID: <375c7756fca56de4f2f85d1a1a4e0b01dadc290b.camel@fi.rohmeurope.com>
References: <cover.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20b107ac6e40206b82d014a145abe0569d7a6f81.1581327762.git.matti.vaittinen@fi.rohmeurope.com>
         <20200211190614.GP4543@sirena.org.uk>
         <cb9ed43aafcd8e1f6af05bfec8108ee8c14af265.camel@fi.rohmeurope.com>
         <20200214114749.GB4827@sirena.org.uk>
In-Reply-To: <20200214114749.GB4827@sirena.org.uk>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [213.255.186.46]
Content-Type: text/plain; charset="utf-8"
Content-ID: <338D36A977CBAD4794E1D9E2E0B91542@de.rohmeurope.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprCJsWRmVeSWpSXmKPExsVyYMXvTbrhk93iDNo7LCymPnzCZjH/yDlW
        iyl/ljNZXN41h83ic+8RRoul1y8yWcxZeoLFonXvEXaL07tLHDg91sxbw+ixc9Zddo9NqzrZ
        PO5c28Pm8XmTXABrFLdNUmJJWXBmep6+XQJ3xpY7L1kLpihXvL3RwtrAuECpi5GTQ0LARKJ5
        83umLkYuDiGBq4wS99c3MUI4JxglHlzbyt7FyMHBJmAj0XWTHaRBREBXYuqvxWwgNcwCk1gk
        PnTvZAFJCAu4Skx6cpUZoshN4mTjRTj7ye/7rCA2i4CqxNpDh8HivAJ+Eue3HYbavJtJoq1n
        FVgRp4CRxOul88G2MQrISnQ2vGMCsZkFxCU2PfvOCnG2gMSSPeeZIWxRiZeP/0HFlST2/nzI
        AnI0s4CmxPpd+hCtDhJ/py1kgbAVJaZ0P2SHuEFQ4uTMJywTGMVmIdkwC6F7FpLuWUi6ZyHp
        XsDIuopRIjcxMyc9sSTVUK8otVSvKD8jF0gl5+duYoTE75cdjP8PeR5iZOJgPMQoycGkJMrL
        2eQWJ8SXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE97AiUI43JbGyKrUoHyYlzcGiJM6r/nBirJAA
        yK7s1NSC1CKYrAwHh5IE75eJQI2CRanpqRVpmTklCGkmDk6Q4VxSIsWpeSmpRYmlJRnxoAQS
        XwxMISApHqC9a0DaeYsLEnOBohCtpxgNOSa8nLuImWPz3KVA8giIFGLJy89LlRLnvQvSIADS
        kFGaB7fuFaM4B6OSMO8LkCwPMKnDTXsFtIgJaFGvpgvIopJEhJRUA6PCCmcvo/V3fscc2Ga5
        tZLzxeb1aSq7PrO9zhdfXlla5sp70TPyannUUaGHO2vlFW+vO5XRwij8XLAvaZ7W+4fPdRlu
        pBzSyLKy4Kn8IvzDeevl0JmfAxmfbnvLLzZ5V9F9tSb9GNtTez5tz/39XCG4+EWu++kN8/qt
        lnUefHkjJeieU0hbALsSS3FGoqEWc1FxIgBFjNffpwMAAA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

DQpPbiBGcmksIDIwMjAtMDItMTQgYXQgMTE6NDcgKzAwMDAsIE1hcmsgQnJvd24gd3JvdGU6DQo+
IE9uIFdlZCwgRmViIDEyLCAyMDIwIGF0IDA2OjU2OjM3QU0gKzAwMDAsIFZhaXR0aW5lbiwgTWF0
dGkgd3JvdGU6DQo+ID4gT24gVHVlLCAyMDIwLTAyLTExIGF0IDE5OjA2ICswMDAwLCBNYXJrIEJy
b3duIHdyb3RlOg0KPiA+ID4gTm90ZSBhbHNvIHRoYXQgd2UgYWxyZWFkeSBoYXZlIHF1aXRlIGV4
dGVuc2l2ZSBoZWxwZXJzIGZvciB0aGlzDQo+ID4gPiBzb3J0DQo+ID4gPiBvZg0KPiA+ID4gc3R1
ZmYgaW4gdGhlIHJlZ3VsYXRvciBBUEkgd2hpY2ggSSBzZW5zZSBtYXkgaGF2ZSBiZWVuIGludm9s
dmVkDQo+ID4gPiBpbg0KPiA+ID4gdGhpcw0KPiA+ID4gaW1wbGVtZW50YXRpb24NCj4gPiBZb3Ug
c2Vuc2Ugd2VsbCB4RA0KPiANCj4gSWYgeW91J3JlIGZhY3RvcmluZyBzdHVmZiBvdXQgb2YgYW4g
ZXhpc3RpbmcgaW1wbGVtZW50YXRpb24gaXQnZCBiZQ0KPiBnb29kDQo+IHRvIGV4cGxpY2l0bHkg
ZG8gdGhhdCAtIHRoaXMgYm90aCBzaG93cyB3aGVyZSB0aGluZ3MgY2FtZSBmcm9tIGFuZA0KPiBh
bHNvDQo+IG1lYW5zIHRoYXQgeW91IGNhbiBzaG93IHRoYXQgdGhlIGV4aXN0aW5nIHVzZXIgd29y
a3Mgd2l0aCB0aGUgbmV3DQo+IGNvZGUNCj4gd2hpY2ggaXMgZ29vZC4NCg0KVHJ1ZS4gQnV0IEkg
ZGlkbid0IHJlZmFjdG9yIHRoZSByZWd1bGF0b3IgY29kZSAtIEkgc3RvbGUgdGhlIGlkZWEgYW5k
DQp3cm90ZSB0aGlzIHRoaW5nIGluIEJENzA1MjggcG93ZXItc3VwcGx5IGRyaXZlci4gSSBkaWRu
J3QgdGhpbmsgb2YNCmNyZWF0aW5nIGdlbmVyaWMgaGVscGVyIHVudGlsIExpbnVzIFcgbWVudGlv
bmVkIHdlIHNob3VsZCBjcmVhdGUgb25lLg0KDQpTbyBub3cgd2hlbiBJIGRpZCB0aGUgQkQ5OTk1
NCBkcml2ZXIgYW5kIG5vdGljZWQgSSBuZWVkZWQgc2FtZSBoZWxwZXINCmluIHBvd2VyLXN1cHBs
eSBhcmVhIGFnYWluIEkgZGVjaWRlZCB0byBnZXQgdGhlIGltcGxlbWVudGF0aW9uIEkgZGlkIGlu
DQpCRDcwNTI4IGRyaXZlciBhbmQgbWFrZSBpdCBhdmFpbGFibGUgZm9yIGFsbC4gVGhhdCB3YXMg
YSBsb3ctaGFuZ2luZw0KZnJ1aXQgZm9yIG1lIGFzIEkgYXV0aG9yZWQgdGhlIEJENzA1MjggYW5k
IGtub3cgdGhlIGxpbmVhci1yYW5nZSBjb2RlDQp3YXMgZWFzeSB0byBwdWxsIG91dCBvZiB0aGUg
QkQ3MDUyOC4gQ2hhbmdpbmcgdGhlIHJlZ3VsYXRvciBzeXN0ZW0gd2FzDQpub3QgYXMgZWFzeSBm
b3IgbWUgLSBhbHRob3VnaCBpdCBpcyBkb2FibGUuDQoNCj4gPiBCdXQgYW5vdGhlciBvcHRpb24g
LSB3aGljaCBJIHRob3VnaHQgb25seSBub3cgLSB3b3VsZCBiZSB0byBzZWUgaWYNCj4gPiBjdXJy
ZW50IHJlZ3VsYXRvciBpbXBsZW1lbnRhdGlvbiBjb3VsZCBiZSByZS1uYW1lZCB0byBtb3JlIGdl
bmVyaWMNCj4gPiBhbmQNCj4gPiBwbGFjZWQgdW5kZXIgc29tZSBtb3JlIGdlbmVyaWMgY29tcG9u
ZW50IChJIHRob3VnaHQgb2YgcmVnbWFwIGJ1dA0KPiA+IGFzDQo+ID4geW91IHBvaW50ZWQgb3V0
IHRoaXMgaXMgZXF1YWxseSB1c2VmdWxsIGZvciBkZXZpY2VzIGNvbm5lY3RlZCB0bw0KPiA+IG1l
bW9yeQ0KPiA+IG1hcHBlZCBidXNlcyAtIHNvIG1heWJlIHVuZGVyIGxpYiAtIGlmIHN0YXRpYyBp
bmxpbmUgZnVuY3Rpb25zIGluIGENCj4gPiBoZWFkZXIgYXJlIG5vdCBhIGdvb2Qgb3B0aW9uKS4g
SSBqdXN0IGhhdmUgYSBmZWVsaW5nIHRoYXQgdGhlDQo+ID4gbGluZWFyLQ0KPiA+IHJhbmdlcyBp
cyBjdXJyZW50bHkga2luZCBvZiBlbWJlZGRlZCBpbiB0aGUgY29kZSB3aGljaCBpcyBpbnRlcm5h
bA0KPiA+IHRvDQo+ID4gcmVndWxhdG9yIGZyYW1ld29yayBzbyBpdCBpcyBwcm9iYWJseSBub3Qg
ZWFzaWx5IGV4dHJhY3RlZCBmcm9tDQo+ID4gcmVndWxhdG9yIGNvZGU/DQo+IA0KPiBJdCBpcyBh
IGJpdCBidXQgSSB0aGluayB0aGF0J3Mgc29sdmFibGUgd2l0aCBzb21lIHJlZmFjdG9yaW5nIGlu
DQo+IHBsYWNlDQo+IChlZywgcHVzaGluZyB0aGluZ3MgaW50byBhIHNtYWxsZXIgc3RydWN0IGVt
YmVkZGVkIGluIHRoZSBtYWluDQo+IHJlZ3VsYXRvcg0KPiBvbmUgYW5kIHRoZW4gbW92aW5nIHRo
ZW0gb3V0KS4gIEkgbWlnaHQgbG9vayBhdCBpdCBteXNlbGYgaWYgbm9ib2R5DQo+IGVsc2UNCj4g
Z2V0cyB0byBpdCBmaXJzdC4uLg0KDQpJIG5lZWQgc29tZXRoaW5nIGxpa2UgdGhpcyBpbiBvcmRl
ciB0byBjb252ZXJ0IEJEOTk5NTQgY3VycmVudCBhbmQNCnZvbHRhZ2UgdmFsdWVzIHRvIHJlZ2lz
dGVyIHZhbHVlcy4gSSB3aWxsIGhhcHBpbHkgdXNlIHdoYXQtZXZlciB5b3UgZG8NCnB1bGwgdG9n
ZXRoZXIgLSBidXQgaWYgeW91IGRvbid0IGZlZWwgbGlrZSBkb2luZyBpdCBub3cgSSBtaWdodCBs
b29rIGF0DQp0aGUgcmVndWxhdG9yIHBhcnQgd2hpbGUgSSBhbSB3b3JraW5nIHdpdGggQkQ5OTk1
NCBhbnl3YXlzLiBQbGVhc2UganVzdA0KbGV0IG1lIGtub3cgaWYgeW91IHdhbnQgbWUgdG8gc2Vl
IGlmIEkgY2FuIHB1bGwgdGhlIHJhbmdlIHN0dWZmIG91dCBvZg0KcmVndWxhdG9yIGFyZWEuDQoN
Cj4gPiBTbyBpZiB3ZSBkbyBub3Qgc3RhcnQgcHVsbGluZyB0aGUgcmFuZ2UgY29kZSBvdXQgb2Yg
cmVndWxhdG9yDQo+ID4gZnJhbWV3b3JrDQo+ID4gKGZvciBub3cgYXQgbGVhc3QpIC0gYW5kIGlm
IHdlIGRvIG5vdCBwbGFjZSB0aGlzIHVuZGVyIHJlZ21hcCAtDQo+ID4gdGhlbiBJDQo+ID4gY2Fu
IGRyb3AgeW91IG91dCBvZiB0aGUgcmVjaXBpZW50IGxpc3QgZm9yIHRoaXMgY2hhcmdlciBkcml2
ZXIgaW4NCj4gPiBvcmRlcg0KPiA+IHRvIG5vdCBwb2xsdXRlIHlvdXIgaW5ib3ggOykgSG93IGRv
IHlvdSBmZWVsIE1hcmssIGRvIHlvdSB3YW50IHRvDQo+ID4gYmUNCj4gPiBmb2xsb3dpbmcgdGhp
cyBzZXJpZXM/DQo+IA0KPiBXZWxsLCBpZiB0aGVyZSdzIGEgcmVmYWN0b3Jpbmcgb3V0IG9mIHRo
ZSByZWd1bGF0b3IgY29kZSBnb2luZyBvbg0KPiBJJ2xsDQo+IG5lZWQgdG8gbG9vayBhdCB0aGF0
IGFueXdheS4NCg0KTXkgZmlyc3QgaWRlYSB3YXMgbm90IHRvIGNoYW5nZSB0aGUgcmVndWxhdG9y
cyBub3cgLSBoZW5jZSBJIGFza2VkIGlmIEkNCnNob3VsZCBkcm9wIHlvdS4gQnV0IEkgZGVmaW5p
dGVseSBuZWVkIHlvdXIgc3VwcG9ydCBpZiB3ZSBkZWNpZGUgdG8NCnJlZmFjdG9yIHRoZSByZWd1
bGF0b3IgY29kZSBpbiB0aGlzIHNlcmllcyBhbmQgY3JlYXRlIHRoZXNlIGNvbW1vbg0KaGVscGVy
cyBvdXQgb2YgaXQuDQoNCkJyLA0KCU1hdHRpIFZhaXR0aW5lbg0K
