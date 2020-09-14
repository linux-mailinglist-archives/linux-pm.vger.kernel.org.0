Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7972682E5
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgINDFk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:05:40 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35987 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726131AbgINDFY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:05:24 -0400
X-UUID: cb9ace53eff64d538449a5cac0ca391d-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JVZ6l/399x9XAS0QODjm3jLzjSqtPbPi9+drCZQrlJg=;
        b=Hxjci03tCA1ixvUUl02Zrg0eEg3AZfsFVo5DeZNn+fnAXHTz+fxyN2cDniXZRNWnQMeQMQqElpS38g7cZjUKg710JA9HVLxOJq2A9JkdGdrRJnA3EHaFRdUUySpKNbcIv+qM29aqeiFhJUt17MzjuHqbIfhV9d/mCDvotoyYIP4=;
X-UUID: cb9ace53eff64d538449a5cac0ca391d-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 202765796; Mon, 14 Sep 2020 11:05:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:50 +0800
Received: from mtksdaap41.mediatek.inc (172.21.77.4) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 11:04:50 +0800
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
Subject: [PATCH V5 16/17] arm64: dts: mt8183: add dvfsrc regulator nodes
Date:   Mon, 14 Sep 2020 11:04:43 +0800
Message-ID: <1600052684-21198-17-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4FA3F5132E9D23EBFB3644E75A344AEC0BA7B80185869F256B752B4863B656992000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

QWRkIGR2ZnNyYyByZWd1bGF0b3Igbm9kZXMgd2hpY2ggaXMgZm9yIE1UODE4My1iYXNlZCBwbGF0
Zm9ybXMNCg0KU2lnbmVkLW9mZi1ieTogSGVucnkgQ2hlbiA8aGVucnljLmNoZW5AbWVkaWF0ZWsu
Y29tPg0KLS0tDQogYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSB8IDYg
KysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9v
dC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmluZGV4IDYzYTRkZWNkLi4yNmNhMGIzIDEwMDY0
NA0KLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KKysrIGIv
YXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDgxODMuZHRzaQ0KQEAgLTQ3NCw2ICs0NzQs
MTIgQEANCiAJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kdmZzcmMiOw0KIAkJCXJl
ZyA9IDwwIDB4MTAwMTIwMDAgMCAweDEwMDA+Ow0KIAkJCSNpbnRlcmNvbm5lY3QtY2VsbHMgPSA8
MT47DQorCQkJZHZmc3JjX3Zjb3JlOiBkdmZzcmMtdmNvcmUgew0KKwkJCQlyZWd1bGF0b3ItbmFt
ZSA9ICJkdmZzcmMtdmNvcmUiOw0KKwkJCQlyZWd1bGF0b3ItbWluLW1pY3Jvdm9sdCA9IDw3MjUw
MDA+Ow0KKwkJCQlyZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDw4MDAwMDA+Ow0KKwkJCQlyZWd1
bGF0b3ItYWx3YXlzLW9uOw0KKwkJCX07DQogCQl9Ow0KIA0KIAkJcHdyYXA6IHB3cmFwQDEwMDBk
MDAwIHsNCi0tIA0KMS45LjENCg==

