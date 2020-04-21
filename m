Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F491B1C43
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 05:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbgDUDA0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 23:00:26 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727889AbgDUDAZ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 23:00:25 -0400
X-UUID: 74d6c1ec07f543caacbecb519939d4c8-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZLGMpeA19u1Wima9wc0S7lbHcEYXik+4JHiV+qyzH4U=;
        b=lhc693EKaBy0XHE9FarKqckLUwKiTZ2x5Qsw2rU4P/Ok+SP7Uvz5OzupMeTAxya+csS6N9NU/LKGsnqONlAnJJyM8UsRWvdBibiUymqZuGSsUsMRaRkpEkDvFMI2ji/VfoLmPZJMjhfsp4a86IVQOUCGVE3ljA3Z8GnuVSJJlyg=;
X-UUID: 74d6c1ec07f543caacbecb519939d4c8-20200421
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 610182586; Tue, 21 Apr 2020 11:00:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 11:00:13 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 11:00:12 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <drinkcat@chromium.org>, Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v13 0/6] Add Support for MediaTek PMIC MT6358
Date:   Tue, 21 Apr 2020 11:00:06 +0800
Message-ID: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F7DE3C45707E7BC4C1C7A2764009051DD0C524407E750491ADB5A3F3C0033AAC2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaHNldCBpbmNsdWRpbmcgbW9kaWZ5aW5nIHN1c3BlbmQvcmVzdW1lIGJlaGF2aW9y
IGFuZCB0cmltbWluZyBwcm9iZSBmdW5jdGlvbiBhZGQgc3VwcG9ydCB0byBNVDYzNTggUE1JQy4N
Ck1UNjM1OCBpcyB0aGUgcHJpbWFyeSBQTUlDIGZvciBNVDgxODMgcGxhdGZvcm0uDQoNCmNoYW5n
ZXMgc2luY2UgdjEyOg0KLSB1cGRhdGUgZmlsZSBkYXRlLg0KLSBtb2RpZnkgcGF0Y2ggc2lnbi1v
ZmZzIGJsb2NrIGFjY29yZGluZyB0byBjaHJvbm9sb2dpY2FsIG9yZGVyLg0KLSBtb2RpZnkgcmVn
aXN0ZXIgZGVmaW5pdGlvbiBpbiBoZWFkZXIgZmlsZS4NCi0gcmViYXNlIHNlcmllcyBvbiA1Ljct
cmMxLg0KDQpIc2luLUhzaXVuZyBXYW5nICg1KToNCiAgbWZkOiBtdDYzOTc6IE1vZGlmeSBzdXNw
ZW5kL3Jlc3VtZSBiZWhhdmlvcg0KICBtZmQ6IG10NjM5NzogVHJpbSBwcm9iZSBmdW5jdGlvbiB0
byBzdXBwb3J0IGRpZmZlcmVudCBjaGlwcyBtb3JlDQogICAgY2xlYW5seQ0KICBkdC1iaW5kaW5n
czogbWZkOiBBZGQgY29tcGF0aWJsZSBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OCBQTUlDDQogIG1m
ZDogQWRkIHN1cHBvcnQgZm9yIHRoZSBNZWRpYVRlayBNVDYzNTggUE1JQw0KICBhcm02NDogZHRz
OiBtdDYzNTg6IGFkZCBQTUlDIE1UNjM1OCByZWxhdGVkIG5vZGVzDQoNClJhbiBCaSAoMSk6DQog
IHJ0YzogbXQ2Mzk3OiBBZGQgc3VwcG9ydCBmb3IgdGhlIE1lZGlhVGVrIE1UNjM1OCBSVEMNCg0K
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvbXQ2Mzk3LnR4dCB8ICAxNCAr
LQ0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ2MzU4LmR0c2kgICAgICAgICB8IDM1
OCArKysrKysrKysrKysrKysrKysrKysrKw0KIGFyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTgzLWV2Yi5kdHMgICAgICB8ICAgMSArDQogZHJpdmVycy9tZmQvTWFrZWZpbGUgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQogZHJpdmVycy9tZmQvbXQ2MzU4LWlycS5j
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgMjM1ICsrKysrKysrKysrKysrKw0KIGRyaXZlcnMv
bWZkL210NjM5Ny1jb3JlLmMgICAgICAgICAgICAgICAgICAgICAgICB8IDEwMSArKysrLS0tDQog
ZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDM1ICsr
LQ0KIGRyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMgICAgICAgICAgICB8ICAg
MiArLQ0KIGRyaXZlcnMvcnRjL3J0Yy1tdDYzOTcuYyAgICAgICAgICAgICAgICAgICAgICAgICB8
ICAxOCArLQ0KIGluY2x1ZGUvbGludXgvbWZkL210NjM1OC9jb3JlLmggICAgICAgICAgICAgICAg
ICB8IDE1OCArKysrKysrKysrDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L3JlZ2lzdGVycy5o
ICAgICAgICAgICAgIHwgMjgyICsrKysrKysrKysrKysrKysrKw0KIGluY2x1ZGUvbGludXgvbWZk
L210NjM5Ny9jb3JlLmggICAgICAgICAgICAgICAgICB8ICAgNSArDQogaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L3J0Yy5oICAgICAgICAgICAgICAgICAgIHwgICA5ICstDQogMTMgZmlsZXMgY2hh
bmdlZCwgMTE1OCBpbnNlcnRpb25zKCspLCA2MiBkZWxldGlvbnMoLSkNCiBjcmVhdGUgbW9kZSAx
MDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDYzNTguZHRzaQ0KIGNyZWF0ZSBt
b2RlIDEwMDY0NCBkcml2ZXJzL21mZC9tdDYzNTgtaXJxLmMNCiBjcmVhdGUgbW9kZSAxMDA2NDQg
aW5jbHVkZS9saW51eC9tZmQvbXQ2MzU4L2NvcmUuaA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNs
dWRlL2xpbnV4L21mZC9tdDYzNTgvcmVnaXN0ZXJzLmgNCg0KLS0gDQoyLjYuNA0K

