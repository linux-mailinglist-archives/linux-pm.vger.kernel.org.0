Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06AD61843CD
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCMJeh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:37 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9371 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbgCMJeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:37 -0400
X-UUID: 22818a712c6244da9d2a55bb431c26a3-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WTsszqZt97hYyVRz3sqpNSZe5TNKlzAwiyT5E3FLPW0=;
        b=ttjmggbwDqjk94k5f4Ek9B2Ff/dkUeeuJWG0AM/r1FPDAQ7Du8qfhJ4C1Lf/ApZq4+AhLR7tO4tMcrHUFmLKUDv8krRMBswAgEUwETe1VP36R0neyjU+tFADXGiIgbjKqooluTZ+5uOyKKXZ9kc2ik4dmMUneoyOe31nnUrehPo=;
X-UUID: 22818a712c6244da9d2a55bb431c26a3-20200313
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 467851482; Fri, 13 Mar 2020 17:34:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:33:33 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:41 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V4 04/13] arm64: dts: mt8183: add performance state support of scpsys
Date:   Fri, 13 Mar 2020 17:34:17 +0800
Message-ID: <1584092066-24425-5-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIHN1cHBvcnQgZm9yIHBlcmZvcm1hbmNlIHN0YXRlIG9mIHNjcHN5cyBvbiBtdDgxODMgcGxh
dGZvcm0NCg0KU2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDIx
ICsrKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAyMSBpbnNlcnRpb25zKCsp
DQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNp
IGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggNDMzYzYy
ZS4uN2JmMjBjYSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kN
CkBAIC0xMSw2ICsxMSw3IEBADQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1w
b3dlci5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9yZXNldC1jb250cm9sbGVyL210ODE4My1y
ZXNldHMuaD4NCiAjaW5jbHVkZSAibXQ4MTgzLXBpbmZ1bmMuaCINCisjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3Mvc29jL210ayxkdmZzcmMuaD4NCiANCiAvIHsNCiAJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMiOw0KQEAgLTMxMCw2ICszMTEsMjYgQEANCiAJCQkJICAgICAgInZwdS0zIiwgInZw
dS00IiwgInZwdS01IjsNCiAJCQlpbmZyYWNmZyA9IDwmaW5mcmFjZmc+Ow0KIAkJCXNtaV9jb21t
ID0gPCZzbWlfY29tbW9uPjsNCisJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZkdmZzcmNfb3Bw
X3RhYmxlPjsNCisJCQlkdmZzcmNfb3BwX3RhYmxlOiBvcHAtdGFibGUgew0KKwkJCQljb21wYXRp
YmxlID0gIm9wZXJhdGluZy1wb2ludHMtdjItbGV2ZWwiOw0KKw0KKwkJCQlkdmZzcmNfdm9sX21p
bjogb3BwMSB7DQorCQkJCQlvcHAsbGV2ZWwgPSA8TVQ4MTgzX0RWRlNSQ19MRVZFTF8xPjsNCisJ
CQkJfTsNCisNCisJCQkJZHZmc3JjX2ZyZXFfbWVkaXVtOiBvcHAyIHsNCisJCQkJCW9wcCxsZXZl
bCA9IDxNVDgxODNfRFZGU1JDX0xFVkVMXzI+Ow0KKwkJCQl9Ow0KKw0KKwkJCQlkdmZzcmNfZnJl
cV9tYXg6IG9wcDMgew0KKwkJCQkJb3BwLGxldmVsID0gPE1UODE4M19EVkZTUkNfTEVWRUxfMz47
DQorCQkJCX07DQorDQorCQkJCWR2ZnNyY192b2xfbWF4OiBvcHA0IHsNCisJCQkJCW9wcCxsZXZl
bCA9IDxNVDgxODNfRFZGU1JDX0xFVkVMXzQ+Ow0KKwkJCQl9Ow0KKwkJCX07DQogCQl9Ow0KIA0K
IAkJYXBtaXhlZHN5czogc3lzY29uQDEwMDBjMDAwIHsNCi0tIA0KMS45LjENCg==

