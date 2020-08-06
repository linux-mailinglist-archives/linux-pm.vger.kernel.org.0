Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4C123DFEC
	for <lists+linux-pm@lfdr.de>; Thu,  6 Aug 2020 19:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728332AbgHFRzZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 6 Aug 2020 13:55:25 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:46434 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727891AbgHFQ2v (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Aug 2020 12:28:51 -0400
X-UUID: 155ce355808a464ab577f90b1ec586ed-20200806
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NLDH9FVoVAm+xVXhqQoVsL3Aq/8DfsNuSyGryiajX7w=;
        b=QcJRFrIgtJ+y1E3ChRm9NKV4aj7ax+65MZmJ9gcqNqJIPv5uy/WCZ8FcCD/AdJXxKVA/eQNdsjJhw7fDmFC4z9QQ+mdcMdp2Y1k5HwiK81iOZ8ZYCy2fH+xphMundZ92NgWeZUrxT716IvR2WPcaqI6PFgua26candVndChBDog=;
X-UUID: 155ce355808a464ab577f90b1ec586ed-20200806
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <hector.yuan@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 314563032; Thu, 06 Aug 2020 20:18:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 6 Aug 2020 20:18:40 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Aug 2020 20:18:41 +0800
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
Subject: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek cpufreq HW driver
Date:   Thu, 6 Aug 2020 20:18:38 +0800
Message-ID: <1596716320-19811-1-git-send-email-hector.yuan@mediatek.com>
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
IHRoZSBzdGVwcyBuZWNlc3NhcnkNCmZvciBjaGFuZ2luZyB0aGUgZnJlcXVlbmN5IG9mIENQVXMu
IFRoZSBkcml2ZXIgaW1wbGVtZW50cyB0aGUgY3B1ZnJlcQ0KZHJpdmVyIGludGVyZmFjZSBmb3Ig
dGhpcyBoYXJkd2FyZSBlbmdpbmUuIA0KDQpUaGlzIHBhdGNoIGRlcGVuZHMgb24gdGhlIE1UNjc5
OSBEVFMgcGF0Y2ggc3VibWl0dGVkIGJ5IEhhbmtzIENoZW4NCiBodHRwczovL2xrbWwub3JnL2xr
bWwvMjAyMC84LzQvMTA5NA0KDQpIZWN0b3IuWXVhbiAoMik6DQogIGNwdWZyZXE6IG1lZGlhdGVr
LWh3OiBBZGQgc3VwcG9ydCBmb3IgTWVkaWF0ZWsgY3B1ZnJlcQ0KICBkdC1iaW5kaW5nczogY3B1
ZnJlcTogYWRkICBNZWRpYVRlayBjcHVmcmVxIGJpbmRpbmdzDQoNCiAuLi4vYmluZGluZ3MvY3B1
ZnJlcS9jcHVmcmVxLW1lZGlhdGVrLWh3LnlhbWwgICAgICB8ICAgNTYgKysrKysNCiBhcmNoL2Fy
bTY0L2NvbmZpZ3MvZGVmY29uZmlnICAgICAgICAgICAgICAgICAgICAgICB8ICAgIDEgKw0KIGRy
aXZlcnMvY3B1ZnJlcS9LY29uZmlnLmFybSAgICAgICAgICAgICAgICAgICAgICAgIHwgICAxMSAr
DQogZHJpdmVycy9jcHVmcmVxL01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
ICAxICsNCiBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jICAgICAgICAgICAg
ICB8ICAyNTUgKysrKysrKysrKysrKysrKysrKysNCiA1IGZpbGVzIGNoYW5nZWQsIDMyNCBpbnNl
cnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9jcHVmcmVxL2NwdWZyZXEtbWVkaWF0ZWstaHcueWFtbA0KIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL2NwdWZyZXEvbWVkaWF0ZWstY3B1ZnJlcS1ody5jDQoNCg==

