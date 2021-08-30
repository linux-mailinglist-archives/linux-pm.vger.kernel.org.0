Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7163FB2E0
	for <lists+linux-pm@lfdr.de>; Mon, 30 Aug 2021 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbhH3JJZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Aug 2021 05:09:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:56344 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234714AbhH3JJZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 30 Aug 2021 05:09:25 -0400
X-UUID: b4a819ab164a483990f1d8e6972d64b7-20210830
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=VLGRimzrdkfwchdwq+WzNLO96kLZ0J37codVtOuAFwA=;
        b=uSWwx+t/BtrU0SEx/x3WRD7gL38zmSPcum/+Okj6+57aH7j8/SoBxTxWddh4Xz3d/XWyM+2f63Ghza+ewGSyJpyyLr4aGzaRSlSZwm+RMgmkMZTdJR3mj280sW3wkGppD8oPv/3ctOY40leCocYo5DapBL5PBhdhDseP9swKDfM=;
X-UUID: b4a819ab164a483990f1d8e6972d64b7-20210830
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1007240998; Mon, 30 Aug 2021 17:08:29 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 30 Aug 2021 17:08:28 +0800
Received: from mtksdccf07 (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 30 Aug 2021 17:08:28 +0800
Message-ID: <964ef8cae3e1eb276da4d891a6daac6ed05bb734.camel@mediatek.com>
Subject: Re: [PATCH v14 2/3] cpufreq: Add of_perf_domain_get_sharing_cpumask
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>
Date:   Mon, 30 Aug 2021 17:08:27 +0800
In-Reply-To: <20210830050450.r4kfv72bsxsttnli@vireshk-i7>
References: <1630162872-25452-1-git-send-email-hector.yuan@mediatek.com>
         <1630162872-25452-3-git-send-email-hector.yuan@mediatek.com>
         <20210830050450.r4kfv72bsxsttnli@vireshk-i7>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTMwIGF0IDEwOjM0ICswNTMwLCBWaXJlc2ggS3VtYXIgd3JvdGU6DQo+
IE9uIDI4LTA4LTIxLCAyMzowMSwgSGVjdG9yIFl1YW4gd3JvdGU6DQo+ID4gRnJvbTogIkhlY3Rv
ci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBvZl9wZXJm
X2RvbWFpbl9nZXRfc2hhcmluZ19jcHVtYXNrIGZ1bmN0aW9uIHRvIGdyb3VwIGNwdQ0KPiA+IHRv
IHNwZWNpZmljIHBlcmZvcm1hbmNlIGRvbWFpbi4NCj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBI
ZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBpbmNs
dWRlL2xpbnV4L2NwdWZyZXEuaCB8ICAgMzkNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKykNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9jcHVmcmVxLmggYi9pbmNsdWRlL2xp
bnV4L2NwdWZyZXEuaA0KPiA+IGluZGV4IDlmZDcxOTQuLjQ5MTZkNzAgMTAwNjQ0DQo+ID4gLS0t
IGEvaW5jbHVkZS9saW51eC9jcHVmcmVxLmgNCj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2NwdWZy
ZXEuaA0KPiA+IEBAIC0xMyw2ICsxMyw4IEBADQo+ID4gICNpbmNsdWRlIDxsaW51eC9jb21wbGV0
aW9uLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9rb2JqZWN0Lmg+DQo+ID4gICNpbmNsdWRlIDxs
aW51eC9ub3RpZmllci5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvb2YuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvcG1fcW9zLmg+DQo+
ID4gICNpbmNsdWRlIDxsaW51eC9zcGlubG9jay5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgvc3lz
ZnMuaD4NCj4gPiBAQCAtMTAzNiw2ICsxMDM4LDQzIEBAIHZvaWQgYXJjaF9zZXRfZnJlcV9zY2Fs
ZShjb25zdCBzdHJ1Y3QNCj4gPiBjcHVtYXNrICpjcHVzLA0KPiA+ICB9DQo+ID4gICNlbmRpZg0K
PiA+ICANCj4gPiArI2lmZGVmIENPTkZJR19DUFVfRlJFUQ0KPiA+ICtzdGF0aWMgaW5saW5lIGlu
dCBvZl9wZXJmX2RvbWFpbl9nZXRfc2hhcmluZ19jcHVtYXNrKGludCBpbmRleCwNCj4gPiBjb25z
dCBjaGFyICpsaXN0X25hbWUsDQo+ID4gKwkJCQkJCSAgICAgY29uc3QgY2hhcg0KPiA+ICpjZWxs
X25hbWUsDQo+ID4gKwkJCQkJCSAgICAgc3RydWN0IGNwdW1hc2sNCj4gPiAqY3B1bWFzaykNCj4g
DQo+IFdoYXQgaGFwcGVuZWQgd2l0aCB0aGUgZGlzY3Vzc2lvbiB3ZSBoYWQgYWJvdXQgcmV0dXJu
aW5nIGluZGV4IGFuZA0KPiBwYXNzaW5nIENQVQ0KPiB0aGVyZSA/DQo+IA0KSGksIFZpcmVzaCwg
c29ycnkgZm9yIHRoaXMsIEkgZGlkbid0IHVwbG9hZCB0aGUgY29ycmVjdCB2ZXJzaW9uIG9mDQpj
cHVmcmVxLmguIFNob3VsZCBJIGp1c3QgZ28gdjE1IG9yIHlvdSB3YW50IHRvIGRvIHNvbWUgcmV2
aWV3IGZvciBvdGhlcg0KcGFydCBvZiBteSBwYXRjaGVzPyBUaGFua3MuDQo=

