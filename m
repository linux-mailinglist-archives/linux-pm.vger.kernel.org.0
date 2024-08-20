Return-Path: <linux-pm+bounces-12568-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEBD958C48
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B7A284073
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3D31BD00C;
	Tue, 20 Aug 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="FoFhAMWf"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD76198E75
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171723; cv=none; b=SrTQAffco0HnjU7SUIVPEYqh5dxj3Bi9ivnKVW2J30gYw6PHtNnOz6cVJQgDoCEqP/flhCwmch8ggDm8KwHNlhfcL8F8B8Ky8oNWasLOWLsZqwTi5vQdvAbRv7QiyhloDULPc/1msMF9QEfnpqC1Q0NZqacC2pNM7kuo6bxiPXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171723; c=relaxed/simple;
	bh=iywCMvLV4TtRo7p9sFYjyRIh592/LLot9ueypZVp58c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GD+ex6hp2QdFUreptapd12RdQ6t4EMIHs8jHRujthh+tUVeyGRkXFO1WEg6bCbjQhRpyUqxaXN62tiEaLY0Nlbc6PYcrJLAWqg7DmK9IipLBSQNTXGzWoRVKXXp0zKy6ju3gf2rM+TPkYwoPHK7Dssktc6FXS7Vx7GH63ffxvEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=FoFhAMWf; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42816ca797fso47308205e9.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171720; x=1724776520; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4F1WOdF23Pe6zUBd4kovJU9RvUMFw9YRtUZ0tQf1aSc=;
        b=FoFhAMWfB3718FijD5y0b0aIYk+gikZSkfUeJJ8Yu49C4AgRG8JGKeGBSFm6+wDlU5
         s9Z6BTE5bDwj4MjhuSaRWcw6meo0nk6rGoknxGWTvnXEYltGR0/T1Bh+mKwyUKRJY5mf
         HADhrMKtY3E3Xqzono+H0556XGUdoLZ5K3ntUsnX36lce/UEyTuCB24+tmRsSeZ3qDHE
         e7rplvTGfuwsDB9jjY2cDmr0GHaM5h8tW3678gRvZZpOIQGAOQYlQSSK/dOGRR3840bY
         J6bV4uJyckwa7Dl7ySRG0fMzW8rABf4YBK2LuT5AlQQlKtxxjQCzXkJvYAkw+QmzUsyc
         QVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171720; x=1724776520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4F1WOdF23Pe6zUBd4kovJU9RvUMFw9YRtUZ0tQf1aSc=;
        b=knkelqzPyX1khMPNZlAaZ/wrPWkBtPqnWPA3BX/7v2YDGlfUl0oMm2eUmhljkcLvQe
         D4alKzq+HH0CDIL/ii96QEnIJtOoR0lBUoPU9fGPc+yHNEKB12Ai96htpyHwc4p5ytA/
         QEqXHi9cJtPaVp2iEpTtqYop9kTu80VmUKFrQhXY543jBU2Bp2RQRK9m0fybt1WaEl+r
         9ISkIhGbsFU0UCze+04ZrcWMbl/ijVk8I/phV8coM9UfG2O+rdJOFRfjU8yHe1LtA8Ne
         rfA45XY+XgLv27S9OiiGaWsPjEcYpjqSaeKQw07qNLUH786Co1qEA+oQg2tEK4mahxk5
         MzGA==
X-Forwarded-Encrypted: i=1; AJvYcCUbd0ACSZe1aDn1qM+lw65Q+DswSpr1qTPbf8dSxzTUWNBVqeC86LVjAQmrxA+YGqf+ZTFy8AXW7RlYlPzK5ayxr9Tjy9fJlOw=
X-Gm-Message-State: AOJu0YyZwVi1tGb8G11K1RwUcOtt4PYJJku+Oqtdahrh7vPjvlCkykH3
	0M9xJ9bNV4UQmJllU4ubDvonByqh1GTVazXWdxeaK0JNhrgHWfSzeGoG7PgBuBo=
X-Google-Smtp-Source: AGHT+IEu45k94fu5QhYe3wBpe9rK5a5C2AuIr7eJpYJMNhrKU40wfFxlLbRCcxUSZTh9bJvNjgDxDA==
X-Received: by 2002:a5d:400d:0:b0:367:8847:5bf4 with SMTP id ffacd0b85a97d-37194317679mr9919698f8f.10.1724171720072;
        Tue, 20 Aug 2024 09:35:20 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:19 -0700 (PDT)
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
Subject: [RFC PATCH 04/16] sched/fair: Remove magic hardcoded margin in fits_capacity()
Date: Tue, 20 Aug 2024 17:35:00 +0100
Message-Id: <20240820163512.1096301-5-qyousef@layalina.io>
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

Replace hardcoded margin value in fits_capacity() with better dynamic
logic.

80% margin is a magic value that has served its purpose for now, but it
no longer fits the variety of systems that exist today. If a system is
over powered specifically, this 80% will mean we leave a lot of capacity
unused before we decide to upmigrate on HMP system.

On many systems the little cores are under powered and ability to
migrate faster away from them is desired.

Redefine misfit migration to mean the utilization threshold at which the
task would become misfit at the next load balance event assuming it
becomes an always running task.

To calculate this threshold, we use the new approximate_util_avg()
function to find out the threshold, based on arch_scale_cpu_capacity()
the task will be misfit if it continues to run for a TICK_USEC which is
our worst case scenario for when misfit migration will kick in.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/core.c  |  1 +
 kernel/sched/fair.c  | 40 ++++++++++++++++++++++++++++++++--------
 kernel/sched/sched.h |  1 +
 3 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6d35c48239be..402ee4947ef0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8266,6 +8266,7 @@ void __init sched_init(void)
 		rq->sd = NULL;
 		rq->rd = NULL;
 		rq->cpu_capacity = SCHED_CAPACITY_SCALE;
+		rq->fits_capacity_threshold = SCHED_CAPACITY_SCALE;
 		rq->balance_callback = &balance_push_callback;
 		rq->active_balance = 0;
 		rq->next_balance = jiffies;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584ec06d..e5e986af18dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -95,11 +95,15 @@ int __weak arch_asym_cpu_priority(int cpu)
 }
 
 /*
- * The margin used when comparing utilization with CPU capacity.
- *
- * (default: ~20%)
+ * fits_capacity() must ensure that a task will not be 'stuck' on a CPU with
+ * lower capacity for too long. This the threshold is the util value at which
+ * if a task becomes always busy it could miss misfit migration load balance
+ * event. So we consider a task is misfit before it reaches this point.
  */
-#define fits_capacity(cap, max)	((cap) * 1280 < (max) * 1024)
+static inline bool fits_capacity(unsigned long util, int cpu)
+{
+	return util < cpu_rq(cpu)->fits_capacity_threshold;
+}
 
 /*
  * The margin used when comparing CPU capacities.
@@ -4978,14 +4982,13 @@ static inline int util_fits_cpu(unsigned long util,
 				unsigned long uclamp_max,
 				int cpu)
 {
-	unsigned long capacity = capacity_of(cpu);
 	unsigned long capacity_orig;
 	bool fits, uclamp_max_fits;
 
 	/*
 	 * Check if the real util fits without any uclamp boost/cap applied.
 	 */
-	fits = fits_capacity(util, capacity);
+	fits = fits_capacity(util, cpu);
 
 	if (!uclamp_is_used())
 		return fits;
@@ -9592,12 +9595,33 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
 {
 	unsigned long capacity = scale_rt_capacity(cpu);
 	struct sched_group *sdg = sd->groups;
+	struct rq *rq = cpu_rq(cpu);
+	u64 limit;
 
 	if (!capacity)
 		capacity = 1;
 
-	cpu_rq(cpu)->cpu_capacity = capacity;
-	trace_sched_cpu_capacity_tp(cpu_rq(cpu));
+	rq->cpu_capacity = capacity;
+	trace_sched_cpu_capacity_tp(rq);
+
+	/*
+	 * Calculate the util at which the task must be considered a misfit.
+	 *
+	 * We must ensure that a task experiences the same ramp-up time to
+	 * reach max performance point of the system regardless of the CPU it
+	 * is running on (due to invariance, time will stretch and task will
+	 * take longer to achieve the same util value compared to a task
+	 * running on a big CPU) and a delay in misfit migration which depends
+	 * on TICK doesn't end up hurting it as it can happen after we would
+	 * have crossed this threshold.
+	 *
+	 * To ensure that invaraince is taken into account, we don't scale time
+	 * and use it as-is, approximate_util_avg() will then let us know the
+	 * our threshold.
+	 */
+	limit = approximate_runtime(arch_scale_cpu_capacity(cpu)) * USEC_PER_MSEC;
+	limit -= TICK_USEC; /* sd->balance_interval is more accurate */
+	rq->fits_capacity_threshold = approximate_util_avg(0, limit);
 
 	sdg->sgc->capacity = capacity;
 	sdg->sgc->min_capacity = capacity;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47f158b2cdc2..ab4672675b84 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1093,6 +1093,7 @@ struct rq {
 	struct sched_domain __rcu	*sd;
 
 	unsigned long		cpu_capacity;
+	unsigned long		fits_capacity_threshold;
 
 	struct balance_callback *balance_callback;
 
-- 
2.34.1


