Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1045B1C9901
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 20:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEGSKY (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 14:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728073AbgEGSKX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 14:10:23 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFA9C05BD09
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 11:10:22 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d35so7690953qtc.20
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 11:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Vd0pNAUBaJ0yRt8OlUay21+ov1Ee3dhw97h0rn0JWzA=;
        b=PGi9JzC7BfRAuyN68vDloXznBqkKjDAhneADm5FudbrS4uv7r6kbQzRzv/pHSIZoMw
         NtiDu0RkmlxflfT2SJq0LixZXAcQCJ0qj22zqjD+SQpKVh58JFZ9ZS92Dsck3iDc+Dl7
         s3E9uXSeRVa05+lLjb1M8OURbGdLy1lVqSgW0bQx5fm5Flhj7D4Xp8PdU5ruoSl271IE
         HLJqxU8UxYNeZ6vD+KZFXRx8oG3+OfDFxpzQc2MsMsff3wqOD4nuA4AWC0Y3DpRwKpsZ
         bJuEpiY+mf33+b06GwFin3o0YSJ9WV7xFkaUIqA1JzXutPno6QGi6l2lYmUIKC/Rr4X7
         j/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Vd0pNAUBaJ0yRt8OlUay21+ov1Ee3dhw97h0rn0JWzA=;
        b=BuIP8/KRCYS34F7xfRMZiAT9gasJ9FjEuv5ghY3ww8Z3Ae80f3t3D3n62FzpIx00hR
         rv5iAwMpCsJkF3O8hCjTVOLpsyN8vkeIWwhAsQjngtreq30J1PO/UWffPbkatfwZs5AB
         dLfgeKp8tp0rF+Al+bJIyU8rIs5C3op2Olc0293GCBC3FQC4XR7joFoo/bGPvH2/KfAO
         LmBGlfvw38ThG4EO3XjePbqcptuGQ5cSiX7QbYbMDGl1GV/yy9QDj/pAfD4oxgk2XtXE
         CkLEfXbx6k8Ra7k4TE1sOScmuBzZPCHiipEx1T+HZl06Z/W8Opa5+8l1JwgglOq3TDku
         RvEQ==
X-Gm-Message-State: AGi0Pua+qTm8sZ/zTKDcPu5AInSBbEuzRDlodGj6YKqRul3+dVbxPjEJ
        oQ/Q/9m+2zBfThFZ+P4NHchBd+g0ZUT+
X-Google-Smtp-Source: APiQypJ4asbJxd94fD3uQEhG1rWXpEeC3AokhHXEV9JcZ9jvjhTmwjtKJgFl4//ydqHlMQWqlkiT0Sn2NmAE
X-Received: by 2002:a05:6214:158b:: with SMTP id m11mr14638091qvw.168.1588875021708;
 Thu, 07 May 2020 11:10:21 -0700 (PDT)
Date:   Thu,  7 May 2020 19:10:01 +0100
In-Reply-To: <20200507181012.29791-1-qperret@google.com>
Message-Id: <20200507181012.29791-4-qperret@google.com>
Mime-Version: 1.0
References: <20200507181012.29791-1-qperret@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 03/14] sched: cpufreq: Introduce 'want_eas' governor flag
From:   Quentin Perret <qperret@google.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com, qperret@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The EAS topology code requires the usage of schedutil on all CPUs of an
rd to actually enable EAS balancing. However, the check implementing
this references the schedutil_gov struct directly, which makes having
schedutil as a module impractical.

To prepare the ground for this modularization, introduce a new
'want_eas' flag in the cpufreq_governor struct, set it for schedutil
only, and make sure to check it from the EAS topology code.

Signed-off-by: Quentin Perret <qperret@google.com>
---
 include/linux/cpufreq.h          |  4 ++++
 kernel/sched/cpufreq_schedutil.c |  5 ++++-
 kernel/sched/topology.c          | 12 ++++++------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index f7240251a949..267cc3b624da 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -560,6 +560,10 @@ struct cpufreq_governor {
 	bool			dynamic_switching;
 	struct list_head	governor_list;
 	struct module		*owner;
+
+#ifdef CONFIG_ENERGY_MODEL
+	bool			want_eas;
+#endif /* CONFIG_ENERGY_MODEL */
 };
 
 /* Pass a target to the cpufreq driver */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index ebd5d30f0861..c5e5045f7c81 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -888,6 +888,9 @@ struct cpufreq_governor schedutil_gov = {
 	.start			= sugov_start,
 	.stop			= sugov_stop,
 	.limits			= sugov_limits,
+#ifdef CONFIG_ENERGY_MODEL
+	.want_eas		= true,
+#endif /* CONFIG_ENERGY_MODEL */
 };
 
 #ifdef CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL
@@ -924,7 +927,7 @@ static DECLARE_WORK(rebuild_sd_work, rebuild_sd_workfn);
 void sched_cpufreq_governor_change(struct cpufreq_policy *policy,
 				  struct cpufreq_governor *old_gov)
 {
-	if (old_gov == &schedutil_gov || policy->governor == &schedutil_gov) {
+	if ((old_gov && old_gov->want_eas) || policy->governor->want_eas) {
 		/*
 		 * When called from the cpufreq_register_driver() path, the
 		 * cpu_hotplug_lock is already held, so use a work item to
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8344757bba6e..b905f2e8d9b2 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -319,7 +319,8 @@ static void sched_energy_set(bool has_eas)
  *    2. the SD_ASYM_CPUCAPACITY flag is set in the sched_domain hierarchy.
  *    3. no SMT is detected.
  *    4. the EM complexity is low enough to keep scheduling overheads low;
- *    5. schedutil is driving the frequency of all CPUs of the rd;
+ *    5. an EAS-compatible CPUfreq governor (schedutil) is driving the frequency
+ *       of all CPUs of the rd;
  *
  * The complexity of the Energy Model is defined as:
  *
@@ -339,7 +340,6 @@ static void sched_energy_set(bool has_eas)
  */
 #define EM_MAX_COMPLEXITY 2048
 
-extern struct cpufreq_governor schedutil_gov;
 static bool build_perf_domains(const struct cpumask *cpu_map)
 {
 	int i, nr_pd = 0, nr_cs = 0, nr_cpus = cpumask_weight(cpu_map);
@@ -347,7 +347,7 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 	int cpu = cpumask_first(cpu_map);
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 	struct cpufreq_policy *policy;
-	struct cpufreq_governor *gov;
+	bool want_eas;
 
 	if (!sysctl_sched_energy_aware)
 		goto free;
@@ -377,11 +377,11 @@ static bool build_perf_domains(const struct cpumask *cpu_map)
 		policy = cpufreq_cpu_get(i);
 		if (!policy)
 			goto free;
-		gov = policy->governor;
+		want_eas = policy->governor && policy->governor->want_eas;
 		cpufreq_cpu_put(policy);
-		if (gov != &schedutil_gov) {
+		if (!want_eas) {
 			if (rd->pd)
-				pr_warn("rd %*pbl: Disabling EAS, schedutil is mandatory\n",
+				pr_warn("rd %*pbl: Disabling EAS because of incompatible CPUFreq governor\n",
 						cpumask_pr_args(cpu_map));
 			goto free;
 		}
-- 
2.26.2.526.g744177e7f7-goog

