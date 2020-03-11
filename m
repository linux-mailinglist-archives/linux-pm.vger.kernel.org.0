Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D975D180EC5
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 04:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgCKDss (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 23:48:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47795 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727659AbgCKDsr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 23:48:47 -0400
X-UUID: e20a39dccc694c7abdaad7ccee920932-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=cMby1nCgA1pDUmKWXFEsXyQ9QhGgBEre690yHGxnHko=;
        b=qXsTTh3r0gGGJwE3in7s8hEI7gDm3EFS8mST4H1eGhl+D6/GzUo75Wfc2Y4HtGZlW7rnTQ49Nq2Tr1+/H6n29TO+8JyVQdtVKxq1GlZ/1o3/9gGeOlB9m4w6atDhFDO4IqNJnsoOJONLxB3utkv+JKG1VwV6yZcAtu8l+Zzhxe8=;
X-UUID: e20a39dccc694c7abdaad7ccee920932-20200311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 890007444; Wed, 11 Mar 2020 11:48:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 11:47:13 +0800
Received: from [172.21.77.4] (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 11:47:48 +0800
Message-ID: <1583898520.17060.1.camel@mtksdaap41>
Subject: Re: [PATCH v9 3/5] mfd: Add support for the MediaTek MT6358 PMIC
From:   Hsin-hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
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
        Ran Bi <ran.bi@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>
Date:   Wed, 11 Mar 2020 11:48:40 +0800
In-Reply-To: <CANMq1KDF32v-YnFRcz8BT6tnD0yq2OOBy9t-R09yA+4zNUZj3A@mail.gmail.com>
References: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
         <1583835040-19157-4-git-send-email-hsin-hsiung.wang@mediatek.com>
         <CANMq1KDF32v-YnFRcz8BT6tnD0yq2OOBy9t-R09yA+4zNUZj3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQpJIHdpbGwgZml4IHRoZSBtaXN0YWtlIGluIHRo
ZSBuZXh0IHZlcnNpb24uDQoNCk9uIFdlZCwgMjAyMC0wMy0xMSBhdCAxMToyNCArMDgwMCwgTmlj
b2xhcyBCb2ljaGF0IHdyb3RlOg0KPiBUaGFua3MsIG11Y2ggYmV0dGVyLiBKdXN0IG9uZSBpc3N1
ZSBsZWZ0Lg0KPiANCj4gT24gVHVlLCBNYXIgMTAsIDIwMjAgYXQgNjoxMCBQTSBIc2luLUhzaXVu
ZyBXYW5nDQo+IDxoc2luLWhzaXVuZy53YW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4g
PiBUaGlzIGFkZHMgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OCBQTUlDLiBUaGlzIGlz
IGENCj4gPiBtdWx0aWZ1bmN0aW9uIGRldmljZSB3aXRoIHRoZSBmb2xsb3dpbmcgc3ViIG1vZHVs
ZXM6DQo+ID4NCj4gPiAtIFJlZ3VsYXRvcg0KPiA+IC0gUlRDDQo+ID4gLSBDb2RlYw0KPiA+IC0g
SW50ZXJydXB0DQo+ID4NCj4gPiBJdCBpcyBpbnRlcmZhY2VkIHRvIHRoZSBob3N0IGNvbnRyb2xs
ZXIgdXNpbmcgU1BJIGludGVyZmFjZQ0KPiA+IGJ5IGEgcHJvcHJpZXRhcnkgaGFyZHdhcmUgY2Fs
bGVkIFBNSUMgd3JhcHBlciBvciBwd3JhcC4NCj4gPiBNVDYzNTggTUZEIGlzIGEgY2hpbGQgZGV2
aWNlIG9mIHRoZSBwd3JhcC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5nIFdh
bmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L21mZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgZHJpdmVycy9tZmQv
bXQ2MzU4LWlycS5jICAgICAgICAgICAgIHwgMjM4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ID4gIGRyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMgICAgICAgICAgICB8ICA1NSArKysr
KystDQo+ID4gIGluY2x1ZGUvbGludXgvbWZkL210NjM1OC9jb3JlLmggICAgICB8IDE1OCArKysr
KysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTgvcmVnaXN0ZXJz
LmggfCAyODIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVk
ZS9saW51eC9tZmQvbXQ2Mzk3L2NvcmUuaCAgICAgIHwgICAzICsNCj4gPiAgNiBmaWxlcyBjaGFu
Z2VkLCA3MzMgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGRyaXZlcnMvbWZkL210NjM1OC1pcnEuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L2NvcmUuaA0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L3JlZ2lzdGVycy5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tZmQvTWFrZWZpbGUgYi9kcml2ZXJzL21mZC9NYWtlZmlsZQ0KPiA+IGluZGV4
IGI4M2YxNzIuLjlhZjE0MTQgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tZmQvTWFrZWZpbGUN
Cj4gPiArKysgYi9kcml2ZXJzL21mZC9NYWtlZmlsZQ0KPiA+IEBAIC0yMzgsNyArMjM4LDcgQEAg
b2JqLSQoQ09ORklHX0lOVEVMX1NPQ19QTUlDKSAgICAgICAgKz0gaW50ZWwtc29jLXBtaWMubw0K
PiA+ICBvYmotJChDT05GSUdfSU5URUxfU09DX1BNSUNfQlhUV0MpICAgICArPSBpbnRlbF9zb2Nf
cG1pY19ieHR3Yy5vDQo+ID4gIG9iai0kKENPTkZJR19JTlRFTF9TT0NfUE1JQ19DSFRXQykgICAg
ICs9IGludGVsX3NvY19wbWljX2NodHdjLm8NCj4gPiAgb2JqLSQoQ09ORklHX0lOVEVMX1NPQ19Q
TUlDX0NIVERDX1RJKSAgKz0gaW50ZWxfc29jX3BtaWNfY2h0ZGNfdGkubw0KPiA+IC1tdDYzOTct
b2JqcyAgICA6PSBtdDYzOTctY29yZS5vIG10NjM5Ny1pcnEubw0KPiA+ICttdDYzOTctb2JqcyAg
ICAgICAgICAgICAgICAgICAgOj0gbXQ2Mzk3LWNvcmUubyBtdDYzOTctaXJxLm8gbXQ2MzU4LWly
cS5vDQo+ID4gIG9iai0kKENPTkZJR19NRkRfTVQ2Mzk3KSAgICAgICArPSBtdDYzOTcubw0KPiA+
ICBvYmotJChDT05GSUdfSU5URUxfU09DX1BNSUNfTVJGTEQpICAgICArPSBpbnRlbF9zb2NfcG1p
Y19tcmZsZC5vDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvbXQ2MzU4LWlycS5j
IGIvZHJpdmVycy9tZmQvbXQ2MzU4LWlycS5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4g
PiBpbmRleCAwMDAwMDAwLi4wYjk5YTM5DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2Ry
aXZlcnMvbWZkL210NjM1OC1pcnEuYw0KPiA+IEBAIC0wLDAgKzEsMjM4IEBADQo+ID4gW3NuaXBd
DQo+ID4gK3N0YXRpYyBpcnFyZXR1cm5fdCBtdDYzNThfaXJxX2hhbmRsZXIoaW50IGlycSwgdm9p
ZCAqZGF0YSkNCj4gPiArew0KPiA+ICsgICAgICAgc3RydWN0IG10NjM5N19jaGlwICpjaGlwID0g
ZGF0YTsNCj4gPiArICAgICAgIHN0cnVjdCBwbWljX2lycV9kYXRhICptdDYzNThfaXJxX2RhdGEg
PSBjaGlwLT5pcnFfZGF0YTsNCj4gPiArICAgICAgIHVuc2lnbmVkIGludCBiaXQsIGksIHRvcF9p
cnFfc3RhdHVzOw0KPiA+ICsgICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgICByZXQg
PSByZWdtYXBfcmVhZChjaGlwLT5yZWdtYXAsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICBtdDYzNThfaXJxX2RhdGEtPnRvcF9pbnRfc3RhdHVzX3JlZywNCj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgICZ0b3BfaXJxX3N0YXR1cyk7DQo+ID4gKyAgICAgICBpZiAocmV0KSB7DQo+
ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoY2hpcC0+ZGV2LA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICJGYWlsZWQgdG8gcmVhZCBzdGF0dXMgZnJvbSB0aGUgZGV2aWNlLCByZXQ9JWRc
biIsIHJldCk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBJUlFfTk9ORTsNCj4gPiArICAg
ICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgbXQ2MzU4X2lycV9kYXRh
LT5udW1fdG9wOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IG10
NjM1OF9pcnFfZGF0YS0+bnVtX3RvcDsgaSsrKSB7DQo+IA0KPiBPbmx5IG9uZSBsb29wIG5lZWRl
ZC4NCj4gDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYml0ID0gQklUKG10NjM1OF9pbnRz
W2ldLnRvcF9vZmZzZXQpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICh0b3BfaXJx
X3N0YXR1cyAmIGJpdCkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXQ2
MzU4X2lycV9zcF9oYW5kbGVyKGNoaXAsIGkpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgdG9wX2lycV9zdGF0dXMgJj0gfmJpdDsNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGlmICghdG9wX2lycV9zdGF0dXMpDQo+ID4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
IH0NCj4gPiArICAgICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAg
ICAgIHJldHVybiBJUlFfSEFORExFRDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBw
bWljX2lycV9kb21haW5fbWFwKHN0cnVjdCBpcnFfZG9tYWluICpkLCB1bnNpZ25lZCBpbnQgaXJx
LA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBpcnFfaHdfbnVtYmVyX3QgaHcp
DQo+ID4gK3sNCj4gPiArICAgICAgIHN0cnVjdCBtdDYzOTdfY2hpcCAqbXQ2Mzk3ID0gZC0+aG9z
dF9kYXRhOw0KPiA+ICsNCj4gPiArICAgICAgIGlycV9zZXRfY2hpcF9kYXRhKGlycSwgbXQ2Mzk3
KTsNCj4gPiArICAgICAgIGlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcihpcnEsICZtdDYzNThfaXJx
X2NoaXAsIGhhbmRsZV9sZXZlbF9pcnEpOw0KPiA+ICsgICAgICAgaXJxX3NldF9uZXN0ZWRfdGhy
ZWFkKGlycSwgMSk7DQo+ID4gKyAgICAgICBpcnFfc2V0X25vcHJvYmUoaXJxKTsNCj4gPiArDQo+
ID4gKyAgICAgICByZXR1cm4gMDsNCj4gPiArfQ0KPiA+IFtzbmlwXQ0KDQo=

