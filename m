Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CDA6FFDBF
	for <lists+linux-pm@lfdr.de>; Fri, 12 May 2023 02:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239587AbjELANn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 May 2023 20:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjELANl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 May 2023 20:13:41 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D99199
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 17:13:39 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f11d267d8bso10410438e87.2
        for <linux-pm@vger.kernel.org>; Thu, 11 May 2023 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683850417; x=1686442417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DDFBAKB/evD9PBK1U977U6D8erFxoAqHqqBb4Z3t/mI=;
        b=Fgrnk844jMS8qS2M69hjtfRz2ZbfT0YdvO0lZNukSQaD/N0n8CdeVLSMJGpVewId/F
         qeqAWM5tTJ3RMOA2L/3zysy2PJ5yDTzgvGq4s/b/JvBmJL/lVsFW6bkXEW2/aTJR+gkP
         d/S+GJ8RYijSgEVvg0IKUJmMv0me+ZUrIjEWJd8R8AoAssVOpa6iqEqBtUakQeMaMH5j
         9H6WDKXKWfgWMwpGF+0jidXbLrBgH4Ylz8k3Q0+W4NYUQhGam9B/66r/jUq/LE05ntsG
         4d2qUtLlNffJ+9nIjHEqidPZi0SaQzthvCFKu/+m1kS1/u63rKDYmITKI7zH/wtFo+Xf
         NA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683850417; x=1686442417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DDFBAKB/evD9PBK1U977U6D8erFxoAqHqqBb4Z3t/mI=;
        b=ECWcJZl3Chcr8DBq0aEVwVX8LlnzWMqyzxM2kajHKHjw4bLUvprmNh5a565vwSrWux
         w8GOEIynMGjWnI361IYRGJasoPrVyxl7nbTxvZmpNVZ/iCAWC7Upo1n//CJLvODQGGIh
         KXWIEVNYMILKdvy68/kfiENyCS16/zDVmTh/AbIn63biGuvjaoQfCc4Nak53HJj0feC6
         L4GYMsIcApfFHsd6ckCEsi7zSzSEafvhC1MvSP8TJaq1hOxaat7vorI90rTI+Glpe6Mt
         Ah5UYJ2dE5gf4pFda+O1hUFUURu+wWMOYOeKMgHcVjZk+t0J7Gs4OjBR3BKGdDG6g5ce
         lWIA==
X-Gm-Message-State: AC+VfDxQZQyhed2AM6EthuIJZJ0+YduA+6cdJSRqvsFOhMy43k/+2++U
        zEjJvSd8VYApzn9Nfkp8S19S1IsuYgPSF5sQDyc=
X-Google-Smtp-Source: ACHHUZ4SH8TQRT5yVHtUOES61yLRovFpVCezhjnzQ9h1twI2w4LvKzLz4FPCXf3xlQrMXpqWuPgatg==
X-Received: by 2002:ac2:5a4d:0:b0:4ee:e10f:8e5f with SMTP id r13-20020ac25a4d000000b004eee10f8e5fmr3238297lfn.4.1683850417274;
        Thu, 11 May 2023 17:13:37 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id p15-20020ac246cf000000b004f13c3cb9ffsm1258109lfo.200.2023.05.11.17.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 17:13:36 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <quic_tdas@quicinc.com>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 3/4] clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
Date:   Fri, 12 May 2023 03:13:33 +0300
Message-Id: <20230512001334.2983048-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
References: <20230512001334.2983048-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
according to CPU frequencies.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Tested-by: Yassine Oudjana <y.oudjana@protonmail.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Kconfig        |  1 +
 drivers/clk/qcom/clk-cbf-8996.c | 60 ++++++++++++++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 12be3e2371b3..85869e7a9f16 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -48,6 +48,7 @@ config QCOM_CLK_APCS_MSM8916
 config QCOM_CLK_APCC_MSM8996
 	tristate "MSM8996 CPU Clock Controller"
 	select QCOM_KRYO_L2_ACCESSORS
+	select INTERCONNECT_CLK if INTERCONNECT
 	depends on ARM64
 	help
 	  Support for the CPU clock controller on msm8996 devices.
diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
index cfd567636f4e..1e23b734abb3 100644
--- a/drivers/clk/qcom/clk-cbf-8996.c
+++ b/drivers/clk/qcom/clk-cbf-8996.c
@@ -5,11 +5,15 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/interconnect-clk.h>
+#include <linux/interconnect-provider.h>
 #include <linux/of.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
 
+#include <dt-bindings/interconnect/qcom,msm8996-cbf.h>
+
 #include "clk-alpha-pll.h"
 #include "clk-regmap.h"
 
@@ -223,6 +227,49 @@ static const struct regmap_config cbf_msm8996_regmap_config = {
 	.val_format_endian	= REGMAP_ENDIAN_LITTLE,
 };
 
+#ifdef CONFIG_INTERCONNECT
+
+/* Random ID that doesn't clash with main qnoc and OSM */
+#define CBF_MASTER_NODE 2000
+
+static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct clk_hw *cbf_hw)
+{
+	struct device *dev = &pdev->dev;
+	struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
+	const struct icc_clk_data data[] = {
+		{ .clk = clk, .name = "cbf", },
+	};
+	struct icc_provider *provider;
+
+	provider = icc_clk_register(dev, CBF_MASTER_NODE, ARRAY_SIZE(data), data);
+	if (IS_ERR(provider))
+		return PTR_ERR(provider);
+
+	platform_set_drvdata(pdev, provider);
+
+	return 0;
+}
+
+static int qcom_msm8996_cbf_icc_remove(struct platform_device *pdev)
+{
+	struct icc_provider *provider = platform_get_drvdata(pdev);
+
+	icc_clk_unregister(provider);
+
+	return 0;
+}
+#define qcom_msm8996_cbf_icc_sync_state icc_sync_state
+#else
+static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev,  struct clk_hw *cbf_hw)
+{
+	dev_warn(&pdev->dev, "CONFIG_INTERCONNECT is disabled, CBF clock is fixed\n");
+
+	return 0;
+}
+#define qcom_msm8996_cbf_icc_remove(pdev) (0)
+#define qcom_msm8996_cbf_icc_sync_state NULL
+#endif
+
 static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -281,7 +328,16 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	return devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &cbf_mux.clkr.hw);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, &cbf_mux.clkr.hw);
+	if (ret)
+		return ret;
+
+	return qcom_msm8996_cbf_icc_register(pdev, &cbf_mux.clkr.hw);
+}
+
+static int qcom_msm8996_cbf_remove(struct platform_device *pdev)
+{
+	return qcom_msm8996_cbf_icc_remove(pdev);
 }
 
 static const struct of_device_id qcom_msm8996_cbf_match_table[] = {
@@ -292,9 +348,11 @@ MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
 
 static struct platform_driver qcom_msm8996_cbf_driver = {
 	.probe = qcom_msm8996_cbf_probe,
+	.remove = qcom_msm8996_cbf_remove,
 	.driver = {
 		.name = "qcom-msm8996-cbf",
 		.of_match_table = qcom_msm8996_cbf_match_table,
+		.sync_state = qcom_msm8996_cbf_icc_sync_state,
 	},
 };
 
-- 
2.39.2

