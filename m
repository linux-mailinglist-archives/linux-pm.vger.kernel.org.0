Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E6B1D73EC
	for <lists+linux-pm@lfdr.de>; Mon, 18 May 2020 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgERJYy (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 May 2020 05:24:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:12679 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726040AbgERJYy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 May 2020 05:24:54 -0400
X-UUID: 96be21da88fd42a9b664bb8f49c26be1-20200518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=xOZ4MeTRfS9iV1mfQHvql2zLgBjMD0iQhXwC9YzCwxc=;
        b=tpTvXBQirvN7i/oouboCalTvovnhTaIagoshnPCqqT5a8shY4howIT6LF/hJjLPLOBH+drWfFIZBMahlMxO1bOxdNXfYGhot3jRuPSAu7PEd9xks5so2Oi92kMbRDEOs/25NTexTIJ07YZv5GTX5eLTD8th6+5ONxtcPwSVl8/U=;
X-UUID: 96be21da88fd42a9b664bb8f49c26be1-20200518
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 668778878; Mon, 18 May 2020 17:24:48 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 18 May 2020 17:24:47 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 18 May 2020 17:24:46 +0800
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
Subject: [PATCH v8 1/3] dt-bindings: power: avs: add mtk svs dt-bindings
Date:   Mon, 18 May 2020 17:24:02 +0800
Message-ID: <20200518092403.22647-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200518092403.22647-1-roger.lu@mediatek.com>
References: <20200518092403.22647-1-roger.lu@mediatek.com>
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
CmluZGV4IDAwMDAwMDAwMDAwMC4uNzdhYjYwNjgxNGNlDQotLS0gL2Rldi9udWxsDQorKysgYi9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvYXZzL210a19zdnMueWFtbA0K
QEAgLTAsMCArMSwxNDEgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1v
bmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZp
Y2V0cmVlLm9yZy9zY2hlbWFzL3Bvd2VyL2F2cy9tdGtfc3ZzLnlhbWwjDQorJHNjaGVtYTogaHR0
cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IElu
dHJvZHVjZSBTVlMgZW5naW5lDQorDQorbWFpbnRhaW5lcnM6DQorICAtIEtldmluIEhpbG1hbiA8
a2hpbG1hbkBrZXJuZWwub3JnPg0KKyAgLSBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPg0KKw0K
K2Rlc2NyaXB0aW9uOiB8Kw0KKyAgVGhlIFNWUyAoU21hcnQgVm9sdGFnZSBTY2FsaW5nKSBlbmdp
bmUgaXMgYSBwaWVjZSBvZiBoYXJkd2FyZSB3aGljaCBpcw0KKyAgdXNlZCB0byBjYWxjdWxhdGUg
b3B0aW1pemVkIHZvbHRhZ2UgdmFsdWVzIG9mIHNldmVyYWwgcG93ZXIgZG9tYWlucywNCisgIGUu
Zy4gQ1BVL0dQVS9DQ0ksIGFjY29yZGluZyB0byBjaGlwIHByb2Nlc3MgY29ybmVyLCB0ZW1wZXJh
dHVyZXMsDQorICBhbmQgb3RoZXIgZmFjdG9ycy4gVGhlbiBEVkZTIGRyaXZlciBjb3VsZCBhcHBs
eSB0aG9zZSBvcHRpbWl6ZWQgdm9sdGFnZQ0KKyAgdmFsdWVzIHRvIHJlZHVjZSBwb3dlciBjb25z
dW1wdGlvbi4NCisNCitwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgY29uc3Q6IG1l
ZGlhdGVrLG10ODE4My1zdnMNCisNCisgIHJlZzoNCisgICAgZGVzY3JpcHRpb246IEFkZHJlc3Mg
cmFuZ2Ugb2YgdGhlIE1USyBTVlMgY29udHJvbGxlci4NCisgICAgbWF4SXRlbXM6IDENCisNCisg
IGludGVycnVwdHM6DQorICAgIGRlc2NyaXB0aW9uOiBJUlEgZm9yIHRoZSBNVEsgU1ZTIGNvbnRy
b2xsZXIuDQorICAgIG1heEl0ZW1zOiAxDQorDQorICBjbG9ja3M6DQorICAgIGRlc2NyaXB0aW9u
OiBNYWluIGNsb2NrIGZvciBzdnMgY29udHJvbGxlciB0byB3b3JrLg0KKw0KKyAgY2xvY2stbmFt
ZXM6DQorICAgIGNvbnN0OiBtYWluDQorDQorICBudm1lbS1jZWxsczoNCisgICAgbWF4SXRlbXM6
IDINCisgICAgZGVzY3JpcHRpb246DQorICAgICAgUGhhbmRsZSB0byB0aGUgY2FsaWJyYXRpb24g
ZGF0YSBwcm92aWRlZCBieSBhIG52bWVtIGRldmljZS4NCisNCisgIG52bWVtLWNlbGwtbmFtZXM6
DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IHN2cy1jYWxpYnJhdGlvbi1kYXRhDQorICAg
ICAgLSBjb25zdDogY2FsaWJyYXRpb24tZGF0YQ0KKw0KK3BhdHRlcm5Qcm9wZXJ0aWVzOg0KKyAg
Il5zdnMtKGNwdS1saXR0bGV8Y3B1LWJpZ3xjY2l8Z3B1KSQiOg0KKyAgICB0eXBlOiBvYmplY3QN
CisgICAgZGVzY3JpcHRpb246DQorICAgICAgRWFjaCBzdWJub2RlIHJlcHJlc2VudHMgb25lIFNW
UyBiYW5rLg0KKyAgICAgICAgLSBzdnMtY3B1LWxpdHRsZSAoU1ZTIGJhbmsgZGV2aWNlIG5vZGUg
b2YgbGl0dGxlIENQVSkNCisgICAgICAgIC0gc3ZzLWNwdS1iaWcgKFNWUyBiYW5rIGRldmljZSBu
b2RlIG9mIGJpZyBDUFUpDQorICAgICAgICAtIHN2cy1jY2kgKFNWUyBiYW5rIGRldmljZSBub2Rl
IG9mIENDSSkNCisgICAgICAgIC0gc3ZzLWdwdSAoU1ZTIGJhbmsgZGV2aWNlIG5vZGUgb2YgR1BV
KQ0KKw0KKyAgICBwcm9wZXJ0aWVzOg0KKyAgICAgIGNvbXBhdGlibGU6DQorICAgICAgIGVudW06
DQorICAgICAgICAgLSBtZWRpYXRlayxtdDgxODMtc3ZzLWNwdS1saXR0bGUNCisgICAgICAgICAt
IG1lZGlhdGVrLG10ODE4My1zdnMtY3B1LWJpZw0KKyAgICAgICAgIC0gbWVkaWF0ZWssbXQ4MTgz
LXN2cy1jY2kNCisgICAgICAgICAtIG1lZGlhdGVrLG10ODE4My1zdnMtZ3B1DQorDQorICAgICAg
cG93ZXItZG9tYWluczoNCisgICAgICAgIGRlc2NyaXB0aW9uOiBQaGFuZGxlIHRvIHRoZSBhc3Nv
Y2lhdGVkIHBvd2VyIGRvbWFpbg0KKyAgICAgICAgbWF4SXRlbXM6IDENCisNCisgICAgICBvcGVy
YXRpbmctcG9pbnRzLXYyOiB0cnVlDQorDQorICAgICAgdmNwdS1saXR0bGUtc3VwcGx5Og0KKyAg
ICAgICAgZGVzY3JpcHRpb246IFBNSUMgYnVjayBvZiBsaXR0bGUgQ1BVDQorDQorICAgICAgdmNw
dS1iaWctc3VwcGx5Og0KKyAgICAgICAgZGVzY3JpcHRpb246IFBNSUMgYnVjayBvZiBiaWcgQ1BV
DQorDQorICAgICAgdmNjaS1zdXBwbHk6DQorICAgICAgICBkZXNjcmlwdGlvbjogUE1JQyBidWNr
IG9mIENDSQ0KKw0KKyAgICAgIHZncHUtc3BwbHk6DQorICAgICAgICBkZXNjcmlwdGlvbjogUE1J
QyBidWNrIG9mIEdQVQ0KKw0KKyAgICByZXF1aXJlZDoNCisgICAgICAtIGNvbXBhdGlibGUNCisg
ICAgICAtIG9wZXJhdGluZy1wb2ludHMtdjINCisNCisgICAgYWRkaXRpb25hbFByb3BlcnRpZXM6
IGZhbHNlDQorDQorcmVxdWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQorICAtIGlu
dGVycnVwdHMNCisgIC0gY2xvY2tzDQorICAtIGNsb2NrLW5hbWVzDQorICAtIG52bWVtLWNlbGxz
DQorICAtIG52bWVtLWNlbGwtbmFtZXMNCisNCithZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UN
CisNCitleGFtcGxlczoNCisgIC0gfA0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2sv
bXQ4MTgzLWNsay5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRy
b2xsZXIvYXJtLWdpYy5oPg0KKyAgICAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNv
bnRyb2xsZXIvaXJxLmg+DQorICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9wb3dlci9tdDgxODMt
cG93ZXIuaD4NCisNCisgICAgc3ZzOiBzdnNAMTEwMGIwMDAgew0KKyAgICAgICAgY29tcGF0aWJs
ZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzIjsNCisgICAgICAgIHJlZyA9IDwwIDB4MTEwMGIwMDAg
MCAweDEwMDA+Ow0KKyAgICAgICAgaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEyNyBJUlFfVFlQRV9M
RVZFTF9MT1c+Ow0KKyAgICAgICAgY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFfVEhFUk0+
Ow0KKyAgICAgICAgY2xvY2stbmFtZXMgPSAibWFpbiI7DQorICAgICAgICBudm1lbS1jZWxscyA9
IDwmc3ZzX2NhbGlicmF0aW9uPiwgPCZ0aGVybWFsX2NhbGlicmF0aW9uPjsNCisgICAgICAgIG52
bWVtLWNlbGwtbmFtZXMgPSAic3ZzLWNhbGlicmF0aW9uLWRhdGEiLCAiY2FsaWJyYXRpb24tZGF0
YSI7DQorDQorICAgICAgICBzdnNfY3B1X2xpdHRsZTogc3ZzLWNwdS1saXR0bGUgew0KKyAgICAg
ICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXN2cy1jcHUtbGl0dGxlIjsNCisg
ICAgICAgICAgICBvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZjbHVzdGVyMF9vcHA+Ow0KKyAgICAg
ICAgICAgIHZjcHUtbGl0dGxlLXN1cHBseSA9IDwmbXQ2MzU4X3Zwcm9jMTJfcmVnPjsNCisgICAg
ICAgIH07DQorDQorICAgICAgICBzdnNfY3B1X2JpZzogc3ZzLWNwdS1iaWcgew0KKyAgICAgICAg
ICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXN2cy1jcHUtYmlnIjsNCisgICAgICAg
ICAgICBvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZjbHVzdGVyMV9vcHA+Ow0KKyAgICAgICAgICAg
IHZjcHUtYmlnLXN1cHBseSA9IDwmbXQ2MzU4X3Zwcm9jMTFfcmVnPjsNCisgICAgICAgIH07DQor
DQorICAgICAgICBzdnNfY2NpOiBzdnMtY2NpIHsNCisgICAgICAgICAgICBjb21wYXRpYmxlID0g
Im1lZGlhdGVrLG10ODE4My1zdnMtY2NpIjsNCisgICAgICAgICAgICBvcGVyYXRpbmctcG9pbnRz
LXYyID0gPCZjY2lfb3BwPjsNCisgICAgICAgICAgICB2Y2NpLXN1cHBseSA9IDwmbXQ2MzU4X3Zw
cm9jMTJfcmVnPjsNCisgICAgICAgIH07DQorDQorICAgICAgICBzdnNfZ3B1OiBzdnMtZ3B1IHsN
CisgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1zdnMtZ3B1IjsNCisg
ICAgICAgICAgICBwb3dlci1kb21haW5zID0gPCZzY3BzeXMgTVQ4MTgzX1BPV0VSX0RPTUFJTl9N
RkdfMkQ+Ow0KKyAgICAgICAgICAgIG9wZXJhdGluZy1wb2ludHMtdjIgPSA8JmdwdV9vcHBfdGFi
bGU+Ow0KKyAgICAgICAgICAgIHZncHUtc3BwbHkgPSA8Jm10NjM1OF92Z3B1X3JlZz47DQorICAg
ICAgICB9Ow0KKyAgICB9Ow0KLS0gDQoyLjE4LjANCg==

