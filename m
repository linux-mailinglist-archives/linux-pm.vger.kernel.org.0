Return-Path: <linux-pm+bounces-1529-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6111F81BA99
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 16:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C892B256FE
	for <lists+linux-pm@lfdr.de>; Thu, 21 Dec 2023 15:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E1553A06;
	Thu, 21 Dec 2023 15:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EPo9OeCy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445611D6A9
	for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40d41555f9dso3708805e9.2
        for <linux-pm@vger.kernel.org>; Thu, 21 Dec 2023 07:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703172252; x=1703777052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v/J6RB2Lw/HQZsxNLlML+TfeS0CELCbuPUL4YNRnsW4=;
        b=EPo9OeCyCT8iG7KPFfiRRNBD1nPqfCmFN8NlasJvxyBiLFqC5rn0OVtiIanRpnLJCc
         AHytF4qG/CuSOoWZSuWpdA1Alg+xBVngoYIJtIPEv4JKJ+HJ/1cogvellIBHsOCyIZnO
         xH3olKLQCKsAe32z9y1TpViCtIrRBK1y/SWEUT7JDzoOe8t5+f37sRgldkELnFFaBvHm
         TDCz+NGq0JzS1WcYJlwWknWqQZYSvLNqyz1rscmYI9c86T1/YGvKUpdxKEzh2pUUziQf
         RAVldsdiSzQOX5j7L1ATDLsP11+kQDzXGj6u/JQzmuGrJfFUAc2Hmd2R3SD2UrebMs8i
         5KvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703172252; x=1703777052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v/J6RB2Lw/HQZsxNLlML+TfeS0CELCbuPUL4YNRnsW4=;
        b=f0MHa3jRTW5YE1fxXm17hxAStDm28wcvG9+x8iFK+yR1vxOOq0Ng70PN69Z88xKP9F
         Gf/G9UvnvrakaipmsNhpymoo/dy/euJcdzqEW8hlBL/ZAgVjZZeiJmsdnCNZcmlF9ajO
         vS1buR6Ei6RopfuHv0F67Fx72FIeJYYlY5j8YoEwaZc45KOtdDmtBfkz5XiutRWmy1yz
         orWwtwUYY5+yqZBHJyQ6xOAzbgbruI/xVPN/R47ghQVSwaOVsQP+s6yfhtoO0bsrGiNA
         fxZ9opgCucg/f+JEHS7O2G4fdB6z7FWBkNGK3/8Gq0fLyU/DmIQI/i8VzX9HJRGFpeWK
         bJgA==
X-Gm-Message-State: AOJu0YwVyMHo78RiMK87oBS+qM+hETX4/JgxoJc54O1imkrhMzOkmhmQ
	dV6dGq4KsTTt/5XI2+PX5E7R6Q==
X-Google-Smtp-Source: AGHT+IGfndV/3k6rdSSpdIesuC+ma43H3wDHyNoKIqhnNKmVdHkXbh2v619WcJ8xmuQj7PY/A9xp4g==
X-Received: by 2002:a05:600c:6012:b0:40c:32fe:e123 with SMTP id az18-20020a05600c601200b0040c32fee123mr827986wmb.167.1703172252551;
        Thu, 21 Dec 2023 07:24:12 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:2db4:9d2a:db65:42d6])
        by smtp.gmail.com with ESMTPSA id t3-20020a05600c450300b0040c4acaa4bfsm11466974wmo.19.2023.12.21.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 07:24:11 -0800 (PST)
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
Subject: [PATCH v2 1/5] cpufreq: Add a cpufreq pressure feedback for the scheduler
Date: Thu, 21 Dec 2023 16:24:03 +0100
Message-Id: <20231221152407.436177-2-vincent.guittot@linaro.org>
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

Provide to the scheduler a feedback about the temporary max available
capacity. Unlike arch_update_thermal_pressure, this doesn't need to be
filtered as the pressure will happen for dozens ms or more.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   | 10 ++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 44db4f59c4cc..15bd41f9bb5e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2563,6 +2563,38 @@ int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu)
 }
 EXPORT_SYMBOL(cpufreq_get_policy);
 
+DEFINE_PER_CPU(unsigned long, cpufreq_pressure);
+
+/**
+ * cpufreq_update_pressure() - Update cpufreq pressure for CPUs
+ * @policy: cpufreq policy of the CPUs.
+ *
+ * Update the value of cpufreq pressure for all @cpus in the policy.
+ */
+static void cpufreq_update_pressure(struct cpufreq_policy *policy)
+{
+	unsigned long max_capacity, capped_freq, pressure;
+	u32 max_freq;
+	int cpu;
+
+	cpu = cpumask_first(policy->related_cpus);
+	pressure = max_capacity = arch_scale_cpu_capacity(cpu);
+	capped_freq = policy->max;
+	max_freq = arch_scale_freq_ref(cpu);
+
+	/*
+	 * Handle properly the boost frequencies, which should simply clean
+	 * the thermal pressure value.
+	 */
+	if (max_freq <= capped_freq)
+		pressure -= max_capacity;
+	else
+		pressure -= mult_frac(max_capacity, capped_freq, max_freq);
+
+	for_each_cpu(cpu, policy->related_cpus)
+		WRITE_ONCE(per_cpu(cpufreq_pressure, cpu), pressure);
+}
+
 /**
  * cpufreq_set_policy - Modify cpufreq policy parameters.
  * @policy: Policy object to modify.
@@ -2618,6 +2650,8 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 	policy->max = __resolve_freq(policy, policy->max, CPUFREQ_RELATION_H);
 	trace_cpu_frequency_limits(policy);
 
+	cpufreq_update_pressure(policy);
+
 	policy->cached_target_freq = UINT_MAX;
 
 	pr_debug("new min and max freqs are %u - %u kHz\n",
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index afda5f24d3dd..b1d97edd3253 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -241,6 +241,12 @@ struct kobject *get_governor_parent_kobj(struct cpufreq_policy *policy);
 void cpufreq_enable_fast_switch(struct cpufreq_policy *policy);
 void cpufreq_disable_fast_switch(struct cpufreq_policy *policy);
 bool has_target_index(void);
+
+DECLARE_PER_CPU(unsigned long, cpufreq_pressure);
+static inline unsigned long cpufreq_get_pressure(int cpu)
+{
+	return per_cpu(cpufreq_pressure, cpu);
+}
 #else
 static inline unsigned int cpufreq_get(unsigned int cpu)
 {
@@ -263,6 +269,10 @@ static inline bool cpufreq_supports_freq_invariance(void)
 	return false;
 }
 static inline void disable_cpufreq(void) { }
+static inline unsigned long cpufreq_get_pressure(int cpu)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_CPU_FREQ_STAT
-- 
2.34.1


