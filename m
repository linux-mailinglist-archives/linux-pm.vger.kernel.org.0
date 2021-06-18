Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7703F3AD582
	for <lists+linux-pm@lfdr.de>; Sat, 19 Jun 2021 00:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhFRW6j (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Jun 2021 18:58:39 -0400
Received: from m-r2.th.seeweb.it ([5.144.164.171]:41535 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbhFRW6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Jun 2021 18:58:38 -0400
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id DFFBF3F412;
        Sat, 19 Jun 2021 00:56:23 +0200 (CEST)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     bjorn.andersson@linaro.org
Cc:     agross@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, phone-devel@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, jeffrey.l.hugo@gmail.com,
        jamipkettunen@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht, stephan@gerhold.net,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v5 2/3] soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS
Date:   Sat, 19 Jun 2021 00:56:19 +0200
Message-Id: <20210618225620.623359-3-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618225620.623359-1-angelogioacchino.delregno@somainline.org>
References: <20210618225620.623359-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Implement the support for SAW v4.1, used in at least MSM8998,
SDM630, SDM660 and APQ variants and, while at it, also add the
configuration for the SDM630/660 Silver and Gold cluster L2
Adaptive Voltage Scaler: this is also one of the prerequisites
to allow the OSM controller to perform DCVS.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 drivers/soc/qcom/spm.c | 28 +++++++++++++++++++++++++++-
 include/soc/qcom/spm.h |  4 +++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
index 0c8aa9240c41..843732d12c54 100644
--- a/drivers/soc/qcom/spm.c
+++ b/drivers/soc/qcom/spm.c
@@ -32,9 +32,28 @@ enum spm_reg {
 	SPM_REG_SEQ_ENTRY,
 	SPM_REG_SPM_STS,
 	SPM_REG_PMIC_STS,
+	SPM_REG_AVS_CTL,
+	SPM_REG_AVS_LIMIT,
 	SPM_REG_NR,
 };
 
+static const u16 spm_reg_offset_v4_1[SPM_REG_NR] = {
+	[SPM_REG_AVS_CTL]	= 0x904,
+	[SPM_REG_AVS_LIMIT]	= 0x908,
+};
+
+static const struct spm_reg_data spm_reg_660_gold_l2  = {
+	.reg_offset = spm_reg_offset_v4_1,
+	.avs_ctl = 0x1010031,
+	.avs_limit = 0x4580458,
+};
+
+static const struct spm_reg_data spm_reg_660_silver_l2  = {
+	.reg_offset = spm_reg_offset_v4_1,
+	.avs_ctl = 0x101c031,
+	.avs_limit = 0x4580458,
+};
+
 static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
 	[SPM_REG_CFG]		= 0x08,
 	[SPM_REG_SPM_CTL]	= 0x30,
@@ -126,6 +145,10 @@ void spm_set_low_power_mode(struct spm_driver_data *drv,
 }
 
 static const struct of_device_id spm_match_table[] = {
+	{ .compatible = "qcom,sdm660-gold-saw2-v4.1-l2",
+	  .data = &spm_reg_660_gold_l2 },
+	{ .compatible = "qcom,sdm660-silver-saw2-v4.1-l2",
+	  .data = &spm_reg_660_silver_l2 },
 	{ .compatible = "qcom,msm8974-saw2-v2.1-cpu",
 	  .data = &spm_reg_8974_8084_cpu },
 	{ .compatible = "qcom,apq8084-saw2-v2.1-cpu",
@@ -169,6 +192,8 @@ static int spm_dev_probe(struct platform_device *pdev)
 	 * CPU was held in reset, the reset signal could trigger the SPM state
 	 * machine, before the sequences are completely written.
 	 */
+	spm_register_write(drv, SPM_REG_AVS_CTL, drv->reg_data->avs_ctl);
+	spm_register_write(drv, SPM_REG_AVS_LIMIT, drv->reg_data->avs_limit);
 	spm_register_write(drv, SPM_REG_CFG, drv->reg_data->spm_cfg);
 	spm_register_write(drv, SPM_REG_DLY, drv->reg_data->spm_dly);
 	spm_register_write(drv, SPM_REG_PMIC_DLY, drv->reg_data->pmic_dly);
@@ -178,7 +203,8 @@ static int spm_dev_probe(struct platform_device *pdev)
 				drv->reg_data->pmic_data[1]);
 
 	/* Set up Standby as the default low power mode */
-	spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
+	if (drv->reg_data->reg_offset[SPM_REG_SPM_CTL])
+		spm_set_low_power_mode(drv, PM_SLEEP_MODE_STBY);
 
 	return 0;
 }
diff --git a/include/soc/qcom/spm.h b/include/soc/qcom/spm.h
index 719c604a8402..5ab40488a9f4 100644
--- a/include/soc/qcom/spm.h
+++ b/include/soc/qcom/spm.h
@@ -22,11 +22,13 @@ enum pm_sleep_mode {
 };
 
 struct spm_reg_data {
-	const u8 *reg_offset;
+	const u16 *reg_offset;
 	u32 spm_cfg;
 	u32 spm_dly;
 	u32 pmic_dly;
 	u32 pmic_data[MAX_PMIC_DATA];
+	u32 avs_ctl;
+	u32 avs_limit;
 	u8 seq[MAX_SEQ_DATA];
 	u8 start_index[PM_SLEEP_MODE_NR];
 };
-- 
2.32.0

