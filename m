Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD0D3EA162
	for <lists+linux-pm@lfdr.de>; Thu, 12 Aug 2021 11:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbhHLJBF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Aug 2021 05:01:05 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:37280 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235664AbhHLJAx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Aug 2021 05:00:53 -0400
X-UUID: c736e56cd2ea4d2a92e0bb40cb1b388c-20210812
X-UUID: c736e56cd2ea4d2a92e0bb40cb1b388c-20210812
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <dawei.chien@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 312176054; Thu, 12 Aug 2021 17:00:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Aug 2021 17:00:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Aug 2021 17:00:23 +0800
From:   Dawei Chien <dawei.chien@mediatek.com>
To:     Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Ryan Case <ryandcase@chromium.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@google.com>,
        <devicetree@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Fan Chen <fan.chen@mediatek.com>,
        Arvin Wang <arvin.wang@mediatek.com>,
        James Liao <jamesjj.liao@mediatek.com>,
        Dawei Chien <dawei.chien@mediatek.com>
Subject: [V11,PATCH 15/19] regulator: mediatek: add support for mt8195
Date:   Thu, 12 Aug 2021 16:58:42 +0800
Message-ID: <20210812085846.2628-16-dawei.chien@mediatek.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20210812085846.2628-1-dawei.chien@mediatek.com>
References: <20210812085846.2628-1-dawei.chien@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

add platform data on mt8195

Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 drivers/regulator/mtk-dvfsrc-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/mtk-dvfsrc-regulator.c b/drivers/regulator/mtk-dvfsrc-regulator.c
index d3d876198d6e..1bd6e67b1de5 100644
--- a/drivers/regulator/mtk-dvfsrc-regulator.c
+++ b/drivers/regulator/mtk-dvfsrc-regulator.c
@@ -140,6 +140,25 @@ static const struct dvfsrc_regulator_init_data regulator_mt6873_data = {
 	.regulator_info = &mt6873_regulators[0],
 };
 
+static const unsigned int mt8195_voltages[] = {
+	550000,
+	600000,
+	650000,
+	750000,
+};
+
+static struct dvfsrc_regulator mt8195_regulators[] = {
+	MT_DVFSRC_REGULAR("dvfsrc-vcore", VCORE,
+			  mt8195_voltages),
+	MT_DVFSRC_REGULAR("dvfsrc-vscp", VSCP,
+			  mt8195_voltages),
+};
+
+static const struct dvfsrc_regulator_init_data regulator_mt8195_data = {
+	.size = ARRAY_SIZE(mt8195_regulators),
+	.regulator_info = &mt8195_regulators[0],
+};
+
 static const struct of_device_id mtk_dvfsrc_regulator_match[] = {
 	{
 		.compatible = "mediatek,mt8183-dvfsrc",
@@ -150,6 +169,10 @@ static const struct of_device_id mtk_dvfsrc_regulator_match[] = {
 	}, {
 		.compatible = "mediatek,mt6873-dvfsrc",
 		.data = &regulator_mt6873_data,
+	}, {
+		.compatible = "mediatek,mt8195-dvfsrc",
+		.data = &regulator_mt8195_data,
+	}, {
 	}, {
 		/* sentinel */
 	},
-- 
2.14.1

