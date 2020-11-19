Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B552B93BF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 14:41:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbgKSNkc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 08:40:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:43512 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726407AbgKSNkc (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 08:40:32 -0500
X-UUID: b34cd89420d04ec99fd42f4f533ccb8e-20201119
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=f+40F60WpF0RZTPE/zrEdYD2XiyfhWpsYsOzRWiBkB8=;
        b=IaY5ZYdlfEnGZ1UYxohbkFYvMeYXEsWBRo1RGp6SUtKGLiXoL1QhU5/kiZevF9mdakSzeBCF5Th7nC6W6lAG1znaoEkWhFgy7kzICYW9798X5Jw0Ws0XIQXD5Rk33UDMSG0/gczUt7+WrCUr7FLTF//1ejweY8NWg5aaMP3p9kM=;
X-UUID: b34cd89420d04ec99fd42f4f533ccb8e-20201119
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1081661305; Thu, 19 Nov 2020 21:40:22 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 19 Nov 2020 21:40:18 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 21:40:18 +0800
Message-ID: <1605793218.20463.5.camel@mtkswgap22>
Subject: Re: [PATCH v8 1/3] cpufreq: mediatek-hw: Add support for CPUFREQ HW
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     Lukasz Luba <lukasz.luba@arm.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
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
Date:   Thu, 19 Nov 2020 21:40:18 +0800
In-Reply-To: <9382b917-f20d-c7b5-42e4-46d11465073f@arm.com>
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
         <1603700349-5922-2-git-send-email-hector.yuan@mediatek.com>
         <9382b917-f20d-c7b5-42e4-46d11465073f@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gVGh1LCAyMDIwLTExLTE5IGF0IDEyOjQxICswMDAwLCBMdWthc3ogTHViYSB3cm90ZToNCj4g
SGkgSGVjdG9yLA0KPiANCj4gT24gMTAvMjYvMjAgODoxOSBBTSwgSGVjdG9yIFl1YW4gd3JvdGU6
DQo+ID4gRnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KPiA+
IA0KPiA+IEFkZCBjcHVmcmVxIEhXIHN1cHBvcnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTog
SGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCj4gDQo+IFtzbmlwXQ0KPiAN
Cj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgbXRrX2NwdWZyZXFfaHdfY3B1X2luaXQoc3RydWN0IGNw
dWZyZXFfcG9saWN5ICpwb2xpY3kpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBjcHVmcmVxX210ayAq
YzsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmNwdV9kZXY7DQo+ID4gKwlzdHJ1Y3QgZW1fZGF0YV9j
YWxsYmFjayBlbV9jYiA9IEVNX0RBVEFfQ0IobXRrX2NwdWZyZXFfZ2V0X2NwdV9wb3dlcik7DQo+
ID4gKwlzdHJ1Y3QgcG1fcW9zX3JlcXVlc3QgKnFvc19yZXF1ZXN0Ow0KPiA+ICsJaW50IHNpZywg
cHdyX2h3ID0gQ1BVRlJFUV9IV19TVEFUVVMgfCBTVlNfSFdfU1RBVFVTOw0KPiA+ICsNCj4gPiAr
CXFvc19yZXF1ZXN0ID0ga3phbGxvYyhzaXplb2YoKnFvc19yZXF1ZXN0KSwgR0ZQX0tFUk5FTCk7
DQo+ID4gKwlpZiAoIXFvc19yZXF1ZXN0KQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsN
Cj4gPiArCWNwdV9kZXYgPSBnZXRfY3B1X2RldmljZShwb2xpY3ktPmNwdSk7DQo+ID4gKwlpZiAo
IWNwdV9kZXYpIHsNCj4gPiArCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgY3B1JWQgZGV2aWNlXG4i
LCBwb2xpY3ktPmNwdSk7DQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJYyA9IG10a19mcmVxX2RvbWFpbl9tYXBbcG9saWN5LT5jcHVdOw0KPiA+ICsJaWYgKCFj
KSB7DQo+ID4gKwkJcHJfZXJyKCJObyBzY2FsaW5nIHN1cHBvcnQgZm9yIENQVSVkXG4iLCBwb2xp
Y3ktPmNwdSk7DQo+ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJ
Y3B1bWFza19jb3B5KHBvbGljeS0+Y3B1cywgJmMtPnJlbGF0ZWRfY3B1cyk7DQo+ID4gKw0KPiA+
ICsJcG9saWN5LT5mcmVxX3RhYmxlID0gYy0+dGFibGU7DQo+ID4gKwlwb2xpY3ktPmRyaXZlcl9k
YXRhID0gYzsNCj4gDQo+IFRvIGNvbnRyb2wgZnJlcXVlbmN5IHRyYW5zaXRpb24gcmF0ZSBpbiBz
Y2hlZHV0aWwsIHlvdSBtaWdodA0KPiBiZSBpbnRlcmVzdGVkIGluIHNldHRpbmc6DQo+IA0KPiBw
b2xpY3ktPmNwdWluZm8udHJhbnNpdGlvbl9sYXRlbmN5ID0gPG10a192YWx1ZV9oZXJlPjsNCj4g
DQo+IEV4YW1wbGUsIHdoZW4gdGhpcyBsYXRlbmN5IHZhbHVlIGNvbWVzIGZyb20gRlcgWzFdDQo+
IA0KT0ssIEkgd2lsbCBhZGQgaXQgaW4gdjkuDQo+ID4gKw0KPiA+ICsJLyogTGV0IENQVXMgbGVh
dmUgaWRsZS1vZmYgc3RhdGUgZm9yIFNWUyBDUFUgaW5pdGlhbGl6aW5nICovDQo+ID4gKwljcHVf
bGF0ZW5jeV9xb3NfYWRkX3JlcXVlc3QocW9zX3JlcXVlc3QsIDApOw0KPiA+ICsNCj4gPiArCS8q
IEhXIHNob3VsZCBiZSBpbiBlbmFibGVkIHN0YXRlIHRvIHByb2NlZWQgbm93ICovDQo+ID4gKwl3
cml0ZWxfcmVsYXhlZCgweDEsIGMtPnJlZ19iYXNlc1tSRUdfRlJFUV9FTkFCTEVdKTsNCj4gPiAr
DQo+ID4gKwlpZiAocmVhZGxfcG9sbF90aW1lb3V0KGMtPnJlZ19iYXNlc1tSRUdfRlJFUV9IV19T
VEFURV0sIHNpZywNCj4gPiArCQkJICAgICAgIChzaWcgJiBwd3JfaHcpID09IHB3cl9odywgUE9M
TF9VU0VDLA0KPiA+ICsJCQkgICAgICAgVElNRU9VVF9VU0VDKSkgew0KPiA+ICsJCWlmICghKHNp
ZyAmIENQVUZSRVFfSFdfU1RBVFVTKSkgew0KPiA+ICsJCQlwcl9pbmZvKCJjcHVmcmVxIGhhcmR3
YXJlIG9mIENQVSVkIGlzIG5vdCBlbmFibGVkXG4iLA0KPiA+ICsJCQkJcG9saWN5LT5jcHUpOw0K
PiA+ICsJCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiArCQl9DQo+ID4gKw0KPiA+ICsJCXByX2luZm8o
IlNWUyBvZiBDUFUlZCBpcyBub3QgZW5hYmxlZFxuIiwgcG9saWN5LT5jcHUpOw0KPiA+ICsJfQ0K
PiA+ICsNCj4gPiArCWVtX2Rldl9yZWdpc3Rlcl9wZXJmX2RvbWFpbihjcHVfZGV2LCBjLT5ucl9v
cHAsICZlbV9jYiwgcG9saWN5LT5jcHVzKTsNCj4gDQo+IFBsZWFzZSBrZWVwIGluIG1pbmQgdGhh
dCB0aGlzIGlzIGdvaW5nIHRvIGJlIGNoYW5nZWQgc29vbiB3aXRoIGEgbmV3DQo+IGFyZ3VtZW50
OiAnbWlsbGl3YXR0cycuIEl0J3MgcXVldWVkIGluIHBtL2xpbnV4LW5leHQgWzJdLg0KPiANCk9L
LCB0aGFua3MgZm9yIHRoZSByZW1pbmQuDQo+IFJlZ2FyZHMsDQo+IEx1a2Fzeg0KPiANCj4gWzFd
IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZl
cnMvY3B1ZnJlcS9zY21pLWNwdWZyZXEuYyNMMTk0DQo+IFsyXSANCj4gaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvcmFmYWVsL2xpbnV4LXBtLmdpdC9jb21t
aXQvP2g9bGludXgtbmV4dCZpZD1jMjUwZDUwZmUyY2U2MjdjYTk4MDVkOWM4YWMxMWNiYmY5MjJh
NGE2DQo+IA0KDQo=

