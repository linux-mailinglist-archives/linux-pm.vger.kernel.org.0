Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835677524F7
	for <lists+linux-pm@lfdr.de>; Thu, 13 Jul 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjGMOS3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 13 Jul 2023 10:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235340AbjGMOSU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 13 Jul 2023 10:18:20 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2081212D
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:18 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso1421141e87.0
        for <linux-pm@vger.kernel.org>; Thu, 13 Jul 2023 07:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689257897; x=1691849897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MR9071mGx80qY0kJZ8wG+4u/OTaITL09lIPAcVvKYoY=;
        b=hKjPdPLXD83qAxjuqN24j9TfFDVAxafvZ1Rb5x/hTQOS73gvGcjakwN4bsCP5GkbfC
         LHz4npRtg/wMvSOLGWv0EcXVFNMKBmQczi/3dNsvRHGrYgU3BHCVFtRiZ4Gh1rcqRUUE
         Ff96gg5AuHyBl/ew/fhyHt8ec0e0b/Hvr1U4MADn34sPUyia0VeVRS2EmEV9YiLbhv7G
         xbz2y6vv4hYzWCI4/WM3aGP7y4qcBV094Df+qhjiwRmleR6QPSrFEg5x1s1+g1+4ZJ9c
         jfdLHMbB4ZymEXIKwB6dW90yGUHbrmAnv77Z9/nXxScaVABZEFIOdP2X3vVzRTvQ4Jiz
         NvjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689257897; x=1691849897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MR9071mGx80qY0kJZ8wG+4u/OTaITL09lIPAcVvKYoY=;
        b=SGTTlI9BrQtnUXHTin6OrtfrdxYDzzrbZWLjTODw7oqhCQktUgOKHVXSJBN/vAWsUN
         t/AnB+xx2XnQkQHfRr4TnT6fhdtTSNAsCUK5a8i7DbwBz/9LHZgXdN6WLRRFnb4Cmd+x
         r70Zlc3L+V6ejqTwg6UvmG0ESvNRRHE6/6D5UKf2PRLX6v8Yjftjjm5YNFfQyG5MsijO
         yoG4kFF5799Yk7qVNbP9DZLKg13l4vqTk/C5is8/MmiUoANC06BgjuIpZN+BSFoVl6dA
         +UZL6zINGpmqsjpNjhcRKoQdM/Lcbv6iv58s/W1BWSsj6nmlW/wAAFNF5va79G0j9Qup
         30kA==
X-Gm-Message-State: ABy/qLbIJsqe7taW2CTNlY7ZWJyh4+Q2pGUXURclbwjByqjHZ07gpP0g
        MhZKUsrtGvz+WNb389agdfhz8A==
X-Google-Smtp-Source: APBJJlEc8L+tzE/ZLwqPTWOj0SM2N8oRU5MLYlzz/leOWTlx7EW0n7Y1Nvozvqu4moF16Gs4iC5BIw==
X-Received: by 2002:a05:6512:2253:b0:4fb:896d:bd70 with SMTP id i19-20020a056512225300b004fb896dbd70mr1398709lfu.46.1689257897246;
        Thu, 13 Jul 2023 07:18:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id w28-20020ac2599c000000b004fb759964a9sm1132426lfn.168.2023.07.13.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:18:16 -0700 (PDT)
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
Subject: [PATCH v2 06/11] cpufreq: scmi: Avoid one OF parsing in scmi_get_sharing_cpus()
Date:   Thu, 13 Jul 2023 16:17:33 +0200
Message-Id: <20230713141738.23970-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230713141738.23970-1-ulf.hansson@linaro.org>
References: <20230713141738.23970-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The domain-id for the cpu_dev has already been parsed at the point when
scmi_get_sharing_cpus() is getting called. Let's pass it as an in-parameter
to avoid the unnecessary OF parsing.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- None.

---
 drivers/cpufreq/scmi-cpufreq.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 125e8a8421fb..78f53e388094 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -82,15 +82,12 @@ static int scmi_cpu_domain_id(struct device *cpu_dev)
 }
 
 static int
-scmi_get_sharing_cpus(struct device *cpu_dev, struct cpumask *cpumask)
+scmi_get_sharing_cpus(struct device *cpu_dev, int domain,
+		      struct cpumask *cpumask)
 {
-	int cpu, domain, tdomain;
+	int cpu, tdomain;
 	struct device *tcpu_dev;
 
-	domain = scmi_cpu_domain_id(cpu_dev);
-	if (domain < 0)
-		return domain;
-
 	for_each_possible_cpu(cpu) {
 		if (cpu == cpu_dev->id)
 			continue;
@@ -163,7 +160,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	/* Obtain CPUs that share SCMI performance controls */
-	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
+	ret = scmi_get_sharing_cpus(cpu_dev, domain, policy->cpus);
 	if (ret) {
 		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
 		goto out_free_cpumask;
-- 
2.34.1

