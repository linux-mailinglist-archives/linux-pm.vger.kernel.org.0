Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A91801A1D37
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 10:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgDHINH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 04:13:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:9335 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727126AbgDHING (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 8 Apr 2020 04:13:06 -0400
X-UUID: 80a1dd2eae094e3a8d1ddd4796f34f7f-20200408
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=TjyXO64FwGcewaav1xdCD25JCQNflx0WEYbeMtOQFrs=;
        b=o7nH+WxDZRgr6zPAiTS3xvOEm7iuiYChzQybKJXmSVpyJ/rVsK3jZKmCMGuRV6wqcSbA4XaeGSOuN7DBTAEieI6MO106W1bGGCIZ1vlYUGaAEl9xc1SDJtfTVipmNpMoxQMBLSxkUSxyo9FBCNcIPVET+HZMs68G3v6+P57IPIY=;
X-UUID: 80a1dd2eae094e3a8d1ddd4796f34f7f-20200408
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 535684888; Wed, 08 Apr 2020 16:12:54 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 8 Apr 2020 16:12:50 +0800
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
Subject: [PATCH v12 5/6] rtc: mt6397: Add support for the MediaTek MT6358 RTC
Date:   Wed, 8 Apr 2020 16:12:10 +0800
Message-ID: <1586333531-21641-6-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1586333531-21641-1-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FC9E6D3D677BFECBC59AA698A2C0BFB58BD00BC5E746CB6D9F98117B906E7CC52000:8
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
ciB3aGljaCBvbmx5IG5lZWRlZCBieSBhcm12NyBDUFUgd2l0aG91dCBBVEYuDQoNClJldmlld2Vk
LWJ5OiBOaWNvbGFzIEJvaWNoYXQgPGRyaW5rY2F0QGNocm9taXVtLm9yZz4NClJldmlld2VkLWJ5
OiBZaW5nam9lIENoZW4gPHlpbmdqb2UuY2hlbkBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogQWxl
eGFuZHJlIEJlbGxvbmkgPGFsZXhhbmRyZS5iZWxsb25pQGJvb3RsaW4uY29tPg0KQWNrZWQtYnk6
IFNlYmFzdGlhbiBSZWljaGVsIDxzcmVAa2VybmVsLm9yZz4NClNpZ25lZC1vZmYtYnk6IFJhbiBC
aSA8cmFuLmJpQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IEhzaW4tSHNpdW5nIFdhbmcg
PGhzaW4taHNpdW5nLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9wb3dlci9yZXNl
dC9tdDYzMjMtcG93ZXJvZmYuYyB8ICAyICstDQogZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jICAg
ICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKy0tLQ0KIGluY2x1ZGUvbGludXgvbWZkL210
NjM5Ny9ydGMuaCAgICAgICAgfCAgOSArKysrKysrKy0NCiAzIGZpbGVzIGNoYW5nZWQsIDI0IGlu
c2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Bvd2Vy
L3Jlc2V0L210NjMyMy1wb3dlcm9mZi5jIGIvZHJpdmVycy9wb3dlci9yZXNldC9tdDYzMjMtcG93
ZXJvZmYuYw0KaW5kZXggMWNhZjQzZC4uMDUzMjgwMyAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcG93
ZXIvcmVzZXQvbXQ2MzIzLXBvd2Vyb2ZmLmMNCisrKyBiL2RyaXZlcnMvcG93ZXIvcmVzZXQvbXQ2
MzIzLXBvd2Vyb2ZmLmMNCkBAIC0zMCw3ICszMCw3IEBAIHN0YXRpYyB2b2lkIG10NjMyM19kb19w
d3JvZmYodm9pZCkNCiAJaW50IHJldDsNCiANCiAJcmVnbWFwX3dyaXRlKHB3cmMtPnJlZ21hcCwg
cHdyYy0+YmFzZSArIFJUQ19CQlBVLCBSVENfQkJQVV9LRVkpOw0KLQlyZWdtYXBfd3JpdGUocHdy
Yy0+cmVnbWFwLCBwd3JjLT5iYXNlICsgUlRDX1dSVEdSLCAxKTsNCisJcmVnbWFwX3dyaXRlKHB3
cmMtPnJlZ21hcCwgcHdyYy0+YmFzZSArIFJUQ19XUlRHUl9NVDYzMjMsIDEpOw0KIA0KIAlyZXQg
PSByZWdtYXBfcmVhZF9wb2xsX3RpbWVvdXQocHdyYy0+cmVnbWFwLA0KIAkJCQkJcHdyYy0+YmFz
ZSArIFJUQ19CQlBVLCB2YWwsDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5j
IGIvZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jDQppbmRleCBjZGEyMzhkLi5mOGIxMzUzIDEwMDY0
NA0KLS0tIGEvZHJpdmVycy9ydGMvcnRjLW10NjM5Ny5jDQorKysgYi9kcml2ZXJzL3J0Yy9ydGMt
bXQ2Mzk3LmMNCkBAIC05LDYgKzksNyBAQA0KICNpbmNsdWRlIDxsaW51eC9tZmQvbXQ2Mzk3L2Nv
cmUuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQogI2luY2x1ZGUgPGxpbnV4L211dGV4
Lmg+DQorI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51eC9wbGF0
Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQogI2luY2x1ZGUgPGxp
bnV4L3J0Yy5oPg0KQEAgLTIwLDcgKzIxLDcgQEAgc3RhdGljIGludCBtdGtfcnRjX3dyaXRlX3Ry
aWdnZXIoc3RydWN0IG10NjM5N19ydGMgKnJ0YykNCiAJaW50IHJldDsNCiAJdTMyIGRhdGE7DQog
DQotCXJldCA9IHJlZ21hcF93cml0ZShydGMtPnJlZ21hcCwgcnRjLT5hZGRyX2Jhc2UgKyBSVENf
V1JUR1IsIDEpOw0KKwlyZXQgPSByZWdtYXBfd3JpdGUocnRjLT5yZWdtYXAsIHJ0Yy0+YWRkcl9i
YXNlICsgcnRjLT5kYXRhLT53cnRnciwgMSk7DQogCWlmIChyZXQgPCAwKQ0KIAkJcmV0dXJuIHJl
dDsNCiANCkBAIC0yNjksNiArMjcwLDggQEAgc3RhdGljIGludCBtdGtfcnRjX3Byb2JlKHN0cnVj
dCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQogCXJlcyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShw
ZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQogCXJ0Yy0+YWRkcl9iYXNlID0gcmVzLT5zdGFydDsN
CiANCisJcnRjLT5kYXRhID0gb2ZfZGV2aWNlX2dldF9tYXRjaF9kYXRhKCZwZGV2LT5kZXYpOw0K
Kw0KIAlydGMtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQogCWlmIChydGMtPmly
cSA8IDApDQogCQlyZXR1cm4gcnRjLT5pcnE7DQpAQCAtMzI1LDkgKzMyOCwxOCBAQCBzdGF0aWMg
aW50IG10NjM5N19ydGNfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCiBzdGF0aWMgU0lNUExF
X0RFVl9QTV9PUFMobXQ2Mzk3X3BtX29wcywgbXQ2Mzk3X3J0Y19zdXNwZW5kLA0KIAkJCW10NjM5
N19ydGNfcmVzdW1lKTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IG10a19ydGNfZGF0YSBtdDYz
NThfcnRjX2RhdGEgPSB7DQorCS53cnRnciA9IFJUQ19XUlRHUl9NVDYzNTgsDQorfTsNCisNCitz
dGF0aWMgY29uc3Qgc3RydWN0IG10a19ydGNfZGF0YSBtdDYzOTdfcnRjX2RhdGEgPSB7DQorCS53
cnRnciA9IFJUQ19XUlRHUl9NVDYzOTcsDQorfTsNCisNCiBzdGF0aWMgY29uc3Qgc3RydWN0IG9m
X2RldmljZV9pZCBtdDYzOTdfcnRjX29mX21hdGNoW10gPSB7DQotCXsgLmNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ2MzIzLXJ0YyIsIH0sDQotCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2
Mzk3LXJ0YyIsIH0sDQorCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ2MzIzLXJ0YyIsIC5k
YXRhID0gJm10NjM5N19ydGNfZGF0YSB9LA0KKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
NjM1OC1ydGMiLCAuZGF0YSA9ICZtdDYzNThfcnRjX2RhdGEgfSwNCisJeyAuY29tcGF0aWJsZSA9
ICJtZWRpYXRlayxtdDYzOTctcnRjIiwgLmRhdGEgPSAmbXQ2Mzk3X3J0Y19kYXRhIH0sDQogCXsg
fQ0KIH07DQogTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgbXQ2Mzk3X3J0Y19vZl9tYXRjaCk7DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oIGIvaW5jbHVkZS9saW51
eC9tZmQvbXQ2Mzk3L3J0Yy5oDQppbmRleCA3ZGZiNjNiLi42MjAwZjNiIDEwMDY0NA0KLS0tIGEv
aW5jbHVkZS9saW51eC9tZmQvbXQ2Mzk3L3J0Yy5oDQorKysgYi9pbmNsdWRlL2xpbnV4L21mZC9t
dDYzOTcvcnRjLmgNCkBAIC0xOCw3ICsxOCw5IEBADQogI2RlZmluZSBSVENfQkJQVV9DQlVTWSAg
ICAgICAgIEJJVCg2KQ0KICNkZWZpbmUgUlRDX0JCUFVfS0VZICAgICAgICAgICAgKDB4NDMgPDwg
OCkNCiANCi0jZGVmaW5lIFJUQ19XUlRHUiAgICAgICAgICAgICAgMHgwMDNjDQorI2RlZmluZSBS
VENfV1JUR1JfTVQ2MzU4ICAgICAgIDB4M2ENCisjZGVmaW5lIFJUQ19XUlRHUl9NVDYzOTcgICAg
ICAgMHgzYw0KKyNkZWZpbmUgUlRDX1dSVEdSX01UNjMyMyAgICAgICBSVENfV1JUR1JfTVQ2Mzk3
DQogDQogI2RlZmluZSBSVENfSVJRX1NUQSAgICAgICAgICAgIDB4MDAwMg0KICNkZWZpbmUgUlRD
X0lSUV9TVEFfQUwgICAgICAgICBCSVQoMCkNCkBAIC02NSw2ICs2NywxMCBAQA0KICNkZWZpbmUg
TVRLX1JUQ19QT0xMX0RFTEFZX1VTICAxMA0KICNkZWZpbmUgTVRLX1JUQ19QT0xMX1RJTUVPVVQg
ICAoamlmZmllc190b191c2VjcyhIWikpDQogDQorc3RydWN0IG10a19ydGNfZGF0YSB7DQorCXUz
MiAgICAgICAgICAgICAgICAgICAgIHdydGdyOw0KK307DQorDQogc3RydWN0IG10NjM5N19ydGMg
ew0KIAlzdHJ1Y3QgZGV2aWNlICAgICAgICAgICAqZGV2Ow0KIAlzdHJ1Y3QgcnRjX2RldmljZSAg
ICAgICAqcnRjX2RldjsNCkBAIC03NCw2ICs4MCw3IEBAIHN0cnVjdCBtdDYzOTdfcnRjIHsNCiAJ
c3RydWN0IHJlZ21hcCAgICAgICAgICAgKnJlZ21hcDsNCiAJaW50ICAgICAgICAgICAgICAgICAg
ICAgaXJxOw0KIAl1MzIgICAgICAgICAgICAgICAgICAgICBhZGRyX2Jhc2U7DQorCWNvbnN0IHN0
cnVjdCBtdGtfcnRjX2RhdGEgKmRhdGE7DQogfTsNCiANCiAjZW5kaWYgLyogX0xJTlVYX01GRF9N
VDYzOTdfUlRDX0hfICovDQotLSANCjIuNi40DQo=

