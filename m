Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3CE2AE5AF
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 02:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732743AbgKKBP2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 20:15:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732668AbgKKBP2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 10 Nov 2020 20:15:28 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944CBC0613D1;
        Tue, 10 Nov 2020 17:15:27 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id 33so732280wrl.7;
        Tue, 10 Nov 2020 17:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tGnE/w0793PmiZunMZUFRQQsSOAX6VpoE5tQ0qL0TNQ=;
        b=CcfAfEc6Wxuq43NPB2gcWjtzwD+rbTxfWxHbeLec/lZwZ6dFPoXjmeEUgLjljQgcld
         8bVDr2hyPhV0gPawzmCUcXpu5S1kfmWxH0asby0EFWuIEvCGEIWJH0Fhyg66gyRTdZVh
         QoDQo7/B8uOk3Ag8f5qy05A0PJa7Xj3rv7xDKjTcwC68fYmEhbnd+s/XpaMfFWtqb+Pl
         +6VLSz3am4vwEWBFThAUB2PPFLh8DnT4pMDBmJl3eRlLSiAhHxWaxZZAtuv50i8MBKxf
         g3j7DQA8P/hivATvNN7WiIbLK6ZOjG00myzY8WtM134yExNprTRQQQsid2x2eCZv3FLk
         tDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tGnE/w0793PmiZunMZUFRQQsSOAX6VpoE5tQ0qL0TNQ=;
        b=J2F/wJphY5rOooEcPqQmU94Yncif4cQgexsb9fo/1ZDhmRTQSb4iGmVaRlebZkKJBu
         J4iXNeSLnyc6RJHQ1YSssXb8equzV0HItrg6PT7/sWeseu8IgsopUguj678qAjNrNk23
         x/y5zNQj2qobVykr5O/JiCyUxU0IdypnXs6mPk0fKO3w+UEpIIwN6GzwsdI2aDQOKdIs
         bbOx5vYSAu9QzMs4Ym15ClwRgBlqz3JavOqLulB1ZUKRfguclkAR10giEsdXd+TkNITt
         oCOW6+SUgAsLfE6aBVfcc1r70x6fdjXuHVwDE1WePzw2N+Nyi4K1Pg8RngQDJPtbGVli
         x9aA==
X-Gm-Message-State: AOAM531gZ+cImgW1/XEaiHtZh+G0FdgxcKoBiRap6fhBZoK8fNw44UD1
        8yal7OXfD3WmV2DmievhHzQ=
X-Google-Smtp-Source: ABdhPJxT2Qem7xK8FMBf7L9oqeIzo9kSbIvbZEskaZoYi7GPZRzXLlBpaEcV3CmGbBmP3438ikSLUQ==
X-Received: by 2002:adf:ecc9:: with SMTP id s9mr24606051wro.246.1605057326400;
        Tue, 10 Nov 2020 17:15:26 -0800 (PST)
Received: from localhost.localdomain (109-252-193-159.dynamic.spd-mgts.ru. [109.252.193.159])
        by smtp.gmail.com with ESMTPSA id g131sm564329wma.35.2020.11.10.17.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 17:15:25 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>,
        Viresh Kumar <vireshk@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v8 10/26] memory: tegra30-emc: Factor out clk initialization
Date:   Wed, 11 Nov 2020 04:14:40 +0300
Message-Id: <20201111011456.7875-11-digetx@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201111011456.7875-1-digetx@gmail.com>
References: <20201111011456.7875-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Factor out clk initialization and make it resource-managed. This makes
easier to follow code and will help to make further changes cleaner.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/memory/tegra/tegra30-emc.c | 70 ++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/drivers/memory/tegra/tegra30-emc.c b/drivers/memory/tegra/tegra30-emc.c
index d27df842a667..1df42e212d73 100644
--- a/drivers/memory/tegra/tegra30-emc.c
+++ b/drivers/memory/tegra/tegra30-emc.c
@@ -1550,6 +1550,49 @@ static int tegra_emc_opp_table_init(struct tegra_emc *emc)
 	return err;
 }
 
+static void devm_tegra_emc_unset_callback(void *data)
+{
+	tegra20_clk_set_emc_round_callback(NULL, NULL);
+}
+
+static void devm_tegra_emc_unreg_clk_notifier(void *data)
+{
+	struct tegra_emc *emc = data;
+
+	clk_notifier_unregister(emc->clk, &emc->clk_nb);
+}
+
+static int tegra_emc_init_clk(struct tegra_emc *emc)
+{
+	int err;
+
+	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
+
+	err = devm_add_action_or_reset(emc->dev, devm_tegra_emc_unset_callback,
+				       NULL);
+	if (err)
+		return err;
+
+	emc->clk = devm_clk_get(emc->dev, NULL);
+	if (IS_ERR(emc->clk)) {
+		dev_err(emc->dev, "failed to get EMC clock: %pe\n", emc->clk);
+		return PTR_ERR(emc->clk);
+	}
+
+	err = clk_notifier_register(emc->clk, &emc->clk_nb);
+	if (err) {
+		dev_err(emc->dev, "failed to register clk notifier: %d\n", err);
+		return err;
+	}
+
+	err = devm_add_action_or_reset(emc->dev,
+				       devm_tegra_emc_unreg_clk_notifier, emc);
+	if (err)
+		return err;
+
+	return 0;
+}
+
 static int tegra_emc_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
@@ -1599,25 +1642,13 @@ static int tegra_emc_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	tegra20_clk_set_emc_round_callback(emc_round_rate, emc);
-
-	emc->clk = devm_clk_get(&pdev->dev, "emc");
-	if (IS_ERR(emc->clk)) {
-		err = PTR_ERR(emc->clk);
-		dev_err(&pdev->dev, "failed to get emc clock: %d\n", err);
-		goto unset_cb;
-	}
-
-	err = clk_notifier_register(emc->clk, &emc->clk_nb);
-	if (err) {
-		dev_err(&pdev->dev, "failed to register clk notifier: %d\n",
-			err);
-		goto unset_cb;
-	}
+	err = tegra_emc_init_clk(emc);
+	if (err)
+		return err;
 
 	err = tegra_emc_opp_table_init(emc);
 	if (err)
-		goto unreg_notifier;
+		return err;
 
 	platform_set_drvdata(pdev, emc);
 	tegra_emc_rate_requests_init(emc);
@@ -1632,13 +1663,6 @@ static int tegra_emc_probe(struct platform_device *pdev)
 	try_module_get(THIS_MODULE);
 
 	return 0;
-
-unreg_notifier:
-	clk_notifier_unregister(emc->clk, &emc->clk_nb);
-unset_cb:
-	tegra20_clk_set_emc_round_callback(NULL, NULL);
-
-	return err;
 }
 
 static int tegra_emc_suspend(struct device *dev)
-- 
2.29.2

