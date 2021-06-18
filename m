Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4113AC144
	for <lists+linux-pm@lfdr.de>; Fri, 18 Jun 2021 05:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbhFRDYv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 17 Jun 2021 23:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbhFRDYu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Jun 2021 23:24:50 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4890DC061574
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 20:22:41 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m17so791524plx.7
        for <linux-pm@vger.kernel.org>; Thu, 17 Jun 2021 20:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MqSK1zOymUxxq/T/RdAPgHK3/+Z9VBscAJFGiuft+WE=;
        b=jP8eVoUmuigO/jQApq8Ze876NJSFHzAqT6HwtfW8AAg9FbfPQhrfV2TZCkRyjjH5HO
         WicCMQs4wDMQWSlcOJYGarpinR3uniubQcC2kDvhsPKihq7qtzppn6+s+1uxTZCGiQbl
         G+ahlp5ARFwSHmojJKhhWbaV9sRfAXxmQ069tTJQ8YIMC/c7dzy5w4i0W1HUDA4YJ3Wj
         A+ffuYVHlur3Ui8R0FAtJz60rMGB1DbnjbhhK3ZmYaMEDb8bRKrj5FM+XGpSZgIgVTI7
         rHhx85acp5Oq2bhRacLWgBfbgMun3tBf3cvoCT+ocKOQj8CSzbLxgncrxmvPlvmwNm4q
         9rPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqSK1zOymUxxq/T/RdAPgHK3/+Z9VBscAJFGiuft+WE=;
        b=VdhAx6fCUylYSgtToElc3cmmFv94ppKSMHSws2a8JEyZorH0LRMS3Pf1dwE7A70lLc
         iZ1oojOluD1qRZHIfMXHR781XmMNNMZuGEyx+40GbFxfVJJXsWEUJmqjAOq49EaIPeqN
         ufSQwcfDGelDqxhI47SFlzi2yli3dmf1h53/vhmdIbyPiUuTFYgAmN6AWrbdTyVzLyK4
         Zxw1l8vjRsOMlN7/LqtNmXt1vbzP1LwjZHUDl1myUHliLoBgpkxE6pEW5VHNsdBCtLVZ
         GcYgF6kbPpUsq5vsV5AvGZNv1sYgEkxMdu/CFIW5g4r+6ubYLdcLdrg0BkcBCUt7B5ZX
         MsGQ==
X-Gm-Message-State: AOAM5332F5RQfqj2WtxyWmLRen7pVBQnibyL6cyudllukdQWhRZU/6Q0
        qYroCeNneoScPDvdk0X7OzzWTA==
X-Google-Smtp-Source: ABdhPJxFthx1OT3wNaOe0+vA6MHe5CsoJnedW2rlLxOtLtzEfVgMYU4fUDUXA2YPPC72o9ZMNGPhJw==
X-Received: by 2002:a17:90a:f0c2:: with SMTP id fa2mr7498294pjb.191.1623986560775;
        Thu, 17 Jun 2021 20:22:40 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id 23sm6122897pjw.28.2021.06.17.20.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 20:22:40 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dirk Brandewie <dirk.brandewie@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/3] cpufreq: intel_pstate: Migrate away from ->stop_cpu() callback
Date:   Fri, 18 Jun 2021 08:52:36 +0530
Message-Id: <c31424b7962608eb13f946a665ba6848c4986856.1623986349.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
References: <5c8da9d378dee39d9c6063713b093f51d271fa9d.1623825358.git.viresh.kumar@linaro.org>
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

Migrate to using the exit() and offline() callbacks instead of
stop_cpu().

We need to clear util hook from both the callbacks, exit() and
offline(), since it is possible that only exit() gets called sometimes
(specially on errors) or both get called at other times.
intel_pstate_clear_update_util_hook() anyway have enough protection in
place if it gets called a second time and will return early then.

Cc: Dirk Brandewie <dirk.brandewie@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2->V3:
- Update intel_pstate_cpu_offline() as well.
- Improved commit log.

 drivers/cpufreq/intel_pstate.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 0e69dffd5a76..8f8a2d9d7daa 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2335,6 +2335,8 @@ static int intel_pstate_cpu_offline(struct cpufreq_policy *policy)
 
 	pr_debug("CPU %d going offline\n", cpu->cpu);
 
+	intel_pstate_clear_update_util_hook(policy->cpu);
+
 	if (cpu->suspended)
 		return 0;
 
@@ -2374,17 +2376,12 @@ static int intel_pstate_cpu_online(struct cpufreq_policy *policy)
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
+
 	policy->fast_switch_possible = false;
 
 	return 0;
@@ -2451,7 +2448,6 @@ static struct cpufreq_driver intel_pstate = {
 	.resume		= intel_pstate_resume,
 	.init		= intel_pstate_cpu_init,
 	.exit		= intel_pstate_cpu_exit,
-	.stop_cpu	= intel_pstate_stop_cpu,
 	.offline	= intel_pstate_cpu_offline,
 	.online		= intel_pstate_cpu_online,
 	.update_limits	= intel_pstate_update_limits,
-- 
2.31.1.272.g89b43f80a514

