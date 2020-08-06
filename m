Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283FF23DFD3
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbgHFRx4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:53:56 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:57026 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728158AbgHFQaz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:30:55 -0400
X-UUID: 8a705a9515e04b39a6104849cbefd20c-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=hq0WCel81lE8aBCRSm65DN3f8dXfFefcGZQW+R17dLo=;
        b=Y2xVrIuwGI/P8R/00nM96g+DhrSFCLQRUZXV4uPxR4pI6N6PwHAWxxJlXn+q+xOUH8VkQIA/emt/xfOhOQcwlPclkctFwcm2+47lmBDJjhhjcoJRHh5lxD9SO4tE6uDtl5BB06K7VZ0GNJz+jkCAMxMZWXGB2MyIF8eyIePyNIA=;
X-UUID: 8a705a9515e04b39a6104849cbefd20c-20200806
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 63181443; Thu, 06 Aug 2020 20:18:46 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 20:18:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 20:18:44 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Vinod Koul <vkoul@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anson Huang <Anson.Huang@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Olof Johansson <olof@lixom.net>
CC:     <wsd_upstream@mediatek.com>, <hector.yuan@mediatek.com>
Subject: [PATCH v1 2/2] dt-bindings: cpufreq: add  MediaTek cpufreq bindings
Date:   Thu, 6 Aug 2020 20:18:40 +0800
Message-ID: <1596716320-19811-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1596716320-19811-1-git-send-email-hector.yuan@mediatek.com>
References: <1596716320-19811-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgSFcgZHJpdmVyLg0KDQpTaWduZWQtb2ZmLWJ5
OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRp
bmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgIDU2ICsrKysrKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKykNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1
ZnJlcS1tZWRpYXRlay1ody55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3Lnlh
bWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi4yYTM1MDk4DQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9j
cHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwNCkBAIC0wLDAgKzEsNTYgQEANCisjIFNQRFgtTGljZW5z
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
IGRvbWFpbi4NCisNCisgIHJlZy1uYW1lczoNCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDog
ImZyZXEtZG9tYWluMCINCisgICAgICAtIGNvbnN0OiAiZnJlcS1kb21haW4xIg0KKyAgICBkZXNj
cmlwdGlvbjogfA0KKyAgICAgIEZyZXF1ZW5jeSBkb21haW4gbmFtZS4NCisNCisgICIjZnJlcS1k
b21haW4tY2VsbHMiOg0KKyAgICBjb25zdDogMQ0KKyAgICBkZXNjcmlwdGlvbjogfA0KKyAgICAg
IE51bWJlciBvZiBjZWxscyBpbiBhIGZyZXFlbmN5IGRvbWFpbiBzcGVjaWZpZXIuDQorDQorcmVx
dWlyZWQ6DQorICAtIGNvbXBhdGlibGUNCisgIC0gcmVnDQorICAtIHJlZy1uYW1lcw0KKyAgLSAi
I2ZyZXEtZG9tYWluLWNlbGxzIg0KKw0KK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0K
K2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIGNwdWZyZXFfaHc6IGNwdWZyZXFAMTFiYzAwIHsNCisg
ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1lZGlhdGVrLGNwdWZyZXEtaHciOw0KKyAgICAgICAg
ICAgIHJlZyA9IDwwIDB4MTFiYzEwIDAgMHg4Yz4sDQorICAgICAgICAgICAgICAgIDwwIDB4MTFi
Y2EwIDAgMHg4Yz47DQorICAgICAgICAgICAgcmVnLW5hbWVzID0gImZyZXEtZG9tYWluMCIsICJm
cmVxLWRvbWFpbjEiOw0KKyAgICAgICAgICAgICNmcmVxLWRvbWFpbi1jZWxscyA9IDwxPjsNCisg
ICAgfTsNCisNCi0tIA0KMS43LjkuNQ0K

