Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC11712F4AB
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 07:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgACGoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Jan 2020 01:44:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:62118 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726180AbgACGoR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jan 2020 01:44:17 -0500
X-UUID: 218839f4868f4a36a440e08c7b5ac2a6-20200103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nZu5Vg6KMNlzJgVAxVNPrImqFUM2QdXibq/TjqkgBuo=;
        b=a5u2SUABpErw+Z3MiXyeTKhfpmQ8l83pcyM/AAGPQx2foGxH8WoivR52CXmHdN2QidfbvAsxwRgaK1/AmLlEv8XJC07879w1XG43Lz4zzeS0W9zLbSLh1NxFNtoDFaqWPGWE8sys54B4LnQ1lIF9nbbsBbL7A8n0sl1SrWq7HSU=;
X-UUID: 218839f4868f4a36a440e08c7b5ac2a6-20200103
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1556896153; Fri, 03 Jan 2020 14:44:11 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 3 Jan 2020 14:43:44 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 3 Jan 2020 14:44:09 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH v3,7/8] thermal: mediatek: add another get_temp ops for thermal sensors
Date:   Fri, 3 Jan 2020 14:44:06 +0800
Message-ID: <20200103064407.19861-8-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200103064407.19861-1-michael.kao@mediatek.com>
References: <20200103064407.19861-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

UHJvdmlkZSB0aGVybWFsIHpvbmUgdG8gcmVhZCB0aGVybWFsIHNlbnNvcg0KaW4gdGhlIFNvQy4g
V2UgY2FuIHJlYWQgYWxsIHRoZSB0aGVybWFsIHNlbnNvcnMNCnZhbHVlIGluIHRoZSBTb0MgYnkg
dGhlIG5vZGUgL3N5cy9jbGFzcy90aGVybWFsLw0KDQpCeXBhc3MgdGhlIGZhaWx1cmUgdGhhdCBu
b24gY3B1X3RoZXJtYWwgc2Vuc29yIGlzIG5vdCBmaW5kIGluIHRoZXJtYWwtem9uZXMNCmluIGR0
cywgd2hpY2ggaXMgbm9ybWFsIGZvciBtdDgxNzMsIHNvIHByb21wdCBhIHdhcm5pbmcgaGVyZSBp
bnN0ZWFkIG9mDQpmYWlsaW5nLg0KDQpSZXR1cm4gLUVBR0FJTiBpbnN0ZWFkIG9mIC1FQUNDRVNT
IG9uIHRoZSBmaXJzdCByZWFkIG9mIHNlbnNvciB0aGF0DQpvZnRlbiBhcmUgYm9ndXMgdmFsdWVz
LiBUaGlzIGNhbiBhdm9pZCBmb2xsb3dpbmcgd2FybmluZyBvbiBib290Og0KDQogIHRoZXJtYWwg
dGhlcm1hbF96b25lNjogZmFpbGVkIHRvIHJlYWQgb3V0IHRoZXJtYWwgem9uZSAoLTEzKQ0KDQpT
aWduZWQtb2ZmLWJ5OiBNaWNoYWVsIEthbyA8bWljaGFlbC5rYW9AbWVkaWF0ZWsuY29tPg0KU2ln
bmVkLW9mZi1ieTogSHNpbi1ZaSBXYW5nIDxoc2lueWlAY2hyb21pdW0ub3JnPg0KLS0tDQogZHJp
dmVycy90aGVybWFsL210a190aGVybWFsLmMgfCA3NCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9u
cygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMgYi9kcml2
ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KaW5kZXggZDZmYWJkMGE3ZGE2Li45YmU5ZmNiMThk
OWUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3RoZXJtYWwvbXRrX3RoZXJtYWwuYw0KKysrIGIvZHJp
dmVycy90aGVybWFsL210a190aGVybWFsLmMNCkBAIC0yMjUsNiArMjI1LDExIEBAIGVudW0gew0K
IA0KIHN0cnVjdCBtdGtfdGhlcm1hbDsNCiANCitzdHJ1Y3QgbXRrX3RoZXJtYWxfem9uZSB7DQor
CXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQ7DQorCWludCBpZDsNCit9Ow0KKw0KIHN0cnVjdCB0aGVy
bWFsX2JhbmtfY2ZnIHsNCiAJdW5zaWduZWQgaW50IG51bV9zZW5zb3JzOw0KIAljb25zdCBpbnQg
KnNlbnNvcnM7DQpAQCAtNjA3LDcgKzYxMiw3IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfYmFu
a190ZW1wZXJhdHVyZShzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFuayAqYmFuaykNCiAJCSAqIG5vdCBp
bW1lZGlhdGVseSBzaHV0IGRvd24uDQogCQkgKi8NCiAJCWlmICh0ZW1wID4gMjAwMDAwKQ0KLQkJ
CXRlbXAgPSAwOw0KKwkJCXRlbXAgPSAtRUFHQUlOOw0KIA0KIAkJaWYgKHRlbXAgPiBtYXgpDQog
CQkJbWF4ID0gdGVtcDsNCkBAIC02MTgsNyArNjIzLDggQEAgc3RhdGljIGludCBtdGtfdGhlcm1h
bF9iYW5rX3RlbXBlcmF0dXJlKHN0cnVjdCBtdGtfdGhlcm1hbF9iYW5rICpiYW5rKQ0KIA0KIHN0
YXRpYyBpbnQgbXRrX3JlYWRfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXBlcmF0dXJlKQ0KIHsN
Ci0Jc3RydWN0IG10a190aGVybWFsICptdCA9IGRhdGE7DQorCXN0cnVjdCBtdGtfdGhlcm1hbF96
b25lICp0eiA9IGRhdGE7DQorCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQgPSB0ei0+bXQ7DQogCWlu
dCBpOw0KIAlpbnQgdGVtcG1heCA9IElOVF9NSU47DQogDQpAQCAtNjMxLDE2ICs2MzcsNDggQEAg
c3RhdGljIGludCBtdGtfcmVhZF90ZW1wKHZvaWQgKmRhdGEsIGludCAqdGVtcGVyYXR1cmUpDQog
DQogCQltdGtfdGhlcm1hbF9wdXRfYmFuayhiYW5rKTsNCiAJfQ0KLQ0KIAkqdGVtcGVyYXR1cmUg
PSB0ZW1wbWF4Ow0KIA0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIGludCBtdGtfcmVhZF9z
ZW5zb3JfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXBlcmF0dXJlKQ0KK3sNCisJc3RydWN0IG10
a190aGVybWFsX3pvbmUgKnR6ID0gZGF0YTsNCisJc3RydWN0IG10a190aGVybWFsICptdCA9IHR6
LT5tdDsNCisJY29uc3Qgc3RydWN0IG10a190aGVybWFsX2RhdGEgKmNvbmYgPSBtdC0+Y29uZjsN
CisJaW50IGlkID0gdHotPmlkIC0gMTsNCisJaW50IHRlbXAgPSBJTlRfTUlOOw0KKwl1MzIgcmF3
Ow0KKw0KKwlpZiAoaWQgPCAwKQ0KKwkJcmV0dXJuICAtRUFDQ0VTOw0KKw0KKwlyYXcgPSByZWFk
bChtdC0+dGhlcm1hbF9iYXNlICsgY29uZi0+bXNyW2lkXSk7DQorDQorCXRlbXAgPSByYXdfdG9f
bWNlbHNpdXMobXQsIGlkLCByYXcpOw0KKw0KKwkvKg0KKwkgKiBUaGUgZmlyc3QgcmVhZCBvZiBh
IHNlbnNvciBvZnRlbiBjb250YWlucyB2ZXJ5IGhpZ2ggYm9ndXMNCisJICogdGVtcGVyYXR1cmUg
dmFsdWUuIEZpbHRlciB0aGVzZSBvdXQgc28gdGhhdCB0aGUgc3lzdGVtIGRvZXMNCisJICogbm90
IGltbWVkaWF0ZWx5IHNodXQgZG93bi4NCisJICovDQorDQorCWlmICh0ZW1wID4gMjAwMDAwKQ0K
KwkJcmV0dXJuICAtRUFHQUlOOw0KKw0KKwkqdGVtcGVyYXR1cmUgPSB0ZW1wOw0KKwlyZXR1cm4g
MDsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29w
cyBtdGtfdGhlcm1hbF9vcHMgPSB7DQogCS5nZXRfdGVtcCA9IG10a19yZWFkX3RlbXAsDQogfTsN
CiANCitzdGF0aWMgY29uc3Qgc3RydWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIG10a190
aGVybWFsX3NlbnNvcl9vcHMgPSB7DQorCS5nZXRfdGVtcCA9IG10a19yZWFkX3NlbnNvcl90ZW1w
LA0KK307DQorDQogc3RhdGljIHZvaWQgbXRrX3RoZXJtYWxfaW5pdF9iYW5rKHN0cnVjdCBtdGtf
dGhlcm1hbCAqbXQsIGludCBudW0sDQogCQkJCSAgdTMyIGFwbWl4ZWRfcGh5c19iYXNlLCB1MzIg
YXV4YWRjX3BoeXNfYmFzZSwNCiAJCQkJICBpbnQgY3RybF9pZCkNCkBAIC04NzMsNiArOTExLDcg
QEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlczsNCiAJdTY0IGF1eGFkY19waHlzX2Jhc2UsIGFw
bWl4ZWRfcGh5c19iYXNlOw0KIAlzdHJ1Y3QgdGhlcm1hbF96b25lX2RldmljZSAqdHpkZXY7DQor
CXN0cnVjdCBtdGtfdGhlcm1hbF96b25lICp0ejsNCiANCiAJbXQgPSBkZXZtX2t6YWxsb2MoJnBk
ZXYtPmRldiwgc2l6ZW9mKCptdCksIEdGUF9LRVJORUwpOw0KIAlpZiAoIW10KQ0KQEAgLTk1NCwx
MSArOTkzLDMwIEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldikNCiANCiAJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgbXQpOw0KIA0K
LQl0emRldiA9IGRldm1fdGhlcm1hbF96b25lX29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2
LCAwLCBtdCwNCi0JCQkJCQkgICAgICZtdGtfdGhlcm1hbF9vcHMpOw0KLQlpZiAoSVNfRVJSKHR6
ZGV2KSkgew0KLQkJcmV0ID0gUFRSX0VSUih0emRldik7DQotCQlnb3RvIGVycl9kaXNhYmxlX2Ns
a19wZXJpX3RoZXJtOw0KKwlmb3IgKGkgPSAwOyBpIDwgbXQtPmNvbmYtPm51bV9zZW5zb3JzICsg
MTsgaSsrKSB7DQorCQl0eiA9IGttYWxsb2Moc2l6ZW9mKCp0eiksIEdGUF9LRVJORUwpOw0KKwkJ
aWYgKCF0eikNCisJCQlyZXR1cm4gLUVOT01FTTsNCisNCisJCXR6LT5tdCA9IG10Ow0KKwkJdHot
PmlkID0gaTsNCisNCisJCXR6ZGV2ID0gZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lz
dGVyKCZwZGV2LT5kZXYsIGksDQorCQkJCXR6LCAoaSA9PSAwKSA/DQorCQkJCSZtdGtfdGhlcm1h
bF9vcHMgOiAmbXRrX3RoZXJtYWxfc2Vuc29yX29wcyk7DQorDQorCQlpZiAoSVNfRVJSKHR6ZGV2
KSkgew0KKwkJCWlmIChQVFJfRVJSKHR6ZGV2KSA9PSAtRU5PREVWKSB7DQorCQkJCWRldl93YXJu
KCZwZGV2LT5kZXYsDQorCQkJCQkic2Vuc29yICVkIG5vdCByZWdpc3RlcmVkIGluIHRoZXJtYWwg
em9uZSBpbiBkdFxuIiwNCisJCQkJCWkpOw0KKwkJCQljb250aW51ZTsNCisJCQl9DQorCQkJaWYg
KElTX0VSUih0emRldikgIT0gLUVBQ0NFUykgew0KKwkJCQlyZXQgPSBQVFJfRVJSKHR6ZGV2KTsN
CisJCQkJZ290byBlcnJfZGlzYWJsZV9jbGtfcGVyaV90aGVybTsNCisJCQl9DQorCQl9DQogCX0N
CiANCiAJcmV0dXJuIDA7DQotLSANCjIuMTguMA0K

