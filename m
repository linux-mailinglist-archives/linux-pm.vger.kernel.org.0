Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521DA2859FA
	for <lists+linux-pm@lfdr.de>; Wed,  7 Oct 2020 09:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727807AbgJGHy6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Oct 2020 03:54:58 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58410 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727647AbgJGHyr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2020 03:54:47 -0400
X-UUID: 939b5591e98c4e3b9b67a18913127566-20201007
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=KYbU0fOLNGaNuX5Rmsinyp0aIQ8VMnZAixaqrXBXKaE=;
        b=ii9PNJjLAU4UyPmyVV7lK5MQAR+WDWxR95CbsEwRV/fzPwcneK9jVga0Z3btXxto7zPj+k9xitHvisqe0LgxIhcw2h942pvTxmvRVZaS0ojtK/CwLzDrbSduomzrf7NFXZevNCOM4lsSwyenjKnKz78x3KToDfGJXzfOGRFO8MQ=;
X-UUID: 939b5591e98c4e3b9b67a18913127566-20201007
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <michael.kao@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 240541855; Wed, 07 Oct 2020 15:54:41 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 7 Oct 2020 15:54:38 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Oct 2020 15:54:40 +0800
From:   Michael Kao <michael.kao@mediatek.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <srv_heupstream@mediatek.com>
CC:     Eduardo Valentin <edubezval@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <hsinyi@chromium.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Michael Kao <michael.kao@mediatek.com>
Subject: [PATCH 2/2] thermal: mediatek: add another get_temp ops for thermal sensors
Date:   Wed, 7 Oct 2020 15:54:37 +0800
Message-ID: <20201007075437.6002-4-michael.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201007075437.6002-1-michael.kao@mediatek.com>
References: <20201007075437.6002-1-michael.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
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
dGtfdGhlcm1hbC5jIHwgNzcgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0NCiAx
IGZpbGUgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdGhlcm1hbC9tdGtfdGhlcm1hbC5jIGIvZHJpdmVycy90aGVybWFsL210
a190aGVybWFsLmMNCmluZGV4IDBiZDdhYTU2NGJjMi4uYzYzOGE2OWJhNjMyIDEwMDY0NA0KLS0t
IGEvZHJpdmVycy90aGVybWFsL210a190aGVybWFsLmMNCisrKyBiL2RyaXZlcnMvdGhlcm1hbC9t
dGtfdGhlcm1hbC5jDQpAQCAtMjQ1LDYgKzI0NSwxMSBAQCBlbnVtIG10a190aGVybWFsX3ZlcnNp
b24gew0KIA0KIHN0cnVjdCBtdGtfdGhlcm1hbDsNCiANCitzdHJ1Y3QgbXRrX3RoZXJtYWxfem9u
ZSB7DQorCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQ7DQorCWludCBpZDsNCit9Ow0KKw0KIHN0cnVj
dCB0aGVybWFsX2JhbmtfY2ZnIHsNCiAJdW5zaWduZWQgaW50IG51bV9zZW5zb3JzOw0KIAljb25z
dCBpbnQgKnNlbnNvcnM7DQpAQCAtNjY4LDcgKzY3Myw3IEBAIHN0YXRpYyBpbnQgbXRrX3RoZXJt
YWxfYmFua190ZW1wZXJhdHVyZShzdHJ1Y3QgbXRrX3RoZXJtYWxfYmFuayAqYmFuaykNCiAJCSAq
IG5vdCBpbW1lZGlhdGVseSBzaHV0IGRvd24uDQogCQkgKi8NCiAJCWlmICh0ZW1wID4gMjAwMDAw
KQ0KLQkJCXRlbXAgPSAwOw0KKwkJCXRlbXAgPSAtRUFHQUlOOw0KIA0KIAkJaWYgKHRlbXAgPiBt
YXgpDQogCQkJbWF4ID0gdGVtcDsNCkBAIC02NzksNyArNjg0LDggQEAgc3RhdGljIGludCBtdGtf
dGhlcm1hbF9iYW5rX3RlbXBlcmF0dXJlKHN0cnVjdCBtdGtfdGhlcm1hbF9iYW5rICpiYW5rKQ0K
IA0KIHN0YXRpYyBpbnQgbXRrX3JlYWRfdGVtcCh2b2lkICpkYXRhLCBpbnQgKnRlbXBlcmF0dXJl
KQ0KIHsNCi0Jc3RydWN0IG10a190aGVybWFsICptdCA9IGRhdGE7DQorCXN0cnVjdCBtdGtfdGhl
cm1hbF96b25lICp0eiA9IGRhdGE7DQorCXN0cnVjdCBtdGtfdGhlcm1hbCAqbXQgPSB0ei0+bXQ7
DQogCWludCBpOw0KIAlpbnQgdGVtcG1heCA9IElOVF9NSU47DQogDQpAQCAtNjk4LDEwICs3MDQs
NDcgQEAgc3RhdGljIGludCBtdGtfcmVhZF90ZW1wKHZvaWQgKmRhdGEsIGludCAqdGVtcGVyYXR1
cmUpDQogCXJldHVybiAwOw0KIH0NCiANCitzdGF0aWMgaW50IG10a19yZWFkX3NlbnNvcl90ZW1w
KHZvaWQgKmRhdGEsIGludCAqdGVtcGVyYXR1cmUpDQorew0KKwlzdHJ1Y3QgbXRrX3RoZXJtYWxf
em9uZSAqdHogPSBkYXRhOw0KKwlzdHJ1Y3QgbXRrX3RoZXJtYWwgKm10ID0gdHotPm10Ow0KKwlj
b25zdCBzdHJ1Y3QgbXRrX3RoZXJtYWxfZGF0YSAqY29uZiA9IG10LT5jb25mOw0KKwlpbnQgaWQg
PSB0ei0+aWQgLSAxOw0KKwlpbnQgdGVtcCA9IElOVF9NSU47DQorCXUzMiByYXc7DQorDQorCWlm
IChpZCA8IDApDQorCQlyZXR1cm4gIC1FQUNDRVM7DQorDQorCXJhdyA9IHJlYWRsKG10LT50aGVy
bWFsX2Jhc2UgKyBjb25mLT5tc3JbaWRdKTsNCisNCisJaWYgKG10LT5jb25mLT52ZXJzaW9uID09
IE1US19USEVSTUFMX1YxKQ0KKwkJdGVtcCA9IHJhd190b19tY2Vsc2l1c192MShtdCwgaWQsIHJh
dyk7DQorCWVsc2UNCisJCXRlbXAgPSByYXdfdG9fbWNlbHNpdXNfdjIobXQsIGlkLCByYXcpOw0K
Kw0KKwkvKg0KKwkgKiBUaGUgZmlyc3QgcmVhZCBvZiBhIHNlbnNvciBvZnRlbiBjb250YWlucyB2
ZXJ5IGhpZ2ggYm9ndXMNCisJICogdGVtcGVyYXR1cmUgdmFsdWUuIEZpbHRlciB0aGVzZSBvdXQg
c28gdGhhdCB0aGUgc3lzdGVtIGRvZXMNCisJICogbm90IGltbWVkaWF0ZWx5IHNodXQgZG93bi4N
CisJICovDQorDQorCWlmICh0ZW1wID4gMjAwMDAwKQ0KKwkJcmV0dXJuICAtRUFHQUlOOw0KKw0K
KwkqdGVtcGVyYXR1cmUgPSB0ZW1wOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQogc3RhdGljIGNv
bnN0IHN0cnVjdCB0aGVybWFsX3pvbmVfb2ZfZGV2aWNlX29wcyBtdGtfdGhlcm1hbF9vcHMgPSB7
DQogCS5nZXRfdGVtcCA9IG10a19yZWFkX3RlbXAsDQogfTsNCiANCitzdGF0aWMgY29uc3Qgc3Ry
dWN0IHRoZXJtYWxfem9uZV9vZl9kZXZpY2Vfb3BzIG10a190aGVybWFsX3NlbnNvcl9vcHMgPSB7
DQorCS5nZXRfdGVtcCA9IG10a19yZWFkX3NlbnNvcl90ZW1wLA0KK307DQorDQogc3RhdGljIHZv
aWQgbXRrX3RoZXJtYWxfaW5pdF9iYW5rKHN0cnVjdCBtdGtfdGhlcm1hbCAqbXQsIGludCBudW0s
DQogCQkJCSAgdTMyIGFwbWl4ZWRfcGh5c19iYXNlLCB1MzIgYXV4YWRjX3BoeXNfYmFzZSwNCiAJ
CQkJICBpbnQgY3RybF9pZCkNCkBAIC05OTIsNiArMTAzNSw3IEBAIHN0YXRpYyBpbnQgbXRrX3Ro
ZXJtYWxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCiAJdTY0IGF1eGFkY19w
aHlzX2Jhc2UsIGFwbWl4ZWRfcGh5c19iYXNlOw0KIAlzdHJ1Y3QgdGhlcm1hbF96b25lX2Rldmlj
ZSAqdHpkZXY7DQogCXZvaWQgX19pb21lbSAqYXBtaXhlZF9iYXNlLCAqYXV4YWRjX2Jhc2U7DQor
CXN0cnVjdCBtdGtfdGhlcm1hbF96b25lICp0ejsNCiANCiAJbXQgPSBkZXZtX2t6YWxsb2MoJnBk
ZXYtPmRldiwgc2l6ZW9mKCptdCksIEdGUF9LRVJORUwpOw0KIAlpZiAoIW10KQ0KQEAgLTEwODAs
MTEgKzExMjQsMzAgQEAgc3RhdGljIGludCBtdGtfdGhlcm1hbF9wcm9iZShzdHJ1Y3QgcGxhdGZv
cm1fZGV2aWNlICpwZGV2KQ0KIA0KIAlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBtdCk7DQog
DQotCXR6ZGV2ID0gZGV2bV90aGVybWFsX3pvbmVfb2Zfc2Vuc29yX3JlZ2lzdGVyKCZwZGV2LT5k
ZXYsIDAsIG10LA0KLQkJCQkJCSAgICAgJm10a190aGVybWFsX29wcyk7DQotCWlmIChJU19FUlIo
dHpkZXYpKSB7DQotCQlyZXQgPSBQVFJfRVJSKHR6ZGV2KTsNCi0JCWdvdG8gZXJyX2Rpc2FibGVf
Y2xrX3BlcmlfdGhlcm07DQorCWZvciAoaSA9IDA7IGkgPCBtdC0+Y29uZi0+bnVtX3NlbnNvcnMg
KyAxOyBpKyspIHsNCisJCXR6ID0ga21hbGxvYyhzaXplb2YoKnR6KSwgR0ZQX0tFUk5FTCk7DQor
CQlpZiAoIXR6KQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KKw0KKwkJdHotPm10ID0gbXQ7DQorCQl0
ei0+aWQgPSBpOw0KKw0KKwkJdHpkZXYgPSBkZXZtX3RoZXJtYWxfem9uZV9vZl9zZW5zb3JfcmVn
aXN0ZXIoJnBkZXYtPmRldiwgaSwNCisJCQkJCQkJICAgICB0eiwgKGkgPT0gMCkgPw0KKwkJCQkm
bXRrX3RoZXJtYWxfb3BzIDogJm10a190aGVybWFsX3NlbnNvcl9vcHMpOw0KKw0KKwkJaWYgKElT
X0VSUih0emRldikpIHsNCisJCQlpZiAoUFRSX0VSUih0emRldikgPT0gLUVOT0RFVikgew0KKwkJ
CQlkZXZfd2FybigmcGRldi0+ZGV2LA0KKwkJCQkJICJzZW5zb3IgJWQgbm90IHJlZ2lzdGVyZWQg
aW4gdGhlcm1hbCB6b25lIGluIGR0XG4iLA0KKwkJCQkJIGkpOw0KKwkJCQljb250aW51ZTsNCisJ
CQl9DQorCQkJaWYgKFBUUl9FUlIodHpkZXYpID09IC1FQUNDRVMpIHsNCisJCQkJcmV0ID0gUFRS
X0VSUih0emRldik7DQorCQkJCWdvdG8gZXJyX2Rpc2FibGVfY2xrX3BlcmlfdGhlcm07DQorCQkJ
fQ0KKwkJfQ0KIAl9DQogDQogCXJldHVybiAwOw0KLS0gDQoyLjE4LjANCg==

