Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEAB60397
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfGEJ6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:58:40 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45893 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfGEJ6I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:58:08 -0400
Received: by mail-lf1-f65.google.com with SMTP id u10so5921118lfm.12
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MJVAb2eTArKPXkqfMij+OJ8quEfYPEO9VgNZrWiWtQw=;
        b=D6veqwBCIZdaKGVBQ823wxMfWToSH4h/wgYIP61phEzN15O3oc9H34N4J9ACNGQjax
         IukHXAeq2Io6RL07oxPu+7BG9Zt9R75uH9EtJOALTlCzIpyVWKaPkP9I4wBvRYYIjOIJ
         6r9V2i/NXacNfOoJCUPfvMiudTNakw7Vfeuxs40sLTZXxtDUOHRp/QWrG2DpSJPWyGzT
         HF2GerMMIJ+L3Ms7OGRqrDP1sQOiv4TEUsXGwrXcJlthNI/UC0+aWkFeA1RdWQIPgN/P
         yM4fKaoGjNSK5W8khJib1VvNN4ialfpWiINA4WT0jkQsrgKXTKcw3Vh+TajVuLwZe7ib
         9GKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MJVAb2eTArKPXkqfMij+OJ8quEfYPEO9VgNZrWiWtQw=;
        b=SzPe+0ImPceRv1eC8NrGrluwXdDKrGPEqdhDrjEU5ejfZtLb5UZ8sCYhA7chCuGrEk
         3YqKYNBgXkVvHKOEdqi1phYa6I+0PU18TuD/YNLV7t+FOAzJOpmhyjSAckK2I3T89hHY
         1ZgA4zjh0vHj/oiorm3nBfghaclbQfWEx20NnVQ1P+y8sZyHq7Zre3EMUWaLvc0E49S/
         YGDDszQq6wxKK5AF/SPRRAnAgTULgGZOVhY0I0XZKHvac+dujmChWbQqVIuJwjPzkJBJ
         +t7D8iJ2X3vi+KpLo95wwsE/gppmeYDJQgyrlfN5D6v0r9NRY7M4eL89vXyGA61m5klX
         gdow==
X-Gm-Message-State: APjAAAXLOKcAIaLUVqqEmPWhQ6hwEdLNvpyGr5Cw2mcXQ73/s87pZJa9
        6qDVB7tmeip28n+PHFyw41siDQ==
X-Google-Smtp-Source: APXvYqxY73jVLqcsA5jlKdLmB4XHPhSHvFM6j887J1gyo2PK2CphQ4eHcV+iboDU5JQzRq359ti5jw==
X-Received: by 2002:a19:4f42:: with SMTP id a2mr1530966lfk.23.1562320684861;
        Fri, 05 Jul 2019 02:58:04 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id 25sm1692704ljn.62.2019.07.05.02.58.03
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:04 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/13] cpufreq: qcom: Refactor the driver to make it easier to extend
Date:   Fri,  5 Jul 2019 11:57:15 +0200
Message-Id: <20190705095726.21433-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Refactor the driver to make it easier to extend in a later commit.

Create a driver struct to collect all common resources, in order to make
it easier to free up all common resources.
Create a driver match_data struct to make it easier to extend the driver
with support for new features that might only be supported on certain SoCs.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since RFC:
-Changed type of versions to u32 from u32*.
-Make the driver use a match_data struct, so that different SoC can have
different features.
-Fixed error handling.

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 123 +++++++++++++++++----------
 1 file changed, 79 insertions(+), 44 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index fad6509eecb5..c0377b0eb2f4 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -43,6 +43,20 @@ enum _msm8996_version {
 	NUM_OF_MSM8996_VERSIONS,
 };
 
+struct qcom_cpufreq_drv;
+
+struct qcom_cpufreq_match_data {
+	int (*get_version)(struct device *cpu_dev,
+			   struct nvmem_cell *speedbin_nvmem,
+			   struct qcom_cpufreq_drv *drv);
+};
+
+struct qcom_cpufreq_drv {
+	struct opp_table **opp_tables;
+	u32 versions;
+	const struct qcom_cpufreq_match_data *data;
+};
+
 static struct platform_device *cpufreq_dt_pdev, *cpufreq_pdev;
 
 static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
@@ -76,7 +90,7 @@ static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 					  struct nvmem_cell *speedbin_nvmem,
-					  u32 *versions)
+					  struct qcom_cpufreq_drv *drv)
 {
 	size_t len;
 	u8 *speedbin;
@@ -94,10 +108,10 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
-		*versions = 1 << (unsigned int)(*speedbin);
+		drv->versions = 1 << (unsigned int)(*speedbin);
 		break;
 	case MSM8996_SG:
-		*versions = 1 << ((unsigned int)(*speedbin) + 4);
+		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
 		break;
 	default:
 		BUG();
@@ -108,17 +122,17 @@ static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
 	return 0;
 }
 
+static const struct qcom_cpufreq_match_data match_data_kryo = {
+	.get_version = qcom_cpufreq_kryo_name_version,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
-	struct opp_table **opp_tables;
-	int (*get_version)(struct device *cpu_dev,
-			   struct nvmem_cell *speedbin_nvmem,
-			   u32 *versions);
+	struct qcom_cpufreq_drv *drv;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
 	struct device *cpu_dev;
 	unsigned cpu;
-	u32 versions;
 	const struct of_device_id *match;
 	int ret;
 
@@ -126,11 +140,6 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	if (!cpu_dev)
 		return -ENODEV;
 
-	match = pdev->dev.platform_data;
-	get_version = match->data;
-	if (!get_version)
-		return -ENODEV;
-
 	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
 	if (!np)
 		return -ENOENT;
@@ -141,23 +150,43 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		return -ENOENT;
 	}
 
-	speedbin_nvmem = of_nvmem_cell_get(np, NULL);
-	of_node_put(np);
-	if (IS_ERR(speedbin_nvmem)) {
-		if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
-			dev_err(cpu_dev, "Could not get nvmem cell: %ld\n",
-				PTR_ERR(speedbin_nvmem));
-		return PTR_ERR(speedbin_nvmem);
+	drv = kzalloc(sizeof(*drv), GFP_KERNEL);
+	if (!drv)
+		return -ENOMEM;
+
+	match = pdev->dev.platform_data;
+	drv->data = match->data;
+	if (!drv->data) {
+		ret = -ENODEV;
+		goto free_drv;
 	}
 
-	ret = get_version(cpu_dev, speedbin_nvmem, &versions);
-	nvmem_cell_put(speedbin_nvmem);
-	if (ret)
-		return ret;
+	if (drv->data->get_version) {
+		speedbin_nvmem = of_nvmem_cell_get(np, NULL);
+		of_node_put(np);
+		if (IS_ERR(speedbin_nvmem)) {
+			if (PTR_ERR(speedbin_nvmem) != -EPROBE_DEFER)
+				dev_err(cpu_dev,
+					"Could not get nvmem cell: %ld\n",
+					PTR_ERR(speedbin_nvmem));
+			ret = PTR_ERR(speedbin_nvmem);
+			goto free_drv;
+		}
 
-	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
-	if (!opp_tables)
-		return -ENOMEM;
+		ret = drv->data->get_version(cpu_dev, speedbin_nvmem, drv);
+		if (ret) {
+			nvmem_cell_put(speedbin_nvmem);
+			goto free_drv;
+		}
+		nvmem_cell_put(speedbin_nvmem);
+	}
+
+	drv->opp_tables = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tables),
+				  GFP_KERNEL);
+	if (!drv->opp_tables) {
+		ret = -ENOMEM;
+		goto free_drv;
+	}
 
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
@@ -166,19 +195,23 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			goto free_opp;
 		}
 
-		opp_tables[cpu] = dev_pm_opp_set_supported_hw(cpu_dev,
-							      &versions, 1);
-		if (IS_ERR(opp_tables[cpu])) {
-			ret = PTR_ERR(opp_tables[cpu]);
-			dev_err(cpu_dev, "Failed to set supported hardware\n");
-			goto free_opp;
+		if (drv->data->get_version) {
+			drv->opp_tables[cpu] =
+				dev_pm_opp_set_supported_hw(cpu_dev,
+							    &drv->versions, 1);
+			if (IS_ERR(drv->opp_tables[cpu])) {
+				ret = PTR_ERR(drv->opp_tables[cpu]);
+				dev_err(cpu_dev,
+					"Failed to set supported hardware\n");
+				goto free_opp;
+			}
 		}
 	}
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
 	if (!IS_ERR(cpufreq_dt_pdev)) {
-		platform_set_drvdata(pdev, opp_tables);
+		platform_set_drvdata(pdev, drv);
 		return 0;
 	}
 
@@ -187,26 +220,30 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 
 free_opp:
 	for_each_possible_cpu(cpu) {
-		if (IS_ERR_OR_NULL(opp_tables[cpu]))
+		if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
 			break;
-		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+		dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
 	}
-	kfree(opp_tables);
+	kfree(drv->opp_tables);
+free_drv:
+	kfree(drv);
 
 	return ret;
 }
 
 static int qcom_cpufreq_remove(struct platform_device *pdev)
 {
-	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	struct qcom_cpufreq_drv *drv = platform_get_drvdata(pdev);
 	unsigned int cpu;
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
 	for_each_possible_cpu(cpu)
-		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+		if (drv->opp_tables[cpu])
+			dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
 
-	kfree(opp_tables);
+	kfree(drv->opp_tables);
+	kfree(drv);
 
 	return 0;
 }
@@ -220,10 +257,8 @@ static struct platform_driver qcom_cpufreq_driver = {
 };
 
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
-	{ .compatible = "qcom,apq8096",
-	  .data = qcom_cpufreq_kryo_name_version },
-	{ .compatible = "qcom,msm8996",
-	  .data = qcom_cpufreq_kryo_name_version },
+	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
+	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{},
 };
 
-- 
2.21.0

