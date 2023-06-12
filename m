Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744AE72B77E
	for <lists+linux-pm@lfdr.de>; Mon, 12 Jun 2023 07:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235767AbjFLFjh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Jun 2023 01:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235296AbjFLFjd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Jun 2023 01:39:33 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEDDFE6E
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:30 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f61735676fso4547835e87.2
        for <linux-pm@vger.kernel.org>; Sun, 11 Jun 2023 22:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686548369; x=1689140369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cDdlePg3Sn8YINuebkJx+v93mjzRedks9PRDH1dCPko=;
        b=xYZDDPVkv6AH2Kkb9tFrtWvXPv2XnOSe/zGZNtQbzci50/kQmHF4Jh9lA/Dq3+sPSI
         RWoMPo+BLYzB5S6+vA4WUU6rlxYX5ZPnrKqDzfAvgD6W8VC+YbIfi2I/kvkvdxrL7MQO
         jsXsocxwY1ljG3OjSwjUNDeeGRenGD1XZL+QYxn+VRj4SsZM0e67hsYo6VUUXZ/y9sgB
         gm7deEG+xfzLjpEEbM04hrFX0oECN6bL4mgIFfHzvFpoNjegeTshnQJRILcfLs7tsrSh
         l9e0gOFW1zFZO2bu6s/koHGpi65MtEIHjqiM4M2yUUZSqi/KrcWTvTZUDuEpHNjZQAJf
         jaPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686548369; x=1689140369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cDdlePg3Sn8YINuebkJx+v93mjzRedks9PRDH1dCPko=;
        b=l7CooHe5eMqTCiUqRZvseOTR1cuVioZaqjNh7UVXzcokJq4XGzh8FGWckeeWRgg8xr
         G20RYHmYo/FQMslUMgTBRO3X3yHJm4owpOYI4oZg7a7ry0ZzdDie7TWMYMH55+TFl/g0
         VHc8mFH73QaPJLhMXiTTuivKWSCK9bjRiz5yifR1dp1xxILTOYEKIu1inpbEb7H1gGQw
         e5KThUnFGY7uofhShxZOWlt5WEfW22/ElJX0gNX9d0bHRTgxkC11TpPneTcS8FdTh9zU
         SMYjP6bQ3o0TEUZXTFjumO+bLzyh1CCnZjyB/5TsUxk6I9Udk3JTINebaBEiV9d0q3rf
         +4Dg==
X-Gm-Message-State: AC+VfDz2j9ELW9CvJGzaH0IDS60inE4davmkk4Z/YkuQmg9ibQ5gjII/
        /iVoz1AbgAgT1g3FXPmDNxlhTg==
X-Google-Smtp-Source: ACHHUZ4LTOFfPGev5zoHP7rx1ABSRmDImHgAbMSrsCCO1UezjhfBEJg7oiacR5PNSzrSktuIUtrmIg==
X-Received: by 2002:a19:5f0e:0:b0:4dd:9f86:859d with SMTP id t14-20020a195f0e000000b004dd9f86859dmr3314338lfb.13.1686548369065;
        Sun, 11 Jun 2023 22:39:29 -0700 (PDT)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id n6-20020a195506000000b004f38260f196sm1324125lfe.218.2023.06.11.22.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 22:39:28 -0700 (PDT)
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
Subject: [PATCH 05/18] clk: qcom: krait-cc: rewrite driver to use clk_hw instead of clk
Date:   Mon, 12 Jun 2023 08:39:09 +0300
Message-Id: <20230612053922.3284394-6-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
References: <20230612053922.3284394-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The krait-cc driver still uses struct clk internally. Rewrite it to
allocate and register struct clk_hw instead.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/clk/qcom/krait-cc.c | 122 ++++++++++++++++--------------------
 1 file changed, 54 insertions(+), 68 deletions(-)

diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
index 410ae8390f1c..2ce38024dc0d 100644
--- a/drivers/clk/qcom/krait-cc.c
+++ b/drivers/clk/qcom/krait-cc.c
@@ -235,7 +235,7 @@ krait_add_pri_mux(struct device *dev, struct clk_hw *hfpll_div, struct clk_hw *s
 		.parent_data = p_data,
 		.num_parents = ARRAY_SIZE(p_data),
 		.ops = &krait_mux_clk_ops,
-		.flags = CLK_SET_RATE_PARENT,
+		.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 	};
 	struct clk_hw *clk;
 	char *hfpll_name;
@@ -324,19 +324,6 @@ static struct clk_hw *krait_add_clks(struct device *dev, int id, bool unique_aux
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
@@ -344,60 +331,81 @@ static const struct of_device_id krait_cc_match_table[] = {
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
 static int krait_cc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	const struct of_device_id *id;
-	unsigned long cur_rate, aux_rate;
 	int cpu;
-	struct clk_hw *mux, *l2_pri_mux;
-	struct clk *clk, **clks;
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
 
 	/* Krait configurations have at most 4 CPUs and one L2 */
-	clks = devm_kcalloc(dev, clks_max, sizeof(*clks), GFP_KERNEL);
+	clks = devm_kzalloc(dev, struct_size(clks, hws, clks_max), GFP_KERNEL);
 	if (!clks)
 		return -ENOMEM;
 
+	clks->num = clks_max;
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
+	clks->hws[l2_mux] = clk;
 
 	/*
 	 * Force reinit of HFPLLs and muxes to overwrite any potential
@@ -410,33 +418,11 @@ static int krait_cc_probe(struct platform_device *pdev)
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
-
-		clk_set_rate(clk, aux_rate);
-		clk_set_rate(clk, 2);
-		clk_set_rate(clk, cur_rate);
-		pr_info("CPU%d @ %lu KHz\n", cpu, clk_get_rate(clk) / 1000);
-	}
+	krait_clk_reinit(clks->hws[l2_mux], -1);
+	for_each_possible_cpu(cpu)
+		krait_clk_reinit(clks->hws[cpu], cpu);
 
-	of_clk_add_provider(dev->of_node, krait_of_get, clks);
-
-	return 0;
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clks);
 }
 
 static struct platform_driver krait_cc_driver = {
-- 
2.39.2

