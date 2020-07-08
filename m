Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAD1B218488
	for <lists+linux-pm@lfdr.de>; Wed,  8 Jul 2020 12:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgGHKAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Jul 2020 06:00:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:41354 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726196AbgGHKAk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Jul 2020 06:00:40 -0400
X-UUID: 1ba09f5c50ff4620baf021339969ea33-20200708
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mNBRD0ukUR3We0EMt+SXwtboaBMsJAHJGnz1Pk9Q/bw=;
        b=MeOHIASaSgC9MchyaIOVqbJjEikbT8wid8K2gQCN1g7E92/rQ/dIF5C8BUjVIVTjexpWDNcIsAtw6aDfz1qapoMlliIeCQ96J76I1ih641G4uwlo7m6SaRS1f8mQ60W304uIOv5J3fZm8jD0ME/u6aHjDnqc3GbKYw70xefi42o=;
X-UUID: 1ba09f5c50ff4620baf021339969ea33-20200708
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 662547110; Wed, 08 Jul 2020 18:00:35 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Jul 2020 18:00:31 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Jul 2020 18:00:32 +0800
Message-ID: <1594202433.20216.5.camel@mtksdccf07>
Subject: Re: [v4,7/7] thermal: mediatek: use spinlock to protect PTPCORESEL
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Wed, 8 Jul 2020 18:00:33 +0800
In-Reply-To: <4c9e9abf-1f87-ae68-3827-22df52adfd19@linaro.org>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
         <20200323121537.22697-8-michael.kao@mediatek.com>
         <1afbf412-fbeb-8abe-66d8-bd7ac4e9dd83@linaro.org>
         <1591329023.12739.0.camel@mtksdccf07>
         <4c9e9abf-1f87-ae68-3827-22df52adfd19@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVHVlLCAyMDIwLTA3LTA3IGF0IDEwOjEzICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gT24gMDUvMDYvMjAyMCAwNTo1MCwgTWljaGFlbCBLYW8gd3JvdGU6DQo+ID4gT24gRnJpLCAy
MDIwLTA1LTIyIGF0IDE3OjM2ICswMjAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToNCj4gPj4gT24g
MjMvMDMvMjAyMCAxMzoxNSwgTWljaGFlbCBLYW8gd3JvdGU6DQo+ID4+PiBGcm9tOiAibWljaGFl
bC5rYW8iIDxtaWNoYWVsLmthb0BtZWRpYXRlay5jb20+DQo+ID4+Pg0KPiA+Pj4gVGhlIGRyaXZl
ciBvZiB0aGVybWFsIGFuZCBzdnMgd2lsbCB1c2UgdGhlDQo+ID4+PiBzYW1lIHJlZ2lzdGVyIGZv
ciB0aGUgcHJvamVjdCB3aGljaCBzaG91bGQgc2VsZWN0DQo+ID4+PiBiYW5rIGJlZm9yZSByZWFk
aW5nIHNlbnNvciB2YWx1ZS4NCj4gPj4NCj4gPj4gSGVyZSB0aGVyZSBpcyBhIGRlc2lnbiBwcm9i
bGVtIEFGQUlDVC4gVGhlIHNlbnNvciBzaG91bGQgbm90IGJlIHVzaW5nDQo+ID4+IGV4dGVybmFs
IGxvY2tzLg0KPiA+Pg0KPiA+IFRoZSBQVFBDT1JFU0VMIGlzIGEgY29tbW9uIHJlZ2lzdGVyIHVz
ZWQgYnkgc3ZzIGFuZCB0aGVybWFsLg0KPiA+IFRoZSB0aGVybWFsIG5lZWQgdG8gZW5zdXJlIFBU
UENPUkVTRUwgcmVnaXN0ZXIgd2lsbCBub3QgYmUgY2hhbmdlZCBieQ0KPiA+IHN2cyB3aGVuIHRo
ZXJtYWwgc3dpdGNoIGJhbmsgdG8gcmVhZCByYXcgZGF0YSBvZiB0ZW1wZXJhdHVyZS4NCj4gPiBT
byB3ZSB1c2Ugc3ZzX2xvY2sgdG8gbWFrZSBzdXJlIHRoZXJlIGlzIG5vIGNvbmZsaWN0IGJldHdl
ZW4gdGhlIHR3bw0KPiA+IGRyaXZlcnMuDQo+IA0KPiBXaHkgbm90IHVzZSByZWdtYXAgPw0KPiAN
CkhpIERhbmllbCwNCg0KV2UgYXJlIG5vdCBzdXJlIHRoZSByZWdtYXAgY2FuIHNvbHZlIHRoZSBw
cm9ibGVtLg0KVGhlIHJlZ21hcCBjYW4gbG9jayBDT1JFU0VMRUNULiBCdXQgaXQgY2FuIG5vdCBw
cm90ZWN0IA0KdGhlIG90aGVyIHNlbnNvcnMgcmVnaXN0ZXJzIHdoaWNoIHRoZXJtYWwgY29udHJv
bGxlciBzdGFydCB0bw0KcmVhZCB0ZW1wZXJhdHVyZSBuZWVkIHRvIGFjY2Vzcy4NCg0KQWZ0ZXIg
aW50ZXJuYWwgZGlzc2N1c3Npb24sIHdlIGRvbid0IGhhdmUgdGhpcyBraW5kIG9mIGV4cGVyaWVu
Y2UgdG8NCnVzZSByZWdtYXAgdG8gcHJvdGVjdCBzb21lIHBlaWNlIG9mIGNvZGUuDQpXZSB3aWxs
IGRvIHNvbWUgcmVzZWFyY2ggb2YgdGhpcyBraW5kIG9mIHVzYWdlLg0KVGhhbmtzIGZvciB5b3Vy
IHN1Z2dlc3Rpb24uDQoNCj4gPj4+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgS2FvIDxtaWNoYWVs
Lmthb0BtZWRpYXRlay5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICBkcml2ZXJzL3RoZXJtYWwvbXRr
X3RoZXJtYWwuYyB8IDkgKysrKy0tLS0tDQo+ID4+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPj4+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90aGVybWFsL210a190aGVybWFsLmMgYi9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0K
PiA+Pj4gaW5kZXggOWVhY2E0MzI5MjBlLi41OTRhZDRmMGY4Y2QgMTAwNjQ0DQo+ID4+PiAtLS0g
YS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KPiA+Pj4gKysrIGIvZHJpdmVycy90aGVy
bWFsL210a190aGVybWFsLmMNCj4gPj4+IEBAIC0yMiw2ICsyMiw3IEBADQo+ID4+PiAgI2luY2x1
ZGUgPGxpbnV4L3RoZXJtYWwuaD4NCj4gPj4+ICAjaW5jbHVkZSA8bGludXgvcmVzZXQuaD4NCj4g
Pj4+ICAjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gPj4+ICsjaW5jbHVkZSA8bGludXgvcG93
ZXIvbXRrX3N2cy5oPg0KPiA+Pj4gIA0KPiA+Pj4gIC8qIEFVWEFEQyBSZWdpc3RlcnMgKi8NCj4g
Pj4+ICAjZGVmaW5lIEFVWEFEQ19DT04xX1NFVF9WCTB4MDA4DQo+ID4+PiBAQCAtMjYyLDcgKzI2
Myw3IEBAIHN0cnVjdCBtdGtfdGhlcm1hbCB7DQo+ID4+PiAgCXN0cnVjdCBjbGsgKmNsa19wZXJp
X3RoZXJtOw0KPiA+Pj4gIAlzdHJ1Y3QgY2xrICpjbGtfYXV4YWRjOw0KPiA+Pj4gIAkvKiBsb2Nr
OiBmb3IgZ2V0dGluZyBhbmQgcHV0dGluZyBiYW5rcyAqLw0KPiA+Pj4gLQlzdHJ1Y3QgbXV0ZXgg
bG9jazsNCj4gPj4+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPj4+ICANCj4gPj4+ICAJLyog
Q2FsaWJyYXRpb24gdmFsdWVzICovDQo+ID4+PiAgCXMzMiBhZGNfZ2U7DQo+ID4+PiBAQCAtNTYx
LDcgKzU2Miw3IEBAIHN0YXRpYyB2b2lkIG10a190aGVybWFsX2dldF9iYW5rKHN0cnVjdCBtdGtf
dGhlcm1hbF9iYW5rICpiYW5rKQ0KPiA+Pj4gIAl1MzIgdmFsOw0KPiA+Pj4gIA0KPiA+Pj4gIAlp
ZiAobXQtPmNvbmYtPm5lZWRfc3dpdGNoX2JhbmspIHsNCj4gPj4+IC0JCW11dGV4X2xvY2soJm10
LT5sb2NrKTsNCj4gPj4+ICsJCW10LT5mbGFncyA9IGNsYWltX210a19zdnNfbG9jaygpOw0KPiA+
Pj4gIA0KPiA+Pj4gIAkJdmFsID0gcmVhZGwobXQtPnRoZXJtYWxfYmFzZSArIFBUUENPUkVTRUwp
Ow0KPiA+Pj4gIAkJdmFsICY9IH4weGY7DQo+ID4+PiBAQCAtNTgxLDcgKzU4Miw3IEBAIHN0YXRp
YyB2b2lkIG10a190aGVybWFsX3B1dF9iYW5rKHN0cnVjdCBtdGtfdGhlcm1hbF9iYW5rICpiYW5r
KQ0KPiA+Pj4gIAlzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10ID0gYmFuay0+bXQ7DQo+ID4+PiAgDQo+
ID4+PiAgCWlmIChtdC0+Y29uZi0+bmVlZF9zd2l0Y2hfYmFuaykNCj4gPj4+IC0JCW11dGV4X3Vu
bG9jaygmbXQtPmxvY2spOw0KPiA+Pj4gKwkJcmVsZWFzZV9tdGtfc3ZzX2xvY2sobXQtPmZsYWdz
KTsNCj4gPj4+ICB9DQo+ID4+PiAgDQo+ID4+PiAgLyoqDQo+ID4+PiBAQCAtOTM4LDggKzkzOSw2
IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldikNCj4gPj4+ICAJaWYgKHJldCkNCj4gPj4+ICAJCXJldHVybiByZXQ7DQo+ID4+PiAgDQo+
ID4+PiAtCW11dGV4X2luaXQoJm10LT5sb2NrKTsNCj4gPj4+IC0NCj4gPj4+ICAJbXQtPmRldiA9
ICZwZGV2LT5kZXY7DQo+ID4+PiAgDQo+ID4+PiAgCWF1eGFkYyA9IG9mX3BhcnNlX3BoYW5kbGUo
bnAsICJtZWRpYXRlayxhdXhhZGMiLCAwKTsNCj4gPj4+DQo+ID4+DQo+ID4+DQo+ID4gDQo+IA0K
PiANCg0K

