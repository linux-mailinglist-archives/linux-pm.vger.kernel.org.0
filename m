Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01856296B29
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460538AbgJWIZO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:25:14 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39533 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S460534AbgJWIZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:25:12 -0400
X-UUID: 5f0bcd56c56b4c558906e803db9aca9d-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0VcRiI/47uBH8qw621lJkqfCixACdBgrTLwaebngM9Y=;
        b=r65d5i8gAyCDBYrLqsR7ei8d2pn+b/amXSMV2VYOCbA/0PKIWP5/Up19zNfAGrOvjrhNYCw4RMbhAprIKM9YRFqE6jXtzCTkQJVx0vrvWxRZLA/XbcJAa+vrRT+5pX9wAzht3ceN/M8HHHt+LojLjgtCrov4IUXJ8JtijlVsZ70=;
X-UUID: 5f0bcd56c56b4c558906e803db9aca9d-20201023
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1743175875; Fri, 23 Oct 2020 16:25:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 16:24:59 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 16:24:59 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <devicetree@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v1 3/6] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Fri, 23 Oct 2020 16:24:50 +0800
Message-ID: <1603441493-18554-4-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgSFcgZHJpdmVyLg0KDQpTaWduZWQtb2ZmLWJ5
OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRp
bmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgIDQ2ICsrKysrKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDQ2IGluc2VydGlvbnMoKykNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1
ZnJlcS1tZWRpYXRlay1ody55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3Lnlh
bWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi5hOTlmNDRmDQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9j
cHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwNCkBAIC0wLDAgKzEsNDYgQEANCisjIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkNCislWUFNTCAxLjIN
CistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL2NwdWZyZXEvY3B1ZnJl
cS1tZWRpYXRlay1ody55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRh
LXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBNZWRpYVRlaydzIENQVUZSRVEgQmluZGlu
Z3MNCisNCittYWludGFpbmVyczoNCisgIC0gSGVjdG9yIFl1YW4gPGhlY3Rvci55dWFuQG1lZGlh
dGVrLmNvbT4NCisNCitkZXNjcmlwdGlvbjoNCisgIENQVUZSRVEgSFcgaXMgYSBoYXJkd2FyZSBl
bmdpbmUgdXNlZCBieSBNZWRpYVRlaw0KKyAgU29DcyB0byBtYW5hZ2UgZnJlcXVlbmN5IGluIGhh
cmR3YXJlLiBJdCBpcyBjYXBhYmxlIG9mIGNvbnRyb2xsaW5nIGZyZXF1ZW5jeQ0KKyAgZm9yIG11
bHRpcGxlIGNsdXN0ZXJzLg0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBj
b25zdDogbWVkaWF0ZWssY3B1ZnJlcS1odw0KKw0KKyAgcmVnOg0KKyAgICBtaW5JdGVtczogMQ0K
KyAgICBtYXhJdGVtczogMg0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAgIEFkZHJlc3NlcyBh
bmQgc2l6ZXMgZm9yIHRoZSBtZW1vcnkgb2YgdGhlIEhXIGJhc2VzIGluIGVhY2ggZnJlcXVlbmN5
IGRvbWFpbi4NCisNCityZXF1aXJlZDoNCisgIC0gY29tcGF0aWJsZQ0KKyAgLSByZWcNCisNCitl
eGFtcGxlczoNCisgIC0gfA0KKyAgICBzb2Mgew0KKyAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8
Mj47DQorICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCisNCisgICAgICAgIGNwdWZyZXFfaHc6
IGNwdWZyZXFAMTFiYzAwIHsNCisgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLGNw
dWZyZXEtaHciOw0KKyAgICAgICAgICAgIHJlZyA9IDwwIDB4MTFiYzEwIDAgMHg4Yz4sDQorICAg
ICAgICAgICAgICAgPDAgMHgxMWJjYTAgMCAweDhjPjsNCisgICAgICAgIH07DQorICAgIH07DQor
DQorDQorDQorDQotLSANCjEuNy45LjUNCg==

