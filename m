Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AFB6E17F47A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJKKv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:10:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42711 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726202AbgCJKKu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:10:50 -0400
X-UUID: 2b8b9708abb74516897a1aabe91401f2-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=inUXDgqoY53ORAeqwgaUzS7AlZMxW4h9radzKBlKZis=;
        b=AB4JyubLn6JVM/6AMaDJMgQW8npj0P5I832Zu5FtwVVbPr2y2EBr5bTHvxsmtPYwfKZsaA3UqYmjiTI0dlrF7OUD5oi4MGLXstMfb0hBF2Nkf24z32JHt6PgXk6Ndhojojp3SWnntRbz1EyfQypVw728M75Mc5ih1rKg2LensTc=;
X-UUID: 2b8b9708abb74516897a1aabe91401f2-20200310
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 739794820; Tue, 10 Mar 2020 18:10:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 18:09:39 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 18:07:58 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Fontana <rfontana@redhat.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        <srv_heupstream@mediatek.com>
Subject: [PATCH v9 0/5] Add Support for MediaTek PMIC MT6358
Date:   Tue, 10 Mar 2020 18:10:35 +0800
Message-ID: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRpbmcgbW9kaWZ5aW5nIHN1c3BlbmQvcmVzdW1lIGJlaGF2aW9y
IGFkZCBzdXBwb3J0IHRvIE1UNjM1OCBQTUlDLg0KTVQ2MzU4IGlzIHRoZSBwcmltYXJ5IFBNSUMg
Zm9yIE1UODE4MyBwbGF0Zm9ybS4NCg0KY2hhbmdlcyBzaW5jZSB2ODoNCi0gdXNlIHRoZSBlZmZp
Y2llbnQgY29tcHV0aW5nIGZ1bmN0aW9uIGluIG1mZCBkcml2ZXIuDQotIHJlbW92ZSB0aGUgdW51
c2VkIHJlZ3VsYXRvciBwcm9wZXJ0eSBpbiBkdHMuDQotIGZpeCBXUlRHUiByZWdpc3RlciBvZmZz
ZXQgaW4gbXQ2MzIzLXBvd2Vyb2ZmIGRyaXZlci4NCg0KSHNpbi1Ic2l1bmcgV2FuZyAoNCk6DQog
IG1mZDogbXQ2Mzk3OiBtb2RpZnkgc3VzcGVuZC9yZXN1bWUgYmVoYXZpb3INCiAgZHQtYmluZGlu
Z3M6IG1mZDogQWRkIGNvbXBhdGlibGUgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUE1JQw0KICBt
ZmQ6IEFkZCBzdXBwb3J0IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFBNSUMNCiAgYXJtNjQ6IGR0
czogbXQ2MzU4OiBhZGQgUE1JQyBNVDYzNTggcmVsYXRlZCBub2Rlcw0KDQpSYW4gQmkgKDEpOg0K
ICBydGM6IG10NjM5NzogQWRkIHN1cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUlRDDQoN
CiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWZkL210NjM5Ny50eHQgfCAgMTQg
Ky0NCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OC5kdHNpICAgICAgICAgfCAz
NTggKysrKysrKysrKysrKysrKysrKysrKysNCiBhcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVr
L210ODE4My1ldmIuZHRzICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvbWZkL01ha2VmaWxlICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KIGRyaXZlcnMvbWZkL210NjM1OC1pcnEu
YyAgICAgICAgICAgICAgICAgICAgICAgICB8IDIzOCArKysrKysrKysrKysrKysNCiBkcml2ZXJz
L21mZC9tdDYzOTctY29yZS5jICAgICAgICAgICAgICAgICAgICAgICAgfCAgODUgKysrLS0tDQog
ZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMzICsr
Kw0KIGRyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMgICAgICAgICAgICB8ICAg
MiArLQ0KIGRyaXZlcnMvcnRjL3J0Yy1tdDYzOTcuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAyNCArLQ0KIGluY2x1ZGUvbGludXgvbWZkL210NjM1OC9jb3JlLmggICAgICAgICAgICAgICAg
ICB8IDE1OCArKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L3JlZ2lzdGVycy5o
ICAgICAgICAgICAgIHwgMjgyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWZk
L210NjM5Ny9jb3JlLmggICAgICAgICAgICAgICAgICB8ICAgNSArDQogaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L3J0Yy5oICAgICAgICAgICAgICAgICAgIHwgIDE3ICstDQogMTMgZmlsZXMgY2hh
bmdlZCwgMTE3MCBpbnNlcnRpb25zKCspLCA0OSBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTguZHRzaQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21mZC9tdDYzNTgtaXJxLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L2NvcmUuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2xpbnV4L21mZC9tdDYzNTgvcmVnaXN0ZXJzLmgNCg0KLS0gDQoyLjYuNA0K

