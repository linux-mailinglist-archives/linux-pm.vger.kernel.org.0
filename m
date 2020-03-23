Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8078518F434
	for <lists+linux-pm@lfdr.de>; Mon, 23 Mar 2020 13:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727608AbgCWMPr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 23 Mar 2020 08:15:47 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37010 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727384AbgCWMPr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Mar 2020 08:15:47 -0400
X-UUID: 10e5c13d7f7b4fa48d2ad273c04ace85-20200323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=6afKyor9AgACuTa8Oqf4MptvrGy9B10niDpAuK601p8=;
        b=Mrh0SgYK2mztGt3Sfq9lLr6Ow8t3HhXjV2eiphMsnsOwBoM1NKtuL4dOa9JWbT2T4Y1p7v2Wkl2DG9rKxt3EeglYhrR3qvMg5A5Ev8tEfVTWGzAdAHPL3P9WmEwWhfCuEdwDj9AvvziCX+DI6XThTO7AXV5IOHfe7XEBpjXjFqY=;
X-UUID: 10e5c13d7f7b4fa48d2ad273c04ace85-20200323
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2045009876; Mon, 23 Mar 2020 20:15:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 23 Mar 2020 20:15:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 23 Mar 2020 20:15:38 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, <hsinyi@chromium.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <michael.kao@mediatek.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [v4,6/7] thermal: mediatek: add another get_temp ops for thermal sensors
Date:   Mon, 23 Mar 2020 20:15:36 +0800
Message-ID: <20200323121537.22697-7-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200323121537.22697-1-michael.kao@mediatek.com>
References: <20200323121537.22697-1-michael.kao@mediatek.com>
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
dGhlIG5vZGUgL3N5cy9jbGFzcy90aGVybWFsLw0KDQpJbiBtdGtfdGhlcm1hbF9iYW5rX3RlbXBl
cmF0dXJlLCByZXR1cm4gLUVBR0FJTiBpbnN0ZWFkIG9mIC1FQUNDRVNTDQpvbiB0aGUgZmlyc3Qg
cmVhZCBvZiBzZW5zb3IgdGhhdCBvZnRlbiBhcmUgYm9ndXMgdmFsdWVzLg0KVGhpcyBjYW4gYXZv
aWQgZm9sbG93aW5nIHdhcm5pbmcgb24gYm9vdDoNCg0KICB0aGVybWFsIHRoZXJtYWxfem9uZTY6
IGZhaWxlZCB0byByZWFkIG91dCB0aGVybWFsIHpvbmUgKC0xMykNCg0KU2lnbmVkLW9mZi1ieTog
TWljaGFlbCBLYW8gPG1pY2hhZWwua2FvQG1lZGlhdGVrLmNvbT4NClNpZ25lZC1vZmYtYnk6IEhz
aW4tWWkgV2FuZyA8aHNpbnlpQGNocm9taXVtLm9yZz4NCi0tLQ0KIGRyaXZlcnMvdGhlcm1hbC9t
dGtfdGhlcm1hbC5jIHwgNzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgNjcgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jIGIvZHJpdmVycy90aGVybWFsL210
a190aGVybWFsLmMNCmluZGV4IDZiN2VmMTk5M2Q3ZS4uOWVhY2E0MzI5MjBlIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9t
dGtfdGhlcm1hbC5jDQpAQCAtMjI1LDYgKzIyNSwxMSBAQCBlbnVtIHsNCiANCiBzdHJ1Y3QgbXRr
X3RoZXJtYWw7DQogDQorc3RydWN0IG10a190aGVybWFsX3pvbmUgew0KKwlzdHJ1Y3QgbXRrX3Ro
ZXJtYWwgKm10Ow0KKwlpbnQgaWQ7DQorfTsNCisNCiBzdHJ1Y3QgdGhlcm1hbF9iYW5rX2NmZyB7
DQogCXVuc2lnbmVkIGludCBudW1fc2Vuc29yczsNCiAJY29uc3QgaW50ICpzZW5zb3JzOw0KQEAg
LTYwNyw3ICs2MTIsNyBAQCBzdGF0aWMgaW50IG10a190aGVybWFsX2JhbmtfdGVtcGVyYXR1cmUo
c3RydWN0IG10a190aGVybWFsX2JhbmsgKmJhbmspDQogCQkgKiBub3QgaW1tZWRpYXRlbHkgc2h1
dCBkb3duLg0KIAkJICovDQogCQlpZiAodGVtcCA+IDIwMDAwMCkNCi0JCQl0ZW1wID0gMDsNCisJ
CQl0ZW1wID0gLUVBR0FJTjsNCiANCiAJCWlmICh0ZW1wID4gbWF4KQ0KIAkJCW1heCA9IHRlbXA7
DQpAQCAtNjE4LDcgKzYyMyw4IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJtYWxfYmFua190ZW1wZXJh
dHVyZShzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFuayAqYmFuaykNCiANCiBzdGF0aWMgaW50IG10a19y
ZWFkX3RlbXAodm9pZCAqZGF0YSwgaW50ICp0ZW1wZXJhdHVyZSkNCiB7DQotCXN0cnVjdCBtdGtf
dGhlcm1hbCAqbXQgPSBkYXRhOw0KKwlzdHJ1Y3QgbXRrX3RoZXJtYWxfem9uZSAqdHogPSBkYXRh
Ow0KKwlzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10ID0gdHotPm10Ow0KIAlpbnQgaTsNCiAJaW50IHRl
bXBtYXggPSBJTlRfTUlOOw0KIA0KQEAgLTYzNywxMCArNjQzLDQ0IEBAIHN0YXRpYyBpbnQgbXRr
X3JlYWRfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXBlcmF0dXJlKQ0KIAlyZXR1cm4gMDsNCiB9
DQogDQorc3RhdGljIGludCBtdGtfcmVhZF9zZW5zb3JfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRl
bXBlcmF0dXJlKQ0KK3sNCisJc3RydWN0IG10a190aGVybWFsX3pvbmUgKnR6ID0gZGF0YTsNCisJ
c3RydWN0IG10a190aGVybWFsICptdCA9IHR6LT5tdDsNCisJY29uc3Qgc3RydWN0IG10a190aGVy
bWFsX2RhdGEgKmNvbmYgPSBtdC0+Y29uZjsNCisJaW50IGlkID0gdHotPmlkIC0gMTsNCisJaW50
IHRlbXAgPSBJTlRfTUlOOw0KKwl1MzIgcmF3Ow0KKw0KKwlpZiAoaWQgPCAwKQ0KKwkJcmV0dXJu
ICAtRUFDQ0VTOw0KKw0KKwlyYXcgPSByZWFkbChtdC0+dGhlcm1hbF9iYXNlICsgY29uZi0+bXNy
W2lkXSk7DQorDQorCXRlbXAgPSByYXdfdG9fbWNlbHNpdXMobXQsIGlkLCByYXcpOw0KKw0KKwkv
Kg0KKwkgKiBUaGUgZmlyc3QgcmVhZCBvZiBhIHNlbnNvciBvZnRlbiBjb250YWlucyB2ZXJ5IGhp
Z2ggYm9ndXMNCisJICogdGVtcGVyYXR1cmUgdmFsdWUuIEZpbHRlciB0aGVzZSBvdXQgc28gdGhh
dCB0aGUgc3lzdGVtIGRvZXMNCisJICogbm90IGltbWVkaWF0ZWx5IHNodXQgZG93bi4NCisJICov
DQorDQorCWlmICh0ZW1wID4gMjAwMDAwKQ0KKwkJcmV0dXJuICAtRUFHQUlOOw0KKw0KKwkqdGVt
cGVyYXR1cmUgPSB0ZW1wOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGNvbnN0IHN0
cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBtdGtfdGhlcm1hbF9vcHMgPSB7DQogCS5n
ZXRfdGVtcCA9IG10a19yZWFkX3RlbXAsDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3RydWN0IHRo
ZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIG10a190aGVybWFsX3NlbnNvcl9vcHMgPSB7DQorCS5n
ZXRfdGVtcCA9IG10a19yZWFkX3NlbnNvcl90ZW1wLA0KK307DQorDQogc3RhdGljIHZvaWQgbXRr
X3RoZXJtYWxfaW5pdF9iYW5rKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQsIGludCBudW0sDQogCQkJ
CSAgdTMyIGFwbWl4ZWRfcGh5c19iYXNlLCB1MzIgYXV4YWRjX3BoeXNfYmFzZSwNCiAJCQkJICBp
bnQgY3RybF9pZCkNCkBAIC04NzMsNiArOTEzLDcgQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9w
cm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIAlzdHJ1Y3QgcmVzb3VyY2UgKnJl
czsNCiAJdTY0IGF1eGFkY19waHlzX2Jhc2UsIGFwbWl4ZWRfcGh5c19iYXNlOw0KIAlzdHJ1Y3Qg
dGhlcm1hbF96b25lX2RldmljZSAqdHpkZXY7DQorCXN0cnVjdCBtdGtfdGhlcm1hbF96b25lICp0
ejsNCiANCiAJbXQgPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwgc2l6ZW9mKCptdCksIEdGUF9L
RVJORUwpOw0KIAlpZiAoIW10KQ0KQEAgLTk1NCwxMSArOTk1LDMwIEBAIHN0YXRpYyBpbnQgbXRr
X3RoZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiANCiAJcGxhdGZv
cm1fc2V0X2RydmRhdGEocGRldiwgbXQpOw0KIA0KLQl0emRldiA9IGRldm1fdGhlcm1hbF96b25l
X29mX3NlbnNvcl9yZWdpc3RlcigmcGRldi0+ZGV2LCAwLCBtdCwNCi0JCQkJCQkgICAgICZtdGtf
dGhlcm1hbF9vcHMpOw0KLQlpZiAoSVNfRVJSKHR6ZGV2KSkgew0KLQkJcmV0ID0gUFRSX0VSUih0
emRldik7DQotCQlnb3RvIGVycl9kaXNhYmxlX2Nsa19wZXJpX3RoZXJtOw0KKwlmb3IgKGkgPSAw
OyBpIDwgbXQtPmNvbmYtPm51bV9zZW5zb3JzICsgMTsgaSsrKSB7DQorCQl0eiA9IGttYWxsb2Mo
c2l6ZW9mKCp0eiksIEdGUF9LRVJORUwpOw0KKwkJaWYgKCF0eikNCisJCQlyZXR1cm4gLUVOT01F
TTsNCisNCisJCXR6LT5tdCA9IG10Ow0KKwkJdHotPmlkID0gaTsNCisNCisJCXR6ZGV2ID0gZGV2
bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKCZwZGV2LT5kZXYsIGksDQorCQkJCQkJ
CSAgICAgdHosIChpID09IDApID8NCisJCQkJJm10a190aGVybWFsX29wcyA6ICZtdGtfdGhlcm1h
bF9zZW5zb3Jfb3BzKTsNCisNCisJCWlmIChJU19FUlIodHpkZXYpKSB7DQorCQkJaWYgKFBUUl9F
UlIodHpkZXYpID09IC1FTk9ERVYpIHsNCisJCQkJZGV2X3dhcm4oJnBkZXYtPmRldiwNCisJCQkJ
CSAic2Vuc29yICVkIG5vdCByZWdpc3RlcmVkIGluIHRoZXJtYWwgem9uZSBpbiBkdFxuIiwNCisJ
CQkJCSBpKTsNCisJCQkJY29udGludWU7DQorCQkJfQ0KKwkJCWlmIChQVFJfRVJSKHR6ZGV2KSA9
PSAtRUFDQ0VTKSB7DQorCQkJCXJldCA9IFBUUl9FUlIodHpkZXYpOw0KKwkJCQlnb3RvIGVycl9k
aXNhYmxlX2Nsa19wZXJpX3RoZXJtOw0KKwkJCX0NCisJCX0NCiAJfQ0KIA0KIAlyZXR1cm4gMDsN
Ci0tIA0KMi4xOC4wDQo=

