Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7129F1843C9
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgCMJei (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:38 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:61434 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726462AbgCMJeh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:37 -0400
X-UUID: aa9c2e754ea8454584ffbf7aa35c2b2c-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=5tHczy6s3OqUwbgulk/Z0FiNwFaqmkAT18Ao+FWBe6k=;
        b=JFykK5/y2Ez3a4vw5AuhIcNZBSK466c4CkWDbF5fjNIQiF17K1cn3RBloHOWVsQB9OmlQtHwx9V4AVSdln26mHkSmpZKHa1aOIykxgF9MNiQ7T4CMCM06X2yoZvvq09e7Mp8sfTgh8gVZucXevGHBNglkXbURJhlOWVGL2NLWME=;
X-UUID: aa9c2e754ea8454584ffbf7aa35c2b2c-20200313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 76565111; Fri, 13 Mar 2020 17:34:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:31:40 +0800
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
Subject: [PATCH V4 07/13] arm64: dts: mt8183: add dvfsrc related nodes
Date:   Fri, 13 Mar 2020 17:34:20 +0800
Message-ID: <1584092066-24425-8-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: A0791F700786907366ACDAA2D3C47FD9579E2C97AFB46EE0B30FD38C6122C57D2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RW5hYmxlIGR2ZnNyYyBvbiBtdDgxODMgcGxhdGZvcm0uDQoNClNpZ25lZC1vZmYtYnk6IEhlbnJ5
IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA3ICsrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNyBp
bnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE4My5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0K
aW5kZXggN2JmMjBjYS4uYzBkMDhjOCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
bWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTgzLmR0c2kNCkBAIC0xNTksNiArMTU5LDEzIEBADQogCQljbG9jay1vdXRwdXQtbmFtZXMg
PSAiY2xrMjZtIjsNCiAJfTsNCiANCisJZHZmc3JjQDEwMDEyMDAwIHsNCisJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLWR2ZnNyYyI7DQorCQlyZWcgPSA8MCAweDEwMDEyMDAwIDAgMHgx
MDAwPjsNCisJCWNsb2NrcyA9IDwmaW5mcmFjZmcgQ0xLX0lORlJBX0RWRlNSQz47DQorCQljbG9j
ay1uYW1lcyA9ICJkdmZzcmMiOw0KKwl9Ow0KKw0KIAl0aW1lciB7DQogCQljb21wYXRpYmxlID0g
ImFybSxhcm12OC10aW1lciI7DQogCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZnaWM+Ow0KLS0gDQox
LjkuMQ0K

