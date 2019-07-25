Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B28E74BEE
	for <lists+linux-pm@lfdr.de>; Thu, 25 Jul 2019 12:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbfGYKmq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 25 Jul 2019 06:42:46 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:45725 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389377AbfGYKme (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 25 Jul 2019 06:42:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id m23so47444715lje.12
        for <linux-pm@vger.kernel.org>; Thu, 25 Jul 2019 03:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lthHRg+gKXUu96aNRs4HmAIZHQgiKH+Tn5IF/VHfwN4=;
        b=bik7/fTBpoIKUMQpRer7EZRyL8s2d/DAzqt781ZRaZF2vwO1YCG6Qs4D75TXyU/Aqd
         QSZ3GJWLYKpwW5o0LrZKZsEk4CJcXsv6AgCV/J7cDqOiEvjFRBIVkvtiiqQA/VjRn2qf
         bdC1jNuEb0T0HuwbJNSe3YVhop2MaqYHeEBujobY8fvxBU232FETSigsM6mBhv2yHcIy
         5dnp3zdQU6XIbchzboRdwDQ+ZmMk0I9pjyVsyQdpXaUo2bv60Lv2nsuSJknU+y77FYls
         iUIOHoo8ck5x0h0baCJf43xQI3/6KainyUBCQY6+M2uIw9xKwncn8JP7KiONLBG/tzQL
         s5uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lthHRg+gKXUu96aNRs4HmAIZHQgiKH+Tn5IF/VHfwN4=;
        b=aHupxzgc33GV+YV+CwPDIbhtpXafWBzZqrkvc/fCGNHsRSBSMJ2IHCWlv325AWnJjs
         BWWaZqrSa+58btcl7L3heVnTinPs57xT3WEnzzg7ncIC8TI2njzP+hEfHeaJAEIQmSx7
         SoR5XYiQuI3NROjygCg7DQTYCHkufXpY6oBPST1SIHWPOyxaGo+NqVqG8tYoHmEzHT1M
         GqP1yYs4knXalUH2tZnX7o8ic9+cwaOBTET4xiVQABuo3NRkPgZUSHw8JC4IukWdeWIO
         cIYMPRQX1BjVqZEmv2SsNBuEjarcaa+lKZpulEC0R32wSjPBU+TdEjAgxnXkusuRpK+C
         ehmQ==
X-Gm-Message-State: APjAAAW9MnhSG3kkCUjs+YaLikFmIA+eCnzeACMIQ2EZeA//RPKNKOMi
        G7CRSeqUKR0u9tFHb1R1jnwqKg==
X-Google-Smtp-Source: APXvYqy30cmSo8WOFrobopcmlYQFl9tHS1A4U25VNDfym4apAzYxjLNd5zvlPoZoGBvkb+mGvfdJZg==
X-Received: by 2002:a2e:89ca:: with SMTP id c10mr30275573ljk.106.1564051352562;
        Thu, 25 Jul 2019 03:42:32 -0700 (PDT)
Received: from localhost.localdomain (ua-83-226-44-230.bbcust.telenor.se. [83.226.44.230])
        by smtp.gmail.com with ESMTPSA id k124sm7461299lfd.60.2019.07.25.03.42.31
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 03:42:32 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     Andy Gross <agross@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, jorge.ramirez-ortiz@linaro.org,
        sboyd@kernel.org, vireshk@kernel.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, Niklas Cassel <niklas.cassel@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/14] cpufreq: qcom: Add support for qcs404 on nvmem driver
Date:   Thu, 25 Jul 2019 12:41:35 +0200
Message-Id: <20190725104144.22924-8-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190725104144.22924-1-niklas.cassel@linaro.org>
References: <20190725104144.22924-1-niklas.cassel@linaro.org>
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
Changes since V1:
-Adapt to dev_pm_opp_attach_genpd() API change.

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 50 ++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 2d798a1685c5..f0d2d5035413 100644
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
@@ -203,7 +220,22 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
+							drv->data->genpd_names,
+							NULL);
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
@@ -218,6 +250,13 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
@@ -238,11 +277,15 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 
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
@@ -259,6 +302,7 @@ static struct platform_driver qcom_cpufreq_driver = {
 static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
+	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{},
 };
 
-- 
2.21.0

