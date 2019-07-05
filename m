Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 574C460390
	for <lists+linux-pm@lfdr.de>; Fri,  5 Jul 2019 11:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728482AbfGEJ6Y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 5 Jul 2019 05:58:24 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44578 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfGEJ6Y (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 5 Jul 2019 05:58:24 -0400
Received: by mail-lj1-f194.google.com with SMTP id k18so8676008ljc.11
        for <linux-pm@vger.kernel.org>; Fri, 05 Jul 2019 02:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u8/u3bwXkZOSy6eu5Z2KZv4GqIpK73hvpV5W7nEAtr8=;
        b=zwiyMKjlZMwH8lIXSWo0y8pv7/y9FQ3ndFZlbQXwbt2CgMSHLw59lKvqVT5NLf4Nue
         //0Xa5ov/+9HP2LeL3DPtc8TMao2ZsZU+fxiged59/1r6aTSaGy+NF2Bs/1gEyVbf7bs
         vCPqrxOoV4We3Q+XOhXrP3ruQzV8RmCvrpSHDFv88QY/PONG5zkyfMoY5RA/pLf1D5wa
         wHp5u5FTVwS2mUNLe6EOXxKsNu+5Ygl0EqAmqX3XLmTETdYgAoicSB16q+PDOviJf2hO
         3XF+0rQrWpr7pHNDf140WQa/6WZixjxUexnMSKz7XcYmZ49Hos0OfneEwVNijyENt8dB
         ou4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u8/u3bwXkZOSy6eu5Z2KZv4GqIpK73hvpV5W7nEAtr8=;
        b=bJRLsgFGomk06qWr/YFYw9jiME1Kd/qsudg5EqLlwT24hq3ga3JRkJtrM/3SYecsFy
         ksvg1qz/85T3QdZ0ej9a2NjoRG/ev2pCc4yB8HyschhL/qKJobSJjI+Cnw9Mlo4eR7Y7
         PnuHqeFAE5y9SF7d+xy4lljKUQwV6YmcvF59eVLxVFjyHzZTGC5GsKu0Nu9Bn96cimzb
         yKSvCZ/+DpEpeOPUzwphLoU7CrFIVLY0xHmkQJS4WlZqsuAek1BpgRi5qKqs9KqaoiXU
         tlMZ5pLMXVAQF6tHwWc9z9I9D2n0Tv0wLWEUBzLhNXbFkaFv8dzNpiBxGlwgz8mQe+3V
         iMKw==
X-Gm-Message-State: APjAAAXhz8fRWGVa9SrsN0967BkpyH82rxHpMFNJKtoysihYolHT533c
        +UQ6/Oepk1w2TimObNkAvqBJzQ==
X-Google-Smtp-Source: APXvYqy9qyxO4byetmUOuxjcwJQ/AdDI4S8b8jwDDftgCLI9lrDWCz0l5rilbiAT1LRClw/eDjpHmg==
X-Received: by 2002:a2e:1290:: with SMTP id 16mr1601420ljs.88.1562320701743;
        Fri, 05 Jul 2019 02:58:21 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-34-119.bbcust.telenor.se. [83.226.34.119])
        by smtp.gmail.com with ESMTPSA id o24sm1674955ljg.6.2019.07.05.02.58.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 05 Jul 2019 02:58:21 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/13] cpufreq: qcom: Add support for qcs404 on nvmem driver
Date:   Fri,  5 Jul 2019 11:57:17 +0200
Message-Id: <20190705095726.21433-7-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190705095726.21433-1-niklas.cassel@linaro.org>
References: <20190705095726.21433-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for qcs404 on nvmem driver.

The qcs404 SoC has support for Core Power Reduction (CPR), which is
implemented as a power domain provider, therefore add optional support
in this driver to attach to a genpd power domain.

Co-developed-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
Changes since RFC:
-Remove empty stub.
-Add power domain attach as a feature in the match_data struct.
-Failing to attach to the power domain is treated as a hard error.

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 ++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index c0377b0eb2f4..ec87c14b598c 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
@@ -49,10 +50,12 @@ struct qcom_cpufreq_match_data {
 	int (*get_version)(struct device *cpu_dev,
 			   struct nvmem_cell *speedbin_nvmem,
 			   struct qcom_cpufreq_drv *drv);
+	const char **genpd_names;
 };
 
 struct qcom_cpufreq_drv {
 	struct opp_table **opp_tables;
+	struct opp_table **genpd_opp_tables;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
 };
@@ -126,6 +129,12 @@ static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
 
+static const char *qcs404_genpd_names[] = { "cpr", NULL };
+
+static const struct qcom_cpufreq_match_data match_data_qcs404 = {
+	.genpd_names = qcs404_genpd_names,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -188,11 +197,19 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 		goto free_drv;
 	}
 
+	drv->genpd_opp_tables = kcalloc(num_possible_cpus(),
+					sizeof(*drv->genpd_opp_tables),
+					GFP_KERNEL);
+	if (!drv->genpd_opp_tables) {
+		ret = -ENOMEM;
+		goto free_opp;
+	}
+
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
 			ret = -ENODEV;
-			goto free_opp;
+			goto free_genpd_opp;
 		}
 
 		if (drv->data->get_version) {
@@ -203,7 +220,21 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 				ret = PTR_ERR(drv->opp_tables[cpu]);
 				dev_err(cpu_dev,
 					"Failed to set supported hardware\n");
-				goto free_opp;
+				goto free_genpd_opp;
+			}
+		}
+
+		if (drv->data->genpd_names) {
+			drv->genpd_opp_tables[cpu] =
+				dev_pm_opp_attach_genpd(cpu_dev,
+							drv->data->genpd_names);
+			if (IS_ERR(drv->genpd_opp_tables[cpu])) {
+				ret = PTR_ERR(drv->genpd_opp_tables[cpu]);
+				if (ret != -EPROBE_DEFER)
+					dev_err(cpu_dev,
+						"Could not attach to pm_domain: %d\n",
+						ret);
+				goto free_genpd_opp;
 			}
 		}
 	}
@@ -218,6 +249,13 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
+free_genpd_opp:
+	for_each_possible_cpu(cpu) {
+		if (IS_ERR_OR_NULL(drv->genpd_opp_tables[cpu]))
+			break;
+		dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
+	}
+	kfree(drv->genpd_opp_tables);
 free_opp:
 	for_each_possible_cpu(cpu) {
 		if (IS_ERR_OR_NULL(drv->opp_tables[cpu]))
@@ -238,11 +276,15 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu)
+	for_each_possible_cpu(cpu) {
 		if (drv->opp_tables[cpu])
 			dev_pm_opp_put_supported_hw(drv->opp_tables[cpu]);
+		if (drv->genpd_opp_tables[cpu])
+			dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
+	}
 
 	kfree(drv->opp_tables);
+	kfree(drv->genpd_opp_tables);
 	kfree(drv);
 
 	return 0;
@@ -259,6 +301,7 @@ static struct platform_driver qcom_cpufreq_driver = {
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
+	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{},
 };
 
-- 
2.21.0

