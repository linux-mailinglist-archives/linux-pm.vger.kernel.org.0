Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8078191533
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfHRGvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 02:51:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:32962 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725786AbfHRGvK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Aug 2019 02:51:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6A24F200138;
        Sun, 18 Aug 2019 08:51:08 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83B97200003;
        Sun, 18 Aug 2019 08:51:00 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8823E4031D;
        Sun, 18 Aug 2019 14:50:50 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND V2 5/7] clk: imx8mn: Add missing rate_count assignment for each PLL structure
Date:   Sun, 18 Aug 2019 02:32:23 -0400
Message-Id: <1566109945-11149-5-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add .rate_count assignment which is necessary for searching required
PLL rate from the each PLL table.

Fixes: 96d6392b54db ("clk: imx: Add support for i.MX8MN clock driver")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- split the patch into 2 patches, #1 fixed those missing .rate_count assignment,
	  #2 add missing frequency points.
---
 drivers/clk/imx/clk-imx8mn.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index ecd1062..b5a027c 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -67,36 +67,43 @@ static const struct imx_pll14xx_rate_table imx8mn_drampll_tbl[] = {
 static struct imx_pll14xx_clk imx8mn_audio_pll = {
 		.type = PLL_1443X,
 		.rate_table = imx8mn_audiopll_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_audiopll_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_video_pll = {
 		.type = PLL_1443X,
 		.rate_table = imx8mn_videopll_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_videopll_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_dram_pll = {
 		.type = PLL_1443X,
 		.rate_table = imx8mn_drampll_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_drampll_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_arm_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mn_pll1416x_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_gpu_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mn_pll1416x_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_vpu_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mn_pll1416x_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
 };
 
 static struct imx_pll14xx_clk imx8mn_sys_pll = {
 		.type = PLL_1416X,
 		.rate_table = imx8mn_pll1416x_tbl,
+		.rate_count = ARRAY_SIZE(imx8mn_pll1416x_tbl),
 };
 
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
-- 
2.7.4

