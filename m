Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBFD1A1D1E
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 10:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDHIM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 04:12:58 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63866 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726642AbgDHIM6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 04:12:58 -0400
X-UUID: 49c8344e8e514be39abfa3c965f19bb2-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=fGKVeJMpPPedNFBW5Z89bG65lS398KakOP6xziYFSsc=;
        b=H/wN0dz1gaqTobfimzYR8IcVbDrcAEc+451udtbn5nGthbYmyHpLBNWt3qwMELR5o4EEPa8qBPxBBSsBHG9eV7lX0FMrMlX0grVeap7U+CFrbUVL1l4UykufPFu+Sd9+/keuGgzBd5wRfQx0QFTrkmYvzVd/4n8na8gTunRcALI=;
X-UUID: 49c8344e8e514be39abfa3c965f19bb2-20200408
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1789487845; Wed, 08 Apr 2020 16:12:53 +0800
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
Subject: [PATCH v12 2/6] mfd: mt6397: Trim probe function to support different chips more cleanly
Date:   Wed, 8 Apr 2020 16:12:07 +0800
Message-ID: <1586333531-21641-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FEDB43AB2ACB42064A2DB5C5D7CC07444166C3514C64B30D112F886F1894AF732000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIG5ldyBzdHJ1Y3QgbWVtYmVycyBmb3IgbWZkLWNlbGxzIGFuZCBpcnEgaW5pdGlhbCBmdW5j
dGlvbiwgc28gd2UgY2FuDQpjYWxsIGRldm1fbWZkX2FkZF9kZXZpY2VzKCkgb25seSBvbmNlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlh
dGVrLmNvbT4NCi0tLQ0KIGRyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMgfCAzNSArKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCAyMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL210NjM5Ny1j
b3JlLmMgYi9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5jDQppbmRleCBkMmU3MGQ4Li5hMzEzYTcy
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYw0KKysrIGIvZHJpdmVycy9t
ZmQvbXQ2Mzk3LWNvcmUuYw0KQEAgLTEwMywyMiArMTAzLDMxIEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgbWZkX2NlbGwgbXQ2Mzk3X2RldnNbXSA9IHsNCiBzdHJ1Y3QgY2hpcF9kYXRhIHsNCiAJdTMy
IGNpZF9hZGRyOw0KIAl1MzIgY2lkX3NoaWZ0Ow0KKwljb25zdCBzdHJ1Y3QgbWZkX2NlbGwgKmNl
bGxzOw0KKwlpbnQgY2VsbF9zaXplOw0KKwlpbnQgKCppcnFfaW5pdCkoc3RydWN0IG10NjM5N19j
aGlwICpjaGlwKTsNCiB9Ow0KIA0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgY2hpcF9kYXRhIG10NjMy
M19jb3JlID0gew0KIAkuY2lkX2FkZHIgPSBNVDYzMjNfQ0lELA0KIAkuY2lkX3NoaWZ0ID0gMCwN
CisJLmNlbGxzID0gbXQ2MzIzX2RldnMsDQorCS5jZWxsX3NpemUgPSBBUlJBWV9TSVpFKG10NjMy
M19kZXZzKSwNCisJLmlycV9pbml0ID0gbXQ2Mzk3X2lycV9pbml0LA0KIH07DQogDQogc3RhdGlj
IGNvbnN0IHN0cnVjdCBjaGlwX2RhdGEgbXQ2Mzk3X2NvcmUgPSB7DQogCS5jaWRfYWRkciA9IE1U
NjM5N19DSUQsDQogCS5jaWRfc2hpZnQgPSAwLA0KKwkuY2VsbHMgPSBtdDYzOTdfZGV2cywNCisJ
LmNlbGxfc2l6ZSA9IEFSUkFZX1NJWkUobXQ2Mzk3X2RldnMpLA0KKwkuaXJxX2luaXQgPSBtdDYz
OTdfaXJxX2luaXQsDQogfTsNCiANCiBzdGF0aWMgaW50IG10NjM5N19wcm9iZShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQ0KIHsNCiAJaW50IHJldDsNCi0JdW5zaWduZWQgaW50IGlkOw0K
Kwl1bnNpZ25lZCBpbnQgaWQgPSAwOw0KIAlzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKnBtaWM7DQogCWNv
bnN0IHN0cnVjdCBjaGlwX2RhdGEgKnBtaWNfY29yZTsNCiANCkBAIC0xNTQsMjkgKzE2MywxMyBA
QCBzdGF0aWMgaW50IG10NjM5N19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0K
IAlpZiAocG1pYy0+aXJxIDw9IDApDQogCQlyZXR1cm4gcG1pYy0+aXJxOw0KIA0KLQlyZXQgPSBt
dDYzOTdfaXJxX2luaXQocG1pYyk7DQorCXJldCA9IHBtaWNfY29yZS0+aXJxX2luaXQocG1pYyk7
DQogCWlmIChyZXQpDQogCQlyZXR1cm4gcmV0Ow0KIA0KLQlzd2l0Y2ggKHBtaWMtPmNoaXBfaWQp
IHsNCi0JY2FzZSBNVDYzMjNfQ0hJUF9JRDoNCi0JCXJldCA9IGRldm1fbWZkX2FkZF9kZXZpY2Vz
KCZwZGV2LT5kZXYsIFBMQVRGT1JNX0RFVklEX05PTkUsDQotCQkJCQkgICBtdDYzMjNfZGV2cywg
QVJSQVlfU0laRShtdDYzMjNfZGV2cyksDQotCQkJCQkgICBOVUxMLCAwLCBwbWljLT5pcnFfZG9t
YWluKTsNCi0JCWJyZWFrOw0KLQ0KLQljYXNlIE1UNjM5MV9DSElQX0lEOg0KLQljYXNlIE1UNjM5
N19DSElQX0lEOg0KLQkJcmV0ID0gZGV2bV9tZmRfYWRkX2RldmljZXMoJnBkZXYtPmRldiwgUExB
VEZPUk1fREVWSURfTk9ORSwNCi0JCQkJCSAgIG10NjM5N19kZXZzLCBBUlJBWV9TSVpFKG10NjM5
N19kZXZzKSwNCi0JCQkJCSAgIE5VTEwsIDAsIHBtaWMtPmlycV9kb21haW4pOw0KLQkJYnJlYWs7
DQotDQotCWRlZmF1bHQ6DQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJ1bnN1cHBvcnRlZCBjaGlw
OiAlZFxuIiwgcG1pYy0+Y2hpcF9pZCk7DQotCQlyZXR1cm4gLUVOT0RFVjsNCi0JfQ0KLQ0KKwly
ZXQgPSBkZXZtX21mZF9hZGRfZGV2aWNlcygmcGRldi0+ZGV2LCBQTEFURk9STV9ERVZJRF9OT05F
LA0KKwkJCQkgICBwbWljX2NvcmUtPmNlbGxzLCBwbWljX2NvcmUtPmNlbGxfc2l6ZSwNCisJCQkJ
ICAgTlVMTCwgMCwgcG1pYy0+aXJxX2RvbWFpbik7DQogCWlmIChyZXQpIHsNCiAJCWlycV9kb21h
aW5fcmVtb3ZlKHBtaWMtPmlycV9kb21haW4pOw0KIAkJZGV2X2VycigmcGRldi0+ZGV2LCAiZmFp
bGVkIHRvIGFkZCBjaGlsZCBkZXZpY2VzOiAlZFxuIiwgcmV0KTsNCi0tIA0KMi42LjQNCg==

