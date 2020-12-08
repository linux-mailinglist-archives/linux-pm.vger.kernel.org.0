Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A742D20EB
	for <lists+linux-pm@lfdr.de>; Tue,  8 Dec 2020 03:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbgLHCiR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Dec 2020 21:38:17 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:46370 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727702AbgLHCiR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Dec 2020 21:38:17 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.09102429|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.259475-0.000416156-0.740109;FP=13177509390828733794|2|2|9|0|-1|-1|-1;HT=ay29a033018047190;MF=huangshuosheng@allwinnertech.com;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.J4MSblz_1607395050;
Received: from allwinnertech.com(mailfrom:huangshuosheng@allwinnertech.com fp:SMTPD_---.J4MSblz_1607395050)
          by smtp.aliyun-inc.com(10.147.40.200);
          Tue, 08 Dec 2020 10:37:32 +0800
From:   Shuosheng Huang <huangshuosheng@allwinnertech.com>
To:     tiny.windzz@gmail.com, rjw@rjwysocki.net, viresh.kumar@linaro.org,
        mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Shuosheng Huang <huangshuosheng@allwinnertech.com>
Subject: [PATCH v3 2/6] cpufreq: sun50i: add a100 cpufreq support
Date:   Tue,  8 Dec 2020 10:37:28 +0800
Message-Id: <20201208023728.22603-1-huangshuosheng@allwinnertech.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add cpufreq nvmem based for allwinner a100 SoC, it's similar to h6.

Signed-off-by: Shuosheng Huang <huangshuosheng@allwinnertech.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c   |  1 +
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 32 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

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
index da23d581a4b4..def4a19abe16 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -25,6 +25,9 @@
 #define SUN50I_H6_NVMEM_MASK		0x7
 #define SUN50I_H6_NVMEM_SHIFT		5
 
+#define SUN50I_A100_NVMEM_MASK		0xf
+#define SUN50I_A100_NVMEM_SHIFT		12
+
 struct sunxi_cpufreq_soc_data {
 	u32 (*efuse_xlate)(void *efuse);
 };
@@ -55,6 +58,30 @@ static u32 sun50i_h6_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
 		return 0;
 }
 
+static u32 sun50i_a100_efuse_xlate(struct nvmem_cell *speedbin_nvmem)
+{
+	size_t len;
+	u32 *speedbin;
+	u32 efuse_value;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	efuse_value = (*(u16 *)efuse >> SUN50I_A100_NVMEM_SHIFT) &
+			  SUN50I_A100_NVMEM_MASK;
+	kfree(speedbin);
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
 /**
  * sun50i_cpufreq_get_efuse() - Determine speed grade from efuse value
  * @soc_data: pointer to sunxi_cpufreq_soc_data context
@@ -188,8 +215,13 @@ static const struct sunxi_cpufreq_soc_data sun50i_h6_data = {
 	.efuse_xlate = sun50i_h6_efuse_xlate,
 };
 
+static const struct sunxi_cpufreq_soc_data sun50i_a100_data = {
+	.efuse_xlate = sun50i_a100_efuse_xlate,
+};
+
 static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6", .data = &sun50i_h6_data },
+	{ .compatible = "allwinner,sun50i-a100", .data = &sun50i_a100_data },
 	{}
 };
 
-- 
2.28.0

