Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12A27CE2B2
	for <lists+linux-pm@lfdr.de>; Wed, 18 Oct 2023 18:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjJRQ0E (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 18 Oct 2023 12:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232768AbjJRQ0B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2023 12:26:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C14195
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 09:25:56 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40566f8a093so65769595e9.3
        for <linux-pm@vger.kernel.org>; Wed, 18 Oct 2023 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697646355; x=1698251155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eArmcx/3FLROUNKiplu862Py9rk3Ajq2JK2reW61wO4=;
        b=P0vJ+LPBt7AarGhehgMf3Q8LeLyeYzEOP4bQkcdZNBOjpcYSwOS/QSGz16cSxqaxFB
         kQV9GfYQmmOmSuAWGX0LX6ejI+D2FsxSkKM/7TXvx9r9fiTsfCNUaXr0C/xrKeSPh1gF
         1XH1U/t31m4HKTr+dRip6mEq/pANRI/eGSmNGsTP9Q0kGBvvMGQ6pm3gAbEu+1xSd7XL
         AC+6ESsAfOZprisQgQZ5kL/Qq+cvREDwrluCkTrgFzGjfzJnta21VaKh5MXcC+D2EFWU
         Ub7/EAjmNVhqYl73lfvigW8F5v0rAiMnHS9AfyDobnU0ivNLZTsdOYEHSTxS9fjrtQGM
         OYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697646355; x=1698251155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eArmcx/3FLROUNKiplu862Py9rk3Ajq2JK2reW61wO4=;
        b=xFel1ljhluEmVUVls0QwdnJUoePwozlGM+a5A/WoKXvGT2mIbQqRxh8sdmnLyVJ8vz
         yjHSxTi5AT9f9Ncq/otnoloNZYe75r3lZPzRzx9xKSo8rUt9Kr4EE7weufIACbvyIHSL
         jP3gaO8Q04Z+n/ZpKTyAlSkyA04DdLVmrKLod9pOVXSF+kZ6kaBLGAMp8nlHpeJocNlk
         QzoJwKUSZuqApEQ63RAvw249ryCrJwWj9D9Jjy6+bTLo2s0EJCIOizi5+UqjWXQhMKYt
         e4384xHWsvgaP4u/wvi+84Rre6z+P49J6QxCHge+K6gfcpK/ATS00Yhx3qBY1hmzMYRf
         MsYA==
X-Gm-Message-State: AOJu0YyZExwB3szSp9YJxx69OdSt/PvIf8aqCU1BxfrCKncIb2H/xcoG
        xLJSxEC8+SRd00E6Zq1mJIhR1g==
X-Google-Smtp-Source: AGHT+IHH1bVKQkcxpQpcPOoV/O1pBJJD4yJy2dQNFZQDh2nUUXXHgkf49JAtvSqW4FBs4vqcEmXUnA==
X-Received: by 2002:a05:600c:4686:b0:401:be5a:989 with SMTP id p6-20020a05600c468600b00401be5a0989mr4309734wmo.23.1697646355120;
        Wed, 18 Oct 2023 09:25:55 -0700 (PDT)
Received: from vingu-book.. ([2a01:e0a:f:6020:fcf4:9d83:8d0d:39aa])
        by smtp.gmail.com with ESMTPSA id q12-20020a05600c2e4c00b0040648217f4fsm2033503wmf.39.2023.10.18.09.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 09:25:54 -0700 (PDT)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        viresh.kumar@linaro.org, lenb@kernel.org, robert.moore@intel.com,
        lukasz.luba@arm.com, ionela.voinescu@arm.com,
        pierre.gondois@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org
Cc:     conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC v3 6/6] arm64/amu: use capacity_ref_freq to set AMU ratio
Date:   Wed, 18 Oct 2023 18:25:40 +0200
Message-Id: <20231018162540.667646-7-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231018162540.667646-1-vincent.guittot@linaro.org>
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Use the new capacity_ref_freq to set the ratio that is used by AMU for
computing the arch_scale_freq_capacity().
This helps to keep everything aligned using the same reference for
computing CPUs capacity.

The default value of the ratio ensures that arch_scale_freq_capacity()
returns max capacity until it is set to its correct value with the
cpu capacity and capacity_ref_freq.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 arch/arm64/kernel/topology.c  | 18 ++++++++++--------
 drivers/base/arch_topology.c  | 14 ++++++++++++--
 include/linux/arch_topology.h |  1 +
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788cd866..0f8f6e90c46d 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -82,7 +82,12 @@ int __init parse_acpi_topology(void)
 #undef pr_fmt
 #define pr_fmt(fmt) "AMU: " fmt
 
-static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale);
+/*
+ * Ensure that amu_scale_freq_tick() will return SCHED_CAPACITY_SHIFT until
+ * the CPU capacity and its assosciated frequency have been correctly
+ * initialized.
+ */
+static DEFINE_PER_CPU_READ_MOSTLY(unsigned long, arch_max_freq_scale) = (2 * SCHED_CAPACITY_SHIFT);
 static DEFINE_PER_CPU(u64, arch_const_cycles_prev);
 static DEFINE_PER_CPU(u64, arch_core_cycles_prev);
 static cpumask_var_t amu_fie_cpus;
@@ -112,9 +117,9 @@ static inline bool freq_counters_valid(int cpu)
 	return true;
 }
 
-static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
+int freq_inv_set_max_ratio(int cpu, u64 max_rate)
 {
-	u64 ratio;
+	u64 ratio, ref_rate = arch_timer_get_rate();
 
 	if (unlikely(!max_rate || !ref_rate)) {
 		pr_debug("CPU%d: invalid maximum or reference frequency.\n",
@@ -142,7 +147,7 @@ static int freq_inv_set_max_ratio(int cpu, u64 max_rate, u64 ref_rate)
 		return -EINVAL;
 	}
 
-	per_cpu(arch_max_freq_scale, cpu) = (unsigned long)ratio;
+	WRITE_ONCE(per_cpu(arch_max_freq_scale, cpu), (unsigned long)ratio);
 
 	return 0;
 }
@@ -195,10 +200,7 @@ static void amu_fie_setup(const struct cpumask *cpus)
 		return;
 
 	for_each_cpu(cpu, cpus) {
-		if (!freq_counters_valid(cpu) ||
-		    freq_inv_set_max_ratio(cpu,
-					   cpufreq_get_hw_max_freq(cpu) * 1000ULL,
-					   arch_timer_get_rate()))
+		if (!freq_counters_valid(cpu))
 			return;
 	}
 
diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 2372ce791bb4..3a604b77b12d 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -344,6 +344,11 @@ bool __init topology_parse_cpu_capacity(struct device_node *cpu_node, int cpu)
 	return !ret;
 }
 
+int __weak freq_inv_set_max_ratio(int cpu, u64 max_rate)
+{
+	return 0;
+}
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
@@ -369,7 +374,6 @@ void topology_init_cpu_capacity_cppc(void)
 			capacity_scale = max_t(u64, capacity_scale, raw_capacity[cpu]);
 
 			per_cpu(capacity_ref_freq, cpu) = cppc_perf_to_khz(&perf_caps, raw_capacity[cpu]);
-
 			pr_debug("cpu_capacity: CPU%d cpu_capacity=%u (raw).\n",
 				 cpu, raw_capacity[cpu]);
 			continue;
@@ -381,6 +385,9 @@ void topology_init_cpu_capacity_cppc(void)
 	}
 
 	for_each_possible_cpu(cpu) {
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_ref_freq, cpu));
+
 		capacity = raw_capacity[cpu];
 		capacity = div64_u64(capacity << SCHED_CAPACITY_SHIFT,
 				     capacity_scale);
@@ -422,8 +429,11 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 
 	cpumask_andnot(cpus_to_visit, cpus_to_visit, policy->related_cpus);
 
-	for_each_cpu(cpu, policy->related_cpus)
+	for_each_cpu(cpu, policy->related_cpus) {
 		per_cpu(capacity_ref_freq, cpu) = policy->cpuinfo.max_freq;
+		freq_inv_set_max_ratio(cpu,
+				       per_cpu(capacity_ref_freq, cpu));
+	}
 
 	if (cpumask_empty(cpus_to_visit)) {
 		topology_normalize_cpu_scale();
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index 38ca6c76af56..b6e95d763279 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -99,6 +99,7 @@ void update_siblings_masks(unsigned int cpu);
 void remove_cpu_topology(unsigned int cpuid);
 void reset_cpu_topology(void);
 int parse_acpi_topology(void);
+int freq_inv_set_max_ratio(int cpu, u64 max_rate);
 #endif
 
 #endif /* _LINUX_ARCH_TOPOLOGY_H_ */
-- 
2.34.1

