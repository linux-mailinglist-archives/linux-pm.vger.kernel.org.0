Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F6C263425
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 19:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729507AbgIIRO5 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 13:14:57 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:44098 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726976AbgIIP3G (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 11:29:06 -0400
X-UUID: 36e0a08b229f472eadec214b44e570cc-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=6Ta4xbWlDnLHSIu1GOEg1nUgcgnCO6XZQfUX8n8EoXs=;
        b=etO8dCFeeYOusmFed/C8TjTy0V+rB4a+b9JonCzglWU5nKCMi9tUvrRjaV0oi7wxS2/pEzfQAXFORlNNe92iT7kBezcf6+dYpOC03wtzRFBxzxa3uJQI2CVV2djaAGZZW4cPATbuVDDnSeW1qqeTRT5eTOjWPDbusdQbM8DO+5w=;
X-UUID: 36e0a08b229f472eadec214b44e570cc-20200909
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1210527837; Wed, 09 Sep 2020 21:34:39 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 21:34:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 21:34:36 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v6] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Wed, 9 Sep 2020 21:34:34 +0800
Message-ID: <1599658476-16562-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhlIENQVWZyZXEgSFcgcHJlc2VudCBpbiBzb21lIE1lZGlhdGVrIGNoaXBzZXRzIG9mZmxvYWRz
IHRoZSBzdGVwcyBuZWNlc3NhcnkgZm9yIGNoYW5naW5nIHRoZSBmcmVxdWVuY3kgb2YgQ1BVcy4g
DQpUaGUgZHJpdmVyIGltcGxlbWVudHMgdGhlIGNwdWZyZXEgZHJpdmVyIGludGVyZmFjZSBmb3Ig
dGhpcyBoYXJkd2FyZSBlbmdpbmUuIA0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gdGhlIE1UNjc3
OSBEVFMgcGF0Y2ggc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4NCiBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAyMC84LzQvMTA5NA0KDQoNCkhlY3Rvci5ZdWFuICgyKToNCiAgY3B1ZnJlcTogbWVkaWF0
ZWstaHc6IEFkZCBzdXBwb3J0IGZvciBNZWRpYXRlayBjcHVmcmVxIEhXIGRyaXZlcg0KICBkdC1i
aW5kaW5nczogY3B1ZnJlcTogYWRkIGJpbmRpbmdzIGZvciBNZWRpYVRlayBjcHVmcmVxIEhXDQoN
CiAuLi4vYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgICAgICB8ICAx
NDEgKysrKysrKysrKw0KIGRyaXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybSAgICAgICAgICAgICAg
ICAgICAgICAgIHwgICAxMiArDQogZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlICAgICAgICAgICAg
ICAgICAgICAgICAgICAgfCAgICAxICsNCiBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJl
cS1ody5jICAgICAgICAgICAgICB8ICAyODMgKysrKysrKysrKysrKysrKysrKysNCiA0IGZpbGVz
IGNoYW5nZWQsIDQzNyBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFt
bA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1o
dy5j

