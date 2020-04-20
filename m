Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969131B085E
	for <lists+linux-pm@lfdr.de>; Mon, 20 Apr 2020 13:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgDTLz1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 07:55:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:50298 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726496AbgDTLz0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 07:55:26 -0400
X-UUID: 8cbfb7c460d0456ca6432414d944c442-20200420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=G75ycipgYh3BzGzGfO3AsO2FJWOZiqx83AQbRPGl/w4=;
        b=ukae1GDHcJMmsq2JCdcQfACm1ErS6V0y9GxlzzhgRVsntqwu7/tMG6z1bbznV/WKGANPXmHMsO2fNaq/yhOVs1SyMJK1NRYHJfwr2zXOaWpAJYKI5o84NJmwxcdn7FDs9x2OsISvWOB2MN5F0sHnG+oQTbQXoDqhhromAMsEcKc=;
X-UUID: 8cbfb7c460d0456ca6432414d944c442-20200420
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1819460659; Mon, 20 Apr 2020 19:55:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 20 Apr 2020 19:55:11 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 20 Apr 2020 19:55:11 +0800
Message-ID: <1587383712.11642.0.camel@mtksdaap41>
Subject: Re: [PATCH v12 1/6] mfd: mt6397: Modify suspend/resume behavior
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        "Richard Fontana" <rfontana@redhat.com>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ran Bi <ran.bi@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Josef Friedl <josef.friedl@speed.at>,
        <srv_heupstream@mediatek.com>, Sebastian Reichel <sre@kernel.org>
Date:   Mon, 20 Apr 2020 19:55:12 +0800
In-Reply-To: <20200420111522.GB3612@dell>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1586333531-21641-2-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200416084910.GX2167633@dell> <1587379959.6297.2.camel@mtksdaap41>
         <20200420111522.GB3612@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQoNCk9uIE1vbiwgMjAyMC0wNC0yMCBhdCAxMjoxNSArMDEwMCwgTGVlIEpvbmVzIHdyb3Rl
Og0KPiBPbiBNb24sIDIwIEFwciAyMDIwLCBIc2luLWhzaXVuZyBXYW5nIHdyb3RlOg0KPiANCj4g
PiBIaSwNCj4gPiANCj4gPiBPbiBUaHUsIDIwMjAtMDQtMTYgYXQgMDk6NDkgKzAxMDAsIExlZSBK
b25lcyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgMDggQXByIDIwMjAsIEhzaW4tSHNpdW5nIFdhbmcg
d3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gU29tZSBwbWljcyBkb24ndCBuZWVkIGJhY2t1cCBpbnRl
cnJ1cHQgc2V0dGluZ3MsIHNvIHdlIGNoYW5nZSB0byB1c2UNCj4gPiA+ID4gcG0gbm90aWZpZXIg
Zm9yIHRoZSBwbWljcyB3aGljaCBhcmUgbmVjZXNzYXJ5IHRvIHN0b3JlIHNldHRpbmdzLg0KPiA+
ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8aHNpbi1oc2l1
bmcud2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgZHJpdmVycy9tZmQv
bXQ2Mzk3LWNvcmUuYyAgICAgICB8IDMwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+ID4gPiAgZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jICAgICAgICB8IDM1ICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9tdDYz
OTcvY29yZS5oIHwgIDIgKysNCj4gPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9u
cygrKSwgMzEgZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZmQvbXQ2Mzk3LWNvcmUuYyBiL2RyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMNCj4gPiA+
ID4gaW5kZXggMDQzN2M4NS4uZDJlNzBkOCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9t
ZmQvbXQ2Mzk3LWNvcmUuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5j
DQo+ID4gPiA+IEBAIC0xMDAsMzUgKzEwMCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWZkX2Nl
bGwgbXQ2Mzk3X2RldnNbXSA9IHsNCj4gPiA+ID4gIAl9DQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiAg
DQo+ID4gPiA+IC0jaWZkZWYgQ09ORklHX1BNX1NMRUVQDQo+ID4gPiA+IC1zdGF0aWMgaW50IG10
NjM5N19pcnFfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gPiA+IC17DQo+ID4gPiA+
IC0Jc3RydWN0IG10NjM5N19jaGlwICpjaGlwID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQo+ID4g
PiA+IC0NCj4gPiA+ID4gLQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLCBjaGlwLT5pbnRfY29u
WzBdLCBjaGlwLT53YWtlX21hc2tbMF0pOw0KPiA+ID4gPiAtCXJlZ21hcF93cml0ZShjaGlwLT5y
ZWdtYXAsIGNoaXAtPmludF9jb25bMV0sIGNoaXAtPndha2VfbWFza1sxXSk7DQo+ID4gPiA+IC0N
Cj4gPiA+ID4gLQllbmFibGVfaXJxX3dha2UoY2hpcC0+aXJxKTsNCj4gPiA+ID4gLQ0KPiA+ID4g
PiAtCXJldHVybiAwOw0KPiA+ID4gPiAtfQ0KPiA+ID4gPiAtDQo+ID4gPiA+IC1zdGF0aWMgaW50
IG10NjM5N19pcnFfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiA+ID4gLXsNCj4gPiA+
ID4gLQlzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCj4g
PiA+ID4gLQ0KPiA+ID4gPiAtCXJlZ21hcF93cml0ZShjaGlwLT5yZWdtYXAsIGNoaXAtPmludF9j
b25bMF0sIGNoaXAtPmlycV9tYXNrc19jdXJbMF0pOw0KPiA+ID4gPiAtCXJlZ21hcF93cml0ZShj
aGlwLT5yZWdtYXAsIGNoaXAtPmludF9jb25bMV0sIGNoaXAtPmlycV9tYXNrc19jdXJbMV0pOw0K
PiA+ID4gPiAtDQo+ID4gPiA+IC0JZGlzYWJsZV9pcnFfd2FrZShjaGlwLT5pcnEpOw0KPiA+ID4g
PiAtDQo+ID4gPiA+IC0JcmV0dXJuIDA7DQo+ID4gPiA+IC19DQo+ID4gPiA+IC0jZW5kaWYNCj4g
PiA+ID4gLQ0KPiA+ID4gPiAtc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKG10NjM5N19wbV9vcHMs
IG10NjM5N19pcnFfc3VzcGVuZCwNCj4gPiA+ID4gLQkJCW10NjM5N19pcnFfcmVzdW1lKTsNCj4g
PiA+ID4gLQ0KPiA+ID4gPiAgc3RydWN0IGNoaXBfZGF0YSB7DQo+ID4gPiA+ICAJdTMyIGNpZF9h
ZGRyOw0KPiA+ID4gPiAgCXUzMiBjaWRfc2hpZnQ7DQo+ID4gPiA+IEBAIC0yMzgsNyArMjA5LDYg
QEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgbXQ2Mzk3X2RyaXZlciA9IHsNCj4gPiA+
ID4gIAkuZHJpdmVyID0gew0KPiA+ID4gPiAgCQkubmFtZSA9ICJtdDYzOTciLA0KPiA+ID4gPiAg
CQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIobXQ2Mzk3X29mX21hdGNoKSwNCj4gPiA+
ID4gLQkJLnBtID0gJm10NjM5N19wbV9vcHMsDQo+ID4gPiA+ICAJfSwNCj4gPiA+ID4gIAkuaWRf
dGFibGUgPSBtdDYzOTdfaWQsDQo+ID4gPiA+ICB9Ow0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9tZmQvbXQ2Mzk3LWlycS5jIGIvZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jDQo+ID4gPiA+
IGluZGV4IGIyZDNjZTEuLjI5MjQ5MTkgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMvbWZk
L210NjM5Ny1pcnEuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL21mZC9tdDYzOTctaXJxLmMNCj4g
PiA+ID4gQEAgLTksNiArOSw3IEBADQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+
DQo+ID4gPiA+ICAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+DQo+ID4gPiA+ICAj
aW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgvc3VzcGVu
ZC5oPg0KPiA+ID4gPiAgI2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzMjMvY29yZS5oPg0KPiA+ID4g
PiAgI2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzMjMvcmVnaXN0ZXJzLmg+DQo+ID4gPiA+ICAjaW5j
bHVkZSA8bGludXgvbWZkL210NjM5Ny9jb3JlLmg+DQo+ID4gPiA+IEBAIC04MSw3ICs4Miw3IEBA
IHN0YXRpYyBzdHJ1Y3QgaXJxX2NoaXAgbXQ2Mzk3X2lycV9jaGlwID0gew0KPiA+ID4gPiAgc3Rh
dGljIHZvaWQgbXQ2Mzk3X2lycV9oYW5kbGVfcmVnKHN0cnVjdCBtdDYzOTdfY2hpcCAqbXQ2Mzk3
LCBpbnQgcmVnLA0KPiA+ID4gPiAgCQkJCSAgaW50IGlycWJhc2UpDQo+ID4gPiA+ICB7DQo+ID4g
PiA+IC0JdW5zaWduZWQgaW50IHN0YXR1czsNCj4gPiA+ID4gKwl1bnNpZ25lZCBpbnQgc3RhdHVz
ID0gMDsNCj4gPiA+IA0KPiA+ID4gVGhpcyBsb29rcyBsaWtlIGFuIHVucmVsYXRlZCBjaGFuZ2Us
IG5vPw0KPiA+ID4gDQo+ID4gDQo+ID4gSXQgaXMgdG8gZml4IHRoZSBjb3Zlcml0eSBkZWZlY3Qu
DQo+IA0KPiBXaGljaCBpc24ndCBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBsb2cgYW5kIGRvZXNu
J3QgaGF2ZSBhbnl0aGluZyB0bw0KPiBkbyB3aXRoIHRoaXMgcGF0Y2guICBUaHVzIGl0IHNob3Vs
ZCBiZSBpbiBhIHNlcGFyYXRlIHBhdGNoLCBidXQgSSdtDQo+IG5vdCBnb2luZyB0byBsb3NlIGFu
eSBzbGVlcCBvdmVyIGl0Lg0KPiANCg0KQ291bGQgSSBqdXN0IGFkZCBpdCB0byB0aGUgY29tbWl0
IG1lc3NhZ2U/DQpUaGFua3MuDQoNCj4gPiA+ID4gIAlpbnQgaSwgaXJxLCByZXQ7DQo+ID4gPiA+
ICANCj4gPiA+ID4gIAlyZXQgPSByZWdtYXBfcmVhZChtdDYzOTctPnJlZ21hcCwgcmVnLCAmc3Rh
dHVzKTsNCj4gPiA+ID4gQEAgLTEyOCw2ICsxMjksMzYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBp
cnFfZG9tYWluX29wcyBtdDYzOTdfaXJxX2RvbWFpbl9vcHMgPSB7DQo+ID4gPiA+ICAJLm1hcCA9
IG10NjM5N19pcnFfZG9tYWluX21hcCwNCj4gPiA+ID4gIH07DQo+ID4gPiANCj4gPiA+IE90aGVy
IHRoYW4gdGhhdC4NCj4gPiA+IA0KPiA+ID4gRm9yIG15IG93biByZWZlcmVuY2U6DQo+ID4gPiAg
IEFja2VkLWZvci1NRkQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5vcmc+DQo+ID4g
PiANCj4gPiBUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJIHdpbGwgYWRkIGl0IGluIHRoZSBuZXh0
IHZlcnNpb24uDQo+ID4gDQo+IA0KDQo=

