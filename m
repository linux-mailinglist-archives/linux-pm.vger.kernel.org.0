Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8919E03F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Apr 2020 23:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgDCVVv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 3 Apr 2020 17:21:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:44372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727842AbgDCVVu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 3 Apr 2020 17:21:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9EDBDAD41;
        Fri,  3 Apr 2020 21:21:47 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-pm@vger.kernel.org, andy.tang@nxp.com, shawnguo@kernel.org,
        leoyang.li@nxp.com
Cc:     viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH 1/2] cpufreq: qoriq: convert to a platform driver
Date:   Fri,  3 Apr 2020 23:21:13 +0200
Message-Id: <20200403212114.15565-1-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The driver has to be manually loaded if it is built as a module. It
is neither exporting MODULE_DEVICE_TABLE nor MODULE_ALIAS. Moreover,
no platform-device is created (and thus no uevent is sent) for the
clockgen nodes it depends on.

Convert the module to a platform driver with its own alias. Moreover,
drop whitelisted SOCs. Platform device will be created only for the
compatible platforms.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/cpufreq/qoriq-cpufreq.c | 76 ++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufreq.c
index 8e436dc75c8b..6b6b20da2bcf 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
+#include <linux/platform_device.h>
 
 /**
  * struct cpu_data
@@ -29,12 +30,6 @@ struct cpu_data {
 	struct cpufreq_frequency_table *table;
 };
 
-/*
- * Don't use cpufreq on this SoC -- used when the SoC would have otherwise
- * matched a more generic compatible.
- */
-#define SOC_BLACKLIST		1
-
 /**
  * struct soc_data - SoC specific data
  * @flags: SOC_xxx
@@ -264,64 +259,51 @@ static struct cpufreq_driver qoriq_cpufreq_driver = {
 	.attr		= cpufreq_generic_attr,
 };
 
-static const struct soc_data blacklist = {
-	.flags = SOC_BLACKLIST,
-};
-
-static const struct of_device_id node_matches[] __initconst = {
+static const struct of_device_id qoriq_cpufreq_blacklist[] = {
 	/* e6500 cannot use cpufreq due to erratum A-008083 */
-	{ .compatible = "fsl,b4420-clockgen", &blacklist },
-	{ .compatible = "fsl,b4860-clockgen", &blacklist },
-	{ .compatible = "fsl,t2080-clockgen", &blacklist },
-	{ .compatible = "fsl,t4240-clockgen", &blacklist },
-
-	{ .compatible = "fsl,ls1012a-clockgen", },
-	{ .compatible = "fsl,ls1021a-clockgen", },
-	{ .compatible = "fsl,ls1028a-clockgen", },
-	{ .compatible = "fsl,ls1043a-clockgen", },
-	{ .compatible = "fsl,ls1046a-clockgen", },
-	{ .compatible = "fsl,ls1088a-clockgen", },
-	{ .compatible = "fsl,ls2080a-clockgen", },
-	{ .compatible = "fsl,lx2160a-clockgen", },
-	{ .compatible = "fsl,p4080-clockgen", },
-	{ .compatible = "fsl,qoriq-clockgen-1.0", },
-	{ .compatible = "fsl,qoriq-clockgen-2.0", },
+	{ .compatible = "fsl,b4420-clockgen", },
+	{ .compatible = "fsl,b4860-clockgen", },
+	{ .compatible = "fsl,t2080-clockgen", },
+	{ .compatible = "fsl,t4240-clockgen", },
 	{}
 };
 
-static int __init qoriq_cpufreq_init(void)
+static int qoriq_cpufreq_probe(struct platform_device *pdev)
 {
 	int ret;
-	struct device_node  *np;
-	const struct of_device_id *match;
-	const struct soc_data *data;
-
-	np = of_find_matching_node(NULL, node_matches);
-	if (!np)
-		return -ENODEV;
-
-	match = of_match_node(node_matches, np);
-	data = match->data;
-
-	of_node_put(np);
+	struct device_node *np;
 
-	if (data && data->flags & SOC_BLACKLIST)
+	np = of_find_matching_node(NULL, qoriq_cpufreq_blacklist);
+	if (np) {
+		dev_info(&pdev->dev, "Disabling due to erratum A-008083");
 		return -ENODEV;
+	}
 
 	ret = cpufreq_register_driver(&qoriq_cpufreq_driver);
-	if (!ret)
-		pr_info("Freescale QorIQ CPU frequency scaling driver\n");
+	if (ret)
+		return ret;
 
-	return ret;
+	dev_info(&pdev->dev, "Freescale QorIQ CPU frequency scaling driver\n");
+	return 0;
 }
-module_init(qoriq_cpufreq_init);
 
-static void __exit qoriq_cpufreq_exit(void)
+static int qoriq_cpufreq_remove(struct platform_device *pdev)
 {
 	cpufreq_unregister_driver(&qoriq_cpufreq_driver);
+
+	return 0;
 }
-module_exit(qoriq_cpufreq_exit);
 
+static struct platform_driver qoriq_cpufreq_platform_driver = {
+	.driver = {
+		.name = "qoriq-cpufreq",
+	},
+	.probe = qoriq_cpufreq_probe,
+	.remove = qoriq_cpufreq_remove,
+};
+module_platform_driver(qoriq_cpufreq_platform_driver);
+
+MODULE_ALIAS("platform:qoriq-cpufreq");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Tang Yuantian <Yuantian.Tang@freescale.com>");
 MODULE_DESCRIPTION("cpufreq driver for Freescale QorIQ series SoCs");
-- 
2.16.4

