Return-Path: <linux-pm+bounces-8010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 764F68CA75C
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 06:32:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 336DA2822A8
	for <lists+linux-pm@lfdr.de>; Tue, 21 May 2024 04:32:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6339714286;
	Tue, 21 May 2024 04:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gbaq5mWh"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6B433C2
	for <linux-pm@vger.kernel.org>; Tue, 21 May 2024 04:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716265924; cv=none; b=cJwGH7XQxBv2SKKGfPJti507ZV3IjLPdC2OMO85no/1Uj0Ybm/lCZieLxxOu5H/DlQx/Q3+ofAp0XWM3oMiDT6Pkz8NstzphL+esHzZFn0ILHOLpks92EuLD6QEr9bJIcftVNbOQB8Q5lZPtEbDpvaIw/Uown6w66p4bA+8BBiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716265924; c=relaxed/simple;
	bh=iBwp2Vj9uLk5Y//NA+Wut1/pctBdAQY16j9PbohDqLk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p3QxwkAjIxSNq9n6q5NFvPiX2OyYagYszuQp4OlV8eJhNXyLKi9PHf+e+qTChOeKrgXOJIq25daHsWvs7RJmQwUZmaER/646iVl1JaSSvdsxKBsaTqGK70OPJZlUCdvdDjBCvBsh/j9qRK4TbwTBamdGPkCUzD0p1HZykDtxrlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gbaq5mWh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidai.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de60321ce6cso22486006276.1
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2024 21:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716265921; x=1716870721; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmhYe5cUmLkxxOw4n/BR7abloLQPh8yyUfUqe+iOKso=;
        b=gbaq5mWh+bP5cpsKeQL6mJUeW4t4YqiOIu5Rox8K1CNdzKF2htbhxn2fKt7qcjA6QM
         N9P6xbqmZky6ahcs3xKTaVBf+S7jk4NvYPkwLvHvhwt1cDnPY1/mLqTUqwR9sjkeGehk
         0ga/YztMvRiKllDfAqemHY+0q7xwBvaS5DAozDhM30ckz1RdTR799f2tuAkuYzO2C533
         +PKqdg/ASbPHGJSI24PomAtYpIlUcXNoQRuRWYUVxDv5GsxBBYcNYVuVKgPyYzieyoxQ
         lT751IlesP6IHEDRNHTT1Pb3u/S+AkJMTrf/UCyfkjTzKflsE9Ds4SLjdnTbtLbWCNCH
         K85w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716265921; x=1716870721;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmhYe5cUmLkxxOw4n/BR7abloLQPh8yyUfUqe+iOKso=;
        b=i4ZLoB/K+bm96BiplhKH4moEtrgxUL5JadZIWJoZslZTZMajQsyZQgRMIPoRYtKndK
         P1AaDVTsQVSpc/vJDBu9+y+KG/GJKy2ROQcDvS83kl6MWzldkHdcTyLkj6tRE2YZTakT
         eEb4tKjWXFq59oi5XCzN5cCTX+qtArNzbpGV6T++69yd9YIzliDGiXYDDF0eFKEKr2xQ
         T7z+McQlKHXovaOiGqg5gs4kw/EWouTHIb+TrERINj1JeLKUeHOR15zN3jp2VgZK/KZb
         XMasPzn/gCulGj+XwmXFqE9ZCC5cNtb4ZM1s6pICDiLiWdZQwZxjD/YFM4mGYN5gKw/Q
         6cmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUbc9ZHctsySiU49b+bWmCebFgIulliR8SHDqC8qgnIF9zXQtPPj9qBS2JzFYKYM8wToDV7JqhKM6x3eckE7wW0jn2/4qpdXE=
X-Gm-Message-State: AOJu0YzpHpqDFE3UGKELaan+3KEOiC2Ujp3qEupZGKS4SGJj0BgWhdT3
	ic0hSn/b6TJBofO+wTdNm8d1ZIUCaME2/q83fBf7CZsdu0SrEZ+9IIjGYi5jvuPkAbW2ph6M5Kd
	2zTH9ow==
X-Google-Smtp-Source: AGHT+IEx3/bMKfThUuZjv8USc7UYBv/ckqjtneMHdE3WXb/3BPmYwMAgrI1ls4YaAxFU2WyUtMwGspeG5ojK
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:ffe6:3bcf:e120:a07a])
 (user=davidai job=sendgmr) by 2002:a05:6902:102a:b0:df4:90aa:f4ac with SMTP
 id 3f1490d57ef6-df490aafcadmr2471016276.9.1716265921579; Mon, 20 May 2024
 21:32:01 -0700 (PDT)
Date: Mon, 20 May 2024 21:30:52 -0700
In-Reply-To: <20240521043102.2786284-1-davidai@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240521043102.2786284-1-davidai@google.com>
X-Mailer: git-send-email 2.45.0.215.g3402c0e53f-goog
Message-ID: <20240521043102.2786284-3-davidai@google.com>
Subject: [PATCH v6 2/2] cpufreq: add virtual-cpufreq driver
From: David Dai <davidai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Sudeep Holla <sudeep.holla@arm.com>, David Dai <davidai@google.com>, 
	Saravana Kannan <saravanak@google.com>
Cc: Quentin Perret <qperret@google.com>, Masami Hiramatsu <mhiramat@google.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Marc Zyngier <maz@kernel.org>, 
	Oliver Upton <oliver.upton@linux.dev>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Pavan Kondeti <quic_pkondeti@quicinc.com>, Gupta Pankaj <pankaj.gupta@amd.com>, 
	Mel Gorman <mgorman@suse.de>, kernel-team@android.com, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce a virtualized cpufreq driver for guest kernels to improve
performance and power of workloads within VMs.

This driver does two main things:

1. Sends the frequency of vCPUs as a hint to the host. The host uses the
hint to schedule the vCPU threads and decide physical CPU frequency.

2. If a VM does not support a virtualized FIE(like AMUs), it queries the
host CPU frequency by reading a MMIO region of a virtual cpufreq device
to update the guest's frequency scaling factor periodically. This enables
accurate Per-Entity Load Tracking for tasks running in the guest.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 drivers/cpufreq/Kconfig           |  14 ++
 drivers/cpufreq/Makefile          |   1 +
 drivers/cpufreq/virtual-cpufreq.c | 335 ++++++++++++++++++++++++++++++
 include/linux/arch_topology.h     |   1 +
 4 files changed, 351 insertions(+)
 create mode 100644 drivers/cpufreq/virtual-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 94e55c40970a..9aa86bec5793 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,20 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_VIRT
+	tristate "Virtual cpufreq driver"
+	depends on OF && GENERIC_ARCH_TOPOLOGY
+	help
+	  This adds a virtualized cpufreq driver for guest kernels that
+	  read/writes to a MMIO region for a virtualized cpufreq device to
+	  communicate with the host. It sends performance requests to the host
+	  which gets used as a hint to schedule vCPU threads and select CPU
+	  frequency. If a VM does not support a virtualized FIE such as AMUs,
+	  it updates the frequency scaling factor by polling host CPU frequency
+	  to enable accurate Per-Entity Load Tracking for tasks running in the guest.
+
+	  If in doubt, say N.
+
 config CPUFREQ_DT_PLATDEV
 	tristate "Generic DT based cpufreq platdev driver"
 	depends on OF
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 8d141c71b016..eb72ecdc24db 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
+obj-$(CONFIG_CPUFREQ_VIRT)		+= virtual-cpufreq.o
 
 # Traces
 CFLAGS_amd-pstate-trace.o               := -I$(src)
diff --git a/drivers/cpufreq/virtual-cpufreq.c b/drivers/cpufreq/virtual-cpufreq.c
new file mode 100644
index 000000000000..59ce2bda3913
--- /dev/null
+++ b/drivers/cpufreq/virtual-cpufreq.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Google LLC
+ */
+
+#include <linux/arch_topology.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+/*
+ * CPU0..CPUn
+ * +-------------+-------------------------------+--------+-------+
+ * | Register    | Description                   | Offset |   Len |
+ * +-------------+-------------------------------+--------+-------+
+ * | cur_perf    | read this register to get     |    0x0 |   0x4 |
+ * |             | the current perf (integer val |        |       |
+ * |             | representing perf relative to |        |       |
+ * |             | max performance)              |        |       |
+ * |             | that vCPU is running at       |        |       |
+ * +-------------+-------------------------------+--------+-------+
+ * | set_perf    | write to this register to set |    0x4 |   0x4 |
+ * |             | perf value of the vCPU        |        |       |
+ * +-------------+-------------------------------+--------+-------+
+ * | perftbl_len | number of entries in perf     |    0x8 |   0x4 |
+ * |             | table. A single entry in the  |        |       |
+ * |             | perf table denotes no table   |        |       |
+ * |             | and the entry contains        |        |       |
+ * |             | the maximum perf value        |        |       |
+ * |             | that this vCPU supports.      |        |       |
+ * |             | The guest can request any     |        |       |
+ * |             | value between 1 and max perf  |        |       |
+ * |             | when perftbls are not used.   |        |       |
+ * +---------------------------------------------+--------+-------+
+ * | perftbl_sel | write to this register to     |    0xc |   0x4 |
+ * |             | select perf table entry to    |        |       |
+ * |             | read from                     |        |       |
+ * +---------------------------------------------+--------+-------+
+ * | perftbl_rd  | read this register to get     |   0x10 |   0x4 |
+ * |             | perf value of the selected    |        |       |
+ * |             | entry based on perftbl_sel    |        |       |
+ * +---------------------------------------------+--------+-------+
+ * | perf_domain | performance domain number     |   0x14 |   0x4 |
+ * |             | that this vCPU belongs to.    |        |       |
+ * |             | vCPUs sharing the same perf   |        |       |
+ * |             | domain number are part of the |        |       |
+ * |             | same performance domain.      |        |       |
+ * +-------------+-------------------------------+--------+-------+
+ */
+
+#define REG_CUR_PERF_STATE_OFFSET 0x0
+#define REG_SET_PERF_STATE_OFFSET 0x4
+#define REG_PERFTBL_LEN_OFFSET 0x8
+#define REG_PERFTBL_SEL_OFFSET 0xc
+#define REG_PERFTBL_RD_OFFSET 0x10
+#define REG_PERF_DOMAIN_OFFSET 0x14
+#define PER_CPU_OFFSET 0x1000
+
+#define PERFTBL_MAX_ENTRIES 64U
+
+static void __iomem *base;
+static DEFINE_PER_CPU(u32, perftbl_num_entries);
+
+static void virt_scale_freq_tick(void)
+{
+	int cpu = smp_processor_id();
+	u32 max_freq = (u32)cpufreq_get_hw_max_freq(cpu);
+	u64 cur_freq;
+	unsigned long scale;
+
+	cur_freq = (u64)readl_relaxed(base + cpu * PER_CPU_OFFSET
+			+ REG_CUR_PERF_STATE_OFFSET);
+
+	cur_freq <<= SCHED_CAPACITY_SHIFT;
+	scale = (unsigned long)div_u64(cur_freq, max_freq);
+	scale = min(scale, SCHED_CAPACITY_SCALE);
+
+	this_cpu_write(arch_freq_scale, scale);
+}
+
+static struct scale_freq_data virt_sfd = {
+	.source = SCALE_FREQ_SOURCE_VIRT,
+	.set_freq_scale = virt_scale_freq_tick,
+};
+
+static unsigned int virt_cpufreq_set_perf(struct cpufreq_policy *policy,
+					  unsigned int target_freq)
+{
+	writel_relaxed(target_freq,
+		       base + policy->cpu * PER_CPU_OFFSET + REG_SET_PERF_STATE_OFFSET);
+	return 0;
+}
+
+static unsigned int virt_cpufreq_fast_switch(struct cpufreq_policy *policy,
+					     unsigned int target_freq)
+{
+	virt_cpufreq_set_perf(policy, target_freq);
+	return target_freq;
+}
+
+static u32 virt_cpufreq_get_perftbl_entry(int cpu, u32 idx)
+{
+	writel_relaxed(idx, base + cpu * PER_CPU_OFFSET +
+		       REG_PERFTBL_SEL_OFFSET);
+	return readl_relaxed(base + cpu * PER_CPU_OFFSET +
+			     REG_PERFTBL_RD_OFFSET);
+}
+
+static int virt_cpufreq_target(struct cpufreq_policy *policy,
+			       unsigned int target_freq,
+			       unsigned int relation)
+{
+	struct cpufreq_freqs freqs;
+	int ret = 0;
+
+	freqs.old = policy->cur;
+	freqs.new = target_freq;
+
+	cpufreq_freq_transition_begin(policy, &freqs);
+	ret = virt_cpufreq_set_perf(policy, target_freq);
+	cpufreq_freq_transition_end(policy, &freqs, ret != 0);
+
+	return ret;
+}
+
+static int virt_cpufreq_get_sharing_cpus(struct cpufreq_policy *policy)
+{
+	u32 cur_perf_domain, perf_domain;
+	struct device *cpu_dev;
+	int cpu;
+
+	cur_perf_domain = readl_relaxed(base + policy->cpu *
+					PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
+
+	for_each_possible_cpu(cpu) {
+		cpu_dev = get_cpu_device(cpu);
+		if (!cpu_dev)
+			continue;
+
+		perf_domain = readl_relaxed(base + cpu *
+					    PER_CPU_OFFSET + REG_PERF_DOMAIN_OFFSET);
+
+		if (perf_domain == cur_perf_domain)
+			cpumask_set_cpu(cpu, policy->cpus);
+	}
+
+	return 0;
+}
+
+static int virt_cpufreq_get_freq_info(struct cpufreq_policy *policy)
+{
+	struct cpufreq_frequency_table *table;
+	u32 num_perftbl_entries, idx;
+
+	num_perftbl_entries = per_cpu(perftbl_num_entries, policy->cpu);
+
+	if (num_perftbl_entries == 1) {
+		policy->cpuinfo.min_freq = 1;
+		policy->cpuinfo.max_freq = virt_cpufreq_get_perftbl_entry(policy->cpu, 0);
+
+		policy->min = policy->cpuinfo.min_freq;
+		policy->max = policy->cpuinfo.max_freq;
+
+		policy->cur = policy->max;
+		return 0;
+	}
+
+	table = kcalloc(num_perftbl_entries + 1, sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	for (idx = 0; idx < num_perftbl_entries; idx++)
+		table[idx].frequency = virt_cpufreq_get_perftbl_entry(policy->cpu, idx);
+
+	table[idx].frequency = CPUFREQ_TABLE_END;
+	policy->freq_table = table;
+
+	return 0;
+}
+
+static int virt_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev;
+	int ret;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev)
+		return -ENODEV;
+
+	ret = virt_cpufreq_get_freq_info(policy);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to get cpufreq info\n");
+		return ret;
+	}
+
+	ret = virt_cpufreq_get_sharing_cpus(policy);
+	if (ret) {
+		dev_warn(cpu_dev, "failed to get sharing cpumask\n");
+		return ret;
+	}
+
+	/*
+	 * To simplify and improve latency of handling frequency requests on
+	 * the host side, this ensures that the vCPU thread triggering the MMIO
+	 * abort is the same thread whose performance constraints (Ex. uclamp
+	 * settings) need to be updated. This simplifies the VMM (Virtual
+	 * Machine Manager) having to find the correct vCPU thread and/or
+	 * facing permission issues when configuring other threads.
+	 */
+	policy->dvfs_possible_from_any_cpu = false;
+	policy->fast_switch_possible = true;
+
+	/*
+	 * Using the default SCALE_FREQ_SOURCE_CPUFREQ is insufficient since
+	 * the actual physical CPU frequency may not match requested frequency
+	 * from the vCPU thread due to frequency update latencies or other
+	 * inputs to the physical CPU frequency selection. This additional FIE
+	 * source allows for more accurate freq_scale updates and only takes
+	 * effect if another FIE source such as AMUs have not been registered.
+	 */
+	topology_set_scale_freq_source(&virt_sfd, policy->cpus);
+
+	return 0;
+}
+
+static int virt_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	topology_clear_scale_freq_source(SCALE_FREQ_SOURCE_VIRT, policy->related_cpus);
+	kfree(policy->freq_table);
+	return 0;
+}
+
+static int virt_cpufreq_online(struct cpufreq_policy *policy)
+{
+	/* Nothing to restore. */
+	return 0;
+}
+
+static int virt_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	/* Dummy offline() to avoid exit() being called and freeing resources. */
+	return 0;
+}
+
+static int virt_cpufreq_verify_policy(struct cpufreq_policy_data *policy)
+{
+	if (policy->freq_table)
+		return cpufreq_frequency_table_verify(policy, policy->freq_table);
+
+	cpufreq_verify_within_cpu_limits(policy);
+	return 0;
+}
+
+static struct cpufreq_driver cpufreq_virt_driver = {
+	.name		= "virt-cpufreq",
+	.init		= virt_cpufreq_cpu_init,
+	.exit		= virt_cpufreq_cpu_exit,
+	.online         = virt_cpufreq_online,
+	.offline        = virt_cpufreq_offline,
+	.verify		= virt_cpufreq_verify_policy,
+	.target		= virt_cpufreq_target,
+	.fast_switch	= virt_cpufreq_fast_switch,
+	.attr		= cpufreq_generic_attr,
+};
+
+static int virt_cpufreq_driver_probe(struct platform_device *pdev)
+{
+	u32 num_perftbl_entries;
+	int ret, cpu;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	for_each_possible_cpu(cpu) {
+		num_perftbl_entries = readl_relaxed(base + cpu * PER_CPU_OFFSET +
+						    REG_PERFTBL_LEN_OFFSET);
+
+		if (!num_perftbl_entries || num_perftbl_entries > PERFTBL_MAX_ENTRIES)
+			return -ENODEV;
+
+		per_cpu(perftbl_num_entries, cpu) = num_perftbl_entries;
+	}
+
+	ret = cpufreq_register_driver(&cpufreq_virt_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "Virtual CPUFreq driver failed to register: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "Virtual CPUFreq driver initialized\n");
+	return 0;
+}
+
+static int virt_cpufreq_driver_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&cpufreq_virt_driver);
+	return 0;
+}
+
+static const struct of_device_id virt_cpufreq_match[] = {
+	{ .compatible = "qemu,virtual-cpufreq", .data = NULL},
+	{}
+};
+MODULE_DEVICE_TABLE(of, virt_cpufreq_match);
+
+static struct platform_driver virt_cpufreq_driver = {
+	.probe = virt_cpufreq_driver_probe,
+	.remove = virt_cpufreq_driver_remove,
+	.driver = {
+		.name = "virt-cpufreq",
+		.of_match_table = virt_cpufreq_match,
+	},
+};
+
+static int __init virt_cpufreq_init(void)
+{
+	return platform_driver_register(&virt_cpufreq_driver);
+}
+postcore_initcall(virt_cpufreq_init);
+
+static void __exit virt_cpufreq_exit(void)
+{
+	platform_driver_unregister(&virt_cpufreq_driver);
+}
+module_exit(virt_cpufreq_exit);
+
+MODULE_DESCRIPTION("Virtual cpufreq driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/arch_topology.h b/include/linux/arch_topology.h
index b721f360d759..d5d848849408 100644
--- a/include/linux/arch_topology.h
+++ b/include/linux/arch_topology.h
@@ -49,6 +49,7 @@ enum scale_freq_source {
 	SCALE_FREQ_SOURCE_CPUFREQ = 0,
 	SCALE_FREQ_SOURCE_ARCH,
 	SCALE_FREQ_SOURCE_CPPC,
+	SCALE_FREQ_SOURCE_VIRT,
 };
 
 struct scale_freq_data {
-- 
2.45.0.215.g3402c0e53f-goog


