Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEF5296B27
	for <lists+linux-pm@lfdr.de>; Fri, 23 Oct 2020 10:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S460592AbgJWIZa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Oct 2020 04:25:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39521 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S371580AbgJWIZO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Oct 2020 04:25:14 -0400
X-UUID: 8b632fbf3d824c47bb44cf15dc646fe4-20201023
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Hl2C1/KpnGuBDsUTL5EqzX0y7l/0KQjCffhP/cb6JWg=;
        b=u8Zvq8u4M07M2DW55pSGW6z49E7QiWxNbyOe+RA2Q5YpD7dQrL6pdX8N+tUwKudVvrr9REEocSSmxGuUTO+x8FvaJFoD5x5uKDE7O1Nf4NmtkHCsmCmo3zSKZwl4Dm+kDgmmHs4INCwIldMSapzn51x/k61lkn/AN469D2gI/Eo=;
X-UUID: 8b632fbf3d824c47bb44cf15dc646fe4-20201023
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 683705731; Fri, 23 Oct 2020 16:25:00 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 23 Oct 2020 16:24:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 23 Oct 2020 16:24:55 +0800
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
Subject: [PATCH v1 2/6] dt-bindings: arm: cpus: Document 'mtk,freq-domain' property
Date:   Fri, 23 Oct 2020 16:24:49 +0800
Message-ID: <1603441493-18554-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 53C7D773113909F92F9C837D2A74572C57D32B39C264274820D612D1E8E54F962000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBkb2N1bWVudGF0aW9uIGZvciAnbXRrLGZyZXEtZG9tYWluJyBwcm9wZXJ0eSBzcGVj
aWZpYw0KdG8gTWVkaWF0ZWsgQ1BVcy4gVGhpcyBwcm9wZXJ0eSBpcyB1c2VkIHRvIHJlZmVyZW5j
ZSB0aGUgQ1BVRlJFUSBub2RlDQphbG9uZyB3aXRoIHRoZSBkb21haW4gaWQuDQoNClNpZ25lZC1v
ZmYtYnk6IEhlY3Rvci5ZdWFuIDxoZWN0b3IueXVhbkBtZWRpYXRlay5jb20+DQotLS0NCiBEb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbCB8ICAgIDYgKysrKysr
DQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9jcHVzLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbA0KaW5kZXggMTIyMmJmMS4uMDZhNmY1
YiAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1
cy55YW1sDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMu
eWFtbA0KQEAgLTI1NSw2ICsyNTUsMTIgQEAgcHJvcGVydGllczoNCiANCiAgICAgICB3aGVyZSB2
b2x0YWdlIGlzIGluIFYsIGZyZXF1ZW5jeSBpcyBpbiBNSHouDQogDQorICBtdGstZnJlcS1kb21h
aW46DQorICAgICRyZWY6ICcvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxl
LWFycmF5Jw0KKyAgICBkZXNjcmlwdGlvbjoNCisgICAgICBDUFVzIHN1cHBvcnRpbmcgZnJlcS1k
b21haW4gbXVzdCBzZXQgdGhlaXIgIm10ay1mcmVxLWRvbWFpbiIgcHJvcGVydHkNCisgICAgICB3
aXRoIHBoYW5kbGUgdG8gYSBjcHVmcmVxX2h3IG5vZGUgZm9sbG93ZWQgYnkgdGhlIGRvbWFpbiBp
ZC4NCisNCiAgIHBvd2VyLWRvbWFpbnM6DQogICAgICRyZWY6ICcvc2NoZW1hcy90eXBlcy55YW1s
Iy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5Jw0KICAgICBkZXNjcmlwdGlvbjoNCi0tIA0KMS43
LjkuNQ0K

