Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AC9262C8B
	for <lists+linux-pm@lfdr.de>; Wed,  9 Sep 2020 11:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIJvn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Sep 2020 05:51:43 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16906 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728584AbgIIJvj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 9 Sep 2020 05:51:39 -0400
X-UUID: 05cea528b9ba428aba7ac55533db2741-20200909
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=MYJuj1+7OUVwOQfGJtUfdsku/gKAE0aqgHgFLGUEUgc=;
        b=Zy8w67dSGsJHU1TFSu5/CNB2vERpEVswu9fw9x4Mu2TMQO+cx/3P7rWq0Cm18HXCsBPjwCGkwvAFMI1U52bKsNfeYoR2cFJ743YWfj2aa6m8UDUyquC4CKYafY/T23BjgquZBPtrRf+vdU8HjytVFyvTcTQ2/CTUAcQhZmI/b3A=;
X-UUID: 05cea528b9ba428aba7ac55533db2741-20200909
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1705486011; Wed, 09 Sep 2020 17:51:33 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 9 Sep 2020 17:51:30 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 9 Sep 2020 17:51:31 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v5] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Wed, 9 Sep 2020 17:51:24 +0800
Message-ID: <1599645086-10169-1-git-send-email-hector.yuan@mediatek.com>
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
dGhpcyBoYXJkd2FyZSBlbmdpbmUuIA0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gdGhlIE1UNjc5
OSBEVFMgcGF0Y2ggc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4NCiBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAyMC84LzQvMTA5NA0KIA0KDQpIZWN0b3IuWXVhbiAoMik6DQogIGNwdWZyZXE6IG1lZGlh
dGVrLWh3OiBBZGQgc3VwcG9ydCBmb3IgTWVkaWF0ZWsgY3B1ZnJlcSBIVyBkcml2ZXINCiAgZHQt
YmluZGluZ3M6IGNwdWZyZXE6IGFkZCBiaW5kaW5ncyBmb3IgTWVkaWFUZWsgY3B1ZnJlcSBIVw0K
DQogLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAg
MTQxICsrKysrKysrKysNCiBkcml2ZXJzL2NwdWZyZXEvS2NvbmZpZy5hcm0gICAgICAgICAgICAg
ICAgICAgICAgICB8ICAgMTIgKw0KIGRyaXZlcnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgICAg
ICAgICAgICAgICAgICAgIHwgICAgMSArDQogZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZy
ZXEtaHcuYyAgICAgICAgICAgICAgfCAgMjg5ICsrKysrKysrKysrKysrKysrKysrDQogNCBmaWxl
cyBjaGFuZ2VkLCA0NDMgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3Lnlh
bWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEt
aHcuYw==

