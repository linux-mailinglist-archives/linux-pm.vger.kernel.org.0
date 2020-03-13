Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9BA1843C2
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:35:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgCMJek (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:40 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16861 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726364AbgCMJej (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:39 -0400
X-UUID: a84b3941202a470a9540f25eed6e7d47-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kO25H1emR15qgYn4QcDNUz+M/XfUisv1uNSv5VIntVQ=;
        b=Pq1EpJIG0xrvZ0p4p7BgY5qU/1j4Jvnua7D57BVcojZHCABXFbeapKbOtpSYhRq0is2YxBPr8uVERI4F6g0BlYCZd2pC/scKc246YC8L7ZI6kZpzQxTRjnaCDq/pG2GEAusDXNmmaS/FwYqe+pCcwRcahdtlgcHs7axRpmc1f0c=;
X-UUID: a84b3941202a470a9540f25eed6e7d47-20200313
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 981195548; Fri, 13 Mar 2020 17:34:31 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:32:56 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:41 +0800
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
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V4 05/13] soc: mediatek: add header for mediatek SIP interface
Date:   Fri, 13 Mar 2020 17:34:18 +0800
Message-ID: <1584092066-24425-6-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: D023FFB3E18CAA474D3E3468F12CDD7C97DD3C90292E266EFC763F850B5EE36A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIGEgaGVhZGVyIHRvIGNvbGxlY3QgU0lQcyBhbmQgYWRkIG9uZSBTSVAgY2FsbCB0byBpbml0
aWFsaXplIHBvd2VyDQptYW5hZ2VtZW50IGhhcmR3YXJlIGZvciB0aGUgU0lQIGludGVyZmFjZSBk
ZWZpbmVkIHRvIGFjY2VzcyB0aGUgU1BNDQpoYW5kbGluZyB2Y29yZSB2b2x0YWdlIGFuZCBkZHIg
cmF0ZSBjaGFuZ2VzIG9uIG10ODE4MyAoYW5kIG1vc3QgbGlrZWx5DQpsYXRlciBzb2NzKS4NCg0K
U2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsuY29tPg0KLS0t
DQogaW5jbHVkZS9zb2MvbWVkaWF0ZWsvbXRrX3NpcC5oIHwgMTcgKysrKysrKysrKysrKysrKysN
CiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL3NvYy9tZWRpYXRlay9tdGtfc2lwLmgNCg0KZGlmZiAtLWdpdCBhL2luY2x1ZGUvc29j
L21lZGlhdGVrL210a19zaXAuaCBiL2luY2x1ZGUvc29jL21lZGlhdGVrL210a19zaXAuaA0KbmV3
IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAuLjk0NWZjNzINCi0tLSAvZGV2L251bGwN
CisrKyBiL2luY2x1ZGUvc29jL21lZGlhdGVrL210a19zaXAuaA0KQEAgLTAsMCArMSwxNyBAQA0K
Ky8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQorICoNCisgKiBDb3B5cmlnaHQg
KGMpIDIwMTggTWVkaWFUZWsgSW5jLg0KKyAqLw0KKyNpZm5kZWYgX19TT0NfTVRLX1NJUF9IDQor
I2RlZmluZSBfX1NPQ19NVEtfU0lQX0gNCisNCisjaWZkZWYgQ09ORklHX0FSTTY0DQorI2RlZmlu
ZSBNVEtfU0lQX1NNQ19BQVJDSF9CSVQJCTB4NDAwMDAwMDANCisjZWxzZQ0KKyNkZWZpbmUgTVRL
X1NJUF9TTUNfQUFSQ0hfQklUCQkweDAwMDAwMDAwDQorI2VuZGlmDQorDQorI2RlZmluZSBNVEtf
U0lQX1NQTQkJCSgweDgyMDAwNTA2IHwgTVRLX1NJUF9TTUNfQUFSQ0hfQklUKQ0KKyNkZWZpbmUg
TVRLX1NJUF9TUE1fRFZGU1JDX0lOSVQJCTB4MDANCisNCisjZW5kaWYNCi0tIA0KMS45LjENCg==

