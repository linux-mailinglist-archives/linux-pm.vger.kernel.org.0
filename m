Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 203AE3A26DF
	for <lists+linux-pm@lfdr.de>; Thu, 10 Jun 2021 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbhFJI0T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Jun 2021 04:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbhFJI0S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Jun 2021 04:26:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A44C061574
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:24:12 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso3357692pjp.2
        for <linux-pm@vger.kernel.org>; Thu, 10 Jun 2021 01:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YORa9oPGsIte4A9SIv+iSxyTgKDWii2V9/ngG7/TXzA=;
        b=QnZSOGTFeWsKK1KHilKfDK4pafowlzadJ9TKAa+hmsV2BZzCj+/mzNGTDxGSaBhHA3
         j/7avbEiKFpACZp0062Lhq8ApmUqDHyaUNM+2SVWL6t63Mw8Jzz3JvHS46Y2baQoz7PK
         Psc3SuhhpdtfnOaufzA9UXg8V6Tk3nmeGGQiHBD2OTApscMEaeu6rDPiayIHvoXeTNkO
         OzSaPi3D8jX9cmHFu0QqCMlaONZwPocDxFUjMhN5zsfaMm9H6rzAv1z+zMDteOM3yf7A
         slwe6pRxRWJX0x+NuFPRLD7cdIvGV1p5JICgyLJVmWhKqBMx3+hd/fDo6PZ/zuvhmjqe
         wXmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YORa9oPGsIte4A9SIv+iSxyTgKDWii2V9/ngG7/TXzA=;
        b=M6L4pK3KiTgQxdZBjlqR2Zv8JAN4STmgYCeoQgO/6VDbd8aI8bRHNhCiBSRQyRgRog
         b4sXAs4+ugYBmgzWHPys4ywOorGRnC4c5lVWVc8PXQzP5JigIATN9lLDIsmmXvrdEsv5
         mG6/BCZ+ScGY8XrxlRClqsd4eW9xxBhYgJHdDpGXfD0+6DUa/L3BVTKBjQ8UfecdUCkI
         qOyhEoIFMEHaDZ2L4qXcjSKk/zPc3urb02qwqvuVSWpEGM25SXRbEC+zV4InCK8drpq2
         y33UXLy234SKDLQiyK7ROXvjazX6dQbzF9P41WjI3sxTspRPijM8is5PMVc6WdfRkiDs
         DVCw==
X-Gm-Message-State: AOAM531Vq2/2LojtItaknCThkCLv+6fygqHd6KN02uBLtGxupUjTHK3A
        WY97vmr4xQa/PaM3YMEkqRi8+bMirFQs6g==
X-Google-Smtp-Source: ABdhPJxxjxDfePUL+ZrWmGQpCfk90nF4ermMnz9VruCwJ5VOs8yvxrVVB/cZUKwaTEtxBqS7qTN70A==
X-Received: by 2002:a17:90a:8816:: with SMTP id s22mr2211669pjn.231.1623313452088;
        Thu, 10 Jun 2021 01:24:12 -0700 (PDT)
Received: from localhost ([136.185.169.128])
        by smtp.gmail.com with ESMTPSA id j2sm6913313pji.34.2021.06.10.01.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 01:24:11 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] cpufreq: cppc: Migrate to ->exit() callback instead of ->stop_cpu()
Date:   Thu, 10 Jun 2021 13:53:57 +0530
Message-Id: <07fa2077b682d026c47192507f320da5bbd4e10f.1623313323.git.viresh.kumar@linaro.org>
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

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cppc_cpufreq.c | 46 ++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index 3848b4c222e1..30a861538784 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -384,27 +384,6 @@ static int cppc_verify_policy(struct cpufreq_policy_data *policy)
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
@@ -557,6 +536,29 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
@@ -665,7 +667,7 @@ static struct cpufreq_driver cppc_cpufreq_driver = {
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

