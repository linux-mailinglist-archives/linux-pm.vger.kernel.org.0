Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1984735A86
	for <lists+linux-pm@lfdr.de>; Wed,  5 Jun 2019 12:37:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727148AbfFEKhQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 5 Jun 2019 06:37:16 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60686 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727083AbfFEKhQ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Jun 2019 06:37:16 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 83F63200786;
        Wed,  5 Jun 2019 12:37:13 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 77B08200774;
        Wed,  5 Jun 2019 12:37:13 +0200 (CEST)
Received: from jana.ea.freescale.net (gw_auto.ea.freescale.net [10.171.94.100])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 00908205FA;
        Wed,  5 Jun 2019 12:37:12 +0200 (CEST)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Jacky Bai <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, kernel@pengutronix.de,
        linux-imx@nxp.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/5] cpufreq: imx-cpufreq-dt: Remove global platform match list
Date:   Wed,  5 Jun 2019 13:37:05 +0300
Message-Id: <d5ce1eb3dec5760d1cf9ea92130f66ddd70a67ce.1559730963.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
In-Reply-To: <cover.1559730963.git.leonard.crestez@nxp.com>
References: <cover.1559730963.git.leonard.crestez@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This is not currently needed, instead a platform device is always created
from SOC-specific code.

We can use of_machine_is_compatible for per-SOC behavior instead.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
---
 drivers/cpufreq/imx-cpufreq-dt.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/imx-cpufreq-dt.c b/drivers/cpufreq/imx-cpufreq-dt.c
index 35b6717d7255..b54fd26ea7df 100644
--- a/drivers/cpufreq/imx-cpufreq-dt.c
+++ b/drivers/cpufreq/imx-cpufreq-dt.c
@@ -17,35 +17,21 @@
 #define OCOTP_CFG3_SPEED_GRADE_SHIFT	8
 #define OCOTP_CFG3_SPEED_GRADE_MASK	(0x3 << 8)
 #define OCOTP_CFG3_MKT_SEGMENT_SHIFT    6
 #define OCOTP_CFG3_MKT_SEGMENT_MASK     (0x3 << 6)
 
-static const struct of_device_id imx_cpufreq_dt_match_list[] = {
-	{ .compatible = "fsl,imx8mm" },
-	{ .compatible = "fsl,imx8mq" },
-	{}
-};
-
 /* cpufreq-dt device registered by imx-cpufreq-dt */
 static struct platform_device *cpufreq_dt_pdev;
 static struct opp_table *cpufreq_opp_table;
 
 static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 {
 	struct device *cpu_dev = get_cpu_device(0);
-	struct device_node *np;
-	const struct of_device_id *match;
 	u32 cell_value, supported_hw[2];
 	int speed_grade, mkt_segment;
 	int ret;
 
-	np = of_find_node_by_path("/");
-	match = of_match_node(imx_cpufreq_dt_match_list, np);
-	of_node_put(np);
-	if (!match)
-		return -ENODEV;
-
 	ret = nvmem_cell_read_u32(cpu_dev, "speed_grade", &cell_value);
 	if (ret)
 		return ret;
 
 	speed_grade = (cell_value & OCOTP_CFG3_SPEED_GRADE_MASK) >> OCOTP_CFG3_SPEED_GRADE_SHIFT;
@@ -59,12 +45,12 @@ static int imx_cpufreq_dt_probe(struct platform_device *pdev)
 	 * consumer parts so clamp to 1 to avoid warning for "no OPPs"
 	 *
 	 * Applies to 8mq and 8mm.
 	 */
 	if (mkt_segment == 0 && speed_grade == 0 && (
-			!strcmp(match->compatible, "fsl,imx8mm") ||
-			!strcmp(match->compatible, "fsl,imx8mq")))
+			of_machine_is_compatible("fsl,imx8mm") ||
+			of_machine_is_compatible("fsl,imx8mq")))
 		speed_grade = 1;
 
 	supported_hw[0] = BIT(speed_grade);
 	supported_hw[1] = BIT(mkt_segment);
 	dev_info(&pdev->dev, "cpu speed grade %d mkt segment %d supported-hw %#x %#x\n",
-- 
2.7.4

