Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F00D7534E42
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347167AbiEZLnz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiEZLnw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:43:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53BB93DDD0
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:50 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id a9so1108204pgv.12
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=At8FyujAWdCUO+FjxXSxheFtkPMDnLD38WsTFqXV9zc=;
        b=Dgq+KUb9LbagAUGbz4g0hK4phFFYr+29FnN0mX4TX4b1/v4uD7L3UQUKMNMl57R56h
         Daverzmf41qCwAAuAj/D9h6tWFPYUhKd80gTK5fBqh3Mwes4+U9vtaCWZq2xdMCR3s2g
         wifI86NL4+O3Rr4ByA0AIeTo1grob/6IktN4l9k8wSWxFJC4HxZBjN8mS39qpcfSDWUK
         oFZrLn2mJGf+QVSnZktWapMm4qpa8nu9h9Din01EFuezVnNmsJh2EqQxgToMrO1ABl5O
         jJLD5JFE3gBXwBVphDzJX4ajUKra9m1MEz6sXiTgVkzfyQXevD9S9ukiLZByjYPBFDOc
         P/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=At8FyujAWdCUO+FjxXSxheFtkPMDnLD38WsTFqXV9zc=;
        b=wkaJwAkHRvS2bOU/cziNTs3hQiZTjrmoI4hUAJwN2eNAg4HgatQVvynyfClMwSKWID
         b6eSzHOzZZ+7q9l2P/IFdYK3SlUMNyuGDtmeFeIpmVVIUi0mNIV+iVEusgrj/y9Clwul
         WZunWMtNmV08uMcKQNEu8J4k7ZdwgY7jy2p37wbG0KqChcVp99PrD2jpz9wuM9/1LoOu
         IyZtaZ7wUYXd955TDhzrCYTmpRTgFM4ZLPJZtw1UTy+pQz2akc14QrQUIdOwMPc5ec1B
         SKyQpDbE7PY+spRSaoY8o8yAi0q86NS4m1XfeED3OJfCozu99HG7EoTx0FxGiHr9mPD8
         XUtA==
X-Gm-Message-State: AOAM533+mhhPDHe4lwd7j1mdFuBqJ6Jfe6SZWvtVoWpA6Ez4drrrTroX
        bWJF19OyrxCOHgfrsLDJSLQdsQ==
X-Google-Smtp-Source: ABdhPJwhHEen29vpBKJyeKDZPt00TZiDzvOdz8gm8EwEypTNkA+35hLqP4GfxTeaCSrp7uJrK2g+zw==
X-Received: by 2002:a05:6a00:1792:b0:519:80a:9598 with SMTP id s18-20020a056a00179200b00519080a9598mr5231833pfg.10.1653565429812;
        Thu, 26 May 2022 04:43:49 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015e8d4eb269sm1298652plf.179.2022.05.26.04.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:43:49 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/31] cpufreq: tegra20: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:07 +0530
Message-Id: <4b38ceed657bfcf87ff9ab0dd69dd1f2f5658b24.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/cpufreq/tegra20-cpufreq.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index e8db3d75be25..2c73623e3abb 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -34,7 +34,7 @@ static bool cpu0_node_has_opp_v2_prop(void)
 
 static void tegra20_cpufreq_put_supported_hw(void *opp_table)
 {
-	dev_pm_opp_put_supported_hw(opp_table);
+	dev_pm_opp_clear_config(opp_table);
 }
 
 static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
@@ -49,6 +49,10 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 	struct device *cpu_dev;
 	u32 versions[2];
 	int err;
+	struct dev_pm_opp_config config = {
+		.supported_hw = versions,
+		.supported_hw_count = ARRAY_SIZE(versions),
+	};
 
 	if (!cpu0_node_has_opp_v2_prop()) {
 		dev_err(&pdev->dev, "operating points not found\n");
@@ -71,10 +75,10 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 	if (WARN_ON(!cpu_dev))
 		return -ENODEV;
 
-	opp_table = dev_pm_opp_set_supported_hw(cpu_dev, versions, 2);
-	err = PTR_ERR_OR_ZERO(opp_table);
+	opp_table = dev_pm_opp_set_config(cpu_dev, &config);
+	err = PTR_ERR(opp_table);
 	if (err) {
-		dev_err(&pdev->dev, "failed to set supported hw: %d\n", err);
+		dev_err(&pdev->dev, "failed to set OPP config: %d\n", err);
 		return err;
 	}
 
-- 
2.31.1.272.g89b43f80a514

