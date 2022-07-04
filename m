Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DB3565461
	for <lists+linux-pm@lfdr.de>; Mon,  4 Jul 2022 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234237AbiGDMIz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 4 Jul 2022 08:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiGDMIj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2022 08:08:39 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7F11C17
        for <linux-pm@vger.kernel.org>; Mon,  4 Jul 2022 05:08:28 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 68so8772027pgb.10
        for <linux-pm@vger.kernel.org>; Mon, 04 Jul 2022 05:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WkT4cfQDKDgQriqwWc+6j8mdVE37fQDQyfwgbCdj5XM=;
        b=etMNCuvt0uzioN7MJq081SPdRL8NX4YOILS2GtQ2QRBruN3Xd/MDhjYqVwL7/BuZcl
         PF9IJMtla+CRBQLhFbVLFBErdBZZreCs+k7cD348iRIFe/hXPphLjrC25UTRHmJbsEBQ
         Y5ZJ+5QSa3+ox9X+oyLyAGJuIxGhhCULJRg2T8wY7q2lCVVNGo7rG1QAuFgbNk0iW+F2
         zZdpEGOnmW3oD0mfkmMWaMXkjjn4uhiCkgPE3rCUOrKi4FjYeyCXlmuSz9sTTZ6Ti8l8
         Fwg/RCN465DERe3QJoOX5ul/Yxty+z2Cm6bWM6aPyOLJxX91o2mgsIpLn3pFV3Zkirat
         5uCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WkT4cfQDKDgQriqwWc+6j8mdVE37fQDQyfwgbCdj5XM=;
        b=Sb7IgtdLbUrMTBHSY+jrFWnwF79aAVdKr1w4nAPZBPq0rGUza3SiIsCDfGsfdFL28S
         +gSLsjlQxwN/DsEISxyxnvKttRzvZVUP8zT6PO+WUNB7V1C+LYDYQ+d3V4RLNmMXhJpJ
         CZM25wwB7xjS4tpE0p5+gWI+eRWZdgxLlVJ3y5mPenWeZYiJL941hGQCS6pU7NF6xCOM
         w4xFhEhfeIgklKBrRvh4cDBOeSvp1Ohk4I414cbg9HZAgAjMwXE9CjYR08X2tgRXLhFE
         VwRoMkXdeNc0EZUZeSiebs6ehRKnEtaffrLN4elxJUvzqjdDpY0pPlTtLsiXh8ZQfghx
         90jg==
X-Gm-Message-State: AJIora88mif9Bk8C8zT2m18d5H3t4PEOiHwlk9fQUp43fDyO6cuR4pRN
        m/wYAjGpQt4tQYRnTtcp46k52A==
X-Google-Smtp-Source: AGRyM1tXweBB4oshG2eCoAeOGjJLdt48rXejLcqNLC2hz6NERwcmVLQ/A4E9kstzW9zBhGDocNwDzA==
X-Received: by 2002:a63:8849:0:b0:40d:e25:9fb2 with SMTP id l70-20020a638849000000b0040d0e259fb2mr25519396pgd.592.1656936507697;
        Mon, 04 Jul 2022 05:08:27 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id n4-20020a6546c4000000b0040c9df2b060sm20448482pgr.30.2022.07.04.05.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 05:08:27 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 06/20] cpufreq: ti: Migrate to dev_pm_opp_set_config()
Date:   Mon,  4 Jul 2022 17:37:44 +0530
Message-Id: <d8d5cfc5ef503c0ab3b5af62d5723eeb9fec62b7.1656935522.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1656935522.git.viresh.kumar@linaro.org>
References: <cover.1656935522.git.viresh.kumar@linaro.org>
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

The OPP core now provides a unified API for setting all configuration
types, i.e. dev_pm_opp_set_config().

Lets start using it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/ti-cpufreq.c | 37 ++++++++++++++----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
index 560d67a6bef1..df85a77d476b 100644
--- a/drivers/cpufreq/ti-cpufreq.c
+++ b/drivers/cpufreq/ti-cpufreq.c
@@ -60,7 +60,6 @@ struct ti_cpufreq_data {
 	struct device_node *opp_node;
 	struct regmap *syscon;
 	const struct ti_cpufreq_soc_data *soc_data;
-	struct opp_table *opp_table;
 };
 
 static unsigned long amx3_efuse_xlate(struct ti_cpufreq_data *opp_data,
@@ -324,10 +323,13 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 {
 	u32 version[VERSION_COUNT];
 	const struct of_device_id *match;
-	struct opp_table *ti_opp_table;
 	struct ti_cpufreq_data *opp_data;
 	const char * const default_reg_names[] = {"vdd", "vbb", NULL};
 	int ret;
+	struct dev_pm_opp_config config = {
+		.supported_hw = version,
+		.supported_hw_count = ARRAY_SIZE(version),
+	};
 
 	match = dev_get_platdata(&pdev->dev);
 	if (!match)
@@ -370,32 +372,21 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
 	if (ret)
 		goto fail_put_node;
 
-	ti_opp_table = dev_pm_opp_set_supported_hw(opp_data->cpu_dev,
-						   version, VERSION_COUNT);
-	if (IS_ERR(ti_opp_table)) {
-		dev_err(opp_data->cpu_dev,
-			"Failed to set supported hardware\n");
-		ret = PTR_ERR(ti_opp_table);
-		goto fail_put_node;
-	}
-
-	opp_data->opp_table = ti_opp_table;
-
 	if (opp_data->soc_data->multi_regulator) {
-		const char * const *reg_names = default_reg_names;
-
 		if (opp_data->soc_data->reg_names)
-			reg_names = opp_data->soc_data->reg_names;
-		ti_opp_table = dev_pm_opp_set_regulators(opp_data->cpu_dev,
-							 reg_names);
-		if (IS_ERR(ti_opp_table)) {
-			dev_pm_opp_put_supported_hw(opp_data->opp_table);
-			ret =  PTR_ERR(ti_opp_table);
-			goto fail_put_node;
-		}
+			config.regulator_names = opp_data->soc_data->reg_names;
+		else
+			config.regulator_names = default_reg_names;
+	}
+
+	ret = dev_pm_opp_set_config(opp_data->cpu_dev, &config);
+	if (ret < 0) {
+		dev_err(opp_data->cpu_dev, "Failed to set OPP config\n");
+		goto fail_put_node;
 	}
 
 	of_node_put(opp_data->opp_node);
+
 register_cpufreq_dt:
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 
-- 
2.31.1.272.g89b43f80a514

