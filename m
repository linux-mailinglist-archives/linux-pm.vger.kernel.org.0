Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0656562DDB
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 10:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiGAIVe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 04:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbiGAIVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 04:21:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F2670E64
        for <linux-pm@vger.kernel.org>; Fri,  1 Jul 2022 01:21:07 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y141so1774052pfb.7
        for <linux-pm@vger.kernel.org>; Fri, 01 Jul 2022 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ythbHY3HGZXqavoZCsWCeWM4NB+A+Z15e7P5aMati+I=;
        b=KQmB5ZcFd9+cVWdlyXtKlYgu/OkQKiHszPPacTNHNiJ2RQFBM2UQBdHc+2QuTNdSt0
         vBDx8hXQBVHDDnYsAStjhO+uFLzQeWvZRmdEsOPdKPAVKJj9gbOi+Z2XixLhmmfx2w23
         SB7RYF0Y1YFexpb2981vcVDBMf/d6JqZneKCyCQ4a80/kh+M68+zi2vvQZu1w98LGDGX
         /p0iwiGtEJHe6JcOUjSjpzOc6dDsaefaaLlp4NKlJacwje30emCGo+r42WF34HhtAtkA
         3R22xGdVftk+1Koe2wwt8MOcLARgvco2JTeP2ZS8JjSr5NkA/CS8OnJ/1j0Kon/LBe9+
         pQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ythbHY3HGZXqavoZCsWCeWM4NB+A+Z15e7P5aMati+I=;
        b=CRai3ThfrvsBOT1k6/sW+EDA31s348CQzdoYkNsuOss2V+ishvk2SuQNsaibAZyheN
         SQpLS4kjcwBmUi7WMH9g5NJfTDupdgTz1/crrv3jWL1lkvMMFwJ/gleGdoOVJeXeD1Nd
         GEzV2w95YNdOkfHYCyk/vwc6ZXT6UaugTJsk/VVQnS6Tl08E01psZw7KQ+YXBXly6OQL
         gU7b1zR0o4YeFz0oe/SYAiSfzaEr73w0jL55SXmyt0o0bU9/zfhefVYtn9a1fYa6lmhl
         13dRyFS/lgsmhA8AVd7gFpsL1iwrYMgQJzfLanOxCJVI/YIjL6o3wMJZgDVG0RWj6a7k
         gNdA==
X-Gm-Message-State: AJIora8KW16Df1evb6icTqmCyURqFFzMj82PF0wXJ0c6CYMd1LGX2WWv
        LjA5NS9nDUgdim62TEd1yOJv2A==
X-Google-Smtp-Source: AGRyM1ua02yOf1KjCRiYGbqfbo7BgHFhNhA1zPuRmxQvnkx9Jj4XIv4wKzRvD7G48zrZnA5RYHWt4g==
X-Received: by 2002:a05:6a00:cd5:b0:525:5211:7d96 with SMTP id b21-20020a056a000cd500b0052552117d96mr19002524pfv.56.1656663666825;
        Fri, 01 Jul 2022 01:21:06 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id s26-20020a65645a000000b0040c755b7651sm14811432pgv.41.2022.07.01.01.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:21:06 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/30] cpufreq: tegra20: Migrate to dev_pm_opp_set_config()
Date:   Fri,  1 Jul 2022 13:50:03 +0530
Message-Id: <1a6fb3ccfb18b82c062ca587422e100064814f4d.1656660185.git.viresh.kumar@linaro.org>
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

Tested-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/tegra20-cpufreq.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index e8db3d75be25..edd738e641f8 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -32,9 +32,9 @@ static bool cpu0_node_has_opp_v2_prop(void)
 	return ret;
 }
 
-static void tegra20_cpufreq_put_supported_hw(void *opp_table)
+static void tegra20_cpufreq_put_supported_hw(void *opp_token)
 {
-	dev_pm_opp_put_supported_hw(opp_table);
+	dev_pm_opp_clear_config((unsigned long) opp_token);
 }
 
 static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
@@ -45,10 +45,13 @@ static void tegra20_cpufreq_dt_unregister(void *cpufreq_dt)
 static int tegra20_cpufreq_probe(struct platform_device *pdev)
 {
 	struct platform_device *cpufreq_dt;
-	struct opp_table *opp_table;
 	struct device *cpu_dev;
 	u32 versions[2];
 	int err;
+	struct dev_pm_opp_config config = {
+		.supported_hw = versions,
+		.supported_hw_count = ARRAY_SIZE(versions),
+	};
 
 	if (!cpu0_node_has_opp_v2_prop()) {
 		dev_err(&pdev->dev, "operating points not found\n");
@@ -71,16 +74,15 @@ static int tegra20_cpufreq_probe(struct platform_device *pdev)
 	if (WARN_ON(!cpu_dev))
 		return -ENODEV;
 
-	opp_table = dev_pm_opp_set_supported_hw(cpu_dev, versions, 2);
-	err = PTR_ERR_OR_ZERO(opp_table);
-	if (err) {
-		dev_err(&pdev->dev, "failed to set supported hw: %d\n", err);
+	err = dev_pm_opp_set_config(cpu_dev, &config);
+	if (err < 0) {
+		dev_err(&pdev->dev, "failed to set OPP config: %d\n", err);
 		return err;
 	}
 
 	err = devm_add_action_or_reset(&pdev->dev,
 				       tegra20_cpufreq_put_supported_hw,
-				       opp_table);
+				       (void *)((unsigned long) err));
 	if (err)
 		return err;
 
-- 
2.31.1.272.g89b43f80a514

