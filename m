Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2F2A2682FD
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbgINDHk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:07:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726067AbgINDEx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:04:53 -0400
X-UUID: 304c0d9b0a144f138ed8e26ac490fcbb-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=k8QXEF+oHSJreVypmTnZQG5P4MnlEfS+mlN+CHFNOV0=;
        b=NI8vj4PPiWpsHdxhIQ8qFXkDK2on1fMUCdw+pgOvk4D0JgJDym34xeHfaqFZPGYZ5IFZX7/QhchyhT0an45nuE70aODtfCEVc2+f1JLZSi0fe2zHVVv2VAanvFIpFh+KDUsuL2dB/Tjta36VtVT6eIdw6kFpDe42ef7fGqEohGA=;
X-UUID: 304c0d9b0a144f138ed8e26ac490fcbb-20200914
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2088837670; Mon, 14 Sep 2020 11:04:49 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:48 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:48 +0800
From:   Henry Chen <henryc.chen@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>,
        Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        Fan Chen <fan.chen@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        Mike Turquette <mturquette@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [PATCH V5 05/17] soc: mediatek: add header for mediatek SIP interface
Date:   Mon, 14 Sep 2020 11:04:32 +0800
Message-ID: <1600052684-21198-6-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RnJvbTogQXJ2aW4gV2FuZyA8YXJ2aW4ud2FuZ0BtZWRpYXRlay5jb20+DQoNCkFkZCBhIGhlYWRl
ciB0byBjb2xsZWN0IFNJUHMgYW5kIGFkZCBvbmUgU0lQIGNhbGwgdG8gaW5pdGlhbGl6ZSBwb3dl
cg0KbWFuYWdlbWVudCBoYXJkd2FyZSBmb3IgdGhlIFNJUCBpbnRlcmZhY2UgZGVmaW5lZCB0byBh
Y2Nlc3MgdGhlIFNQTQ0KaGFuZGxpbmcgdmNvcmUgdm9sdGFnZSBhbmQgZGRyIHJhdGUgY2hhbmdl
cyBvbiBtdDgxODMgKGFuZCBtb3N0IGxpa2VseQ0KbGF0ZXIgc29jcykuDQoNClNpZ25lZC1vZmYt
Ynk6IEFydmluIFdhbmcgPGFydmluLndhbmdAbWVkaWF0ZWsuY29tPg0KLS0tDQogaW5jbHVkZS9s
aW51eC9zb2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMuaCB8IDQgKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvc29jL21lZGlh
dGVrL210a19zaXBfc3ZjLmggYi9pbmNsdWRlL2xpbnV4L3NvYy9tZWRpYXRlay9tdGtfc2lwX3N2
Yy5oDQppbmRleCAwODIzOThlLi4wNzliYmNiIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9saW51eC9z
b2MvbWVkaWF0ZWsvbXRrX3NpcF9zdmMuaA0KKysrIGIvaW5jbHVkZS9saW51eC9zb2MvbWVkaWF0
ZWsvbXRrX3NpcF9zdmMuaA0KQEAgLTIyLDQgKzIyLDggQEANCiAJQVJNX1NNQ0NDX0NBTExfVkFM
KEFSTV9TTUNDQ19GQVNUX0NBTEwsIE1US19TSVBfU01DX0NPTlZFTlRJT04sIFwNCiAJCQkgICBB
Uk1fU01DQ0NfT1dORVJfU0lQLCBmbl9pZCkNCiANCisvKiBWQ09SRUZTICovDQorI2RlZmluZSBN
VEtfU0lQX1ZDT1JFRlNfQ09OVFJPTCBcDQorCU1US19TSVBfU01DX0NNRCgweDUwNikNCisNCiAj
ZW5kaWYNCi0tIA0KMS45LjENCg==

