Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6241B1C44
	for <lists+linux-pm@lfdr.de>; Tue, 21 Apr 2020 05:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgDUDA2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 20 Apr 2020 23:00:28 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3503 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726801AbgDUDA0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Apr 2020 23:00:26 -0400
X-UUID: 488896d5c454445c8b22fc2646c6c6a5-20200421
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DxwUIh59l4BK7Z3Cu0IhKqqer070y2Op68ePjcw0Jbc=;
        b=dhHGNoNu6el/Kj7xMWIS20itRhcDK7qehzeQSHi4apUSWO4SjbEYMmqqbkRuPOMbmyvtgGP36EVXfKCuQTZn6LPsQmVLUXl+Z9j8ztMJig8Aivgt6CGe18pKO9wQs01W+CSIT+RCVzYXXN+4cjYoO8Oqj2xnxXx8hGULyebk8C0=;
X-UUID: 488896d5c454445c8b22fc2646c6c6a5-20200421
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hsin-hsiung.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 757059187; Tue, 21 Apr 2020 11:00:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 21 Apr 2020 11:00:13 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 21 Apr 2020 11:00:12 +0800
From:   Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     <drinkcat@chromium.org>, Sean Wang <sean.wang@mediatek.com>,
        Sebastian Reichel <sre@kernel.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Frank Wunderlich <frank-w@public-files.de>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Josef Friedl <josef.friedl@speed.at>,
        Richard Fontana <rfontana@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ran Bi <ran.bi@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <srv_heupstream@mediatek.com>
Subject: [PATCH v13 1/6] mfd: mt6397: Modify suspend/resume behavior
Date:   Tue, 21 Apr 2020 11:00:07 +0800
Message-ID: <1587438012-24832-2-git-send-email-hsin-hsiung.wang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
References: <1587438012-24832-1-git-send-email-hsin-hsiung.wang@mediatek.com>
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
L210NjM5Ny1pcnEuYyAgICAgICAgfCAzNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLQ0KIGluY2x1ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmggfCAgMiArKw0KIDMgZmlsZXMg
Y2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMzEgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQg
YS9kcml2ZXJzL21mZC9tdDYzOTctY29yZS5jIGIvZHJpdmVycy9tZmQvbXQ2Mzk3LWNvcmUuYw0K
aW5kZXggMDQzN2M4NS4uZDJlNzBkOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvbWZkL210NjM5Ny1j
b3JlLmMNCisrKyBiL2RyaXZlcnMvbWZkL210NjM5Ny1jb3JlLmMNCkBAIC0xMDAsMzUgKzEwMCw2
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbWZkX2NlbGwgbXQ2Mzk3X2RldnNbXSA9IHsNCiAJfQ0K
IH07DQogDQotI2lmZGVmIENPTkZJR19QTV9TTEVFUA0KLXN0YXRpYyBpbnQgbXQ2Mzk3X2lycV9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikNCi17DQotCXN0cnVjdCBtdDYzOTdfY2hpcCAqY2hp
cCA9IGRldl9nZXRfZHJ2ZGF0YShkZXYpOw0KLQ0KLQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFw
LCBjaGlwLT5pbnRfY29uWzBdLCBjaGlwLT53YWtlX21hc2tbMF0pOw0KLQlyZWdtYXBfd3JpdGUo
Y2hpcC0+cmVnbWFwLCBjaGlwLT5pbnRfY29uWzFdLCBjaGlwLT53YWtlX21hc2tbMV0pOw0KLQ0K
LQllbmFibGVfaXJxX3dha2UoY2hpcC0+aXJxKTsNCi0NCi0JcmV0dXJuIDA7DQotfQ0KLQ0KLXN0
YXRpYyBpbnQgbXQ2Mzk3X2lycV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KLXsNCi0Jc3Ry
dWN0IG10NjM5N19jaGlwICpjaGlwID0gZGV2X2dldF9kcnZkYXRhKGRldik7DQotDQotCXJlZ21h
cF93cml0ZShjaGlwLT5yZWdtYXAsIGNoaXAtPmludF9jb25bMF0sIGNoaXAtPmlycV9tYXNrc19j
dXJbMF0pOw0KLQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFwLCBjaGlwLT5pbnRfY29uWzFdLCBj
aGlwLT5pcnFfbWFza3NfY3VyWzFdKTsNCi0NCi0JZGlzYWJsZV9pcnFfd2FrZShjaGlwLT5pcnEp
Ow0KLQ0KLQlyZXR1cm4gMDsNCi19DQotI2VuZGlmDQotDQotc3RhdGljIFNJTVBMRV9ERVZfUE1f
T1BTKG10NjM5N19wbV9vcHMsIG10NjM5N19pcnFfc3VzcGVuZCwNCi0JCQltdDYzOTdfaXJxX3Jl
c3VtZSk7DQotDQogc3RydWN0IGNoaXBfZGF0YSB7DQogCXUzMiBjaWRfYWRkcjsNCiAJdTMyIGNp
ZF9zaGlmdDsNCkBAIC0yMzgsNyArMjA5LDYgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2
ZXIgbXQ2Mzk3X2RyaXZlciA9IHsNCiAJLmRyaXZlciA9IHsNCiAJCS5uYW1lID0gIm10NjM5NyIs
DQogCQkub2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIobXQ2Mzk3X29mX21hdGNoKSwNCi0J
CS5wbSA9ICZtdDYzOTdfcG1fb3BzLA0KIAl9LA0KIAkuaWRfdGFibGUgPSBtdDYzOTdfaWQsDQog
fTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL21mZC9tdDYzOTctaXJxLmMgYi9kcml2ZXJzL21mZC9t
dDYzOTctaXJxLmMNCmluZGV4IGIyZDNjZTEuLjI5MjQ5MTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJz
L21mZC9tdDYzOTctaXJxLmMNCisrKyBiL2RyaXZlcnMvbWZkL210NjM5Ny1pcnEuYw0KQEAgLTks
NiArOSw3IEBADQogI2luY2x1ZGUgPGxpbnV4L29mX2lycS5oPg0KICNpbmNsdWRlIDxsaW51eC9w
bGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+DQorI2luY2x1ZGUg
PGxpbnV4L3N1c3BlbmQuaD4NCiAjaW5jbHVkZSA8bGludXgvbWZkL210NjMyMy9jb3JlLmg+DQog
I2luY2x1ZGUgPGxpbnV4L21mZC9tdDYzMjMvcmVnaXN0ZXJzLmg+DQogI2luY2x1ZGUgPGxpbnV4
L21mZC9tdDYzOTcvY29yZS5oPg0KQEAgLTgxLDcgKzgyLDcgQEAgc3RhdGljIHN0cnVjdCBpcnFf
Y2hpcCBtdDYzOTdfaXJxX2NoaXAgPSB7DQogc3RhdGljIHZvaWQgbXQ2Mzk3X2lycV9oYW5kbGVf
cmVnKHN0cnVjdCBtdDYzOTdfY2hpcCAqbXQ2Mzk3LCBpbnQgcmVnLA0KIAkJCQkgIGludCBpcnFi
YXNlKQ0KIHsNCi0JdW5zaWduZWQgaW50IHN0YXR1czsNCisJdW5zaWduZWQgaW50IHN0YXR1cyA9
IDA7DQogCWludCBpLCBpcnEsIHJldDsNCiANCiAJcmV0ID0gcmVnbWFwX3JlYWQobXQ2Mzk3LT5y
ZWdtYXAsIHJlZywgJnN0YXR1cyk7DQpAQCAtMTI4LDYgKzEyOSwzNiBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGlycV9kb21haW5fb3BzIG10NjM5N19pcnFfZG9tYWluX29wcyA9IHsNCiAJLm1hcCA9
IG10NjM5N19pcnFfZG9tYWluX21hcCwNCiB9Ow0KIA0KK3N0YXRpYyBpbnQgbXQ2Mzk3X2lycV9w
bV9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5vdGlmaWVyLA0KKwkJCQkgIHVuc2ln
bmVkIGxvbmcgcG1fZXZlbnQsIHZvaWQgKnVudXNlZCkNCit7DQorCXN0cnVjdCBtdDYzOTdfY2hp
cCAqY2hpcCA9DQorCQljb250YWluZXJfb2Yobm90aWZpZXIsIHN0cnVjdCBtdDYzOTdfY2hpcCwg
cG1fbmIpOw0KKw0KKwlzd2l0Y2ggKHBtX2V2ZW50KSB7DQorCWNhc2UgUE1fU1VTUEVORF9QUkVQ
QVJFOg0KKwkJcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwNCisJCQkgICAgIGNoaXAtPmludF9j
b25bMF0sIGNoaXAtPndha2VfbWFza1swXSk7DQorCQlyZWdtYXBfd3JpdGUoY2hpcC0+cmVnbWFw
LA0KKwkJCSAgICAgY2hpcC0+aW50X2NvblsxXSwgY2hpcC0+d2FrZV9tYXNrWzFdKTsNCisJCWVu
YWJsZV9pcnFfd2FrZShjaGlwLT5pcnEpOw0KKwkJYnJlYWs7DQorDQorCWNhc2UgUE1fUE9TVF9T
VVNQRU5EOg0KKwkJcmVnbWFwX3dyaXRlKGNoaXAtPnJlZ21hcCwNCisJCQkgICAgIGNoaXAtPmlu
dF9jb25bMF0sIGNoaXAtPmlycV9tYXNrc19jdXJbMF0pOw0KKwkJcmVnbWFwX3dyaXRlKGNoaXAt
PnJlZ21hcCwNCisJCQkgICAgIGNoaXAtPmludF9jb25bMV0sIGNoaXAtPmlycV9tYXNrc19jdXJb
MV0pOw0KKwkJZGlzYWJsZV9pcnFfd2FrZShjaGlwLT5pcnEpOw0KKwkJYnJlYWs7DQorDQorCWRl
ZmF1bHQ6DQorCQlicmVhazsNCisJfQ0KKw0KKwlyZXR1cm4gTk9USUZZX0RPTkU7DQorfQ0KKw0K
IGludCBtdDYzOTdfaXJxX2luaXQoc3RydWN0IG10NjM5N19jaGlwICpjaGlwKQ0KIHsNCiAJaW50
IHJldDsNCkBAIC0xNTksNiArMTkwLDcgQEAgaW50IG10NjM5N19pcnFfaW5pdChzdHJ1Y3QgbXQ2
Mzk3X2NoaXAgKmNoaXApDQogCXJlZ21hcF93cml0ZShjaGlwLT5yZWdtYXAsIGNoaXAtPmludF9j
b25bMF0sIDB4MCk7DQogCXJlZ21hcF93cml0ZShjaGlwLT5yZWdtYXAsIGNoaXAtPmludF9jb25b
MV0sIDB4MCk7DQogDQorCWNoaXAtPnBtX25iLm5vdGlmaWVyX2NhbGwgPSBtdDYzOTdfaXJxX3Bt
X25vdGlmaWVyOw0KIAljaGlwLT5pcnFfZG9tYWluID0gaXJxX2RvbWFpbl9hZGRfbGluZWFyKGNo
aXAtPmRldi0+b2Zfbm9kZSwNCiAJCQkJCQkgTVQ2Mzk3X0lSUV9OUiwNCiAJCQkJCQkgJm10NjM5
N19pcnFfZG9tYWluX29wcywNCkBAIC0xNzcsNSArMjA5LDYgQEAgaW50IG10NjM5N19pcnFfaW5p
dChzdHJ1Y3QgbXQ2Mzk3X2NoaXAgKmNoaXApDQogCQlyZXR1cm4gcmV0Ow0KIAl9DQogDQorCXJl
Z2lzdGVyX3BtX25vdGlmaWVyKCZjaGlwLT5wbV9uYik7DQogCXJldHVybiAwOw0KIH0NCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L21mZC9tdDYzOTcvY29yZS5oIGIvaW5jbHVkZS9saW51eC9t
ZmQvbXQ2Mzk3L2NvcmUuaA0KaW5kZXggZmM4OGQzMS4uYjgxZDMzMyAxMDA2NDQNCi0tLSBhL2lu
Y2x1ZGUvbGludXgvbWZkL210NjM5Ny9jb3JlLmgNCisrKyBiL2luY2x1ZGUvbGludXgvbWZkL210
NjM5Ny9jb3JlLmgNCkBAIC04LDYgKzgsNyBAQA0KICNkZWZpbmUgX19NRkRfTVQ2Mzk3X0NPUkVf
SF9fDQogDQogI2luY2x1ZGUgPGxpbnV4L211dGV4Lmg+DQorI2luY2x1ZGUgPGxpbnV4L25vdGlm
aWVyLmg+DQogDQogZW51bSBjaGlwX2lkIHsNCiAJTVQ2MzIzX0NISVBfSUQgPSAweDIzLA0KQEAg
LTU0LDYgKzU1LDcgQEAgZW51bSBtdDYzOTdfaXJxX251bWJlcnMgew0KIHN0cnVjdCBtdDYzOTdf
Y2hpcCB7DQogCXN0cnVjdCBkZXZpY2UgKmRldjsNCiAJc3RydWN0IHJlZ21hcCAqcmVnbWFwOw0K
KwlzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgcG1fbmI7DQogCWludCBpcnE7DQogCXN0cnVjdCBpcnFf
ZG9tYWluICppcnFfZG9tYWluOw0KIAlzdHJ1Y3QgbXV0ZXggaXJxbG9jazsNCi0tIA0KMi42LjQN
Cg==

