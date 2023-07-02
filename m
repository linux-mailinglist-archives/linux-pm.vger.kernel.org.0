Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEAAF744EEA
	for <lists+linux-pm@lfdr.de>; Sun,  2 Jul 2023 19:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbjGBRnV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 2 Jul 2023 13:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjGBRm7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 2 Jul 2023 13:42:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172CAE48
        for <linux-pm@vger.kernel.org>; Sun,  2 Jul 2023 10:42:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b69f216c73so53860671fa.3
        for <linux-pm@vger.kernel.org>; Sun, 02 Jul 2023 10:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688319774; x=1690911774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCEB400wiwuGaLoRWnnc0v8VJxlf3ONSbs27qRslkuQ=;
        b=VMXdJ3XCCqVdWiUmDmm/ZInqLgVxODxy3YG3y9yJLZ3lxVD9UPJqF4pfKpsD1Aoa2W
         Y8eglB0mlheWm+Q1nEIeWZJEd+Qyzwql2HOk+yneKKcNxCJElg7FrXH2Ba+9tf7Uzhi6
         lBOMSycnWf7dj85l/f+HGeLh04RLosLBv3JqBwyv2AjpiGhwT/E+9p/uTBTjfIOxTtys
         lA6B5HmINstHGfbnID9TaSlAJTvQSMzBhH7qX/aBrmQuunHTIwNwiAcwd761s8c64Re9
         upT0ZS5xMPoNSLjs73l0aLNisIlExwyVtpbuwfZCc8ympg7A7NMsZgGxyEbHsuZtHLw+
         H5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688319774; x=1690911774;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YCEB400wiwuGaLoRWnnc0v8VJxlf3ONSbs27qRslkuQ=;
        b=KpRABD5oEAaMZk9AAkcYGohi2IcisOtkV1qXCz8qxN/q79GDWn2pWlR8KWx529qCyL
         Ks8LB588+/eRGtXZkzqGaHJdqFsbQoQFGOj4v5r4XyY0bM5MZukaSTQcE7zRVXYqdhwj
         n6qj+ESGqyvEb/+paYnaQaGHUHt659HK8cEDEJ8a2h7U8aeRVvXKqlD11aZk53nTWiuf
         TT4KSPikaRH11m8boQ1rr+ca4vMx73pj+G83kGMafBfRkc4dtBSXkUJXaEdnhRINHvsZ
         YMySdDSropn3+XvuUYRJTjpHHNkIny9g2fNLjyzt6Po0zze8g+NtsNI9cWa2I9mUhkF4
         sC8g==
X-Gm-Message-State: ABy/qLYPRbsLEePIakbXs9NErG9OE8WJ5sumnURLwpBuf8UidVKK2cfP
        +y7gGDo6gqJjbghI8nBy8WjmbQ==
X-Google-Smtp-Source: APBJJlGOcPoEisqVEp6N8ppKuuStsdLPtbMB5y5GtMuawUyUeEHsv0QjdKeUce2go4Xg0QcPmHzr2w==
X-Received: by 2002:a2e:800b:0:b0:2b4:7380:230 with SMTP id j11-20020a2e800b000000b002b473800230mr5268985ljg.13.1688319774323;
        Sun, 02 Jul 2023 10:42:54 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v23-20020a2e9917000000b002b6daa3fa2csm1372550lji.69.2023.07.02.10.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jul 2023 10:42:53 -0700 (PDT)
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
Subject: [PATCH v3 07/28] clk: qcom: krait-cc: rewrite driver to use clk_hw instead of clk
Date:   Sun,  2 Jul 2023 20:42:25 +0300
Message-Id: <20230702174246.121656-8-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
References: <20230702174246.121656-1-dmitry.baryshkov@linaro.org>
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

The krait-cc driver still uses struct clk internally. Rewrite it to
allocate and register struct clk_hw instead.

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/krait-cc.c | 141 ++++++++++++++++--------------------
 1 file changed, 63 insertions(+), 78 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 410ae8390f1c..a37abbd31f50 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -13,17 +13,9 @@
 #include <linux/clk-provider.h>
 #include <linux/slab.h>
 
-#include "clk-krait.h"
-
-enum {
-	cpu0_mux = 0,
-	cpu1_mux,
-	cpu2_mux,
-	cpu3_mux,
-	l2_mux,
+#include <dt-bindings/clock/qcom,krait-cc.h>
 
-	clks_max,
-};
+#include "clk-krait.h"
 
 static unsigned int sec_mux_map[] = {
 	2,
@@ -235,7 +227,7 @@ krait_add_pri_mux(struct device *dev, struct clk_hw *hfpll_div, struct clk_hw *s
 		.parent_data = p_data,
 		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_mux_clk_ops,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 	};
 	struct clk_hw *clk;
 	char *hfpll_name;
@@ -324,19 +316,6 @@ static struct clk_hw *krait_add_clks(struct device *dev, int id, bool unique_aux
 	return pri_mux;
 }
 
-static struct clk *krait_of_get(struct of_phandle_args *clkspec, void *data)
-{
-	unsigned int idx = clkspec->args[0];
-	struct clk **clks = data;
-
-	if (idx >= clks_max) {
-		pr_err("%s: invalid clock index %d\n", __func__, idx);
-		return ERR_PTR(-EINVAL);
-	}
-
-	return clks[idx] ? : ERR_PTR(-ENODEV);
-}
-
 static const struct of_device_id krait_cc_match_table[] = {
 	{ .compatible = "qcom,krait-cc-v1", (void *)1UL },
 	{ .compatible = "qcom,krait-cc-v2" },
@@ -344,60 +323,84 @@ static const struct of_device_id krait_cc_match_table[] = {
 };
 MODULE_DEVICE_TABLE(of, krait_cc_match_table);
 
+static int krait_clk_reinit(struct clk_hw *hw, int cpu)
+{
+	struct clk *clk;
+	unsigned long cur_rate, aux_rate;
+	char name[5]; /* CPUn */
+
+	if (cpu == -1)
+		strcpy(name, "L2");
+	else
+		snprintf(name, sizeof(name), "CPU%d", cpu);
+
+	clk = clk_hw_get_clk(hw, clk_hw_get_name(hw));
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	aux_rate = 384000000;
+
+	cur_rate = clk_get_rate(clk);
+	if (cur_rate < aux_rate) {
+		pr_info("%s @ Undefined rate %lu. Forcing new rate.\n",
+			name, cur_rate / 1000);
+		cur_rate = aux_rate;
+	}
+
+	clk_set_rate(clk, aux_rate);
+	clk_set_rate(clk, 2);
+	clk_set_rate(clk, cur_rate);
+	pr_info("%s @ %lu KHz\n", name, clk_get_rate(clk) / 1000);
+
+	clk_put(clk);
+
+	return 0;
+}
+
+/* Krait configurations have at most 4 CPUs and one L2 */
+#define KRAIT_NUM_CLOCKS 5
+
 static int krait_cc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
-	unsigned long cur_rate, aux_rate;
-	int cpu;
-	struct clk_hw *mux, *l2_pri_mux;
-	struct clk *clk, **clks;
+	int cpu, ret;
+	struct clk_hw *clk;
+	struct clk_hw_onecell_data *clks;
 
 	id = of_match_device(krait_cc_match_table, dev);
 	if (!id)
 		return -ENODEV;
 
 	/* Rate is 1 because 0 causes problems for __clk_mux_determine_rate */
-	clk = clk_register_fixed_rate(dev, "qsb", NULL, 0, 1);
+	clk = clk_hw_register_fixed_rate(dev, "qsb", NULL, 0, 1);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
 	if (!id->data) {
-		clk = clk_register_fixed_factor(dev, "acpu_aux",
-						"gpll0_vote", 0, 1, 2);
+		clk = clk_hw_register_fixed_factor(dev, "acpu_aux", "gpll0_vote", 0, 1, 2);
 		if (IS_ERR(clk))
 			return PTR_ERR(clk);
 	}
 
-	/* Krait configurations have at most 4 CPUs and one L2 */
-	clks = devm_kcalloc(dev, clks_max, sizeof(*clks), GFP_KERNEL);
+	clks = devm_kzalloc(dev, struct_size(clks, hws, KRAIT_NUM_CLOCKS), GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
 
+	clks->num = KRAIT_NUM_CLOCKS;
+	BUILD_BUG_ON(KRAIT_L2 >= KRAIT_NUM_CLOCKS);
+
 	for_each_possible_cpu(cpu) {
-		mux = krait_add_clks(dev, cpu, id->data);
-		if (IS_ERR(mux))
-			return PTR_ERR(mux);
-		clks[cpu] = mux->clk;
+		clk = krait_add_clks(dev, cpu, id->data);
+		if (IS_ERR(clk))
+			return PTR_ERR(clk);
+		clks->hws[cpu] = clk;
 	}
 
-	l2_pri_mux = krait_add_clks(dev, -1, id->data);
-	if (IS_ERR(l2_pri_mux))
-		return PTR_ERR(l2_pri_mux);
-	clks[l2_mux] = l2_pri_mux->clk;
-
-	/*
-	 * We don't want the CPU or L2 clocks to be turned off at late init
-	 * if CPUFREQ or HOTPLUG configs are disabled. So, bump up the
-	 * refcount of these clocks. Any cpufreq/hotplug manager can assume
-	 * that the clocks have already been prepared and enabled by the time
-	 * they take over.
-	 */
-	for_each_online_cpu(cpu) {
-		clk_prepare_enable(clks[l2_mux]);
-		WARN(clk_prepare_enable(clks[cpu]),
-		     "Unable to turn on CPU%d clock", cpu);
-	}
+	clk = krait_add_clks(dev, -1, id->data);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	clks->hws[KRAIT_L2] = clk;
 
 	/*
 	 * Force reinit of HFPLLs and muxes to overwrite any potential
@@ -410,31 +413,13 @@ static int krait_cc_probe(struct platform_device *pdev)
 	 * two different rates to force a HFPLL reinit under all
 	 * circumstances.
 	 */
-	cur_rate = clk_get_rate(clks[l2_mux]);
-	aux_rate = 384000000;
-	if (cur_rate < aux_rate) {
-		pr_info("L2 @ Undefined rate. Forcing new rate.\n");
-		cur_rate = aux_rate;
-	}
-	clk_set_rate(clks[l2_mux], aux_rate);
-	clk_set_rate(clks[l2_mux], 2);
-	clk_set_rate(clks[l2_mux], cur_rate);
-	pr_info("L2 @ %lu KHz\n", clk_get_rate(clks[l2_mux]) / 1000);
-	for_each_possible_cpu(cpu) {
-		clk = clks[cpu];
-		cur_rate = clk_get_rate(clk);
-		if (cur_rate < aux_rate) {
-			pr_info("CPU%d @ Undefined rate. Forcing new rate.\n", cpu);
-			cur_rate = aux_rate;
-		}
+	krait_clk_reinit(clks->hws[KRAIT_L2], -1);
+	for_each_possible_cpu(cpu)
+		krait_clk_reinit(clks->hws[cpu], cpu);
 
-		clk_set_rate(clk, aux_rate);
-		clk_set_rate(clk, 2);
-		clk_set_rate(clk, cur_rate);
-		pr_info("CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
-	}
-
-	of_clk_add_provider(dev->of_node, krait_of_get, clks);
+	ret = devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clks);
+	if (ret)
+		return ret;
 
 	return 0;
 }
-- 
2.39.2

