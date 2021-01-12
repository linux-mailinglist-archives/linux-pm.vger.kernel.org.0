Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F375E2F38B7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 19:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406644AbhALSXe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 13:23:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406612AbhALSXb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jan 2021 13:23:31 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4CF1C061786
        for <linux-pm@vger.kernel.org>; Tue, 12 Jan 2021 10:21:42 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id EBBE53EBD9;
        Tue, 12 Jan 2021 19:20:58 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rjw@rjwysocki.net, viresh.kumar@linaro.org, nks@flawful.org,
        agross@kernel.org, bjorn.andersson@linaro.org,
        daniel.lezcano@linaro.org, manivannan.sadhasivam@linaro.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH v3 02/15] soc: qcom: spm: Implement support for SAWv4.1, SDM630/660 L2 AVS
Date:   Tue, 12 Jan 2021 19:20:39 +0100
Message-Id: <20210112182052.481888-3-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112182052.481888-1-angelogioacchino.delregno@somainline.org>
References: <20210112182052.481888-1-angelogioacchino.delregno@somainline.org>
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
 1 file changed, 27 insertions(+), 1 deletion(-)

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
-- 
2.29.2

