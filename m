Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71E21098D5
	for <lists+linux-pm@lfdr.de>; Tue, 26 Nov 2019 06:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbfKZFfB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 26 Nov 2019 00:35:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36382 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbfKZFfB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 26 Nov 2019 00:35:01 -0500
X-UUID: 6408d35a8ce442359e705cb85c5e23d5-20191126
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=+ylx+liID2k/ZQg5HjGKdpWZLavo0cVeqpmKRzq/c94=;
        b=jtWj3dO27grh1T0HwxocZGqyNoMbvz5HPzjRlHDkFYbL0pKm7qWtd54KwoauhHActfkMFSKnUi7lszYOdpRqP9HyvcXOUcpl4osHmH9kIlG7+YIJpdIPSRs5YdMR3W4rUDbYLrT3YIZnrCXh8G0i3zZ4A8J0I8EWvY3QgvkKRZI=;
X-UUID: 6408d35a8ce442359e705cb85c5e23d5-20191126
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <freddy.hsin@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1110702092; Tue, 26 Nov 2019 13:34:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 26 Nov 2019 13:34:50 +0800
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
Subject: [PATCH v1 2/4] watchdog: populate reboot mode node in toprgu node of MTK RGU (Reset Generation Unit)
Date:   Tue, 26 Nov 2019 13:34:48 +0800
Message-ID: <1574746490-625-3-git-send-email-freddy.hsin@mediatek.com>
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

RnJvbTogRnJlZGR5IEhzaW4gPGZyZWRkeS5oc2luQG1lZGlhdGVrLmNvbT4NCg0Kb2ZfcGxhdGZv
cm1fcG9wdWxhdGlvbiBzaG91bGQgYmUgYWRkZWQgaW4gdGhlIHByb2JlIGZ1bmN0aW9uIG9mDQp0
b3ByZ3UgZHJpdmVyLCBvciB0aGUgcmVib290IG1vZGUgZHJpdmVyIHdpbGwgbm90IGJlIHByb2Jl
ZA0KDQpTaWduZWQtb2ZmLWJ5OiBGcmVkZHkgSHNpbiA8ZnJlZGR5LmhzaW5AbWVkaWF0ZWsuY29t
Pg0KLS0tDQogZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmMgfCAgICAzICsrKw0KIDEgZmlsZSBj
aGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvd2F0Y2hkb2cv
bXRrX3dkdC5jIGIvZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmMNCmluZGV4IDljM2QwMDMuLjJm
YjI2MTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3dhdGNoZG9nL210a193ZHQuYw0KKysrIGIvZHJp
dmVycy93YXRjaGRvZy9tdGtfd2R0LmMNCkBAIC0yMCw2ICsyMCw3IEBADQogI2luY2x1ZGUgPGxp
bnV4L3R5cGVzLmg+DQogI2luY2x1ZGUgPGxpbnV4L3dhdGNoZG9nLmg+DQogI2luY2x1ZGUgPGxp
bnV4L2RlbGF5Lmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX3BsYXRmb3JtLmg+DQogDQogI2RlZmlu
ZSBXRFRfTUFYX1RJTUVPVVQJCTMxDQogI2RlZmluZSBXRFRfTUlOX1RJTUVPVVQJCTENCkBAIC0x
NjcsNiArMTY4LDggQEAgc3RhdGljIGludCBtdGtfd2R0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9k
ZXZpY2UgKnBkZXYpDQogCWlmIChJU19FUlIobXRrX3dkdC0+d2R0X2Jhc2UpKQ0KIAkJcmV0dXJu
IFBUUl9FUlIobXRrX3dkdC0+d2R0X2Jhc2UpOw0KIA0KKwlvZl9wbGF0Zm9ybV9wb3B1bGF0ZShw
ZGV2LT5kZXYub2Zfbm9kZSwgTlVMTCwgTlVMTCwgJnBkZXYtPmRldik7DQorDQogCW10a193ZHQt
PndkdF9kZXYuaW5mbyA9ICZtdGtfd2R0X2luZm87DQogCW10a193ZHQtPndkdF9kZXYub3BzID0g
Jm10a193ZHRfb3BzOw0KIAltdGtfd2R0LT53ZHRfZGV2LnRpbWVvdXQgPSBXRFRfTUFYX1RJTUVP
VVQ7DQotLSANCjEuNy45LjUNCg==

