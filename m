Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C64FB1B6F43
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 09:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726028AbgDXHqV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 03:46:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:47797 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbgDXHqV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 03:46:21 -0400
X-UUID: 42574fb4d7c640c6b37c4610ca4244c7-20200424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TGTl6pQNQgkA/N1LJ9tQCq0BeEV1GoiphNNPW0tMqhM=;
        b=mBIGmXaGn7DNbs+CdEYFFVdoacHrZrzgN14Zdeq1MggFG2x3DSHhL22LnNtTFoLpd7rWxtqg5xLSJCZLYBVevakXumwRDDl3fwy3yk3ab5fmeX9Ht+fyE78558yfrGFBoNcTYsBHcHrGzmNc5TQNOR59qq/VamhsU+NDSpiYl6Y=;
X-UUID: 42574fb4d7c640c6b37c4610ca4244c7-20200424
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 475130578; Fri, 24 Apr 2020 15:46:18 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Apr 2020 15:46:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Apr 2020 15:46:15 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH] arm64: dts: mt8173: fix cooling device range
Date:   Fri, 24 Apr 2020 15:46:15 +0800
Message-ID: <20200424074615.2835-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

V2hlbiB0aGVybWFsIHJlYWNoZXMgdGFyZ2V0IHRlbXBlcmF0dXJlLGl0IHdvdWxkIGJlIHBpbm5l
ZCB0byBzdGF0ZSAwDQoobWF4IGZyZXF1ZW5jeSBhbmQgcG93ZXIpLg0KRml4IHRoZSB0aHJvdHRs
aW5nIHJhbmdlIHRvIG5vIGxpbWl0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBIc2luLVlpIFdhbmcgPGhz
aW55aUBjaHJvbWl1bS5vcmc+DQpTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEthbyA8bWljaGFlbC5r
YW9AbWVkaWF0ZWsuY29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgx
NzMuZHRzaSB8IDEyICsrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE3My5kdHNpIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMu
ZHRzaQ0KaW5kZXggY2NiOGU4OGE2MGM1Li4xMWIxYmQ1NWJhOWIgMTAwNjQ0DQotLS0gYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL21lZGlhdGVrL210ODE3My5kdHNpDQpAQCAtMjk0LDE0ICsyOTQsMTggQEANCiAJCQlj
b29saW5nLW1hcHMgew0KIAkJCQltYXBAMCB7DQogCQkJCQl0cmlwID0gPCZ0YXJnZXQ+Ow0KLQkJ
CQkJY29vbGluZy1kZXZpY2UgPSA8JmNwdTAgMCAwPiwNCi0JCQkJCQkJIDwmY3B1MSAwIDA+Ow0K
KwkJCQkJY29vbGluZy1kZXZpY2UgPSA8JmNwdTAgVEhFUk1BTF9OT19MSU1JVA0KKwkJCQkJCQkg
IFRIRVJNQUxfTk9fTElNSVQ+LA0KKwkJCQkJCQkgPCZjcHUxIFRIRVJNQUxfTk9fTElNSVQNCisJ
CQkJCQkJICBUSEVSTUFMX05PX0xJTUlUPjsNCiAJCQkJCWNvbnRyaWJ1dGlvbiA9IDwzMDcyPjsN
CiAJCQkJfTsNCiAJCQkJbWFwQDEgew0KIAkJCQkJdHJpcCA9IDwmdGFyZ2V0PjsNCi0JCQkJCWNv
b2xpbmctZGV2aWNlID0gPCZjcHUyIDAgMD4sDQotCQkJCQkJCSA8JmNwdTMgMCAwPjsNCisJCQkJ
CWNvb2xpbmctZGV2aWNlID0gPCZjcHUyIFRIRVJNQUxfTk9fTElNSVQNCisJCQkJCQkJICBUSEVS
TUFMX05PX0xJTUlUPiwNCisJCQkJCQkJIDwmY3B1MyBUSEVSTUFMX05PX0xJTUlUDQorCQkJCQkJ
CSAgVEhFUk1BTF9OT19MSU1JVD47DQogCQkJCQljb250cmlidXRpb24gPSA8MTAyND47DQogCQkJ
CX07DQogCQkJfTsNCi0tIA0KMi4xOC4wDQo=

