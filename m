Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D65F296B2A
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460548AbgJWIZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:25:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39521 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S460537AbgJWIZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:25:12 -0400
X-UUID: 8546ccb3dd9a4aabbb4c3beabb0f73bc-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=rCMbXAuODNB8y7MkCaQc2mt7ayxf9TpGQeinPyFrbEU=;
        b=GnQ6+fAVumYrFWqAkKKLjk9CLJtjVadZpNeJwhDfjYydGS1aZnF1QMeozaJX9Zw8G04Z+olQvmVI4ZSLOUD/SgZBmMYIwYtdwMtrXDd2w+51FZ+CsKgiRmveywJHUPVKTiwcRSVK5AXgj7pW/nx220aWyFUmeuNxb6q2mmRCYKc=;
X-UUID: 8546ccb3dd9a4aabbb4c3beabb0f73bc-20201023
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 436456902; Fri, 23 Oct 2020 16:25:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 16:24:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 16:24:59 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1 4/6] cpufreq: mediatek-hw: register EM power table
Date:   Fri, 23 Oct 2020 16:24:51 +0800
Message-ID: <1603441493-18554-5-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1492DA2F4D89FE5D46D7253A3B77EFCEF5EC965C4A22111D57C163518DC29DF22000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpSZWdpc3Rl
ciBlbmVyZ3kgbW9kZWwgdGFibGUgZm9yIEVBUyBhbmQgdGhlcm1hbCBjb29saW5nIGRldmljZSB1
c2FnZQ0KDQpTaWduZWQtb2ZmLWJ5OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyB8ICAgNTgg
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDQ2IGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9jcHVm
cmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyBiL2RyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVm
cmVxLWh3LmMNCmluZGV4IDc0NDQ5ZGEuLjI0MWQ5M2YgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL2Nw
dWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jDQorKysgYi9kcml2ZXJzL2NwdWZyZXEvbWVkaWF0
ZWstY3B1ZnJlcS1ody5jDQpAQCAtNSw2ICs1LDcgQEANCiANCiAjaW5jbHVkZSA8bGludXgvYml0
ZmllbGQuaD4NCiAjaW5jbHVkZSA8bGludXgvY3B1ZnJlcS5oPg0KKyNpbmNsdWRlIDxsaW51eC9l
bmVyZ3lfbW9kZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KICNpbmNsdWRlIDxsaW51
eC9rZXJuZWwuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQpAQCAtMTcsOSArMTgsMTAg
QEANCiAjZGVmaW5lIExVVF9ST1dfU0laRQkJCTB4NA0KIA0KIGVudW0gew0KLQlSRUdfTFVUX1RB
QkxFLA0KLQlSRUdfRU5BQkxFLA0KLQlSRUdfUEVSRl9TVEFURSwNCisJUkVHX0ZSRVFfTFVUX1RB
QkxFLA0KKwlSRUdfRlJFUV9FTkFCTEUsDQorCVJFR19GUkVRX1BFUkZfU1RBVEUsDQorCVJFR19F
TV9QT1dFUl9UQkwsDQogDQogCVJFR19BUlJBWV9TSVpFLA0KIH07DQpAQCAtMjcsMjMgKzI5LDQ0
IEBAIGVudW0gew0KIHN0cnVjdCBjcHVmcmVxX210ayB7DQogCXN0cnVjdCBjcHVmcmVxX2ZyZXF1
ZW5jeV90YWJsZSAqdGFibGU7DQogCXZvaWQgX19pb21lbSAqcmVnX2Jhc2VzW1JFR19BUlJBWV9T
SVpFXTsNCisJaW50IG5yX29wcDsNCiAJY3B1bWFza190IHJlbGF0ZWRfY3B1czsNCiB9Ow0KIA0K
IHN0YXRpYyBjb25zdCB1MTYgY3B1ZnJlcV9tdGtfb2Zmc2V0c1tSRUdfQVJSQVlfU0laRV0gPSB7
DQotCVtSRUdfTFVUX1RBQkxFXQkJPSAweDAsDQotCVtSRUdfRU5BQkxFXQkJPSAweDg0LA0KLQlb
UkVHX1BFUkZfU1RBVEVdCT0gMHg4OCwNCisJW1JFR19GUkVRX0xVVF9UQUJMRV0JPSAweDAsDQor
CVtSRUdfRlJFUV9FTkFCTEVdCT0gMHg4NCwNCisJW1JFR19GUkVRX1BFUkZfU1RBVEVdCT0gMHg4
OCwNCisJW1JFR19FTV9QT1dFUl9UQkxdCT0gMHgzRDAsDQogfTsNCiANCiBzdGF0aWMgc3RydWN0
IGNwdWZyZXFfbXRrICptdGtfZnJlcV9kb21haW5fbWFwW05SX0NQVVNdOw0KIA0KK3N0YXRpYyBp
bnQgbXRrX2NwdWZyZXFfZ2V0X2NwdV9wb3dlcih1bnNpZ25lZCBsb25nICptVywNCisJCQkJICAg
ICB1bnNpZ25lZCBsb25nICpLSHosIHN0cnVjdCBkZXZpY2UgKmNwdV9kZXYpDQorew0KKwlzdHJ1
Y3QgY3B1ZnJlcV9tdGsgKmMgPSBtdGtfZnJlcV9kb21haW5fbWFwW2NwdV9kZXYtPmlkXTsNCisJ
aW50IGk7DQorDQorCWZvciAoaSA9IDA7IGkgPCBjLT5ucl9vcHA7IGkrKykgew0KKwkJaWYgKGMt
PnRhYmxlW2ldLmZyZXF1ZW5jeSA8ICpLSHopDQorCQkJYnJlYWs7DQorCX0NCisJaS0tOw0KKw0K
KwkqS0h6ID0gYy0+dGFibGVbaV0uZnJlcXVlbmN5Ow0KKwkqbVcgPSByZWFkbF9yZWxheGVkKGMt
PnJlZ19iYXNlc1tSRUdfRU1fUE9XRVJfVEJMXSArDQorCQkJICAgIGkgKiBMVVRfUk9XX1NJWkUp
IC8gMTAwMDsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KIHN0YXRpYyBpbnQgbXRrX2NwdWZyZXFf
aHdfdGFyZ2V0X2luZGV4KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5LA0KIAkJCQkgICAg
ICAgdW5zaWduZWQgaW50IGluZGV4KQ0KIHsNCiAJc3RydWN0IGNwdWZyZXFfbXRrICpjID0gcG9s
aWN5LT5kcml2ZXJfZGF0YTsNCiANCi0Jd3JpdGVsX3JlbGF4ZWQoaW5kZXgsIGMtPnJlZ19iYXNl
c1tSRUdfUEVSRl9TVEFURV0pOw0KKwl3cml0ZWxfcmVsYXhlZChpbmRleCwgYy0+cmVnX2Jhc2Vz
W1JFR19GUkVRX1BFUkZfU1RBVEVdKTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTU1LDcgKzc4
LDcgQEAgc3RhdGljIHVuc2lnbmVkIGludCBtdGtfY3B1ZnJlcV9od19nZXQodW5zaWduZWQgaW50
IGNwdSkNCiANCiAJYyA9IG10a19mcmVxX2RvbWFpbl9tYXBbY3B1XTsNCiANCi0JaW5kZXggPSBy
ZWFkbF9yZWxheGVkKGMtPnJlZ19iYXNlc1tSRUdfUEVSRl9TVEFURV0pOw0KKwlpbmRleCA9IHJl
YWRsX3JlbGF4ZWQoYy0+cmVnX2Jhc2VzW1JFR19GUkVRX1BFUkZfU1RBVEVdKTsNCiAJaW5kZXgg
PSBtaW4oaW5kZXgsIExVVF9NQVhfRU5UUklFUyAtIDEpOw0KIA0KIAlyZXR1cm4gYy0+dGFibGVb
aW5kZXhdLmZyZXF1ZW5jeTsNCkBAIC02NCw2ICs4NywxNCBAQCBzdGF0aWMgdW5zaWduZWQgaW50
IG10a19jcHVmcmVxX2h3X2dldCh1bnNpZ25lZCBpbnQgY3B1KQ0KIHN0YXRpYyBpbnQgbXRrX2Nw
dWZyZXFfaHdfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFfcG9saWN5ICpwb2xpY3kpDQogew0KIAlz
dHJ1Y3QgY3B1ZnJlcV9tdGsgKmM7DQorCXN0cnVjdCBkZXZpY2UgKmNwdV9kZXY7DQorCXN0cnVj
dCBlbV9kYXRhX2NhbGxiYWNrIGVtX2NiID0gRU1fREFUQV9DQihtdGtfY3B1ZnJlcV9nZXRfY3B1
X3Bvd2VyKTsNCisNCisJY3B1X2RldiA9IGdldF9jcHVfZGV2aWNlKHBvbGljeS0+Y3B1KTsNCisJ
aWYgKCFjcHVfZGV2KSB7DQorCQlwcl9lcnIoImZhaWxlZCB0byBnZXQgY3B1JWQgZGV2aWNlXG4i
LCBwb2xpY3ktPmNwdSk7DQorCQlyZXR1cm4gLUVOT0RFVjsNCisJfQ0KIA0KIAljID0gbXRrX2Zy
ZXFfZG9tYWluX21hcFtwb2xpY3ktPmNwdV07DQogCWlmICghYykgew0KQEAgLTc3LDcgKzEwOCw5
IEBAIHN0YXRpYyBpbnQgbXRrX2NwdWZyZXFfaHdfY3B1X2luaXQoc3RydWN0IGNwdWZyZXFfcG9s
aWN5ICpwb2xpY3kpDQogCXBvbGljeS0+ZHJpdmVyX2RhdGEgPSBjOw0KIA0KIAkvKiBIVyBzaG91
bGQgYmUgaW4gZW5hYmxlZCBzdGF0ZSB0byBwcm9jZWVkIG5vdyAqLw0KLQl3cml0ZWxfcmVsYXhl
ZCgweDEsIGMtPnJlZ19iYXNlc1tSRUdfRU5BQkxFXSk7DQorCXdyaXRlbF9yZWxheGVkKDB4MSwg
Yy0+cmVnX2Jhc2VzW1JFR19GUkVRX0VOQUJMRV0pOw0KKw0KKwllbV9kZXZfcmVnaXN0ZXJfcGVy
Zl9kb21haW4oY3B1X2RldiwgYy0+bnJfb3BwLCAmZW1fY2IsIHBvbGljeS0+Y3B1cyk7DQogDQog
CXJldHVybiAwOw0KIH0NCkBAIC05Myw3ICsxMjYsNyBAQCBzdGF0aWMgaW50IG10a19jcHVmcmVx
X2h3X2NwdV9leGl0KHN0cnVjdCBjcHVmcmVxX3BvbGljeSAqcG9saWN5KQ0KIAl9DQogDQogCS8q
IEhXIHNob3VsZCBiZSBpbiBwYXVzZWQgc3RhdGUgbm93ICovDQotCXdyaXRlbF9yZWxheGVkKDB4
MCwgYy0+cmVnX2Jhc2VzW1JFR19FTkFCTEVdKTsNCisJd3JpdGVsX3JlbGF4ZWQoMHgwLCBjLT5y
ZWdfYmFzZXNbUkVHX0ZSRVFfRU5BQkxFXSk7DQogDQogCXJldHVybiAwOw0KIH0NCkBAIC0xMjIs
NyArMTU1LDcgQEAgc3RhdGljIGludCBtdGtfY3B1X2NyZWF0ZV9mcmVxX3RhYmxlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCWlmICghYy0+dGFibGUpDQogCQlyZXR1cm4gLUVOT01F
TTsNCiANCi0JYmFzZV90YWJsZSA9IGMtPnJlZ19iYXNlc1tSRUdfTFVUX1RBQkxFXTsNCisJYmFz
ZV90YWJsZSA9IGMtPnJlZ19iYXNlc1tSRUdfRlJFUV9MVVRfVEFCTEVdOw0KIA0KIAlmb3IgKGkg
PSAwOyBpIDwgTFVUX01BWF9FTlRSSUVTOyBpKyspIHsNCiAJCWRhdGEgPSByZWFkbF9yZWxheGVk
KGJhc2VfdGFibGUgKyAoaSAqIExVVF9ST1dfU0laRSkpOw0KQEAgLTE0MCw2ICsxNzMsNyBAQCBz
dGF0aWMgaW50IG10a19jcHVfY3JlYXRlX2ZyZXFfdGFibGUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiwNCiAJfQ0KIA0KIAljLT50YWJsZVtpXS5mcmVxdWVuY3kgPSBDUFVGUkVRX1RBQkxF
X0VORDsNCisJYy0+bnJfb3BwID0gaTsNCiANCiAJcmV0dXJuIDA7DQogfQ0KQEAgLTE5MSw3ICsy
MjUsNyBAQCBzdGF0aWMgaW50IG10a19jcHVfcmVzb3VyY2VzX2luaXQoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiwNCiAJaWYgKElTX0VSUihiYXNlKSkNCiAJCXJldHVybiBQVFJfRVJSKGJh
c2UpOw0KIA0KLQlmb3IgKGkgPSBSRUdfTFVUX1RBQkxFOyBpIDwgUkVHX0FSUkFZX1NJWkU7IGkr
KykNCisJZm9yIChpID0gUkVHX0ZSRVFfTFVUX1RBQkxFOyBpIDwgUkVHX0FSUkFZX1NJWkU7IGkr
KykNCiAJCWMtPnJlZ19iYXNlc1tpXSA9IGJhc2UgKyBvZmZzZXRzW2ldOw0KIA0KIAlyZXQgPSBt
dGtfZ2V0X3JlbGF0ZWRfY3B1cyhpbmRleCwgYyk7DQotLSANCjEuNy45LjUNCg==

