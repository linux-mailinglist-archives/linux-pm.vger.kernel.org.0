Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79D591843B0
	for <lists+linux-pm@lfdr.de>; Fri, 13 Mar 2020 10:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbgCMJei (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 13 Mar 2020 05:34:38 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:12079 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726543AbgCMJei (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Mar 2020 05:34:38 -0400
X-UUID: 688c0dbc8df94d6bb51056bf3da10502-20200313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=y4fidyRMowL3surEo6zhd1R+r3Ch90oXxAv9QuI8xU0=;
        b=sWLBUWp4Hr3buMy3YPTagFHWIMAX+m6BdkYF9m0ovRbTnsg4ncGG2W6WdFP8q2Y+LqjTk5Im+ke2VCH5pb66HGCwS16aFZnhBHWHhAene1tVpeq4DRQLyDYEZ8PUMTCeJs8jllbA+9gQL5wD6PvK1GMIouDcoALHGJ8uALpflfQ=;
X-UUID: 688c0dbc8df94d6bb51056bf3da10502-20200313
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 514878430; Fri, 13 Mar 2020 17:34:32 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 13 Mar 2020 17:31:41 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 13 Mar 2020 17:33:42 +0800
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
Subject: [PATCH V4 10/13] arm64: dts: mt8183: add dvfsrc related nodes
Date:   Fri, 13 Mar 2020 17:34:23 +0800
Message-ID: <1584092066-24425-11-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
References: <1584092066-24425-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB2F051B1CE46416C0FA451C46FB79B651A5F200F22551BD3162F8468D7B5AA92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIEREUiBFTUkgcHJvdmlkZXIgZGljdGF0aW5nIGRyYW0gaW50ZXJjb25uZWN0IGJ1cyBwZXJm
b3JtYW5jZSBmb3VuZCBvbg0KTVQ4MTgzLWJhc2VkIHBsYXRmb3Jtcw0KDQpTaWduZWQtb2ZmLWJ5
OiBIZW5yeSBDaGVuIDxoZW5yeWMuY2hlbkBtZWRpYXRlay5jb20+DQotLS0NCiBhcmNoL2FybTY0
L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5kdHNpIHwgNSArKysrKw0KIDEgZmlsZSBjaGFuZ2Vk
LCA1IGluc2VydGlvbnMoKykNCg0KZGlmZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVk
aWF0ZWsvbXQ4MTgzLmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210ODE4My5k
dHNpDQppbmRleCBjMGQwOGM4Li41N2E1NWEzIDEwMDY0NA0KLS0tIGEvYXJjaC9hcm02NC9ib290
L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9tZWRp
YXRlay9tdDgxODMuZHRzaQ0KQEAgLTEyLDYgKzEyLDcgQEANCiAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvcmVzZXQtY29udHJvbGxlci9tdDgxODMtcmVzZXRzLmg+DQogI2luY2x1ZGUgIm10ODE4My1w
aW5mdW5jLmgiDQogI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3NvYy9tdGssZHZmc3JjLmg+DQorI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVyY29ubmVjdC9tdGssbXQ4MTgzLWVtaS5oPg0KIA0KIC8g
ew0KIAljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4MyI7DQpAQCAtMTY0LDYgKzE2NSwxMCBA
QA0KIAkJcmVnID0gPDAgMHgxMDAxMjAwMCAwIDB4MTAwMD47DQogCQljbG9ja3MgPSA8JmluZnJh
Y2ZnIENMS19JTkZSQV9EVkZTUkM+Ow0KIAkJY2xvY2stbmFtZXMgPSAiZHZmc3JjIjsNCisJCWRk
cl9lbWk6IGludGVyY29ubmVjdCB7DQorCQkJY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODMt
ZW1pIjsNCisJCQkjaW50ZXJjb25uZWN0LWNlbGxzID0gPDE+Ow0KKwkJfTsNCiAJfTsNCiANCiAJ
dGltZXIgew0KLS0gDQoxLjkuMQ0K

