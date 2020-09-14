Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3242682EC
	for <lists+linux-pm@lfdr.de>; Mon, 14 Sep 2020 05:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbgINDFH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 13 Sep 2020 23:05:07 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:36695 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgINDE5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 13 Sep 2020 23:04:57 -0400
X-UUID: 3e201a3a7b72495792612e947120b223-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=MKE4jZGqu52vi5Uz/HjxItS9UOZV1uxSdfMgoJDVFOQ=;
        b=hE3IlIBnznxa91xVIPbEFd/bAWqeh7fugG9pHUpeNvUZshulsbzS18N5PVoqI2C3ATgkGRDxaFLBsTIo2QZ5OJrOYeLfXEN34TAXzq/mxzEO2/Q5gbz5OgBLhjIC385AHv87VqWOEi1+ojr7p2ZQxYNMKfxQYQuU5K9KXWAhSWg=;
X-UUID: 3e201a3a7b72495792612e947120b223-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <henryc.chen@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 588433921; Mon, 14 Sep 2020 11:04:50 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 11:04:49 +0800
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
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Henry Chen <henryc.chen@mediatek.com>
Subject: [PATCH V5 07/17] arm64: dts: mt8183: add dvfsrc related nodes
Date:   Mon, 14 Sep 2020 11:04:34 +0800
Message-ID: <1600052684-21198-8-git-send-email-henryc.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
References: <1600052684-21198-1-git-send-email-henryc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FC384D45CC594BA5BF0C52214A57D6027217EB44F1FEFA415C3C1BCA262E45A92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

RW5hYmxlIGR2ZnNyYyBvbiBtdDgxODMgcGxhdGZvcm0uDQoNClNpZ25lZC1vZmYtYnk6IEhlbnJ5
IENoZW4gPGhlbnJ5Yy5jaGVuQG1lZGlhdGVrLmNvbT4NCi0tLQ0KIGFyY2gvYXJtNjQvYm9vdC9k
dHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kgfCA1ICsrKysrDQogMSBmaWxlIGNoYW5nZWQsIDUgaW5z
ZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9t
dDgxODMuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ4MTgzLmR0c2kNCmlu
ZGV4IDgyY2E5MjkuLjQwNDY2MDMgMTAwNjQ0DQotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21l
ZGlhdGVrL210ODE4My5kdHNpDQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210
ODE4My5kdHNpDQpAQCAtNDY5LDYgKzQ2OSwxMSBAQA0KIAkJCSNjbG9jay1jZWxscyA9IDwxPjsN
CiAJCX07DQogDQorCQlkZHJfZW1pOiBkdmZzcmNAMTAwMTIwMDAgew0KKwkJCWNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLWR2ZnNyYyI7DQorCQkJcmVnID0gPDAgMHgxMDAxMjAwMCAwIDB4
MTAwMD47DQorCQl9Ow0KKw0KIAkJcHdyYXA6IHB3cmFwQDEwMDBkMDAwIHsNCiAJCQljb21wYXRp
YmxlID0gIm1lZGlhdGVrLG10ODE4My1wd3JhcCI7DQogCQkJcmVnID0gPDAgMHgxMDAwZDAwMCAw
IDB4MTAwMD47DQotLSANCjEuOS4xDQo=

