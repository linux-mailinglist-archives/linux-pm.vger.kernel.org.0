Return-Path: <linux-pm+bounces-29565-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CB0AE99FE
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 11:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7295D4A6FB3
	for <lists+linux-pm@lfdr.de>; Thu, 26 Jun 2025 09:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5EB2C031B;
	Thu, 26 Jun 2025 09:30:49 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A1A295DAA;
	Thu, 26 Jun 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750930249; cv=none; b=hqc8JfDcqQgehuS3XTH4RW2oLrdpxYlbz1R8Q+Z+ifcltWFuwTUADUg/B3N33NbjnbtePrPM8IblbEpq8FrOZZxcjoRWbUO16DcCMWWk+OnESLPdRZQruIHARDpI/p+m0S0lnobkiTojmM70ldqm3ZZ2tbkFNiJ37EhIJlZuyTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750930249; c=relaxed/simple;
	bh=3s6usKiJD5sKkUXuZnQU8k249aZMs0i8lS5Xo2pslDQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DO+HSkwigcA+mDozpr2X6+lvkC3/NTbG7AMR4IA1pom4HhwFd2debcUTIoG2F5mwIvDmzLiIMfwvafNnCvTS4X0iS4QCMPxJWi14LuACSX/RwPYeoO3a7tgpQgv+OAQbpJwkH+X52QkzxR2GfRNQA7iDqJChq8kHHOrsBklqdzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8FFDB1063;
	Thu, 26 Jun 2025 02:30:28 -0700 (PDT)
Received: from e125579.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 71B823F63F;
	Thu, 26 Jun 2025 02:30:44 -0700 (PDT)
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Christian Loehle <christian.loehle@arm.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robin Murphy <robin.murphy@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	zhenglifeng1@huawei.com
Subject: [RFC PATCH] cpufreq,base/arch_topology: Calculate cpu_capacity according to boost
Date: Thu, 26 Jun 2025 11:30:18 +0200
Message-Id: <20250626093018.106265-1-dietmar.eggemann@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I noticed on my Arm64 big.Little platform (Juno-r0, scmi-cpufreq) that
the cpu_scale values (/sys/devices/system/cpu/cpu*/cpu_capacity) of the
little CPU changed in v6.14 from 446 to 505. I bisected and found that
commit dd016f379ebc ("cpufreq: Introduce a more generic way to set
default per-policy boost flag") (1) introduced this change.
Juno's scmi FW marks the 2 topmost OPPs of each CPUfreq policy (policy0:
775000 850000, policy1: 950000 1100000) as boost OPPs.

The reason is that the 'policy->boost_enabled = true' is now done after
'cpufreq_table_validate_and_sort() -> cpufreq_frequency_table_cpuinfo()'
in cpufreq_online() so that 'policy->cpuinfo.max_freq' is set to the
'highest non-boost' instead of the 'highest boost' frequency.

This is before the CPUFREQ_CREATE_POLICY notifier is fired in
cpufreq_online() to which the cpu_capacity setup code in
[drivers/base/arch_topology.c] has registered.

Its notifier_call init_cpu_capacity_callback() uses
'policy->cpuinfo.max_freq' to set the per-cpu
capacity_freq_ref so that the cpu_capacity can be calculated as:

cpu_capacity = raw_cpu_capacity (2) * capacity_freq_ref /
				      'max system-wide cpu frequency'

(2) Juno's little CPU has 'capacity-dmips-mhz = <578>'.

So before (1) for a little CPU:

cpu_capacity = 578 * 850000 / 1100000 = 446

and after:

cpu_capacity = 578 * 700000 / 800000 = 505

This issue can also be seen on Arm64 boards with cpufreq-dt drivers
using the 'turbo-mode' dt property for boosted OPPs.

What's actually needed IMHO is to calculate cpu_capacity according to
the boost value. I.e.:

(a) The infrastructure to adjust cpu_capacity in arch_topology.c has to
    be kept alive after boot.

(b) There has to be some kind of notification from cpufreq.c to
    arch_topology.c about the toggling of boost. I'm abusing
    CPUFREQ_CREATE_POLICY for this right now. Could we perhaps add a
    CPUFREQ_MOD_POLICY for this?

(c) Allow unconditional set of policy->cpuinfo.max_freq in case boost
    is set to 0 in cpufreq_frequency_table_cpuinfo().
    This currently clashes with the commented feature that in case the
    driver has set a higher value it should stay untouched.

Tested on Arm64 Juno (scmi-cpufreq) and Hikey 960 (cpufreq-dt +
added 'turbo-mode' to the topmost OPPs in dts file).

This is probably related what Christian Loehle tried to address in
https://lkml.kernel.org/r/3cc5b83b-f81c-4bd7-b7ff-4d02db4e25d8@arm.com .

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/base/arch_topology.c | 11 -----------
 drivers/cpufreq/cpufreq.c    |  3 +++
 drivers/cpufreq/freq_table.c |  8 +-------
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1c3221ff1d1f..0a3916dc9644 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -378,8 +378,6 @@ void acpi_processor_init_invariance_cppc(void)
 
 #ifdef CONFIG_CPU_FREQ
 static cpumask_var_t cpus_to_visit;
-static void parsing_done_workfn(struct work_struct *work);
-static DECLARE_WORK(parsing_done_work, parsing_done_workfn);
 
 static int
 init_cpu_capacity_callback(struct notifier_block *nb,
@@ -408,10 +406,8 @@ init_cpu_capacity_callback(struct notifier_block *nb,
 		if (raw_capacity) {
 			topology_normalize_cpu_scale();
 			schedule_work(&update_topology_flags_work);
-			free_raw_capacity();
 		}
 		pr_debug("cpu_capacity: parsing done\n");
-		schedule_work(&parsing_done_work);
 	}
 
 	return 0;
@@ -447,13 +443,6 @@ static int __init register_cpufreq_notifier(void)
 }
 core_initcall(register_cpufreq_notifier);
 
-static void parsing_done_workfn(struct work_struct *work)
-{
-	cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
-					 CPUFREQ_POLICY_NOTIFIER);
-	free_cpumask_var(cpus_to_visit);
-}
-
 #else
 core_initcall(free_raw_capacity);
 #endif
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index d7426e1d8bdd..6fdfcb6815d7 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2798,6 +2798,9 @@ int cpufreq_boost_set_sw(struct cpufreq_policy *policy, int state)
 		return ret;
 	}
 
+	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
+				     CPUFREQ_CREATE_POLICY, policy);
+
 	ret = freq_qos_update_request(policy->max_freq_req, policy->max);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
index 35de513af6c9..06068a12ec53 100644
--- a/drivers/cpufreq/freq_table.c
+++ b/drivers/cpufreq/freq_table.c
@@ -51,13 +51,7 @@ int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 	}
 
 	policy->min = policy->cpuinfo.min_freq = min_freq;
-	policy->max = max_freq;
-	/*
-	 * If the driver has set its own cpuinfo.max_freq above max_freq, leave
-	 * it as is.
-	 */
-	if (policy->cpuinfo.max_freq < max_freq)
-		policy->max = policy->cpuinfo.max_freq = max_freq;
+	policy->max = policy->cpuinfo.max_freq = max_freq;
 
 	if (policy->min == ~0)
 		return -EINVAL;
-- 
2.34.1


