Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E90F13202D
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 08:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727554AbgAGHC2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 02:02:28 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:24243 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727413AbgAGHC2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 02:02:28 -0500
X-UUID: 0a3b91bbc8644cb9bc0d39ddae3228c6-20200107
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Et48gACf9Egz+SR4ne4zbTYMcE1fV+LhbFdrbAdWJRk=;
        b=dEQYRML4xmWP7Ct2dK2+m/b+N5vZKzTZLYoXoXLgCfwhvIWCInYaJwEUynHV3a8w/zq2/ykIOieIlG4n34c4RFAfNezhwJgg0B4ONGuHyHTTifVF5CydRrfcauwBABVZ4SzxNWN0UP+cx67/PriPhYiDCfKOJXytjOuJICAkhR0=;
X-UUID: 0a3b91bbc8644cb9bc0d39ddae3228c6-20200107
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 2084706163; Tue, 07 Jan 2020 15:02:21 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 7 Jan 2020 15:01:19 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 7 Jan 2020 15:01:09 +0800
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
Subject: [PATCH v6 1/3] dt-bindings: soc: add mtk svs dt-bindings
Date:   Tue, 7 Jan 2020 15:01:52 +0800
Message-ID: <20200107070154.1574-2-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200107070154.1574-1-roger.lu@mediatek.com>
References: <20200107070154.1574-1-roger.lu@mediatek.com>
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
DQogLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcG93ZXIvbXRrLXN2cy50eHQgICAgIHwgNzYgKysr
KysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspDQogY3Jl
YXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlci9t
dGstc3ZzLnR4dA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3Bvd2VyL210ay1zdnMudHh0IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3Bvd2VyL210ay1zdnMudHh0DQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAw
MDAwLi45YTNlODFiOWUxZDINCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wb3dlci9tdGstc3ZzLnR4dA0KQEAgLTAsMCArMSw3NiBAQA0KKyog
TWVkaWF0ZWsgU21hcnQgVm9sdGFnZSBTY2FsaW5nIChNVEsgU1ZTKQ0KKw0KK1RoaXMgZGVzY3Jp
YmVzIHRoZSBkZXZpY2UgdHJlZSBiaW5kaW5nIGZvciB0aGUgTVRLIFNWUyBjb250cm9sbGVyIChi
YW5rKQ0KK3doaWNoIGhlbHBzIHByb3ZpZGUgdGhlIG9wdGltaXplZCBDUFUvR1BVL0NDSSB2b2x0
YWdlcy4gVGhpcyBkZXZpY2UgYWxzbw0KK25lZWRzIHRoZXJtYWwgZGF0YSB0byBjYWxjdWxhdGUg
dGhlcm1hbCBzbG9wZSBmb3IgYWNjdXJhdGVseSBjb21wZW5zYXRlDQordGhlIHZvbHRhZ2VzIHdo
ZW4gdGVtcGVyYXR1cmUgY2hhbmdlLg0KKw0KK1JlcXVpcmVkIHByb3BlcnRpZXM6DQorLSBjb21w
YXRpYmxlOg0KKyAgLSAibWVkaWF0ZWssbXQ4MTgzLXN2cyIgOiBGb3IgTVQ4MTgzIGZhbWlseSBv
ZiBTb0NzDQorLSByZWc6IEFkZHJlc3MgcmFuZ2Ugb2YgdGhlIE1USyBTVlMgY29udHJvbGxlci4N
CistIGludGVycnVwdHM6IElSUSBmb3IgdGhlIE1USyBTVlMgY29udHJvbGxlci4NCistIGNsb2Nr
cywgY2xvY2stbmFtZXM6IENsb2NrcyBuZWVkZWQgZm9yIHRoZSBzdnMgaGFyZHdhcmUuIHJlcXVp
cmVkDQorICAgICAgICAgICAgICAgICAgICAgICBjbG9ja3MgYXJlOg0KKwkJICAgICAgICJtYWlu
IjogTWFpbiBjbG9jayBmb3Igc3ZzIGNvbnRyb2xsZXIgdG8gd29yay4NCistIG52bWVtLWNlbGxz
OiBQaGFuZGxlIHRvIHRoZSBjYWxpYnJhdGlvbiBkYXRhIHByb3ZpZGVkIGJ5IGEgbnZtZW0gZGV2
aWNlLg0KKy0gbnZtZW0tY2VsbC1uYW1lczogU2hvdWxkIGJlICJzdnMtY2FsaWJyYXRpb24tZGF0
YSIgYW5kICJjYWxpYnJhdGlvbi1kYXRhIg0KKw0KK1N1Ym5vZGVzOg0KKy0gc3ZzLWNwdS1saXR0
bGU6IFNWUyBiYW5rIGRldmljZSBub2RlIG9mIGxpdHRsZSBDUFUNCisgIGNvbXBhdGlibGU6ICJt
ZWRpYXRlayxtdDgxODMtc3ZzLWNwdS1saXR0bGUiDQorICBvcGVyYXRpbmctcG9pbnRzLXYyOiBP
UFAgdGFibGUgaG9va2VkIGJ5IFNWUyBsaXR0bGUgQ1BVIGJhbmsuDQorCQkgICAgICAgU1ZTIHdp
bGwgb3B0aW16ZSB0aGlzIE9QUCB0YWJsZSB2b2x0YWdlIHBhcnQuDQorICB2Y3B1LWxpdHRsZS1z
dXBwbHk6IFBNSUMgYnVjayBvZiBsaXR0bGUgQ1BVDQorLSBzdnMtY3B1LWJpZzogU1ZTIGJhbmsg
ZGV2aWNlIG5vZGUgb2YgYmlnIENQVQ0KKyAgY29tcGF0aWJsZTogIm1lZGlhdGVrLG10ODE4My1z
dnMtY3B1LWJpZyINCisgIG9wZXJhdGluZy1wb2ludHMtdjI6IE9QUCB0YWJsZSBob29rZWQgYnkg
U1ZTIGJpZyBDUFUgYmFuay4NCisJCSAgICAgICBTVlMgd2lsbCBvcHRpbXplIHRoaXMgT1BQIHRh
YmxlIHZvbHRhZ2UgcGFydC4NCisgIHZjcHUtYmlnLXN1cHBseTogUE1JQyBidWNrIG9mIGJpZyBD
UFUNCistIHN2cy1jY2k6IFNWUyBiYW5rIGRldmljZSBub2RlIG9mIENDSQ0KKyAgY29tcGF0aWJs
ZTogIm1lZGlhdGVrLG10ODE4My1zdnMtY2NpIg0KKyAgb3BlcmF0aW5nLXBvaW50cy12MjogT1BQ
IHRhYmxlIGhvb2tlZCBieSBTVlMgQ0NJIGJhbmsuDQorCQkgICAgICAgU1ZTIHdpbGwgb3B0aW16
ZSB0aGlzIE9QUCB0YWJsZSB2b2x0YWdlIHBhcnQuDQorICB2Y2NpLXN1cHBseTogUE1JQyBidWNr
IG9mIENDSQ0KKy0gc3ZzLWdwdTogU1ZTIGJhbmsgZGV2aWNlIG5vZGUgb2YgR1BVDQorICBjb21w
YXRpYmxlOiAibWVkaWF0ZWssbXQ4MTgzLXN2cy1ncHUiDQorICBvcGVyYXRpbmctcG9pbnRzLXYy
OiBPUFAgdGFibGUgaG9va2VkIGJ5IFNWUyBHUFUgYmFuay4NCisJCSAgICAgICBTVlMgd2lsbCBv
cHRpbXplIHRoaXMgT1BQIHRhYmxlIHZvbHRhZ2UgcGFydC4NCisgIHZncHUtc3VwcGx5OiBQTUlD
IGJ1Y2sgb2YgR1BVDQorDQorRXhhbXBsZToNCisNCisJc3ZzOiBzdnNAMTEwMGIwMDAgew0KKwkJ
Y29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtc3ZzIjsNCisJCXJlZyA9IDwwIDB4MTEwMGIw
MDAgMCAweDEwMDA+Ow0KKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDEyNyBJUlFfVFlQRV9MRVZF
TF9MT1c+Ow0KKwkJY2xvY2tzID0gPCZpbmZyYWNmZyBDTEtfSU5GUkFfVEhFUk0+Ow0KKwkJY2xv
Y2stbmFtZXMgPSAibWFpbl9jbGsiOw0KKwkJbnZtZW0tY2VsbHMgPSA8JnN2c19jYWxpYnJhdGlv
bj4sIDwmdGhlcm1hbF9jYWxpYnJhdGlvbj47DQorCQludm1lbS1jZWxsLW5hbWVzID0gInN2cy1j
YWxpYnJhdGlvbi1kYXRhIiwgImNhbGlicmF0aW9uLWRhdGEiOw0KKw0KKwkJc3ZzX2NwdV9saXR0
bGU6IHN2cy1jcHUtbGl0dGxlIHsNCisJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1z
dnMtY3B1LWxpdHRsZSI7DQorCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmY2x1c3RlcjBfb3Bw
PjsNCisJCQl2Y3B1LWxpdHRsZS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47DQorCQl9
Ow0KKw0KKwkJc3ZzX2NwdV9iaWc6IHN2cy1jcHUtYmlnIHsNCisJCQljb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4My1zdnMtY3B1LWJpZyI7DQorCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwm
Y2x1c3RlcjFfb3BwPjsNCisJCQl2Y3B1LWJpZy1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzExX3Jl
Zz47DQorCQl9Ow0KKw0KKwkJc3ZzX2NjaTogc3ZzLWNjaSB7DQorCQkJY29tcGF0aWJsZSA9ICJt
ZWRpYXRlayxtdDgxODMtc3ZzLWNjaSI7DQorCQkJb3BlcmF0aW5nLXBvaW50cy12MiA9IDwmY2Np
X29wcD47DQorCQkJdmNjaS1zdXBwbHkgPSA8Jm10NjM1OF92cHJvYzEyX3JlZz47DQorCQl9Ow0K
Kw0KKwkJc3ZzX2dwdTogc3ZzLWdwdSB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgx
ODMtc3ZzLWdwdSI7DQorCQkJcG93ZXItZG9tYWlucyA9IDwmc2Nwc3lzIE1UODE4M19QT1dFUl9E
T01BSU5fTUZHXzJEPjsNCisJCQlvcGVyYXRpbmctcG9pbnRzLXYyID0gPCZncHVfb3BwX3RhYmxl
PjsNCisJCQl2Z3B1LXNwcGx5ID0gPCZtdDYzNThfdmdwdV9yZWc+Ow0KKwkJfTsNCisJfTsNCi0t
IA0KMi4xOC4wDQo=

