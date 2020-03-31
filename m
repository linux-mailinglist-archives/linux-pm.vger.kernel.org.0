Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170AF198AD9
	for <lists+linux-pm@lfdr.de>; Tue, 31 Mar 2020 06:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726397AbgCaEHs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Mar 2020 00:07:48 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58280 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725792AbgCaEHr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Mar 2020 00:07:47 -0400
X-UUID: 628a8654f425445eacba6045dd5d9d9c-20200331
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=U6Q1mnGYOtg9IfYqJ21CXjqAm8LRNeM9DhjP0Pg/xQ0=;
        b=REPe9Fg/MnD6nr55rTIbHeFZexNFa97hcuRIC7wuyqIps3sVAmJQ0n8VpWDB+vNYnsvHpwpVKvZbpmJqjp7iQqgjGlUPinzbY1czgd5ce0PpPq7zshrsRJeWuiSZEes5FIOXWcUqzgZbV6MPFK+sSHQW1zmaI5U2Lvb3AWru6xg=;
X-UUID: 628a8654f425445eacba6045dd5d9d9c-20200331
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 38801241; Tue, 31 Mar 2020 12:07:41 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 31 Mar 2020 12:07:39 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 31 Mar 2020 12:07:40 +0800
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
Subject: [PATCH v11 4/5] rtc: mt6397: Add support for the MediaTek MT6358 RTC
Date:   Tue, 31 Mar 2020 12:07:36 +0800
Message-ID: <1585627657-3265-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1585627657-3265-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogUmFuIEJpIDxyYW4uYmlAbWVkaWF0ZWsuY29tPg0KDQpUaGlzIGFkZCBzdXBwb3J0IGZv
ciB0aGUgTWVkaWFUZWsgTVQ2MzU4IFJUQy4gRHJpdmVyIHVzaW5nDQpjb21wYXRpYmxlIGRhdGEg
dG8gc3RvcmUgZGlmZmVyZW50IFJUQ19XUlRHUiBhZGRyZXNzIG9mZnNldC4NClRoaXMgcmVwbGFj
ZSBSVENfV1JUR1IgdG8gUlRDX1dSVEdSX01UNjMyMyBpbiBtdDYzMjMtcG93ZXJvZmYNCmRyaXZl
ciB3aGljaCBvbmx5IG5lZWRlZCBieSBhcm12NyBDUFUgd2l0aG91dCBBVEYuDQoNClNpZ25lZC1v
ZmYtYnk6IFJhbiBCaSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IEhzaW4t
SHNpdW5nIFdhbmcgPGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVy
cy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYyB8ICAyICstDQogZHJpdmVycy9ydGMvcnRj
LW10NjM5Ny5jICAgICAgICAgICAgICB8IDIzICsrKysrKysrKysrKysrKysrKystLS0tDQogaW5j
bHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oICAgICAgICB8ICA5ICsrKysrKysrLQ0KIDMgZmls
ZXMgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMgYi9kcml2ZXJzL3Bvd2Vy
L3Jlc2V0L210NjMyMy1wb3dlcm9mZi5jDQppbmRleCAxY2FmNDNkLi4wNTMyODAzIDEwMDY0NA0K
LS0tIGEvZHJpdmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYw0KKysrIGIvZHJpdmVy
cy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYw0KQEAgLTMwLDcgKzMwLDcgQEAgc3RhdGlj
IHZvaWQgbXQ2MzIzX2RvX3B3cm9mZih2b2lkKQ0KIAlpbnQgcmV0Ow0KIA0KIAlyZWdtYXBfd3Jp
dGUocHdyYy0+cmVnbWFwLCBwd3JjLT5iYXNlICsgUlRDX0JCUFUsIFJUQ19CQlBVX0tFWSk7DQot
CXJlZ21hcF93cml0ZShwd3JjLT5yZWdtYXAsIHB3cmMtPmJhc2UgKyBSVENfV1JUR1IsIDEpOw0K
KwlyZWdtYXBfd3JpdGUocHdyYy0+cmVnbWFwLCBwd3JjLT5iYXNlICsgUlRDX1dSVEdSX01UNjMy
MywgMSk7DQogDQogCXJldCA9IHJlZ21hcF9yZWFkX3BvbGxfdGltZW91dChwd3JjLT5yZWdtYXAs
DQogCQkJCQlwd3JjLT5iYXNlICsgUlRDX0JCUFUsIHZhbCwNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3J0Yy9ydGMtbXQ2Mzk3LmMgYi9kcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMNCmluZGV4IGNkYTIz
OGQuLjdmM2RmZDIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMNCisrKyBi
L2RyaXZlcnMvcnRjL3J0Yy1tdDYzOTcuYw0KQEAgLTksNiArOSw3IEBADQogI2luY2x1ZGUgPGxp
bnV4L21mZC9tdDYzOTcvY29yZS5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1bGUuaD4NCiAjaW5j
bHVkZSA8bGludXgvbXV0ZXguaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfZGV2aWNlLmg+DQogI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9yZWdtYXAu
aD4NCiAjaW5jbHVkZSA8bGludXgvcnRjLmg+DQpAQCAtMjAsNyArMjEsNyBAQCBzdGF0aWMgaW50
IG10a19ydGNfd3JpdGVfdHJpZ2dlcihzdHJ1Y3QgbXQ2Mzk3X3J0YyAqcnRjKQ0KIAlpbnQgcmV0
Ow0KIAl1MzIgZGF0YTsNCiANCi0JcmV0ID0gcmVnbWFwX3dyaXRlKHJ0Yy0+cmVnbWFwLCBydGMt
PmFkZHJfYmFzZSArIFJUQ19XUlRHUiwgMSk7DQorCXJldCA9IHJlZ21hcF93cml0ZShydGMtPnJl
Z21hcCwgcnRjLT5hZGRyX2Jhc2UgKyBydGMtPmRhdGEtPndydGdyLCAxKTsNCiAJaWYgKHJldCA8
IDApDQogCQlyZXR1cm4gcmV0Ow0KIA0KQEAgLTI2OSw2ICsyNzAsOCBAQCBzdGF0aWMgaW50IG10
a19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmVzID0gcGxhdGZv
cm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJcnRjLT5hZGRyX2Jh
c2UgPSByZXMtPnN0YXJ0Ow0KIA0KKwlydGMtPmRhdGEgPSBvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoJnBkZXYtPmRldik7DQorDQogCXJ0Yy0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCAw
KTsNCiAJaWYgKHJ0Yy0+aXJxIDwgMCkNCiAJCXJldHVybiBydGMtPmlycTsNCkBAIC0zMjUsMTAg
KzMyOCwyMiBAQCBzdGF0aWMgaW50IG10NjM5N19ydGNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRl
dikNCiBzdGF0aWMgU0lNUExFX0RFVl9QTV9PUFMobXQ2Mzk3X3BtX29wcywgbXQ2Mzk3X3J0Y19z
dXNwZW5kLA0KIAkJCW10NjM5N19ydGNfcmVzdW1lKTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0
IG10a19ydGNfZGF0YSBtdDYzNThfcnRjX2RhdGEgPSB7DQorCS53cnRnciA9IFJUQ19XUlRHUl9N
VDYzNTgsDQorfTsNCisNCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19ydGNfZGF0YSBtdDYzOTdf
cnRjX2RhdGEgPSB7DQorCS53cnRnciA9IFJUQ19XUlRHUl9NVDYzOTcsDQorfTsNCisNCiBzdGF0
aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtdDYzOTdfcnRjX29mX21hdGNoW10gPSB7DQot
CXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzIzLXJ0YyIsIH0sDQotCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQ2Mzk3LXJ0YyIsIH0sDQotCXsgfQ0KKwl7IC5jb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10NjMyMy1ydGMiLA0KKwkJLmRhdGEgPSAmbXQ2Mzk3X3J0Y19kYXRhLCB9LA0K
Kwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM1OC1ydGMiLA0KKwkJLmRhdGEgPSAmbXQ2
MzU4X3J0Y19kYXRhLCB9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM5Ny1ydGMi
LA0KKwkJLmRhdGEgPSAmbXQ2Mzk3X3J0Y19kYXRhLCB9LA0KKwl7fQ0KIH07DQogTU9EVUxFX0RF
VklDRV9UQUJMRShvZiwgbXQ2Mzk3X3J0Y19vZl9tYXRjaCk7DQogDQpkaWZmIC0tZ2l0IGEvaW5j
bHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0
Yy5oDQppbmRleCA3ZGZiNjNiLi42MjAwZjNiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L3J0Yy5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvcnRjLmgNCkBA
IC0xOCw3ICsxOCw5IEBADQogI2RlZmluZSBSVENfQkJQVV9DQlVTWSAgICAgICAgIEJJVCg2KQ0K
ICNkZWZpbmUgUlRDX0JCUFVfS0VZICAgICAgICAgICAgKDB4NDMgPDwgOCkNCiANCi0jZGVmaW5l
IFJUQ19XUlRHUiAgICAgICAgICAgICAgMHgwMDNjDQorI2RlZmluZSBSVENfV1JUR1JfTVQ2MzU4
ICAgICAgIDB4M2ENCisjZGVmaW5lIFJUQ19XUlRHUl9NVDYzOTcgICAgICAgMHgzYw0KKyNkZWZp
bmUgUlRDX1dSVEdSX01UNjMyMyAgICAgICBSVENfV1JUR1JfTVQ2Mzk3DQogDQogI2RlZmluZSBS
VENfSVJRX1NUQSAgICAgICAgICAgIDB4MDAwMg0KICNkZWZpbmUgUlRDX0lSUV9TVEFfQUwgICAg
ICAgICBCSVQoMCkNCkBAIC02NSw2ICs2NywxMCBAQA0KICNkZWZpbmUgTVRLX1JUQ19QT0xMX0RF
TEFZX1VTICAxMA0KICNkZWZpbmUgTVRLX1JUQ19QT0xMX1RJTUVPVVQgICAoamlmZmllc190b191
c2VjcyhIWikpDQogDQorc3RydWN0IG10a19ydGNfZGF0YSB7DQorCXUzMiAgICAgICAgICAgICAg
ICAgICAgIHdydGdyOw0KK307DQorDQogc3RydWN0IG10NjM5N19ydGMgew0KIAlzdHJ1Y3QgZGV2
aWNlICAgICAgICAgICAqZGV2Ow0KIAlzdHJ1Y3QgcnRjX2RldmljZSAgICAgICAqcnRjX2RldjsN
CkBAIC03NCw2ICs4MCw3IEBAIHN0cnVjdCBtdDYzOTdfcnRjIHsNCiAJc3RydWN0IHJlZ21hcCAg
ICAgICAgICAgKnJlZ21hcDsNCiAJaW50ICAgICAgICAgICAgICAgICAgICAgaXJxOw0KIAl1MzIg
ICAgICAgICAgICAgICAgICAgICBhZGRyX2Jhc2U7DQorCWNvbnN0IHN0cnVjdCBtdGtfcnRjX2Rh
dGEgKmRhdGE7DQogfTsNCiANCiAjZW5kaWYgLyogX0xJTlVYX01GRF9NVDYzOTdfUlRDX0hfICov
DQotLSANCjIuNi40DQo=

