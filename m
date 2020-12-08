Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1792D2430
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 08:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725789AbgLHHUR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Dec 2020 02:20:17 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:43133 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725208AbgLHHUR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Dec 2020 02:20:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436719|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0175408-0.00371488-0.978744;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.J4UIRBD_1607411969;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J4UIRBD_1607411969)
          by smtp.aliyun-inc.com(10.147.41.121);
          Tue, 08 Dec 2020 15:19:32 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     tiny.windzz@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net,
        samuel@sholland.org
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH v4 1/6] cpufreq: sun50i: add efuse_xlate to get efuse version.
Date:   Tue,  8 Dec 2020 15:19:28 +0800
Message-Id: <20201208071928.2078-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It's better to use efuse_xlate to extract the differentiated part
regarding different SoC.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 82 ++++++++++++++++----------
 1 file changed, 51 insertions(+), 31 deletions(-)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 9907a165135b..3c0531938d1a 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -19,24 +19,51 @@
 
 #define MAX_NAME_LEN	7
 
-#define NVMEM_MASK	0x7
-#define NVMEM_SHIFT	5
+#define SUN50I_H6_NVMEM_MASK		0x7
+#define SUN50I_H6_NVMEM_SHIFT		5
+
+struct sunxi_cpufreq_soc_data {
+	int (*efuse_xlate)(struct nvmem_cell *speedbin_nvmem);
+};
 
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
+static int sun50i_h6_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
+{
+	size_t len;
+	u32 *speedbin;
+	u32 efuse_value;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	efuse_value = (*(u32 *)speedbin >> SUN50I_H6_NVMEM_SHIFT) &
+			  SUN50I_H6_NVMEM_MASK;
+	kfree(speedbin);
+	/*
+	 * We treat unexpected efuse values as if the SoC was from
+	 * the slowest bin. Expected efuse values are 1-3, slowest
+	 * to fastest.
+	 */
+	if (efuse_value >= 1 && efuse_value <= 3)
+		return efuse_value - 1;
+	else
+		return 0;
+}
+
 /**
  * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
- * @versions: Set to the value parsed from efuse
+ * @soc_data: pointer to sunxi_cpufreq_soc_data context
  *
  * Returns 0 if success.
  */
-static int sun50i_cpufreq_get_efuse(u32 *versions)
+static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data)
 {
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	u32 *speedbin, efuse_value;
-	size_t len;
+	int versions;
 	int ret;
 
 	cpu_dev = get_cpu_device(0);
@@ -63,43 +90,33 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 		return PTR_ERR(speedbin_nvmem);
 	}
 
-	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	versions = soc_data->efuse_xlate(speedbin_nvmem);
 	nvmem_cell_put(speedbin_nvmem);
-	if (IS_ERR(speedbin))
-		return PTR_ERR(speedbin);
-
-	efuse_value = (*speedbin >> NVMEM_SHIFT) & NVMEM_MASK;
-
-	/*
-	 * We treat unexpected efuse values as if the SoC was from
-	 * the slowest bin. Expected efuse values are 1-3, slowest
-	 * to fastest.
-	 */
-	if (efuse_value >= 1 && efuse_value <= 3)
-		*versions = efuse_value - 1;
-	else
-		*versions = 0;
 
-	kfree(speedbin);
-	return 0;
+	return versions;
 };
 
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct opp_table **opp_tables;
 	char name[MAX_NAME_LEN];
 	unsigned int cpu;
-	u32 speed = 0;
+	int speed = 0;
 	int ret;
 
+	match = dev_get_platdata(&pdev->dev);
+	if (!match)
+		return -EINVAL;
+
 	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables),
 			     GFP_KERNEL);
 	if (!opp_tables)
 		return -ENOMEM;
 
-	ret = sun50i_cpufreq_get_efuse(&speed);
-	if (ret)
-		return ret;
+	speed = sun50i_cpufreq_get_efuse(match->data);
+	if (speed < 0)
+		return speed;
 
 	snprintf(name, MAX_NAME_LEN, "speed%d", speed);
 
@@ -163,8 +180,12 @@ static struct platform_driver sun50i_cpufreq_driver = {
 	},
 };
 
+static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
+	.efuse_xlate = sun50i_h6_efuse_xlate,
+};
+
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
-	{ .compatible = "allwinner,sun50i-h6" },
+	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
 	{}
 };
 
@@ -198,9 +219,8 @@ static int __init sun50i_cpufreq_init(void)
 	if (unlikely(ret < 0))
 		return ret;
 
-	sun50i_cpufreq_pdev =
-		platform_device_register_simple("sun50i-cpufreq-nvmem",
-						-1, NULL, 0);
+	sun50i_cpufreq_pdev = platform_device_register_data(NULL,
+		"sun50i-cpufreq-nvmem", -1, match, sizeof(*match));
 	ret = PTR_ERR_OR_ZERO(sun50i_cpufreq_pdev);
 	if (ret == 0)
 		return 0;
-- 
2.28.0

