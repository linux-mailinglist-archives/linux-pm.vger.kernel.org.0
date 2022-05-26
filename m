Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DF2534E55
	for <lists+linux-pm@lfdr.de>; Thu, 26 May 2022 13:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345584AbiEZLo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 26 May 2022 07:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347212AbiEZLoI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 May 2022 07:44:08 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC594AFAE9
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:03 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id r71so1196754pgr.0
        for <linux-pm@vger.kernel.org>; Thu, 26 May 2022 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=11qGt7qh8zRe6KglTXx56ADtsrAzF8XGakYWw73nu7U=;
        b=B10RnQ+4h3rJ31p7/lyMfDOmSs4vHMBIqdYH/jhUlv+RtqyWrCKWHK7xC5dAO8JVzl
         O+s+7KTuEoYA134U7uTjPfU4njmVrFjfbNKbdAC/mc4y2pdFVyazvM5n2LgD+c3Bp4Xd
         8ZMXN3NUen2pWITJUoJz7YpJABh11SHblcNfaghlJmBToJLVUOSCuYpaF8vNtF8VALBF
         cw1kbqq49Wo4AYmaeTVN/xTzM7YaHjTF5RbwUThblJBXtw6qvCeTxZ+zuC8RWvUr/caZ
         T6ZtXwAoLeQbU9jEIN2aiWBlX6ta1z1j5OBAtwPU37YS4GpryQtAfo5vW+CnkdElTQwC
         hIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=11qGt7qh8zRe6KglTXx56ADtsrAzF8XGakYWw73nu7U=;
        b=5hWDvlT1Afl49m8EiA2acDxrY7ThxzA4OTY4lsSWIf5/lWaVK00MckYtpbgt8l+PEc
         ldWLavJ92fbtnGmcBNv6a+3RX/OPdB8V/QOCOFl2ddt4Bc+rfqdiunpdu/aabY/gd/ie
         Jr+MCmDUD42bhoChBpvIL0R9SkjyWH1jly5QVa7iDH7nho35xJrG6j4f+fjdFleSB8VM
         8w+LWPp3VhC57Iu9j68telfVhTrbtfCzdZs1LHIRaPyp6KwMZXOWQpLDxFX8kCk7T/ex
         qfPLOro1MrRjbGwTNxI9hCqAagjfJsJuTImNmcSyWkJYoTfw3b9ntaneOOedAQCd699s
         6HRg==
X-Gm-Message-State: AOAM531qVKbNUGGkXod9G6x+MIdEkYU7JDK2izGiv+cVHJBQ6D1AukUb
        XiUNud3n+1VeAoxWEdQvoZM+7A==
X-Google-Smtp-Source: ABdhPJwVgHoxb/fCbZF3mP2Q0s1t8l7NyGjFM6en7hyZyhg8rEMRObWrGwGkProaqe8dmm38mDCa9Q==
X-Received: by 2002:aa7:83d0:0:b0:50c:eb2b:8e8a with SMTP id j16-20020aa783d0000000b0050ceb2b8e8amr38168150pfn.31.1653565442488;
        Thu, 26 May 2022 04:44:02 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id e17-20020a170903241100b0015e8d4eb208sm1318377plo.82.2022.05.26.04.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:02 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 12/31] devfreq: tegra30: Migrate to dev_pm_opp_set_config()
Date:   Thu, 26 May 2022 17:12:11 +0530
Message-Id: <f2951943c1b85eb1ad480da5c2ccdb407dad3296.1653564321.git.viresh.kumar@linaro.org>
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
 drivers/devfreq/tegra30-devfreq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/tegra30-devfreq.c b/drivers/devfreq/tegra30-devfreq.c
index 65ecf17a36f4..30382bdfc655 100644
--- a/drivers/devfreq/tegra30-devfreq.c
+++ b/drivers/devfreq/tegra30-devfreq.c
@@ -830,6 +830,10 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 	unsigned int i;
 	long rate;
 	int err;
+	struct dev_pm_opp_config config = {
+		.supported_hw = &hw_version,
+		.supported_hw_count = 1,
+	};
 
 	tegra = devm_kzalloc(&pdev->dev, sizeof(*tegra), GFP_KERNEL);
 	if (!tegra)
@@ -874,9 +878,9 @@ static int tegra_devfreq_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	err = devm_pm_opp_set_supported_hw(&pdev->dev, &hw_version, 1);
+	err = devm_pm_opp_set_config(&pdev->dev, &config);
 	if (err) {
-		dev_err(&pdev->dev, "Failed to set supported HW: %d\n", err);
+		dev_err(&pdev->dev, "Failed to set OPP config: %d\n", err);
 		return err;
 	}
 
-- 
2.31.1.272.g89b43f80a514

