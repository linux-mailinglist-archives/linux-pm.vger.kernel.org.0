Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC25911A5AC
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2019 09:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfLKINj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Dec 2019 03:13:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:10703 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727547AbfLKINj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Dec 2019 03:13:39 -0500
X-UUID: 8ce0a82ac5d84fa5b3d915213eed691f-20191211
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=LMtGwOTN7KKUaEd8A9wg9LxG6VsxXxh0GBa84A4j5NY=;
        b=VrSyV1Cp/l36nS3QpKYFQo/XlsRas7PPPnVbCA0Vmr0Xq/oddPdYCRZ+S1LbSxLa35dk22OAX4BCsnJciiodIVZTT0ChjctJfIyvGXWxdOJosTtSwLsF9p3akTdDJSv8K+NEZp+u963N+G6BOLk9LhnhyLF5R0EpP+D0ff2xj7o=;
X-UUID: 8ce0a82ac5d84fa5b3d915213eed691f-20191211
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1353820062; Wed, 11 Dec 2019 16:13:33 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Dec 2019 16:13:09 +0800
Received: from [172.21.84.99] (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Dec 2019 16:12:57 +0800
Message-ID: <1576052012.1631.13.camel@mtksdccf07>
Subject: Re: [PATCH] [RESEND] arm64: dts: mt8173: Add dynamic power node.
From:   Michael Kao <michael.kao@mediatek.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
CC:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Dawei Chien <dawei.chien@mediatek.com>, <mn.tsou@mediatek.com>
Date:   Wed, 11 Dec 2019 16:13:32 +0800
In-Reply-To: <4aaf8cee-eaa2-5de4-37f0-094b9bc8da22@linaro.org>
References: <20191122090610.17015-1-michael.kao@mediatek.com>
         <4aaf8cee-eaa2-5de4-37f0-094b9bc8da22@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDE5LTEyLTA1IGF0IDE3OjAwICswMTAwLCBEYW5pZWwgTGV6Y2FubyB3cm90ZToN
Cj4gSGkgTWljaGFlbCwNCj4gDQo+IA0KPiBPbiAyMi8xMS8yMDE5IDEwOjA2LCBtaWNoYWVsLmth
b0BtZWRpYXRlay5jb20gd3JvdGU6DQo+ID4gRnJvbTogIm1pY2hhZWwua2FvIiA8bWljaGFlbC5r
YW9AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IFRoaXMgZGV2aWNlIG5vZGUgaXMgZm9yIGNhbGN1
bGF0aW5nIGR5bmFtaWMgcG93ZXIgaW4gbVcuDQo+ID4gU2luY2UgbXQ4MTczIGhhcyB0d28gY2x1
c3RlcnMsIHRoZXJlIGFyZSB0d28gZHluYW1pYyBwb3dlcg0KPiA+IGNvZWZmaWNpZW50IGFzIHdl
bGwuDQo+IA0KPiBBcmUgeW91IHN1cmUgYWJvdXQgdGhlIHZhbHVlcz8gVXN1YWxseSwgQmlnIGlz
IH54NCBsaXR0bGUsIGhlcmUgaXQgaXMgfngyLg0KDQpIaSBEYW5pZWwsDQoNCkkgaGF2ZSBjb25m
aXJtZWQgYWdhaW4gd2l0aCBvdXIgSUMgZGVzaWduZXIuDQpUaGUgZHluYW1pYyBwb3dlciBjb2Vm
ZmljaWVudHMgYXJlIHRoZXNlIHZhbHVlIGlzIHJpZ2h0Lg0KRGVzaWduZXIgY29tbWVudCB0aGF0
IGl0IGlzIHJlc3VsdCBmcm9tIGRpZmZlcmVudCBJQyBpbXBsZW1lbnQuDQo+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IERhd2VpIENoaWVuIDxkYXdlaS5jaGllbkBtZWRpYXRlay5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogTWljaGFlbC5LYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4NCj4gPiAN
Cj4gPiAtLS0NCj4gPiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMuZHRzaSB8
IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gDQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTczLmR0c2kgYi9h
cmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQo+ID4gaW5kZXggMTVmMTg0
MmY2ZGYzLi5iMDNjYTVhNzEzMzggMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxNzMuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTczLmR0c2kNCj4gPiBAQCAtMTU3LDYgKzE1Nyw3IEBADQo+ID4gIAkJCWVuYWJs
ZS1tZXRob2QgPSAicHNjaSI7DQo+ID4gIAkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NMRUVQ
XzA+Ow0KPiA+ICAJCQkjY29vbGluZy1jZWxscyA9IDwyPjsNCj4gPiArCQkJZHluYW1pYy1wb3dl
ci1jb2VmZmljaWVudCA9IDwyNjM+Ow0KPiA+ICAJCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19J
TkZSQV9DQTUzU0VMPiwNCj4gPiAgCQkJCSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTUFJTlBM
TD47DQo+ID4gIAkJCWNsb2NrLW5hbWVzID0gImNwdSIsICJpbnRlcm1lZGlhdGUiOw0KPiA+IEBA
IC0xNzAsNiArMTcxLDcgQEANCj4gPiAgCQkJZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiAg
CQkJY3B1LWlkbGUtc3RhdGVzID0gPCZDUFVfU0xFRVBfMD47DQo+ID4gIAkJCSNjb29saW5nLWNl
bGxzID0gPDI+Ow0KPiA+ICsJCQlkeW5hbWljLXBvd2VyLWNvZWZmaWNpZW50ID0gPDI2Mz47DQo+
ID4gIAkJCWNsb2NrcyA9IDwmaW5mcmFjZmcgQ0xLX0lORlJBX0NBNTNTRUw+LA0KPiA+ICAJCQkJ
IDwmYXBtaXhlZHN5cyBDTEtfQVBNSVhFRF9NQUlOUExMPjsNCj4gPiAgCQkJY2xvY2stbmFtZXMg
PSAiY3B1IiwgImludGVybWVkaWF0ZSI7DQo+ID4gQEAgLTE4Myw2ICsxODUsNyBAQA0KPiA+ICAJ
CQllbmFibGUtbWV0aG9kID0gInBzY2kiOw0KPiA+ICAJCQljcHUtaWRsZS1zdGF0ZXMgPSA8JkNQ
VV9TTEVFUF8wPjsNCj4gPiAgCQkJI2Nvb2xpbmctY2VsbHMgPSA8Mj47DQo+ID4gKwkJCWR5bmFt
aWMtcG93ZXItY29lZmZpY2llbnQgPSA8NTMwPjsNCj4gPiAgCQkJY2xvY2tzID0gPCZpbmZyYWNm
ZyBDTEtfSU5GUkFfQ0E3MlNFTD4sDQo+ID4gIAkJCQkgPCZhcG1peGVkc3lzIENMS19BUE1JWEVE
X01BSU5QTEw+Ow0KPiA+ICAJCQljbG9jay1uYW1lcyA9ICJjcHUiLCAiaW50ZXJtZWRpYXRlIjsN
Cj4gPiBAQCAtMTk2LDYgKzE5OSw3IEBADQo+ID4gIAkJCWVuYWJsZS1tZXRob2QgPSAicHNjaSI7
DQo+ID4gIAkJCWNwdS1pZGxlLXN0YXRlcyA9IDwmQ1BVX1NMRUVQXzA+Ow0KPiA+ICAJCQkjY29v
bGluZy1jZWxscyA9IDwyPjsNCj4gPiArCQkJZHluYW1pYy1wb3dlci1jb2VmZmljaWVudCA9IDw1
MzA+Ow0KPiA+ICAJCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9DQTcyU0VMPiwNCj4g
PiAgCQkJCSA8JmFwbWl4ZWRzeXMgQ0xLX0FQTUlYRURfTUFJTlBMTD47DQo+ID4gIAkJCWNsb2Nr
LW5hbWVzID0gImNwdSIsICJpbnRlcm1lZGlhdGUiOw0KPiA+IA0KPiANCj4gDQoNCg==

