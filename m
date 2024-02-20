Return-Path: <linux-pm+bounces-4139-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F7485BF58
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68C09282666
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD00763F2;
	Tue, 20 Feb 2024 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sazZ+4Tz"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2C2762DC
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 15:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441206; cv=none; b=pgLdMsAhulQc76iXM+JeYwMHkdQ1d+m5U5+Mz1H9ZLqo2j9g5rGQt9R0O/i+97UfIiWvH+6x/9QzAnZN2O1wVzJD1xR7Y2LbawJGmre0JURW+Jf8iTz0eIUPvyB20m9662wOpd4H4FR+65xCWGVtnT7YpQSEilObSm6HZV1XXw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441206; c=relaxed/simple;
	bh=uqPQzpqpW1oWCehvSp8LygvJhWA+5XoquTYQhMHNHrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EEw5otm0d0W8RcdMU+lxpO+aO6B1U6E0NRFOz1QP2RWMwn+mHeJvwR/+RcIMSC2JpbJ3zusQq9+1fhs5C5zSPwUbAYcoySMpyh5DKKthKfdkqtAMSJp0FKIK+9xV6HlHM5g7Ql6X/qjrzM7WyxP6EeqyfbSLHU38hkEaalkrzrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sazZ+4Tz; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4127109694aso2909575e9.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 07:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708441202; x=1709046002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXsi9e0ZJaTq8tCuJHkWD66aNk20DvqQuX0JKE5P0uc=;
        b=sazZ+4TzSqBtwKqibBN7eNNt+F534BEttEcpvsXx28MOgZydOmxB+TYMci/emI0oTo
         Kiq16rELs8Il8gwahnkE+6DdTbtDjURFDltN/20c/NcsMYBStRhsQuqueHpcSgsE0PAH
         gqINnk1sPGoOcpzyqs4iKkpteQHA/URt/pE6l+7/wwPx/LQMvZVN6Tq3+UgKb24tKxQ8
         qJ1bPaEDAcsMqYAdoKnkW+cNyWLlcNxrbeMliO0glXULrAG/0URL8cz8p0mYmwQYEi+8
         0CK7bd0ZqU8fvVgFYtd0kP4jw5Zd5FLjLjFMW/oCpoSUr+3JrKZ8U6TsrctxzbhKuaMD
         3egQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708441202; x=1709046002;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXsi9e0ZJaTq8tCuJHkWD66aNk20DvqQuX0JKE5P0uc=;
        b=rfoOesN5mpeuODTXxMSKKPOvT8hj71C5zE2uagNnm5ofMVqq50Ho+e63Yk+Bm5PC/L
         JkTH0QbkGTANWFBOwXICwx7DQo8/Mwa+4c+EAVOvDHPjrSXO7qWFGJKqllDa2AmKctKi
         AhoWjP+pduNqXvu7CWpec86VKvEBvDT3vWbMpbe415LgFh/YlxR2v4kNqWoRT7+5+T+S
         tJGLtduEMBUtaTRiSq/K+GD3ks6Wnoqo1UWyVod4rwKcoM58upichLmVUnERsDIwCHHK
         SmL4VMNF5rr+qD4R8a0UBEbp/AIE5xfpt5ThHLEdQaPfPOKasvfdHJaPR6PqHVjPamBH
         iIMA==
X-Forwarded-Encrypted: i=1; AJvYcCXwYQnyYReWk2g/vvCvRbZ02CaZtuipMlk4+jI7H2NL0C9FslPEeU+xCZVvT7iYlAK2A6ukIsO6OIq+AlkK/qZVqdz7fngEH6o=
X-Gm-Message-State: AOJu0YxbKmg1pCG4cZjJCqA2RUKpxMJs4Vbk9m58sardPCX5RhcG2dPo
	enFwX8LzZzklYMPAl3A+bDGCjzYeZ+fCMWkceM3EXeB7/lRMwT+yhpJkpXXaX2A=
X-Google-Smtp-Source: AGHT+IEGJuS9S6rDAwOVJ71L9m5a65+6iLz6u9I0qEZvXUIWtxH6o/5l2zVbIcoozPQzIagXT47Q0A==
X-Received: by 2002:a05:6000:1a43:b0:33d:32ff:9629 with SMTP id t3-20020a0560001a4300b0033d32ff9629mr6355629wry.23.1708441202610;
        Tue, 20 Feb 2024 07:00:02 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:8deb:bfb9:b028:6d5c])
        by smtp.gmail.com with ESMTPSA id v4-20020a5d6784000000b0033d39626c27sm9304405wru.76.2024.02.20.07.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 07:00:01 -0800 (PST)
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
Subject: [PATCH v5 5/5] sched/pelt: Remove shift of thermal clock
Date: Tue, 20 Feb 2024 15:59:47 +0100
Message-Id: <20240220145947.1107937-6-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220145947.1107937-1-vincent.guittot@linaro.org>
References: <20240220145947.1107937-1-vincent.guittot@linaro.org>
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
---
 .../admin-guide/kernel-parameters.txt          |  1 +
 kernel/sched/core.c                            |  2 +-
 kernel/sched/fair.c                            | 10 ++--------
 kernel/sched/sched.h                           | 18 ------------------
 4 files changed, 4 insertions(+), 27 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 31b3a25680d0..4dc54bd1bbf2 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -5749,6 +5749,7 @@
 			but is useful for debugging and performance tuning.
 
 	sched_thermal_decay_shift=
+			[Deprecated]
 			[KNL, SMP] Set a decay shift for scheduler thermal
 			pressure signal. Thermal pressure signal follows the
 			default decay period of other scheduler pelt
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8bfe5ce4ccd3..b740dcdc86a0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5669,7 +5669,7 @@ void scheduler_tick(void)
 
 	update_rq_clock(rq);
 	hw_pressure = arch_scale_hw_pressure(cpu_of(rq));
-	update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure);
+	update_hw_load_avg(rq_clock_task(rq), rq, hw_pressure);
 	curr->sched_class->task_tick(rq, curr, 0);
 	if (sched_feat(LATENCY_WARN))
 		resched_latency = cpu_resched_latency(rq);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8961d307f232..f7c2bf0eba65 100644
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
@@ -9296,7 +9290,7 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 	decayed = update_rt_rq_load_avg(now, rq, curr_class == &rt_sched_class) |
 		  update_dl_rq_load_avg(now, rq, curr_class == &dl_sched_class) |
-		  update_hw_load_avg(rq_clock_hw(rq), rq, hw_pressure) |
+		  update_hw_load_avg(now, rq, hw_pressure) |
 		  update_irq_load_avg(rq, 0);
 
 	if (others_have_blocked(rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1f8799788cea..638c61efe19d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1531,24 +1531,6 @@ static inline u64 rq_clock_task(struct rq *rq)
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


