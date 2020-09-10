Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFF3263B9E
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 05:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725773AbgIJDso (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 23:48:44 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49871 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729822AbgIJDsb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 23:48:31 -0400
X-UUID: 2df7bd4b00f14007921cf70cb6f6ce8e-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=h4KTk5shQrSyQDIxPJZftxCwDg7ngCtftlyh+RM3c1o=;
        b=TWtYHWM+f2I2op8pMxtixr3wdhqoFJJr9dvWVQBh0Fp+CtK87F3Bhu4kFBd2fXNoYTiLTUQG9VbLClJ04eRvkkosGnHB4H6sG8U2rEdSFs4+LvPJXgEzSz0mD+GdX8nGaL9bEgC8CtnPIR1XWAHyvwEZbfpABlX6KoR7WOhyX2A=;
X-UUID: 2df7bd4b00f14007921cf70cb6f6ce8e-20200910
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 379000295; Thu, 10 Sep 2020 11:48:26 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 11:48:21 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 11:48:22 +0800
Message-ID: <1599709702.7042.1.camel@mtkswgap22>
Subject: Re: [PATCH v6 1/2] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rob Herring" <robh+dt@kernel.org>, <linux-kernel@vger.kernel.org>,
        <wsd_upstream@mediatek.com>
Date:   Thu, 10 Sep 2020 11:48:22 +0800
In-Reply-To: <20200910034245.eqya625p7la33dkc@vireshk-i7>
References: <1599658476-16562-1-git-send-email-hector.yuan@mediatek.com>
         <1599658476-16562-2-git-send-email-hector.yuan@mediatek.com>
         <20200910034245.eqya625p7la33dkc@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: A78FA5853F92044C4771A9B1C8BF1BDA2274661E2593E21FCABB848E93EDED232000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDA5OjEyICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDA5LTA5LTIwLCAyMTozNCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gK3N0YXRpYyB1bnNp
Z25lZCBpbnQgbXRrX2NwdWZyZXFfaHdfZ2V0KHVuc2lnbmVkIGludCBjcHUpDQo+ID4gK3sNCj4g
PiArCXN0cnVjdCBjcHVmcmVxX210ayAqYzsNCj4gPiArCXN0cnVjdCBjcHVmcmVxX3BvbGljeSAq
cG9saWN5Ow0KPiA+ICsJdW5zaWduZWQgaW50IGluZGV4Ow0KPiA+ICsNCj4gPiArCXBvbGljeSA9
IGNwdWZyZXFfY3B1X2dldF9yYXcoY3B1KTsNCj4gPiArCWlmICghcG9saWN5KQ0KPiA+ICsJCXJl
dHVybiAwOw0KPiANCj4gV2h5IGRpZG4ndCB5b3UgZHJvcCBwb2xpY3kgYXMgd2UgZGlzY3Vzc2Vk
IGluIHByZXZpb3VzIHZlcnNpb24gPw0KPiANClNvcnJ5IEkgbWlzc2VkIHRoYXQuIFRoYW5rIHlv
dS4NCj4gPiArCWMgPSBtdGtfZnJlcV9kb21haW5fbWFwW2NwdV07DQo+ID4gKw0KPiA+ICsJaW5k
ZXggPSByZWFkbF9yZWxheGVkKGMtPnJlZ19iYXNlc1tSRUdfUEVSRl9TVEFURV0pOw0KPiA+ICsJ
aW5kZXggPSBtaW4oaW5kZXgsIExVVF9NQVhfRU5UUklFUyAtIDEpOw0KPiA+ICsNCj4gPiArCXJl
dHVybiBwb2xpY3ktPmZyZXFfdGFibGVbaW5kZXhdLmZyZXF1ZW5jeTsNCj4gDQo+IHBvbGljeS0+
ZnJlcV90YWJsZSBhbmQgYy0+dGFibGUgYXJlIHNhbWUsIGlzbid0IGl0ID8NCj4gDQpZZXMsIHlv
dSBhcmUgcmlnaHQuDQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1f
ZHJpdmVyIG10a19jcHVmcmVxX2h3X2RyaXZlciA9IHsNCj4gPiArCS5wcm9iZSA9IG10a19jcHVm
cmVxX2h3X2RyaXZlcl9wcm9iZSwNCj4gPiArCS5yZW1vdmUgPSBtdGtfY3B1ZnJlcV9od19kcml2
ZXJfcmVtb3ZlLA0KPiA+ICsJLmRyaXZlciA9IHsNCj4gPiArCQkubmFtZSA9ICJtdGstY3B1ZnJl
cS1odyIsDQo+ID4gKwkJLm9mX21hdGNoX3RhYmxlID0gbXRrX2NwdWZyZXFfaHdfbWF0Y2gsDQo+
ID4gKwl9LA0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+IFJlbW92ZSB0aGlzIGJsYW5rIGxpbmUuDQo+
IA0KT0sNCj4gPiArbW9kdWxlX3BsYXRmb3JtX2RyaXZlcihtdGtfY3B1ZnJlcV9od19kcml2ZXIp
Ow0KPiA+ICsNCj4gPiArTU9EVUxFX0RFU0NSSVBUSU9OKCJtdGsgQ1BVRlJFUSBIVyBEcml2ZXIi
KTsNCj4gDQo+IE1heWJlIHdyaXRlIHRoaXMgaXMgIk1lZGlhdGVrIGNwdWZyZXEtaHcgZHJpdmVy
IiA/DQo+IA0KT0sNCj4gPiArTU9EVUxFX0xJQ0VOU0UoIkdQTCB2MiIpOw0KPiA+IC0tIA0KPiA+
IDEuNy45LjUNCj4gDQoNCg==

