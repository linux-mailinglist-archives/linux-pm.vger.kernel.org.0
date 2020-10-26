Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83442986D6
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 07:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770346AbgJZGVf (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 02:21:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54523 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1770343AbgJZGVf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 02:21:35 -0400
X-UUID: 29f335cd3a40456eaaeff45935fe4b5a-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=ovD35jwSjQ+wqlOD/MbETU9+rdGO8IPjUS8gPRDFFlI=;
        b=qDm0b8LmRcF0QV/N2EyDfpo/uDDfVGwQO0/EuWC3ZAFJI/1pXfunz+buRkn4M+d/xgnOdoH6Le253uoA5L2kgqICfbazLPLW/OjzT0zDlfHcDWuZxKP/NPQPKVZ6KWGGhAIwiOkkxhH6HSbBaE4X3mnXhIPXdzLtwYmZXlChiX4=;
X-UUID: 29f335cd3a40456eaaeff45935fe4b5a-20201026
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 104698409; Mon, 26 Oct 2020 14:21:24 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 14:17:34 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 14:17:34 +0800
Message-ID: <1603693055.20535.7.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/6] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 26 Oct 2020 14:17:35 +0800
In-Reply-To: <20201023083538.f6hhcyizvlf2ufjr@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
         <1603441493-18554-4-git-send-email-hector.yuan@mediatek.com>
         <20201023083538.f6hhcyizvlf2ufjr@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E1F42458ABCB867985AE95354FADF6F53CB2514EB2DD0DF40D93A33E308990832000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDE0OjA1ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDIzLTEwLTIwLCAxNjoyNCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogIkhlY3Rv
ci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBkZXZpY2V0
cmVlIGJpbmRpbmdzIGZvciBNZWRpYVRlayBIVyBkcml2ZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9m
Zi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAg
IDQ2ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0NiBpbnNlcnRp
b25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwNCj4gPiANCj4gPiBkaWZm
IC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJl
cS1tZWRpYXRlay1ody55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Nw
dWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwLi5hOTlmNDRmDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0
ZWstaHcueWFtbA0KPiA+IEBAIC0wLDAgKzEsNDYgQEANCj4gPiArIyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQo+ID4gKyVZQU1MIDEuMg0K
PiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9jcHVmcmVx
L2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRy
ZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogTWVkaWFU
ZWsncyBDUFVGUkVRIEJpbmRpbmdzDQo+ID4gKw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAt
IEhlY3RvciBZdWFuIDxoZWN0b3IueXVhbkBtZWRpYXRlay5jb20+DQo+ID4gKw0KPiA+ICtkZXNj
cmlwdGlvbjoNCj4gPiArICBDUFVGUkVRIEhXIGlzIGEgaGFyZHdhcmUgZW5naW5lIHVzZWQgYnkg
TWVkaWFUZWsNCj4gPiArICBTb0NzIHRvIG1hbmFnZSBmcmVxdWVuY3kgaW4gaGFyZHdhcmUuIEl0
IGlzIGNhcGFibGUgb2YgY29udHJvbGxpbmcgZnJlcXVlbmN5DQo+ID4gKyAgZm9yIG11bHRpcGxl
IGNsdXN0ZXJzLg0KPiA+ICsNCj4gPiArcHJvcGVydGllczoNCj4gPiArICBjb21wYXRpYmxlOg0K
PiA+ICsgICAgY29uc3Q6IG1lZGlhdGVrLGNwdWZyZXEtaHcNCj4gPiArDQo+ID4gKyAgcmVnOg0K
PiA+ICsgICAgbWluSXRlbXM6IDENCj4gPiArICAgIG1heEl0ZW1zOiAyDQo+ID4gKyAgICBkZXNj
cmlwdGlvbjogfA0KPiA+ICsgICAgICBBZGRyZXNzZXMgYW5kIHNpemVzIGZvciB0aGUgbWVtb3J5
IG9mIHRoZSBIVyBiYXNlcyBpbiBlYWNoIGZyZXF1ZW5jeSBkb21haW4uDQo+ID4gKw0KPiA+ICty
ZXF1aXJlZDoNCj4gPiArICAtIGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsNCj4gPiAr
ZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBzb2Mgew0KPiA+ICsgICAgICAgICNhZGRy
ZXNzLWNlbGxzID0gPDI+Ow0KPiA+ICsgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsN
Cj4gPiArICAgICAgICBjcHVmcmVxX2h3OiBjcHVmcmVxQDExYmMwMCB7DQo+ID4gKyAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssY3B1ZnJlcS1odyI7DQo+ID4gKyAgICAgICAgICAg
IHJlZyA9IDwwIDB4MTFiYzEwIDAgMHg4Yz4sDQo+ID4gKyAgICAgICAgICAgICAgIDwwIDB4MTFi
Y2EwIDAgMHg4Yz47DQo+ID4gKyAgICAgICAgfTsNCj4gPiArICAgIH07DQo+IA0KPiBZb3Ugc3Rp
bGwgbmVlZCB0byBrZWVwIHRoZSBDUFUgc3BlY2lmaWMgcGFydCBoZXJlIGFuZCBleHBsYWluIGhv
dyB0aGlzDQo+IGJsb2NrIGlzIGdvaW5nIHRvIGdldCB1c2VkIHVzaW5nIHRoZSBvdGhlciBiaW5k
aW5nIHlvdSBhZGRlZC4NCj4gDQpPSywgd2lsbCBhZGQgY3B1IHBhcnQgaGVyZSBpbiB2OC4NCg0K
DQo=

