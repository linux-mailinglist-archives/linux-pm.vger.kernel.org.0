Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFAB296B23
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460582AbgJWIZ0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:25:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:54300 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S460535AbgJWIZP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:25:15 -0400
X-UUID: 1980161871ce45309552688f71154944-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=jUKvU/HzCuL2PPK0da8gu19V+NdKcPP0gYDYa+SwXrM=;
        b=oLXc/imYIxdZ4AZKP6NZ7gJz4z1l91xCXtsjN4qAlDXT4dTafm45S/AY3g7u0OnFamR2eqEQkoKWnA1SlXc6T14Qyut+JcJzSXReox+my2mAWheBlu4zdHZ4fFBLZtVyxAHcY37PHG+SX+ZEDcjBYHmFjGxyrLJ2p14yiL+5fag=;
X-UUID: 1980161871ce45309552688f71154944-20201023
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 358697557; Fri, 23 Oct 2020 16:25:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 16:24:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 16:24:59 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1 5/6] cpufreq: mediatek-hw: Add SVS CPU initialization
Date:   Fri, 23 Oct 2020 16:24:52 +0800
Message-ID: <1603441493-18554-6-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpVc2UgcG1f
cW9zIHRvIGJsb2NrIGNwdS1pZGxlIHN0YXRlIGZvciBTVlMgaW5pdGlhbGl6aW5nLg0KQ1BVcyBt
dXN0IGJlIGluIHBvd2VyIG9uIHN0YXRlIHdoZW4gZG9pbmcgU1ZTLg0KQWRkIHBvbGxpbmcgYWNr
IHdoaWxlIGNvdWZyZXEgaHcgaXMgcmVhZHkuKFNWUyBpbml0IGRvbmUpDQoNClNpZ25lZC1vZmYt
Ynk6IEhlY3Rvci5ZdWFuIDxoZWN0b3IueXVhbkBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJz
L2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jIHwgICAzMiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jIGIvZHJpdmVycy9j
cHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYw0KaW5kZXggMjQxZDkzZi4uMTVmYmEyMCAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLWh3LmMNCisrKyBiL2Ry
aXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLWh3LmMNCkBAIC03LDIwICs3LDI3IEBADQog
I2luY2x1ZGUgPGxpbnV4L2NwdWZyZXEuaD4NCiAjaW5jbHVkZSA8bGludXgvZW5lcmd5X21vZGVs
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L2luaXQuaD4NCisjaW5jbHVkZSA8bGludXgvaW9wb2xsLmg+
DQogI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4N
CiAjaW5jbHVkZSA8bGludXgvb2ZfYWRkcmVzcy5oPg0KICNpbmNsdWRlIDxsaW51eC9vZl9wbGF0
Zm9ybS5oPg0KKyNpbmNsdWRlIDxsaW51eC9wbV9xb3MuaD4NCiAjaW5jbHVkZSA8bGludXgvc2xh
Yi5oPg0KIA0KICNkZWZpbmUgTFVUX01BWF9FTlRSSUVTCQkJMzJVDQogI2RlZmluZSBMVVRfRlJF
UQkJCUdFTk1BU0soMTEsIDApDQogI2RlZmluZSBMVVRfUk9XX1NJWkUJCQkweDQNCisjZGVmaW5l
IENQVUZSRVFfSFdfU1RBVFVTCQlCSVQoMCkNCisjZGVmaW5lIFNWU19IV19TVEFUVVMJCQlCSVQo
MSkNCisjZGVmaW5lIFBPTExfVVNFQwkJCTEwMDANCisjZGVmaW5lIFRJTUVPVVRfVVNFQwkJCTMw
MDAwMA0KIA0KIGVudW0gew0KIAlSRUdfRlJFUV9MVVRfVEFCTEUsDQogCVJFR19GUkVRX0VOQUJM
RSwNCiAJUkVHX0ZSRVFfUEVSRl9TVEFURSwNCisJUkVHX0ZSRVFfSFdfU1RBVEUsDQogCVJFR19F
TV9QT1dFUl9UQkwsDQogDQogCVJFR19BUlJBWV9TSVpFLA0KQEAgLTM3LDYgKzQ0LDcgQEAgc3Ry
dWN0IGNwdWZyZXFfbXRrIHsNCiAJW1JFR19GUkVRX0xVVF9UQUJMRV0JPSAweDAsDQogCVtSRUdf
RlJFUV9FTkFCTEVdCT0gMHg4NCwNCiAJW1JFR19GUkVRX1BFUkZfU1RBVEVdCT0gMHg4OCwNCisJ
W1JFR19GUkVRX0hXX1NUQVRFXQk9IDB4OGMsDQogCVtSRUdfRU1fUE9XRVJfVEJMXQk9IDB4M0Qw
LA0KIH07DQogDQpAQCAtODksNiArOTcsMTIgQEAgc3RhdGljIGludCBtdGtfY3B1ZnJlcV9od19j
cHVfaW5pdChzdHJ1Y3QgY3B1ZnJlcV9wb2xpY3kgKnBvbGljeSkNCiAJc3RydWN0IGNwdWZyZXFf
bXRrICpjOw0KIAlzdHJ1Y3QgZGV2aWNlICpjcHVfZGV2Ow0KIAlzdHJ1Y3QgZW1fZGF0YV9jYWxs
YmFjayBlbV9jYiA9IEVNX0RBVEFfQ0IobXRrX2NwdWZyZXFfZ2V0X2NwdV9wb3dlcik7DQorCXN0
cnVjdCBwbV9xb3NfcmVxdWVzdCAqcW9zX3JlcXVlc3Q7DQorCWludCBzaWcsIHB3cl9odyA9IENQ
VUZSRVFfSFdfU1RBVFVTIHwgU1ZTX0hXX1NUQVRVUzsNCisNCisJcW9zX3JlcXVlc3QgPSBremFs
bG9jKHNpemVvZigqcW9zX3JlcXVlc3QpLCBHRlBfS0VSTkVMKTsNCisJaWYgKCFxb3NfcmVxdWVz
dCkNCisJCXJldHVybiAtRU5PTUVNOw0KIA0KIAljcHVfZGV2ID0gZ2V0X2NwdV9kZXZpY2UocG9s
aWN5LT5jcHUpOw0KIAlpZiAoIWNwdV9kZXYpIHsNCkBAIC0xMDcsMTEgKzEyMSwyOSBAQCBzdGF0
aWMgaW50IG10a19jcHVmcmVxX2h3X2NwdV9pbml0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9s
aWN5KQ0KIAlwb2xpY3ktPmZyZXFfdGFibGUgPSBjLT50YWJsZTsNCiAJcG9saWN5LT5kcml2ZXJf
ZGF0YSA9IGM7DQogDQorCS8qIExldCBDUFVzIGxlYXZlIGlkbGUtb2ZmIHN0YXRlIGZvciBTVlMg
Q1BVIGluaXRpYWxpemluZyAqLw0KKwljcHVfbGF0ZW5jeV9xb3NfYWRkX3JlcXVlc3QocW9zX3Jl
cXVlc3QsIDApOw0KKw0KIAkvKiBIVyBzaG91bGQgYmUgaW4gZW5hYmxlZCBzdGF0ZSB0byBwcm9j
ZWVkIG5vdyAqLw0KIAl3cml0ZWxfcmVsYXhlZCgweDEsIGMtPnJlZ19iYXNlc1tSRUdfRlJFUV9F
TkFCTEVdKTsNCiANCisJaWYgKHJlYWRsX3BvbGxfdGltZW91dChjLT5yZWdfYmFzZXNbUkVHX0ZS
RVFfSFdfU1RBVEVdLCBzaWcsDQorCQkJICAgICAgIChzaWcgJiBwd3JfaHcpID09IHB3cl9odywg
UE9MTF9VU0VDLA0KKwkJCSAgICAgICBUSU1FT1VUX1VTRUMpKSB7DQorCQlpZiAoIShzaWcgJiBD
UFVGUkVRX0hXX1NUQVRVUykpIHsNCisJCQlwcl9pbmZvKCJjcHVmcmVxIGhhcmR3YXJlIG9mIENQ
VSVkIGlzIG5vdCBlbmFibGVkXG4iLA0KKwkJCQlwb2xpY3ktPmNwdSk7DQorCQkJcmV0dXJuIC1F
Tk9ERVY7DQorCQl9DQorDQorCQlwcl9pbmZvKCJTVlMgb2YgQ1BVJWQgaXMgbm90IGVuYWJsZWRc
biIsIHBvbGljeS0+Y3B1KTsNCisJfQ0KKw0KIAllbV9kZXZfcmVnaXN0ZXJfcGVyZl9kb21haW4o
Y3B1X2RldiwgYy0+bnJfb3BwLCAmZW1fY2IsIHBvbGljeS0+Y3B1cyk7DQogDQorCWNwdV9sYXRl
bmN5X3Fvc19yZW1vdmVfcmVxdWVzdChxb3NfcmVxdWVzdCk7DQorCWtmcmVlKHFvc19yZXF1ZXN0
KTsNCisNCiAJcmV0dXJuIDA7DQogfQ0KIA0KLS0gDQoxLjcuOS41DQo=

