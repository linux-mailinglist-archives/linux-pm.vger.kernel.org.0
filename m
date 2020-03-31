Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5983198AE5
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 06:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCaEHw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 00:07:52 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:51617 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbgCaEHv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 00:07:51 -0400
X-UUID: 431f3b00fa2444e887b8bc81a5a01dbd-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6cH/NQKcPKqnVf6a6IZggs62m/KD6ANc8osyacauays=;
        b=MLrdhomltPL1bVKFbGkqFF3CNzF9snFr56BNXlWwatKHSyEHJ1RtGoleqx3wrWhXu7IS9O3iAEJeW958rUrPPwjWBhDMHujxm/vXK5GWBKZfBdxg/mSeLDUQBQVNj1+6BKCa4jTxAOJu9FLnLP9G9F8qM+qtZksZLgeCYzzoy9o=;
X-UUID: 431f3b00fa2444e887b8bc81a5a01dbd-20200331
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 685286035; Tue, 31 Mar 2020 12:07:47 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 31 Mar 2020 12:07:34 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 31 Mar 2020 12:07:39 +0800
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
Subject: [PATCH v11 0/5] Add Support for MediaTek PMIC MT6358
Date:   Tue, 31 Mar 2020 12:07:32 +0800
Message-ID: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 9478A9E60E7CEAB7CD3D185E20460CD264C9B82EE337357E728FF91007D8EDDE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRpbmcgbW9kaWZ5aW5nIHN1c3BlbmQvcmVzdW1lIGJlaGF2aW9y
IGFkZCBzdXBwb3J0IHRvIE1UNjM1OCBQTUlDLg0KTVQ2MzU4IGlzIHRoZSBwcmltYXJ5IFBNSUMg
Zm9yIE1UODE4MyBwbGF0Zm9ybS4NCg0KY2hhbmdlcyBzaW5jZSB2MTA6DQotIGdldCBtYXRjaCBk
YXRhIHdpdGhvdXQgY2FzdCBpbiB0aGUgcnRjIGRyaXZlci4NCi0gbW92ZSBNT0RVTEVfREVWSUNF
X1RBQkxFIHRvIHRoZSBib3R0b20gb2YgdGhlIGZpbGUgaW4gdGhlIHJ0YyBkcml2ZXIuDQoNCkhz
aW4tSHNpdW5nIFdhbmcgKDQpOg0KICBtZmQ6IG10NjM5NzogbW9kaWZ5IHN1c3BlbmQvcmVzdW1l
IGJlaGF2aW9yDQogIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBjb21wYXRpYmxlIGZvciB0aGUgTWVk
aWFUZWsgTVQ2MzU4IFBNSUMNCiAgbWZkOiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVrIE1U
NjM1OCBQTUlDDQogIGFybTY0OiBkdHM6IG10NjM1ODogYWRkIFBNSUMgTVQ2MzU4IHJlbGF0ZWQg
bm9kZXMNCg0KUmFuIEJpICgxKToNCiAgcnRjOiBtdDYzOTc6IEFkZCBzdXBwb3J0IGZvciB0aGUg
TWVkaWFUZWsgTVQ2MzU4IFJUQw0KDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9tdDYzOTcudHh0IHwgIDE0ICstDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDYzNTguZHRzaSAgICAgICAgIHwgMzU4ICsrKysrKysrKysrKysrKysrKysrKysrDQogYXJjaC9h
cm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMtZXZiLmR0cyAgICAgIHwgICAxICsNCiBkcml2
ZXJzL21mZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCiBk
cml2ZXJzL21mZC9tdDYzNTgtaXJxLmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAyMzYgKysr
KysrKysrKysrKysrDQogZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYyAgICAgICAgICAgICAgICAg
ICAgICAgIHwgIDg1ICsrKy0tLQ0KIGRyaXZlcnMvbWZkL210NjM5Ny1pcnEuYyAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAzMyArKysNCiBkcml2ZXJzL3Bvd2VyL3Jlc2V0L210NjMyMy1wb3dl
cm9mZi5jICAgICAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMjMgKy0NCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzNTgv
Y29yZS5oICAgICAgICAgICAgICAgICAgfCAxNTggKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgv
bWZkL210NjM1OC9yZWdpc3RlcnMuaCAgICAgICAgICAgICB8IDI4MiArKysrKysrKysrKysrKysr
KysNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvY29yZS5oICAgICAgICAgICAgICAgICAgfCAg
IDUgKw0KIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaCAgICAgICAgICAgICAgICAgICB8
ICAgOSArLQ0KIDEzIGZpbGVzIGNoYW5nZWQsIDExNjMgaW5zZXJ0aW9ucygrKSwgNDUgZGVsZXRp
b25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ2MzU4LmR0c2kNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tZmQvbXQ2MzU4LWlycS5j
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgvbWZkL210NjM1OC9jb3JlLmgNCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L3JlZ2lzdGVycy5oDQoN
Ci0tIA0KMi42LjQNCg==

