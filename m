Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304E91F384B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 12:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728718AbgFIKpk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 06:45:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16379 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727122AbgFIKpk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 06:45:40 -0400
X-UUID: bff02273612845ec9b2da71e31fb0019-20200609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=mUcP1s22j8Ujxa7NaiWgCxFQDgBhnWhL140VV9SUHPw=;
        b=nd44leTJVl4+VE+e7Ut5lYxhGHw2G8A2Pryu9x5MFuWwA2dFxpn4C74kd6USpRVOJn5zcquSVdBTfbTNR/qqylOnsv/yUUZYrfC3oEGGv4OwAKsOWx3Dq6ch1iIqaRK97TVnRXW9iai0n77+R2BZGaDk8LKkX4UaQ8HG7AbXlfQ=;
X-UUID: bff02273612845ec9b2da71e31fb0019-20200609
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2064220007; Tue, 09 Jun 2020 18:45:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 18:45:34 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Jun 2020 18:45:35 +0800
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
Subject: [PATCH v9 2/4] arm64: dts: mt8183: add svs device information
Date:   Tue, 9 Jun 2020 18:45:32 +0800
Message-ID: <20200609104534.29314-3-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200609104534.29314-1-roger.lu@mediatek.com>
References: <20200609104534.29314-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 933CDA7A71541E0675C6207B267F9F41A02AC4D1DD31C023D4B69A3E0079EB382000:8
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
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My1ldmIuZHRzDQppbmRleCAxZmIxOTVjNjgzYzMuLjNl
ZmE0ZjZjZjkwOSAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4
MTgzLWV2Yi5kdHMNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLWV2
Yi5kdHMNCkBAIC0yMzEsNiArMjMxLDIyIEBADQogDQogfTsNCiANCismc3ZzX2NwdV9saXR0bGUg
ew0KKwl2Y3B1LWxpdHRsZS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47DQorfTsNCisN
Cismc3ZzX2NwdV9iaWcgew0KKwl2Y3B1LWJpZy1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzExX3Jl
Zz47DQorfTsNCisNCismc3ZzX2NjaSB7DQorCXZjY2ktc3VwcGx5ID0gPCZtdDYzNThfdnByb2Mx
Ml9yZWc+Ow0KK307DQorDQorJnN2c19ncHUgew0KKwl2Z3B1LXN1cHBseSA9IDwmbXQ2MzU4X3Zn
cHVfcmVnPjsNCit9Ow0KKw0KICZ1YXJ0MCB7DQogCXN0YXR1cyA9ICJva2F5IjsNCiB9Ow0KZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNo
L2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpDQppbmRleCA4ZTQ1YjVhNTgxOGYu
LjZmZDEyOWI1ZmQ3MiAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsv
bXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0
c2kNCkBAIC00MjMsNiArNDIzLDM5IEBADQogCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCiAJCX07
DQogDQorCQlzdnM6IHN2c0AxMTAwYjAwMCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxODMtc3ZzIjsNCisJCQlyZWcgPSA8MCAweDExMDBiMDAwIDAgMHgxMDAwPjsNCisJCQlpbnRl
cnJ1cHRzID0gPEdJQ19TUEkgMTI3IElSUV9UWVBFX0xFVkVMX0xPVz47DQorCQkJY2xvY2tzID0g
PCZpbmZyYWNmZyBDTEtfSU5GUkFfVEhFUk0+Ow0KKwkJCWNsb2NrLW5hbWVzID0gIm1haW4iOw0K
KwkJCW52bWVtLWNlbGxzID0gPCZzdnNfY2FsaWJyYXRpb24+LA0KKwkJCQkgICAgICA8JnRoZXJt
YWxfY2FsaWJyYXRpb24+Ow0KKwkJCW52bWVtLWNlbGwtbmFtZXMgPSAic3ZzLWNhbGlicmF0aW9u
LWRhdGEiLA0KKwkJCQkJICAgImNhbGlicmF0aW9uLWRhdGEiOw0KKw0KKwkJCXN2c19jcHVfbGl0
dGxlOiBzdnMtY3B1LWxpdHRsZSB7DQorCQkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LXN2cy1jcHUtbGl0dGxlIjsNCisJCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmY2x1c3RlcjBf
b3BwPjsNCisJCQl9Ow0KKw0KKwkJCXN2c19jcHVfYmlnOiBzdnMtY3B1LWJpZyB7DQorCQkJCWNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXN2cy1jcHUtYmlnIjsNCisJCQkJb3BlcmF0aW5n
LXBvaW50cy12MiA9IDwmY2x1c3RlcjFfb3BwPjsNCisJCQl9Ow0KKw0KKwkJCXN2c19jY2k6IHN2
cy1jY2kgew0KKwkJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zdnMtY2NpIjsNCisJ
CQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmY2NpX29wcD47DQorCQkJfTsNCisNCisJCQlzdnNf
Z3B1OiBzdnMtZ3B1IHsNCisJCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzLWdw
dSI7DQorCQkJCXBvd2VyLWRvbWFpbnMgPSA8JnNjcHN5cyBNVDgxODNfUE9XRVJfRE9NQUlOX01G
R18yRD47DQorCQkJCW9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmdwdV9vcHBfdGFibGU+Ow0KKwkJ
CX07DQorCQl9Ow0KKw0KIAkJaTJjMzogaTJjQDExMDBmMDAwIHsNCiAJCQljb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE4My1pMmMiOw0KIAkJCXJlZyA9IDwwIDB4MTEwMGYwMDAgMCAweDEwMDA+
LA0KQEAgLTYxNCw2ICs2NDcsMTQgQEANCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4
My1lZnVzZSIsDQogCQkJCSAgICAgIm1lZGlhdGVrLGVmdXNlIjsNCiAJCQlyZWcgPSA8MCAweDEx
ZjEwMDAwIDAgMHgxMDAwPjsNCisJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsNCisJCQkjc2l6ZS1j
ZWxscyA9IDwxPjsNCisJCQl0aGVybWFsX2NhbGlicmF0aW9uOiBjYWxpYkAxODAgew0KKwkJCQly
ZWcgPSA8MHgxODAgMHhjPjsNCisJCQl9Ow0KKwkJCXN2c19jYWxpYnJhdGlvbjogY2FsaWJANTgw
IHsNCisJCQkJcmVnID0gPDB4NTgwIDB4NjQ+Ow0KKwkJCX07DQogCQl9Ow0KIA0KIAkJbWZnY2Zn
OiBzeXNjb25AMTMwMDAwMDAgew0KLS0gDQoyLjE4LjANCg==

