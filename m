Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CEB3B12CD
	for <lists+linux-pm@lfdr.de>; Wed, 23 Jun 2021 06:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbhFWE1Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Jun 2021 00:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbhFWE1W (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jun 2021 00:27:22 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEADFC06175F
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i6so1323229pfq.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EPOEQ7pRTnNWs9xaNPcoV7k6Yz2O7yBdc0WvhyMJhVY=;
        b=b8ZR4og0732gAR3c1QYoPDfJ0QOfR/MZV3Znls5zMiLv1QapescQpW0mD0cXuEw5Y+
         3ryskYMHsIw99NYuadcF4O8zZpYOnknde2t3RqK3gw6O00rMiPD5u6zLv9ZPRTnmPtqS
         QaibiMZ53wEa0Jnl4UvoisAz+Mq2Sd/rYN+VPqYLh+AeOXqhwxYhgYlhJ/KIAbBLM2u/
         RWaqb4dhS1RkSbnBFmzrpXoZteqOa4XE8SvRzjqKDRyngP1oIPE3ybe5u+9TezGMdJET
         G/83PxfoCv7PcITInYuigzvIk8yHyiE9S5Cp0CbNDM2i6M9FELfdjrys21Wt+7pVpMRy
         9m9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EPOEQ7pRTnNWs9xaNPcoV7k6Yz2O7yBdc0WvhyMJhVY=;
        b=kD/5pkqT8Y8a25gudn1tZO+rmWvRIQ+9J7AiEyW4yepkHOPZweVBXP/nJ/HhhZI3av
         nDSRIHeMKU5rrWiak8XN4RKMjmnYwgD14U7UmUI4o0N0UKB2So9jqvbJDguu+NvzFUG+
         ws3NzCcCRKId0DGWduS/+1sTyXbirPTuOu2gyAfqoZqy+z2yGIB9hZ+vc75bzhfVgfXr
         TkikdVz9gDPNK06abzyuyWXeUBDgP+A8gaAYNbsc3j1XzqrkegQ4vhPXI8FTYcZD6ncn
         KfJ7kodcBS8v+PENn9N/HDxGFl/d92xn/icGG2f0URQyLrRLn3jobag/tDgvtUIV8OxJ
         Zk9Q==
X-Gm-Message-State: AOAM530HCiMnBGYnnqjXGlApkPBAnkGpxivaT5i+KRwiWtTthMWCfnR6
        rxogQuUGtu0+lgr63DhT6omzeQ==
X-Google-Smtp-Source: ABdhPJwtaLYPkAkke/7GDdYEPqEd+You7RszJVPaWQ98zJu6S3iWxjde5O/SpattSp4ZGVHE9cqODQ==
X-Received: by 2002:aa7:954c:0:b029:2f5:33fc:1073 with SMTP id w12-20020aa7954c0000b02902f533fc1073mr6933781pfq.79.1624422301480;
        Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id v3sm802496pfb.126.2021.06.22.21.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:25:01 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/4] cpufreq: intel_pstate: Migrate to ->offline() instead of ->stop_cpu()
Date:   Wed, 23 Jun 2021 09:54:40 +0530
Message-Id: <6144911f36d3d1f5faddf81d744bd39946843f6b.1624421816.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1624421816.git.viresh.kumar@linaro.org>
References: <cover.1624421816.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state can't be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need to separately
call stop_cpu() for cpufreq drivers.

Migrate to using the offline() callbacks instead of stop_cpu().

Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e69dffd5a76..b4c0ff7f5b71 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 
 	pr_debug("CPU %d going offline\n", cpu->cpu);
 
+	intel_pstate_clear_update_util_hook(policy->cpu);
+
 	if (cpu->suspended)
 		return 0;
 
@@ -2374,13 +2376,6 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
 	return 0;
 }
 
-static void intel_pstate_stop_cpu(struct cpufreq_policy *policy)
-{
-	pr_debug("CPU %d stopping\n", policy->cpu);
-
-	intel_pstate_clear_update_util_hook(policy->cpu);
-}
-
 static int intel_pstate_cpu_exit(struct cpufreq_policy *policy)
 {
 	pr_debug("CPU %d exiting\n", policy->cpu);
@@ -2451,7 +2446,6 @@ static struct cpufreq_driver intel_pstate = {
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
-- 
2.31.1.272.g89b43f80a514

