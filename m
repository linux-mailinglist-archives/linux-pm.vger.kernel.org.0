Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7B85298827
	for <lists+linux-pm@lfdr.de>; Mon, 26 Oct 2020 09:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1770202AbgJZITT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 26 Oct 2020 04:19:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:54768 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1736794AbgJZITS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 26 Oct 2020 04:19:18 -0400
X-UUID: 60e9d9da9cf54e4a9f945e5131eb7f5f-20201026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=VsODDh3KIxQlll6BhtrmRw5xCTw49FcPfdwVLthSeUg=;
        b=GcUYS6mmux9upFUuZMK36F2S5/mXm7cNAhYyhIfzjBkape/wnJ47wLBn80F4q9YDrLU972ELtjr+hzB2z2LDWPgN1nCGrkprkmfYofvyyQr0uD+IR2O530F15JS9g4dT9BTE0/QYLukzUdJkVCc8gb1PmAV1h6c6oLzuPpG4HKQ=;
X-UUID: 60e9d9da9cf54e4a9f945e5131eb7f5f-20201026
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 504100724; Mon, 26 Oct 2020 16:19:15 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 26 Oct 2020 16:19:13 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 26 Oct 2020 16:19:13 +0800
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
Subject: [PATCH v8] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Mon, 26 Oct 2020 16:19:06 +0800
Message-ID: <1603700349-5922-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIENQVWZyZXEgSFcgcHJlc2VudCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRz
IHRoZSBzdGVwcyBuZWNlc3NhcnkgZm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kgb2YgQ1BVcy4g
DQpUaGUgZHJpdmVyIGltcGxlbWVudHMgdGhlIGNwdWZyZXEgZHJpdmVyIGludGVyZmFjZSBmb3Ig
dGhpcyBoYXJkd2FyZSBlbmdpbmUuIA0KVGhpcyBwYXRjaCBkZXBlbmRzIG9uIE1UNjc3OSBEVFMg
cGF0Y2hbMV0gc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4uDQoNCkZyb20gdjcgdG8gdjgsIHRoZXJl
IGFyZSB0aHJlZSBtb3JlIHBhdGNoZXMgYmFzZWQgb24gcGF0Y2hzZXRbMl0uDQpUaGlzIHBhdGNo
c2V0IGlzIGFib3V0IHRvIHJlZ2lzdGVyIHBvd2VyIHRhYmxlIHRvIEVuZXJneSBtb2RlbCBmb3Ig
RUFTIGFuZCB0aGVybWFsIHVzYWdlLg0KMS4gRU0gQ1BVIHBvd2VyIHRhYmxlDQotIFJlZ2lzdGVy
IGVuZXJneSBtb2RlbCB0YWJsZSBmb3IgRUFTIGFuZCB0aGVybWFsIGNvb2xpbmcgZGV2aWNlIHVz
YWdlLg0KLSBSZWFkIHRoZSBjb3Jlc3BvbmRpbmcgTFVUIGZvciBwb3dlciB0YWJsZS4NCjIuIFNW
UyBpbml0aWFsaXphdGlvbg0KLSBUaGUgU1ZTKFNtYXJ0IFZvbHRhZ2UgU2NhbGluZykgZW5naW5l
IGlzIGEgaGFyZHdhcmUgd2hpY2ggaXMNCiAgdXNlZCB0byBjYWxjdWxhdGUgb3B0aW1pemVkIHZv
bHRhZ2UgdmFsdWVzIGZvciBDUFUgcG93ZXIgZG9tYWluLg0KICBEVkZTIGRyaXZlciBjb3VsZCBh
cHBseSB0aG9zZSBvcHRpbWl6ZWQgdm9sdGFnZSB2YWx1ZXMgdG8gcmVkdWNlIHBvd2VyIGNvbnN1
bXB0aW9uLg0KLSBEcml2ZXIgd2lsbCBwb2xsaW5nIGlmIEhXIGVuZ2luZSBpcyBkb25lIGZvciBT
VlMgaW5pdGlhbGl6YXRpb24uDQogIEFmdGVyIHRoYXQsIGRyaXZlciB3aWxsIHJlYWQgcG93ZXIg
dGFibGUgYW5kIHJlZ2lzdGVyIGl0IHRvIEVBUy4NCi0gQ1BVcyBtdXN0IGJlIGluIHBvd2VyIG9u
IHN0YXRlIHdoZW4gZG9pbmcgU1ZTLiBVc2UgcG1fcW9zIHRvIGJsb2NrIGNwdS1pZGxlIHN0YXRl
IGZvciBTVlMgaW5pdGlhbGl6aW5nLg0KMy4gQ29vbGluZyBkZXZpY2UgZmxhZw0KLSBBZGQgY29v
bGluZyBkZXZpY2UgZmxhZyBmb3IgdGhlcm1hbA0KDQpbMV0gaHR0cHM6Ly9sa21sLm9yZy9sa21s
LzIwMjAvOC80LzEwOTQNClsyXSBodHRwczovL2xrbWwub3JnL2xrbWwvMjAyMC85LzIzLzM4NA0K
DQoNCkhlY3Rvci5ZdWFuICgzKToNCiAgY3B1ZnJlcTogbWVkaWF0ZWstaHc6IEFkZCBzdXBwb3J0
IGZvciBDUFVGUkVRIEhXDQogIGR0LWJpbmRpbmdzOiBhcm06IGNwdXM6IERvY3VtZW50ICdtZWRp
YXRlayxmcmVxLWRvbWFpbicgcHJvcGVydHkNCiAgZHQtYmluZGluZ3M6IGNwdWZyZXE6IGFkZCBi
aW5kaW5ncyBmb3IgTWVkaWFUZWsgY3B1ZnJlcSBIVw0KDQogRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2FybS9jcHVzLnlhbWwgICAgfCAgICA2ICsNCiAuLi4vYmluZGluZ3MvY3B1
ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgICAgICB8ICAxMTMgKysrKysrKw0KIGRyaXZl
cnMvY3B1ZnJlcS9LY29uZmlnLmFybSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxMiArDQog
ZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgICAx
ICsNCiBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jICAgICAgICAgICAgICB8
ICAzNDMgKysrKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDQ3NSBpbnNlcnRp
b25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KIGNyZWF0ZSBtb2RlIDEwMDY0
NCBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5j

