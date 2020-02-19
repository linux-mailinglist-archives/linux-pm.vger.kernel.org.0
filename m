Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6EF3165053
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 21:56:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBSU4X (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 15:56:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40423 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgBSU4W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 15:56:22 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so2177244wmi.5;
        Wed, 19 Feb 2020 12:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMk/Y7Fqu98LytrpnZeBf0vMkusEQQP/lCvCtTwXUs4=;
        b=SnWvR2uLDPWet7/2PIuVvUdACeAf9w4tf8I4HzlAQTQlLQF+jcgy30Tq1+E7pia9gh
         sica45qA6OJq1ISNn92a+TmCHsqkjqNhfKokg3RipXZy1coAlVgEPwdplQVtETwxirvy
         jtqpnDf3LJ4EV2oaqudxyrIWf4SKkWb4GhOckvw7LOEoviG6gz7U8HVNV4mjUPkHF3Mi
         FmnNqHICSMV8EjAjAIlHxB+hoqjWjlgvtFtR4LuimT/s/n1a+la2mPHqS46uzvt25OQR
         txz9vDC/jtfA7ZfiXFEYBN6LlH5+mFCZvjkJW/8T6WHkzgmLUbsOz6J0xWCf5xHXmSL6
         et+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sMk/Y7Fqu98LytrpnZeBf0vMkusEQQP/lCvCtTwXUs4=;
        b=nrzXw/PxZ+OBKP6SckER/zdcxgNtd77tVJJZIsUq330ChYKi8NI4kBBft1VsG3CVBn
         v07XxySYSUgu//kT4EOC9U+7lN8M3vUynepfbJQ8TTj81rej1LZuwstwh/kTLD3MfUTA
         k0DDvA2ga89rceZXHm1Mkpauasxg/81PtJ9I4y6eVOZHkgDGt8BltafMHREdd2V4hOPm
         oyhrjwU6kl1Pjx0WgbvcJmbv/vxyxk2/4SStDGpHQSA+P6/NH67STSdntpK5DAeILgGQ
         0cfj9RqrBEGiYh1Ae/+quv8Irkj54E8nzFCH6UEaO8VjCe3VYWJ6ISZd+irNVSoGy+iX
         ooOQ==
X-Gm-Message-State: APjAAAWe4/y+vW2QQceECE9F2wbKLu1B/Zjjl4+X1fLc0s/pmqoklNg+
        SMCdQINmsGrjnt4b2pbcwhCvU5RlvO0=
X-Google-Smtp-Source: APXvYqxfBKxU+0cLJYYZ4YvZ4KGKqVu8uWMSazJl/G4F1CmgKyg5eUtgqIK+6jG9VFrqiew9xXIt+g==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr12116795wml.138.1582145778806;
        Wed, 19 Feb 2020 12:56:18 -0800 (PST)
Received: from Ansuel-XPS.localdomain ([5.170.106.116])
        by smtp.googlemail.com with ESMTPSA id v15sm1435093wrf.7.2020.02.19.12.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 12:56:17 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Ansuel Smith <ansuelsmth@gmail.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: qcom: Add support for krait based socs
Date:   Wed, 19 Feb 2020 21:55:45 +0100
Message-Id: <20200219205546.6800-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In Certain QCOM SoCs like ipq8064, apq8064, msm8960, msm8974
that has KRAIT processors the voltage/current value of each OPP
varies based on the silicon variant in use.

The required OPP related data is determined based on
the efuse value. This is similar to the existing code for
kryo cores. So adding support for krait cores here.

Signed-off-by: Sricharan R <sricharan@codeaurora.org>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 .../bindings/opp/qcom-nvmem-cpufreq.txt       |   3 +-
 drivers/cpufreq/Kconfig.arm                   |   2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c          |   5 +
 drivers/cpufreq/qcom-cpufreq-nvmem.c          | 181 ++++++++++++++++--
 4 files changed, 173 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
index 4751029b9b74..64f07417ecfb 100644
--- a/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
+++ b/Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
@@ -19,7 +19,8 @@ In 'cpu' nodes:
 
 In 'operating-points-v2' table:
 - compatible: Should be
-	- 'operating-points-v2-kryo-cpu' for apq8096 and msm8996.
+	- 'operating-points-v2-kryo-cpu' for apq8096, msm8996, msm8974,
+					     apq8064, ipq8064, msm8960 and ipq8074.
 
 Optional properties:
 --------------------
diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 3858d86cf409..15c1a1231516 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -128,7 +128,7 @@ config ARM_OMAP2PLUS_CPUFREQ
 
 config ARM_QCOM_CPUFREQ_NVMEM
 	tristate "Qualcomm nvmem based CPUFreq"
-	depends on ARM64
+	depends on ARCH_QCOM
 	depends on QCOM_QFPROM
 	depends on QCOM_SMEM
 	select PM_OPP
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index f2ae9cd455c1..cb9db16bea61 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -141,6 +141,11 @@ static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "ti,dra7", },
 	{ .compatible = "ti,omap3", },
 
+	{ .compatible = "qcom,ipq8064", },
+	{ .compatible = "qcom,apq8064", },
+	{ .compatible = "qcom,msm8974", },
+	{ .compatible = "qcom,msm8960", },
+
 	{ }
 };
 
diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index f0d2d5035413..35a616189030 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -49,12 +49,14 @@ struct qcom_cpufreq_drv;
 struct qcom_cpufreq_match_data {
 	int (*get_version)(struct device *cpu_dev,
 			   struct nvmem_cell *speedbin_nvmem,
+			   char **pvs_name,
 			   struct qcom_cpufreq_drv *drv);
 	const char **genpd_names;
 };
 
 struct qcom_cpufreq_drv {
-	struct opp_table **opp_tables;
+	struct opp_table **names_opp_tables;
+	struct opp_table **hw_opp_tables;
 	struct opp_table **genpd_opp_tables;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
@@ -62,6 +64,81 @@ struct qcom_cpufreq_drv {
 
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
+static void get_krait_bin_format_a(struct device *cpu_dev,
+					  int *speed, int *pvs, int *pvs_ver,
+					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+{
+	u32 pte_efuse;
+
+	pte_efuse = *((u32 *)buf);
+
+	*speed = pte_efuse & 0xf;
+	if (*speed == 0xf)
+		*speed = (pte_efuse >> 4) & 0xf;
+
+	if (*speed == 0xf) {
+		*speed = 0;
+		dev_warn(cpu_dev, "Speed bin: Defaulting to %d\n", *speed);
+	} else {
+		dev_dbg(cpu_dev, "Speed bin: %d\n", *speed);
+	}
+
+	*pvs = (pte_efuse >> 10) & 0x7;
+	if (*pvs == 0x7)
+		*pvs = (pte_efuse >> 13) & 0x7;
+
+	if (*pvs == 0x7) {
+		*pvs = 0;
+		dev_warn(cpu_dev, "PVS bin: Defaulting to %d\n", *pvs);
+	} else {
+		dev_dbg(cpu_dev, "PVS bin: %d\n", *pvs);
+	}
+}
+
+static void get_krait_bin_format_b(struct device *cpu_dev,
+					  int *speed, int *pvs, int *pvs_ver,
+					  struct nvmem_cell *pvs_nvmem, u8 *buf)
+{
+	u32 pte_efuse, redundant_sel;
+
+	pte_efuse = *((u32 *)buf);
+	redundant_sel = (pte_efuse >> 24) & 0x7;
+	*speed = pte_efuse & 0x7;
+
+	/* 4 bits of PVS are in efuse register bits 31, 8-6. */
+	*pvs = ((pte_efuse >> 28) & 0x8) | ((pte_efuse >> 6) & 0x7);
+	*pvs_ver = (pte_efuse >> 4) & 0x3;
+
+	switch (redundant_sel) {
+	case 1:
+		*speed = (pte_efuse >> 27) & 0xf;
+		break;
+	case 2:
+		*pvs = (pte_efuse >> 27) & 0xf;
+		break;
+	}
+
+	/* Check SPEED_BIN_BLOW_STATUS */
+	if (pte_efuse & BIT(3)) {
+		dev_dbg(cpu_dev, "Speed bin: %d\n", *speed);
+	} else {
+		dev_warn(cpu_dev, "Speed bin not set. Defaulting to 0!\n");
+		*speed = 0;
+	}
+
+	/* Check PVS_BLOW_STATUS */
+	pte_efuse = *(((u32 *)buf) + 4);
+	pte_efuse &= BIT(21);
+	if (pte_efuse) {
+		dev_dbg(cpu_dev, "PVS bin: %d\n", *pvs);
+	} else {
+		dev_warn(cpu_dev, "PVS bin not set. Defaulting to 0!\n");
+		*pvs = 0;
+	}
+
+	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
+}
+
 static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 {
 	size_t len;
@@ -93,11 +170,13 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
+					  char **pvs_name,
 					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
 	u8 *speedbin;
 	enum _msm8996_version msm8996_version;
+	*pvs_name = NULL;
 
 	msm8996_version = qcom_cpufreq_get_msm_id();
 	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
@@ -125,10 +204,44 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	return 0;
 }
 
+static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
+					   struct nvmem_cell *speedbin_nvmem,
+					   char **pvs_name,
+					   struct qcom_cpufreq_drv *drv)
+{
+	int speed = 0, pvs = 0, pvs_ver = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (len == 4) {
+		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
+				       speedbin_nvmem, speedbin);
+	} else if (len == 8) {
+		get_krait_bin_format_b(cpu_dev, &speed, &pvs, &pvs_ver,
+				       speedbin_nvmem, speedbin);
+	} else {
+		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
+		return -ENODEV;
+	}
+
+	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
+		 speed, pvs, pvs_ver);
+
+	drv->versions = (1 << speed);
+
+	kfree(speedbin);
+	return 0;
+}
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
 
+static const struct qcom_cpufreq_match_data match_data_krait = {
+	.get_version = qcom_cpufreq_krait_name_version,
+};
+
 static const char *qcs404_genpd_names[] = { "cpr", NULL };
 
 static const struct qcom_cpufreq_match_data match_data_qcs404 = {
@@ -141,6 +254,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
+	char *pvs_name = "speedXX-pvsXX-vXX";
 	unsigned cpu;
 	const struct of_device_id *match;
 	int ret;
@@ -153,7 +267,7 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!np)
 		return -ENOENT;
 
-	ret = of_device_is_compatible(np, "operating-points-v2-kryo-cpu");
+	ret = of_device_is_compatible(np, "operating-points-v2-qcom-cpu");
 	if (!ret) {
 		of_node_put(np);
 		return -ENOENT;
@@ -181,7 +295,8 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			goto free_drv;
 		}
 
-		ret = drv->data->get_version(cpu_dev, speedbin_nvmem, drv);
+		ret = drv->data->get_version(cpu_dev,
+							speedbin_nvmem, &pvs_name, drv);
 		if (ret) {
 			nvmem_cell_put(speedbin_nvmem);
 			goto free_drv;
@@ -190,12 +305,20 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	}
 	of_node_put(np);
 
-	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
+	drv->names_opp_tables = kcalloc(num_possible_cpus(),
+				  sizeof(*drv->names_opp_tables),
 				  GFP_KERNEL);
-	if (!drv->opp_tables) {
+	if (!drv->names_opp_tables) {
 		ret = -ENOMEM;
 		goto free_drv;
 	}
+	drv->hw_opp_tables = kcalloc(num_possible_cpus(),
+				  sizeof(*drv->hw_opp_tables),
+				  GFP_KERNEL);
+	if (!drv->hw_opp_tables) {
+		ret = -ENOMEM;
+		goto free_opp1;
+	}
 
 	drv->genpd_opp_tables = kcalloc(num_possible_cpus(),
 					sizeof(*drv->genpd_opp_tables),
@@ -213,11 +336,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		}
 
 		if (drv->data->get_version) {
-			drv->opp_tables[cpu] =
-				dev_pm_opp_set_supported_hw(cpu_dev,
-							    &drv->versions, 1);
-			if (IS_ERR(drv->opp_tables[cpu])) {
-				ret = PTR_ERR(drv->opp_tables[cpu]);
+
+			if (pvs_name) {
+				drv->names_opp_tables[cpu] = dev_pm_opp_set_prop_name(
+								     cpu_dev,
+								     pvs_name);
+				if (IS_ERR(drv->names_opp_tables[cpu])) {
+					ret = PTR_ERR(drv->names_opp_tables[cpu]);
+					dev_err(cpu_dev, "Failed to add OPP name %s\n",
+						pvs_name);
+					goto free_opp;
+				}
+			}
+
+			drv->hw_opp_tables[cpu] = dev_pm_opp_set_supported_hw(
+									 cpu_dev, &drv->versions, 1);
+			if (IS_ERR(drv->hw_opp_tables[cpu])) {
+				ret = PTR_ERR(drv->hw_opp_tables[cpu]);
 				dev_err(cpu_dev,
 					"Failed to set supported hardware\n");
 				goto free_genpd_opp;
@@ -259,11 +394,18 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	kfree(drv->genpd_opp_tables);
 free_opp:
 	for_each_possible_cpu(cpu) {
-		if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
+		if (IS_ERR_OR_NULL(drv->names_opp_tables[cpu]))
+			break;
+		dev_pm_opp_put_prop_name(drv->names_opp_tables[cpu]);
+	}
+	for_each_possible_cpu(cpu) {
+		if (IS_ERR_OR_NULL(drv->hw_opp_tables[cpu]))
 			break;
-		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
+		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
 	}
-	kfree(drv->opp_tables);
+	kfree(drv->hw_opp_tables);
+free_opp1:
+	kfree(drv->names_opp_tables);
 free_drv:
 	kfree(drv);
 
@@ -278,13 +420,16 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu) {
-		if (drv->opp_tables[cpu])
-			dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
+		if (drv->names_opp_tables[cpu])
+			dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
+		if (drv->hw_opp_tables[cpu])
+			dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
 		if (drv->genpd_opp_tables[cpu])
 			dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
 	}
 
-	kfree(drv->opp_tables);
+	kfree(drv->names_opp_tables);
+	kfree(drv->hw_opp_tables);
 	kfree(drv->genpd_opp_tables);
 	kfree(drv);
 
@@ -303,6 +448,10 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
+	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
+	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
 	{},
 };
 
-- 
2.25.0

