Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124EC1BF3E7
	for <lists+linux-pm@lfdr.de>; Thu, 30 Apr 2020 11:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgD3JOp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 30 Apr 2020 05:14:45 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:33341 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726358AbgD3JOp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Apr 2020 05:14:45 -0400
X-UUID: f207856ef58a444a9ad3c554b2e7f10f-20200430
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=ZyWHANL6IrB0l51Zfc83GdOFYp8wjYfrW0mYPD40bfY=;
        b=Us9RZsZwQWKSnaORmR1b3FZpJRd8+LQWH9wrFyKxFsRA7fmz1MUBYHoSf9uLkV6BCnKpXnY9EfY38W74DRqeIwxNhFZSPASrkCN6JqQ1jGf3WNKorx9v49TKTuPywk7sBLWFvAr/dYo+23nG8hzOfm8D0Ynh4eMLE/YRwzenQmQ=;
X-UUID: f207856ef58a444a9ad3c554b2e7f10f-20200430
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <henry.yen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1925825601; Thu, 30 Apr 2020 17:14:41 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 30 Apr 2020 17:14:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 30 Apr 2020 17:14:39 +0800
From:   Henry Yen <henry.yen@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pm@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <henry.yen@mediatek.com>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH v2 0/2] Mediatek thermal driver update
Date:   Thu, 30 Apr 2020 17:14:32 +0800
Message-ID: <1588238074-19338-1-git-send-email-henry.yen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 7F58CE61F64B44D235ACC83466F1B3E82A319B4F514B5C42ADCF5FDE31662D0F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

TWVkaWF0ZWsgb3ducyB0d28gdGhlcm1hbCBzeXN0ZW1zLCB3aGljaCBhcmUgYWxtb3N0IHRoZSBz
YW1lIGV4Y2VwdCBmb3INCnRoZSB3YXkgb2YgcmVhZGluZyBjYWxpYnJhdGlvbiBkYXRhIGFuZCBj
b252ZXJ0aW5nIHRlbXBlcmF0dXJlLg0KTVQ4MTczLCBNVDgxODMsIE1UMjcwMSBhbmQgTVQyNzEy
IGJlbG9uZ3MgdG8gdmVyc2lvbiAxIHRoZXJtYWwgc3lzdGVtLA0KYW5kIE1UNzYyMiBiZWxvbmdz
IHRvIHZlcnNpb24gMi4gVGhlIGN1cnJlbnQgY29kZSBoYXMgYWxyZWFkeSBzdXBwb3J0ZWQNCnZl
cnNpb24gMSBzeXN0ZW0uIFRoZW4gdGhpcyBwYXRjaHNldCB3aWxsIGFkZCB0aGUgc3VwcG9ydCBm
b3IgYW5vdGhlcg0KcGxhdGZvcm0gKGUuZy4sIE1UNzYyMiBTb0MpLg0KDQpDaGFuZ2Vsb2c6DQoN
CnYyOg0KKiByZW9yZ2FuaXplIHRoZSBvcmRlciBvZiB0aGUgdHdvIHBhdGNoZXMNCiogcmVtb3Zl
IHVubmVjZXNzYXJ5IC5leHRyYWN0IGFuZCAuY29udmVydCBjYWxsYmFja3MNCiogYWRkIGZpeGVz
IHRhZw0KDQp2MToNCiogaW5pdGlhbCBwb3N0DQoNCkhlbnJ5IFllbiAoMik6DQogIHRoZXJtYWw6
IG1lZGlhdGVrOiBwcmVwYXJlIHRvIGFkZCBzdXBwb3J0IGZvciBvdGhlciBwbGF0Zm9ybXMNCiAg
dGhlcm1hbDogbWVkaWF0ZWs6IGFkZCB0c2Vuc29yIHN1cHBvcnQgZm9yIFYyIHRoZXJtYWwgc3lz
dGVtDQoNCiBkcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYyB8IDIzNCArKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDE4MSBpbnNlcnRpb25zKCsp
LCA1MyBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjE3LjENCg==

