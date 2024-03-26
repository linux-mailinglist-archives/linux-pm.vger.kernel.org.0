Return-Path: <linux-pm+bounces-5398-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF07488BD85
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 10:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B048B25150
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 09:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC626EB58;
	Tue, 26 Mar 2024 09:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTTWmi/x"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBAF6BB4E
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 09:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711444593; cv=none; b=rVOLMXcufbX3djmTLWg3U9Foi4B2ewj+WVqzxT8uOAns165SKHTvZFtQP56TJQOz2ksHttnRqZqF12/s48yFF0pFS4I7tzsoVXhoe4vFLCydRN6F9ddMRtgqkPG3hpIKr0QVZmDIYfHX0LEhtQCXd2AAyAt5K8uQjNrUNLXSOfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711444593; c=relaxed/simple;
	bh=+A3pGDGHlCvfB06rHbYDp02nhAm4PpLDNZT/uPMVXIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ep9FOPZexDS2cTPfLUS9FEKkV84R2lK7B+bWG4lqyhkqj5NUlk/as0FinpKjzqP7Xv7bKSnis8j1O6MAmRjO32LX5hlVGZHa++zjxhmEf9vk27dVFW3k91gaNeWqhMA+ZrPlp7pDCQEGBH23i7CfSU9ScSmvVl0E9R1l5VzfrKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bTTWmi/x; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d228a132acso72098931fa.0
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 02:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711444588; x=1712049388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEa7sTPJSW6I5rKhiraqApmqO1PEw1EfsKWWuLtpUqA=;
        b=bTTWmi/xLUQ4ndFAtr6g1N2PagOQT7+4+FkdOJjBPR5XjAV4OPtuTcQ56z0gcXRGBX
         YhpvsMupuiTPF08VAsgjzFVc787wZVo0MktpZBM5w4S+lyeiSNgBYC8fojJncFyx6LUe
         cBRidTkcWmXYk6hhgAlhT8doYgC4eWf74Zm6yptko9fxXRBSoCwcfKcuIQS3z6GtI9+1
         Kr1iycsH/uKNxa8eQHYWuS2SGpUAjxuGH2t99hMS3h1MH4ZNlOklR2PFCT4PHYF9IxbQ
         8QzXeH3h8V1dqBIS+CGvfNHi2obgzUhcneMGZv5zXz9lwGl1c3uGw/JuJMRyxNRLxzBc
         5bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711444588; x=1712049388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEa7sTPJSW6I5rKhiraqApmqO1PEw1EfsKWWuLtpUqA=;
        b=MLeuCGJba0WK2195g4aWVS4AzAWspvhql5o6snDJcWLRRH1r7lti//QIdVZvaC4mky
         C8e07h44h5eO5T6PjCw+sTAq/fGwCNO7kwNIQpBL/+pyOoTNUS4hAvT0EVWf5cq+XGGz
         Vjt4RVYe68HXIJ10mBZ/4uzQObRHS/mmIDmYZHTzqHnhDV0I/3dPIeJW9XgWneur8mtk
         FQf+HnC+j/mAVyuLb63FeZ1x/r7oBfDSUzChueVLpJjPrqQ/cyK4pgX+A3ScBJzzXHXB
         1ADQheGXy6PQ2Zq0ZTHv6D3E5EJJagkcJ8YfMuNZXhhjHi766L7dPZp2qD+ZG8ERU5t9
         RVnQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+l3IHU4aPXG9qGMTEgiN3PbDlyyhSaogz01kaqWwyXyOCHPIzsQ21G7Xal7Fw0B9HyI6wUUROt44DohKn7jhuSds6ewZF208=
X-Gm-Message-State: AOJu0Yyl3x4u7HA686wAS02wZpk6Wau3ogCuIF1yVe+UoJsY4XYD9vpi
	xnSW9brqf9DTUZlcDpnqI4bzgU4XaRiR7xb+sp3RkTFck7VYtfwBKJDU1mcItDM=
X-Google-Smtp-Source: AGHT+IGGf2jXiDAnhlOkuMEI4imxOyrO3PVUvWqnMnUfZ8UI9s9IA++rAw1HPl8cghXzf2aqmiMA6w==
X-Received: by 2002:a2e:88d0:0:b0:2d2:206a:2f2a with SMTP id a16-20020a2e88d0000000b002d2206a2f2amr6919353ljk.17.1711444588320;
        Tue, 26 Mar 2024 02:16:28 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:e6b6:c92e:43ff:71d7])
        by smtp.gmail.com with ESMTPSA id m15-20020adffe4f000000b0033e5c54d0d9sm11647606wrs.38.2024.03.26.02.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:16:27 -0700 (PDT)
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
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v6 5/5] sched/pelt: Remove shift of thermal clock
Date: Tue, 26 Mar 2024 10:16:16 +0100
Message-Id: <20240326091616.3696851-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326091616.3696851-1-vincent.guittot@linaro.org>
References: <20240326091616.3696851-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The optional shift of the clock used by thermal/hw load avg has been
introduced to handle case where the signal was not always a high frequency
hw signal. Now that cpufreq provides a signal for firmware and
SW pressure, we can remove this exception and always keep this PELT signal
aligned with other signals.
Mark sysctl_sched_migration_cost boot parameter as deprecated

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Qais Yousef <qyousef@layalina.io>
Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
Tested-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../admin-guide/kernel-parameters.txt          |  1 +
 kernel/sched/core.c                            |  2 +-
 kernel/sched/fair.c                            | 10 ++--------
 kernel/sched/sched.h                           | 18 ------------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index bb884c14b2f6..3f390cc5f77e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5807,6 +5807,7 @@
 			but is useful for debugging and performance tuning.
 
 	sched_thermal_decay_shift=
+			[Deprecated]
 			[KNL, SMP] Set a decay shift for scheduler thermal
 			pressure signal. Thermal pressure signal follows the
 			default decay period of other scheduler pelt
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 67a8302c3131..1a914388144a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5680,7 +5680,7 @@ void sched_tick(void)
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
+	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2cdc4c242afe..3ac17b20350a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -78,15 +78,9 @@ static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
-int sched_hw_decay_shift;
 static int __init setup_sched_thermal_decay_shift(char *str)
 {
-	int _shift = 0;
-
-	if (kstrtoint(str, 0, &_shift))
-		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");
-
-	sched_hw_decay_shift = clamp(_shift, 0, 10);
+	pr_warn("Ignoring the deprecated sched_thermal_decay_shift= option\n");
 	return 1;
 }
 __setup("sched_thermal_decay_shift=", setup_sched_thermal_decay_shift);
@@ -9371,7 +9365,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
+		  update_hw_load_avg(now, rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5d73d4612e58..35a05f95af3a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1543,24 +1543,6 @@ static inline u64 rq_clock_task(struct rq *rq)
 	return rq->clock_task;
 }
 
-/**
- * By default the decay is the default pelt decay period.
- * The decay shift can change the decay period in
- * multiples of 32.
- *  Decay shift		Decay period(ms)
- *	0			32
- *	1			64
- *	2			128
- *	3			256
- *	4			512
- */
-extern int sched_hw_decay_shift;
-
-static inline u64 rq_clock_hw(struct rq *rq)
-{
-	return rq_clock_task(rq) >> sched_hw_decay_shift;
-}
-
 static inline void rq_clock_skip_update(struct rq *rq)
 {
 	lockdep_assert_rq_held(rq);
-- 
2.34.1


