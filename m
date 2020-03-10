Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90DFE17F493
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCJKLR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:11:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:39143 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726283AbgCJKKv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:10:51 -0400
X-UUID: bd6bdf8bfad140aba38c3db281612922-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vbBy5C/DaSBU2FKJVnVr9W82i4fyWHiz2DGgjDIySMQ=;
        b=HxyH6sJ6MJwHTr7IWbQa7JTjukwVTZ9gW2tRBne6cYcZZ+dL3AQQk4psNsXXuf5wNhvuMYEbnkI240t+YHMFhyK2xIDew4QMOw+M0OKdRX1Z8iF82j4XbsdzOgLUn9lHcn7XR4XQiGayM0nqX3xfg0yTeqjCjErf5X0A3DdyXCY=;
X-UUID: bd6bdf8bfad140aba38c3db281612922-20200310
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1780487686; Tue, 10 Mar 2020 18:10:45 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 18:09:17 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 18:07:58 +0800
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
Subject: [PATCH v9 1/5] mfd: mt6397: modify suspend/resume behavior
Date:   Tue, 10 Mar 2020 18:10:36 +0800
Message-ID: <1583835040-19157-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
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
aHNpbi1oc2l1bmcud2FuZ0BtZWRpYXRlay5jb20+DQpBY2tlZC1mb3ItTUZELWJ5OiBMZWUgSm9u
ZXMgPGxlZS5qb25lc0BsaW5hcm8ub3JnPg0KLS0tDQogZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUu
YyAgICAgICB8IDMwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIGRyaXZlcnMvbWZk
L210NjM5Ny1pcnEuYyAgICAgICAgfCAzMyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCiBpbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvY29yZS5oIHwgIDIgKysNCiAzIGZpbGVzIGNo
YW5nZWQsIDM1IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYyBiL2RyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMNCmlu
ZGV4IDA0MzdjODUuLmQyZTcwZDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL21mZC9tdDYzOTctY29y
ZS5jDQorKysgYi9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5jDQpAQCAtMTAwLDM1ICsxMDAsNiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG1mZF9jZWxsIG10NjM5N19kZXZzW10gPSB7DQogCX0NCiB9
Ow0KIA0KLSNpZmRlZiBDT05GSUdfUE1fU0xFRVANCi1zdGF0aWMgaW50IG10NjM5N19pcnFfc3Vz
cGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpDQotew0KLQlzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXAg
PSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsNCi0NCi0JcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwg
Y2hpcC0+aW50X2NvblswXSwgY2hpcC0+d2FrZV9tYXNrWzBdKTsNCi0JcmVnbWFwX3dyaXRlKGNo
aXAtPnJlZ21hcCwgY2hpcC0+aW50X2NvblsxXSwgY2hpcC0+d2FrZV9tYXNrWzFdKTsNCi0NCi0J
ZW5hYmxlX2lycV93YWtlKGNoaXAtPmlycSk7DQotDQotCXJldHVybiAwOw0KLX0NCi0NCi1zdGF0
aWMgaW50IG10NjM5N19pcnFfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCi17DQotCXN0cnVj
dCBtdDYzOTdfY2hpcCAqY2hpcCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KLQ0KLQlyZWdtYXBf
d3JpdGUoY2hpcC0+cmVnbWFwLCBjaGlwLT5pbnRfY29uWzBdLCBjaGlwLT5pcnFfbWFza3NfY3Vy
WzBdKTsNCi0JcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+aW50X2NvblsxXSwgY2hp
cC0+aXJxX21hc2tzX2N1clsxXSk7DQotDQotCWRpc2FibGVfaXJxX3dha2UoY2hpcC0+aXJxKTsN
Ci0NCi0JcmV0dXJuIDA7DQotfQ0KLSNlbmRpZg0KLQ0KLXN0YXRpYyBTSU1QTEVfREVWX1BNX09Q
UyhtdDYzOTdfcG1fb3BzLCBtdDYzOTdfaXJxX3N1c3BlbmQsDQotCQkJbXQ2Mzk3X2lycV9yZXN1
bWUpOw0KLQ0KIHN0cnVjdCBjaGlwX2RhdGEgew0KIAl1MzIgY2lkX2FkZHI7DQogCXUzMiBjaWRf
c2hpZnQ7DQpAQCAtMjM4LDcgKzIwOSw2IEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVy
IG10NjM5N19kcml2ZXIgPSB7DQogCS5kcml2ZXIgPSB7DQogCQkubmFtZSA9ICJtdDYzOTciLA0K
IAkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKG10NjM5N19vZl9tYXRjaCksDQotCQku
cG0gPSAmbXQ2Mzk3X3BtX29wcywNCiAJfSwNCiAJLmlkX3RhYmxlID0gbXQ2Mzk3X2lkLA0KIH07
DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9tZmQvbXQ2Mzk3LWlycS5jIGIvZHJpdmVycy9tZmQvbXQ2
Mzk3LWlycS5jDQppbmRleCBiMmQzY2UxLi42NjllOTNkIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9t
ZmQvbXQ2Mzk3LWlycS5jDQorKysgYi9kcml2ZXJzL21mZC9tdDYzOTctaXJxLmMNCkBAIC05LDYg
KzksNyBAQA0KICNpbmNsdWRlIDxsaW51eC9vZl9pcnEuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxh
dGZvcm1fZGV2aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3JlZ21hcC5oPg0KKyNpbmNsdWRlIDxs
aW51eC9zdXNwZW5kLmg+DQogI2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzMjMvY29yZS5oPg0KICNp
bmNsdWRlIDxsaW51eC9tZmQvbXQ2MzIzL3JlZ2lzdGVycy5oPg0KICNpbmNsdWRlIDxsaW51eC9t
ZmQvbXQ2Mzk3L2NvcmUuaD4NCkBAIC0xMjgsNiArMTI5LDM2IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgaXJxX2RvbWFpbl9vcHMgbXQ2Mzk3X2lycV9kb21haW5fb3BzID0gew0KIAkubWFwID0gbXQ2
Mzk3X2lycV9kb21haW5fbWFwLA0KIH07DQogDQorc3RhdGljIGludCBtdDYzOTdfaXJxX3BtX25v
dGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbm90aWZpZXIsDQorCQkJCSAgdW5zaWduZWQg
bG9uZyBwbV9ldmVudCwgdm9pZCAqdW51c2VkKQ0KK3sNCisJc3RydWN0IG10NjM5N19jaGlwICpj
aGlwID0NCisJCWNvbnRhaW5lcl9vZihub3RpZmllciwgc3RydWN0IG10NjM5N19jaGlwLCBwbV9u
Yik7DQorDQorCXN3aXRjaCAocG1fZXZlbnQpIHsNCisJY2FzZSBQTV9TVVNQRU5EX1BSRVBBUkU6
DQorCQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLA0KKwkJCSAgICAgY2hpcC0+aW50X2Nvblsw
XSwgY2hpcC0+d2FrZV9tYXNrWzBdKTsNCisJCXJlZ21hcF93cml0ZShjaGlwLT5yZWdtYXAsDQor
CQkJICAgICBjaGlwLT5pbnRfY29uWzFdLCBjaGlwLT53YWtlX21hc2tbMV0pOw0KKwkJZW5hYmxl
X2lycV93YWtlKGNoaXAtPmlycSk7DQorCQlicmVhazsNCisNCisJY2FzZSBQTV9QT1NUX1NVU1BF
TkQ6DQorCQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLA0KKwkJCSAgICAgY2hpcC0+aW50X2Nv
blswXSwgY2hpcC0+aXJxX21hc2tzX2N1clswXSk7DQorCQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVn
bWFwLA0KKwkJCSAgICAgY2hpcC0+aW50X2NvblsxXSwgY2hpcC0+aXJxX21hc2tzX2N1clsxXSk7
DQorCQlkaXNhYmxlX2lycV93YWtlKGNoaXAtPmlycSk7DQorCQlicmVhazsNCisNCisJZGVmYXVs
dDoNCisJCWJyZWFrOw0KKwl9DQorDQorCXJldHVybiBOT1RJRllfRE9ORTsNCit9DQorDQogaW50
IG10NjM5N19pcnFfaW5pdChzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXApDQogew0KIAlpbnQgcmV0
Ow0KQEAgLTE1OSw2ICsxOTAsNyBAQCBpbnQgbXQ2Mzk3X2lycV9pbml0KHN0cnVjdCBtdDYzOTdf
Y2hpcCAqY2hpcCkNCiAJcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+aW50X2Nvblsw
XSwgMHgwKTsNCiAJcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwgY2hpcC0+aW50X2NvblsxXSwg
MHgwKTsNCiANCisJY2hpcC0+cG1fbmIubm90aWZpZXJfY2FsbCA9IG10NjM5N19pcnFfcG1fbm90
aWZpZXI7DQogCWNoaXAtPmlycV9kb21haW4gPSBpcnFfZG9tYWluX2FkZF9saW5lYXIoY2hpcC0+
ZGV2LT5vZl9ub2RlLA0KIAkJCQkJCSBNVDYzOTdfSVJRX05SLA0KIAkJCQkJCSAmbXQ2Mzk3X2ly
cV9kb21haW5fb3BzLA0KQEAgLTE3Nyw1ICsyMDksNiBAQCBpbnQgbXQ2Mzk3X2lycV9pbml0KHN0
cnVjdCBtdDYzOTdfY2hpcCAqY2hpcCkNCiAJCXJldHVybiByZXQ7DQogCX0NCiANCisJcmVnaXN0
ZXJfcG1fbm90aWZpZXIoJmNoaXAtPnBtX25iKTsNCiAJcmV0dXJuIDA7DQogfQ0KZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggYi9pbmNsdWRlL2xpbnV4L21mZC9t
dDYzOTcvY29yZS5oDQppbmRleCBmYzg4ZDMxLi5iODFkMzMzIDEwMDY0NA0KLS0tIGEvaW5jbHVk
ZS9saW51eC9tZmQvbXQ2Mzk3L2NvcmUuaA0KKysrIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3
L2NvcmUuaA0KQEAgLTgsNiArOCw3IEBADQogI2RlZmluZSBfX01GRF9NVDYzOTdfQ09SRV9IX18N
CiANCiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCisjaW5jbHVkZSA8bGludXgvbm90aWZpZXIu
aD4NCiANCiBlbnVtIGNoaXBfaWQgew0KIAlNVDYzMjNfQ0hJUF9JRCA9IDB4MjMsDQpAQCAtNTQs
NiArNTUsNyBAQCBlbnVtIG10NjM5N19pcnFfbnVtYmVycyB7DQogc3RydWN0IG10NjM5N19jaGlw
IHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAlzdHJ1Y3QgcmVnbWFwICpyZWdtYXA7DQorCXN0
cnVjdCBub3RpZmllcl9ibG9jayBwbV9uYjsNCiAJaW50IGlycTsNCiAJc3RydWN0IGlycV9kb21h
aW4gKmlycV9kb21haW47DQogCXN0cnVjdCBtdXRleCBpcnFsb2NrOw0KLS0gDQoyLjYuNA0K

