Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE58C2986CF
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 07:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770320AbgJZGT5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 02:19:57 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:35867 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1770305AbgJZGT4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 02:19:56 -0400
X-UUID: a67159984eeb43d094518b94ac1390cd-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=N5cnpKHxqvg4FtGCE4b75ACj8g4RCxqwiKLoHCbkZXs=;
        b=mYfw8KvPCSjMBAofj5hJ4YeIHYfuBEyXUnJCHj7Wu27/RexTQTKdR1vfWdX18u2P2UL411QFhb0jUTO+0GYxckMn8MuIzpw9T6vBN8gRBjR+1Yy9RpmDBDPTvIvd55llakCn4OclKL+ntK0UH9St0n2WDtOGMGHRNhvUeEag86o=;
X-UUID: a67159984eeb43d094518b94ac1390cd-20201026
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 65964395; Mon, 26 Oct 2020 14:14:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 14:14:13 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 14:14:12 +0800
Message-ID: <1603692853.20535.4.camel@mtkswgap22>
Subject: Re: [PATCH v1 2/6] dt-bindings: arm: cpus: Document
 'mtk,freq-domain' property
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Mon, 26 Oct 2020 14:14:13 +0800
In-Reply-To: <20201023082941.yfjewzdsnspug7by@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
         <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
         <20201023082941.yfjewzdsnspug7by@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDEzOjU5ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDIzLTEwLTIwLCAxNjoyNCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogIkhlY3Rv
ci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBkZXZpY2V0
cmVlIGRvY3VtZW50YXRpb24gZm9yICdtdGssZnJlcS1kb21haW4nIHByb3BlcnR5IHNwZWNpZmlj
DQo+ID4gdG8gTWVkaWF0ZWsgQ1BVcy4gVGhpcyBwcm9wZXJ0eSBpcyB1c2VkIHRvIHJlZmVyZW5j
ZSB0aGUgQ1BVRlJFUSBub2RlDQo+ID4gYWxvbmcgd2l0aCB0aGUgZG9tYWluIGlkLg0KPiA+IA0K
PiA+IFNpZ25lZC1vZmYtYnk6IEhlY3Rvci5ZdWFuIDxoZWN0b3IueXVhbkBtZWRpYXRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1
cy55YW1sIHwgICAgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygr
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvYXJtL2NwdXMueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
Y3B1cy55YW1sDQo+ID4gaW5kZXggMTIyMmJmMS4uMDZhNmY1YiAxMDA2NDQNCj4gPiAtLS0gYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQo+ID4gQEAg
LTI1NSw2ICsyNTUsMTIgQEAgcHJvcGVydGllczoNCj4gPiAgDQo+ID4gICAgICAgIHdoZXJlIHZv
bHRhZ2UgaXMgaW4gViwgZnJlcXVlbmN5IGlzIGluIE1Iei4NCj4gPiAgDQo+ID4gKyAgbXRrLWZy
ZXEtZG9tYWluOg0KPiA+ICsgICAgJHJlZjogJy9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRp
b25zL3BoYW5kbGUtYXJyYXknDQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgQ1BV
cyBzdXBwb3J0aW5nIGZyZXEtZG9tYWluIG11c3Qgc2V0IHRoZWlyICJtdGstZnJlcS1kb21haW4i
IHByb3BlcnR5DQo+ID4gKyAgICAgIHdpdGggcGhhbmRsZSB0byBhIGNwdWZyZXFfaHcgbm9kZSBm
b2xsb3dlZCBieSB0aGUgZG9tYWluIGlkLg0KPiA+ICsNCj4gDQo+IE5hbWUgc2hvdWxkIGhhdmUg
YmVlbiBtdGssZnJlcS1kb21haW4gSSBiZWxpZXZlLiBSb2Igd2lsbCBjb25maXJtIHRoZQ0KPiBy
ZXN0Lg0KPiANCk9LLCB3aWxsIG5hbWUgaXQgYXMgbWVkaWF0ZWssZnJlcS1kb21haW4uIFRoYW5r
IHlvdS4NCg0KPiA+ICAgIHBvd2VyLWRvbWFpbnM6DQo+ID4gICAgICAkcmVmOiAnL3NjaGVtYXMv
dHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvcGhhbmRsZS1hcnJheScNCj4gPiAgICAgIGRlc2NyaXB0
aW9uOg0KPiA+IC0tIA0KPiA+IDEuNy45LjUNCj4gDQoNCg==

