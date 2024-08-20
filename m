Return-Path: <linux-pm+bounces-12571-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48C958C52
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0F031F25EA9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB961BB69B;
	Tue, 20 Aug 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="wsyA3i1I"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2596C1B3F33
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171809; cv=none; b=rcc8jr531xUZH/b5chIpCTh6C8Pw/TdjbEUj0Kkpf5lBD+wQyODMIwL8tA4BQlP1X6sqEafMriB0qTpe0qvjhNX3vFmjhDmQsBF6CSdNThdlKEQSm40DWI0rpGj6/HXkgCcLc+0iKJCLjIG5hrRzfUB/y7dOCJ7nQFwQbBjnrbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171809; c=relaxed/simple;
	bh=ggQ0xHMfPwWR5W6MLhFpsoF3X1RHmOFsfCjj+44KrkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W8AlGSN1XpjgGWwCiaCVbvGKZsJ/qkqqCp+T0k7L1zSWD9U50p6CwPjjVarJCaXuuQEiK3hdyfVyVbivmvhde5cRvi3zOHzzvw2ZdhQK+U1OQ5U+trx4DKwRwC7SZVBhKWJLYN4d0K285Q+qNgrqgR/nAQaa9bI2Dr3DREB12OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=wsyA3i1I; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso569566366b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171804; x=1724776604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wet2+g0g75UUnmsKQrb/VZONF2cRQanUuyFsF+8Vjk=;
        b=wsyA3i1IbjWoPW9j3p0vNvUGwPtjDlNT45+LMvpLkR7Gh+g1Ft4yn9bcG6cHDY6Fx7
         EskjTsaMfaEWcarR6Xqt1tnXRL+7pkPpjAlgUab7PvpOrpZbl2ph7izXNPl7oLISini8
         V4ljBcawl8Sf7NAfs1prsOlVMV9YYOL0v+8HXCSOh1Jr1bnvLd6Ku1IjRgSIUBusiYEp
         r084fR18jdRdhPY4bsDBe2NmYEqcLYCTg9X4e7/HH2BtfV9GHjqzHR7A6eYyy1REsQRq
         0wdm6G189GSe9YpKNQ8GF0GCTNPMj8Yt4Zf7NoW335B8v6ZY/TFYj7N1dCKjvlLGo8OY
         bzvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171804; x=1724776604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wet2+g0g75UUnmsKQrb/VZONF2cRQanUuyFsF+8Vjk=;
        b=jbcH43S+Vbei6a2ua3WZ7LmB/boEIowfXt02L7i0S61mL66D+8UcLB+T78dxbVAi9E
         JP/wno3u334Izb9x7IIKE3HvuNN92oUeQLEsG/AxoPtLG94mQPSdj3vpmS5vp/LVYprO
         WAvcDj+/Gpje+g72j/8LgeYcp9ZKDsSn8084ekk27dBmUCuqEn66gI2O/p1b04WA/jlC
         j5pJtq33QIVUeySLtsTSvqeJg61hWjt0huUOYKWX3kt3UefLYFBnchKYYDalt3bPbRC4
         S0K+FG+UhBAdjUcFMdEseylvVJs5l59vMpy1gBj5c1FDF4capkbBmsnc6sHcmh99J9oX
         Czxg==
X-Forwarded-Encrypted: i=1; AJvYcCWwE41RUN3AWzfy38TVupUvm3Q7uo55nHxriziWw1FLMKXC+qX3JIaUoA5L3mTt9jjCI+G8/GBvx9K4F0gAnTDBxTSeeDwqO5U=
X-Gm-Message-State: AOJu0YyKg2XrRBHvgHf/CPv6kETAzps0o7oZW70JlTl8Hwo3UOSJczkt
	l24mLwqDlaJkl1SFB6ILh4HJFV4C4NfR1Mf2+0B/KaOvxPa9R00xcsnj9W4bRaw=
X-Google-Smtp-Source: AGHT+IFEuSDJpZmH2vuXQPhm8UldWkmv4L2KE1jsWvuj7bhXQKIf0BaaBicVLq/zLot7W5U3e4x0BA==
X-Received: by 2002:a17:906:d7c7:b0:a7a:bece:6222 with SMTP id a640c23a62f3a-a83928a9f25mr1027872166b.10.1724171804254;
        Tue, 20 Aug 2024 09:36:44 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:43 -0700 (PDT)
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
Subject: [RFC PATCH 07/16] sched/pelt: Introduce PELT multiplier boot time parameter
Date: Tue, 20 Aug 2024 17:35:03 +0100
Message-Id: <20240820163512.1096301-8-qyousef@layalina.io>
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

The param is set as read only and can only be changed at boot time via

	kernel.sched_pelt_multiplier=[1, 2, 4]

PELT has a big impact on the overall system response and reactiveness to
change. Smaller PELT HF means it'll require less time to reach the
maximum performance point of the system when the system become fully
busy; and equally shorter time to go back to lowest performance point
when the system goes back to idle.

This faster reaction impacts both DVFS response and migration time
between clusters in HMP system.

Smaller PELT values (higher multiplier) are expected to give better
performance at the cost of more power. Under-powered systems can
particularly benefit from faster response time. Powerful systems can
still benefit from response time if they want to be tuned towards perf
more and power is not the major concern for them.

This combined with response_time_ms from schedutil should give the user
and sysadmin a deterministic way to control the triangular power, perf
and thermals for their system. The default response_time_ms will half
as PELT HF halves.

Update approximate_{util_avg, runtime}() to take into account the PELT
HALFLIFE multiplier.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
[qyousef: Commit message and boot param]
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c | 62 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 06cb881ba582..536575757420 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -24,6 +24,9 @@
  *  Author: Vincent Guittot <vincent.guittot@linaro.org>
  */
 
+static __read_mostly unsigned int sched_pelt_lshift;
+static unsigned int sched_pelt_multiplier = 1;
+
 /*
  * Approximate:
  *   val * y^n,    where y^32 ~= 0.5 (~1 scheduling period)
@@ -180,6 +183,7 @@ static __always_inline int
 ___update_load_sum(u64 now, struct sched_avg *sa,
 		  unsigned long load, unsigned long runnable, int running)
 {
+	int time_shift;
 	u64 delta;
 
 	delta = now - sa->last_update_time;
@@ -195,12 +199,17 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
 	/*
 	 * Use 1024ns as the unit of measurement since it's a reasonable
 	 * approximation of 1us and fast to compute.
+	 * On top of this, we can change the half-time period from the default
+	 * 32ms to a shorter value. This is equivalent to left shifting the
+	 * time.
+	 * Merge both right and left shifts in one single right shift
 	 */
-	delta >>= 10;
+	time_shift = 10 - sched_pelt_lshift;
+	delta >>= time_shift;
 	if (!delta)
 		return 0;
 
-	sa->last_update_time += delta << 10;
+	sa->last_update_time += delta << time_shift;
 
 	/*
 	 * running is a subset of runnable (weight) so running can't be set if
@@ -468,6 +477,51 @@ int update_irq_load_avg(struct rq *rq, u64 running)
 }
 #endif /* CONFIG_HAVE_SCHED_AVG_IRQ */
 
+static int set_sched_pelt_multiplier(const char *val, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = param_set_int(val, kp);
+	if (ret)
+		goto error;
+
+	switch (sched_pelt_multiplier)  {
+	case 1:
+		fallthrough;
+	case 2:
+		fallthrough;
+	case 4:
+		WRITE_ONCE(sched_pelt_lshift,
+			   sched_pelt_multiplier >> 1);
+		break;
+	default:
+		ret = -EINVAL;
+		goto error;
+	}
+
+	return 0;
+
+error:
+	sched_pelt_multiplier = 1;
+	return ret;
+}
+
+static const struct kernel_param_ops sched_pelt_multiplier_ops = {
+	.set = set_sched_pelt_multiplier,
+	.get = param_get_int,
+};
+
+#ifdef MODULE_PARAM_PREFIX
+#undef MODULE_PARAM_PREFIX
+#endif
+/* XXX: should we use sched as prefix? */
+#define MODULE_PARAM_PREFIX "kernel."
+module_param_cb(sched_pelt_multiplier, &sched_pelt_multiplier_ops, &sched_pelt_multiplier, 0444);
+MODULE_PARM_DESC(sched_pelt_multiplier, "PELT HALFLIFE helps control the responsiveness of the system.");
+MODULE_PARM_DESC(sched_pelt_multiplier, "Accepted value: 1 32ms PELT HALIFE - roughly 200ms to go from 0 to max performance point (default).");
+MODULE_PARM_DESC(sched_pelt_multiplier, "                2 16ms PELT HALIFE - roughly 100ms to go from 0 to max performance point.");
+MODULE_PARM_DESC(sched_pelt_multiplier, "                4  8ms PELT HALIFE - roughly  50ms to go from 0 to max performance point.");
+
 /*
  * Approximate the new util_avg value assuming an entity has continued to run
  * for @delta us.
@@ -482,7 +536,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 	if (unlikely(!delta))
 		return util;
 
-	accumulate_sum(delta, &sa, 1, 0, 1);
+	accumulate_sum(delta << sched_pelt_lshift, &sa, 1, 0, 1);
 	___update_load_avg(&sa, 0);
 
 	return sa.util_avg;
@@ -494,7 +548,7 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 u64 approximate_runtime(unsigned long util)
 {
 	struct sched_avg sa = {};
-	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 delta = 1024 << sched_pelt_lshift; // period = 1024 = ~1ms
 	u64 runtime = 0;
 
 	if (unlikely(!util))
-- 
2.34.1


