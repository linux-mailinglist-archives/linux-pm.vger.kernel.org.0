Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F4569EFC
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jul 2022 12:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235221AbiGGJ6k (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jul 2022 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235209AbiGGJ6i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jul 2022 05:58:38 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EC332061
        for <linux-pm@vger.kernel.org>; Thu,  7 Jul 2022 02:58:36 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id b9so2313981pfp.10
        for <linux-pm@vger.kernel.org>; Thu, 07 Jul 2022 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4HG/EzZ4yDDFX9ZLe3tGPR/mp2zuB3XLszlvbX2wT0=;
        b=oBdEAfaiagKKd/OutXLnPclA2lEf0G7KFP80f2aTDyy1KnozMKyeI6Pbm4w5TMKXd1
         nVtTwwblWIebPNpAa+ogNWgoQNu4DMh+8y+dJbkiBnt+B37PXJBJZE3dBRBlYBxbSnCN
         XYz30hJd4U1Uc8GTwVoCEGX5Zx4ckZ5qvnUuMOZS4ZtzF+xL/qgXb1LoDHzQs8Ujl29T
         ENrpuknJ8MuWpIckjPyzTjidW5D4q7vtodavABDg67aNky/5meMIFETP89eBMOCDdUJZ
         S35+JDntIrkn8r9tUg02hklcAbRgdWg43GtZ7Htq1x+4s5myhYhiFgSWPxO0ImFjiih5
         qwiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=m4HG/EzZ4yDDFX9ZLe3tGPR/mp2zuB3XLszlvbX2wT0=;
        b=qJwgRfCN0TeJVLhWjAtfFcInDastyVQr5unkE0jXNvN8cqUG0C8c0GtLCQytJ/dzs/
         ZVAUpUELFdYku/fTNs7dCBq6OTuVrkUv4cPDsppuPZ7Jp6Qfe3J+VA0VSOMbX8VyunfE
         dWSgJYpf8FXz3m4KaibxtKXjdK8Wjc5xt/tuD1QFBFcxE8xnqchHywj27Bs2IQoQ2wll
         X4WEKD3cqa6r8WLRERZrkzJYuLI3ITFJSOU1Ljpv68bpPyDHngyNmR/vvlz+9Cp9c8rx
         Uqrr9Ykw2oTpTKCaaSQQzTn/KtV8jTq3cVETQjne7Y1u7sVGALoi3DorWGdiECVI67Bq
         hvog==
X-Gm-Message-State: AJIora+EAlZyNCsbMp9pO/YYVB82Tf2vvPm8ER7f2PFADnnH53DBzEVm
        qd7ABSleOGdGEdA3ueZGiFLLrRYL+0vcMQ==
X-Google-Smtp-Source: AGRyM1sv2d47ZVfrMkLu7LHO/t5v2OTCRnI1aRQaGL/3uZGV4t3oKHyq4b78ACM45jaLg2vSXdlZVw==
X-Received: by 2002:a17:902:cecc:b0:16b:da4d:7e8d with SMTP id d12-20020a170902cecc00b0016bda4d7e8dmr25287850plg.82.1657187915972;
        Thu, 07 Jul 2022 02:58:35 -0700 (PDT)
Received: from localhost ([122.171.18.80])
        by smtp.gmail.com with ESMTPSA id g29-20020aa79f1d000000b0051c4f6d2d95sm26594677pfr.106.2022.07.07.02.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 02:58:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3] cpufreq: Warn users while freeing active policy
Date:   Thu,  7 Jul 2022 15:28:31 +0530
Message-Id: <0af6e95f8da395f75c5a58363d8b1b40483252c8.1657187391.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
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

With the new design in place, the show() and store() callbacks check if
the policy is active or not before proceeding any further to avoid
potential races. And in order to guarantee that cpufreq_policy_free()
must be called after clearing the policy->cpus mask, i.e. by marking the
policy inactive.

In order to avoid introducing a bug around this later, print a warning
message if we end up freeing an active policy.

Also update cpufreq_online() a bit to make sure we clear the cpus mask
for each error case before calling cpufreq_policy_free().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V3: BUG_ON() -> pr_warn()

 drivers/cpufreq/cpufreq.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 73432360e6e9..954eef26685f 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1273,6 +1273,13 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	unsigned long flags;
 	int cpu;
 
+	/*
+	 * The callers must ensure the policy is inactive by now, to avoid any
+	 * races with show()/store() callbacks.
+	 */
+	if (unlikely(!policy_is_inactive(policy)))
+		pr_warn("%s: Freeing active policy\n", __func__);
+
 	/* Remove policy from list */
 	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	list_del(&policy->policy_list);
@@ -1527,8 +1534,6 @@ static int cpufreq_online(unsigned int cpu)
 	for_each_cpu(j, policy->real_cpus)
 		remove_cpu_dev_symlink(policy, j, get_cpu_device(j));
 
-	cpumask_clear(policy->cpus);
-
 out_offline_policy:
 	if (cpufreq_driver->offline)
 		cpufreq_driver->offline(policy);
@@ -1538,6 +1543,7 @@ static int cpufreq_online(unsigned int cpu)
 		cpufreq_driver->exit(policy);
 
 out_free_policy:
+	cpumask_clear(policy->cpus);
 	up_write(&policy->rwsem);
 
 	cpufreq_policy_free(policy);
-- 
2.31.1.272.g89b43f80a514

