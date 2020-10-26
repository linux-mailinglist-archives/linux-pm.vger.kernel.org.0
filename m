Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9232986C8
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 07:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770289AbgJZGQS (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 02:16:18 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33653 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389782AbgJZGQS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 02:16:18 -0400
X-UUID: 82867f4a05ea473e89cb8fdab7f0c9a0-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=fFYuqSgziReu/G4QjEAJhcURj3Mh57kwDqeA7BpmSO4=;
        b=crsPT7kGO0GWyOZretEV0xsoCp46eZDuyjp+xEpbM69QUvnWiA2ZvV+GSMW5VChu1GLvAcNwZQzg+o+Sm1XQR5tg1ptQN2S47lZcY8fDeYtXnYcrHd501Om/iBkBzmlAlzYdI0WqfuU1t4ClpPyMLqZtwggva72V5mFUW6UBbY8=;
X-UUID: 82867f4a05ea473e89cb8fdab7f0c9a0-20201026
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2005564280; Mon, 26 Oct 2020 14:16:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 14:15:25 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 14:15:24 +0800
Message-ID: <1603692925.20535.5.camel@mtkswgap22>
Subject: Re: [PATCH v1 3/6] dt-bindings: cpufreq: add bindings for MediaTek
 cpufreq HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, Maxime Ripard <mripard@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        "Amit Kucheria" <amit.kucheria@linaro.org>,
        <linux-pm@vger.kernel.org>, Dave Gerlach <d-gerlach@ti.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <wsd_upstream@mediatek.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-arm-kernel@lists.infradead.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Florian Fainelli <f.fainelli@gmail.com>
Date:   Mon, 26 Oct 2020 14:15:25 +0800
In-Reply-To: <20201023161500.GA2800310@bogus>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
         <1603441493-18554-4-git-send-email-hector.yuan@mediatek.com>
         <20201023161500.GA2800310@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTEwLTIzIGF0IDExOjE1IC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gRnJpLCAyMyBPY3QgMjAyMCAxNjoyNDo1MCArMDgwMCwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+
ID4gRnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0K
PiA+IEFkZCBkZXZpY2V0cmVlIGJpbmRpbmdzIGZvciBNZWRpYVRlayBIVyBkcml2ZXIuDQo+ID4g
DQo+ID4gU2lnbmVkLW9mZi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNv
bT4NCj4gPiAtLS0NCj4gPiAgLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1o
dy55YW1sICAgICAgfCAgIDQ2ICsrKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA0NiBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwN
Cj4gPiANCj4gDQo+IA0KPiBNeSBib3QgZm91bmQgZXJyb3JzIHJ1bm5pbmcgJ21ha2UgZHRfYmlu
ZGluZ19jaGVjaycgb24geW91ciBwYXRjaDoNCj4gDQo+IHlhbWxsaW50IHdhcm5pbmdzL2Vycm9y
czoNCj4gLi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVx
LW1lZGlhdGVrLWh3LnlhbWw6NDY6MTogW3dhcm5pbmddIHRvbyBtYW55IGJsYW5rIGxpbmVzICg0
ID4gMSkgKGVtcHR5LWxpbmVzKQ0KPiANCj4gZHRzY2hlbWEvZHRjIHdhcm5pbmdzL2Vycm9yczoN
Cj4gDQo+IA0KPiBTZWUgaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8xMzg2NTcy
DQo+IA0KPiBUaGUgYmFzZSBmb3IgdGhlIHBhdGNoIGlzIGdlbmVyYWxseSB0aGUgbGFzdCByYzEu
IEFueSBkZXBlbmRlbmNpZXMNCj4gc2hvdWxkIGJlIG5vdGVkLg0KPiANCj4gSWYgeW91IGFscmVh
ZHkgcmFuICdtYWtlIGR0X2JpbmRpbmdfY2hlY2snIGFuZCBkaWRuJ3Qgc2VlIHRoZSBhYm92ZQ0K
PiBlcnJvcihzKSwgdGhlbiBtYWtlIHN1cmUgJ3lhbWxsaW50JyBpcyBpbnN0YWxsZWQgYW5kIGR0
LXNjaGVtYSBpcyB1cCB0bw0KPiBkYXRlOg0KPiANCj4gcGlwMyBpbnN0YWxsIGR0c2NoZW1hIC0t
dXBncmFkZQ0KPiANCj4gUGxlYXNlIGNoZWNrIGFuZCByZS1zdWJtaXQuDQo+IA0KT0ssIHdpbGwg
Zml4IHRoaXMgd2FybmluZyBpbiB2OC4NCg0KDQo=

