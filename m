Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE624345F
	for <lists+linux-pm@lfdr.de>; Thu, 13 Aug 2020 09:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgHMHIH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Aug 2020 03:08:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:55533 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725982AbgHMHIG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Aug 2020 03:08:06 -0400
X-UUID: 2c024129dac94eefb06f8e9923260d7e-20200813
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Em+aZRblnSBBXfbIqqdD7o9UIm1k6YffKGxm9JLcp40=;
        b=GJymZi33EF/dF6e1Y00qJmDN/6669Y/F3GNzCAAiaH1F+lSaDZsXD5tW5gWiygBqymQffYZ6VAy0ap8b5vAbCtNmqhkx1GMpqnybIdu1UdTbhQPwiianQzm9JFf8AJEIZdTfmAdEfHB8GRk0Ekt1xzf8Gzp6mWdSkMfOgNXWydc=;
X-UUID: 2c024129dac94eefb06f8e9923260d7e-20200813
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1870755673; Thu, 13 Aug 2020 15:08:01 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 13 Aug 2020 15:07:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Aug 2020 15:07:58 +0800
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
Subject: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Thu, 13 Aug 2020 15:07:53 +0800
Message-ID: <1597302475-15484-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 22E7736455FFC7AFAC1005B33F5D3A93FDE664E47FE8A993C0634980A15532C92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIENQVWZyZXEgSFcgcHJlc2VudCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRz
DQp0aGUgc3RlcHMgbmVjZXNzYXJ5IGZvciBjaGFuZ2luZyB0aGUgZnJlcXVlbmN5IG9mIENQVXMu
DQpUaGUgZHJpdmVyIGltcGxlbWVudHMgdGhlIGNwdWZyZXEgZHJpdmVyIGludGVyZmFjZSBmb3IN
CnRoaXMgaGFyZHdhcmUgZW5naW5lLiANCg0KVGhpcyBwYXRjaCBkZXBlbmRzIG9uIHRoZSBNVDY3
NzkgRFRTIHBhdGNoIHN1Ym1pdHRlZCBieSBIYW5rcyBDaGVuDQogaHR0cHM6Ly9sa21sLm9yZy9s
a21sLzIwMjAvOC80LzEwOTQNCg0KDQpIZWN0b3IuWXVhbiAoMik6DQogIGR0LWJpbmRpbmdzOiBj
cHVmcmVxOiBhZGQgYmluZGluZ3MgZm9yIE1lZGlhVGVrIGNwdWZyZXEgSFcNCiAgY3B1ZnJlcTog
bWVkaWF0ZWstaHc6IEFkZCBzdXBwb3J0IGZvciBNZWRpYXRlayBjcHVmcmVxIEhXIGRyaXZlcg0K
DQogLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAg
IDYxICsrKysrDQogYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAg
ICAgICAgfCAgICAxICsNCiBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZy5hcm0gICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMTEgKw0KIGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMSArDQogZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZy
ZXEtaHcuYyAgICAgICAgICAgICAgfCAgMjU1ICsrKysrKysrKysrKysrKysrKysrDQogNSBmaWxl
cyBjaGFuZ2VkLCAzMjkgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3Lnlh
bWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEt
aHcuYw0K

