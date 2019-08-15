Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 400118E9FE
	for <lists+linux-pm@lfdr.de>; Thu, 15 Aug 2019 13:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731299AbfHOLSW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Aug 2019 07:18:22 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38084 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730969AbfHOLSV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 15 Aug 2019 07:18:21 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 997881A00FE;
        Thu, 15 Aug 2019 13:18:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B639B1A0115;
        Thu, 15 Aug 2019 13:18:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id E3E9B402F1;
        Thu, 15 Aug 2019 19:18:01 +0800 (SGT)
From:   Anson.Huang@nxp.com
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH 5/6] clk: imx8mn: Add necessary frequency support for ARM PLL table
Date:   Thu, 15 Aug 2019 06:59:42 -0400
Message-Id: <1565866783-19672-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565866783-19672-1-git-send-email-Anson.Huang@nxp.com>
References: <1565866783-19672-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

i.MX8MN supports CPU running at 1.5GHz/1.4GHz/1.2GHz, add missing
frequency for ARM PLL table.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/clk/imx/clk-imx8mn.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index ecd1062..3f1239a 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -42,6 +42,8 @@ enum {
 static const struct imx_pll14xx_rate_table imx8mn_pll1416x_tbl[] = {
 	PLL_1416X_RATE(1800000000U, 225, 3, 0),
 	PLL_1416X_RATE(1600000000U, 200, 3, 0),
+	PLL_1416X_RATE(1500000000U, 375, 3, 1),
+	PLL_1416X_RATE(1400000000U, 350, 3, 1),
 	PLL_1416X_RATE(1200000000U, 300, 3, 1),
 	PLL_1416X_RATE(1000000000U, 250, 3, 1),
 	PLL_1416X_RATE(800000000U,  200, 3, 1),
@@ -82,6 +84,7 @@ static struct imx_pll14xx_clk imx8mn_dram_pll = {
 static struct imx_pll14xx_clk imx8mn_arm_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mn_pll1416x_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_gpu_pll = {
-- 
2.7.4

