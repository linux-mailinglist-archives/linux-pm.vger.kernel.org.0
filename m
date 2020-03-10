Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF73817F48A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Mar 2020 11:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCJKKx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Mar 2020 06:10:53 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:42711 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726199AbgCJKKx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Mar 2020 06:10:53 -0400
X-UUID: 34719fa14c37412c9cc979f9dea59a1f-20200310
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=a9EBRq1NN/wbj7E+tzJXbC0ZXvmXx8HMCccIA8ONyLc=;
        b=ksPszvzikMIpUz/vunEAiKSC5Kzpc2bmpeq08pD3BuAF3j8jCtYbfR2Vfu2rp/3bBb6ciO3E7A83tgxxDLXP6JjJaXas7SmRAEL/HBxxCJWNt9yIcK0wsq7IiqqPTbFaSKXGJP83rQOG09gvEybkkl7Hp02ltTYeU+fiiso91OE=;
X-UUID: 34719fa14c37412c9cc979f9dea59a1f-20200310
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 922481140; Tue, 10 Mar 2020 18:10:46 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 10 Mar 2020 18:06:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 10 Mar 2020 18:07:59 +0800
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
Subject: [PATCH v9 4/5] rtc: mt6397: Add support for the MediaTek MT6358 RTC
Date:   Tue, 10 Mar 2020 18:10:39 +0800
Message-ID: <1583835040-19157-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1583835040-19157-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: CB323D5109DFD0B68FB40BAC4FE3119C2060C7528207A66DFE4B545D726C57412000:8
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
LW10NjM5Ny5jICAgICAgICAgICAgICB8IDI0ICsrKysrKysrKysrKysrKystLS0tLS0tLQ0KIGlu
Y2x1ZGUvbGludXgvbWZkL210NjM5Ny9ydGMuaCAgICAgICAgfCAxNyArKysrKysrKysrKysrKysr
LQ0KIDMgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2VyL3Jlc2V0L210NjMyMy1wb3dlcm9mZi5jIGIvZHJp
dmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93ZXJvZmYuYw0KaW5kZXggMWNhZjQzZC4uMDUzMjgw
MyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMNCisr
KyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMNCkBAIC0zMCw3ICszMCw3
IEBAIHN0YXRpYyB2b2lkIG10NjMyM19kb19wd3JvZmYodm9pZCkNCiAJaW50IHJldDsNCiANCiAJ
cmVnbWFwX3dyaXRlKHB3cmMtPnJlZ21hcCwgcHdyYy0+YmFzZSArIFJUQ19CQlBVLCBSVENfQkJQ
VV9LRVkpOw0KLQlyZWdtYXBfd3JpdGUocHdyYy0+cmVnbWFwLCBwd3JjLT5iYXNlICsgUlRDX1dS
VEdSLCAxKTsNCisJcmVnbWFwX3dyaXRlKHB3cmMtPnJlZ21hcCwgcHdyYy0+YmFzZSArIFJUQ19X
UlRHUl9NVDYzMjMsIDEpOw0KIA0KIAlyZXQgPSByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQocHdy
Yy0+cmVnbWFwLA0KIAkJCQkJcHdyYy0+YmFzZSArIFJUQ19CQlBVLCB2YWwsDQpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jIGIvZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jDQpp
bmRleCBjZGEyMzhkLi5iYzU3N2VmIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ydGMvcnRjLW10NjM5
Ny5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMNCkBAIC05LDE4ICs5LDMwIEBADQog
I2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzOTcvY29yZS5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxs
aW51eC9yZWdtYXAuaD4NCiAjaW5jbHVkZSA8bGludXgvcnRjLmg+DQogI2luY2x1ZGUgPGxpbnV4
L21mZC9tdDYzOTcvcnRjLmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0K
IA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10NjM5N19ydGNfb2ZfbWF0Y2hb
XSA9IHsNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzMjMtcnRjIiwNCisJCS5kYXRh
ID0gKHZvaWQgKikmbXQ2Mzk3X3J0Y19kYXRhLCB9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10NjM1OC1ydGMiLA0KKwkJLmRhdGEgPSAodm9pZCAqKSZtdDYzNThfcnRjX2RhdGEsIH0s
DQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Mzk3LXJ0YyIsDQorCQkuZGF0YSA9ICh2
b2lkICopJm10NjM5N19ydGNfZGF0YSwgfSwNCisJe30NCit9Ow0KK01PRFVMRV9ERVZJQ0VfVEFC
TEUob2YsIG10NjM5N19ydGNfb2ZfbWF0Y2gpOw0KKw0KIHN0YXRpYyBpbnQgbXRrX3J0Y193cml0
ZV90cmlnZ2VyKHN0cnVjdCBtdDYzOTdfcnRjICpydGMpDQogew0KIAlpbnQgcmV0Ow0KIAl1MzIg
ZGF0YTsNCiANCi0JcmV0ID0gcmVnbWFwX3dyaXRlKHJ0Yy0+cmVnbWFwLCBydGMtPmFkZHJfYmFz
ZSArIFJUQ19XUlRHUiwgMSk7DQorCXJldCA9IHJlZ21hcF93cml0ZShydGMtPnJlZ21hcCwgcnRj
LT5hZGRyX2Jhc2UgKyBydGMtPmRhdGEtPndydGdyLCAxKTsNCiAJaWYgKHJldCA8IDApDQogCQly
ZXR1cm4gcmV0Ow0KIA0KQEAgLTI2OSw2ICsyODEsOSBAQCBzdGF0aWMgaW50IG10a19ydGNfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmVzID0gcGxhdGZvcm1fZ2V0X3Jl
c291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJcnRjLT5hZGRyX2Jhc2UgPSByZXMt
PnN0YXJ0Ow0KIA0KKwlydGMtPmRhdGEgPSAoc3RydWN0IG10a19ydGNfZGF0YSAqKQ0KKwkJCW9m
X2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCisNCiAJcnRjLT5pcnEgPSBwbGF0
Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KIAlpZiAocnRjLT5pcnEgPCAwKQ0KIAkJcmV0dXJuIHJ0
Yy0+aXJxOw0KQEAgLTMyNSwxMyArMzQwLDYgQEAgc3RhdGljIGludCBtdDYzOTdfcnRjX3Jlc3Vt
ZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogc3RhdGljIFNJTVBMRV9ERVZfUE1fT1BTKG10NjM5N19w
bV9vcHMsIG10NjM5N19ydGNfc3VzcGVuZCwNCiAJCQltdDYzOTdfcnRjX3Jlc3VtZSk7DQogDQot
c3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXQ2Mzk3X3J0Y19vZl9tYXRjaFtdID0g
ew0KLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjMyMy1ydGMiLCB9LA0KLQl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NjM5Ny1ydGMiLCB9LA0KLQl7IH0NCi19Ow0KLU1PRFVMRV9E
RVZJQ0VfVEFCTEUob2YsIG10NjM5N19ydGNfb2ZfbWF0Y2gpOw0KLQ0KIHN0YXRpYyBzdHJ1Y3Qg
cGxhdGZvcm1fZHJpdmVyIG10a19ydGNfZHJpdmVyID0gew0KIAkuZHJpdmVyID0gew0KIAkJLm5h
bWUgPSAibXQ2Mzk3LXJ0YyIsDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3
L3J0Yy5oIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQppbmRleCA3ZGZiNjNiLi4z
ZGM0OGU4IDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQorKysg
Yi9pbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvcnRjLmgNCkBAIC0xOCw3ICsxOCw5IEBADQogI2Rl
ZmluZSBSVENfQkJQVV9DQlVTWSAgICAgICAgIEJJVCg2KQ0KICNkZWZpbmUgUlRDX0JCUFVfS0VZ
ICAgICAgICAgICAgKDB4NDMgPDwgOCkNCiANCi0jZGVmaW5lIFJUQ19XUlRHUiAgICAgICAgICAg
ICAgMHgwMDNjDQorI2RlZmluZSBSVENfV1JUR1JfTVQ2MzU4ICAgICAgIDB4M2ENCisjZGVmaW5l
IFJUQ19XUlRHUl9NVDYzOTcgICAgICAgMHgzYw0KKyNkZWZpbmUgUlRDX1dSVEdSX01UNjMyMyAg
ICAgICBSVENfV1JUR1JfTVQ2Mzk3DQogDQogI2RlZmluZSBSVENfSVJRX1NUQSAgICAgICAgICAg
IDB4MDAwMg0KICNkZWZpbmUgUlRDX0lSUV9TVEFfQUwgICAgICAgICBCSVQoMCkNCkBAIC02NSw2
ICs2NywxMCBAQA0KICNkZWZpbmUgTVRLX1JUQ19QT0xMX0RFTEFZX1VTICAxMA0KICNkZWZpbmUg
TVRLX1JUQ19QT0xMX1RJTUVPVVQgICAoamlmZmllc190b191c2VjcyhIWikpDQogDQorc3RydWN0
IG10a19ydGNfZGF0YSB7DQorCXUzMgkJCXdydGdyOw0KK307DQorDQogc3RydWN0IG10NjM5N19y
dGMgew0KIAlzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAqZGV2Ow0KIAlzdHJ1Y3QgcnRjX2Rldmlj
ZSAgICAgICAqcnRjX2RldjsNCkBAIC03NCw2ICs4MCwxNSBAQCBzdHJ1Y3QgbXQ2Mzk3X3J0YyB7
DQogCXN0cnVjdCByZWdtYXAgICAgICAgICAgICpyZWdtYXA7DQogCWludCAgICAgICAgICAgICAg
ICAgICAgIGlycTsNCiAJdTMyICAgICAgICAgICAgICAgICAgICAgYWRkcl9iYXNlOw0KKwljb25z
dCBzdHJ1Y3QgbXRrX3J0Y19kYXRhICpkYXRhOw0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVj
dCBtdGtfcnRjX2RhdGEgbXQ2MzU4X3J0Y19kYXRhID0gew0KKwkud3J0Z3IgPSBSVENfV1JUR1Jf
TVQ2MzU4LA0KK307DQorDQorc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfcnRjX2RhdGEgbXQ2Mzk3
X3J0Y19kYXRhID0gew0KKwkud3J0Z3IgPSBSVENfV1JUR1JfTVQ2Mzk3LA0KIH07DQogDQogI2Vu
ZGlmIC8qIF9MSU5VWF9NRkRfTVQ2Mzk3X1JUQ19IXyAqLw0KLS0gDQoyLjYuNA0K

