Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173AD1B1C38
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 05:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgDUDAT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 23:00:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63718 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726644AbgDUDAS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 23:00:18 -0400
X-UUID: 280ccff0309840b3861706258c11236f-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=99oh6N8mdr4ZmH3MgX6Bmt28F3Ip4r6y2UmH1UwY2G4=;
        b=mahRy4Gz0S1L3iZv8qxHJooFesAqhOcL+L3gSIoHOJLLORwMY5nmjMtSIwotMpH7RPRYYz1t4uHJ2HHGkuHyQ58nDTu9qNyeYkqunWsGlqMIMt7ap23ewW84d19gUVJDIlm7wcvrW5cEYvBKxSxPDE3S1KEgutWXWpukBKKi5HY=;
X-UUID: 280ccff0309840b3861706258c11236f-20200421
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 630533692; Tue, 21 Apr 2020 11:00:14 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 11:00:14 +0800
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
Subject: [PATCH v13 2/6] mfd: mt6397: Trim probe function to support different chips more cleanly
Date:   Tue, 21 Apr 2020 11:00:08 +0800
Message-ID: <1587438012-24832-3-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIG5ldyBzdHJ1Y3QgbWVtYmVycyBmb3IgbWZkLWNlbGxzIGFuZCBpcnEgaW5pdGlhbCBmdW5j
dGlvbiwgc28gd2UgY2FuDQpjYWxsIGRldm1fbWZkX2FkZF9kZXZpY2VzKCkgb25seSBvbmNlLg0K
DQpTaWduZWQtb2ZmLWJ5OiBIc2luLUhzaXVuZyBXYW5nIDxoc2luLWhzaXVuZy53YW5nQG1lZGlh
dGVrLmNvbT4NCkFja2VkLWZvci1NRkQtYnk6IExlZSBKb25lcyA8bGVlLmpvbmVzQGxpbmFyby5v
cmc+DQotLS0NCiBkcml2ZXJzL21mZC9tdDYzOTctY29yZS5jIHwgMzUgKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTQgaW5zZXJ0aW9ucygrKSwg
MjEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5j
IGIvZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYw0KaW5kZXggZDJlNzBkOC4uYTMxM2E3MiAxMDA2
NDQNCi0tLSBhL2RyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMNCisrKyBiL2RyaXZlcnMvbWZkL210
NjM5Ny1jb3JlLmMNCkBAIC0xMDMsMjIgKzEwMywzMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1m
ZF9jZWxsIG10NjM5N19kZXZzW10gPSB7DQogc3RydWN0IGNoaXBfZGF0YSB7DQogCXUzMiBjaWRf
YWRkcjsNCiAJdTMyIGNpZF9zaGlmdDsNCisJY29uc3Qgc3RydWN0IG1mZF9jZWxsICpjZWxsczsN
CisJaW50IGNlbGxfc2l6ZTsNCisJaW50ICgqaXJxX2luaXQpKHN0cnVjdCBtdDYzOTdfY2hpcCAq
Y2hpcCk7DQogfTsNCiANCiBzdGF0aWMgY29uc3Qgc3RydWN0IGNoaXBfZGF0YSBtdDYzMjNfY29y
ZSA9IHsNCiAJLmNpZF9hZGRyID0gTVQ2MzIzX0NJRCwNCiAJLmNpZF9zaGlmdCA9IDAsDQorCS5j
ZWxscyA9IG10NjMyM19kZXZzLA0KKwkuY2VsbF9zaXplID0gQVJSQVlfU0laRShtdDYzMjNfZGV2
cyksDQorCS5pcnFfaW5pdCA9IG10NjM5N19pcnFfaW5pdCwNCiB9Ow0KIA0KIHN0YXRpYyBjb25z
dCBzdHJ1Y3QgY2hpcF9kYXRhIG10NjM5N19jb3JlID0gew0KIAkuY2lkX2FkZHIgPSBNVDYzOTdf
Q0lELA0KIAkuY2lkX3NoaWZ0ID0gMCwNCisJLmNlbGxzID0gbXQ2Mzk3X2RldnMsDQorCS5jZWxs
X3NpemUgPSBBUlJBWV9TSVpFKG10NjM5N19kZXZzKSwNCisJLmlycV9pbml0ID0gbXQ2Mzk3X2ly
cV9pbml0LA0KIH07DQogDQogc3RhdGljIGludCBtdDYzOTdfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCiB7DQogCWludCByZXQ7DQotCXVuc2lnbmVkIGludCBpZDsNCisJdW5z
aWduZWQgaW50IGlkID0gMDsNCiAJc3RydWN0IG10NjM5N19jaGlwICpwbWljOw0KIAljb25zdCBz
dHJ1Y3QgY2hpcF9kYXRhICpwbWljX2NvcmU7DQogDQpAQCAtMTU0LDI5ICsxNjMsMTMgQEAgc3Rh
dGljIGludCBtdDYzOTdfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJaWYg
KHBtaWMtPmlycSA8PSAwKQ0KIAkJcmV0dXJuIHBtaWMtPmlycTsNCiANCi0JcmV0ID0gbXQ2Mzk3
X2lycV9pbml0KHBtaWMpOw0KKwlyZXQgPSBwbWljX2NvcmUtPmlycV9pbml0KHBtaWMpOw0KIAlp
ZiAocmV0KQ0KIAkJcmV0dXJuIHJldDsNCiANCi0Jc3dpdGNoIChwbWljLT5jaGlwX2lkKSB7DQot
CWNhc2UgTVQ2MzIzX0NISVBfSUQ6DQotCQlyZXQgPSBkZXZtX21mZF9hZGRfZGV2aWNlcygmcGRl
di0+ZGV2LCBQTEFURk9STV9ERVZJRF9OT05FLA0KLQkJCQkJICAgbXQ2MzIzX2RldnMsIEFSUkFZ
X1NJWkUobXQ2MzIzX2RldnMpLA0KLQkJCQkJICAgTlVMTCwgMCwgcG1pYy0+aXJxX2RvbWFpbik7
DQotCQlicmVhazsNCi0NCi0JY2FzZSBNVDYzOTFfQ0hJUF9JRDoNCi0JY2FzZSBNVDYzOTdfQ0hJ
UF9JRDoNCi0JCXJldCA9IGRldm1fbWZkX2FkZF9kZXZpY2VzKCZwZGV2LT5kZXYsIFBMQVRGT1JN
X0RFVklEX05PTkUsDQotCQkJCQkgICBtdDYzOTdfZGV2cywgQVJSQVlfU0laRShtdDYzOTdfZGV2
cyksDQotCQkJCQkgICBOVUxMLCAwLCBwbWljLT5pcnFfZG9tYWluKTsNCi0JCWJyZWFrOw0KLQ0K
LQlkZWZhdWx0Og0KLQkJZGV2X2VycigmcGRldi0+ZGV2LCAidW5zdXBwb3J0ZWQgY2hpcDogJWRc
biIsIHBtaWMtPmNoaXBfaWQpOw0KLQkJcmV0dXJuIC1FTk9ERVY7DQotCX0NCi0NCisJcmV0ID0g
ZGV2bV9tZmRfYWRkX2RldmljZXMoJnBkZXYtPmRldiwgUExBVEZPUk1fREVWSURfTk9ORSwNCisJ
CQkJICAgcG1pY19jb3JlLT5jZWxscywgcG1pY19jb3JlLT5jZWxsX3NpemUsDQorCQkJCSAgIE5V
TEwsIDAsIHBtaWMtPmlycV9kb21haW4pOw0KIAlpZiAocmV0KSB7DQogCQlpcnFfZG9tYWluX3Jl
bW92ZShwbWljLT5pcnFfZG9tYWluKTsNCiAJCWRldl9lcnIoJnBkZXYtPmRldiwgImZhaWxlZCB0
byBhZGQgY2hpbGQgZGV2aWNlczogJWRcbiIsIHJldCk7DQotLSANCjIuNi40DQo=

