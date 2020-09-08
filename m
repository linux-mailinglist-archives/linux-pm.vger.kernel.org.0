Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 247472608AE
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 04:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbgIHCfS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Sep 2020 22:35:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63879 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728185AbgIHCfR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Sep 2020 22:35:17 -0400
X-UUID: 953299e669834864b7c324e40744cd9b-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zPKIe0f4htLXPBgdV5V5ez5FoqIWorB9FGa+1tg+aIs=;
        b=T5mCB5XgJuIuJBlClQ7py/z68y8xD/sgGKUjrjgd42Ri0+A/2mM1NNaVu4DD0f3QEPvb7sd5ryY2EVO6OhbtszXAAfsCNn6BAqJgt9m4L+7UKlEONREMnXT0j7HDT2PrOAqbl68cRCJMPsPpV3T3BawWK9hfdhepyB+0mNorl6k=;
X-UUID: 953299e669834864b7c324e40744cd9b-20200908
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 795396862; Tue, 08 Sep 2020 10:35:13 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 10:35:11 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 10:35:07 +0800
Message-ID: <1599532510.17707.4.camel@mtkswgap22>
Subject: Re: [PATCH v3] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>, <wsd_upstream@mediatek.com>
Date:   Tue, 8 Sep 2020 10:35:10 +0800
In-Reply-To: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
References: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 20163B1F379299FECF0559FE30ED5B620CF238BC658FC8CDEAA9638C5FF6418A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

SGksIFNpcnM6DQoNClBsZWFzZSBraW5kbHkgbGV0IG1lIGtub3cgeW91ciByZXZpZXcgdGhvdWdo
dHMgb2YgdGhpcyBwYXRjaC4NCkFwcHJlY2lhdGVkLg0KIA0KT24gV2VkLCAyMDIwLTA4LTI2IGF0
IDIxOjAxICswODAwLCBIZWN0b3IgWXVhbiB3cm90ZToNCj4gVGhlIENQVWZyZXEgSFcgcHJlc2Vu
dCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRzIHRoZSBzdGVwcyBuZWNlc3Nhcnkg
Zm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kgb2YgQ1BVcy4gDQo+IFRoZSBkcml2ZXIgaW1wbGVt
ZW50cyB0aGUgY3B1ZnJlcSBkcml2ZXIgaW50ZXJmYWNlIGZvciB0aGlzIGhhcmR3YXJlIGVuZ2lu
ZS4gDQo+IA0KPiBUaGlzIHBhdGNoIGRlcGVuZHMgb24gdGhlIE1UNjc5OSBEVFMgcGF0Y2ggc3Vi
bWl0dGVkIGJ5IEhhbmtzIENoZW4NCj4gIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDIwLzgvNC8x
MDk0DQo+IA0KPiANCj4gSGVjdG9yLll1YW4gKDIpOg0KPiAgIGNwdWZyZXE6IG1lZGlhdGVrLWh3
OiBBZGQgc3VwcG9ydCBmb3IgTWVkaWF0ZWsgY3B1ZnJlcSBIVyBkcml2ZXINCj4gICBkdC1iaW5k
aW5nczogY3B1ZnJlcTogYWRkIGJpbmRpbmdzIGZvciBNZWRpYVRlayBjcHVmcmVxIEhXDQo+IA0K
PiAgLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAg
MTQxICsrKysrKysrKw0KPiAgZHJpdmVycy9jcHVmcmVxL0tjb25maWcuYXJtICAgICAgICAgICAg
ICAgICAgICAgICAgfCAgIDEyICsNCj4gIGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQo+ICBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWst
Y3B1ZnJlcS1ody5jICAgICAgICAgICAgICB8ICAzMDUgKysrKysrKysrKysrKysrKysrKysNCj4g
IDQgZmlsZXMgY2hhbmdlZCwgNDU5IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlh
dGVrLWh3LnlhbWwNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0
ZWstY3B1ZnJlcS1ody5jDQoNCg==

