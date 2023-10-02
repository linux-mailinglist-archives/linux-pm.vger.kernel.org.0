Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9807B5AC2
	for <lists+linux-pm@lfdr.de>; Mon,  2 Oct 2023 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238539AbjJBS7v (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Oct 2023 14:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238511AbjJBS7u (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2023 14:59:50 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF427DA
        for <linux-pm@vger.kernel.org>; Mon,  2 Oct 2023 11:59:46 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-5046bf37daeso42234e87.1
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2023 11:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696273185; x=1696877985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jjTNnguvLOGzQRpp4J4p+5ap6mcEJVkzoAyjCrZDG0=;
        b=NQ2jQ/OFw/PTK1BnEpgfXw0gQY1B6T6VWOtV2+gPJ9XYDEOfgrnJc2S3dOoh9aT6E7
         DjoEhl+0un/5nhJOnP06zXn1KhPMoc0svDl29u3mpI3yhlQ43fhWHUvLf8GLUwejL1El
         mP3fA2cFAHogS3aD6me1+vlvr0ybcz/UJ77KJTM1gxMN8+IMvwfySyEq+2QOUu8WAsin
         n1vFIFiu4QAq8H+k1QS/OZxZuWRxT62NU9DeattywJHR4oBm92ua0M4mzQ0RB3aSEbfV
         nJa4byizxuaL9ORc7Q9BkJkLakdu5bvOW1sqC6LTmT5ZDXxYlGmXlg6We+bIcv7MFKL3
         WtuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696273185; x=1696877985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jjTNnguvLOGzQRpp4J4p+5ap6mcEJVkzoAyjCrZDG0=;
        b=XMU0O+47/ubnlFoaGFA5rmBKRVoRPhv2wvkjkjxY4YanISgOujOOY/KJidQ3Jx1eT8
         C5wr2gdam1hIUH9h7dHgfqw4QkW8uQ0K/9jXedUO5uEjvpvj4uyvhaJk+s+OoFsGzZ8F
         GtMtU+SHacqYpAdD/Mm/+KGOkhMINsxD4tuV1fcHzLGfoKMWkNrM6DScMV+QsAlbWrtO
         gZqvuQrVvhH6m3t+PJtyMLAjtOpQT64XttbC633N6pW7OwHzkG2fbImuAyJ0GhZojsTh
         zc25McEPmFDi5cn2qV4UCgXHXvuUIjK0yfXehpYyY8XJO7jev1nzQqCneWE4Hvsy5QHi
         23qQ==
X-Gm-Message-State: AOJu0YyQ7y/RTgxDzfw4RNJgdcb3rhi+5jrbECl0ZDZZDp7eIVsCkDEO
        cvz29z+inveWf35Sq084zTiVaQ==
X-Google-Smtp-Source: AGHT+IF9di7HXMGcz4wrofKDMcmvUiyBh0pXCdwNqtXi9q6sEWgaWOUBvf+9O6tKdebgvtPgvS3+NQ==
X-Received: by 2002:a05:6512:acb:b0:502:d743:9fc4 with SMTP id n11-20020a0565120acb00b00502d7439fc4mr14105432lfu.37.1696273185145;
        Mon, 02 Oct 2023 11:59:45 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b00502d7365e8fsm2443981lfc.137.2023.10.02.11.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 11:59:44 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        Stephan Gerhold <stephan@gerhold.net>
Subject: [PATCH v5 5/6] cpufreq: qcom-nvmem: provide separate configuration data for apq8064
Date:   Mon,  2 Oct 2023 21:59:39 +0300
Message-Id: <20231002185940.1271800-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
References: <20231002185940.1271800-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

APQ8064 can scale core voltage according to the frequency needs. Rather
than reusing the A/B format multiplexer, use a simple fuse parsing
function and configure required regulator.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 49 ++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index e5c17d9f5a24..e1cf677b0c6f 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_opp.h>
+#include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/smem.h>
 
@@ -39,6 +40,7 @@ struct qcom_cpufreq_match_data {
 			   char **pvs_name,
 			   struct qcom_cpufreq_drv *drv);
 	const char **genpd_names;
+	const char * const *regulator_names;
 };
 
 struct qcom_cpufreq_drv {
@@ -203,6 +205,34 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
 	return ret;
 }
 
+static int qcom_cpufreq_apq8064_name_version(struct device *cpu_dev,
+					     struct nvmem_cell *speedbin_nvmem,
+					     char **pvs_name,
+					     struct qcom_cpufreq_drv *drv)
+{
+	int speed = 0, pvs = 0;
+	u8 *speedbin;
+	size_t len;
+
+	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
+
+	if (len != 4)
+		return -EINVAL;
+
+	get_krait_bin_format_a(cpu_dev, &speed, &pvs, speedbin);
+
+	snprintf(*pvs_name, sizeof("speedXX-pvsXX"), "speed%d-pvs%d",
+		 speed, pvs);
+
+	drv->versions = (1 << speed);
+
+	kfree(speedbin);
+
+	return 0;
+}
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -217,6 +247,16 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
+static const char * apq8064_regulator_names[] = {
+	"vdd-core",
+	NULL
+};
+
+static const struct qcom_cpufreq_match_data match_data_apq8064 = {
+	.get_version = qcom_cpufreq_apq8064_name_version,
+	.regulator_names = apq8064_regulator_names,
+};
+
 static int qcom_cpufreq_probe(struct platform_device *pdev)
 {
 	struct qcom_cpufreq_drv *drv;
@@ -304,7 +344,12 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 			config.virt_devs = NULL;
 		}
 
-		if (config.supported_hw || config.genpd_names) {
+		if (drv->data->regulator_names)
+			config.regulator_names = drv->data->regulator_names;
+
+		if (config.supported_hw ||
+		    config.genpd_names ||
+		    config.regulator_names) {
 			drv->opp_tokens[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
 			if (drv->opp_tokens[cpu] < 0) {
 				ret = drv->opp_tokens[cpu];
@@ -361,7 +406,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
 	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
 	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
-	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
+	{ .compatible = "qcom,apq8064", .data = &match_data_apq8064 },
 	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
 	{ .compatible = "qcom,msm8960", .data = &match_data_krait },
 	{},
-- 
2.39.2

