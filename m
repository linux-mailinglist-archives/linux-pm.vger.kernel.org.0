Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D64FD243466
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 09:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgHMHIX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 03:08:23 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46250 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726639AbgHMHIW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 03:08:22 -0400
X-UUID: 4d3e63dde98149d9a01d08479df424f2-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gpARQxC1AZt6f+ZHYA/7gHQMcpim6UyqrkhBThG0UAQ=;
        b=kpNfml3PYikXEGUMU/PbMbDsTrdbe8rdMXh8hP2VlnDJ+IqaspNuaV/x9u2o8kXts5QzLWKFypHHOohQ5LH8Rrsx65w2ijtzlHGGdOvaBkjnq1m373OOWYD6SkhrsVdwyeiMs4kVgvRtW3FBXh5MezaqiC58VgV2L9/TaOPhRhY=;
X-UUID: 4d3e63dde98149d9a01d08479df424f2-20200813
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1978797628; Thu, 13 Aug 2020 15:08:18 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 15:08:08 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 15:08:08 +0800
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
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v2 2/2] dt-bindings: cpufreq: add bindings for MediaTek cpufreq HW
Date:   Thu, 13 Aug 2020 15:07:55 +0800
Message-ID: <1597302475-15484-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
References: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 243C5C9360AE5E81DE14DCB92FF591F7A9CBD5026502A21E5CC2BB3E2FE2F9952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgSFcgZHJpdmVyLg0KDQpTaWduZWQtb2ZmLWJ5
OiBIZWN0b3IuWXVhbiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KLS0tDQogLi4uL2JpbmRp
bmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgIDYxICsrKysrKysr
KysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYxIGluc2VydGlvbnMoKykNCiBjcmVhdGUg
bW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1
ZnJlcS1tZWRpYXRlay1ody55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3Lnlh
bWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwLi41OWJiMjRlDQotLS0gL2Rl
di9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9j
cHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwNCkBAIC0wLDAgKzEsNjEgQEANCisjIFNQRFgtTGljZW5z
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
K2V4YW1wbGVzOg0KKyAgLSB8DQorICAgIHNvYyB7DQorICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwyPjsNCisgICAgICAgICNzaXplLWNlbGxzID0gPDI+Ow0KKw0KKyAgICAgICAgY3B1ZnJlcV9o
dzogY3B1ZnJlcUAxMWJjMDAgew0KKyAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWVkaWF0ZWss
Y3B1ZnJlcS1odyI7DQorICAgICAgICAgICAgcmVnID0gPDAgMHgxMWJjMTAgMCAweDhjPiwNCisg
ICAgICAgICAgICAgICA8MCAweDExYmNhMCAwIDB4OGM+Ow0KKyAgICAgICAgICAgIHJlZy1uYW1l
cyA9ICJmcmVxLWRvbWFpbjAiLCAiZnJlcS1kb21haW4xIjsNCisgICAgICAgICAgICAjZnJlcS1k
b21haW4tY2VsbHMgPSA8MT47DQorICAgICAgICB9Ow0KKyAgICB9Ow0KKw0KLS0gDQoxLjcuOS41
DQo=

