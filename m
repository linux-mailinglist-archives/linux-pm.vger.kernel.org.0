Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1237191532
	for <lists+linux-pm@lfdr.de>; Sun, 18 Aug 2019 08:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbfHRGvL (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Aug 2019 02:51:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:33010 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726606AbfHRGvL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 18 Aug 2019 02:51:11 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69795200003;
        Sun, 18 Aug 2019 08:51:09 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 84A28200710;
        Sun, 18 Aug 2019 08:51:01 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 222064031E;
        Sun, 18 Aug 2019 14:50:52 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mturquette@baylibre.com, sboyd@kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, leonard.crestez@nxp.com,
        abel.vesa@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH RESEND V2 6/7] clk: imx8mn: Add necessary frequency support for ARM PLL table
Date:   Sun, 18 Aug 2019 02:32:24 -0400
Message-Id: <1566109945-11149-6-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
References: <1566109945-11149-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

i.MX8MN supports CPU running at 1.5GHz/1.4GHz/1.2GHz, add missing
frequency for ARM PLL table.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
         - split the patch into 2 patches, #1 fixed those missing .rate_count assignment,
           #2 add missing frequency points.
---
 drivers/clk/imx/clk-imx8mn.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index b5a027c..48884f9 100644
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
-- 
2.7.4

