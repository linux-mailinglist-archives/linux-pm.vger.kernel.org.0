Return-Path: <linux-pm+bounces-14151-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FD0978127
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 083FE288342
	for <lists+linux-pm@lfdr.de>; Fri, 13 Sep 2024 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22121DB93E;
	Fri, 13 Sep 2024 13:30:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BFD1DB924;
	Fri, 13 Sep 2024 13:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726234214; cv=none; b=C72xwREqnE4TePG5KXF8oqM8HZq9qZdQeD5ihn4G/9KPB4CY7JSHyWpnX4PvND1bPxIkEjqBrLtzwAu+1IEKxJsjUO57W184IJsAcXJrl7STbMnwey+66olR9ipgrZFlS3en5iIoYPuKpY5uIJnlL26juqUZs8mfcLB0Cjq1scU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726234214; c=relaxed/simple;
	bh=Fo04DaqLuYN+fLnrUK1gfA8USPC+6X7tI51hiyG1a3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lzyUypFBeQ+VvMhAvvWBezqHAy76OjLmhG7uJIUYNulKQsgwZFdWCTBpUg8uYBmiPcFGjbLK3tkmuvCx8qAyiMhZn4dNr0b6UMk4MnZGy/6yDnMs62FFtTluY+u/0BJUOog51VZ1GbVqFgK5w+68Hu85YZXHNaXnYt+OHhdLv8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 930071477;
	Fri, 13 Sep 2024 06:30:41 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.194.73])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 779333F73B;
	Fri, 13 Sep 2024 06:30:10 -0700 (PDT)
From: Beata Michalska <beata.michalska@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	ionela.voinescu@arm.com,
	sudeep.holla@arm.com,
	will@kernel.org,
	catalin.marinas@arm.com,
	rafael@kernel.org,
	viresh.kumar@linaro.org
Cc: sumitg@nvidia.com,
	yang@os.amperecomputing.com,
	vanshikonda@os.amperecomputing.com,
	lihuisong@huawei.com,
	zhanjie9@hisilicon.com
Subject: [PATCH v7 1/4] cpufreq: Introduce an optional cpuinfo_avg_freq sysfs entry
Date: Fri, 13 Sep 2024 14:29:41 +0100
Message-Id: <20240913132944.1880703-2-beata.michalska@arm.com>
In-Reply-To: <20240913132944.1880703-1-beata.michalska@arm.com>
References: <20240913132944.1880703-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently the CPUFreq core exposes two sysfs attributes that can be used
to query current frequency of a given CPU(s): namely cpuinfo_cur_freq
and scaling_cur_freq. Both provide slightly different view on the
subject and they do come with their own drawbacks.

cpuinfo_cur_freq provides higher precision though at a cost of being
rather expensive. Moreover, the information retrieved via this attribute
is somewhat short lived as frequency can change at any point of time
making it difficult to reason from.

scaling_cur_freq, on the other hand, tends to be less accurate but then
the actual level of precision (and source of information) varies between
architectures making it a bit ambiguous.

The new attribute, cpuinfo_avg_freq, is intended to provide more stable,
distinct interface, exposing an average frequency of a given CPU(s), as
reported by the hardware, over a time frame spanning no more than a few
milliseconds. As it requires appropriate hardware support, this
interface is optional.

Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 Documentation/admin-guide/pm/cpufreq.rst | 10 ++++++++
 drivers/cpufreq/cpufreq.c                | 31 ++++++++++++++++++++++++
 include/linux/cpufreq.h                  |  1 +
 3 files changed, 42 insertions(+)

diff --git a/Documentation/admin-guide/pm/cpufreq.rst b/Documentation/admin-guide/pm/cpufreq.rst
index fe1be4ad88cb..2204d6132c05 100644
--- a/Documentation/admin-guide/pm/cpufreq.rst
+++ b/Documentation/admin-guide/pm/cpufreq.rst
@@ -248,6 +248,16 @@ are the following:
 	If that frequency cannot be determined, this attribute should not
 	be present.
 
+``cpuinfo_avg_freq``
+        An average frequency (in KHz) of all CPUs belonging to a given policy,
+        derived from a hardware provided feedback and reported on a time frame
+        spanning at most few milliseconds.
+
+        This is expected to be based on the frequency the hardware actually runs
+        at and, as such, might require specialised hardware support (such as AMU
+        extension on ARM). If one cannot be determined, this attribute should
+        not be present.
+
 ``cpuinfo_max_freq``
 	Maximum possible operating frequency the CPUs belonging to this policy
 	can run at (in kHz).
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 04fc786dd2c0..3493e5a9500d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -752,6 +752,16 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
 	return 0;
 }
 
+__weak int arch_freq_avg_get_on_cpu(int cpu)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline bool cpufreq_avg_freq_supported(struct cpufreq_policy *policy)
+{
+	return arch_freq_avg_get_on_cpu(policy->cpu) >= 0;
+}
+
 static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 {
 	ssize_t ret;
@@ -802,6 +812,20 @@ static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 	return sysfs_emit(buf, "<unknown>\n");
 }
 
+/*
+ * show_cpuinfo_avg_freq - average CPU frequency as detected by hardware
+ */
+static ssize_t show_cpuinfo_avg_freq(struct cpufreq_policy *policy,
+				     char *buf)
+{
+	int avg_freq = arch_freq_avg_get_on_cpu(policy->cpu);
+
+	if (avg_freq > 0)
+		return sysfs_emit(buf, "%u\n", avg_freq);
+
+	return sysfs_emit(buf, "<unknown>\n");
+}
+
 /*
  * show_scaling_governor - show the current policy for the specified CPU
  */
@@ -964,6 +988,7 @@ static ssize_t show_bios_limit(struct cpufreq_policy *policy, char *buf)
 }
 
 cpufreq_freq_attr_ro_perm(cpuinfo_cur_freq, 0400);
+cpufreq_freq_attr_ro(cpuinfo_avg_freq);
 cpufreq_freq_attr_ro(cpuinfo_min_freq);
 cpufreq_freq_attr_ro(cpuinfo_max_freq);
 cpufreq_freq_attr_ro(cpuinfo_transition_latency);
@@ -1091,6 +1116,12 @@ static int cpufreq_add_dev_interface(struct cpufreq_policy *policy)
 			return ret;
 	}
 
+	if (cpufreq_avg_freq_supported(policy)) {
+		ret = sysfs_create_file(&policy->kobj, &cpuinfo_avg_freq.attr);
+		if (ret)
+			return ret;
+	}
+
 	ret = sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
 	if (ret)
 		return ret;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index d4d2f4d1d7cb..48262073707e 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -1195,6 +1195,7 @@ static inline int of_perf_domain_get_sharing_cpumask(int pcpu, const char *list_
 #endif
 
 extern unsigned int arch_freq_get_on_cpu(int cpu);
+extern int arch_freq_avg_get_on_cpu(int cpu);
 
 #ifndef arch_set_freq_scale
 static __always_inline
-- 
2.25.1


