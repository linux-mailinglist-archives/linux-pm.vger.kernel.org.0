Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCA51D73EB
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgERJY4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 05:24:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:60647 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726497AbgERJYz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 05:24:55 -0400
X-UUID: 5528049c07ac4a3eaefc26b458621c46-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XWQIwQIcTzHBiRtT8y/pLH7l27zFDZIQLPPN6nq9RoU=;
        b=ijH2jf8Gu0Dws658PLhy3sOJ7wTBz0p7YGQungC2Z2rGkpPNmdvU5fd/J4Q0q7jKekEgGVyFAk82mx9rBrpnZ0cIbxftSrRZzcDjOcwL1dKKgyRDGWkruUAE8doWTlZ3aHU+7TmeGykIEan+AV8UGg/3LaJiph2m286D4GByh1E=;
X-UUID: 5528049c07ac4a3eaefc26b458621c46-20200518
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2092121369; Mon, 18 May 2020 17:24:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 17:24:47 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 17:24:47 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Kevin Hilman <khilman@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Fan Chen <fan.chen@mediatek.com>,
        HenryC Chen <HenryC.Chen@mediatek.com>,
        YT Lee <yt.lee@mediatek.com>,
        Xiaoqing Liu <Xiaoqing.Liu@mediatek.com>,
        Charles Yang <Charles.Yang@mediatek.com>,
        Angus Lin <Angus.Lin@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nishanth Menon <nm@ti.com>, Roger Lu <roger.lu@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH v8 2/3] arm64: dts: mt8183: add svs device information
Date:   Mon, 18 May 2020 17:24:03 +0800
Message-ID: <20200518092403.22647-3-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200518092403.22647-1-roger.lu@mediatek.com>
References: <20200518092403.22647-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 470799B14A663516422E7C38CC9E7744BC9531C9C7DF9683D475CD2044EBF24B2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

YWRkIHBtaWMvY2xvY2svaXJxL2VmdXNlIHNldHRpbmcgaW4gc3ZzIG5vZGUNCg0KU2lnbmVkLW9m
Zi1ieTogUm9nZXIgTHUgPHJvZ2VyLmx1QG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWV2Yi5kdHMgfCAxNiArKysrKysrKw0KIGFyY2gvYXJt
NjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgICAgfCA0MSArKysrKysrKysrKysrKysr
KysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBh
L2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWV2Yi5kdHMgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My1ldmIuZHRzDQppbmRleCAxZmIxOTVjNjgzYzMuLjZh
ZTFkOWExYmNiZiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTgzLWV2Yi5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWV2
Yi5kdHMNCkBAIC0yMzEsNiArMjMxLDIyIEBADQogDQogfTsNCiB9Ow0KIA0KKyZzdnNfY3B1X2xp
dHRsZSB7DQorCXZjcHUtbGl0dGxlLXN1cHBseSA9IDwmbXQ2MzU4X3Zwcm9jMTJfcmVnPjsNCit9
Ow0KKw0KKyZzdnNfY3B1X2JpZyB7DQorCXZjcHUtYmlnLXN1cHBseSA9IDwmbXQ2MzU4X3Zwcm9j
MTFfcmVnPjsNCit9Ow0KKw0KKyZzdnNfY2NpIHsNCisJdmNjaS1zdXBwbHkgPSA8Jm10NjM1OF92
cHJvYzEyX3JlZz47DQorfTsNCisNCismc3ZzX2dwdSB7DQorCXZncHUtc3BwbHkgPSA8Jm10NjM1
OF92Z3B1X3JlZz47DQorfTsNCisNCiAmdWFydDAgew0KIAlzdGF0dXMgPSAib2theSI7DQogfTsN
CmRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KaW5kZXggOTc4NjNhZGI3
YmMwLi42YjZiOGRjMTgyNGYgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlh
dGVrL210ODE4My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4
My5kdHNpDQpAQCAtNDUzLDYgKzQ1MywzOSBAQA0KIAkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQog
CQl9Ow0KIA0KIA0KKwkJc3ZzOiBzdnNAMTEwMGIwMDAgew0KKwkJCWNvbXBhdGlibGUgPSAibWVk
aWF0ZWssbXQ4MTgzLXN2cyI7DQorCQkJcmVnID0gPDAgMHgxMTAwYjAwMCAwIDB4MTAwMD47DQor
CQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEyNyBJUlFfVFlQRV9MRVZFTF9MT1c+Ow0KKwkJCWNs
b2NrcyA9IDwmaW5mcmFjZmcgQ0xLX0lORlJBX1RIRVJNPjsNCisJCQljbG9jay1uYW1lcyA9ICJt
YWluIjsNCisJCQludm1lbS1jZWxscyA9IDwmc3ZzX2NhbGlicmF0aW9uPiwNCisJCQkJICAgICAg
PCZ0aGVybWFsX2NhbGlicmF0aW9uPjsNCisJCQludm1lbS1jZWxsLW5hbWVzID0gInN2cy1jYWxp
YnJhdGlvbi1kYXRhIiwNCisJCQkJCSAgICJjYWxpYnJhdGlvbi1kYXRhIjsNCisNCisJCQlzdnNf
Y3B1X2xpdHRsZTogc3ZzLWNwdS1saXR0bGUgew0KKwkJCQljb21wYXRpYmxlID0gIm1lZGlhdGVr
LG10ODE4My1zdnMtY3B1LWxpdHRsZSI7DQorCQkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmNs
dXN0ZXIwX29wcD47DQorCQkJfTsNCisNCisJCQlzdnNfY3B1X2JpZzogc3ZzLWNwdS1iaWcgew0K
KwkJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zdnMtY3B1LWJpZyI7DQorCQkJCW9w
ZXJhdGluZy1wb2ludHMtdjIgPSA8JmNsdXN0ZXIxX29wcD47DQorCQkJfTsNCisNCisJCQlzdnNf
Y2NpOiBzdnMtY2NpIHsNCisJCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzLWNj
aSI7DQorCQkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmNjaV9vcHA+Ow0KKwkJCX07DQorDQor
CQkJc3ZzX2dwdTogc3ZzLWdwdSB7DQorCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LXN2cy1ncHUiOw0KKwkJCQlwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RP
TUFJTl9NRkdfMkQ+Ow0KKwkJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZncHVfb3BwX3RhYmxl
PjsNCisJCQl9Ow0KKwkJfTsNCisNCiAJCWkyYzM6IGkyY0AxMTAwZjAwMCB7DQogCQkJY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtaTJjIjsNCiAJCQlyZWcgPSA8MCAweDExMDBmMDAwIDAg
MHgxMDAwPiwNCkBAIC02NDQsNiArNjc3LDE0IEBADQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODMtZWZ1c2UiLA0KIAkJCQkgICAgICJtZWRpYXRlayxlZnVzZSI7DQogCQkJcmVnID0g
PDAgMHgxMWYxMDAwMCAwIDB4MTAwMD47DQorCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQorCQkJ
I3NpemUtY2VsbHMgPSA8MT47DQorCQkJdGhlcm1hbF9jYWxpYnJhdGlvbjogY2FsaWJAMTgwIHsN
CisJCQkJcmVnID0gPDB4MTgwIDB4Yz47DQorCQkJfTsNCisJCQlzdnNfY2FsaWJyYXRpb246IGNh
bGliQDU4MCB7DQorCQkJCXJlZyA9IDwweDU4MCAweDY0PjsNCisJCQl9Ow0KIAkJfTsNCiANCiAJ
CW1mZ2NmZzogc3lzY29uQDEzMDAwMDAwIHsNCi0tIA0KMi4xOC4wDQo=

