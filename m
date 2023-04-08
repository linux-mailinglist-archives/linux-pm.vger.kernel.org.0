Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461656DBE0B
	for <lists+linux-pm@lfdr.de>; Sun,  9 Apr 2023 01:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDHXtk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 8 Apr 2023 19:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDHXtj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 8 Apr 2023 19:49:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4AD7DA9
        for <linux-pm@vger.kernel.org>; Sat,  8 Apr 2023 16:49:37 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id o1so2484075lfc.2
        for <linux-pm@vger.kernel.org>; Sat, 08 Apr 2023 16:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680997775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=puEneLbVlFI8EiTNpeTpU1hGbRj/YDRKi9IRDYTjr5U=;
        b=v0541xFXCBu+DjvKTU3GxezAk5+jSjSmBMc6UFRfUjq4ypsjzBSNu597dNqVgCYFL5
         JJCHJBgH+vPs4xhLmNUdLjJ0VWlIeU7u4WYkbbG9K6M9qwn3BB/w9O9LiX3UQpIy0uAe
         PXBhFZzqD/dbV8a7M0z6OoU/SCDsk5L/HQsbA99OOZNy5bvlNqdjHTSLjyAJzbLvwgXy
         FobL4aNNqLwDT9ulb1zIKhEYNVOsntTp6O6bGm/FsmIPz6x8LxP32EBGHfRMPEPSout2
         WDGiWDTnnAkIgsIPG85HnrU3jU1mhKWxx7LlWpGM+BQFmKK0oFRW2ToQZ7dTEdjFJ3KN
         a+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680997775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=puEneLbVlFI8EiTNpeTpU1hGbRj/YDRKi9IRDYTjr5U=;
        b=iGaOsVL4QcRZx+1biZ/A23Z7z7iH4ci5g2Rx5AaxT58PooHS1kM9bVDrcerAoxbEf2
         VDJ70BsRsIIYul+zAnGW8qvQS57jxGJcRGcgEW+SNq4n5khNQDZP+Zf6vikesuahlqk8
         0Jo/JtIzgybOix5L6eo5RtTZYudBpoNAGUH/7u58yNA9j0o3BqhzBq0CVN1pTJ9m4f4k
         W3x50CPo1EdCCNznpyN5eOfQUPKDk1qCIktg4eRyYljrZLvlq0FOqfqIydBD9DTxoXkQ
         Fnt955at4yRZZAG9yTtO348M+/9ZW4t5Gpk+4Wdw7ZGpLJHdYqwcJ1Pbr+3x8UE6dKHa
         1+ew==
X-Gm-Message-State: AAQBX9dXBjuEQ47yH9/S+7EVWdLp+89QOGF423pyt93shYAHpn7L4NWX
        Hqd6qKOOEjZnjylljT3R2UhOTv8K7OkT61+KWGc=
X-Google-Smtp-Source: AKy350a8qLwhbttJq4i1XhBLzPtLviUknACnkI22pT1PajL5RlAXVEPdtYSceMbH60C15NUnxymkYg==
X-Received: by 2002:a19:7410:0:b0:4d8:57dc:fcdd with SMTP id v16-20020a197410000000b004d857dcfcddmr878760lfe.56.1680997775576;
        Sat, 08 Apr 2023 16:49:35 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id q26-20020ac2529a000000b004e7fa99f3f4sm1353008lfm.265.2023.04.08.16.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Apr 2023 16:49:35 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v4 3/4] clk: qcom: cbf-msm8996: scale CBF clock according to the CPUfreq
Date:   Sun,  9 Apr 2023 02:49:31 +0300
Message-Id: <20230408234932.2363302-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
References: <20230408234932.2363302-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Turn CBF into the interconnect provider. Scale CBF frequency (bandwidth)
according to CPU frequencies.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/Kconfig        |  1 +
 drivers/clk/qcom/clk-cbf-8996.c | 59 ++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 449bc8314d21..475f4997d79f 100644
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
index cfd567636f4e..1bb2cd956d68 100644
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
 
@@ -223,6 +227,48 @@ static const struct regmap_config cbf_msm8996_regmap_config = {
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
+#else
+static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev,  struct clk_hw *cbf_hw)
+{
+	dev_warn(&pdev->dev, "interconnects support is disabled, CBF clock is fixed\n");
+
+	return 0;
+}
+#define qcom_msm8996_cbf_icc_remove(pdev) (0)
+#define qcom_msm8996_cbf_icc_sync_state(dev) (0)
+#endif
+
 static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
 {
 	void __iomem *base;
@@ -281,7 +327,16 @@ static int qcom_msm8996_cbf_probe(struct platform_device *pdev)
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
@@ -292,9 +347,11 @@ MODULE_DEVICE_TABLE(of, qcom_msm8996_cbf_match_table);
 
 static struct platform_driver qcom_msm8996_cbf_driver = {
 	.probe = qcom_msm8996_cbf_probe,
+	.remove = qcom_msm8996_cbf_remove,
 	.driver = {
 		.name = "qcom-msm8996-cbf",
 		.of_match_table = qcom_msm8996_cbf_match_table,
+		.sync_state = icc_sync_state,
 	},
 };
 
-- 
2.30.2

