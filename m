Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62E63A92E7
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 08:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhFPGnT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 02:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhFPGnK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 02:43:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933CC061141
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:40:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id h12so1393969pfe.2
        for <linux-pm@vger.kernel.org>; Tue, 15 Jun 2021 23:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xjI9Ft4Ufb3P2xW78lRK4EZEZNp1oyWp3i4UsHjcOQ=;
        b=AaZ5K1mn3CqmF3UBf4tp5pwmUSIgZiJ2GY9eGrKPV91JA0u+SN8DMJeZc39ZH7mo5G
         rTDQuIYUJSvNepfzbvSymEQZhPeHkr4VfyKosdavqblrMSGbkHLg7bDHooR0jSL3UYQD
         gvLk4vTuQsUTmeWWca9pavgqcxXuZXD0eB5d2j/lYFmaTiwFDoEIs8fOgcn9eRXeSSDr
         Jpylt+434GLrL/4l2GPYABmT+pFmGjyU659JGlCMSmqdyy0AluezexzjLRBTPjS0SFmt
         5IMYSm8AvJUaRkvczyU5cIr1DUUJq59IdQVvZKFvQ1G8xMS3X/vYfGEaDhqInrFITye/
         7X0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xjI9Ft4Ufb3P2xW78lRK4EZEZNp1oyWp3i4UsHjcOQ=;
        b=T2/wACZklkwQwEK48Ps968S+WaNIzl1qAfDaD/c31sS43KAdc73WrXTqgxxyVr8wI2
         OpWmq5Ti7QnIrQubdhMcLnmvL9FbBPht2R8NDNyqXXNbDirkLVaaHag5Q0ULimvZbng1
         Z5wtjN5XRchdvtzVlWcnaHX5W9RtqdY4WivteGa2IjBMkkI33VAfM4rkoJKixqhW1l8q
         TaPGcS/HQqYrHxZmik4PfLuRg85MMjDcXg4NsHDD+mBtpAxmZ+UT7t2AgSfphbtaqlLo
         orkyvuaKdKpYIQ01m9DFYcy3saOb+75Mv12dRfYqwbiQNzzc/vY+fVSYw6k7D07lWN1l
         wJ2Q==
X-Gm-Message-State: AOAM532ShT7kniT7M6a/nQ1vmV6XDFrS4lee80MfowezTfhqQZTJWZVS
        CiGdzYQjdAChLQBoAbA2m9eMqg==
X-Google-Smtp-Source: ABdhPJyK/NVdHWFOUuJzT18a2fj1rPtOQzYu0mkgar9dtWJ7ktDUZd4sva1iBH2PpXZQfwXbiv2RpA==
X-Received: by 2002:a65:52c8:: with SMTP id z8mr3573567pgp.50.1623825636758;
        Tue, 15 Jun 2021 23:40:36 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id a15sm1074707pfl.100.2021.06.15.23.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 23:40:35 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Wed, 16 Jun 2021 12:10:26 +0530
Message-Id: <ff4ac68413499fa7d26e6c360d0b29785f110ff0.1623825358.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1623825358.git.viresh.kumar@linaro.org>
References: <cover.1623825358.git.viresh.kumar@linaro.org>
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
by the CPU hotplug core now and we don't really need two separate
callbacks for cpufreq drivers, i.e. stop_cpu() and exit(), as everything
can be done from the exit() callback itself.

Migrate to using the exit() callback instead of stop_cpu().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 46 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 2f769b1630c5..be4f62e2c5f1 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -182,27 +182,6 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
 	return 0;
 }
 
-static void cppc_cpufreq_stop_cpu(struct cpufreq_policy *policy)
-{
-	struct cppc_cpudata *cpu_data = policy->driver_data;
-	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
-	unsigned int cpu = policy->cpu;
-	int ret;
-
-	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
-
-	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
-	if (ret)
-		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
-			 caps->lowest_perf, cpu, ret);
-
-	/* Remove CPU node from list and free driver data for policy */
-	free_cpumask_var(cpu_data->shared_cpu_map);
-	list_del(&cpu_data->node);
-	kfree(policy->driver_data);
-	policy->driver_data = NULL;
-}
-
 /*
  * The PCC subspace describes the rate at which platform can accept commands
  * on the shared PCC channel (including READs which do not count towards freq
@@ -352,6 +331,29 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cppc_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	struct cppc_cpudata *cpu_data = policy->driver_data;
+	struct cppc_perf_caps *caps = &cpu_data->perf_caps;
+	unsigned int cpu = policy->cpu;
+	int ret;
+
+	cpu_data->perf_ctrls.desired_perf = caps->lowest_perf;
+
+	ret = cppc_set_perf(cpu, &cpu_data->perf_ctrls);
+	if (ret)
+		pr_debug("Err setting perf value:%d on CPU:%d. ret:%d\n",
+			 caps->lowest_perf, cpu, ret);
+
+	/* Remove CPU node from list and free driver data for policy */
+	free_cpumask_var(cpu_data->shared_cpu_map);
+	list_del(&cpu_data->node);
+	kfree(policy->driver_data);
+	policy->driver_data = NULL;
+
+	return 0;
+}
+
 static inline u64 get_delta(u64 t1, u64 t0)
 {
 	if (t1 > t0 || t0 > ~(u32)0)
@@ -451,7 +453,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
 	.target = cppc_cpufreq_set_target,
 	.get = cppc_cpufreq_get_rate,
 	.init = cppc_cpufreq_cpu_init,
-	.stop_cpu = cppc_cpufreq_stop_cpu,
+	.exit = cppc_cpufreq_cpu_exit,
 	.set_boost = cppc_cpufreq_set_boost,
 	.attr = cppc_cpufreq_attr,
 	.name = "cppc_cpufreq",
-- 
2.31.1.272.g89b43f80a514

