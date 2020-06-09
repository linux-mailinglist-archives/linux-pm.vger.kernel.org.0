Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DADBC1F384C
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jun 2020 12:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbgFIKpo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Jun 2020 06:45:44 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:26511 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728305AbgFIKpm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 9 Jun 2020 06:45:42 -0400
X-UUID: 3e298489a864435fb845463d1be7a578-20200609
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eY5MvzczwNbrwtKhGEVAhCGRBXkqAd3J0N4ihq/a/Eg=;
        b=Ixbh/pRi2qVt4/u18b6/pZ6JYYn7wksjI/N+YKre+mLy3rJVXv/8QRu6uKffChwppnwMGrutMzgpt9fAKXVe76sjN8gLYTQ/x+U0h0q0x4v3wfgG3e91o3fKUHSAFWEFPuQXlCLLvR6KzoiGG/0RMVVOri53w8AHZQuzOxYQ7fc=;
X-UUID: 3e298489a864435fb845463d1be7a578-20200609
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1802064524; Tue, 09 Jun 2020 18:45:37 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Jun 2020 18:45:36 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 9 Jun 2020 18:45:34 +0800
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
Subject: [PATCH v9 1/4] dt-bindings: power: avs: add mtk svs dt-bindings
Date:   Tue, 9 Jun 2020 18:45:31 +0800
Message-ID: <20200609104534.29314-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200609104534.29314-1-roger.lu@mediatek.com>
References: <20200609104534.29314-1-roger.lu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RG9jdW1lbnQgdGhlIGJpbmRpbmcgZm9yIGVuYWJsaW5nIG10ayBzdnMgb24gTWVkaWFUZWsgU29D
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBSb2dlciBMdSA8cm9nZXIubHVAbWVkaWF0ZWsuY29tPg0KLS0t
DQogLi4uL2JpbmRpbmdzL3Bvd2VyL2F2cy9tdGtfc3ZzLnlhbWwgICAgICAgICAgIHwgMTQxICsr
KysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCAxNDEgaW5zZXJ0aW9ucygrKQ0KIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIv
YXZzL210a19zdnMueWFtbA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3Bvd2VyL2F2cy9tdGtfc3ZzLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcG93ZXIvYXZzL210a19zdnMueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQN
CmluZGV4IDAwMDAwMDAwMDAwMC4uZjE2ZjRlYjU2ZWUzDQotLS0gL2Rldi9udWxsDQorKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvYXZzL210a19zdnMueWFtbA0K
QEAgLTAsMCArMSwxNDEgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL3Bvd2VyL2F2cy9tdGtfc3ZzLnlhbWwjDQorJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IElu
dHJvZHVjZSBTVlMgZW5naW5lDQorDQorbWFpbnRhaW5lcnM6DQorICAtIEtldmluIEhpbG1hbiA8
a2hpbG1hbkBrZXJuZWwub3JnPg0KKyAgLSBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPg0KKw0K
K2Rlc2NyaXB0aW9uOiB8Kw0KKyAgVGhlIFNtYXJ0IFZvbHRhZ2UgU2NhbGluZyhTVlMpIGVuZ2lu
ZSBpcyBhIHBpZWNlIG9mIGhhcmR3YXJlDQorICB3aGljaCBoYXMgc2V2ZXJhbCBjb250cm9sbGVy
cyhiYW5rcykgZm9yIGNhbGN1bGF0aW5nIHN1aXRhYmxlDQorICB2b2x0YWdlIHRvIGRpZmZlcmVu
dCBwb3dlciBkb21haW5zKENQVS9HUFUvQ0NJKSBhY2NvcmRpbmcgdG8NCisgIGNoaXAgcHJvY2Vz
cyBjb3JuZXIsIHRlbXBlcmF0dXJlcyBhbmQgb3RoZXIgZmFjdG9ycy4gVGhlbiBEVkZTDQorICBk
cml2ZXIgY291bGQgYXBwbHkgU1ZTIGJhbmsgdm9sdGFnZSB0byBQTUlDL0J1Y2suDQorDQorcHJv
cGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBtZWRpYXRlayxtdDgxODMtc3Zz
DQorDQorICByZWc6DQorICAgIGRlc2NyaXB0aW9uOiBBZGRyZXNzIHJhbmdlIG9mIHRoZSBNVEsg
U1ZTIGNvbnRyb2xsZXIuDQorICAgIG1heEl0ZW1zOiAxDQorDQorICBpbnRlcnJ1cHRzOg0KKyAg
ICBkZXNjcmlwdGlvbjogSVJRIGZvciB0aGUgTVRLIFNWUyBjb250cm9sbGVyLg0KKyAgICBtYXhJ
dGVtczogMQ0KKw0KKyAgY2xvY2tzOg0KKyAgICBkZXNjcmlwdGlvbjogTWFpbiBjbG9jayBmb3Ig
c3ZzIGNvbnRyb2xsZXIgdG8gd29yay4NCisNCisgIGNsb2NrLW5hbWVzOg0KKyAgICBjb25zdDog
bWFpbg0KKw0KKyAgbnZtZW0tY2VsbHM6DQorICAgIG1heEl0ZW1zOiAyDQorICAgIGRlc2NyaXB0
aW9uOg0KKyAgICAgIFBoYW5kbGUgdG8gdGhlIGNhbGlicmF0aW9uIGRhdGEgcHJvdmlkZWQgYnkg
YSBudm1lbSBkZXZpY2UuDQorDQorICBudm1lbS1jZWxsLW5hbWVzOg0KKyAgICBpdGVtczoNCisg
ICAgICAtIGNvbnN0OiBzdnMtY2FsaWJyYXRpb24tZGF0YQ0KKyAgICAgIC0gY29uc3Q6IGNhbGli
cmF0aW9uLWRhdGENCisNCitwYXR0ZXJuUHJvcGVydGllczoNCisgICJec3ZzLShjcHUtbGl0dGxl
fGNwdS1iaWd8Y2NpfGdwdSkkIjoNCisgICAgdHlwZTogb2JqZWN0DQorICAgIGRlc2NyaXB0aW9u
Og0KKyAgICAgIEVhY2ggc3Vibm9kZSByZXByZXNlbnRzIG9uZSBTVlMgYmFuay4NCisgICAgICAg
IC0gc3ZzLWNwdS1saXR0bGUgKFNWUyBiYW5rIGRldmljZSBub2RlIG9mIGxpdHRsZSBDUFUpDQor
ICAgICAgICAtIHN2cy1jcHUtYmlnIChTVlMgYmFuayBkZXZpY2Ugbm9kZSBvZiBiaWcgQ1BVKQ0K
KyAgICAgICAgLSBzdnMtY2NpIChTVlMgYmFuayBkZXZpY2Ugbm9kZSBvZiBDQ0kpDQorICAgICAg
ICAtIHN2cy1ncHUgKFNWUyBiYW5rIGRldmljZSBub2RlIG9mIEdQVSkNCisNCisgICAgcHJvcGVy
dGllczoNCisgICAgICBjb21wYXRpYmxlOg0KKyAgICAgICBlbnVtOg0KKyAgICAgICAgIC0gbWVk
aWF0ZWssbXQ4MTgzLXN2cy1jcHUtbGl0dGxlDQorICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMt
c3ZzLWNwdS1iaWcNCisgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1zdnMtY2NpDQorICAgICAg
ICAgLSBtZWRpYXRlayxtdDgxODMtc3ZzLWdwdQ0KKw0KKyAgICAgIHBvd2VyLWRvbWFpbnM6DQor
ICAgICAgICBkZXNjcmlwdGlvbjogUGhhbmRsZSB0byB0aGUgYXNzb2NpYXRlZCBwb3dlciBkb21h
aW4NCisgICAgICAgIG1heEl0ZW1zOiAxDQorDQorICAgICAgb3BlcmF0aW5nLXBvaW50cy12Mjog
dHJ1ZQ0KKw0KKyAgICAgIHZjcHUtbGl0dGxlLXN1cHBseToNCisgICAgICAgIGRlc2NyaXB0aW9u
OiBQTUlDIGJ1Y2sgb2YgbGl0dGxlIENQVQ0KKw0KKyAgICAgIHZjcHUtYmlnLXN1cHBseToNCisg
ICAgICAgIGRlc2NyaXB0aW9uOiBQTUlDIGJ1Y2sgb2YgYmlnIENQVQ0KKw0KKyAgICAgIHZjY2kt
c3VwcGx5Og0KKyAgICAgICAgZGVzY3JpcHRpb246IFBNSUMgYnVjayBvZiBDQ0kNCisNCisgICAg
ICB2Z3B1LXNwcGx5Og0KKyAgICAgICAgZGVzY3JpcHRpb246IFBNSUMgYnVjayBvZiBHUFUNCisN
CisgICAgcmVxdWlyZWQ6DQorICAgICAgLSBjb21wYXRpYmxlDQorICAgICAgLSBvcGVyYXRpbmct
cG9pbnRzLXYyDQorDQorICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK3JlcXVp
cmVkOg0KKyAgLSBjb21wYXRpYmxlDQorICAtIHJlZw0KKyAgLSBpbnRlcnJ1cHRzDQorICAtIGNs
b2Nrcw0KKyAgLSBjbG9jay1uYW1lcw0KKyAgLSBudm1lbS1jZWxscw0KKyAgLSBudm1lbS1jZWxs
LW5hbWVzDQorDQorYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQor
ICAtIHwNCisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2Nsb2NrL210ODE4My1jbGsuaD4NCisg
ICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4N
CisgICAgI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0K
KyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTgzLXBvd2VyLmg+DQorDQorICAg
IHN2czogc3ZzQDExMDBiMDAwIHsNCisgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTgzLXN2cyI7DQorICAgICAgICByZWcgPSA8MCAweDExMDBiMDAwIDAgMHgxMDAwPjsNCisgICAg
ICAgIGludGVycnVwdHMgPSA8R0lDX1NQSSAxMjcgSVJRX1RZUEVfTEVWRUxfTE9XPjsNCisgICAg
ICAgIGNsb2NrcyA9IDwmaW5mcmFjZmcgQ0xLX0lORlJBX1RIRVJNPjsNCisgICAgICAgIGNsb2Nr
LW5hbWVzID0gIm1haW4iOw0KKyAgICAgICAgbnZtZW0tY2VsbHMgPSA8JnN2c19jYWxpYnJhdGlv
bj4sIDwmdGhlcm1hbF9jYWxpYnJhdGlvbj47DQorICAgICAgICBudm1lbS1jZWxsLW5hbWVzID0g
InN2cy1jYWxpYnJhdGlvbi1kYXRhIiwgImNhbGlicmF0aW9uLWRhdGEiOw0KKw0KKyAgICAgICAg
c3ZzX2NwdV9saXR0bGU6IHN2cy1jcHUtbGl0dGxlIHsNCisgICAgICAgICAgICBjb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE4My1zdnMtY3B1LWxpdHRsZSI7DQorICAgICAgICAgICAgb3BlcmF0
aW5nLXBvaW50cy12MiA9IDwmY2x1c3RlcjBfb3BwPjsNCisgICAgICAgICAgICB2Y3B1LWxpdHRs
ZS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47DQorICAgICAgICB9Ow0KKw0KKyAgICAg
ICAgc3ZzX2NwdV9iaWc6IHN2cy1jcHUtYmlnIHsNCisgICAgICAgICAgICBjb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE4My1zdnMtY3B1LWJpZyI7DQorICAgICAgICAgICAgb3BlcmF0aW5nLXBv
aW50cy12MiA9IDwmY2x1c3RlcjFfb3BwPjsNCisgICAgICAgICAgICB2Y3B1LWJpZy1zdXBwbHkg
PSA8Jm10NjM1OF92cHJvYzExX3JlZz47DQorICAgICAgICB9Ow0KKw0KKyAgICAgICAgc3ZzX2Nj
aTogc3ZzLWNjaSB7DQorICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
c3ZzLWNjaSI7DQorICAgICAgICAgICAgb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmY2NpX29wcD47
DQorICAgICAgICAgICAgdmNjaS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47DQorICAg
ICAgICB9Ow0KKw0KKyAgICAgICAgc3ZzX2dwdTogc3ZzLWdwdSB7DQorICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzLWdwdSI7DQorICAgICAgICAgICAgcG93ZXIt
ZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9ET01BSU5fTUZHXzJEPjsNCisgICAgICAg
ICAgICBvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZncHVfb3BwX3RhYmxlPjsNCisgICAgICAgICAg
ICB2Z3B1LXNwcGx5ID0gPCZtdDYzNThfdmdwdV9yZWc+Ow0KKyAgICAgICAgfTsNCisgICAgfTsN
Ci0tIA0KMi4xOC4wDQo=

