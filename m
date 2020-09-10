Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC77263C08
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 06:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgIJEbT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 00:31:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8710 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725372AbgIJEbK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 00:31:10 -0400
X-UUID: 032b2ff9dcec4b6c949ac288fe68e278-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=2htd7M6DykqGF8tAcRkyCSKqlUafEqHfM5E33nlVBCI=;
        b=X9SoaKfN68aafE6YjUwaDonkAVajPry3+ryDpprnRWdjEYlVTpZn/85q+Hl19fFRYfcAZUPINoqwRf7ytaQeubkpCw+0HHtR6XZ4Ko8+ZnPudEUXkDfKdR04vdEtFNRMmWGaWljyJfdr3tcu3l2hVSGSVhvrNzR+0sox1jh40Po=;
X-UUID: 032b2ff9dcec4b6c949ac288fe68e278-20200910
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 127319970; Thu, 10 Sep 2020 12:31:05 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 12:31:02 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 12:31:03 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v7] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Thu, 10 Sep 2020 12:31:00 +0800
Message-ID: <1599712262-8819-1-git-send-email-hector.yuan@mediatek.com>
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
cS1ody5jICAgICAgICAgICAgICB8ICAyNzcgKysrKysrKysrKysrKysrKysrKysNCiA0IGZpbGVz
IGNoYW5nZWQsIDQzMSBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFt
bA0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1o
dy5j

