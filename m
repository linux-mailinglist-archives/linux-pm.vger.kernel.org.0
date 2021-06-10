Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1330B3A26DE
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbhFJI0M (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJI0K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 04:26:10 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4098FC0617A6
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:24:15 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id e20so10050453pgg.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=e7B2ZK+wpxF4j3+qmLEZ4xXUKjyuONFX7C0C6Hmnb+s=;
        b=SvT3rRWlPJYK+5pRZfIdOS69PuLDlN+vLemcMKfxfEvZPAvgBg0a+oLjqkS0ZNb4XW
         /Tt2KQcPvnAsKzk5qOBYPfBNvR1ujyESsRd1uXJcSZe0hbF4DpgGYlS1EDIMUakxPvFL
         dXwaR1ygCUrSG9n0HfokdqT3TU6sNjot3TjJQmr4biXPxAL1PxHFtYU+SNED5ThZejmn
         Hc/UqMk/oju36bDipalENDyOQr504hK1fcQ6hruwr8P0hIb6/rPvDHzoeCVxKMXz1607
         W70h2N4N/qRObY9w9kdB4xLgLEYF7eoUAjx9g2Utl6h8SUf01655cTr2peUgp0I8g0D3
         CtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=e7B2ZK+wpxF4j3+qmLEZ4xXUKjyuONFX7C0C6Hmnb+s=;
        b=jamDZvaAYK56Ker/DYZpz9njKdvFjm27Sfs4btLGdm9WHdHjjLzDpJmofw+kL2mMOq
         iqGPwkP9mlVQnwmsSrsDSQ2jwz1gUDujm8qJAR6AfbWn+OO1B69M/tpNiZD0PyNlIMc6
         +VGGXdF8u7hti8iqflrf6owqhspRRYNSDTmeAAmAfNcELkyLjAYCj0Np82v7YXivXHb1
         b+HUT3OCjuMX82saopJ/Ccwm2Gs5UcUnrC170acZPHhVpAg/0YsP1s7S8174WhaGt/Fg
         DrxnmXKdh6Adze8OUpr0+OJFjYEluhcCd6lAdMxxgcDu0Oj3obqmsPhAi7lCvjHR5ugC
         W+Ug==
X-Gm-Message-State: AOAM530erWDlHFmcOpdVTW/H6MF7Y32DLhsvjGyyrfXvmThB4qvgwXA8
        mmn4fzPimkKCLY0Cw++l0QV7Sg==
X-Google-Smtp-Source: ABdhPJzKh6+W053F1SeGZVSKhG/Yk7QkfyteBY515xdU6z0An8lnFQKYZdkfj8hrGzdGcn/EnZI+iQ==
X-Received: by 2002:a62:804b:0:b029:2e9:c897:aa7c with SMTP id j72-20020a62804b0000b02902e9c897aa7cmr1904664pfd.12.1623313454836;
        Thu, 10 Jun 2021 01:24:14 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id m1sm1863638pfb.14.2021.06.10.01.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:14 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dirk Brandewie <dirk.j.brandewie@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] cpufreq: intel_pstate: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Thu, 10 Jun 2021 13:53:58 +0530
Message-Id: <eb57f99bcd87ab4cb5971060fff57c3ee19ffbc3.1623313323.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623313323.git.viresh.kumar@linaro.org>
References: <cover.1623313323.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

commit 367dc4aa932b ("cpufreq: Add stop CPU callback to cpufreq_driver
interface") added the stop_cpu() callback to allow the drivers to do
clean up before the CPU is completely down and its state cannot be
modified.

At that time the CPU hotplug framework used to call the cpufreq core's
registered notifier for different events like CPU_DOWN_PREPARE and
CPU_POST_DEAD. The stop_cpu() callback was called during the
CPU_DOWN_PREPARE event.

This is no longer the case, cpuhp_cpufreq_offline() is called only once
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

Cc: Dirk Brandewie <dirk.j.brandewie@intel.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index f0401064d7aa..9d3191663925 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2374,17 +2374,11 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
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
 
+	intel_pstate_clear_update_util_hook(policy->cpu);
 	policy->fast_switch_possible = false;
 
 	return 0;
@@ -2451,7 +2445,6 @@ static struct cpufreq_driver intel_pstate = {
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
-- 
2.31.1.272.g89b43f80a514

