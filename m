Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 340701843D2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgCMJeg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:36 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12079 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726377AbgCMJef (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:35 -0400
X-UUID: fde83ec298e04a80834a9d2e4d453eef-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=dHVIssRQ//ChPQ0rQbsqbfW2EvYkungBACJezcgPQ3Y=;
        b=Nh1Yrv507nI8PNsTjY//9qa99WyonrmMS9EkFoLLQj+CTKWmcMPKt8sW/D3z5NDJO5CYJ0+/uL3KLQmDUn8oYB37iCY90lXOn5EehObXSvbtDwMxmkp+7PHY2Wd4KdOAtweiPacZSFNL2AN7FqQBDYroGyMBIkx+clGbEZ+Bh60=;
X-UUID: fde83ec298e04a80834a9d2e4d453eef-20200313
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 121892569; Fri, 13 Mar 2020 17:34:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:32:17 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:41 +0800
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
        <srv_heupstream@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V4 08/13] dt-bindings: interconnect: add MT8183 interconnect dt-bindings
Date:   Fri, 13 Mar 2020 17:34:21 +0800
Message-ID: <1584092066-24425-9-git-send-email-henryc.chen@mediatek.com>
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

QWRkIGludGVyY29ubmVjdCBwcm92aWRlciBkdC1iaW5kaW5ncyBmb3IgTVQ4MTgzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLnR4dCAgICAgICAgfCAg
OSArKysrKysrKysNCiBpbmNsdWRlL2R0LWJpbmRpbmdzL2ludGVyY29ubmVjdC9tdGssbXQ4MTgz
LWVtaS5oICAgICAgfCAxOCArKysrKysrKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDI3
IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9kdC1iaW5kaW5ncy9p
bnRlcmNvbm5lY3QvbXRrLG10ODE4My1lbWkuaA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMudHh0IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMudHh0DQppbmRleCA3
ZjQzNDk5Li5kYTk4ZWM5IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy50eHQNCkBAIC0xMiw2ICsxMiwxMSBA
QCBSZXF1aXJlZCBQcm9wZXJ0aWVzOg0KIC0gY2xvY2stbmFtZXM6IE11c3QgaW5jbHVkZSB0aGUg
Zm9sbG93aW5nIGVudHJpZXM6DQogCSJkdmZzcmMiOiBEVkZTUkMgbW9kdWxlIGNsb2NrDQogLSBj
bG9ja3M6IE11c3QgY29udGFpbiBhbiBlbnRyeSBmb3IgZWFjaCBlbnRyeSBpbiBjbG9jay1uYW1l
cy4NCistICNpbnRlcmNvbm5lY3QtY2VsbHMgOiBzaG91bGQgY29udGFpbiAxDQorLSBpbnRlcmNv
bm5lY3QgOiBpbnRlcmNvbm5lY3QgcHJvdmlkZXJzIHN1cHBvcnQgZHJhbSBiYW5kd2lkdGggcmVx
dWlyZW1lbnRzLg0KKwlUaGUgcHJvdmlkZXIgaXMgYWJsZSB0byBjb21tdW5pY2F0ZSB3aXRoIHRo
ZSBEVkZTUkMgYW5kIHNlbmQgdGhlIGRyYW0NCisJYmFuZHdpZHRoIHRvIGl0LiBzaGFsbCBjb250
YWluIG9ubHkgb25lIG9mIHRoZSBmb2xsb3dpbmc6DQorCSJtZWRpYXRlayxtdDgxODMtZW1pIg0K
IA0KIEV4YW1wbGU6DQogDQpAQCAtMjAsNCArMjUsOCBAQCBFeGFtcGxlOg0KIAkJcmVnID0gPDAg
MHgxMDAxMjAwMCAwIDB4MTAwMD47DQogCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9E
VkZTUkM+Ow0KIAkJY2xvY2stbmFtZXMgPSAiZHZmc3JjIjsNCisJCWRkcl9lbWk6IGludGVyY29u
bmVjdCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZW1pIjsNCisJCQkjaW50
ZXJjb25uZWN0LWNlbGxzID0gPDE+Ow0KKwkJfTsNCiAJfTsNCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2R0LWJpbmRpbmdzL2ludGVyY29ubmVjdC9tdGssbXQ4MTgzLWVtaS5oIGIvaW5jbHVkZS9kdC1i
aW5kaW5ncy9pbnRlcmNvbm5lY3QvbXRrLG10ODE4My1lbWkuaA0KbmV3IGZpbGUgbW9kZSAxMDA2
NDQNCmluZGV4IDAwMDAwMDAuLjJhNTQ4NTYNCi0tLSAvZGV2L251bGwNCisrKyBiL2luY2x1ZGUv
ZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L210ayxtdDgxODMtZW1pLmgNCkBAIC0wLDAgKzEsMTgg
QEANCisvKiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCAqLw0KKw0KKyNpZm5kZWYg
X19EVF9CSU5ESU5HU19JTlRFUkNPTk5FQ1RfTVRLX01UODE4M19FTUlfSA0KKyNkZWZpbmUgX19E
VF9CSU5ESU5HU19JTlRFUkNPTk5FQ1RfTVRLX01UODE4M19FTUlfSA0KKw0KKyNkZWZpbmUgTVQ4
MTgzX1NMQVZFX0REUl9FTUkJCQkwDQorI2RlZmluZSBNVDgxODNfTUFTVEVSX01DVVNZUwkJCTEN
CisjZGVmaW5lIE1UODE4M19NQVNURVJfR1BVCQkJMg0KKyNkZWZpbmUgTVQ4MTgzX01BU1RFUl9N
TVNZUwkJCTMNCisjZGVmaW5lIE1UODE4M19NQVNURVJfTU1fVlBVCQkJNA0KKyNkZWZpbmUgTVQ4
MTgzX01BU1RFUl9NTV9ESVNQCQkJNQ0KKyNkZWZpbmUgTVQ4MTgzX01BU1RFUl9NTV9WREVDCQkJ
Ng0KKyNkZWZpbmUgTVQ4MTgzX01BU1RFUl9NTV9WRU5DCQkJNw0KKyNkZWZpbmUgTVQ4MTgzX01B
U1RFUl9NTV9DQU0JCQk4DQorI2RlZmluZSBNVDgxODNfTUFTVEVSX01NX0lNRwkJCTkNCisjZGVm
aW5lIE1UODE4M19NQVNURVJfTU1fTURQCQkJMTANCisNCisjZW5kaWYNCi0tIA0KMS45LjENCg==

