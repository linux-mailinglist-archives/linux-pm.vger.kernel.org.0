Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6826F1843B2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgCMJek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:9371 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726613AbgCMJek (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:40 -0400
X-UUID: b371ff98c1b5471ca0f1b0dc8d36953f-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=WAEDF3wVGcfjsbdKKEpfCJNHsy4ujyOaVE9TmeCQY2A=;
        b=nacHbsjXdJLlfaxTDRTb1OXzs03qnpmXZguBtmxNT4Gp4Ck6XYnTTrC2sND2OCaBGftdmeIkZX+xe6zmKA3RU3dg1XiSJ2vj4A8h+Mp7WkHQVGGxy1iJJ4N1FiFk5qbDkgosQzcEuU4HVgT0sg1e7vnoZdUT1wSdMjfi2xZG00I=;
X-UUID: b371ff98c1b5471ca0f1b0dc8d36953f-20200313
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 609043105; Fri, 13 Mar 2020 17:34:30 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:32:17 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:40 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        "Mike Turquette" <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V4 03/13] soc: mediatek: add support for the performance state
Date:   Fri, 13 Mar 2020 17:34:16 +0800
Message-ID: <1584092066-24425-4-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

U3VwcG9ydCBwb3dlciBkb21haW4gcGVyZm9ybWFuY2Ugc3RhdGUsIGFkZCBoZWFkZXIgZmlsZSBm
b3Igc2NwIGV2ZW50Lg0KDQpTaWduZWQtb2ZmLWJ5OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMgfCA1
OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3NvYy9t
ZWRpYXRlay9tdGstc2Nwc3lzLmggfCAyMiArKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5n
ZWQsIDgwIGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9zb2MvbWVk
aWF0ZWsvbXRrLXNjcHN5cy5oDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9t
dGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDg1
Mzg0MDguLmFkZDc1YTUgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTEwLDgg
KzEwLDEwIEBADQogI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcG1fZG9tYWluLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L3BtX29wcC5oPg0KICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCiAjaW5j
bHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCiAjaW5jbHVkZSAic2Nwc3lzLmgiDQogDQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2Vy
L210MjcwMS1wb3dlci5oPg0KQEAgLTIxLDYgKzIzLDcgQEANCiAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcG93ZXIvbXQ3NjIzYS1wb3dlci5oPg0KICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9t
dDgxNzMtcG93ZXIuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2Vy
Lmg+DQorI2luY2x1ZGUgIm10ay1zY3BzeXMuaCINCiANCiAjZGVmaW5lIE1US19QT0xMX0RFTEFZ
X1VTICAgMTANCiAjZGVmaW5lIE1US19QT0xMX1RJTUVPVVQgICAgVVNFQ19QRVJfU0VDDQpAQCAt
MTUwLDYgKzE1MywxOCBAQCBzdHJ1Y3Qgc2NwX3NvY19kYXRhIHsNCiAJY29uc3Qgc3RydWN0IHNj
cF9jdHJsX3JlZyByZWdzOw0KIH07DQogDQorc3RhdGljIEJMT0NLSU5HX05PVElGSUVSX0hFQUQo
c2Nwc3lzX25vdGlmaWVyX2xpc3QpOw0KKw0KK2ludCByZWdpc3Rlcl9zY3BzeXNfbm90aWZpZXIo
c3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYikNCit7DQorCXJldHVybiBibG9ja2luZ19ub3RpZmll
cl9jaGFpbl9yZWdpc3Rlcigmc2Nwc3lzX25vdGlmaWVyX2xpc3QsIG5iKTsNCit9DQorDQoraW50
IHVucmVnaXN0ZXJfc2Nwc3lzX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpDQor
ew0KKwlyZXR1cm4gYmxvY2tpbmdfbm90aWZpZXJfY2hhaW5fdW5yZWdpc3Rlcigmc2Nwc3lzX25v
dGlmaWVyX2xpc3QsIG5iKTsNCit9DQorDQogc3RhdGljIGludCBzY3BzeXNfZG9tYWluX2lzX29u
KHN0cnVjdCBzY3BfZG9tYWluICpzY3BkKQ0KIHsNCiAJc3RydWN0IHNjcCAqc2NwID0gc2NwZC0+
c2NwOw0KQEAgLTU1MCw2ICs1NjUsNDEgQEAgc3RhdGljIGludCBpbml0X2Jhc2ljX2Nsa3Moc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwgc3RydWN0IGNsayAqKmNsaywNCiAJcmV0dXJuIDA7
DQogfQ0KIA0KK3N0YXRpYyBpbnQgbXRrX3BkX3NldF9wZXJmb3JtYW5jZShzdHJ1Y3QgZ2VuZXJp
Y19wbV9kb21haW4gKmdlbnBkLA0KKwkJCQkgIHVuc2lnbmVkIGludCBzdGF0ZSkNCit7DQorCWlu
dCBpOw0KKwlzdHJ1Y3Qgc2NwX2RvbWFpbiAqc2NwZCA9DQorCQljb250YWluZXJfb2YoZ2VucGQs
IHN0cnVjdCBzY3BfZG9tYWluLCBnZW5wZCk7DQorCXN0cnVjdCBzY3BfZXZlbnRfZGF0YSBzY3Bl
Ow0KKwlzdHJ1Y3Qgc2NwICpzY3AgPSBzY3BkLT5zY3A7DQorCXN0cnVjdCBnZW5wZF9vbmVjZWxs
X2RhdGEgKnBkX2RhdGEgPSAmc2NwLT5wZF9kYXRhOw0KKw0KKwlmb3IgKGkgPSAwOyBpIDwgcGRf
ZGF0YS0+bnVtX2RvbWFpbnM7IGkrKykgew0KKwkJaWYgKGdlbnBkID09IHBkX2RhdGEtPmRvbWFp
bnNbaV0pIHsNCisJCQlkZXZfZGJnKHNjcC0+ZGV2LCAiJWQuICVzID0gJWRcbiIsDQorCQkJCWks
IGdlbnBkLT5uYW1lLCBzdGF0ZSk7DQorCQkJYnJlYWs7DQorCQl9DQorCX0NCisNCisJaWYgKGkg
PT0gcGRfZGF0YS0+bnVtX2RvbWFpbnMpDQorCQlyZXR1cm4gMDsNCisNCisJc2NwZS5ldmVudF90
eXBlID0gTVRLX1NDUFNZU19QU1RBVEU7DQorCXNjcGUuZ2VucGQgPSBnZW5wZDsNCisJc2NwZS5k
b21haW5faWQgPSBpOw0KKwlibG9ja2luZ19ub3RpZmllcl9jYWxsX2NoYWluKCZzY3BzeXNfbm90
aWZpZXJfbGlzdCwgc3RhdGUsICZzY3BlKTsNCisNCisJcmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRp
YyB1bnNpZ25lZCBpbnQgbXRrX3BkX2dldF9wZXJmb3JtYW5jZShzdHJ1Y3QgZ2VuZXJpY19wbV9k
b21haW4gKmdlbnBkLA0KKwkJCQkJICAgc3RydWN0IGRldl9wbV9vcHAgKm9wcCkNCit7DQorCXJl
dHVybiBkZXZfcG1fb3BwX2dldF9sZXZlbChvcHApOw0KK30NCisNCiBzdGF0aWMgc3RydWN0IHNj
cCAqaW5pdF9zY3Aoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiwNCiAJCQljb25zdCBzdHJ1
Y3Qgc2NwX2RvbWFpbl9kYXRhICpzY3BfZG9tYWluX2RhdGEsIGludCBudW0sDQogCQkJY29uc3Qg
c3RydWN0IHNjcF9jdHJsX3JlZyAqc2NwX2N0cmxfcmVnKQ0KQEAgLTY1MCw2ICs3MDAsMTQgQEAg
c3RhdGljIHN0cnVjdCBzY3AgKmluaXRfc2NwKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYs
DQogCQlnZW5wZC0+cG93ZXJfb24gPSBzY3BzeXNfcG93ZXJfb247DQogCQlpZiAoTVRLX1NDUERf
Q0FQUyhzY3BkLCBNVEtfU0NQRF9BQ1RJVkVfV0FLRVVQKSkNCiAJCQlnZW5wZC0+ZmxhZ3MgfD0g
R0VOUERfRkxBR19BQ1RJVkVfV0FLRVVQOw0KKw0KKwkJLyogQWRkIG9wcCB0YWJsZSBjaGVjayBm
aXJzdCB0byBhdm9pZCBPRiBydW50aW1lIHBhcnNlIGZhaWxlZCAqLw0KKwkJaWYgKG9mX2NvdW50
X3BoYW5kbGVfd2l0aF9hcmdzKHBkZXYtPmRldi5vZl9ub2RlLA0KKwkJICAgICJvcGVyYXRpbmct
cG9pbnRzLXYyIiwgTlVMTCkgPiAwKSB7DQorCQkJZ2VucGQtPnNldF9wZXJmb3JtYW5jZV9zdGF0
ZSA9IG10a19wZF9zZXRfcGVyZm9ybWFuY2U7DQorCQkJZ2VucGQtPm9wcF90b19wZXJmb3JtYW5j
ZV9zdGF0ZSA9DQorCQkJCW10a19wZF9nZXRfcGVyZm9ybWFuY2U7DQorCQl9DQogCX0NCiANCiAJ
cmV0dXJuIHNjcDsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lz
LmggYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmgNCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQppbmRleCAwMDAwMDAwLi5jMWU4MzI1DQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmgNCkBAIC0wLDAgKzEsMjIgQEANCisvKiBTUERYLUxp
Y2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KKyAqDQorICogQ29weXJpZ2h0IChjKSAyMDE4IE1l
ZGlhVGVrIEluYy4NCisgKi8NCisNCisjaWZuZGVmIF9fTVRLX1NDUFNZU19IX18NCisjZGVmaW5l
IF9fTVRLX1NDUFNZU19IX18NCisNCitzdHJ1Y3Qgc2NwX2V2ZW50X2RhdGEgew0KKwlpbnQgZXZl
bnRfdHlwZTsNCisJaW50IGRvbWFpbl9pZDsNCisJc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluICpn
ZW5wZDsNCit9Ow0KKw0KK2VudW0gc2NwX2V2ZW50X3R5cGUgew0KKwlNVEtfU0NQU1lTX1BTVEFU
RSwNCit9Ow0KKw0KK2ludCByZWdpc3Rlcl9zY3BzeXNfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVy
X2Jsb2NrICpuYik7DQoraW50IHVucmVnaXN0ZXJfc2Nwc3lzX25vdGlmaWVyKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIpOw0KKw0KKyNlbmRpZiAvKiBfX01US19TQ1BTWVNfSF9fICovDQotLSAN
CjEuOS4xDQo=

