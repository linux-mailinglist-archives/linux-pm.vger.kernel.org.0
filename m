Return-Path: <linux-pm+bounces-12564-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30505958C42
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E1A6B22C20
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9462A1B86FC;
	Tue, 20 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="B+yMZs56"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85981AB53E
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171721; cv=none; b=fWVbH8XmMdhppcMrdIbPfvdXG4K5s+5cgKsXjUGP8ApFXLmjbM4eZpBDsxLY7SMDx2Q2N353/AQ9EyJlyF9QAfSaCskRcPWR6zsO42gDkLc47oubzPxvvQJBI0DEnKpgAGvjP8LjJn+/4acX9ueO0vueu1Ln4B0TdyKs1gRbNg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171721; c=relaxed/simple;
	bh=zQ47ImMy4Dn1DCDt3xGlBdnPJ6cBUL0LZB3cTsDPnpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJQ3RWSC0wZsTP4iLJB7YadkapCd/R661fYDNXUcWjA3nZK9VzLwp9gKSAoIgeGP/j9X9DIpometibsUAAeeFxzry/XQBPxngxlsZxlKcWv74YpTaJRzFE0LAtRAWQGcUlujm8UunvIKHTh4DdxDFcj8O0ajeLMU/nOgqmWRbWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=B+yMZs56; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-533462b9428so615027e87.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171718; x=1724776518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ALljPJwr4PeLXzf4Mb7jserQc5yvW1LK2jxOSl+dUgk=;
        b=B+yMZs56DcUH8lwhBw7LjnX1UE4bUz+uXrsRAFZbq2wDl9WIxCE+7bQCJwVAV5dsvD
         1HsSi9npTs5kShx7/YWBr/EBeHotOA4Dpbfrbr2FRXrBNy60r0xdiA3bwQ1g6i+Y/DNs
         C/bxMu8u18z+qiYdM/h/tJV3T9vRh/uxJxbCCKC2n9UDjv2RAhlDe9MPXAbNuxxPyfDq
         bMuW7p4nT+noroAo2WrnYcpYuAjP8ldg5f+Y0le8COnziAh0YLgg4T2nKPUipHxp1kK7
         dILxGzzGxGrRXuCOJanfpKtPd+YKkTbvX4DuWhHIKs156AogCLT6SJAUMuiXA3HMrzCz
         U0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171718; x=1724776518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ALljPJwr4PeLXzf4Mb7jserQc5yvW1LK2jxOSl+dUgk=;
        b=ZWRbHN5RcuXVBnRzmVHjeMO66m8ZmMiS8JYULkWtYw+Yxu7LY8rp7CBotxN2eHcRbJ
         T1JOdImrHoSH+6TkIcHp3gkLeUUL2ItctlgS7NSJMw9D+QWytvaSKrVI4+bqPHf1KPEf
         o+13gfUgK1Lgv7a6ZVaSEc1lT6+gplUQdMitfa29O0RcV6qy/xqRoPXkgo5KrBqqun7g
         7hdMjxrvCljehVeP8DNqJfOUfwqWTlz+znzwElTcMKPWPmN/+Yk99vR17BOeqlBKk4FV
         vIMXaCev9X5b2Rv6n+W6bOS5/q55XJenwkuPvjmiF6BF+R+PiuRb/pcZxnjSdRVKJBeb
         vkvw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Irp8ISJvo6zl7GgVftOFJv5jMnLd/hUkCJBq1HS4U+0N60TjuIy5h4BlNXV0bQqLkwEqE/WuM94yD3bjL88EZ8oc38ODmtY=
X-Gm-Message-State: AOJu0Yxk6GCxPue39ff5rHfWy7SWNJMzRFy8+lsuZWbYcMGmPF2br1Dx
	KXogBnpD9rom2tznnaAHdeEw+r63TPaRCuUeQ98oSxqm78hv+SETCRJuLEAxXiU=
X-Google-Smtp-Source: AGHT+IGuDVH/ZjqmvSREiN6JjWHaWFgiSgGpgzFBXWMg8TVU1iExwbDmMv1TgZFfKYdZJrbLW1T/7A==
X-Received: by 2002:a05:6512:1193:b0:533:4620:ebec with SMTP id 2adb3069b0e04-5334620eda4mr942030e87.3.1724171717578;
        Tue, 20 Aug 2024 09:35:17 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:17 -0700 (PDT)
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
Subject: [RFC PATCH 01/16] sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
Date: Tue, 20 Aug 2024 17:34:57 +0100
Message-Id: <20240820163512.1096301-2-qyousef@layalina.io>
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

We are providing headroom for the utilization to grow until the next
decision point to pick the next frequency. Give the function a better
name and give it some documentation. It is not really mapping anything.

Also move it to cpufreq_schedutil.c. This function relies on updating
util signal appropriately to give a headroom to grow. This is tied to
schedutil and scheduler and not something that can be shared with other
governors.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h    |  5 -----
 kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..d01755d3142f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
 {
 	return freq * util / cap;
 }
-
-static inline unsigned long map_util_perf(unsigned long util)
-{
-	return util + (util >> 2);
-}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..575df3599813 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+/*
+ * DVFS decision are made at discrete points. If CPU stays busy, the util will
+ * continue to grow, which means it could need to run at a higher frequency
+ * before the next decision point was reached. IOW, we can't follow the util as
+ * it grows immediately, but there's a delay before we issue a request to go to
+ * higher frequency. The headroom caters for this delay so the system continues
+ * to run at adequate performance point.
+ *
+ * This function provides enough headroom to provide adequate performance
+ * assuming the CPU continues to be busy.
+ *
+ * At the moment it is a constant multiplication with 1.25.
+ */
+static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
+{
+	return util + (util >> 2);
+}
+
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
+	actual = sugov_apply_dvfs_headroom(actual);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
-- 
2.34.1


