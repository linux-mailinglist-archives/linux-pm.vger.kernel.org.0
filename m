Return-Path: <linux-pm+bounces-1931-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CACE882703C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 14:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BF1F232FC
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jan 2024 13:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575454597E;
	Mon,  8 Jan 2024 13:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PXdtE9dg"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E345976
	for <linux-pm@vger.kernel.org>; Mon,  8 Jan 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso21425585e9.2
        for <linux-pm@vger.kernel.org>; Mon, 08 Jan 2024 05:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704721730; x=1705326530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phTXHvJ5StdCWYZVkAY/BBaxM+ZVuOBK1aqv/JPv6kA=;
        b=PXdtE9dgZSl1dCB4NvKMYZfMAsqtWigueS8zMziEQx6w0ya342g5K6Q7U9DmbVs0bN
         HVhmFd67XSG4S9dfky91isINbA302istv2HEcpw5WabHuQqGLkwrfJ2PdVd2LCj7Tmjy
         Tj/Ai2RY6p2xdxlJThOTpphv2iHP9cneOaq4nh0FBubh46cbI/y61JiMBSj3rreF3GPf
         SjnLVNBz6aVk0ZGn/xV0UIHPSZ7VnB0q8BBHqhiCdLPs6cpGXb7RuCg6+3ZhU5UyDPMO
         a+gqcogeTud+TALHXMgIYUJ+IYAI0j/nVvl9fDzmmJdaTtIFLT8nk2T88WyZ46PHfVEb
         nngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704721730; x=1705326530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=phTXHvJ5StdCWYZVkAY/BBaxM+ZVuOBK1aqv/JPv6kA=;
        b=QomGZ9oB+LCdkS9eEypNWP2V1OrWyVdQg7a1odS0CfDUMon02opF6dYq6K9pIiJd6J
         t1zGt7mG9Elz9RdB0OsUWx4FwYjZNBbgYzmnig2qLonpma1pNOxG2GuF3Xr/hYGViayI
         jvPBBc0gEYG+EkGuf/2DnWwfxEUUiNlV/ZDD+vmhoEkRFt/2fWQNxAVufbdrV3KRIKQe
         EEwQSVrlEI2GHwRJlHIQ1VaHrs+Mn1oA2Win/+8iXvAfcW6a5i9N69XAK1BWWTW2c7M1
         D0QuTthhJh7OEuk4D7LhyG9AUitd8X8HCy8INd5s7gdwY7MeosggJtHpxTY7obpENp9n
         XUdA==
X-Gm-Message-State: AOJu0Yx9ke/cy7SKR99nCXGoNTpZGE4eg3Yo/mAxsUkcHBW83LjTH/3A
	oiDocpXcZ8Crw6gQaldClGXn9SvDAlNcYA==
X-Google-Smtp-Source: AGHT+IGZ4LJVst31jYM4bvwb4ViXf1apPYw/HzjVtWl6oMMOrmJPPZy6ZMmsc+HeVBjEWZ86bh0a5w==
X-Received: by 2002:a05:600c:3483:b0:40e:4af2:c1f with SMTP id a3-20020a05600c348300b0040e4af20c1fmr159196wmq.50.1704721729693;
        Mon, 08 Jan 2024 05:48:49 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:53aa:59bc:34ea:bb2c])
        by smtp.gmail.com with ESMTPSA id n34-20020a05600c3ba200b0040d5b984668sm11165003wms.9.2024.01.08.05.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 05:48:49 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	sudeep.holla@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	agross@kernel.org,
	andersson@kernel.org,
	konrad.dybcio@linaro.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	lukasz.luba@arm.com,
	rui.zhang@intel.com,
	mhiramat@kernel.org,
	daniel.lezcano@linaro.org,
	amit.kachhap@gmail.com,
	corbet@lwn.net,
	gregkh@linuxfoundation.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: qyousef@layalina.io,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v3 2/5] sched: Take cpufreq feedback into account
Date: Mon,  8 Jan 2024 14:48:40 +0100
Message-Id: <20240108134843.429769-3-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240108134843.429769-1-vincent.guittot@linaro.org>
References: <20240108134843.429769-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Aggregate the different pressures applied on the capacity of CPUs and
create a new function that returns the actual capacity of the CPU:
  get_actual_cpu_capacity()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
---
 kernel/sched/fair.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9cc20855dc2b..e54bbf8b4936 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4910,13 +4910,22 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	trace_sched_util_est_se_tp(&p->se);
 }
 
+static inline unsigned long get_actual_cpu_capacity(int cpu)
+{
+	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+
+	capacity -= max(thermal_load_avg(cpu_rq(cpu)), cpufreq_get_pressure(cpu));
+
+	return capacity;
+}
+
 static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_min,
 				unsigned long uclamp_max,
 				int cpu)
 {
-	unsigned long capacity_orig, capacity_orig_thermal;
 	unsigned long capacity = capacity_of(cpu);
+	unsigned long capacity_orig;
 	bool fits, uclamp_max_fits;
 
 	/*
@@ -4948,7 +4957,6 @@ static inline int util_fits_cpu(unsigned long util,
 	 * goal is to cap the task. So it's okay if it's getting less.
 	 */
 	capacity_orig = arch_scale_cpu_capacity(cpu);
-	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
 
 	/*
 	 * We want to force a task to fit a cpu as implied by uclamp_max.
@@ -5023,7 +5031,8 @@ static inline int util_fits_cpu(unsigned long util,
 	 * handle the case uclamp_min > uclamp_max.
 	 */
 	uclamp_min = min(uclamp_min, uclamp_max);
-	if (fits && (util < uclamp_min) && (uclamp_min > capacity_orig_thermal))
+	if (fits && (util < uclamp_min) &&
+	    (uclamp_min > get_actual_cpu_capacity(cpu)))
 		return -1;
 
 	return fits;
@@ -7404,7 +7413,7 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 		 * Look for the CPU with best capacity.
 		 */
 		else if (fits < 0)
-			cpu_cap = arch_scale_cpu_capacity(cpu) - thermal_load_avg(cpu_rq(cpu));
+			cpu_cap = get_actual_cpu_capacity(cpu);
 
 		/*
 		 * First, select CPU which fits better (-1 being better than 0).
@@ -7897,8 +7906,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 	struct root_domain *rd = this_rq()->rd;
 	int cpu, best_energy_cpu, target = -1;
 	int prev_fits = -1, best_fits = -1;
-	unsigned long best_thermal_cap = 0;
-	unsigned long prev_thermal_cap = 0;
+	unsigned long best_actual_cap = 0;
+	unsigned long prev_actual_cap = 0;
 	struct sched_domain *sd;
 	struct perf_domain *pd;
 	struct energy_env eenv;
@@ -7928,7 +7937,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 
 	for (; pd; pd = pd->next) {
 		unsigned long util_min = p_util_min, util_max = p_util_max;
-		unsigned long cpu_cap, cpu_thermal_cap, util;
+		unsigned long cpu_cap, cpu_actual_cap, util;
 		long prev_spare_cap = -1, max_spare_cap = -1;
 		unsigned long rq_util_min, rq_util_max;
 		unsigned long cur_delta, base_energy;
@@ -7940,18 +7949,17 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 		if (cpumask_empty(cpus))
 			continue;
 
-		/* Account thermal pressure for the energy estimation */
+		/* Account external pressure for the energy estimation */
 		cpu = cpumask_first(cpus);
-		cpu_thermal_cap = arch_scale_cpu_capacity(cpu);
-		cpu_thermal_cap -= arch_scale_thermal_pressure(cpu);
+		cpu_actual_cap = get_actual_cpu_capacity(cpu);
 
-		eenv.cpu_cap = cpu_thermal_cap;
+		eenv.cpu_cap = cpu_actual_cap;
 		eenv.pd_cap = 0;
 
 		for_each_cpu(cpu, cpus) {
 			struct rq *rq = cpu_rq(cpu);
 
-			eenv.pd_cap += cpu_thermal_cap;
+			eenv.pd_cap += cpu_actual_cap;
 
 			if (!cpumask_test_cpu(cpu, sched_domain_span(sd)))
 				continue;
@@ -8022,7 +8030,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			if (prev_delta < base_energy)
 				goto unlock;
 			prev_delta -= base_energy;
-			prev_thermal_cap = cpu_thermal_cap;
+			prev_actual_cap = cpu_actual_cap;
 			best_delta = min(best_delta, prev_delta);
 		}
 
@@ -8037,7 +8045,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			 * but best energy cpu has better capacity.
 			 */
 			if ((max_fits < 0) &&
-			    (cpu_thermal_cap <= best_thermal_cap))
+			    (cpu_actual_cap <= best_actual_cap))
 				continue;
 
 			cur_delta = compute_energy(&eenv, pd, cpus, p,
@@ -8058,14 +8066,14 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
 			best_delta = cur_delta;
 			best_energy_cpu = max_spare_cap_cpu;
 			best_fits = max_fits;
-			best_thermal_cap = cpu_thermal_cap;
+			best_actual_cap = cpu_actual_cap;
 		}
 	}
 	rcu_read_unlock();
 
 	if ((best_fits > prev_fits) ||
 	    ((best_fits > 0) && (best_delta < prev_delta)) ||
-	    ((best_fits < 0) && (best_thermal_cap > prev_thermal_cap)))
+	    ((best_fits < 0) && (best_actual_cap > prev_actual_cap)))
 		target = best_energy_cpu;
 
 	return target;
@@ -9441,8 +9449,8 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
 
 static unsigned long scale_rt_capacity(int cpu)
 {
+	unsigned long max = get_actual_cpu_capacity(cpu);
 	struct rq *rq = cpu_rq(cpu);
-	unsigned long max = arch_scale_cpu_capacity(cpu);
 	unsigned long used, free;
 	unsigned long irq;
 
@@ -9454,12 +9462,9 @@ static unsigned long scale_rt_capacity(int cpu)
 	/*
 	 * avg_rt.util_avg and avg_dl.util_avg track binary signals
 	 * (running and not running) with weights 0 and 1024 respectively.
-	 * avg_thermal.load_avg tracks thermal pressure and the weighted
-	 * average uses the actual delta max capacity(load).
 	 */
 	used = READ_ONCE(rq->avg_rt.util_avg);
 	used += READ_ONCE(rq->avg_dl.util_avg);
-	used += thermal_load_avg(rq);
 
 	if (unlikely(used >= max))
 		return 1;
-- 
2.34.1


