Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F51B2682F3
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726093AbgINDFE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:05:04 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35987 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbgINDE5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:04:57 -0400
X-UUID: d4a8afd103f74f9b937809069c4aee82-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=b+P99K3c89W+s3w0wcI++BC4dbvHHPlV6NYVkc5ibts=;
        b=oGUDn1Ey7pV4eduBlg+svcToa2UAQkQcj3dS7i5S135AHWIe7sH4BTP95gXeJwg7uo+xF1p9opZrOgmkZ8K8RSeomhAp470bG82u7VhHgO4zyQZOvW7CPFQ/FB3mSDZlX3BW1eCp1y3pdNOLDi3PLkFiMyhYN4jczNeJgSN5wSU=;
X-UUID: d4a8afd103f74f9b937809069c4aee82-20200914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1991007190; Mon, 14 Sep 2020 11:04:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:48 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:47 +0800
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
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V5 03/17] soc: mediatek: add support for the performance state
Date:   Mon, 14 Sep 2020 11:04:30 +0800
Message-ID: <1600052684-21198-4-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
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
dGstc2Nwc3lzLmMgYi9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmMNCmluZGV4IDE5
YTBjN2UuLmFkMGNhNTIgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nw
c3lzLmMNCisrKyBiL2RyaXZlcnMvc29jL21lZGlhdGVrL210ay1zY3BzeXMuYw0KQEAgLTExLDgg
KzExLDEwIEBADQogI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KICNpbmNsdWRlIDxsaW51
eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCiAjaW5jbHVkZSA8bGludXgvcG1fZG9tYWluLmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L3BtX29wcC5oPg0KICNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCiAjaW5j
bHVkZSA8bGludXgvcmVndWxhdG9yL2NvbnN1bWVyLmg+DQorI2luY2x1ZGUgPGxpbnV4L3NsYWIu
aD4NCiANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQyNzAxLXBvd2VyLmg+DQogI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210MjcxMi1wb3dlci5oPg0KQEAgLTIyLDYgKzI0LDcg
QEANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTczLXBvd2VyLmg+DQogI2luY2x1
ZGUgPGR0LWJpbmRpbmdzL3Bvd2VyL210ODE4My1wb3dlci5oPg0KICNpbmNsdWRlIDxkdC1iaW5k
aW5ncy9wb3dlci9tdDgxOTItcG93ZXIuaD4NCisjaW5jbHVkZSAibXRrLXNjcHN5cy5oIg0KIA0K
ICNkZWZpbmUgTVRLX1BPTExfREVMQVlfVVMgICAxMA0KICNkZWZpbmUgTVRLX1BPTExfVElNRU9V
VCAgICBVU0VDX1BFUl9TRUMNCkBAIC0yNzIsNiArMjc1LDE4IEBAIHN0cnVjdCBzY3Bfc29jX2Rh
dGEgew0KIAljb25zdCBzdHJ1Y3Qgc2NwX2N0cmxfcmVnIHJlZ3M7DQogfTsNCiANCitzdGF0aWMg
QkxPQ0tJTkdfTk9USUZJRVJfSEVBRChzY3BzeXNfbm90aWZpZXJfbGlzdCk7DQorDQoraW50IHJl
Z2lzdGVyX3NjcHN5c19ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5iKQ0KK3sNCisJ
cmV0dXJuIGJsb2NraW5nX25vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKCZzY3BzeXNfbm90aWZpZXJf
bGlzdCwgbmIpOw0KK30NCisNCitpbnQgdW5yZWdpc3Rlcl9zY3BzeXNfbm90aWZpZXIoc3RydWN0
IG5vdGlmaWVyX2Jsb2NrICpuYikNCit7DQorCXJldHVybiBibG9ja2luZ19ub3RpZmllcl9jaGFp
bl91bnJlZ2lzdGVyKCZzY3BzeXNfbm90aWZpZXJfbGlzdCwgbmIpOw0KK30NCisNCiBzdGF0aWMg
aW50IHNjcHN5c19kb21haW5faXNfb24oc3RydWN0IHNjcF9kb21haW4gKnNjcGQpDQogew0KIAlz
dHJ1Y3Qgc2NwICpzY3AgPSBzY3BkLT5zY3A7DQpAQCAtMjk0LDYgKzMwOSw0MSBAQCBzdGF0aWMg
aW50IHNjcHN5c19kb21haW5faXNfb24oc3RydWN0IHNjcF9kb21haW4gKnNjcGQpDQogCXJldHVy
biAtRUlOVkFMOw0KIH0NCiANCitzdGF0aWMgaW50IG10a19wZF9zZXRfcGVyZm9ybWFuY2Uoc3Ry
dWN0IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZCwNCisJCQkJICB1bnNpZ25lZCBpbnQgc3RhdGUp
DQorew0KKwlpbnQgaTsNCisJc3RydWN0IHNjcF9kb21haW4gKnNjcGQgPQ0KKwkJY29udGFpbmVy
X29mKGdlbnBkLCBzdHJ1Y3Qgc2NwX2RvbWFpbiwgZ2VucGQpOw0KKwlzdHJ1Y3Qgc2NwX2V2ZW50
X2RhdGEgc2NwZTsNCisJc3RydWN0IHNjcCAqc2NwID0gc2NwZC0+c2NwOw0KKwlzdHJ1Y3QgZ2Vu
cGRfb25lY2VsbF9kYXRhICpwZF9kYXRhID0gJnNjcC0+cGRfZGF0YTsNCisNCisJZm9yIChpID0g
MDsgaSA8IHBkX2RhdGEtPm51bV9kb21haW5zOyBpKyspIHsNCisJCWlmIChnZW5wZCA9PSBwZF9k
YXRhLT5kb21haW5zW2ldKSB7DQorCQkJZGV2X2RiZyhzY3AtPmRldiwgIiVkLiAlcyA9ICVkXG4i
LA0KKwkJCQlpLCBnZW5wZC0+bmFtZSwgc3RhdGUpOw0KKwkJCWJyZWFrOw0KKwkJfQ0KKwl9DQor
DQorCWlmIChpID09IHBkX2RhdGEtPm51bV9kb21haW5zKQ0KKwkJcmV0dXJuIDA7DQorDQorCXNj
cGUuZXZlbnRfdHlwZSA9IE1US19TQ1BTWVNfUFNUQVRFOw0KKwlzY3BlLmdlbnBkID0gZ2VucGQ7
DQorCXNjcGUuZG9tYWluX2lkID0gaTsNCisJYmxvY2tpbmdfbm90aWZpZXJfY2FsbF9jaGFpbigm
c2Nwc3lzX25vdGlmaWVyX2xpc3QsIHN0YXRlLCAmc2NwZSk7DQorDQorCXJldHVybiAwOw0KK30N
CisNCitzdGF0aWMgdW5zaWduZWQgaW50IG10a19wZF9nZXRfcGVyZm9ybWFuY2Uoc3RydWN0IGdl
bmVyaWNfcG1fZG9tYWluICpnZW5wZCwNCisJCQkJCSAgIHN0cnVjdCBkZXZfcG1fb3BwICpvcHAp
DQorew0KKwlyZXR1cm4gZGV2X3BtX29wcF9nZXRfbGV2ZWwob3BwKTsNCit9DQorDQogc3RhdGlj
IGludCBzY3BzeXNfcmVndWxhdG9yX2VuYWJsZShzdHJ1Y3Qgc2NwX2RvbWFpbiAqc2NwZCkNCiB7
DQogCWlmICghc2NwZC0+c3VwcGx5KQ0KQEAgLTgwMCw2ICs4NTAsMTQgQEAgc3RhdGljIHN0cnVj
dCBzY3AgKmluaXRfc2NwKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQogCQlnZW5wZC0+
cG93ZXJfb24gPSBzY3BzeXNfcG93ZXJfb247DQogCQlpZiAoTVRLX1NDUERfQ0FQUyhzY3BkLCBN
VEtfU0NQRF9BQ1RJVkVfV0FLRVVQKSkNCiAJCQlnZW5wZC0+ZmxhZ3MgfD0gR0VOUERfRkxBR19B
Q1RJVkVfV0FLRVVQOw0KKw0KKwkJLyogQWRkIG9wcCB0YWJsZSBjaGVjayBmaXJzdCB0byBhdm9p
ZCBPRiBydW50aW1lIHBhcnNlIGZhaWxlZCAqLw0KKwkJaWYgKG9mX2NvdW50X3BoYW5kbGVfd2l0
aF9hcmdzKHBkZXYtPmRldi5vZl9ub2RlLA0KKwkJICAgICJvcGVyYXRpbmctcG9pbnRzLXYyIiwg
TlVMTCkgPiAwKSB7DQorCQkJZ2VucGQtPnNldF9wZXJmb3JtYW5jZV9zdGF0ZSA9IG10a19wZF9z
ZXRfcGVyZm9ybWFuY2U7DQorCQkJZ2VucGQtPm9wcF90b19wZXJmb3JtYW5jZV9zdGF0ZSA9DQor
CQkJCW10a19wZF9nZXRfcGVyZm9ybWFuY2U7DQorCQl9DQogCX0NCiANCiAJcmV0dXJuIHNjcDsN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmggYi9kcml2ZXJz
L3NvYy9tZWRpYXRlay9tdGstc2Nwc3lzLmgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAw
MDAwMDAwLi5jMWU4MzI1DQotLS0gL2Rldi9udWxsDQorKysgYi9kcml2ZXJzL3NvYy9tZWRpYXRl
ay9tdGstc2Nwc3lzLmgNCkBAIC0wLDAgKzEsMjIgQEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMA0KKyAqDQorICogQ29weXJpZ2h0IChjKSAyMDE4IE1lZGlhVGVrIEluYy4N
CisgKi8NCisNCisjaWZuZGVmIF9fTVRLX1NDUFNZU19IX18NCisjZGVmaW5lIF9fTVRLX1NDUFNZ
U19IX18NCisNCitzdHJ1Y3Qgc2NwX2V2ZW50X2RhdGEgew0KKwlpbnQgZXZlbnRfdHlwZTsNCisJ
aW50IGRvbWFpbl9pZDsNCisJc3RydWN0IGdlbmVyaWNfcG1fZG9tYWluICpnZW5wZDsNCit9Ow0K
Kw0KK2VudW0gc2NwX2V2ZW50X3R5cGUgew0KKwlNVEtfU0NQU1lTX1BTVEFURSwNCit9Ow0KKw0K
K2ludCByZWdpc3Rlcl9zY3BzeXNfbm90aWZpZXIoc3RydWN0IG5vdGlmaWVyX2Jsb2NrICpuYik7
DQoraW50IHVucmVnaXN0ZXJfc2Nwc3lzX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAq
bmIpOw0KKw0KKyNlbmRpZiAvKiBfX01US19TQ1BTWVNfSF9fICovDQotLSANCjEuOS4xDQo=

