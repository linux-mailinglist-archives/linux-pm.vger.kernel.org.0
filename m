Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0791562DBF
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234281AbiGAIVF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:21:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236182AbiGAIVB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:21:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A2170E59
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:20:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id v126so1741487pgv.11
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xl1HN34mhSotDnvkt8tXbixjNJQAdLGe7tUjPgb4h/M=;
        b=i7M5+MWQM/Wqyk1fA5iuLZE9bqsbrbc3WDWPOdi3fxmV/AJTwIEE7Si1xPTx5n2Xhn
         LOSApbAqXS878yYMItr7z4UBSPclNrnv36g5iFVV6jM84cVz4aZ1MCOHvI4E9Lw5JF2u
         u6SeJygVMbhOGlHlVjNyuv/RcUvYRGwMFWpcpNQJVYbNsAPnd79yR7+c9NJ8IMookw+U
         MkTEgtPVhXcuZ7cijPlnKYk0euz/zP2qHiPxelFniNIa1bjPNnBOqMx6nTor+cFORIbK
         HEQ2dTbvlms6brsUkKvwNKNz+C+cX7Ful6WWCTold3g5lPNYADIzEr2fTSm+w6C5shAJ
         Wrbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xl1HN34mhSotDnvkt8tXbixjNJQAdLGe7tUjPgb4h/M=;
        b=AH7MlLfATncfcgPqT2e7ZMLbZWMw4Nx4FKPr6NCMOdCar0KoLolXL8VbDZQ+74A02y
         726PSw9AuQjfslDA1tYmNrrBa7USfYxartlg5AGNaV6i3ZjxMw8SW19Wek7EsxBi4LdO
         rsIow/UNFMA9TQyzXZvprGRCRgYwXJcCauyXnT9Wv+d4sVghW5OiQHobOYdTz0iJbYam
         tw7zHKi7gppIfQX7k+I1X1DSaBSe+08Ti6AWsMpXJX2anpxvWI/nrgSdQuJPX8l2vSio
         1u4v4I7uSaM/n1MNwqafgnKwlFNY/1aAun7WbsoLBADMcnF0i6r1OQRpEyNQbwPlw1T8
         mdeg==
X-Gm-Message-State: AJIora/t9lepuDv1FaUFBI4LnNmOgy1hhR5MAswlFnIG1n6ZOTmNTDB3
        2K1dqYM7yPDH2tEbD+eKqZMkFA==
X-Google-Smtp-Source: AGRyM1uXWoz/xWc2GMqHOJsNXnU5IHLjBXiEnxQDiL/VVRBiBKY0HSQeRbsyqOL4jGI0ag21bGXGrQ==
X-Received: by 2002:a05:6a00:c91:b0:525:8c3f:269 with SMTP id a17-20020a056a000c9100b005258c3f0269mr20249956pfv.66.1656663658830;
        Fri, 01 Jul 2022 01:20:58 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902dc8100b00163c6ac211fsm14910383pld.111.2022.07.01.01.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:20:58 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ilia Lin <ilia.lin@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/30] cpufreq: qcom-nvmem: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:00 +0530
Message-Id: <cb712d0b383af3f15d7583f30a82284b06731367.1656660185.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656660185.git.viresh.kumar@linaro.org>
References: <cover.1656660185.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-nvmem.c | 109 +++++++--------------------
 1 file changed, 28 insertions(+), 81 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
index 6dfa86971a75..863548f59c3e 100644
--- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
+++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
@@ -55,9 +55,7 @@ struct qcom_cpufreq_match_data {
 };
 
 struct qcom_cpufreq_drv {
-	struct opp_table **names_opp_tables;
-	struct opp_table **hw_opp_tables;
-	struct opp_table **genpd_opp_tables;
+	int *opp_tokens;
 	u32 versions;
 	const struct qcom_cpufreq_match_data *data;
 };
@@ -315,72 +313,43 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	}
 	of_node_put(np);
 
-	drv->names_opp_tables = kcalloc(num_possible_cpus(),
-				  sizeof(*drv->names_opp_tables),
+	drv->opp_tokens = kcalloc(num_possible_cpus(), sizeof(*drv->opp_tokens),
 				  GFP_KERNEL);
-	if (!drv->names_opp_tables) {
+	if (!drv->opp_tokens) {
 		ret = -ENOMEM;
 		goto free_drv;
 	}
-	drv->hw_opp_tables = kcalloc(num_possible_cpus(),
-				  sizeof(*drv->hw_opp_tables),
-				  GFP_KERNEL);
-	if (!drv->hw_opp_tables) {
-		ret = -ENOMEM;
-		goto free_opp_names;
-	}
-
-	drv->genpd_opp_tables = kcalloc(num_possible_cpus(),
-					sizeof(*drv->genpd_opp_tables),
-					GFP_KERNEL);
-	if (!drv->genpd_opp_tables) {
-		ret = -ENOMEM;
-		goto free_opp;
-	}
 
 	for_each_possible_cpu(cpu) {
+		struct dev_pm_opp_config config = {
+			.supported_hw = NULL,
+		};
+
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
 			ret = -ENODEV;
-			goto free_genpd_opp;
+			goto free_opp;
 		}
 
 		if (drv->data->get_version) {
+			config.supported_hw = &drv->versions;
+			config.supported_hw_count = 1;
 
-			if (pvs_name) {
-				drv->names_opp_tables[cpu] = dev_pm_opp_set_prop_name(
-								     cpu_dev,
-								     pvs_name);
-				if (IS_ERR(drv->names_opp_tables[cpu])) {
-					ret = PTR_ERR(drv->names_opp_tables[cpu]);
-					dev_err(cpu_dev, "Failed to add OPP name %s\n",
-						pvs_name);
-					goto free_opp;
-				}
-			}
-
-			drv->hw_opp_tables[cpu] = dev_pm_opp_set_supported_hw(
-									 cpu_dev, &drv->versions, 1);
-			if (IS_ERR(drv->hw_opp_tables[cpu])) {
-				ret = PTR_ERR(drv->hw_opp_tables[cpu]);
-				dev_err(cpu_dev,
-					"Failed to set supported hardware\n");
-				goto free_genpd_opp;
-			}
+			if (pvs_name)
+				config.prop_name = pvs_name;
 		}
 
 		if (drv->data->genpd_names) {
-			drv->genpd_opp_tables[cpu] =
-				dev_pm_opp_attach_genpd(cpu_dev,
-							drv->data->genpd_names,
-							NULL);
-			if (IS_ERR(drv->genpd_opp_tables[cpu])) {
-				ret = PTR_ERR(drv->genpd_opp_tables[cpu]);
-				if (ret != -EPROBE_DEFER)
-					dev_err(cpu_dev,
-						"Could not attach to pm_domain: %d\n",
-						ret);
-				goto free_genpd_opp;
+			config.genpd_names = drv->data->genpd_names;
+			config.virt_devs = NULL;
+		}
+
+		if (config.supported_hw || config.genpd_names) {
+			drv->opp_tokens[cpu] = dev_pm_opp_set_config(cpu_dev, &config);
+			if (drv->opp_tokens[cpu] < 0) {
+				ret = drv->opp_tokens[cpu];
+				dev_err(cpu_dev, "Failed to set OPP config\n");
+				goto free_opp;
 			}
 		}
 	}
@@ -395,27 +364,10 @@ static int qcom_cpufreq_probe(struct platform_device *pdev)
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
 
-free_genpd_opp:
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->genpd_opp_tables[cpu]))
-			break;
-		dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
-	}
-	kfree(drv->genpd_opp_tables);
 free_opp:
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->names_opp_tables[cpu]))
-			break;
-		dev_pm_opp_put_prop_name(drv->names_opp_tables[cpu]);
-	}
-	for_each_possible_cpu(cpu) {
-		if (IS_ERR(drv->hw_opp_tables[cpu]))
-			break;
-		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
-	}
-	kfree(drv->hw_opp_tables);
-free_opp_names:
-	kfree(drv->names_opp_tables);
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
+	kfree(drv->opp_tokens);
 free_drv:
 	kfree(drv);
 
@@ -429,15 +381,10 @@ static int qcom_cpufreq_remove(struct platform_device *pdev)
 
 	platform_device_unregister(cpufreq_dt_pdev);
 
-	for_each_possible_cpu(cpu) {
-		dev_pm_opp_put_supported_hw(drv->names_opp_tables[cpu]);
-		dev_pm_opp_put_supported_hw(drv->hw_opp_tables[cpu]);
-		dev_pm_opp_detach_genpd(drv->genpd_opp_tables[cpu]);
-	}
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_clear_config(drv->opp_tokens[cpu]);
 
-	kfree(drv->names_opp_tables);
-	kfree(drv->hw_opp_tables);
-	kfree(drv->genpd_opp_tables);
+	kfree(drv->opp_tokens);
 	kfree(drv);
 
 	return 0;
-- 
2.31.1.272.g89b43f80a514

