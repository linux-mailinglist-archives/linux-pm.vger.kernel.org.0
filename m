Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E02E1098DA
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 06:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727551AbfKZFf0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 00:35:26 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:61355 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727374AbfKZFfC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 00:35:02 -0500
X-UUID: ff52aa425c5b4ae9afce9763c53e93b9-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Y1RF2/cLUQF2MNOynB8uR3SFbEklhbVv5kPFp1T7iWo=;
        b=eO9HCBU1l+JmiIaDsimASO9Oqfu+sN+fpGRyw1ildMRFO9BwouVtSgEP75/KSgLXvQYhXcwBo7o2MeYwCnVTMswB6KtxyhTV9c5YtiJuuTlkocHRBJ/Im/8IaXic2XvWHd7FvcKHg2+EGlr+dnwl+WYvla7Uw8U4lvVrCD2JugU=;
X-UUID: ff52aa425c5b4ae9afce9763c53e93b9-20191126
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1045314236; Tue, 26 Nov 2019 13:34:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 13:34:46 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 26 Nov 2019 13:34:35 +0800
From:   <freddy.hsin@mediatek.com>
To:     <sre@kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wim@linux-watchdog.org>,
        <linux@roeck-us.net>, <matthias.bgg@gmail.com>,
        <linux-watchdog@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <devicetree@vger.kernel.org>
CC:     <Chang-An.Chen@mediatek.com>, <wsd_upstream@mediatek.com>,
        Freddy Hsin <freddy.hsin@mediatek.com>
Subject: [PATCH v1 3/4] soc: mediatek: add reboot-mode header
Date:   Tue, 26 Nov 2019 13:34:49 +0800
Message-ID: <1574746490-625-4-git-send-email-freddy.hsin@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
References: <1574746490-625-1-git-send-email-freddy.hsin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogRnJlZGR5IEhzaW4gPGZyZWRkeS5oc2luQG1lZGlhdGVrLmNvbT4NCg0KTWVkaWF0ZWsg
cGxhdGZvcm0gdXNlIGEgUkdVIChSZXNldCBHZW5lcmF0aW9uIFVuaXQpIG1hcHBlZA0KcmVnaXN0
ZXIgc3RvcmUgdGhlIHJlYm9vdCBtb2RlIG1hZ2ljIHZhbHVlIGZvciBib290bG9hZGVyDQp0byB1
c2Ugd2hlbiBzeXN0ZW0gcmVib290Lg0KDQpBZGQgdGhlIHNoYXJlZCBoZWFkZXIgZGVzY3JpYmlu
ZyB0aGUgdmFsdWVzIGZpcm13YXJlIGV4cGVjdHMNCmZvciBkaWZmZXJlbnQgYm9vdCBtb2Rlcy4N
Cg0KU2lnbmVkLW9mZi1ieTogRnJlZGR5IEhzaW4gPGZyZWRkeS5oc2luQG1lZGlhdGVrLmNvbT4N
Ci0tLQ0KIGluY2x1ZGUvZHQtYmluZGluZ3Mvc29jL21lZGlhdGVrLGJvb3QtbW9kZS5oIHwgICAx
NyArKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspDQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvZHQtYmluZGluZ3Mvc29jL21lZGlhdGVrLGJvb3Qt
bW9kZS5oDQoNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2R0LWJpbmRpbmdzL3NvYy9tZWRpYXRlayxi
b290LW1vZGUuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3Mvc29jL21lZGlhdGVrLGJvb3QtbW9kZS5o
DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uZjdkNTEwNw0KLS0tIC9kZXYv
bnVsbA0KKysrIGIvaW5jbHVkZS9kdC1iaW5kaW5ncy9zb2MvbWVkaWF0ZWssYm9vdC1tb2RlLmgN
CkBAIC0wLDAgKzEsMTcgQEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAq
Lw0KKy8qDQorICogQ29weXJpZ2h0IChjKSAyMDE5IE1lZGlhVGVrIEluYy4NCisgKi8NCisjaWZu
ZGVmIF9fTUVESUFURUtfQk9PVF9NT0RFX0gNCisjZGVmaW5lIF9fTUVESUFURUtfQk9PVF9NT0RF
X0gNCisNCisjZGVmaW5lIEJPT1RfQ0hBUkdFUgkxDQorI2RlZmluZSBCT09UX1JFQ09WRVJZCTIN
CisjZGVmaW5lIEJPT1RfQk9PVExPQURFUgkzDQorI2RlZmluZSBCT09UX0RNX1ZFUklUWQk0DQor
I2RlZmluZSBCT09UX0tQT0MJNQ0KKyNkZWZpbmUgQk9PVF9ERFJfUlNWRAk2DQorI2RlZmluZSBC
T09UX01FVEEJNw0KKyNkZWZpbmUgQk9PVF9SUE1CUEsJOA0KKw0KKyNlbmRpZg0KLS0gDQoxLjcu
OS41DQo=

