Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6B82682F7
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgINDHc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:07:32 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:11909 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726086AbgINDFD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:03 -0400
X-UUID: 8470a758da134d0b998d0f577538cad7-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0gzL144Gf60balVoTIYjBH07iTjIZ3Xa+rPftl1g/Qc=;
        b=mgnr4wm9gInfriywzLEJSe7zrLrBF8qZvRyLAq3iY2xdn5NnvKQgNk4mFMJJVDnoA+w+ZXvdqXvMhw5qXXL+RhceGcAuMEhZ9yL9xZi9p5/7lJO/z/HqT2ifXzK8+UjAz/OT1H887Qunket1Ws57IyjZ/5yVC/O3tdrDyKwCsWk=;
X-UUID: 8470a758da134d0b998d0f577538cad7-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1042128624; Mon, 14 Sep 2020 11:04:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
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
Subject: [PATCH V5 13/17] arm64: dts: mt8192: add dvfsrc related nodes
Date:   Mon, 14 Sep 2020 11:04:40 +0800
Message-ID: <1600052684-21198-14-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 04FC23DCA8F614B3FF1123FFA0967F30DB89E06C58A9FDFAF197ABF4DCA99CC92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIEREUiBFTUkgcHJvdmlkZXIgZGljdGF0aW5nIGRyYW0gaW50ZXJjb25uZWN0IGJ1cyBwZXJm
b3JtYW5jZSBmb3VuZCBvbg0KTVQ4MTgzLWJhc2VkIHBsYXRmb3Jtcw0KDQpTaWduZWQtb2ZmLWJ5
OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNpIHwgMiArKw0KIDEgZmlsZSBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0
ZWsvbXQ4MTkyLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE5Mi5kdHNp
DQppbmRleCAxZWFlNDQxLi42NDdjNTdhIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0
cy9tZWRpYXRlay9tdDgxOTIuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRl
ay9tdDgxOTIuZHRzaQ0KQEAgLTEwLDYgKzEwLDcgQEANCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3BpbmN0
cmwvbXQ4MTkyLXBpbmZ1bmMuaD4NCiAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvcG93ZXIvbXQ4MTky
LXBvd2VyLmg+DQorI2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVyY29ubmVjdC9tdGssbXQ2ODcz
LWVtaS5oPg0KIA0KIC8gew0KIAljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5MiI7DQpAQCAt
NDIwLDYgKzQyMSw3IEBADQogCQlkZHJfZW1pOiBkdmZzcmNAMTAwMTIwMDAgew0KIAkJCWNvbXBh
dGlibGUgPSAibWVkaWF0ZWssbXQ4MTkyLWR2ZnNyYyI7DQogCQkJcmVnID0gPDAgMHgxMDAxMjAw
MCAwIDB4MTAwMD47DQorCQkJI2ludGVyY29ubmVjdC1jZWxscyA9IDwxPjsNCiAJCX07DQogDQog
CQlzeXN0aW1lcjogdGltZXJAMTAwMTcwMDAgew0KLS0gDQoxLjkuMQ0K

