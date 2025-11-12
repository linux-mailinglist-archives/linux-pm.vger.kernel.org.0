Return-Path: <linux-pm+bounces-37890-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 37282C54DAC
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 00:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B9A234342A
	for <lists+linux-pm@lfdr.de>; Wed, 12 Nov 2025 23:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC122E54D7;
	Wed, 12 Nov 2025 23:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pY/vjHJ4"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD6C2D2390
	for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762991621; cv=none; b=CxishFyGYXJBXbKFdw7zcx7uZFThsXwOmqmtL1CpyLzty3oFP5R+peyvyK+4zZfyCOg4KRdgmEkYev/dgxdN2wMJXmZBDg+fADpjy5/DnhXObbjK3iq4JGi9hYK4+RrOjVPidFlK/eLoxx5CbWiRmqoWySjOjCCMyptgKcyLRDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762991621; c=relaxed/simple;
	bh=ENGPD0aIdY+2YhPwx5lnx6WYkkApmZ92GCEve7RFK/U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hGlR7cNc4B9Qo4KNAnRnbXc0YUKBp8TL5LnB6oDj9DFuN6UCg8Ke/eFtfBMOyet4CXs7sY1sFyx6v8FqDqx91a+UEqobhhxQhAZH79SXAO4t/2y4A45nod+aCPy3eVpDwKIH4SQY2ozqI4TTvKf03eNpgmdvjVOmHBj7vJyVsUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pY/vjHJ4; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-29846a9efa5so4985975ad.0
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2025 15:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762991620; x=1763596420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G2fCelaOXaY0hKXLaw4yZFPLF+MlvdQQ3DNLXys3oQE=;
        b=pY/vjHJ4muuy7ZFlb6oiGwKk8ICttYUPvsz7POoLuJpNFI4/Fd4kJY+JuPbdz4+oGW
         e9jcl4jvBnctL6ab1Uw6ABTDhd/R0L5kx6nvzzrFxvtMymt1CjBOzwuc4TbcUtVkrXce
         wfqjPm+Xo8dBZD09GCwvfMZ8ah9NkOS9z8JL6w8Oz5RYKDQForv4sL78EMwJYwHsZ7O6
         6vM/OFw4wj+hetN66DLNy3jw1nXKlEtZIDQmfo3h/l9nQyA5DkY0gGDMUOjyObYruaqi
         mArdCH8XcXHP42eu2WQDRPYRJY9/eYihFlq9IHAO76Z0mhPdHDSf1millzriK6vvu+3K
         9dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762991620; x=1763596420;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G2fCelaOXaY0hKXLaw4yZFPLF+MlvdQQ3DNLXys3oQE=;
        b=bxLW2m3AktD6E3ozv/E3ZR55OORh+qJkYDY9OED9PrpC5sPAe87Ywc4Kft/wHtwF29
         CH8RITRZpm/x4oiM//xvescIs6FjiUL7inxlmF+ZS1DaUJRVXLZQxXyCK4MuNoNk2Xa0
         Ctj74XPtnBFFzC13XcPcuYHflK/5KaubH7uMT81wz75fiX+GtzaPa+iHw4UBW+VcZ93A
         33BgzP4qB1bD4MUzMmCoqgi29TSwy7AzR/SA6RR01FCP+x9iWKsEgJgweD4ng7aBSDoN
         mOuUA4Nrp1jXFRHfdRi/TohFARPi5SUalgT+KLEfWkc6ougx6VP9xxCIK0iTEG6yZsOD
         brrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXcuhKOUkj5WLphvlygioZzjNX9rqZtqKAe013rXcQWF7qr5wo1C/DtqNDPPsIVQbc3fWTP4w9hRw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh9BHW8mpYLYA6EtiBhBkoN1W2lyk723fsLcAMhmvcWwksROEZ
	1qzyp8iXCgQFEJs8LYGPodcZ2cPElhepZa37UfCxLiIvDymh+4brR+CXrGNR74o8gQi3vk1qXkV
	B1/uFpbdqSR2W5g==
X-Google-Smtp-Source: AGHT+IF7hTHhrm0qYbt1kdGgwC2gzoDhVXbYo4QhlWXJhezRX7mAL/XfnnuESy82/pQJzT4cXDYe7+WHmgieIA==
X-Received: from dlbur14.prod.google.com ([2002:a05:7022:ea4e:b0:119:49ca:6b9c])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:d4c3:b0:28e:756c:707e with SMTP id d9443c01a7336-2984eda94d4mr59926575ad.33.1762991619647;
 Wed, 12 Nov 2025 15:53:39 -0800 (PST)
Date: Wed, 12 Nov 2025 15:51:53 -0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.2.1041.gc1ab5b90ca-goog
Message-ID: <20251112235154.2974902-1-wusamuel@google.com>
Subject: [PATCH v1] cpufreq: Add policy_frequency trace event
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The existing cpu_frequency trace_event can be verbose, emitting an event
for every CPU in the policy even when their frequencies are identical.

This patch adds a new policy_frequency trace event, which provides a
more efficient alternative to cpu_frequency trace event. This option
allows users who only need frequency at a policy level more concise logs
with simpler analysis.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/cpufreq/cpufreq.c    |  2 ++
 include/trace/events/power.h | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4472bb1ec83c..b65534a4fd9a 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -345,6 +345,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 		pr_debug("FREQ: %u - CPUs: %*pbl\n", freqs->new,
 			 cpumask_pr_args(policy->cpus));
 
+		trace_policy_frequency(freqs->new, policy->cpu);
 		for_each_cpu(cpu, policy->cpus)
 			trace_cpu_frequency(freqs->new, cpu);
 
@@ -2214,6 +2215,7 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 			    arch_scale_freq_ref(policy->cpu));
 	cpufreq_stats_record_transition(policy, freq);
 
+	trace_policy_frequency(freq, policy->cpu);
 	if (trace_cpu_frequency_enabled()) {
 		for_each_cpu(cpu, policy->cpus)
 			trace_cpu_frequency(freq, cpu);
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 82904291c2b8..87dbd53c8ea1 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -188,6 +188,27 @@ DEFINE_EVENT(cpu, cpu_frequency,
 	TP_ARGS(frequency, cpu_id)
 );
 
+TRACE_EVENT(policy_frequency,
+
+	TP_PROTO(unsigned int frequency, unsigned int policy_cpu),
+
+	TP_ARGS(frequency, policy_cpu),
+
+	TP_STRUCT__entry(
+		__field(u32, frequency)
+		__field(u32, policy_cpu)
+	),
+
+	TP_fast_assign(
+		__entry->frequency = frequency;
+		__entry->policy_cpu = policy_cpu;
+	),
+
+	TP_printk("frequency=%lu policy_cpu=%lu",
+		  (unsigned long)__entry->frequency,
+		  (unsigned long)__entry->policy_cpu)
+);
+
 TRACE_EVENT(cpu_frequency_limits,
 
 	TP_PROTO(struct cpufreq_policy *policy),
-- 
2.51.2.1041.gc1ab5b90ca-goog


