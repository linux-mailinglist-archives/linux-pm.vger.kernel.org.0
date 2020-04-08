Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53AC91A1D32
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgDHINB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 04:13:01 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:46511 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726525AbgDHINB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 04:13:01 -0400
X-UUID: 53ee3fd8b8cf4e5594616ccf0ae4b40b-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ReQScgLFJ9/68fAYgC7XYU0D88RS9Ej3AolLMr7k38s=;
        b=R+9pES03dreXenkf2EvtHb+0JMmK/wRdQ+RFzG+pRO+PU8DU96knKnXBHTPLamVrSTruGb86aiKo/V6DEtAO0SjglFw4NdODeqYkwkh4iw7SlOqGzyoBcEGo+t0qYc2qM+6pBKZ+hlNjI+clsOYSGF+rPE3paPPnqDdVjhsZQ5M=;
X-UUID: 53ee3fd8b8cf4e5594616ccf0ae4b40b-20200408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2085188719; Wed, 08 Apr 2020 16:12:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Apr 2020 16:12:49 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 8 Apr 2020 16:12:49 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Nicolas Boichat <drinkcat@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Richard Fontana <rfontana@redhat.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Josef Friedl <josef.friedl@speed.at>,
        Thomas Gleixner <tglx@linutronix.de>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v12 0/6] Add Support for MediaTek PMIC MT6358
Date:   Wed, 8 Apr 2020 16:12:05 +0800
Message-ID: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1D8F51BD4EA362DB9AFC00BF572DE7769CFAA3A7B3B2B4FA91B9CCF20772BA492000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRpbmcgbW9kaWZ5aW5nIHN1c3BlbmQvcmVzdW1lIGJlaGF2aW9y
IGFuZCB0cmltbWluZyBwcm9iZSBmdW5jdGlvbiBhZGQgc3VwcG9ydCB0byBNVDYzNTggUE1JQy4N
Ck1UNjM1OCBpcyB0aGUgcHJpbWFyeSBQTUlDIGZvciBNVDgxODMgcGxhdGZvcm0uDQoNCmNoYW5n
ZXMgc2luY2UgdjExOg0KLSBhZGQgYSBuZXcgcGF0Y2ggdG8gdHJpbSBwcm9iZSBmdW5jdGlvbiBt
b3JlIGNsZWFubHkuDQotIGZpeCBzb21lIGNvdmVyaXR5IGRlZmVjdHMuDQotIHVwZGF0ZSBzb21l
IGNvbW1lbnQgbWVzc2FnZXMuDQotIGZpeCB3cm9uZyBzaXplb2YgYXJndW1lbnQuDQoNCkhzaW4t
SHNpdW5nIFdhbmcgKDUpOg0KICBtZmQ6IG10NjM5NzogTW9kaWZ5IHN1c3BlbmQvcmVzdW1lIGJl
aGF2aW9yDQogIG1mZDogbXQ2Mzk3OiBUcmltIHByb2JlIGZ1bmN0aW9uIHRvIHN1cHBvcnQgZGlm
ZmVyZW50IGNoaXBzIG1vcmUNCiAgICBjbGVhbmx5DQogIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBj
b21wYXRpYmxlIGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFBNSUMNCiAgbWZkOiBBZGQgc3VwcG9y
dCBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OCBQTUlDDQogIGFybTY0OiBkdHM6IG10NjM1ODogYWRk
IFBNSUMgTVQ2MzU4IHJlbGF0ZWQgbm9kZXMNCg0KUmFuIEJpICgxKToNCiAgcnRjOiBtdDYzOTc6
IEFkZCBzdXBwb3J0IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQw0KDQogRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0IHwgIDE0ICstDQogYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTguZHRzaSAgICAgICAgIHwgMzU4ICsrKysrKysrKysr
KysrKysrKysrKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMtZXZiLmR0
cyAgICAgIHwgICAxICsNCiBkcml2ZXJzL21mZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL21mZC9tdDYzNTgtaXJxLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyMzUgKysrKysrKysrKysrKysrDQogZHJpdmVycy9tZmQvbXQ2Mzk3LWNv
cmUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgMTAxICsrKystLS0NCiBkcml2ZXJzL21mZC9t
dDYzOTctaXJxLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzUgKystDQogZHJpdmVycy9w
b3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYyAgICAgICAgICAgIHwgICAyICstDQogZHJpdmVy
cy9ydGMvcnRjLW10NjM5Ny5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE4ICstDQogaW5j
bHVkZS9saW51eC9tZmQvbXQ2MzU4L2NvcmUuaCAgICAgICAgICAgICAgICAgIHwgMTU4ICsrKysr
KysrKysNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTgvcmVnaXN0ZXJzLmggICAgICAgICAgICAg
fCAyODIgKysrKysrKysrKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L2NvcmUu
aCAgICAgICAgICAgICAgICAgIHwgICA1ICsNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvcnRj
LmggICAgICAgICAgICAgICAgICAgfCAgIDkgKy0NCiAxMyBmaWxlcyBjaGFuZ2VkLCAxMTU4IGlu
c2VydGlvbnMoKyksIDYyIGRlbGV0aW9ucygtKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2Fy
bTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NjM1OC5kdHNpDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvbWZkL210NjM1OC1pcnEuYw0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2xpbnV4
L21mZC9tdDYzNTgvY29yZS5oDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWZk
L210NjM1OC9yZWdpc3RlcnMuaA0KDQotLSANCjIuNi40DQo=

