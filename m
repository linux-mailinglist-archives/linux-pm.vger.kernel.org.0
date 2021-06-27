Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312413B527F
	for <lists+linux-pm@lfdr.de>; Sun, 27 Jun 2021 09:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbhF0H6l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 27 Jun 2021 03:58:41 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50373 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229507AbhF0H6k (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 27 Jun 2021 03:58:40 -0400
X-UUID: e7ce929d298b4a2cbeb934bcd9bf50b0-20210627
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6TSr5TS0E7uuhhXK7oCAhWahR2YqxhAPByhuMU0eWFQ=;
        b=ISGSo8j5gsAbxZjjM/6Xdqm3XzCIIbsEayzKNP2vvmglBf/ovC6FIj4wOJPECy9IpJPie3WWGBnrmClkSZbFPQOtWvEnztnrjzLcFcsQuyvs3gqp6jKj5ZHv4Op4Gd0qww59H+QAvIR3VEgQhj2LzJJ5cG7pkD8IABdJOuYRX1A=;
X-UUID: e7ce929d298b4a2cbeb934bcd9bf50b0-20210627
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1880613911; Sun, 27 Jun 2021 15:56:13 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sun, 27 Jun 2021 15:56:12 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Jun 2021 15:56:12 +0800
Message-ID: <1624780572.1958.2.camel@mtkswgap22>
Subject: Re: [PATCH v12 2/2] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Sun, 27 Jun 2021 15:56:12 +0800
In-Reply-To: <20210602165827.GA3558170@robh.at.kernel.org>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
         <1622307153-3639-3-git-send-email-hector.yuan@mediatek.com>
         <20210602165827.GA3558170@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gV2VkLCAyMDIxLTA2LTAyIGF0IDExOjU4IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gU3VuLCBNYXkgMzAsIDIwMjEgYXQgMTI6NTI6MzNBTSArMDgwMCwgSGVjdG9yIFl1YW4gd3Jv
dGU6DQo+ID4gRnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0K
PiA+IA0KPiA+IEFkZCBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciBNZWRpYVRlayBIVyBkcml2ZXIu
DQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlh
dGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRp
YXRlay1ody55YW1sICAgICAgfCAgIDcxICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmls
ZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3
LnlhbWwNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sIGIvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sDQo+ID4g
bmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwLi4xYWE0ZDU0DQo+ID4gLS0t
IC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9j
cHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KPiA+IEBAIC0wLDAgKzEsNzEgQEANCj4g
PiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1
c2UpDQo+ID4gKyVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJl
ZS5vcmcvc2NoZW1hcy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbCMNCj4gPiArJHNj
aGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4g
Kw0KPiA+ICt0aXRsZTogTWVkaWFUZWsncyBDUFVGUkVRIEJpbmRpbmdzDQo+ID4gKw0KPiA+ICtt
YWludGFpbmVyczoNCj4gPiArICAtIEhlY3RvciBZdWFuIDxoZWN0b3IueXVhbkBtZWRpYXRlay5j
b20+DQo+ID4gKw0KPiA+ICtkZXNjcmlwdGlvbjoNCj4gPiArICBDUFVGUkVRIEhXIGlzIGEgaGFy
ZHdhcmUgZW5naW5lIHVzZWQgYnkgTWVkaWFUZWsNCj4gPiArICBTb0NzIHRvIG1hbmFnZSBmcmVx
dWVuY3kgaW4gaGFyZHdhcmUuIEl0IGlzIGNhcGFibGUgb2YgY29udHJvbGxpbmcgZnJlcXVlbmN5
DQo+ID4gKyAgZm9yIG11bHRpcGxlIGNsdXN0ZXJzLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoN
Cj4gPiArICBjb21wYXRpYmxlOg0KPiA+ICsgICAgY29uc3Q6IG1lZGlhdGVrLGNwdWZyZXEtaHcN
Cj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0
ZW1zOiAyDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ICsgICAgICBBZGRyZXNzZXMgYW5k
IHNpemVzIGZvciB0aGUgbWVtb3J5IG9mIHRoZQ0KPiA+ICsgICAgICBIVyBiYXNlcyBpbiBlYWNo
IGZyZXF1ZW5jeSBkb21haW4uDQo+ID4gKw0KPiA+ICsgICIjcGVyZm9ybWFuY2UtZG9tYWluLWNl
bGxzIjoNCj4gPiArICAgIGRlc2NyaXB0aW9uOg0KPiA+ICsgICAgICBOdW1iZXIgb2YgY2VsbHMg
aW4gYSBwZXJmb3JtYW5jZSBkb21haW4gc3BlY2lmaWVyLiBUeXBpY2FsbHkgMCBmb3Igbm9kZXMN
Cj4gPiArICAgICAgcmVwcmVzZW50aW5nIGEgc2luZ2xlIHBlcmZvcm1hbmNlIGRvbWFpbiBhbmQg
MSBmb3Igbm9kZXMgcHJvdmlkaW5nDQo+ID4gKyAgICAgIG11bHRpcGxlIHBlcmZvcm1hbmNlIGRv
bWFpbnMgKGUuZy4gcGVyZm9ybWFuY2UgY29udHJvbGxlcnMpLCBidXQgY2FuIGJlDQo+ID4gKyAg
ICAgIGFueSB2YWx1ZSBhcyBzcGVjaWZpZWQgYnkgZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVu
dGF0aW9uIG9mIHBhcnRpY3VsYXINCj4gPiArICAgICAgcHJvdmlkZXIuDQo+ID4gKyAgICBlbnVt
OiBbIDAsIDEgXQ0KPiANCj4gQ2FuJ3QgeW91IHJlc3RyaWN0IHRoaXMgdG8gYmUgMSBmb3IgTWVk
aWF0ZWsgaC93PyBFdmVuIGlmIHlvdSBzb21ldGltZXMgDQo+IGhhdmUgYSBzaW5nbGUgZG9tYWlu
LCBpdCdzIHByb2JhYmx5IG1vcmUgc2ltcGxlIGZvciB0aGUgZHJpdmVyIGlmIHRoaXMgDQo+IGlz
IGZpeGVkLg0KPiANCk9LLCBJIHdpbGwgcmVzdHJpY3QgdGhpcyBhcyAxIGluIG5leHQgdmVyc2lv
bi4NCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0g
cmVnDQo+ID4gKyAgLSAiI3BlcmZvcm1hbmNlLWRvbWFpbi1jZWxscyINCj4gPiArDQo+ID4gK2Fk
ZGl0aW9uYWxQcm9wZXJ0aWVzOiB0cnVlDQo+IA0KPiBTaG91bGQgYmUgZmFsc2UuDQo+IA0KT0ss
IHRoYW5rcw0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBjcHVz
IHsNCj4gPiArICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAg
ICAgICNzaXplLWNlbGxzID0gPDA+Ow0KPiA+ICsNCj4gPiArICAgICAgICAgICAgY3B1MDogY3B1
QDAgew0KPiA+ICsgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAiY3B1IjsNCj4gPiArICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLGNvcnRleC1hNTUiOw0KPiA+ICsgICAgICAg
ICAgICAgICAgZW5hYmxlLW1ldGhvZCA9ICJwc2NpIjsNCj4gPiArICAgICAgICAgICAgICAgIHBl
cmZvcm1hbmNlLWRvbWFpbnMgPSA8JnBlcmZvcm1hbmNlIDA+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgcmVnID0gPDB4MDAwPjsNCj4gPiArICAgICAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4g
Kw0KPiA+ICsgICAgLyogLi4uICovDQo+ID4gKw0KPiA+ICsgICAgc29jIHsNCj4gPiArICAgICAg
ICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCj4gPiArICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsN
Cj4gPiArDQo+ID4gKyAgICAgICAgcGVyZm9ybWFuY2U6IHBlcmZvcm1hbmNlLWNvbnRyb2xsZXJA
MTFiYzAwIHsNCj4gPiArICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxjcHVmcmVx
LWh3IjsNCj4gPiArICAgICAgICAgICAgcmVnID0gPDAgMHgwMDExYmMxMCAwIDB4MTIwPiwgPDAg
MHgwMDExYmQzMCAwIDB4MTIwPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICNwZXJmb3JtYW5j
ZS1kb21haW4tY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+ID4g
LS0gDQo+ID4gMS43LjkuNQ0KDQo=

