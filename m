Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3A5B19A6F2
	for <lists+linux-pm@lfdr.de>; Wed,  1 Apr 2020 10:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732004AbgDAIPZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Apr 2020 04:15:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32278 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726536AbgDAIPY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 Apr 2020 04:15:24 -0400
X-UUID: 85477a0a56a0464e99d2b4dcd26fe772-20200401
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=EUSbiZ5r21/VYhtoXigszZHmGB4861uUEJICZijPPz8=;
        b=rVF2vAtM9hLqWUY7cOfJM67VbleqT4ZU/KNk1kDPt4sKkz8UFCJAazznvi6O7G7cM3LyuGlml0V87Fpa/Hm9LKNsK6CtKWkAQGCH842sWY7ELJA5pVeSskNZmodPpiAC+exc/AuDecegLuiLusNEcAqoj4LtCTsmAQ/UJ7T79P4=;
X-UUID: 85477a0a56a0464e99d2b4dcd26fe772-20200401
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 886987047; Wed, 01 Apr 2020 16:15:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 1 Apr 2020 16:15:10 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 1 Apr 2020 16:15:10 +0800
Message-ID: <1585728912.29188.5.camel@mtksdaap41>
Subject: Re: [PATCH v10 3/5] mfd: Add support for the MediaTek MT6358 PMIC
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        "Frank Wunderlich" <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>
Date:   Wed, 1 Apr 2020 16:15:12 +0800
In-Reply-To: <20200325094326.GH442973@dell>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1583918223-22506-4-git-send-email-hsin-hsiung.wang@mediatek.com>
         <20200325094326.GH442973@dell>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 06D9F1349F844C3C636E8A872788F7EFF171DBA945BD46709F6C7CC20C761D822000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQpPbiBXZWQsIDIwMjAtMDMtMjUgYXQgMDk6NDMgKzAwMDAsIExlZSBKb25lcyB3cm90ZToN
Cj4gT24gV2VkLCAxMSBNYXIgMjAyMCwgSHNpbi1Ic2l1bmcgV2FuZyB3cm90ZToNCj4gDQo+ID4g
VGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUE1JQy4gVGhpcyBpcyBh
DQo+ID4gbXVsdGlmdW5jdGlvbiBkZXZpY2Ugd2l0aCB0aGUgZm9sbG93aW5nIHN1YiBtb2R1bGVz
Og0KPiA+IA0KPiA+IC0gUmVndWxhdG9yDQo+ID4gLSBSVEMNCj4gPiAtIENvZGVjDQo+ID4gLSBJ
bnRlcnJ1cHQNCj4gPiANCj4gPiBJdCBpcyBpbnRlcmZhY2VkIHRvIHRoZSBob3N0IGNvbnRyb2xs
ZXIgdXNpbmcgU1BJIGludGVyZmFjZQ0KPiA+IGJ5IGEgcHJvcHJpZXRhcnkgaGFyZHdhcmUgY2Fs
bGVkIFBNSUMgd3JhcHBlciBvciBwd3JhcC4NCj4gPiBNVDYzNTggTUZEIGlzIGEgY2hpbGQgZGV2
aWNlIG9mIHRoZSBwd3JhcC4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBX
YW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVy
cy9tZmQvTWFrZWZpbGUgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvbWZk
L210NjM1OC1pcnEuYyAgICAgICAgICAgICB8IDIzNiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICBkcml2ZXJzL21mZC9tdDYzOTctY29yZS5jICAgICAgICAgICAgfCAgNTUgKysr
KysrLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTgvY29yZS5oICAgICAgfCAxNTggKysr
KysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L3JlZ2lzdGVy
cy5oIHwgMjgyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIGluY2x1
ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggICAgICB8ICAgMyArDQo+ID4gIDYgZmlsZXMgY2hh
bmdlZCwgNzMxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNClsuLi5dDQoNCj4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvbXQ2MzU4LWlycS5jIGIvZHJpdmVycy9tZmQvbXQ2MzU4
LWlycS5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi4wMjJl
NWY1DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvbWZkL210NjM1OC1pcnEu
Yw0KPiA+IEBAIC0wLDAgKzEsMjM2IEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiBHUEwtMi4wDQo+ID4gKy8vDQo+ID4gKy8vIENvcHlyaWdodCAoYykgMjAxOSBNZWRpYVRlayBJ
bmMuDQo+IA0KPiBUaGlzIGlzIG91dCBvZiBkYXRlLg0KPiANCg0KVGhhbmtzLiBJIHdpbGwgdXBk
YXRlIGl0IGluIHRoZSBuZXh0IHBhdGNoLg0KDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1
cHQuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzNTgvY29yZS5oPg0KPiA+ICsjaW5j
bHVkZSA8bGludXgvbWZkL210NjM1OC9yZWdpc3RlcnMuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4
L21mZC9tdDYzOTcvY29yZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4g
KyNpbmNsdWRlIDxsaW51eC9vZi5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+
DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3Bs
YXRmb3JtX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQo+ID4gKw0K
PiA+ICtzdGF0aWMgc3RydWN0IGlycV90b3BfdCBtdDYzNThfaW50c1tdID0gew0KPiA+ICsJTVQ2
MzU4X1RPUF9HRU4oQlVDSyksDQo+ID4gKwlNVDYzNThfVE9QX0dFTihMRE8pLA0KPiA+ICsJTVQ2
MzU4X1RPUF9HRU4oUFNDKSwNCj4gPiArCU1UNjM1OF9UT1BfR0VOKFNDSyksDQo+ID4gKwlNVDYz
NThfVE9QX0dFTihCTSksDQo+ID4gKwlNVDYzNThfVE9QX0dFTihISyksDQo+ID4gKwlNVDYzNThf
VE9QX0dFTihBVUQpLA0KPiA+ICsJTVQ2MzU4X1RPUF9HRU4oTUlTQyksDQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgdm9pZCBwbWljX2lycV9lbmFibGUoc3RydWN0IGlycV9kYXRhICpkYXRh
KQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBpbnQgaHdpcnEgPSBpcnFkX3RvX2h3aXJxKGRhdGEp
Ow0KPiA+ICsJc3RydWN0IG10NjM5N19jaGlwICpjaGlwID0gaXJxX2RhdGFfZ2V0X2lycV9jaGlw
X2RhdGEoZGF0YSk7DQo+IA0KPiA2Mzk3Pw0KPiANCj4gVGhpcyBkb2VzIG1ha2UgbWUgd29uZGVy
IGhvdyBkaWZmZXJlbnQgdGhpcyBmaWxlIGlzIHRvIHRoZSBleGlzdGluZw0KPiBzdXBwb3J0IGZv
ciB0aGUgTVQ2Mzk3LiAgV2hhdCBpcyB0aGUganVzdGlmaWNhdGlvbiBmb3Igbm90IGV4dGVuZGlu
Zw0KPiB0aGF0IGluc3RlYWQgb2YgY3JlYXRpbmcgYSBicmFuZCBuZXcgZmlsZT8NCj4gDQoNCk1U
NjM1OCBpcyBzaW1pbGFyIHRvIE1UNjM5NyBmb3IgbWZkIGRyaXZlciBleGNlcHQgdGhlIGhhcmR3
YXJlIGRlc2lnbiBvZg0KaW50ZXJydXB0IHdoaWNoIHByb3ZpZGVzIG1vcmUgaW50ZXJydXB0cyB0
aGFuIE1UNjM5Ny4NCkkgdGhpbmsgTVQ2MzU4IGNhbiByZXVzZSB0aGUgb3RoZXIgcGFydHMgb2Yg
TVQ2Mzk3IG1mZCBkcml2ZXIsIHNvIEkgb25seQ0KYWRkIHRoZSBpbnRlcnJ1cHQgcGFydCBvZiBN
VDYzNTguDQoNCj4gPiArCXN0cnVjdCBwbWljX2lycV9kYXRhICppcnFkID0gY2hpcC0+aXJxX2Rh
dGE7DQo+ID4gKw0KPiA+ICsJaXJxZC0+ZW5hYmxlX2h3aXJxW2h3aXJxXSA9IHRydWU7DQo+ID4g
K30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHBtaWNfaXJxX2Rpc2FibGUoc3RydWN0IGlycV9k
YXRhICpkYXRhKQ0KPiA+ICt7DQo+ID4gKwl1bnNpZ25lZCBpbnQgaHdpcnEgPSBpcnFkX3RvX2h3
aXJxKGRhdGEpOw0KPiA+ICsJc3RydWN0IG10NjM5N19jaGlwICpjaGlwID0gaXJxX2RhdGFfZ2V0
X2lycV9jaGlwX2RhdGEoZGF0YSk7DQo+ID4gKwlzdHJ1Y3QgcG1pY19pcnFfZGF0YSAqaXJxZCA9
IGNoaXAtPmlycV9kYXRhOw0KPiA+ICsNCj4gPiArCWlycWQtPmVuYWJsZV9od2lycVtod2lycV0g
PSBmYWxzZTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgcG1pY19pcnFfbG9jayhz
dHJ1Y3QgaXJxX2RhdGEgKmRhdGEpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBtdDYzOTdfY2hpcCAq
Y2hpcCA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGRhdGEpOw0KPiA+ICsNCj4gPiArCW11
dGV4X2xvY2soJmNoaXAtPmlycWxvY2spOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdm9p
ZCBwbWljX2lycV9zeW5jX3VubG9jayhzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpDQo+ID4gK3sNCj4g
PiArCXVuc2lnbmVkIGludCBpLCB0b3BfZ3AsIGdwX29mZnNldCwgZW5fcmVnLCBpbnRfcmVncywg
c2hpZnQ7DQo+ID4gKwlzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXAgPSBpcnFfZGF0YV9nZXRfaXJx
X2NoaXBfZGF0YShkYXRhKTsNCj4gPiArCXN0cnVjdCBwbWljX2lycV9kYXRhICppcnFkID0gY2hp
cC0+aXJxX2RhdGE7DQo+ID4gKw0KPiA+ICsJZm9yIChpID0gMDsgaSA8IGlycWQtPm51bV9wbWlj
X2lycXM7IGkrKykgew0KPiA+ICsJCWlmIChpcnFkLT5lbmFibGVfaHdpcnFbaV0gPT0gaXJxZC0+
Y2FjaGVfaHdpcnFbaV0pDQo+ID4gKwkJCWNvbnRpbnVlOw0KPiA+ICsNCj4gPiArCQkvKiBGaW5k
IG91dCB0aGUgSVJRIGdyb3VwICovDQo+ID4gKwkJdG9wX2dwID0gMDsNCj4gPiArCQl3aGlsZSAo
KHRvcF9ncCArIDEpIDwgaXJxZC0+bnVtX3RvcCAmJg0KPiA+ICsJCSAgICAgICBpID49IG10NjM1
OF9pbnRzW3RvcF9ncCArIDFdLmh3aXJxX2Jhc2UpDQo+ID4gKwkJCXRvcF9ncCsrOw0KPiA+ICsN
Cj4gPiArCQkvKiBGaW5kIHRoZSBpcnEgcmVnaXN0ZXJzICovDQo+IA0KPiBOaXQ6ICJJUlEiDQo+
IA0KDQpUaGFua3MuIEkgd2lsbCB1cGRhdGUgaXQgaW4gdGhlIG5leHQgcGF0Y2guDQoNCj4gPiAr
CQlncF9vZmZzZXQgPSBpIC0gbXQ2MzU4X2ludHNbdG9wX2dwXS5od2lycV9iYXNlOw0KPiA+ICsJ
CWludF9yZWdzID0gZ3Bfb2Zmc2V0IC8gTVQ2MzU4X1JFR19XSURUSDsNCj4gPiArCQlzaGlmdCA9
IGdwX29mZnNldCAlIE1UNjM1OF9SRUdfV0lEVEg7DQo+ID4gKwkJZW5fcmVnID0gbXQ2MzU4X2lu
dHNbdG9wX2dwXS5lbl9yZWcgKw0KPiA+ICsJCQkgKG10NjM1OF9pbnRzW3RvcF9ncF0uZW5fcmVn
X3NoaWZ0ICogaW50X3JlZ3MpOw0KPiA+ICsNCj4gPiArCQlyZWdtYXBfdXBkYXRlX2JpdHMoY2hp
cC0+cmVnbWFwLCBlbl9yZWcsIEJJVChzaGlmdCksDQo+ID4gKwkJCQkgICBpcnFkLT5lbmFibGVf
aHdpcnFbaV0gPDwgc2hpZnQpOw0KPiA+ICsNCj4gPiArCQlpcnFkLT5jYWNoZV9od2lycVtpXSA9
IGlycWQtPmVuYWJsZV9od2lycVtpXTsNCj4gPiArCX0NCj4gPiArCW11dGV4X3VubG9jaygmY2hp
cC0+aXJxbG9jayk7DQo+ID4gK30NCj4gDQo+IFsuLi5dDQo+IA0KPiA+ICtpbnQgbXQ2MzU4X2ly
cV9pbml0KHN0cnVjdCBtdDYzOTdfY2hpcCAqY2hpcCkNCj4gPiArew0KPiA+ICsJaW50IGksIGos
IHJldDsNCj4gPiArCXN0cnVjdCBwbWljX2lycV9kYXRhICppcnFkOw0KPiA+ICsNCj4gPiArCWly
cWQgPSBkZXZtX2t6YWxsb2MoY2hpcC0+ZGV2LCBzaXplb2Yoc3RydWN0IHBtaWNfaXJxX2RhdGEg
KiksDQo+IA0KPiBzaXplb2YoKmlycWQpDQo+IA0KDQpUaGFua3MuIEkgd2lsbCB1cGRhdGUgaXQg
aW4gdGhlIG5leHQgcGF0Y2guDQoNCj4gWy4uLl0NCj4gDQo+ID4gIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgY2hpcF9kYXRhIG10NjM5N19jb3JlID0gew0KPiA+ICAJLmNpZF9hZGRyID0gTVQ2Mzk3X0NJ
RCwNCj4gPiAgCS5jaWRfc2hpZnQgPSAwLA0KPiA+IEBAIC0xNTQsMTkgKzE4NCwzMyBAQCBzdGF0
aWMgaW50IG10NjM5N19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJ
aWYgKHBtaWMtPmlycSA8PSAwKQ0KPiA+ICAJCXJldHVybiBwbWljLT5pcnE7DQo+ID4gIA0KPiA+
IC0JcmV0ID0gbXQ2Mzk3X2lycV9pbml0KHBtaWMpOw0KPiA+IC0JaWYgKHJldCkNCj4gPiAtCQly
ZXR1cm4gcmV0Ow0KPiA+IC0NCj4gPiAgCXN3aXRjaCAocG1pYy0+Y2hpcF9pZCkgew0KPiA+ICAJ
Y2FzZSBNVDYzMjNfQ0hJUF9JRDoNCj4gPiArCQlyZXQgPSBtdDYzOTdfaXJxX2luaXQocG1pYyk7
DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gIAkJcmV0
ID0gZGV2bV9tZmRfYWRkX2RldmljZXMoJnBkZXYtPmRldiwgUExBVEZPUk1fREVWSURfTk9ORSwN
Cj4gPiAgCQkJCQkgICBtdDYzMjNfZGV2cywgQVJSQVlfU0laRShtdDYzMjNfZGV2cyksDQo+ID4g
IAkJCQkJICAgTlVMTCwgMCwgcG1pYy0+aXJxX2RvbWFpbik7DQo+ID4gIAkJYnJlYWs7DQo+ID4g
IA0KPiA+ICsJY2FzZSBNVDYzNThfQ0hJUF9JRDoNCj4gPiArCQlyZXQgPSBtdDYzNThfaXJxX2lu
aXQocG1pYyk7DQo+ID4gKwkJaWYgKHJldCkNCj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+
ID4gKwkJcmV0ID0gZGV2bV9tZmRfYWRkX2RldmljZXMoJnBkZXYtPmRldiwgUExBVEZPUk1fREVW
SURfTk9ORSwNCj4gPiArCQkJCQkgICBtdDYzNThfZGV2cywgQVJSQVlfU0laRShtdDYzNThfZGV2
cyksDQo+ID4gKwkJCQkJICAgTlVMTCwgMCwgcG1pYy0+aXJxX2RvbWFpbik7DQo+IA0KPiBJbiBh
IHN1YnNlcXVlbnQgcGF0Y2ggeW91IGNhbiBjaG9vc2UgdGhlIGNvcnJlY3QgbXRYWFhYX2RldnMg
c3RydWN0dXJlDQo+IHRvIHBhc3MgYW5kIGNhbGwgZGV2bV9tZmRfYWRkX2RldmljZXMoKSBvbmx5
IG9uY2UgYmVsb3cgdGhlIHN3aXRjaCgpLg0KPiANCg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnQu
IEkgd2lsbCB1cGRhdGUgaXQgaW4gdGhlIG5leHQgcGF0Y2guDQoNCj4gPiArCQlicmVhazsNCj4g
PiArDQo+ID4gIAljYXNlIE1UNjM5MV9DSElQX0lEOg0KPiA+ICAJY2FzZSBNVDYzOTdfQ0hJUF9J
RDoNCj4gPiArCQlyZXQgPSBtdDYzOTdfaXJxX2luaXQocG1pYyk7DQo+ID4gKwkJaWYgKHJldCkN
Cj4gPiArCQkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gIAkJcmV0ID0gZGV2bV9tZmRfYWRkX2Rl
dmljZXMoJnBkZXYtPmRldiwgUExBVEZPUk1fREVWSURfTk9ORSwNCj4gPiAgCQkJCQkgICBtdDYz
OTdfZGV2cywgQVJSQVlfU0laRShtdDYzOTdfZGV2cyksDQo+ID4gIAkJCQkJICAgTlVMTCwgMCwg
cG1pYy0+aXJxX2RvbWFpbik7DQo+IA0KPiBbLi4uXQ0KPiANCg0K

