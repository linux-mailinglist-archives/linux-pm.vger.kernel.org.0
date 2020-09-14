Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E786F2682D9
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgINDFP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:05:15 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35987 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726105AbgINDFL (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:11 -0400
X-UUID: fe5ed44f85de406f83c6fe252e68f761-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nOOM9yhncstnm5UMFYqxtAtm4GAlmiu3+ZgwHqj+zAM=;
        b=dzCiJCPEb/5+CFfoRt5fzPpcsC4wK/qsTPnvqvXcnpQtTkI1EnARo6jsRziDF9sZhXhwkGEdYa6YCamuDQNs2GAIhBrXprn+8XzqFWSg1pvsA56s1qaYlYm1/xja2dktphn0fyg0UWjUxNVqWFjI+PK8KlmrsBpxJW2puMutbUI=;
X-UUID: fe5ed44f85de406f83c6fe252e68f761-20200914
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 453261723; Mon, 14 Sep 2020 11:04:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:48 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:48 +0800
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
Subject: [PATCH V5 09/17] dt-bindings: interconnect: add MT8183 interconnect dt-bindings
Date:   Mon, 14 Sep 2020 11:04:36 +0800
Message-ID: <1600052684-21198-10-git-send-email-henryc.chen@mediatek.com>
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

QWRkIGludGVyY29ubmVjdCBwcm92aWRlciBkdC1iaW5kaW5ncyBmb3IgTVQ4MTgzLg0KDQpTaWdu
ZWQtb2ZmLWJ5OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLnR4dCAgICAgICAgfCAg
MiArKw0KIGluY2x1ZGUvZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L210ayxtdDgxODMtZW1pLmgg
ICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKw0KIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0
aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2R0LWJpbmRpbmdzL2ludGVyY29u
bmVjdC9tdGssbXQ4MTgzLWVtaS5oDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy50eHQgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc29jL21lZGlhdGVrL2R2ZnNyYy50eHQNCmluZGV4IGQ1YTQ3ZDgu
Ljc2Y2E2MWQgMTAwNjQ0DQotLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
c29jL21lZGlhdGVrL2R2ZnNyYy50eHQNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9zb2MvbWVkaWF0ZWsvZHZmc3JjLnR4dA0KQEAgLTE0LDYgKzE0LDcgQEAgUmVxdWly
ZWQgUHJvcGVydGllczoNCiAtIGNsb2NrLW5hbWVzOiBNdXN0IGluY2x1ZGUgdGhlIGZvbGxvd2lu
ZyBlbnRyaWVzOg0KIAkiZHZmc3JjIjogRFZGU1JDIG1vZHVsZSBjbG9jaw0KIC0gY2xvY2tzOiBN
dXN0IGNvbnRhaW4gYW4gZW50cnkgZm9yIGVhY2ggZW50cnkgaW4gY2xvY2stbmFtZXMuDQorLSAj
aW50ZXJjb25uZWN0LWNlbGxzIDogc2hvdWxkIGNvbnRhaW4gMQ0KIA0KIEV4YW1wbGU6DQogDQpA
QCAtMjIsNCArMjMsNSBAQCBFeGFtcGxlOg0KIAkJcmVnID0gPDAgMHgxMDAxMjAwMCAwIDB4MTAw
MD47DQogCQljbG9ja3MgPSA8JmluZnJhY2ZnIENMS19JTkZSQV9EVkZTUkM+Ow0KIAkJY2xvY2st
bmFtZXMgPSAiZHZmc3JjIjsNCisJCSNpbnRlcmNvbm5lY3QtY2VsbHMgPSA8MT47DQogCX07DQpk
aWZmIC0tZ2l0IGEvaW5jbHVkZS9kdC1iaW5kaW5ncy9pbnRlcmNvbm5lY3QvbXRrLG10ODE4My1l
bWkuaCBiL2luY2x1ZGUvZHQtYmluZGluZ3MvaW50ZXJjb25uZWN0L210ayxtdDgxODMtZW1pLmgN
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4yYTU0ODU2DQotLS0gL2Rldi9u
dWxsDQorKysgYi9pbmNsdWRlL2R0LWJpbmRpbmdzL2ludGVyY29ubmVjdC9tdGssbXQ4MTgzLWVt
aS5oDQpAQCAtMCwwICsxLDE4IEBADQorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0y
LjAgKi8NCisNCisjaWZuZGVmIF9fRFRfQklORElOR1NfSU5URVJDT05ORUNUX01US19NVDgxODNf
RU1JX0gNCisjZGVmaW5lIF9fRFRfQklORElOR1NfSU5URVJDT05ORUNUX01US19NVDgxODNfRU1J
X0gNCisNCisjZGVmaW5lIE1UODE4M19TTEFWRV9ERFJfRU1JCQkJMA0KKyNkZWZpbmUgTVQ4MTgz
X01BU1RFUl9NQ1VTWVMJCQkxDQorI2RlZmluZSBNVDgxODNfTUFTVEVSX0dQVQkJCTINCisjZGVm
aW5lIE1UODE4M19NQVNURVJfTU1TWVMJCQkzDQorI2RlZmluZSBNVDgxODNfTUFTVEVSX01NX1ZQ
VQkJCTQNCisjZGVmaW5lIE1UODE4M19NQVNURVJfTU1fRElTUAkJCTUNCisjZGVmaW5lIE1UODE4
M19NQVNURVJfTU1fVkRFQwkJCTYNCisjZGVmaW5lIE1UODE4M19NQVNURVJfTU1fVkVOQwkJCTcN
CisjZGVmaW5lIE1UODE4M19NQVNURVJfTU1fQ0FNCQkJOA0KKyNkZWZpbmUgTVQ4MTgzX01BU1RF
Ul9NTV9JTUcJCQk5DQorI2RlZmluZSBNVDgxODNfTUFTVEVSX01NX01EUAkJCTEwDQorDQorI2Vu
ZGlmDQotLSANCjEuOS4xDQo=

