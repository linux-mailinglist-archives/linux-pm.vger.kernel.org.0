Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968512682EA
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726077AbgINDGs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:06:48 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726110AbgINDFO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:14 -0400
X-UUID: ad68860518d144298f9ae2a8973eb03c-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zCXRrkr8hbuyZzh57oC5SLs5YknEaRLVAx2Pnd9+kF8=;
        b=CeRiK2CpMT1x0aT5lQ8wePIxhwapD9w+WroBPIK4I35HzpleWEnfgCmD9cAWMr96dOKXEP73pqm4jDyEKuuddldxJgEiZW56ED/9LzzYG2jgzO9rBKD6zNF2mg2JaJjJuM+abJdmvQaubWFBpRAqHCSspWKIHfMGnWzW5+NWZu0=;
X-UUID: ad68860518d144298f9ae2a8973eb03c-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 579268809; Mon, 14 Sep 2020 11:05:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:50 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:49 +0800
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
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V5 12/17] arm64: dts: mt8183: add dvfsrc related nodes
Date:   Mon, 14 Sep 2020 11:04:39 +0800
Message-ID: <1600052684-21198-13-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 04D812122765638FA2AD8DCDCCC0258D59FF06FCB9C9AD8BD87F56214D4C10842000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIEREUiBFTUkgcHJvdmlkZXIgZGljdGF0aW5nIGRyYW0gaW50ZXJjb25uZWN0IGJ1cyBwZXJm
b3JtYW5jZSBmb3VuZCBvbg0KTVQ4MTkyLWJhc2VkIHBsYXRmb3Jtcw0KDQpTaWduZWQtb2ZmLWJ5
OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNp
DQppbmRleCA0MDQ2NjAzLi42M2E0ZGVjZCAxMDA2NDQNCi0tLSBhL2FyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCisrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTgzLmR0c2kNCkBAIC0xMyw2ICsxMyw3IEBADQogI2luY2x1ZGUgPGR0LWJpbmRpbmdz
L3BoeS9waHkuaD4NCiAjaW5jbHVkZSAibXQ4MTgzLXBpbmZ1bmMuaCINCiAjaW5jbHVkZSA8ZHQt
YmluZGluZ3Mvc29jL210ayxkdmZzcmMuaD4NCisjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJj
b25uZWN0L210ayxtdDgxODMtZW1pLmg+DQogDQogLyB7DQogCWNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTgzIjsNCkBAIC00NzIsNiArNDczLDcgQEANCiAJCWRkcl9lbWk6IGR2ZnNyY0AxMDAx
MjAwMCB7DQogCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMtZHZmc3JjIjsNCiAJCQly
ZWcgPSA8MCAweDEwMDEyMDAwIDAgMHgxMDAwPjsNCisJCQkjaW50ZXJjb25uZWN0LWNlbGxzID0g
PDE+Ow0KIAkJfTsNCiANCiAJCXB3cmFwOiBwd3JhcEAxMDAwZDAwMCB7DQotLSANCjEuOS4xDQo=

