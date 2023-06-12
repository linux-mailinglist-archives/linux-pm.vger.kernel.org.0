Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6F472CDF7
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 20:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbjFLSZe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237828AbjFLSY5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 14:24:57 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EECEC
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:24:54 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f611ac39c5so5745241e87.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Jun 2023 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686594293; x=1689186293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+fKLnlHalDuAg33z9Jtbv/mJQQ+EEa4+LdoMppCsko=;
        b=La2OgBxvBFrtW4m4CplAemsIBFvAxmMnIWokZAFiAB+Q697qjtl40sY1Io0vhc5RgD
         GYMlYKRYh7RIGaVZGmmEbKspnsSxR8R0QoXUlcBvJoAikFOrRij+4ELJAjG/1KKwFjwx
         LgGFvEoeiTZh/NMFhZOJYeJ4OZNk5dEjCcD+e3o42mxNRiVzWT9D+Pw0NHfnSQT7/dWF
         4nhtr6l5omaRV+a8ZI9kmvi3kLzksYMG2AViYtKq9MPDXsTXMGM9J9jR5gil20HRW+qy
         bi75dm1OCv4vLeFcGfPe+nQGrQju6UZMTZVIDHliFZMfqrxDbNXw+JzPpJj3VVi7yefQ
         Tkwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686594293; x=1689186293;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+fKLnlHalDuAg33z9Jtbv/mJQQ+EEa4+LdoMppCsko=;
        b=b7+J9ikiKZ7YNJWS+RHgPQMeP1wI87PtUm8BXPc0v7ojTtb6BRKBkTIBFDlU5Opnzx
         MRvUjuvA0jiIifYiLyzY9j7W08j5/v08XvyQDkOddK8lNsv9N4ghFgvLZWoUx5cset8p
         picR1juz1N9FM4ArIu7THraxGd41uZVkUeA12UjnNqwsGXF6S/kfgJfTt4NOguaR2NoX
         TUEIQ3HD8XQkB3XfdAyEZgJFWNaVnUL/ooy0tQABtlkP0YxZq/cLaxtbT/d9vN/hAIN0
         QEBd/fZZROWcUdFOVcGCuCAv9whnW7cLGfWpxVfORvelSlMPXoKzXkusxqB8nNEtgSBj
         OuSw==
X-Gm-Message-State: AC+VfDyubJwTD0W26nGCyzFQbaM9Udj8fg/EHWPlL0xA6+ezbws/eYc6
        lftLFDkAvJWW/+nAvFjkwgVrSQ==
X-Google-Smtp-Source: ACHHUZ59/tTDCgH0r44I8FLs/uvRB3MugLqwk6TzkTwglm+qmJ+bKV+h+7DVF3e6WWdVp5J+ut7sVQ==
X-Received: by 2002:a19:5f16:0:b0:4f6:25a3:95ab with SMTP id t22-20020a195f16000000b004f625a395abmr4056807lfb.25.1686594293179;
        Mon, 12 Jun 2023 11:24:53 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id v24-20020ac25938000000b004f64073a252sm1502035lfi.96.2023.06.12.11.24.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 11:24:52 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 12 Jun 2023 20:24:28 +0200
Subject: [PATCH v3 11/23] interconnect: qcom: Define RPM bus clocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230526-topic-smd_icc-v3-11-5fb7d39b874f@linaro.org>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686594276; l=3759;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=x0HK0TeLMEP7kpXmLD7jervQe77EX+FiCHoc2go6cXk=;
 b=RPPe1rZlc5NDivCFl9EM8aDcII2KaEHhRxDvpA2ebjzmGlNHBMAS8MvdmxDBbf7KBp+W7FBR/
 jwBVMenGv12Cb72fuyw7x2aoLv1z5QfRLp3nTNsoib2yRCsIDNh5v8b
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the definitions for RPM bus clocks that will be used by many
different platforms.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/Makefile         |  2 +-
 drivers/interconnect/qcom/icc-rpm-clocks.c | 66 ++++++++++++++++++++++++++++++
 drivers/interconnect/qcom/icc-rpm.h        | 13 ++++++
 3 files changed, 80 insertions(+), 1 deletion(-)

diff --git a/drivers/interconnect/qcom/Makefile b/drivers/interconnect/qcom/Makefile
index ab988926433c..80d9d2da95d1 100644
--- a/drivers/interconnect/qcom/Makefile
+++ b/drivers/interconnect/qcom/Makefile
@@ -29,7 +29,7 @@ qnoc-sm8250-objs			:= sm8250.o
 qnoc-sm8350-objs			:= sm8350.o
 qnoc-sm8450-objs			:= sm8450.o
 qnoc-sm8550-objs			:= sm8550.o
-icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o
+icc-smd-rpm-objs			:= smd-rpm.o icc-rpm.o icc-rpm-clocks.o
 
 obj-$(CONFIG_INTERCONNECT_QCOM_BCM_VOTER) += icc-bcm-voter.o
 obj-$(CONFIG_INTERCONNECT_QCOM_MSM8916) += qnoc-msm8916.o
diff --git a/drivers/interconnect/qcom/icc-rpm-clocks.c b/drivers/interconnect/qcom/icc-rpm-clocks.c
new file mode 100644
index 000000000000..a195bf32aff4
--- /dev/null
+++ b/drivers/interconnect/qcom/icc-rpm-clocks.c
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Linaro Ltd
+ */
+
+#include <linux/soc/qcom/smd-rpm.h>
+
+#include "icc-rpm.h"
+
+const struct rpm_clk_resource aggre1_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 1,
+};
+
+const struct rpm_clk_resource aggre2_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 2,
+};
+
+const struct rpm_clk_resource bimc_clk = {
+	.resource_type = QCOM_SMD_RPM_MEM_CLK,
+	.clock_id = 0,
+};
+
+const struct rpm_clk_resource bus_0_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 0,
+};
+
+const struct rpm_clk_resource bus_1_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 1,
+};
+
+const struct rpm_clk_resource bus_2_clk = {
+	.resource_type = QCOM_SMD_RPM_BUS_CLK,
+	.clock_id = 2,
+};
+
+const struct rpm_clk_resource mmaxi_0_clk = {
+	.resource_type = QCOM_SMD_RPM_MMAXI_CLK,
+	.clock_id = 0,
+};
+
+const struct rpm_clk_resource mmaxi_1_clk = {
+	.resource_type = QCOM_SMD_RPM_MMAXI_CLK,
+	.clock_id = 1,
+};
+
+const struct rpm_clk_resource qup_clk = {
+	.resource_type = QCOM_SMD_RPM_QUP_CLK,
+	.clock_id = 0,
+};
+
+/* Branch clocks */
+const struct rpm_clk_resource aggre1_branch_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 1,
+	.branch = true,
+};
+
+const struct rpm_clk_resource aggre2_branch_clk = {
+	.resource_type = QCOM_SMD_RPM_AGGR_CLK,
+	.clock_id = 2,
+	.branch = true,
+};
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 057a1a8b3cb9..99e34f684c85 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -136,6 +136,19 @@ enum qos_mode {
 	NOC_QOS_MODE_BYPASS,
 };
 
+extern const struct rpm_clk_resource aggre1_clk;
+extern const struct rpm_clk_resource aggre2_clk;
+extern const struct rpm_clk_resource bimc_clk;
+extern const struct rpm_clk_resource bus_0_clk;
+extern const struct rpm_clk_resource bus_1_clk;
+extern const struct rpm_clk_resource bus_2_clk;
+extern const struct rpm_clk_resource mmaxi_0_clk;
+extern const struct rpm_clk_resource mmaxi_1_clk;
+extern const struct rpm_clk_resource qup_clk;
+
+extern const struct rpm_clk_resource aggre1_branch_clk;
+extern const struct rpm_clk_resource aggre2_branch_clk;
+
 int qnoc_probe(struct platform_device *pdev);
 int qnoc_remove(struct platform_device *pdev);
 

-- 
2.41.0

