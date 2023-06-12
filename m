Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71EF72B792
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjFLFkD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235781AbjFLFjq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:46 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8849310E0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f649db9b25so4445474e87.0
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548374; x=1689140374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I6BmIz26haO/gRx19tTS+BciZJfoAnK1MSrY6sI/V8k=;
        b=QFY8ZBjlIVAsQYNCRm8MpmPXZt8qZvcVP/Xp6qxReozaztaxZg7fJnMQn+sWoPexl9
         lVyLgMPyldymmgl5IlxcX5fEHMqF8xfjpOspd3OxolLhopC4daJ8H4miHbq+JmYAgy26
         Ft8WoX1Bu4u9ifYn76NX0k1cgmaYLdytTikYLnGQPtWjDAxj33uhwM/J2C45qIKOE1P5
         wVS11E+YUo0ON7OFTblPyQtBmdt5+QnrSvFe3BvbuqL/cw5ihzpSh+sLeV5p/M7Ibbul
         1LWl9pUdciY1p2jRT9xsYdagj9EaWBFFCKh4fnwKXB+1sjS4a4Yf34JcK5KTHJ+eSJMX
         0IkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548374; x=1689140374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I6BmIz26haO/gRx19tTS+BciZJfoAnK1MSrY6sI/V8k=;
        b=I//mybW4AEpK5vhd+YLURTM037xlM5YfJD3IoBtxeU3cL/9peNCy8gKsEhbnwXSmO8
         aTVaMgtqjQEjgZKOXE54pOe/rtoYjvZMk3m5VkQstufSQUvbDLVmO2qnWIT2NBz/L/oM
         VgSESFLZwLb8aFkPAoRhGVPnohpkha8ZtTpz3jlLK2gS24scgkp5JNM9Xk2UUWQpP8Fh
         setLrm0QULqf8sNR3aZ4Q50oZohbv4Eus7lZbWJNBCGSr1JmTp4KSmSp6AyM2EcZVv20
         zvoBQDwIVlqj3YJbf5hCMxgfBwTkVzmh0Dc0ncGOwTKPc+RBL8bfONCJ281Ubxhw7oS8
         PYOA==
X-Gm-Message-State: AC+VfDw+DpF60sUpbHjWNR6z+hsysD1bndeykJ00ZZ6xWjrJtdnN77/C
        qtjWbcH8ouPp6jRl4m8tyoOAIQ==
X-Google-Smtp-Source: ACHHUZ7+Jem4hQArYg/4ZZ2o2xuhyXDoB47oVaMbUTualpRO95YO9Rlm7N0YUi+NM71qo45fUj/ibQ==
X-Received: by 2002:a19:7101:0:b0:4f3:b61a:a94b with SMTP id m1-20020a197101000000b004f3b61aa94bmr3213076lfc.53.1686548374716;
        Sun, 11 Jun 2023 22:39:34 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:34 -0700 (PDT)
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
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: [PATCH 11/18] cpufreq: qcom-nvmem: provide separate configuration data for apq8064
Date:   Mon, 12 Jun 2023 08:39:15 +0300
Message-Id: <20230612053922.3284394-12-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
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

APQ8064 can scale core and memory voltages according to the frequency
needs. Rather than reusing the A/B format multiplexer, use a simple fuse
parsing function and configure required regulators.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index fc446acfda22..e5fede594399 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -206,6 +206,34 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
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
@@ -220,7 +248,19 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
 	.genpd_names = qcs404_genpd_names,
 };
 
-#define NUM_SUPPLIES 2
+static const char * apq8064_regulator_names[] = {
+	"vdd-mem",
+	"vdd-dig",
+	"vdd-core",
+	NULL
+};
+
+static const struct qcom_cpufreq_match_data match_data_apq8064 = {
+	.get_version = qcom_cpufreq_apq8064_name_version,
+	.regulator_names = apq8064_regulator_names,
+};
+
+#define NUM_SUPPLIES 3
 static int qcom_cpufreq_config_regulators(struct device *dev,
 					  struct dev_pm_opp *old_opp,
 					  struct dev_pm_opp *new_opp,
@@ -477,7 +517,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
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

