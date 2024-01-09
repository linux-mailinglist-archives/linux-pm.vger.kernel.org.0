Return-Path: <linux-pm+bounces-2011-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2882E828A5F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 17:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295431C24AFA
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jan 2024 16:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98873A8DB;
	Tue,  9 Jan 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1649ycS"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04433BB27
	for <linux-pm@vger.kernel.org>; Tue,  9 Jan 2024 16:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3376d424a79so1678793f8f.1
        for <linux-pm@vger.kernel.org>; Tue, 09 Jan 2024 08:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704818827; x=1705423627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUNENfX24A37uKXzgL32igc38T3KBUOtvdr56h+2ocw=;
        b=L1649ycSPbxB6I8AZmgZ6W3q2XDcq+nVWRMaNDiPwqpz1fTCbYT2k9kHpGnj2JFhb4
         HxSjaIJ2ZnhrOhUDaF0EvAJxKUj92HrhNleSPKCxZu+mlGfDGoACVSyOa2pMXF7vEl7+
         LfCl19xeIVZGnmKWKWGIoBDDhHurkLXTvf7jSICz/zJorBkWMmmWW0oAIwtitpPTxTmz
         PxPaqUvDBr/NvjvZ1Z4XxoS6Kql0433q5u3JYiu5ubjrqGYc0dPrlQiOOAqjTdOqpIZC
         VGw36ljS5FbeQpVni1wxUTPa91Muqjxls2fiyK3vsaMRWmStHzyw+enumj9UQutAzzgV
         zoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704818827; x=1705423627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUNENfX24A37uKXzgL32igc38T3KBUOtvdr56h+2ocw=;
        b=mvQ1N2tWH8dDk2nLS9XPqg8ohRDaRu/N3TpHIaHkvUnH9tg3UxTPGCLuxjnonqyhCX
         jW4bj5uUCb7zTkc80qjNCoKLS5ezvmmmMGlsadGGJCOv6YfOB/OyFM+kJr6HMAQWlpCp
         0vLG4tKYXwsNHi9150SJuluz1dYI1DtHSrUR8f1fMe6QZ48dWptrbpx3RUZS60Smd6Xt
         SFJ9Z2B417DF2bTfirpHpu1teu2PLUgHUP8V8y5r0tb8zDKJ/e++X/jIUBRYLkkrbRWw
         AyxR5ArAX0BbMMAQPBynrkKTrcM4VhQi6oxo1KliXO+GCUVVRrWzcW9ki9XaHzM08oqF
         EkJA==
X-Gm-Message-State: AOJu0YzVgBi1iFztaOs5zbHXlkewdP6BVwddKcs2Opn1bJnT2yzjG2tj
	9QURG2CbQLgc0KiUMsEiTM4WAp2h/wkmjA==
X-Google-Smtp-Source: AGHT+IHftbvboN5ELqVOpFEPFxK0DVVlPwVl6dJVolSY7UAcnlG9aTp/c6KD84FzE6qW3hO59lZ0vw==
X-Received: by 2002:a5d:598c:0:b0:336:8657:60df with SMTP id n12-20020a5d598c000000b00336865760dfmr962148wri.79.1704818827235;
        Tue, 09 Jan 2024 08:47:07 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:378:51f6:d46e:8457])
        by smtp.gmail.com with ESMTPSA id r4-20020adff104000000b00336a0c083easm2847845wro.53.2024.01.09.08.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 08:47:06 -0800 (PST)
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
Subject: [PATCH v4 5/5] sched/pelt: Remove shift of thermal clock
Date: Tue,  9 Jan 2024 17:46:55 +0100
Message-Id: <20240109164655.626085-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240109164655.626085-1-vincent.guittot@linaro.org>
References: <20240109164655.626085-1-vincent.guittot@linaro.org>
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
index f1c3d600d6d6..d5ba6cdb141c 100644
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
@@ -9247,7 +9241,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
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


