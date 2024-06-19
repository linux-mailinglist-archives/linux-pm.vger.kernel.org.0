Return-Path: <linux-pm+bounces-9529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C206F90E1DB
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 05:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47CC21F23640
	for <lists+linux-pm@lfdr.de>; Wed, 19 Jun 2024 03:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4484E558B6;
	Wed, 19 Jun 2024 03:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQWf6wcy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DE54784;
	Wed, 19 Jun 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718766781; cv=none; b=UOkj/0YtZQwkWaJrQoUnz4TrN5JF06yRmmC82kuklGQWv9hBeKjyOngeJ9O6g0TJ/3v0veJLIh3+1ik1A413/jCi/yFY2FuflZx4++j9UiYJ7ITVuWh+nSGuvdUE2yyBjeuXbvAfa7lf8r4EZ0VlE/lKwgZkix/KDd8pChehyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718766781; c=relaxed/simple;
	bh=Zq97RFD1NzD3tX8GsrLWGIfqfuyHmC1Lemr3mtU8B2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSQ9fCOEJ1uOXdDv6Y37RrVSjzKuu2XMmw0WP2da1VYtudw/4QfKfCa2+kSm3auBosD4XgGQWxybKgGWaSII47Nol/NqjkVQyN7wYDiJHHczxWyyO60Og90OsFhgdVd4HdKdtoJ3OIn6UfP6vTuO/vm8OOKiWieGzlTu7HA8Tjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQWf6wcy; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-681ad26f4a5so3820958a12.2;
        Tue, 18 Jun 2024 20:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718766779; x=1719371579; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JosPq4a3t0Nvwb3xXfy9h1QN+lF3Y/D33Vjab98o6+4=;
        b=XQWf6wcyw87KlfcA0mXkqkF+dP6jJwioQxmJlLVsaiGvl9WMi/bDl8Jbu3c/qzKMRl
         q9oburpFrcJzBuDI6FQuXyRDqFlvp5ZBwjmvr7RzUanRajsQ1U4AR1o/s8QpVgxMme6G
         8UzfLeFqqmAdnk+8Fp20EMfYYxbuCEq731IbBawgxaOnvzgUzaKc419dcagtOOfwrR4m
         8YgUMYuz4V1MWjOjTEV5sFGyxSD8MiFXtVDGesylRoRxosPvukeS7lET+GQg5fizwZsQ
         Dj3cW1wTzSzJLV8y5tODdVeB3o9v2BG6Co5TliYXAVp4voKsPps7+j+5d63D1dQyDpZV
         87FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718766779; x=1719371579;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JosPq4a3t0Nvwb3xXfy9h1QN+lF3Y/D33Vjab98o6+4=;
        b=nuAghi6d0BDsmsHoUrwzZMnTfvHciXdwLxJziE4jsO1fSTA0O6V7zJoLfDeW+Ks9P9
         uFuPkXfdFpJ5QM9YbvUUfPM6w90Q21PPA1YYf1AAEOXSr4TwsiZHlD3x2fbScNAt0q49
         zvvIh4Lf7Cvx9q4JufygB9LYUFp+KPQiaQJeqeHli44bOHUlbGWWUrz8qNFDZA8Xpg9V
         zsy5FLQ358oziaXtgt+c8JpBafdsYR3UnhAV6qer/+yPDIvvlvfScaFKhdZlFll1Pj+7
         SEr//FYs/p3GXfV/TO933vRg//XtWn4e0dhR34KlPgB9CgRtWAQAyR9+INaRfVtzMgln
         NBUw==
X-Forwarded-Encrypted: i=1; AJvYcCXy+/w1bPD5D46mGDNcwI2tvczpYZISSf5rppW0AfEppmqMtVLp/r7k/7YFijeH12ZndO4DM5HymNZF6aofhQXXuqErGyNykQV4oTk9
X-Gm-Message-State: AOJu0Yw3JAH4wL3xH8awGM6EzU5M+n6ttRv8nam+hKyiJow6MAyguwDr
	GXqXGWwhp0SfIRcp0pNfIU7CxE6E9WcqvXCvrHVSul9a9kXCzCzZ
X-Google-Smtp-Source: AGHT+IG+fhRudi5HuFf6xkV00KsDluYeXerGoOKbcSfr4sooFI3Od7mBdTDnc6p8Qh1/V4+UQLiE1A==
X-Received: by 2002:a05:6a21:78a3:b0:1b8:6ed5:a89 with SMTP id adf61e73a8af0-1bcbb640cb4mr1761896637.46.1718766778778;
        Tue, 18 Jun 2024 20:12:58 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e72397sm104869915ad.95.2024.06.18.20.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 20:12:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org,
	void@manifault.com,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	mingo@redhat.com,
	peterz@infradead.org,
	Tejun Heo <tj@kernel.org>,
	David Vernet <dvernet@meta.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH 1/2] cpufreq_schedutil: Refactor sugov_cpu_is_busy()
Date: Tue, 18 Jun 2024 17:12:02 -1000
Message-ID: <20240619031250.2936087-2-tj@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240619031250.2936087-1-tj@kernel.org>
References: <20240619031250.2936087-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sugov_cpu_is_busy() is used to avoid decreasing performance level while the
CPU is busy and called by sugov_update_single_freq() and
sugov_update_single_perf(). Both callers repeat the same pattern to first
test for uclamp and then the business. Let's refactor so that the tests
aren't repeated.

The new helper is named sugov_hold_freq() and tests both the uclamp
exception and CPU business. No functional changes. This will make adding
more exception conditions easier.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 38 +++++++++++++++-----------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..972b7dd65af2 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -325,16 +325,27 @@ static unsigned long sugov_iowait_apply(struct sugov_cpu *sg_cpu, u64 time,
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
-static bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu)
+static bool sugov_hold_freq(struct sugov_cpu *sg_cpu)
 {
-	unsigned long idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
-	bool ret = idle_calls == sg_cpu->saved_idle_calls;
+	unsigned long idle_calls;
+	bool ret;
+
+	/* if capped by uclamp_max, always update to be in compliance */
+	if (uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)))
+		return false;
+
+	/*
+	 * Maintain the frequency if the CPU has not been idle recently, as
+	 * reduction is likely to be premature.
+	 */
+	idle_calls = tick_nohz_get_idle_calls_cpu(sg_cpu->cpu);
+	ret = idle_calls == sg_cpu->saved_idle_calls;
 
 	sg_cpu->saved_idle_calls = idle_calls;
 	return ret;
 }
 #else
-static inline bool sugov_cpu_is_busy(struct sugov_cpu *sg_cpu) { return false; }
+static inline bool sugov_hold_freq(struct sugov_cpu *sg_cpu) { return false; }
 #endif /* CONFIG_NO_HZ_COMMON */
 
 /*
@@ -382,14 +393,8 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		return;
 
 	next_f = get_next_freq(sg_policy, sg_cpu->util, max_cap);
-	/*
-	 * Do not reduce the frequency if the CPU has not been idle
-	 * recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
-	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && next_f < sg_policy->next_freq &&
+
+	if (sugov_hold_freq(sg_cpu) && next_f < sg_policy->next_freq &&
 	    !sg_policy->need_freq_update) {
 		next_f = sg_policy->next_freq;
 
@@ -436,14 +441,7 @@ static void sugov_update_single_perf(struct update_util_data *hook, u64 time,
 	if (!sugov_update_single_common(sg_cpu, time, max_cap, flags))
 		return;
 
-	/*
-	 * Do not reduce the target performance level if the CPU has not been
-	 * idle recently, as the reduction is likely to be premature then.
-	 *
-	 * Except when the rq is capped by uclamp_max.
-	 */
-	if (!uclamp_rq_is_capped(cpu_rq(sg_cpu->cpu)) &&
-	    sugov_cpu_is_busy(sg_cpu) && sg_cpu->util < prev_util)
+	if (sugov_hold_freq(sg_cpu) && sg_cpu->util < prev_util)
 		sg_cpu->util = prev_util;
 
 	cpufreq_driver_adjust_perf(sg_cpu->cpu, sg_cpu->bw_min,
-- 
2.45.2


