Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851387885A9
	for <lists+linux-pm@lfdr.de>; Fri, 25 Aug 2023 13:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243334AbjHYL1c (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 25 Aug 2023 07:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243439AbjHYL1K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 25 Aug 2023 07:27:10 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1162108
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:27:03 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5007c8308c3so1248833e87.0
        for <linux-pm@vger.kernel.org>; Fri, 25 Aug 2023 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692962821; x=1693567621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGDMaEKOG+5X48Gol+AxEGCcHKZ/Xp97A0Ym/9JW7WA=;
        b=evHyviDBbKrlfh1CbONZfo3Hw+ynOWClrckD28Hb4PQcbXyoltKbeIH4CQbLmR4S6R
         gfXyfPRSmirFAB54VWIlpJf7lMgQb9zUUyrjoPQOGM42LzYtaUEz8p70IB3y3cHdb35z
         JtJzJnNoeyesZh6C1XKmiD8VyuRDY7uuAIz0leu5xTiSqhPT2K6Qy6H+tF5yoHzeqCVy
         Avoxxpxu/R1LWsiFNPBzJGfEvp7kTXz6cUUd7rpoaTFDqMoqknyWMzaoTBrAmjvDgQ0Q
         mE5IcQatFk8G70HHJisUwSFN+I6u8aAeVOmMIyaYvJNznAYDyvW2qkiFLKRnp0RoDB3x
         PLVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692962821; x=1693567621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGDMaEKOG+5X48Gol+AxEGCcHKZ/Xp97A0Ym/9JW7WA=;
        b=ex3BB3mJHKKuqo2Lx8khBzYwR+kg8OwGGEeG9MfnFJlPJ70rNNizTKItCNEU3RbU38
         5b0oFIxEe4Q6kxsxP6LIZ3L+O7r/0APQG/BoQNNaNKurcUSJrIXlrmYverqO59uNTznd
         jGNbNCW9XftjudMAsVTrhxXc+M0NUQ5CZg2WHwaJTuTCWdm4OxwMFwvNKky2X0AEGYbh
         ZwXP2u+X3sdgCxWh7J4yMOn1mi6DX9M8KD6aEQ9jbMaxehmtmHBcaGwdQIZnbWsdsi8D
         +MxHZBS0Xns5/Bs79eTLWRGtYhcR0AshIqVXTD8nz9u3n3mXbXEZAiXrhLj9amZXrEV5
         pJJw==
X-Gm-Message-State: AOJu0Yy+AYtnpa98W8NM/7YJYNJgVNVYYZSLYSgv8vamF2UiLQqSuxl/
        6OK1ivxHoOX/mCxKC/AXOao9zg==
X-Google-Smtp-Source: AGHT+IH6lqqhRCYBDaNaKp91DKemKXN5IdXT7VJPtMsE6HuTPI+lcAdwJlp7Kc2m4jw4UZT1pd3Vkw==
X-Received: by 2002:a05:6512:ba0:b0:500:882b:e55a with SMTP id b32-20020a0565120ba000b00500882be55amr11312115lfv.45.1692962821456;
        Fri, 25 Aug 2023 04:27:01 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id g7-20020ac25387000000b004fb7ac67bbdsm259164lfh.41.2023.08.25.04.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 04:27:01 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/13] cpufreq: scmi: Drop redundant ifdef in scmi_cpufreq_probe()
Date:   Fri, 25 Aug 2023 13:26:27 +0200
Message-Id: <20230825112633.236607-8-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230825112633.236607-1-ulf.hansson@linaro.org>
References: <20230825112633.236607-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

We have stubs for devm_of_clk_add_hw_provider(), so there should be no need
to protect this with the '#ifdef CONFIG_COMMON_CLK'. Let's drop it to clean
up the code a bit.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- None.

---
 drivers/cpufreq/scmi-cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 78f53e388094..48bd393a1506 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -320,11 +320,9 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	if (IS_ERR(perf_ops))
 		return PTR_ERR(perf_ops);
 
-#ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
 	if (of_property_present(dev->of_node, "#clock-cells"))
 		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
-#endif
 
 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
 	if (ret) {
-- 
2.34.1

