Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409462856B7
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 04:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgJGCnq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Oct 2020 22:43:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:42591 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbgJGCnq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2020 22:43:46 -0400
X-UUID: 20384dc07366430b91a2c9fb45b9941f-20201007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=AFPXpclqC/BVWvt1LdPXCMRHLa9WQf2iX9kXqT1ZSNs=;
        b=eBGwrty71ludhboOCgew7oyCJIcOzGTzYnUfNaGFRPQizsUc/ctOd/odc8h74bUnePBQ/p0Zp0eliuk8qjLRDYd1fPMyit7CW/xo2vXpvBATRj8jWnIpaPfQHN8qAjQey5e9DYJbYJ2/Fj/DUMQQi9Hm+SlyVJOsnBSgvazabnQ=;
X-UUID: 20384dc07366430b91a2c9fb45b9941f-20201007
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 841286483; Wed, 07 Oct 2020 10:43:38 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Oct 2020 10:43:35 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Oct 2020 10:43:32 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH] [v2] thermal: core: add upper and lower limits to power_actor_set_power
Date:   Wed, 7 Oct 2020 10:43:32 +0800
Message-ID: <20201007024332.30322-1-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIHVwcGVyIGFuZCBsb3dlciBsaW1pdHMgb2YgdGhlcm1hbCB0aHJvdHRsZSBzdGF0ZSBpbiB0
aGUNCkRUIGRvIG5vdCBhcHBseSB0byB0aGUgSW50ZWxsaWdlbnQgUG93ZXIgQWxsb2NhdGlvbiAo
SVBBKSBnb3Zlcm5vci4NCkFkZCB0aGUgY2xhbXBpbmcgZm9yIGNvb2xpbmcgZGV2aWNlIHVwcGVy
IGFuZCBsb3dlciBsaW1pdHMgaW4gdGhlDQpwb3dlcl9hY3Rvcl9zZXRfcG93ZXIoKSB1c2VkIGJ5
IElQQS4NCg0KU2lnbmVkLW9mZi1ieTogTWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVr
LmNvbT4NCi0tLQ0KIGRyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyB8IDIgKy0NCiAxIGZp
bGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdGhlcm1hbC90aGVybWFsX2NvcmUuYyBiL2RyaXZlcnMvdGhlcm1hbC90aGVybWFs
X2NvcmUuYw0KaW5kZXggNzJiZjE1OWJjZWNjLi5hMjYwZTRhNTc1ZjMgMTAwNjQ0DQotLS0gYS9k
cml2ZXJzL3RoZXJtYWwvdGhlcm1hbF9jb3JlLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC90aGVy
bWFsX2NvcmUuYw0KQEAgLTY3NCw3ICs2NzQsNyBAQCBpbnQgcG93ZXJfYWN0b3Jfc2V0X3Bvd2Vy
KHN0cnVjdCB0aGVybWFsX2Nvb2xpbmdfZGV2aWNlICpjZGV2LA0KIAlpZiAocmV0KQ0KIAkJcmV0
dXJuIHJldDsNCiANCi0JaW5zdGFuY2UtPnRhcmdldCA9IHN0YXRlOw0KKwlpbnN0YW5jZS0+dGFy
Z2V0ID0gY2xhbXBfdmFsKHN0YXRlLCBpbnN0YW5jZS0+bG93ZXIsIGluc3RhbmNlLT51cHBlcik7
DQogCW11dGV4X2xvY2soJmNkZXYtPmxvY2spOw0KIAljZGV2LT51cGRhdGVkID0gZmFsc2U7DQog
CW11dGV4X3VubG9jaygmY2Rldi0+bG9jayk7DQotLSANCjIuMTguMA0K

