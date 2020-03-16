Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD45718659D
	for <lists+linux-pm@lfdr.de>; Mon, 16 Mar 2020 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbgCPHYq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 16 Mar 2020 03:24:46 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:31638 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729638AbgCPHYp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Mar 2020 03:24:45 -0400
X-UUID: 5242a75c287e47e5b2f575f992114b96-20200316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=39ItGNth9VrE85n3VIY5Tt/fJgOiTIGshUGjxE8ZVBQ=;
        b=Uf7xUX1OYTeqo0ZDks2kCHHHabbzKo4vDQ5WfDJCDtVuWtxZnRN48Gbs6PICta3J5M3lPxGJNXw2ZqI7j3/evDtsMWj7Vt1J9Yck2Uwff3qU3LnINZTmEpy6EZOUSucEggjq6SQz+poIVndYixI4vqcvNQ14EFEA9Rx7YY77AtM=;
X-UUID: 5242a75c287e47e5b2f575f992114b96-20200316
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 602375775; Mon, 16 Mar 2020 15:24:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 16 Mar 2020 15:23:22 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 16 Mar 2020 15:21:41 +0800
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
Subject: [PATCH v7 2/3] arm64: dts: mt8183: add svs device information
Date:   Mon, 16 Mar 2020 15:23:16 +0800
Message-ID: <20200316072316.7156-3-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200316072316.7156-1-roger.lu@mediatek.com>
References: <20200316072316.7156-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
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
Yi5kdHMNCkBAIC0yMzEsNiArMjMxLDIyIEBADQogDQogfTsNCiANCismc3ZzX2NwdV9saXR0bGUg
ew0KKwl2Y3B1LWxpdHRsZS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47DQorfTsNCisN
Cismc3ZzX2NwdV9iaWcgew0KKwl2Y3B1LWJpZy1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzExX3Jl
Zz47DQorfTsNCisNCismc3ZzX2NjaSB7DQorCXZjY2ktc3VwcGx5ID0gPCZtdDYzNThfdnByb2Mx
Ml9yZWc+Ow0KK307DQorDQorJnN2c19ncHUgew0KKwl2Z3B1LXNwcGx5ID0gPCZtdDYzNThfdmdw
dV9yZWc+Ow0KK307DQorDQogJnVhcnQwIHsNCiAJc3RhdHVzID0gIm9rYXkiOw0KIH07DQpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBiL2FyY2gv
YXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDQzM2M2MmVmYWIyZC4u
NzhmM2NkMDk0MGU3IDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRz
aQ0KQEAgLTQ1Nyw2ICs0NTcsMzkgQEANCiAJCQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KIAkJfTsN
CiANCisJCXN2czogc3ZzQDExMDBiMDAwIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE4My1zdnMiOw0KKwkJCXJlZyA9IDwwIDB4MTEwMGIwMDAgMCAweDEwMDA+Ow0KKwkJCWludGVy
cnVwdHMgPSA8R0lDX1NQSSAxMjcgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisJCQljbG9ja3MgPSA8
JmluZnJhY2ZnIENMS19JTkZSQV9USEVSTT47DQorCQkJY2xvY2stbmFtZXMgPSAibWFpbiI7DQor
CQkJbnZtZW0tY2VsbHMgPSA8JnN2c19jYWxpYnJhdGlvbj4sDQorCQkJCSAgICAgIDwmdGhlcm1h
bF9jYWxpYnJhdGlvbj47DQorCQkJbnZtZW0tY2VsbC1uYW1lcyA9ICJzdnMtY2FsaWJyYXRpb24t
ZGF0YSIsDQorCQkJCQkgICAiY2FsaWJyYXRpb24tZGF0YSI7DQorDQorCQkJc3ZzX2NwdV9saXR0
bGU6IHN2cy1jcHUtbGl0dGxlIHsNCisJCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
c3ZzLWNwdS1saXR0bGUiOw0KKwkJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZjbHVzdGVyMF9v
cHA+Ow0KKwkJCX07DQorDQorCQkJc3ZzX2NwdV9iaWc6IHN2cy1jcHUtYmlnIHsNCisJCQkJY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzLWNwdS1iaWciOw0KKwkJCQlvcGVyYXRpbmct
cG9pbnRzLXYyID0gPCZjbHVzdGVyMV9vcHA+Ow0KKwkJCX07DQorDQorCQkJc3ZzX2NjaTogc3Zz
LWNjaSB7DQorCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXN2cy1jY2kiOw0KKwkJ
CQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZjY2lfb3BwPjsNCisJCQl9Ow0KKw0KKwkJCXN2c19n
cHU6IHN2cy1ncHUgew0KKwkJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zdnMtZ3B1
IjsNCisJCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fTUZH
XzJEPjsNCisJCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmZ3B1X29wcF90YWJsZT47DQorCQkJ
fTsNCisJCX07DQorDQogCQlpMmMzOiBpMmNAMTEwMGYwMDAgew0KIAkJCWNvbXBhdGlibGUgPSAi
bWVkaWF0ZWssbXQ4MTgzLWkyYyI7DQogCQkJcmVnID0gPDAgMHgxMTAwZjAwMCAwIDB4MTAwMD4s
DQpAQCAtNjQ4LDYgKzY4MSwxNCBAQA0KIAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LWVmdXNlIiwNCiAJCQkJICAgICAibWVkaWF0ZWssZWZ1c2UiOw0KIAkJCXJlZyA9IDwwIDB4MTFm
MTAwMDAgMCAweDEwMDA+Ow0KKwkJCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KKwkJCSNzaXplLWNl
bGxzID0gPDE+Ow0KKwkJCXRoZXJtYWxfY2FsaWJyYXRpb246IGNhbGliQDE4MCB7DQorCQkJCXJl
ZyA9IDwweDE4MCAweGM+Ow0KKwkJCX07DQorCQkJc3ZzX2NhbGlicmF0aW9uOiBjYWxpYkA1ODAg
ew0KKwkJCQlyZWcgPSA8MHg1ODAgMHg2ND47DQorCQkJfTsNCiAJCX07DQogDQogCQltZmdjZmc6
IHN5c2NvbkAxMzAwMDAwMCB7DQotLSANCjIuMTguMA0K

