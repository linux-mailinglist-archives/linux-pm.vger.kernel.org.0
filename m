Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6128F181473
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 10:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgCKJRQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 05:17:16 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58454 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728606AbgCKJRQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 05:17:16 -0400
X-UUID: e5f77489817f46938285fbb914e26390-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=w/OFvaAVqelVRqsmT335UVcjfyRxqRhg1qlxZpxXnpY=;
        b=M56im9O3gMpK9T2JmCngoiZYscMXlR4BpT6C5tbfeOd32LrLxKi7PInM16+ItyscRh0xCoyMs+p0m3GQbvbL5z4uPiNR+XEWIkVMt6JkeoBlUfWXUJjh/6dVispN67R5AXBlEYcZTHvmoccDAdSD/zWnS2YHhuKC0TVZiEBvO24=;
X-UUID: e5f77489817f46938285fbb914e26390-20200311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 4283539; Wed, 11 Mar 2020 17:17:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 17:15:37 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 17:17:12 +0800
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
Subject: [PATCH v10 0/5] Add Support for MediaTek PMIC MT6358
Date:   Wed, 11 Mar 2020 17:16:58 +0800
Message-ID: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
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
Zm9yIE1UODE4MyBwbGF0Zm9ybS4NCg0KY2hhbmdlcyBzaW5jZSB2OToNCi0gcmVtb3ZlIHJlZHVu
ZGFudCBsb29wIGluIG1mZCBkcml2ZXIuDQotIG1vdmUgbXRrX3J0Y19kYXRhIGZyb20gcnRjLmgg
dG8gcnRjLW10NjM5Ny5jDQoNCkhzaW4tSHNpdW5nIFdhbmcgKDQpOg0KICBtZmQ6IG10NjM5Nzog
bW9kaWZ5IHN1c3BlbmQvcmVzdW1lIGJlaGF2aW9yDQogIGR0LWJpbmRpbmdzOiBtZmQ6IEFkZCBj
b21wYXRpYmxlIGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFBNSUMNCiAgbWZkOiBBZGQgc3VwcG9y
dCBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OCBQTUlDDQogIGFybTY0OiBkdHM6IG10NjM1ODogYWRk
IFBNSUMgTVQ2MzU4IHJlbGF0ZWQgbm9kZXMNCg0KUmFuIEJpICgxKToNCiAgcnRjOiBtdDYzOTc6
IEFkZCBzdXBwb3J0IGZvciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQw0KDQogRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9tdDYzOTcudHh0IHwgIDE0ICstDQogYXJjaC9hcm02
NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTguZHRzaSAgICAgICAgIHwgMzU4ICsrKysrKysrKysr
KysrKysrKysrKysrDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMtZXZiLmR0
cyAgICAgIHwgICAxICsNCiBkcml2ZXJzL21mZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJzL21mZC9tdDYzNTgtaXJxLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgfCAyMzYgKysrKysrKysrKysrKysrDQogZHJpdmVycy9tZmQvbXQ2Mzk3LWNv
cmUuYyAgICAgICAgICAgICAgICAgICAgICAgIHwgIDg1ICsrKy0tLQ0KIGRyaXZlcnMvbWZkL210
NjM5Ny1pcnEuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzMyArKysNCiBkcml2ZXJzL3Bv
d2VyL3Jlc2V0L210NjMyMy1wb3dlcm9mZi5jICAgICAgICAgICAgfCAgIDIgKy0NCiBkcml2ZXJz
L3J0Yy9ydGMtbXQ2Mzk3LmMgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMzIgKy0NCiBpbmNs
dWRlL2xpbnV4L21mZC9tdDYzNTgvY29yZS5oICAgICAgICAgICAgICAgICAgfCAxNTggKysrKysr
KysrKw0KIGluY2x1ZGUvbGludXgvbWZkL210NjM1OC9yZWdpc3RlcnMuaCAgICAgICAgICAgICB8
IDI4MiArKysrKysrKysrKysrKysrKysNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvY29yZS5o
ICAgICAgICAgICAgICAgICAgfCAgIDUgKw0KIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMu
aCAgICAgICAgICAgICAgICAgICB8ICAgOSArLQ0KIDEzIGZpbGVzIGNoYW5nZWQsIDExNjggaW5z
ZXJ0aW9ucygrKSwgNDkgZGVsZXRpb25zKC0pDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU4LmR0c2kNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9tZmQvbXQ2MzU4LWlycS5jDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGludXgv
bWZkL210NjM1OC9jb3JlLmgNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9saW51eC9tZmQv
bXQ2MzU4L3JlZ2lzdGVycy5oDQoNCi0tIA0KMi42LjQNCg==

