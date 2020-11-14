Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 970442B2FC8
	for <lists+linux-pm@lfdr.de>; Sat, 14 Nov 2020 19:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgKNSla (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 14 Nov 2020 13:41:30 -0500
Received: from mga03.intel.com ([134.134.136.65]:5211 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbgKNSl3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 14 Nov 2020 13:41:29 -0500
IronPort-SDR: 5ey5BDiLXUIcmMeHR1EG7+94kihFVKGQ6l2+LVm2C1UBmjnDWwwN7VNf1/dc1zMweNg1cI2QcU
 PN+Fipruf6WA==
X-IronPort-AV: E=McAfee;i="6000,8403,9805"; a="170696362"
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="170696362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2020 10:41:29 -0800
IronPort-SDR: drCe00QhedDF28lBQs2q3CRMtIpqUSH/e1VccXVKPiAYBcW4Wm8fgLtrxm2KTtSRzSm3o9//nR
 nBjvXO8YF67A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,478,1596524400"; 
   d="scan'208";a="340095375"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 14 Nov 2020 10:41:29 -0800
Received: from shsmsx604.ccr.corp.intel.com (10.109.6.214) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 14 Nov 2020 10:41:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 SHSMSX604.ccr.corp.intel.com (10.109.6.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 15 Nov 2020 02:41:25 +0800
Received: from orsmsx610.amr.corp.intel.com ([10.22.229.23]) by
 ORSMSX610.amr.corp.intel.com ([10.22.229.23]) with mapi id 15.01.1713.004;
 Sat, 14 Nov 2020 10:41:23 -0800
From:   "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To:     "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "andres@anarazel.de" <andres@anarazel.de>
CC:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
Thread-Topic: [PATCH] thermal: intel_pch_thermal: Add PCI ids for Lewisburg
 PCH.
Thread-Index: AQHWurXAiZ2S27JbI0KcWWP3JmxpAw==
Date:   Sat, 14 Nov 2020 18:41:23 +0000
Message-ID: <58f71764994d5f2ea5dda231605cfe046c3050c8.camel@intel.com>
References: <2fd3733b-ed67-80e0-7b27-8e3c421eeb9c@linaro.org>
         <20201113204916.1144907-1-andres@anarazel.de>
In-Reply-To: <20201113204916.1144907-1-andres@anarazel.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
x-originating-ip: [10.1.200.100]
Content-Type: text/plain; charset="utf-8"
Content-ID: <93C16CF009B3414DAD716BEBCCF7F25D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

T24gRnJpLCAyMDIwLTExLTEzIGF0IDEyOjQ5IC0wODAwLCBBbmRyZXMgRnJldW5kIHdyb3RlOg0K
PiBJIG5vdGljZWQgdGhhdCBJIGNvdWxkbid0IHJlYWQgdGhlIFBDSCB0ZW1wZXJhdHVyZSBvbiBt
eSB3b3Jrc3RhdGlvbg0KPiAoQzYyMCBzZXJpZXMgY2hpcHNldCwgdy8gMnggWGVvbiBHb2xkIDUy
MTUgQ1BVcykgZGlyZWN0bHksIGJ1dCBoYWQgdG8NCj4gZ28NCj4gdGhyb3VnaCBJUE1JLiBMb29r
aW5nIGF0IHRoZSBkYXRhIHNoZWV0LCBpdCBsb29rcyB0byBtZSBsaWtlIHRoZQ0KPiBleGlzdGlu
ZyBpbnRlbCBQQ0ggdGhlcm1hbCBkcml2ZXIgc2hvdWxkIHdvcmsgd2l0aG91dCBjaGFuZ2VzIGZv
cg0KPiBMZXdpc2J1cmcuDQo+IA0KPiBJIHN1c3BlY3QgdGhlcmUncyBzb21lIG90aGVyIFBDSSBJ
RHMgbWlzc2luZy4gQnV0IEkgaG9wZSBzb21lYm9keSBhdA0KPiBJbnRlbCB3b3VsZCBoYXZlIGFu
IGVhc2llciB0aW1lIGZpZ3VyaW5nIHRoYXQgb3V0IHRoYW4gSS4uLg0KPiANCj4gQ2M6IERhbmll
bCBMZXpjYW5vIDxkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnPg0KPiBDYzogU3Jpbml2YXMgUGFu
ZHJ1dmFkYSA8c3Jpbml2YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+IENjOiBUdXNo
YXIgRGF2ZSA8dHVzaGFyLm4uZGF2ZUBpbnRlbC5jb20+DQo+IENjOiBaaGFuZyBSdWkgPHJ1aS56
aGFuZ0BpbnRlbC5jb20+DQo+IENjOiBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gTGluazogDQo+IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xrbWwvMjAyMDAxMTUxODQ0MTUuMTcyNjk1My0xLWFuZHJlc0BhbmFyYXplbC5kZS8N
Cj4gU2lnbmVkLW9mZi1ieTogQW5kcmVzIEZyZXVuZCA8YW5kcmVzQGFuYXJhemVsLmRlPg0KUmV2
aWV3ZWQtYnk6IFBhbmRydXZhZGEsIFNyaW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGxpbnV4
LmludGVsLmNvbT4NCg0KPiAtLS0NCj4gIGRyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wY2hf
dGhlcm1hbC5jIHwgMTAgKysrKysrKysrLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9p
bnRlbC9pbnRlbF9wY2hfdGhlcm1hbC5jDQo+IGIvZHJpdmVycy90aGVybWFsL2ludGVsL2ludGVs
X3BjaF90aGVybWFsLmMNCj4gaW5kZXggM2I4MTNlYmI2Y2ExLi43Nzg1ZTA1ZjQ2ZjAgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wY2hfdGhlcm1hbC5jDQo+ICsr
KyBiL2RyaXZlcnMvdGhlcm1hbC9pbnRlbC9pbnRlbF9wY2hfdGhlcm1hbC5jDQo+IEBAIC0yNiw2
ICsyNiw3IEBADQo+ICAjZGVmaW5lIFBDSF9USEVSTUFMX0RJRF9DTkxfSAkweEEzNzkgLyogQ05M
LUggUENIICovDQo+ICAjZGVmaW5lIFBDSF9USEVSTUFMX0RJRF9DTkxfTFAJMHgwMkY5IC8qIENO
TC1MUCBQQ0ggKi8NCj4gICNkZWZpbmUgUENIX1RIRVJNQUxfRElEX0NNTF9ICTBYMDZGOSAvKiBD
TUwtSCBQQ0ggKi8NCj4gKyNkZWZpbmUgUENIX1RIRVJNQUxfRElEX0xXQgkweEExQjEgLyogTGV3
aXNidXJnIFBDSCAqLw0KPiAgDQo+ICAvKiBXaWxkY2F0IFBvaW50LUxQICBQQ0ggVGhlcm1hbCBy
ZWdpc3RlcnMgKi8NCj4gICNkZWZpbmUgV1BUX1RFTVAJMHgwMDAwCS8qIFRlbXBlcmF0dXJlICov
DQo+IEBAIC0yNzYsNiArMjc3LDcgQEAgZW51bSBib2FyZF9pZHMgew0KPiAgCWJvYXJkX3NrbCwN
Cj4gIAlib2FyZF9jbmwsDQo+ICAJYm9hcmRfY21sLA0KPiArCWJvYXJkX2x3YiwNCj4gIH07DQo+
ICANCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYm9hcmRfaW5mbyB7DQo+IEBAIC0zMDEsNyArMzAz
LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgYm9hcmRfaW5mbyB7DQo+ICAJW2JvYXJkX2NtbF0g
PSB7DQo+ICAJCS5uYW1lID0gInBjaF9jb21ldGxha2UiLA0KPiAgCQkub3BzID0gJnBjaF9kZXZf
b3BzX3dwdCwNCj4gLQl9DQo+ICsJfSwNCj4gKwlbYm9hcmRfbHdiXSA9IHsNCj4gKwkJLm5hbWUg
PSAicGNoX2xld2lzYnVyZyIsDQo+ICsJCS5vcHMgPSAmcGNoX2Rldl9vcHNfd3B0LA0KPiArCX0s
DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgaW50IGludGVsX3BjaF90aGVybWFsX3Byb2JlKHN0cnVj
dCBwY2lfZGV2ICpwZGV2LA0KPiBAQCAtNDE1LDYgKzQyMSw4IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgcGNpX2RldmljZV9pZA0KPiBpbnRlbF9wY2hfdGhlcm1hbF9pZFtdID0gew0KPiAgCQkuZHJp
dmVyX2RhdGEgPSBib2FyZF9jbmwsIH0sDQo+ICAJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURf
SU5URUwsIFBDSF9USEVSTUFMX0RJRF9DTUxfSCksDQo+ICAJCS5kcml2ZXJfZGF0YSA9IGJvYXJk
X2NtbCwgfSwNCj4gKwl7IFBDSV9ERVZJQ0UoUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENIX1RIRVJN
QUxfRElEX0xXQiksDQo+ICsJCS5kcml2ZXJfZGF0YSA9IGJvYXJkX2x3YiwgfSwNCj4gIAl7IDAs
IH0sDQo+ICB9Ow0KPiAgTU9EVUxFX0RFVklDRV9UQUJMRShwY2ksIGludGVsX3BjaF90aGVybWFs
X2lkKTsNCg==
