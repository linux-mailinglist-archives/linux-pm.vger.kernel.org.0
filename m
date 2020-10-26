Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00532298829
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 09:19:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770816AbgJZITV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 04:19:21 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54744 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1736790AbgJZITU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 04:19:20 -0400
X-UUID: dc875c41c5794d33bc8409725bcdc169-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OorCNuODuPaiqUDoyfpo5/p6Zg42Hars9OJsK2xA+SI=;
        b=ceahJheCV8fb+NTqM72bAML1hCQY1KhM++jEQ8eNIYLgLL/TEAJEfPELt8HgS2Qwmii1CcNvtLgkqZbeQSrkggnfZA1qG6O/hiXKNpqdn3WcuW2DEDottqQyccFRsW6Dw+qLlPM3yGifWZuWBv6KMZdP1Lsexk0M5u+ZehUulqc=;
X-UUID: dc875c41c5794d33bc8409725bcdc169-20201026
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2045557172; Mon, 26 Oct 2020 16:19:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 16:19:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 16:19:14 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
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
Subject: [PATCH v8 2/3] dt-bindings: arm: cpus: Document 'mediatek,freq-domain' property
Date:   Mon, 26 Oct 2020 16:19:08 +0800
Message-ID: <1603700349-5922-3-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
References: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogIkhlY3Rvci5ZdWFuIiA8aGVjdG9yLnl1YW5AbWVkaWF0ZWsuY29tPg0KDQpBZGQgZGV2
aWNldHJlZSBkb2N1bWVudGF0aW9uIGZvciAnbWVkaWF0ZWssZnJlcS1kb21haW4nIHByb3BlcnR5
IHNwZWNpZmljDQp0byBNZWRpYXRlayBDUFVzLiBUaGlzIHByb3BlcnR5IGlzIHVzZWQgdG8gcmVm
ZXJlbmNlIHRoZSBDUFVGUkVRIG5vZGUNCmFsb25nIHdpdGggdGhlIGRvbWFpbiBpZC4NCg0KU2ln
bmVkLW9mZi1ieTogSGVjdG9yLll1YW4gPGhlY3Rvci55dWFuQG1lZGlhdGVrLmNvbT4NCi0tLQ0K
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sIHwgICAgNiAr
KysrKysNCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL2NwdXMueWFtbCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vY3B1cy55YW1sDQppbmRleCAxMjIyYmYxLi5l
OTk1YjI2IDEwMDY0NA0KLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Fy
bS9jcHVzLnlhbWwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0v
Y3B1cy55YW1sDQpAQCAtMjU1LDYgKzI1NSwxMiBAQCBwcm9wZXJ0aWVzOg0KIA0KICAgICAgIHdo
ZXJlIHZvbHRhZ2UgaXMgaW4gViwgZnJlcXVlbmN5IGlzIGluIE1Iei4NCiANCisgIG1lZGlhdGVr
LGZyZXEtZG9tYWluOg0KKyAgICAkcmVmOiAnL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlv
bnMvcGhhbmRsZS1hcnJheScNCisgICAgZGVzY3JpcHRpb246DQorICAgICAgQ1BVcyBzdXBwb3J0
aW5nIGZyZXEtZG9tYWluIG11c3Qgc2V0IHRoZWlyICJtZWRpYXRlayxmcmVxLWRvbWFpbiIgcHJv
cGVydHkNCisgICAgICB3aXRoIHBoYW5kbGUgdG8gYSBjcHVmcmVxX2h3IG5vZGUgZm9sbG93ZWQg
YnkgdGhlIGRvbWFpbiBpZC4NCisNCiAgIHBvd2VyLWRvbWFpbnM6DQogICAgICRyZWY6ICcvc2No
ZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy9waGFuZGxlLWFycmF5Jw0KICAgICBkZXNjcmlw
dGlvbjoNCi0tIA0KMS43LjkuNQ0K

