Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 118B42682FA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbgINDHj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:07:39 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36695 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726075AbgINDEz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:04:55 -0400
X-UUID: c5fc2be83a854886b057f5a4e0ca5a17-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=3iNwgFEYsqQE0ecY/uJhBDR4AFw1KMuDJ1lQlv3adck=;
        b=gRMUGDhc/mDB7XojWDglCPRd06bWFcV/h4F2+UpErczFqni7pG7ShboQwCKp5O6uGWZgyJd6gleupK5oe37LOfeJ3X/CM8ZYtoNLRMw+33E7bM68AYRjZ/7T9sg6MjOh5FrzuG1nErDYs7J7ZZwRCBk5qauj83E12d2c81qFlfA=;
X-UUID: c5fc2be83a854886b057f5a4e0ca5a17-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2002611273; Mon, 14 Sep 2020 11:04:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH V5 01/17] dt-bindings: soc: Add dvfsrc driver bindings
Date:   Mon, 14 Sep 2020 11:04:28 +0800
Message-ID: <1600052684-21198-2-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 2BBBC37BC1269D0C0C35EF6A095D4F2182244D1975B471AD2F58AE758DEEED542000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RG9jdW1lbnQgdGhlIGJpbmRpbmcgZm9yIGVuYWJsaW5nIGR2ZnNyYyBvbiBNZWRpYVRlayBTb0Mu
DQoNClNpZ25lZC1vZmYtYnk6IEhlbnJ5IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4N
ClJldmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KLS0tDQogLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy50eHQgICAgfCAyNSArKysrKysr
KysrKysrKysrKysrKysrDQogaW5jbHVkZS9kdC1iaW5kaW5ncy9zb2MvbXRrLGR2ZnNyYy5oICAg
ICAgICAgICAgICAgfCAxNCArKysrKysrKysrKysNCiAyIGZpbGVzIGNoYW5nZWQsIDM5IGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMudHh0DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1
ZGUvZHQtYmluZGluZ3Mvc29jL210ayxkdmZzcmMuaA0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMudHh0IGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kdmZzcmMudHh0DQpuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uZDVhNDdkOA0KLS0tIC9kZXYvbnVsbA0K
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9tZWRpYXRlay9kdmZz
cmMudHh0DQpAQCAtMCwwICsxLDI1IEBADQorTWVkaWFUZWsgRFZGU1JDDQorDQorVGhlIER5bmFt
aWMgVm9sdGFnZSBhbmQgRnJlcXVlbmN5IFNjYWxpbmcgUmVzb3VyY2UgQ29sbGVjdG9yIChEVkZT
UkMpIGlzIGENCitIVyBtb2R1bGUgd2hpY2ggaXMgdXNlZCB0byBjb2xsZWN0IGFsbCB0aGUgcmVx
dWVzdHMgZnJvbSBib3RoIHNvZnR3YXJlIGFuZA0KK2hhcmR3YXJlIGFuZCB0dXJuIGludG8gdGhl
IGRlY2lzaW9uIG9mIG1pbmltdW0gb3BlcmF0aW5nIHZvbHRhZ2UgYW5kIG1pbmltdW0NCitEUkFN
IGZyZXF1ZW5jeSB0byBmdWxmaWxsIHRob3NlIHJlcXVlc3RzLg0KKw0KK1JlcXVpcmVkIFByb3Bl
cnRpZXM6DQorLSBjb21wYXRpYmxlOiBTaG91bGQgYmUgb25lIG9mIHRoZSBmb2xsb3dpbmcNCisJ
LSAibWVkaWF0ZWssbXQ2ODczLWR2ZnNyYyI6IEZvciBNVDY4NzMgU29DDQorCS0gIm1lZGlhdGVr
LG10ODE4My1kdmZzcmMiOiBGb3IgTVQ4MTgzIFNvQw0KKwktICJtZWRpYXRlayxtdDgxOTItZHZm
c3JjIjogRm9yIE1UODE5MiBTb0MNCistIHJlZzogQWRkcmVzcyByYW5nZSBvZiB0aGUgRFZGU1JD
IHVuaXQNCistIGNsb2NrLW5hbWVzOiBNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2luZyBlbnRyaWVz
Og0KKwkiZHZmc3JjIjogRFZGU1JDIG1vZHVsZSBjbG9jaw0KKy0gY2xvY2tzOiBNdXN0IGNvbnRh
aW4gYW4gZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gY2xvY2stbmFtZXMuDQorDQorRXhhbXBsZToN
CisNCisJZHZmc3JjQDEwMDEyMDAwIHsNCisJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgz
LWR2ZnNyYyI7DQorCQlyZWcgPSA8MCAweDEwMDEyMDAwIDAgMHgxMDAwPjsNCisJCWNsb2NrcyA9
IDwmaW5mcmFjZmcgQ0xLX0lORlJBX0RWRlNSQz47DQorCQljbG9jay1uYW1lcyA9ICJkdmZzcmMi
Ow0KKwl9Ow0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHQtYmluZGluZ3Mvc29jL210ayxkdmZzcmMu
aCBiL2luY2x1ZGUvZHQtYmluZGluZ3Mvc29jL210ayxkdmZzcmMuaA0KbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCmluZGV4IDAwMDAwMDAuLmE1MjI0ODgNCi0tLSAvZGV2L251bGwNCisrKyBiL2luY2x1
ZGUvZHQtYmluZGluZ3Mvc29jL210ayxkdmZzcmMuaA0KQEAgLTAsMCArMSwxNCBAQA0KKy8qIFNQ
RFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorICoNCisgKiBDb3B5cmlnaHQgKGMpIDIw
MTggTWVkaWFUZWsgSW5jLg0KKyAqLw0KKw0KKyNpZm5kZWYgX0RUX0JJTkRJTkdTX1BPV0VSX01U
S19EVkZTUkNfSA0KKyNkZWZpbmUgX0RUX0JJTkRJTkdTX1BPV0VSX01US19EVkZTUkNfSA0KKw0K
KyNkZWZpbmUgTVQ4MTgzX0RWRlNSQ19MRVZFTF8xCTENCisjZGVmaW5lIE1UODE4M19EVkZTUkNf
TEVWRUxfMgkyDQorI2RlZmluZSBNVDgxODNfRFZGU1JDX0xFVkVMXzMJMw0KKyNkZWZpbmUgTVQ4
MTgzX0RWRlNSQ19MRVZFTF80CTQNCisNCisjZW5kaWYgLyogX0RUX0JJTkRJTkdTX1BPV0VSX01U
S19EVkZTUkNfSCAqLw0KLS0gDQoxLjkuMQ0K

