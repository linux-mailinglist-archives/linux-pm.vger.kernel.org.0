Return-Path: <linux-pm+bounces-12569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA783958C4A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 723E62836D6
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51321BF303;
	Tue, 20 Aug 2024 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="ZN42eiHZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92411BB69B
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171724; cv=none; b=kHuozDGZ40AudJcUGWXvAaJ/+ZggqiXfp3Xp0n3h8x0HGwu8lwnn9sinBX1Z4QqPocKiCp1czQVoUFr6Xa7aQZshKQdZe48Y4I26tBBzn9iRUoI+mYeQOVafbn7U3CL/C6WJsIQ8QfJXCugyRcJ/acH0aJJnt1QCK4lr7udCyLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171724; c=relaxed/simple;
	bh=ZmhmvAh2ezCJJ4PmFxbu0s4/c7f7Y3hO+tlLfSwsztc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I3WjMi6crSLzFoD7A3kpO4INtRVqmJ4ykGtxQviyBg4Z1IKuAFsqW5ZrKF3BVpga7DxApmMojXTql8Fg5fopmGJl49rvT8I7r8uK9tFmqemTXIQcfyBU6XYhRa5g6dR4LgMORVmrb1deyhDgz9rGUFkSceWajjhtGH5dSDe+WmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=ZN42eiHZ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a7abe5aa9d5so615137766b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171721; x=1724776521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xQ1DK2daPE9ncuhHLypAOQVYnkEU114ByewzWSw0TA4=;
        b=ZN42eiHZCPvTwREOEJqJbGsuizb3xhvMQU+MZwMM7zwdpGQXJPR6SZZfQc6p3D/mN9
         OBtJ23dNwC5DWwNJpmSbUXMusS5vccpj7YQVygqKPqeiXdhZCn6gccNgy+Gsbjf9j3+2
         cZr7ggSGTuB73fANZfHQXOmh7FiwA/eHPo6fXHEpu35ASUbEC6aqWRzlXNeo80nRJ6To
         RXOcI+E/vyHC7ycySs3+7f5fDKDj9NTqZ47GICpek8hUBtP3p9vP67+UURg1Eq+ZT+EW
         3KNhD8the0zCN95BVUUf05GwYDBQ2KWn4kkjDTFQLurhYDTtbS/ZqF54VpcpbRIAxth/
         kq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171721; x=1724776521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ1DK2daPE9ncuhHLypAOQVYnkEU114ByewzWSw0TA4=;
        b=T8uQqp29Q5xQqDf3C9RBKPYS7fr9EwzJsd9alUzgCpBY/9Kf063EBojNQ5olWuYMsg
         i+PRGurcOLgBuaDlEJWrIf4CA2GPkx1A18UrswauBj9rGP3UTPVQPTXWaXDwE4XdvIBV
         wxDWEZjoSmmuhWr+/0g7iGwEyZpOUCmBrEnua+X407mbZefEVQCKD6IVUXXGHRfxuQbc
         gn+w+iSSF/v2FGbH7bROQwWv+jm3aue7zW0E2+9o5kURnA8ju5YKQavthqQe64nW50JI
         oFXM2YLzHS82XRTtfw29IRPPzacwfiyXDUq9uFSG2voQX+kL39ROeITo8H/6vxfz11xI
         /zsw==
X-Forwarded-Encrypted: i=1; AJvYcCXuLXYeag8s68FlQKDNcs2dW2Qsn+oJwsEfS9R04NHw6GcEAjw2fBIzPnPyxOZR1Qp/h2rpNMrUaQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/5pe3FRNTBd0RJiG1gWlKYrSwYXpoilbYyGfsyuDsauaNYApQ
	rem9kbTsZjmnm8eyqzJelMD/GH6AO0mh6LWm39syJA+oGI6in/MV40bgTjTgKAQ=
X-Google-Smtp-Source: AGHT+IGJIEiqfLHFXG+Ko/nMDgS5J7g2UwUVQhLX/Pve1qWCglcSM9ewImEX+qVu2VF8smMRoWdXuQ==
X-Received: by 2002:a17:907:72cb:b0:a6f:27e6:8892 with SMTP id a640c23a62f3a-a8392a38c8dmr1018867866b.60.1724171720898;
        Tue, 20 Aug 2024 09:35:20 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:20 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 05/16] sched: cpufreq: Remove magic 1.25 headroom from sugov_apply_dvfs_headroom()
Date: Tue, 20 Aug 2024 17:35:01 +0100
Message-Id: <20240820163512.1096301-6-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace 1.25 headroom in sugov_apply_dvfs_headroom() with better dynamic
logic.

Instead of the magical 1.25 headroom, use the new approximate_util_avg()
to provide headroom based on the dvfs_update_delay, which is the period
at which the cpufreq governor will send DVFS updates to the hardware, or
min(curr.se.slice, TICK_USEC) which is the max delay for util signal to
change and promote a cpufreq update; whichever is higher.

Add a new percpu dvfs_update_delay that can be cheaply accessed whenever
sugov_apply_dvfs_headroom() is called. We expect cpufreq governors that
rely on util to drive its DVFS logic/algorithm to populate these percpu
variables. schedutil is the only such governor at the moment.

The behavior of schedutil will change. Some systems will experience
faster dvfs rampup (because of higher TICK or rate_limit_us), others
will experience slower rampup.

The impact on performance should not be visible if not for the black
hole effect of utilization invariance. A problem that will be addressed
in later patches.

Later patches will also address how to provide better control of how
fast or slow the system should respond to allow userspace to select
their power/perf/thermal trade-off.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c              |  1 +
 kernel/sched/cpufreq_schedutil.c | 36 ++++++++++++++++++++++++++------
 kernel/sched/sched.h             |  9 ++++++++
 3 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 402ee4947ef0..7099e40cc8bd 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -118,6 +118,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
 
 #ifdef CONFIG_SCHED_DEBUG
 /*
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 575df3599813..303b0ab227e7 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -187,13 +187,28 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * to run at adequate performance point.
  *
  * This function provides enough headroom to provide adequate performance
- * assuming the CPU continues to be busy.
+ * assuming the CPU continues to be busy. This headroom is based on the
+ * dvfs_update_delay of the cpufreq governor or min(curr.se.slice, TICK_US),
+ * whichever is higher.
  *
- * At the moment it is a constant multiplication with 1.25.
+ * XXX: Should we provide headroom when the util is decaying?
  */
-static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
+static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
 {
-	return util + (util >> 2);
+	struct rq *rq = cpu_rq(cpu);
+	u64 delay;
+
+	/*
+	 * What is the possible worst case scenario for updating util_avg, ctx
+	 * switch or TICK?
+	 */
+	if (rq->cfs.h_nr_running > 1)
+		delay = min(rq->curr->se.slice/1000, TICK_USEC);
+	else
+		delay = TICK_USEC;
+	delay = max(delay, per_cpu(dvfs_update_delay, cpu));
+
+	return approximate_util_avg(util, delay);
 }
 
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
@@ -201,7 +216,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = sugov_apply_dvfs_headroom(actual);
+	actual = sugov_apply_dvfs_headroom(actual, cpu);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
@@ -579,15 +594,21 @@ rate_limit_us_store(struct gov_attr_set *attr_set, const char *buf, size_t count
 	struct sugov_tunables *tunables = to_sugov_tunables(attr_set);
 	struct sugov_policy *sg_policy;
 	unsigned int rate_limit_us;
+	int cpu;
 
 	if (kstrtouint(buf, 10, &rate_limit_us))
 		return -EINVAL;
 
 	tunables->rate_limit_us = rate_limit_us;
 
-	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook)
+	list_for_each_entry(sg_policy, &attr_set->policy_list, tunables_hook) {
+
 		sg_policy->freq_update_delay_ns = rate_limit_us * NSEC_PER_USEC;
 
+		for_each_cpu(cpu, sg_policy->policy->cpus)
+			per_cpu(dvfs_update_delay, cpu) = rate_limit_us;
+	}
+
 	return count;
 }
 
@@ -868,6 +889,9 @@ static int sugov_start(struct cpufreq_policy *policy)
 		memset(sg_cpu, 0, sizeof(*sg_cpu));
 		sg_cpu->cpu = cpu;
 		sg_cpu->sg_policy = sg_policy;
+
+		per_cpu(dvfs_update_delay, cpu) = sg_policy->tunables->rate_limit_us;
+
 		cpufreq_add_update_util_hook(cpu, &sg_cpu->update_util, uu);
 	}
 	return 0;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ab4672675b84..c2d9fba6ea7a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3068,6 +3068,15 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
 u64 approximate_runtime(unsigned long util);
 
+/*
+ * Any governor that relies on util signal to drive DVFS, must populate these
+ * percpu dvfs_update_delay variables.
+ *
+ * It should describe the rate/delay at which the governor sends DVFS freq
+ * update to the hardware in us.
+ */
+DECLARE_PER_CPU_READ_MOSTLY(u64, dvfs_update_delay);
+
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
  * CPU original capacity and the runtime/deadline ratio of the task.
-- 
2.34.1


