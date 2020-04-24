Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51CE1B6FAD
	for <lists+linux-pm@lfdr.de>; Fri, 24 Apr 2020 10:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgDXIXp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 24 Apr 2020 04:23:45 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:32475 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726028AbgDXIXp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Apr 2020 04:23:45 -0400
X-UUID: aa5e11a295bd4456a9b0e6dd56f50983-20200424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5Le9qoejU+6jSbO30NZ6FQCsnzb28/ib8ihNNO5nR/Q=;
        b=X/Rep5K8QMo98wwa7h4FZ9m9ROq5x7ZKPJXqFs76Mw4ybRk0NHNOaoSQxEBKdP3grJcrLBZwNrEL2I4qkBgFcRBwvpOVmQh1aaDQj5+zysrE52qZxF2KaXzlJHemL0vzGEWtWgvLaIWdzgM3IXpCsXi00WaDLcgwa54tk+sITJE=;
X-UUID: aa5e11a295bd4456a9b0e6dd56f50983-20200424
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1217075942; Fri, 24 Apr 2020 16:23:42 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 24 Apr 2020 16:23:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 24 Apr 2020 16:23:39 +0800
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
Subject: [PATCH] [RESEND] arm64: dts: mt8173: fix cooling device range
Date:   Fri, 24 Apr 2020 16:23:40 +0800
Message-ID: <20200424082340.4127-1-michael.kao@mediatek.com>
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
NzMuZHRzaSB8IDEzICsrKysrKysrKy0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgOSBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9t
ZWRpYXRlay9tdDgxNzMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTcz
LmR0c2kNCmluZGV4IGNjYjhlODhhNjBjNS4uY2FlMmNlYzQ2Y2RjIDEwMDY0NA0KLS0tIGEvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxNzMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9i
b290L2R0cy9tZWRpYXRlay9tdDgxNzMuZHRzaQ0KQEAgLTE5LDYgKzE5LDcgQEANCiAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTczLXBvd2VyLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRp
bmdzL3Jlc2V0L210ODE3My1yZXNldHMuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvZ2NlL210
ODE3My1nY2UuaD4NCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvdGhlcm1hbC90aGVybWFsLmg+DQog
I2luY2x1ZGUgIm10ODE3My1waW5mdW5jLmgiDQogDQogLyB7DQpAQCAtMjk0LDE0ICsyOTUsMTgg
QEANCiAJCQljb29saW5nLW1hcHMgew0KIAkJCQltYXBAMCB7DQogCQkJCQl0cmlwID0gPCZ0YXJn
ZXQ+Ow0KLQkJCQkJY29vbGluZy1kZXZpY2UgPSA8JmNwdTAgMCAwPiwNCi0JCQkJCQkJIDwmY3B1
MSAwIDA+Ow0KKwkJCQkJY29vbGluZy1kZXZpY2UgPSA8JmNwdTAgVEhFUk1BTF9OT19MSU1JVA0K
KwkJCQkJCQkgIFRIRVJNQUxfTk9fTElNSVQ+LA0KKwkJCQkJCQkgPCZjcHUxIFRIRVJNQUxfTk9f
TElNSVQNCisJCQkJCQkJICBUSEVSTUFMX05PX0xJTUlUPjsNCiAJCQkJCWNvbnRyaWJ1dGlvbiA9
IDwzMDcyPjsNCiAJCQkJfTsNCiAJCQkJbWFwQDEgew0KIAkJCQkJdHJpcCA9IDwmdGFyZ2V0PjsN
Ci0JCQkJCWNvb2xpbmctZGV2aWNlID0gPCZjcHUyIDAgMD4sDQotCQkJCQkJCSA8JmNwdTMgMCAw
PjsNCisJCQkJCWNvb2xpbmctZGV2aWNlID0gPCZjcHUyIFRIRVJNQUxfTk9fTElNSVQNCisJCQkJ
CQkJICBUSEVSTUFMX05PX0xJTUlUPiwNCisJCQkJCQkJIDwmY3B1MyBUSEVSTUFMX05PX0xJTUlU
DQorCQkJCQkJCSAgVEhFUk1BTF9OT19MSU1JVD47DQogCQkJCQljb250cmlidXRpb24gPSA8MTAy
ND47DQogCQkJCX07DQogCQkJfTsNCi0tIA0KMi4xOC4wDQo=

