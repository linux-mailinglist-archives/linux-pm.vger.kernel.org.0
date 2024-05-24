Return-Path: <linux-pm+bounces-8103-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3333F8CE571
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 14:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EA1E1C20F50
	for <lists+linux-pm@lfdr.de>; Fri, 24 May 2024 12:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69C386244;
	Fri, 24 May 2024 12:43:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555641E49E;
	Fri, 24 May 2024 12:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716554639; cv=none; b=Hf3i4OAt5HQwhdGUArBkvpp+5sVp9jqdNGXo9eQmM6gJ12knRlHaHvbZAcotiax5Ii8MQiXyseZCklrSMOfrV6N6zaSENkw5FE2d8JpaAA13DlBnhK5JxPvTNZpXjqDBy290431vugEE5lr3h9uJeWYc6BIpIG2SeRTX7iU4pJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716554639; c=relaxed/simple;
	bh=iKOe4ED1tMYc7cGRPSvGgUI54lMEzsn/dUU5ikBx2/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbIqJPzzQMatdlZq5RuWEfheu/4kOTitiVt1m1NiWfKD6USDzhCt+HKiOTvgK7Wty1uYqusEzxaib830GRCCbPPujj3BmnxL1YueUACfdu+gYdedy4fvCI2PFoN7L1p+OUnIHMymznHok5x5MWOCm37f1Op2tmp3J0EblEB5BVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58326339;
	Fri, 24 May 2024 05:44:15 -0700 (PDT)
Received: from [192.168.178.6] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BC1153F641;
	Fri, 24 May 2024 05:43:49 -0700 (PDT)
Message-ID: <91b37d34-6d9a-4623-87d8-0ff648ea2415@arm.com>
Date: Fri, 24 May 2024 14:43:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH v1 3/3] cpufreq: intel_pstate: Set asymmetric CPU
 capacity on hybrid systems
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, x86 Maintainers <x86@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Ricardo Neri <ricardo.neri@intel.com>, Tim Chen <tim.c.chen@intel.com>
References: <7663799.EvYhyI6sBW@kreacher> <1799046.VLH7GnMWUR@kreacher>
From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Content-Language: en-US
In-Reply-To: <1799046.VLH7GnMWUR@kreacher>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/04/2024 21:06, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Make intel_pstate use the HWP_HIGHEST_PERF values from
> MSR_HWP_CAPABILITIES to set asymmetric CPU capacity information
> via the previously introduced arch_set_cpu_capacity() on hybrid
> systems without SMT.
> 
> Setting asymmetric CPU capacity is generally necessary to allow the
> scheduler to compute task sizes in a consistent way across all CPUs
> in a system where they differ by capacity.  That, in turn, should help
> to improve task placement and load balancing decisions.  It is also
> necessary for the schedutil cpufreq governor to operate as expected
> on hybrid systems where tasks migrate between CPUs of different
> capacities.

[...]

For Arm64 we expose the cpu_capacity under:

  /sys/devices/system/cpu/cpu*/cpu_capacity

Might be handy for X86 hybrid as well.

Code snippet copied from from drivers/base/arch_topology.c :

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 9e94b3f05a57..c445e5d1efc8 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3746,5 +3746,49 @@ static int __init intel_pstate_setup(char *str)
 }
 early_param("intel_pstate", intel_pstate_setup);
 
+static ssize_t cpu_capacity_show(struct device *dev,
+                                 struct device_attribute *attr,
+                                 char *buf)
+{
+       struct cpu *cpu = container_of(dev, struct cpu, dev);
+
+       return sysfs_emit(buf, "%lu\n", arch_scale_cpu_capacity(cpu->dev.id));
+}
+
+static DEVICE_ATTR_RO(cpu_capacity);
+
+static int cpu_capacity_sysctl_add(unsigned int cpu)
+{
+       struct device *cpu_dev = get_cpu_device(cpu);
+
+       if (!cpu_dev)
+               return -ENOENT;
+
+       device_create_file(cpu_dev, &dev_attr_cpu_capacity);
+
+       return 0;
+}
+
+static int cpu_capacity_sysctl_remove(unsigned int cpu)
+{
+       struct device *cpu_dev = get_cpu_device(cpu);
+
+       if (!cpu_dev)
+               return -ENOENT;
+
+       device_remove_file(cpu_dev, &dev_attr_cpu_capacity);
+
+       return 0;
+}
+
+static int register_cpu_capacity_sysctl(void)
+{
+       cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "topology/cpu-capacity",
+                         cpu_capacity_sysctl_add, cpu_capacity_sysctl_remove);
+
+       return 0;
+}
+subsys_initcall(register_cpu_capacity_sysctl);
+

[...]

