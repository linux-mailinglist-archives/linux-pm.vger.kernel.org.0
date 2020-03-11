Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 688AA181479
	for <lists+linux-pm@lfdr.de>; Wed, 11 Mar 2020 10:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgCKJRT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Mar 2020 05:17:19 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58454 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728726AbgCKJRS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 11 Mar 2020 05:17:18 -0400
X-UUID: c3adb646dbde463cb6e5e3dd86dfbe1f-20200311
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Mzsz3KCruejmaGRI59TsChdTHv2ZTb1K2CrUFLXr9fU=;
        b=QTKOlE5OXeXrPXwaukKH0Tv0lpTm2Ba53xAxucFFdsbDHU8b+egN3p2Dasf2y5qpAgNkNUvvoc6wYrYfUuGGr3bq462s7LfHu8wqySsqffRUMRSKg0qVOr20Z0Har6JjPnc5aDLELD66mqFLav6s2DWflRUBgQ/X8f8m+nwkkB0=;
X-UUID: c3adb646dbde463cb6e5e3dd86dfbe1f-20200311
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 770383864; Wed, 11 Mar 2020 17:17:12 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 11 Mar 2020 17:15:38 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 11 Mar 2020 17:17:13 +0800
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
Subject: [PATCH v10 4/5] rtc: mt6397: Add support for the MediaTek MT6358 RTC
Date:   Wed, 11 Mar 2020 17:17:02 +0800
Message-ID: <1583918223-22506-5-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1583918223-22506-1-git-send-email-hsin-hsiung.wang@mediatek.com>
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
LW10NjM5Ny5jICAgICAgICAgICAgICB8IDMyICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQogaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oICAgICAgICB8ICA5ICsrKysrKysr
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
bmRleCBjZGEyMzhkLi43YTVhOWUyIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9ydGMvcnRjLW10NjM5
Ny5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMtbXQ2Mzk3LmMNCkBAIC05LDE4ICs5LDM4IEBADQog
I2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzOTcvY29yZS5oPg0KICNpbmNsdWRlIDxsaW51eC9tb2R1
bGUuaD4NCiAjaW5jbHVkZSA8bGludXgvbXV0ZXguaD4NCisjaW5jbHVkZSA8bGludXgvb2ZfZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KICNpbmNsdWRlIDxs
aW51eC9yZWdtYXAuaD4NCiAjaW5jbHVkZSA8bGludXgvcnRjLmg+DQogI2luY2x1ZGUgPGxpbnV4
L21mZC9tdDYzOTcvcnRjLmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZF9kZXZpY2V0YWJsZS5oPg0K
IA0KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3J0Y19kYXRhIG10NjM1OF9ydGNfZGF0YSA9IHsN
CisJLndydGdyID0gUlRDX1dSVEdSX01UNjM1OCwNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1
Y3QgbXRrX3J0Y19kYXRhIG10NjM5N19ydGNfZGF0YSA9IHsNCisJLndydGdyID0gUlRDX1dSVEdS
X01UNjM5NywNCit9Ow0KKw0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10NjM5
N19ydGNfb2ZfbWF0Y2hbXSA9IHsNCisJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDYzMjMt
cnRjIiwNCisJCS5kYXRhID0gKHZvaWQgKikmbXQ2Mzk3X3J0Y19kYXRhLCB9LA0KKwl7IC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NjM1OC1ydGMiLA0KKwkJLmRhdGEgPSAodm9pZCAqKSZtdDYz
NThfcnRjX2RhdGEsIH0sDQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2Mzk3LXJ0YyIs
DQorCQkuZGF0YSA9ICh2b2lkICopJm10NjM5N19ydGNfZGF0YSwgfSwNCisJe30NCit9Ow0KK01P
RFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10NjM5N19ydGNfb2ZfbWF0Y2gpOw0KKw0KIHN0YXRpYyBp
bnQgbXRrX3J0Y193cml0ZV90cmlnZ2VyKHN0cnVjdCBtdDYzOTdfcnRjICpydGMpDQogew0KIAlp
bnQgcmV0Ow0KIAl1MzIgZGF0YTsNCiANCi0JcmV0ID0gcmVnbWFwX3dyaXRlKHJ0Yy0+cmVnbWFw
LCBydGMtPmFkZHJfYmFzZSArIFJUQ19XUlRHUiwgMSk7DQorCXJldCA9IHJlZ21hcF93cml0ZShy
dGMtPnJlZ21hcCwgcnRjLT5hZGRyX2Jhc2UgKyBydGMtPmRhdGEtPndydGdyLCAxKTsNCiAJaWYg
KHJldCA8IDApDQogCQlyZXR1cm4gcmV0Ow0KIA0KQEAgLTI2OSw2ICsyODksOSBAQCBzdGF0aWMg
aW50IG10a19ydGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJcmVzID0g
cGxhdGZvcm1fZ2V0X3Jlc291cmNlKHBkZXYsIElPUkVTT1VSQ0VfTUVNLCAwKTsNCiAJcnRjLT5h
ZGRyX2Jhc2UgPSByZXMtPnN0YXJ0Ow0KIA0KKwlydGMtPmRhdGEgPSAoc3RydWN0IG10a19ydGNf
ZGF0YSAqKQ0KKwkJCW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0YSgmcGRldi0+ZGV2KTsNCisNCiAJ
cnRjLT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOw0KIAlpZiAocnRjLT5pcnEgPCAw
KQ0KIAkJcmV0dXJuIHJ0Yy0+aXJxOw0KQEAgLTMyNSwxMyArMzQ4LDYgQEAgc3RhdGljIGludCBt
dDYzOTdfcnRjX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogc3RhdGljIFNJTVBMRV9ERVZf
UE1fT1BTKG10NjM5N19wbV9vcHMsIG10NjM5N19ydGNfc3VzcGVuZCwNCiAJCQltdDYzOTdfcnRj
X3Jlc3VtZSk7DQogDQotc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgbXQ2Mzk3X3J0
Y19vZl9tYXRjaFtdID0gew0KLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjMyMy1ydGMi
LCB9LA0KLQl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NjM5Ny1ydGMiLCB9LA0KLQl7IH0N
Ci19Ow0KLU1PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIG10NjM5N19ydGNfb2ZfbWF0Y2gpOw0KLQ0K
IHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVyIG10a19ydGNfZHJpdmVyID0gew0KIAkuZHJp
dmVyID0gew0KIAkJLm5hbWUgPSAibXQ2Mzk3LXJ0YyIsDQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9s
aW51eC9tZmQvbXQ2Mzk3L3J0Yy5oIGIvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQpp
bmRleCA3ZGZiNjNiLi42NjUzNGVkIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9tZmQvbXQ2
Mzk3L3J0Yy5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvcnRjLmgNCkBAIC0xOCw3
ICsxOCw5IEBADQogI2RlZmluZSBSVENfQkJQVV9DQlVTWSAgICAgICAgIEJJVCg2KQ0KICNkZWZp
bmUgUlRDX0JCUFVfS0VZICAgICAgICAgICAgKDB4NDMgPDwgOCkNCiANCi0jZGVmaW5lIFJUQ19X
UlRHUiAgICAgICAgICAgICAgMHgwMDNjDQorI2RlZmluZSBSVENfV1JUR1JfTVQ2MzU4ICAgICAg
IDB4M2ENCisjZGVmaW5lIFJUQ19XUlRHUl9NVDYzOTcgICAgICAgMHgzYw0KKyNkZWZpbmUgUlRD
X1dSVEdSX01UNjMyMyAgICAgICBSVENfV1JUR1JfTVQ2Mzk3DQogDQogI2RlZmluZSBSVENfSVJR
X1NUQSAgICAgICAgICAgIDB4MDAwMg0KICNkZWZpbmUgUlRDX0lSUV9TVEFfQUwgICAgICAgICBC
SVQoMCkNCkBAIC02NSw2ICs2NywxMCBAQA0KICNkZWZpbmUgTVRLX1JUQ19QT0xMX0RFTEFZX1VT
ICAxMA0KICNkZWZpbmUgTVRLX1JUQ19QT0xMX1RJTUVPVVQgICAoamlmZmllc190b191c2VjcyhI
WikpDQogDQorc3RydWN0IG10a19ydGNfZGF0YSB7DQorCXUzMgkJCXdydGdyOw0KK307DQorDQog
c3RydWN0IG10NjM5N19ydGMgew0KIAlzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAqZGV2Ow0KIAlz
dHJ1Y3QgcnRjX2RldmljZSAgICAgICAqcnRjX2RldjsNCkBAIC03NCw2ICs4MCw3IEBAIHN0cnVj
dCBtdDYzOTdfcnRjIHsNCiAJc3RydWN0IHJlZ21hcCAgICAgICAgICAgKnJlZ21hcDsNCiAJaW50
ICAgICAgICAgICAgICAgICAgICAgaXJxOw0KIAl1MzIgICAgICAgICAgICAgICAgICAgICBhZGRy
X2Jhc2U7DQorCWNvbnN0IHN0cnVjdCBtdGtfcnRjX2RhdGEgKmRhdGE7DQogfTsNCiANCiAjZW5k
aWYgLyogX0xJTlVYX01GRF9NVDYzOTdfUlRDX0hfICovDQotLSANCjIuNi40DQo=

