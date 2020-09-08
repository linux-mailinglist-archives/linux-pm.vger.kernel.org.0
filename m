Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF1260C22
	for <lists+linux-pm@lfdr.de>; Tue,  8 Sep 2020 09:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgIHHfz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Sep 2020 03:35:55 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:45193 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729190AbgIHHfz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Sep 2020 03:35:55 -0400
X-UUID: ae21a226dfcb4941a56d39e028f66fea-20200908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=hbb4qHCvH9B4+P53YMJXs/+DzoBkaX6B2n9wmkiuJ2o=;
        b=jPMYkV0kjsIzzOpYXxT30YR2KWkxzE4+5AAY+PjTptrRiS6wHZn9K33FfGNDon5stDB1eqwK3/exxWDV7T5REONp4zxPAmTcTRTs8PJKtV6t6KhheI4NcwD6k1HbzrPQxPMMN4rp2GLFXmXp503XuOIssXbuU4D16XAoG0KwV/A=;
X-UUID: ae21a226dfcb4941a56d39e028f66fea-20200908
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 911027175; Tue, 08 Sep 2020 15:35:53 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 8 Sep 2020 15:35:50 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Sep 2020 15:35:51 +0800
From:   Hector Yuan <hector.yuan@mediatek.com>
To:     <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <hector.yuan@mediatek.com>
Subject: [PATCH v4] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Tue, 8 Sep 2020 15:35:45 +0800
Message-ID: <1599550547-27767-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

VGhpcyBwYXRjaCBkZXBlbmRzIG9uIHRoZSBNVDY3OTkgRFRTIHBhdGNoIHN1Ym1pdHRlZCBieSBI
YW5rcyBDaGVuDQogaHR0cHM6Ly9sa21sLm9yZy9sa21sLzIwMjAvOC80LzEwOTQNCg0KDQpIZWN0
b3IuWXVhbiAoMik6DQogIGNwdWZyZXE6IG1lZGlhdGVrLWh3OiBBZGQgc3VwcG9ydCBmb3IgTWVk
aWF0ZWsgY3B1ZnJlcSBIVyBkcml2ZXINCiAgZHQtYmluZGluZ3M6IGNwdWZyZXE6IGFkZCBiaW5k
aW5ncyBmb3IgTWVkaWFUZWsgY3B1ZnJlcSBIVw0KDQogLi4uL2JpbmRpbmdzL2NwdWZyZXEvY3B1
ZnJlcS1tZWRpYXRlay1ody55YW1sICAgICAgfCAgMTQxICsrKysrKysrKysNCiBkcml2ZXJzL2Nw
dWZyZXEvS2NvbmZpZy5hcm0gICAgICAgICAgICAgICAgICAgICAgICB8ICAgMTIgKw0KIGRyaXZl
cnMvY3B1ZnJlcS9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAgMSArDQog
ZHJpdmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYyAgICAgICAgICAgICAgfCAgMjk0
ICsrKysrKysrKysrKysrKysrKysrDQogNCBmaWxlcyBjaGFuZ2VkLCA0NDggaW5zZXJ0aW9ucygr
KQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
Y3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwNCiBjcmVhdGUgbW9kZSAxMDA2NDQgZHJp
dmVycy9jcHVmcmVxL21lZGlhdGVrLWNwdWZyZXEtaHcuYw==

