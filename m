Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9CC73D3E2
	for <lists+linux-pm@lfdr.de>; Sun, 25 Jun 2023 22:26:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjFYU0J (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Jun 2023 16:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjFYU0E (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Jun 2023 16:26:04 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FABE64
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:02 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fa08687246so1287895e87.1
        for <linux-pm@vger.kernel.org>; Sun, 25 Jun 2023 13:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687724760; x=1690316760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jaBkKadUWtDPt8dHILR5FATfH/ynS29hE6HSGf3w28=;
        b=III+FM6TGR05oyymoH1LKGFmfljglFSvDwH+Y2ibmh1pMegZumIsAay0iIym03uxPF
         vCHbT1y7/FgQfnN2HErxAflP21OJuS7ZTq0n2n0j+hu5nSDCiisYwXW2av9J1c1WWw8x
         7q1XXUTkKcYqbgWKH+v1WEDwIRVs2KqFN8SkLzPTafBaphuVUBzNLsRrGE17BBJD87E6
         iUO5u/Len+aiMP+TiFjkMU3c6AdnSC5QYKu/59mf/9mkuqv9uR5MioWPrD9YUkQ0FD+z
         er/bUArXoU+zpplZLLOO58E29lOVXfzCEtK0N0IAT3jE25q3wUEtqTBxS0Y070wVRoIa
         EKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687724760; x=1690316760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jaBkKadUWtDPt8dHILR5FATfH/ynS29hE6HSGf3w28=;
        b=Bd+IEudWrqB05qj95uXdqXo7IyFZ5K6Raa5JkV0U7UqzBz+NZ9mhiBLrALi27CqWUz
         zUnRGprgrn0CVQJ5SRPmrP/+vXoXzgWm8dAdQlvfkCAAZXcrVv6UbQcEGSM6AODCfKpI
         +tP5eFDVYPW6CLblsDW3gGo7BwlYaDQ2sg7vQ0+54cXrZR59vkeM5qHo3otUGGy+F+jI
         sj2+hCJ4sy18tnLm4iQtyDQdIG+3aue3Vk8QQzWrvtcTa6RCYLnuHky3gEoPI0fQclH4
         Fjtz0hwx1rHI1t7CIUKz+wHXHE/wpeCcUJvi+GCO9g5WiiVKtHB1RvWNkZ1hj7Iw2KuQ
         1EqQ==
X-Gm-Message-State: AC+VfDzgMrCurPV6pcS9tGd/qjk27UFCSvARAf+iWnMof39WEfU4kZKb
        Lc/RR0/z4pQ/rDyPEODLEige6A==
X-Google-Smtp-Source: ACHHUZ5+tEEkhinGLyR8nEY1Y99x7FKrJLFxvUHnVTekjen88gHvbXLirp5ZmcmInitLAlctgSsf7w==
X-Received: by 2002:a05:6512:2314:b0:4fa:21d4:b3ca with SMTP id o20-20020a056512231400b004fa21d4b3camr1465859lfu.2.1687724760466;
        Sun, 25 Jun 2023 13:26:00 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id m21-20020a195215000000b004f8427f8716sm787537lfb.262.2023.06.25.13.25.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 13:25:59 -0700 (PDT)
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
Subject: [PATCH v2 12/26] cpufreq: qcom-nvmem: provide separate configuration data for apq8064
Date:   Sun, 25 Jun 2023 23:25:33 +0300
Message-Id: <20230625202547.174647-13-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
References: <20230625202547.174647-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 2a591fafc090..9cbc37ce91a8 100644
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
@@ -204,6 +206,34 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
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
+	int ret = 0;
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
+	return ret;
+}
+
 static const struct qcom_cpufreq_match_data match_data_kryo = {
 	.get_version = qcom_cpufreq_kryo_name_version,
 };
@@ -218,6 +248,16 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
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
@@ -305,7 +345,12 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
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
@@ -364,7 +409,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
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

