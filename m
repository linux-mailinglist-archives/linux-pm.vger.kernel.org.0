Return-Path: <linux-pm+bounces-19078-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F05C9EDD3F
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 02:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BD521889B75
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 01:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CA984A35;
	Thu, 12 Dec 2024 01:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XOFVZkBM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05091B640;
	Thu, 12 Dec 2024 01:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733968659; cv=none; b=t5inB0rNeCtlE8pjqTmAEQuAJdnB1ahMslI0ZU4HvgFi7xXKcdYnz9PCszWziS63ITpp6UXWNbrJM/6HN2FT0PVHVbquRlMv2dhlYPa/FB+2ybk4MF8eIRsNz9NBQNA1oLAPAh/LdnJFO+UDijQA1zBWMXEToTMfQx/fM31vBaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733968659; c=relaxed/simple;
	bh=V6oh0JB1tyWMyrCwjgseP1Lzp1BH76pDoodTXJ0bb9w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CU0XkzadtnqjInvTY3rE04b79ZeTnxltoH7HN+/EG3TkoOLUh9+KKj7n4B+unitSP3U+WW0PQBPrD4H8ICbSRJ9HkBunf3IOV9egRBwjDoeNk2amW1c1KY+qHAyWw5pu+ARtSrLvmlioG25uWD4dqCthnPWlmrUS0ahUCXFT3jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XOFVZkBM; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kerneltoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-723f37dd76cso88657b3a.0;
        Wed, 11 Dec 2024 17:57:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733968657; x=1734573457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=nwG3dseg3dFXG3OHkltH5qxLvvZzBHAhdNLBlAWWT6Q=;
        b=XOFVZkBMGC9NcpH5OB31OEvwvLIeSP8TxzDl+UAVmrjbql5Du5rG4udYQZ3HD0fuch
         0jp8V12hOdoKjdSZUpr8MOkiVzgq8LCnR3vhpGgv1OXIBnWd1pkiIEAIh2YJRraoEIJy
         esjxoIrQIKhZ9x4y41qaZDwjTgDL6LNmgKX3dskElFR/5sdYpsY5kN5HZU2xd7KEonY+
         e5O5nl5B08DNhynW+UV6gPG2/KNBm9EhnYsPQqV03sHsYldPS2FwPL/lf2zcpnmcJu/k
         nR6jrSarwbVtyqXc6254DO4wZ8XU6UQjkC/RMRj8sYlfuSyUsG6iVabWcZAFJT0yvmoW
         DNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733968657; x=1734573457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwG3dseg3dFXG3OHkltH5qxLvvZzBHAhdNLBlAWWT6Q=;
        b=cbi0DIKgO0V5Ce8PoEQGYi0LD5kixQOYbwXEByAb+c0ay4t5yIuIFstTxe1UCgXjHH
         f4dkI9nrwdgzKPj+EjDPw9HzOJO6Jx3xllEm08CdB4myQFw8WXKE1mRpEy68TQaC9QyZ
         03cLjAg8OKyil7ZhjWsQX73rOmSYW3Z5fs6fjtuNgjTwvbgEwbjaKnhIqJ6lLU23LpyR
         UGpv8Aj8T0T8tt972rtYsNgPtfMPw2BLCCUu35XTZDuf0HRfwlsApEd+CNJ9/QmSKM5j
         EQz+5SIH0X1vgWBrn3L8E7/1GT8Ybfw+tK3lSIwbq7ZddeAwYnOnKW2IuCGsTK6r9jsO
         mNlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOUIhW9iMgl4ehFnSr1FGLdgj4G/2yG0b+pTH/8c5LU406sF0SA4q5kJy/pDTgYMYY+c2Gz8U0gyU=@vger.kernel.org, AJvYcCWROZYX0rOsb9ofUHGqlqTReOgYzZgFi7CiOHxlHiUtHJu+VaCfWGKdrogu2+f/aC92jl/XAbS/PPVP4Uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyanmlRQcld8TTOLZf7ogNEYe0n/pEjfqebNdF6FmX3isDchpnP
	dVibHEMH9maOFORbvKkle9MHAXbip+0VzoizpdQYMRP7c5yYQC6S
X-Gm-Gg: ASbGnctP1wvrszL86salweISkT3ynfi+dBzlAX671ZjZAOLzKtDjVKR65Qt/hSC51P1
	hwYOtzEkQKuMu+Ehz+9oxQrdiDB39YTk+ld6bt+qQHMYqynEJVC1d16s39mBnjQpi1doHrCULmf
	tECm3j/b8GugbrirMDuIlC7aw3NrDW97GqAuBNWKKxlDH1l+NhOUyiLp8lEBblAgTJlgzDDXVhP
	c/KgBXw66ZWPVSl3C4NUKKz9LAe63O50bI=
X-Google-Smtp-Source: AGHT+IHFz1p986CrolQn3NjI/x8hFPs8BhwhQZregchadiI4OpGY1ZYBH+sFDLZjfFGdCFGPNpGw1g==
X-Received: by 2002:a05:6a20:72a4:b0:1e1:a932:4a3f with SMTP id adf61e73a8af0-1e1cea7ff33mr2400400637.3.1733968657226;
        Wed, 11 Dec 2024 17:57:37 -0800 (PST)
Received: from sultan-box.lan ([142.147.89.231])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd41a128ebsm7086456a12.85.2024.12.11.17.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 17:57:36 -0800 (PST)
Sender: Sultan Alsawaf <sultan.kerneltoast@gmail.com>
From: Sultan Alsawaf <sultan@kerneltoast.com>
X-Google-Original-From: Sultan Alsawaf (unemployed)
To: 
Cc: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: schedutil: Ignore rate limit when scaling up with FIE present
Date: Wed, 11 Dec 2024 17:57:31 -0800
Message-ID: <20241212015734.41241-1-sultan@kerneltoast.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Sultan Alsawaf (unemployed)" <sultan@kerneltoast.com>

When schedutil disregards a frequency transition due to the transition rate
limit, there is no guaranteed deadline as to when the frequency transition
will actually occur after the rate limit expires. For instance, depending
on how long a CPU spends in a preempt/IRQs disabled context, a rate-limited
frequency transition may be delayed indefinitely, until said CPU reaches
the scheduler again. This also hurts tasks boosted via UCLAMP_MIN.

For frequency transitions _down_, this only poses a theoretical loss of
energy savings since a CPU may remain at a higher frequency than necessary
for an indefinite period beyond the rate limit expiry.

For frequency transitions _up_, however, this poses a significant hit to
performance when a CPU is stuck at an insufficient frequency for an
indefinitely long time. In latency-sensitive and bursty workloads
especially, a missed frequency transition up can result in a significant
performance loss due to a CPU operating at an insufficient frequency for
too long.

When support for the Frequency Invariant Engine (FIE) _isn't_ present, a
rate limit is always required for the scheduler to compute CPU utilization
with some semblance of accuracy: any frequency transition that occurs
before the previous transition latches would result in the scheduler not
knowing the frequency a CPU is actually operating at, thereby trashing the
computed CPU utilization.

However, when FIE support _is_ present, there's no technical requirement to
rate limit all frequency transitions to a cpufreq driver's reported
transition latency. With FIE, the scheduler's CPU utilization tracking is
unaffected by any frequency transitions that occur before the previous
frequency is latched.

Therefore, ignore the frequency transition rate limit when scaling up on
systems where FIE is present. This guarantees that transitions to a higher
frequency cannot be indefinitely delayed, since they simply cannot be
delayed at all.

Signed-off-by: Sultan Alsawaf (unemployed) <sultan@kerneltoast.com>
---
 kernel/sched/cpufreq_schedutil.c | 35 +++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index e51d5ce730be..563baab89a24 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -59,10 +59,15 @@ static DEFINE_PER_CPU(struct sugov_cpu, sugov_cpu);
 
 /************************ Governor internals ***********************/
 
-static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+static bool sugov_should_rate_limit(struct sugov_policy *sg_policy, u64 time)
 {
-	s64 delta_ns;
+	s64 delta_ns = time - sg_policy->last_freq_update_time;
+
+	return delta_ns < sg_policy->freq_update_delay_ns;
+}
 
+static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
+{
 	/*
 	 * Since cpufreq_update_util() is called with rq->lock held for
 	 * the @target_cpu, our per-CPU data is fully serialized.
@@ -87,17 +92,37 @@ static bool sugov_should_update_freq(struct sugov_policy *sg_policy, u64 time)
 		return true;
 	}
 
-	delta_ns = time - sg_policy->last_freq_update_time;
+	/*
+	 * When frequency-invariant utilization tracking is present, there's no
+	 * rate limit when increasing frequency. Therefore, the next frequency
+	 * must be determined before a decision can be made to rate limit the
+	 * frequency change, hence the rate limit check is bypassed here.
+	 */
+	if (arch_scale_freq_invariant())
+		return true;
 
-	return delta_ns >= sg_policy->freq_update_delay_ns;
+	return !sugov_should_rate_limit(sg_policy, time);
 }
 
 static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 				   unsigned int next_freq)
 {
+	/*
+	 * When a frequency update isn't mandatory (!need_freq_update), the rate
+	 * limit is checked again upon frequency reduction because systems with
+	 * frequency-invariant utilization bypass the rate limit check entirely
+	 * in sugov_should_update_freq(). This is done so that the rate limit
+	 * can be applied only for frequency reduction when frequency-invariant
+	 * utilization is present. Now that the next frequency is known, the
+	 * rate limit can be selectively applied to frequency reduction on such
+	 * systems. A check for arch_scale_freq_invariant() is omitted here
+	 * because unconditionally rechecking the rate limit is cheaper.
+	 */
 	if (sg_policy->need_freq_update)
 		sg_policy->need_freq_update = false;
-	else if (sg_policy->next_freq == next_freq)
+	else if (next_freq == sg_policy->next_freq ||
+		 (next_freq < sg_policy->next_freq &&
+		  sugov_should_rate_limit(sg_policy, time)))
 		return false;
 
 	sg_policy->next_freq = next_freq;
-- 
2.47.1


