Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CCA2CE86C
	for <lists+linux-pm@lfdr.de>; Fri,  4 Dec 2020 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgLDHKG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Dec 2020 02:10:06 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:49538 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727939AbgLDHKG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 4 Dec 2020 02:10:06 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436367|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0402969-0.00271428-0.956989;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.J2qu1x2_1607065747;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J2qu1x2_1607065747)
          by smtp.aliyun-inc.com(10.147.42.253);
          Fri, 04 Dec 2020 15:09:16 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     robh+dt@kernel.org, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@siol.net, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, tiny.windzz@gmail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH 1/2] cpufreq: sun50i: add a100 cpufreq support
Date:   Fri,  4 Dec 2020 15:09:01 +0800
Message-Id: <20201204070901.24592-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Let's add cpufreq nvmem based for allwinner a100 soc. It's similar to h6,
let us use efuse_xlate to extract the differentiated part.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 81 ++++++++++++++++++++------
 2 files changed, 64 insertions(+), 18 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 3776d960f405..2ebf5d9cb616 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -102,6 +102,7 @@ static const struct of_device_id whitelist[] __initconst = {
  */
 static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
+	{ .compatible = "allwinner,sun50i-a100", },
 
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 9907a165135b..044e44a763f5 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -21,21 +21,63 @@
 
 #define NVMEM_MASK	0x7
 #define NVMEM_SHIFT	5
+#define SUN50I_A100_NVMEM_MASK		0xf
+#define SUN50I_A100_NVMEM_SHIFT		12
+
+#define SUN50I_H6_NVMEM_MASK		0x7
+#define SUN50I_H6_NVMEM_SHIFT		5
+
+struct sunxi_cpufreq_soc_data {
+	u32 (*efuse_xlate)(void *efuse);
+};
 
 static struct platform_device *cpufreq_dt_pdev, *sun50i_cpufreq_pdev;
 
+static u32 sun50i_a100_efuse_xlate(void *efuse)
+{
+	u32 efuse_value = (*(u16 *)efuse >> SUN50I_A100_NVMEM_SHIFT) &
+			  SUN50I_A100_NVMEM_MASK;
+
+	switch (efuse_value) {
+	case 0b100:
+		return 2;
+	case 0b010:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static u32 sun50i_h6_efuse_xlate(void *efuse)
+{
+	u32 efuse_value = (*(u32 *)efuse >> SUN50I_H6_NVMEM_SHIFT) &
+			  SUN50I_H6_NVMEM_MASK;
+
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
+ * @soc_data: pointer to sunxi_cpufreq_soc_data context
  * @versions: Set to the value parsed from efuse
  *
  * Returns 0 if success.
  */
-static int sun50i_cpufreq_get_efuse(u32 *versions)
+static int sun50i_cpufreq_get_efuse(const struct sunxi_cpufreq_soc_data *soc_data,
+				    u32 *versions)
 {
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
-	u32 *speedbin, efuse_value;
+	u32 *speedbin;
 	size_t len;
 	int ret;
 
@@ -68,17 +110,7 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 	if (IS_ERR(speedbin))
 		return PTR_ERR(speedbin);
 
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
+	*versions = soc_data->efuse_xlate(speedbin);
 
 	kfree(speedbin);
 	return 0;
@@ -86,18 +118,23 @@ static int sun50i_cpufreq_get_efuse(u32 *versions)
 
 static int sun50i_cpufreq_nvmem_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *match;
 	struct opp_table **opp_tables;
 	char name[MAX_NAME_LEN];
 	unsigned int cpu;
 	u32 speed = 0;
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
+	ret = sun50i_cpufreq_get_efuse(match->data, &speed);
 	if (ret)
 		return ret;
 
@@ -163,8 +200,17 @@ static struct platform_driver sun50i_cpufreq_driver = {
 	},
 };
 
+static const struct sunxi_cpufreq_soc_data sun50i_a100_data = {
+	.efuse_xlate = sun50i_a100_efuse_xlate,
+};
+
+static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
+	.efuse_xlate = sun50i_h6_efuse_xlate,
+};
+
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
-	{ .compatible = "allwinner,sun50i-h6" },
+	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
+	{ .compatible = "allwinner,sun50i-a100", .data = &sun50i_a100_data },
 	{}
 };
 
@@ -198,9 +244,8 @@ static int __init sun50i_cpufreq_init(void)
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

