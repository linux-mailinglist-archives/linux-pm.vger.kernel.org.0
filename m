Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1CE1A1D34
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 10:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgDHIND (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 04:13:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9335 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726146AbgDHINC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 04:13:02 -0400
X-UUID: 13fc219e180e47d6beac0a362bd9c807-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=LCpxPAAAlbCRhNWaPlL/YFI3+ocxOtHpC4ZE4h02Q94=;
        b=qP6e6Bx/1fpCP//jsDK3xQRw0fSg+WeUNJZW7Ui1WcEZ6S9UQsncL7TKrSHd8VdprJrQyGxE5ZX6nlMN37zy5oEIqjSky1F03cGhKE+jBOo/e9OqzFr3UQ2yrae/T5ArZ1RbS2SWQKFVFnThmrSvYsI/oP+CqiXwsfnq7x9/MUk=;
X-UUID: 13fc219e180e47d6beac0a362bd9c807-20200408
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1975154832; Wed, 08 Apr 2020 16:12:53 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH v12 1/6] mfd: mt6397: Modify suspend/resume behavior
Date:   Wed, 8 Apr 2020 16:12:06 +0800
Message-ID: <1586333531-21641-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

U29tZSBwbWljcyBkb24ndCBuZWVkIGJhY2t1cCBpbnRlcnJ1cHQgc2V0dGluZ3MsIHNvIHdlIGNo
YW5nZSB0byB1c2UNCnBtIG5vdGlmaWVyIGZvciB0aGUgcG1pY3Mgd2hpY2ggYXJlIG5lY2Vzc2Fy
eSB0byBzdG9yZSBzZXR0aW5ncy4NCg0KU2lnbmVkLW9mZi1ieTogSHNpbi1Ic2l1bmcgV2FuZyA8
aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL21mZC9tdDYzOTct
Y29yZS5jICAgICAgIHwgMzAgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQogZHJpdmVy
cy9tZmQvbXQ2Mzk3LWlycS5jICAgICAgICB8IDM1ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L2NvcmUuaCB8ICAyICsrDQogMyBm
aWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMgYi9kcml2ZXJzL21mZC9tdDYzOTctY29y
ZS5jDQppbmRleCAwNDM3Yzg1Li5kMmU3MGQ4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9tZmQvbXQ2
Mzk3LWNvcmUuYw0KKysrIGIvZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYw0KQEAgLTEwMCwzNSAr
MTAwLDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtZmRfY2VsbCBtdDYzOTdfZGV2c1tdID0gew0K
IAl9DQogfTsNCiANCi0jaWZkZWYgQ09ORklHX1BNX1NMRUVQDQotc3RhdGljIGludCBtdDYzOTdf
aXJxX3N1c3BlbmQoc3RydWN0IGRldmljZSAqZGV2KQ0KLXsNCi0Jc3RydWN0IG10NjM5N19jaGlw
ICpjaGlwID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQotDQotCXJlZ21hcF93cml0ZShjaGlwLT5y
ZWdtYXAsIGNoaXAtPmludF9jb25bMF0sIGNoaXAtPndha2VfbWFza1swXSk7DQotCXJlZ21hcF93
cml0ZShjaGlwLT5yZWdtYXAsIGNoaXAtPmludF9jb25bMV0sIGNoaXAtPndha2VfbWFza1sxXSk7
DQotDQotCWVuYWJsZV9pcnFfd2FrZShjaGlwLT5pcnEpOw0KLQ0KLQlyZXR1cm4gMDsNCi19DQot
DQotc3RhdGljIGludCBtdDYzOTdfaXJxX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQotew0K
LQlzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCi0NCi0J
cmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+aW50X2NvblswXSwgY2hpcC0+aXJxX21h
c2tzX2N1clswXSk7DQotCXJlZ21hcF93cml0ZShjaGlwLT5yZWdtYXAsIGNoaXAtPmludF9jb25b
MV0sIGNoaXAtPmlycV9tYXNrc19jdXJbMV0pOw0KLQ0KLQlkaXNhYmxlX2lycV93YWtlKGNoaXAt
PmlycSk7DQotDQotCXJldHVybiAwOw0KLX0NCi0jZW5kaWYNCi0NCi1zdGF0aWMgU0lNUExFX0RF
Vl9QTV9PUFMobXQ2Mzk3X3BtX29wcywgbXQ2Mzk3X2lycV9zdXNwZW5kLA0KLQkJCW10NjM5N19p
cnFfcmVzdW1lKTsNCi0NCiBzdHJ1Y3QgY2hpcF9kYXRhIHsNCiAJdTMyIGNpZF9hZGRyOw0KIAl1
MzIgY2lkX3NoaWZ0Ow0KQEAgLTIzOCw3ICsyMDksNiBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3Jt
X2RyaXZlciBtdDYzOTdfZHJpdmVyID0gew0KIAkuZHJpdmVyID0gew0KIAkJLm5hbWUgPSAibXQ2
Mzk3IiwNCiAJCS5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cihtdDYzOTdfb2ZfbWF0Y2gp
LA0KLQkJLnBtID0gJm10NjM5N19wbV9vcHMsDQogCX0sDQogCS5pZF90YWJsZSA9IG10NjM5N19p
ZCwNCiB9Ow0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWZkL210NjM5Ny1pcnEuYyBiL2RyaXZlcnMv
bWZkL210NjM5Ny1pcnEuYw0KaW5kZXggYjJkM2NlMS4uMjkyNDkxOSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbWZkL210NjM5Ny1pcnEuYw0KKysrIGIvZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jDQpA
QCAtOSw2ICs5LDcgQEANCiAjaW5jbHVkZSA8bGludXgvb2ZfaXJxLmg+DQogI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCisjaW5j
bHVkZSA8bGludXgvc3VzcGVuZC5oPg0KICNpbmNsdWRlIDxsaW51eC9tZmQvbXQ2MzIzL2NvcmUu
aD4NCiAjaW5jbHVkZSA8bGludXgvbWZkL210NjMyMy9yZWdpc3RlcnMuaD4NCiAjaW5jbHVkZSA8
bGludXgvbWZkL210NjM5Ny9jb3JlLmg+DQpAQCAtODEsNyArODIsNyBAQCBzdGF0aWMgc3RydWN0
IGlycV9jaGlwIG10NjM5N19pcnFfY2hpcCA9IHsNCiBzdGF0aWMgdm9pZCBtdDYzOTdfaXJxX2hh
bmRsZV9yZWcoc3RydWN0IG10NjM5N19jaGlwICptdDYzOTcsIGludCByZWcsDQogCQkJCSAgaW50
IGlycWJhc2UpDQogew0KLQl1bnNpZ25lZCBpbnQgc3RhdHVzOw0KKwl1bnNpZ25lZCBpbnQgc3Rh
dHVzID0gMDsNCiAJaW50IGksIGlycSwgcmV0Ow0KIA0KIAlyZXQgPSByZWdtYXBfcmVhZChtdDYz
OTctPnJlZ21hcCwgcmVnLCAmc3RhdHVzKTsNCkBAIC0xMjgsNiArMTI5LDM2IEBAIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaXJxX2RvbWFpbl9vcHMgbXQ2Mzk3X2lycV9kb21haW5fb3BzID0gew0KIAku
bWFwID0gbXQ2Mzk3X2lycV9kb21haW5fbWFwLA0KIH07DQogDQorc3RhdGljIGludCBtdDYzOTdf
aXJxX3BtX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbm90aWZpZXIsDQorCQkJCSAg
dW5zaWduZWQgbG9uZyBwbV9ldmVudCwgdm9pZCAqdW51c2VkKQ0KK3sNCisJc3RydWN0IG10NjM5
N19jaGlwICpjaGlwID0NCisJCWNvbnRhaW5lcl9vZihub3RpZmllciwgc3RydWN0IG10NjM5N19j
aGlwLCBwbV9uYik7DQorDQorCXN3aXRjaCAocG1fZXZlbnQpIHsNCisJY2FzZSBQTV9TVVNQRU5E
X1BSRVBBUkU6DQorCQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLA0KKwkJCSAgICAgY2hpcC0+
aW50X2NvblswXSwgY2hpcC0+d2FrZV9tYXNrWzBdKTsNCisJCXJlZ21hcF93cml0ZShjaGlwLT5y
ZWdtYXAsDQorCQkJICAgICBjaGlwLT5pbnRfY29uWzFdLCBjaGlwLT53YWtlX21hc2tbMV0pOw0K
KwkJZW5hYmxlX2lycV93YWtlKGNoaXAtPmlycSk7DQorCQlicmVhazsNCisNCisJY2FzZSBQTV9Q
T1NUX1NVU1BFTkQ6DQorCQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLA0KKwkJCSAgICAgY2hp
cC0+aW50X2NvblswXSwgY2hpcC0+aXJxX21hc2tzX2N1clswXSk7DQorCQlyZWdtYXBfd3JpdGUo
Y2hpcC0+cmVnbWFwLA0KKwkJCSAgICAgY2hpcC0+aW50X2NvblsxXSwgY2hpcC0+aXJxX21hc2tz
X2N1clsxXSk7DQorCQlkaXNhYmxlX2lycV93YWtlKGNoaXAtPmlycSk7DQorCQlicmVhazsNCisN
CisJZGVmYXVsdDoNCisJCWJyZWFrOw0KKwl9DQorDQorCXJldHVybiBOT1RJRllfRE9ORTsNCit9
DQorDQogaW50IG10NjM5N19pcnFfaW5pdChzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXApDQogew0K
IAlpbnQgcmV0Ow0KQEAgLTE1OSw2ICsxOTAsNyBAQCBpbnQgbXQ2Mzk3X2lycV9pbml0KHN0cnVj
dCBtdDYzOTdfY2hpcCAqY2hpcCkNCiAJcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+
aW50X2NvblswXSwgMHgwKTsNCiAJcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+aW50
X2NvblsxXSwgMHgwKTsNCiANCisJY2hpcC0+cG1fbmIubm90aWZpZXJfY2FsbCA9IG10NjM5N19p
cnFfcG1fbm90aWZpZXI7DQogCWNoaXAtPmlycV9kb21haW4gPSBpcnFfZG9tYWluX2FkZF9saW5l
YXIoY2hpcC0+ZGV2LT5vZl9ub2RlLA0KIAkJCQkJCSBNVDYzOTdfSVJRX05SLA0KIAkJCQkJCSAm
bXQ2Mzk3X2lycV9kb21haW5fb3BzLA0KQEAgLTE3Nyw1ICsyMDksNiBAQCBpbnQgbXQ2Mzk3X2ly
cV9pbml0KHN0cnVjdCBtdDYzOTdfY2hpcCAqY2hpcCkNCiAJCXJldHVybiByZXQ7DQogCX0NCiAN
CisJcmVnaXN0ZXJfcG1fbm90aWZpZXIoJmNoaXAtPnBtX25iKTsNCiAJcmV0dXJuIDA7DQogfQ0K
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggYi9pbmNsdWRlL2xp
bnV4L21mZC9tdDYzOTcvY29yZS5oDQppbmRleCBmYzg4ZDMxLi5iODFkMzMzIDEwMDY0NA0KLS0t
IGEvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L2NvcmUuaA0KKysrIGIvaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L2NvcmUuaA0KQEAgLTgsNiArOCw3IEBADQogI2RlZmluZSBfX01GRF9NVDYzOTdf
Q09SRV9IX18NCiANCiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCisjaW5jbHVkZSA8bGludXgv
bm90aWZpZXIuaD4NCiANCiBlbnVtIGNoaXBfaWQgew0KIAlNVDYzMjNfQ0hJUF9JRCA9IDB4MjMs
DQpAQCAtNTQsNiArNTUsNyBAQCBlbnVtIG10NjM5N19pcnFfbnVtYmVycyB7DQogc3RydWN0IG10
NjM5N19jaGlwIHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAlzdHJ1Y3QgcmVnbWFwICpyZWdt
YXA7DQorCXN0cnVjdCBub3RpZmllcl9ibG9jayBwbV9uYjsNCiAJaW50IGlycTsNCiAJc3RydWN0
IGlycV9kb21haW4gKmlycV9kb21haW47DQogCXN0cnVjdCBtdXRleCBpcnFsb2NrOw0KLS0gDQoy
LjYuNA0K

