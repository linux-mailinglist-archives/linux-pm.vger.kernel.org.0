Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCB42252F38
	for <lists+linux-pm@lfdr.de>; Wed, 26 Aug 2020 15:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgHZNCR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 26 Aug 2020 09:02:17 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:24891 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729549AbgHZNCM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Aug 2020 09:02:12 -0400
X-UUID: 6e6492c573c84724acc74574ec2b7dd0-20200826
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=TlrhuKUtXiamr2icTWX8cnBDNHjfUgMUC7MJFBSZR/U=;
        b=fNGdYeyRjoYq/mGCfam+jstSrw8XwWHWpenEB/+luJgi6zAKs9zHkFOP0ssW+uI+NTqkkbFxVYeR2/1/vy+EVB4Yl9dFhdjRdQ1FTTvyDKxUIRqAt+RBEFdi+xp4lmdOMgc9IaFxH9h6Lf+5kMUhWkiB0YY3vZF5EPJ3PPyopUI=;
X-UUID: 6e6492c573c84724acc74574ec2b7dd0-20200826
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1936986098; Wed, 26 Aug 2020 21:02:08 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 26 Aug 2020 21:01:55 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 Aug 2020 21:01:55 +0800
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
Subject: [PATCH v3] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Wed, 26 Aug 2020 21:01:51 +0800
Message-ID: <1598446913-24325-1-git-send-email-hector.yuan@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 02D1B9AEDA205CDA5DD0E93B3C8A86442BE58BD603423B503BCF813E15882B482000:8
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
bWwvMjAyMC84LzQvMTA5NA0KDQoNCkhlY3Rvci5ZdWFuICgyKToNCiAgY3B1ZnJlcTogbWVkaWF0
ZWstaHc6IEFkZCBzdXBwb3J0IGZvciBNZWRpYXRlayBjcHVmcmVxIEhXIGRyaXZlcg0KICBkdC1i
aW5kaW5nczogY3B1ZnJlcTogYWRkIGJpbmRpbmdzIGZvciBNZWRpYVRlayBjcHVmcmVxIEhXDQoN
CiAuLi4vYmluZGluZ3MvY3B1ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgICAgICB8ICAx
NDEgKysrKysrKysrDQogZHJpdmVycy9jcHVmcmVxL0tjb25maWcuYXJtICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgIDEyICsNCiBkcml2ZXJzL2NwdWZyZXEvTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVx
LWh3LmMgICAgICAgICAgICAgIHwgIDMwNSArKysrKysrKysrKysrKysrKysrKw0KIDQgZmlsZXMg
Y2hhbmdlZCwgNDU5IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2NwdWZyZXEvY3B1ZnJlcS1tZWRpYXRlay1ody55YW1s
DQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvY3B1ZnJlcS9tZWRpYXRlay1jcHVmcmVxLWh3
LmM=

