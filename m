Return-Path: <linux-pm+bounces-1533-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A6A81BAA3
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 16:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB1EB26066
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 15:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E818A58237;
	Thu, 21 Dec 2023 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CFb1oPYU"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDC458215
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 15:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3368ae75082so382200f8f.1
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 07:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172258; x=1703777058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EW4UFXmfryDRvAbEc3thu9hdl9GkSp2IgG/2/oPu1XE=;
        b=CFb1oPYUVZuKtyxsTQYDiYV7XR5OXVAgJd9Mktt1mqjEsxGfoAnARasGZcvGTEpUAZ
         TfO5HxearkFBts+C1t1eN+0xu5TAmysCFz/AIm3H7GDkPOvzmOgy0vJGyO14ERtH2HhL
         1EgMxuMsGDBFA3EPclCqW9Y1BnsT2Q9lCgNIZlSsjHje6Vz1qEg7Umi9NTAqBbizXnTJ
         kkTXbcEQdSFbxNsSW4B1AkYaoGhltwQYa5Ll8T3dZ77Yc483TOi1yNAIeWSycHHE5/Zx
         ntAdq/QKAXi2/Sz6yASwTO7BWt1pGWNjc2OaAne9MkWlQBq46ZEZG8sADaZdXixBtdYS
         Vffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172258; x=1703777058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EW4UFXmfryDRvAbEc3thu9hdl9GkSp2IgG/2/oPu1XE=;
        b=HPL96AY3G/9o1XcAGy2o8YggsVMSaqtKAliIHfcV4qoj8AkfMM4sounp02h5wm+hmN
         /mMKBS11fsfE43ANb7gQC+NUzVJIL/FByH2WvjWCJ6qYUihnIdeMT1AGRl5HmxBYA4AR
         lzmGOr4sIqJB3+3UItgAA8dWw9b8tfDu6oT+B2NmqGPMWoEgPqleOppmrkLwAjxAuw5Z
         bqj9oECJK2aMq7p4fZACW1Q0f6ri7mQInqPQbMpbEoCL65fmKhT2jNm0rlF9n50sUHx5
         kGT8UrqFzFQdRGF7H8naaC7WpL7Y22bqNQWEVKxHDKBjuCZeNfJp1HNoQBh2vf3eEN8q
         j2bg==
X-Gm-Message-State: AOJu0YxFO98s/62zlyfQL0dV9IHBh9f39E+FFpQJ5h9LSg9SRCU6ZW8+
	S6iNnsboZgttus9ytRF0J0mR4g==
X-Google-Smtp-Source: AGHT+IFV4lp3HaT2elvrC1ZEK9+aGj2nsqqaqkLI2enYvIHG+UiSLXNYY15i3mv5tv1y2IdbLT/KwQ==
X-Received: by 2002:a05:600c:3b25:b0:40c:6a61:23da with SMTP id m37-20020a05600c3b2500b0040c6a6123damr564633wms.41.1703172258515;
        Thu, 21 Dec 2023 07:24:18 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2db4:9d2a:db65:42d6])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm11466974wmo.19.2023.12.21.07.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:24:17 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: catalin.marinas@arm.com,
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
	linux@armlinux.org.uk,
	corbet@lwn.net,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 5/5] sched/pelt: Remove shift of thermal clock
Date: Thu, 21 Dec 2023 16:24:07 +0100
Message-Id: <20231221152407.436177-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221152407.436177-1-vincent.guittot@linaro.org>
References: <20231221152407.436177-1-vincent.guittot@linaro.org>
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
Mark deprecated sched_thermal_decay_shift boot parameter.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 .../admin-guide/kernel-parameters.txt          |  1 +
 kernel/sched/core.c                            |  2 +-
 kernel/sched/fair.c                            | 10 ++--------
 kernel/sched/sched.h                           | 18 ------------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 65731b060e3f..2ee15522b15d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5722,6 +5722,7 @@
 			but is useful for debugging and performance tuning.
 
 	sched_thermal_decay_shift=
+			[Deprecated]
 			[KNL, SMP] Set a decay shift for scheduler thermal
 			pressure signal. Thermal pressure signal follows the
 			default decay period of other scheduler pelt
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a6f084bdf1c5..c68e47bfd5ae 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5670,7 +5670,7 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
+	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ce0d32f441a8..16d71e764131 100644
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
@@ -9271,7 +9265,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
+		  update_hw_load_avg(now, rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 677d24202eec..6fc6718a1060 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1520,24 +1520,6 @@ static inline u64 rq_clock_task(struct rq *rq)
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


