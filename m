Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 341D9534E64
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240514AbiEZLo6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347201AbiEZLos (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:44:48 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33A2D413E
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:31 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id bo5so1500093pfb.4
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S0NlDi35C5TiI50sHYYZcC2yRcLHKFC/rVdhF6VTtZA=;
        b=hRbGmYeFezjznrIp6yTfpw+NAJasDPpaj4RCuJ9Zkc9Hx9bRHX1aGwtxb+ttllpkpo
         HLhzlDBANM4W4V2dV3v0vbi7c0VVdukcxzwN8T0pXIoY1ZhMWW1FfPOqnYocpfV2Au1E
         R1lxkbwd8ftyzVbS4NwDBGfPVSd3C08h7F1diUnpRcU/XDv1TJc3wkiiJJ/0/cQsGT5Z
         X/3zjBpy7CG/rrWaeWuVsSnhEM/UcaJX6lImTX20/h1dp/nmXjEoaan8oVGwVw6RmZXO
         Ko71ST7dsuTWw6JbAzwj6A+8OLpQXwGv7ZiGwmiOHwNWc8I6LRFRf5kr+sYlMMoYtjci
         8ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S0NlDi35C5TiI50sHYYZcC2yRcLHKFC/rVdhF6VTtZA=;
        b=mooi+IpNmuBUcyE7I5RVi1h6ETIMD7Jq/mBAz/IEyg/sdJ+tLgljnvjTi5AFN+MIk7
         qhZNAp/fC9rlldxPcm5bqf/6dBNqMise+DtJabPv1dIaJ90wfim518bjtr1x0NRnk8NU
         fDtSvgD/P+huozt7GHq1uI6dRWmC/Ku1S+HKNUnISZP6S9dfRqDT+bX71YXnywD3NEzQ
         4anVu43BYFGKbR1ewHCogoT0BuCYbOLnC2Gmmm8td6Pmi0Q4n3/qv7qQwqDskJ15CnrH
         QYPcvpkCBUHyK1JNix9Oj+pKEi3lIlBK7fsdq9CRrpo4ErQRlHCFv/2LxOwh7MaZHLev
         uLSw==
X-Gm-Message-State: AOAM531k2DGbYMh9QgDHjdIfjm0P3Jh05SUn96lb/XS3VtVOjKZ5TODT
        zsghdtvh+oxsZv/p7u9kqHG3wQ==
X-Google-Smtp-Source: ABdhPJwHYkyoY4z87/UCZHUe3lYmt8OLgjsm6sOa4UfL7geTmMxhXMYYb7I+ABhdvJyb8MwWGgj82A==
X-Received: by 2002:a05:6a00:cc9:b0:518:c96f:5c8b with SMTP id b9-20020a056a000cc900b00518c96f5c8bmr13088695pfv.59.1653565471507;
        Thu, 26 May 2022 04:44:31 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e13-20020a17090301cd00b0015e8d4eb1cesm1403105plh.24.2022.05.26.04.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:31 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 21/31] soc/tegra: Remove the call to devm_pm_opp_set_clkname()
Date:   Thu, 26 May 2022 17:12:20 +0530
Message-Id: <1e88b248352afe03cd3bf0e887b1f2be86b5afb5.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
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

The OPP core already performs devm_pm_opp_set_clkname() with name as
NULL, the callers shouldn't be doing the same unless they have a
different clock name to add here.

Drop the call.

Cc: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/soc/tegra/common.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/soc/tegra/common.c b/drivers/soc/tegra/common.c
index 32c346b72635..49a5360f4507 100644
--- a/drivers/soc/tegra/common.c
+++ b/drivers/soc/tegra/common.c
@@ -108,12 +108,6 @@ int devm_tegra_core_dev_init_opp_table(struct device *dev,
 	u32 hw_version;
 	int err;
 
-	err = devm_pm_opp_set_clkname(dev, NULL);
-	if (err) {
-		dev_err(dev, "failed to set OPP clk: %d\n", err);
-		return err;
-	}
-
 	/* Tegra114+ doesn't support OPP yet */
 	if (!of_machine_is_compatible("nvidia,tegra20") &&
 	    !of_machine_is_compatible("nvidia,tegra30"))
-- 
2.31.1.272.g89b43f80a514

