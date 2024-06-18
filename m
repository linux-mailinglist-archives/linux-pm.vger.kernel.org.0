Return-Path: <linux-pm+bounces-9404-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D6E90C295
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 05:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D391F22B5D
	for <lists+linux-pm@lfdr.de>; Tue, 18 Jun 2024 03:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F03E19CD00;
	Tue, 18 Jun 2024 03:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n5i9fK6O"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B4158A21;
	Tue, 18 Jun 2024 03:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718682691; cv=none; b=ZBO3+hyaC5Q4WqqsxEt8F5BIXVy25D6z/a/DrSxobnadCuqp5/S8HI9dQoYLkS12QdwxXmWwQyHD4LvUFjjz1XbyHoQZiXEAj88Z4Hs+f5td+2V+aP4C14Xb4YA6f31i/pZZf7e8+RwCaPsXrczHYOV+r8oB9yW/ORraM9sS8w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718682691; c=relaxed/simple;
	bh=ToLL9U63MC+1PeSC4IR0KmcmXUpq1cuEujftwBgIbBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CyatjIlX7cXSgO+v2P/TJ02q8Q7SGdTyZ0hGl7EER7yDUQABIHqVwRbOw6UYxkDWQ3ZmRhXG8NgIokuUXwLBs+bBshSuyAyO0T9Uvna0PbAlrAY6IuLu0dZlzustKAWC2Jxe9MyQC+aHtjfYYHKl6y5B/mxaIgvYv7f6KcmdVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n5i9fK6O; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718682689; x=1750218689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ToLL9U63MC+1PeSC4IR0KmcmXUpq1cuEujftwBgIbBM=;
  b=n5i9fK6OebPkSf9/JmundpmL2sZYlvzaFSG8//kzkG6qPljWPzcEg0q7
   FSiS/1hPPUDi7cP239wLzPIGjsbP8VSrzjb4m53ZTjS9YIiE9/DMtoa9M
   YTqVnUplLMTIv6zYaVEn0zVe4Sxw461il6SIouMHeqABwscdpnpR7ZDnT
   7cvZv4n9MzFnKoDVWUma8PBiJ/gHZ4u8fkPKNdlhCvLlzrUVR+1HViMFM
   GUZD29S61SfS/WlluZcZzQ8QV6MotHd1KoJdkt1VJZ6SDaDDhDd6BTX1s
   LK/LWMlrmq5m8KMQ3E0KWAWo1zmyK4fbtrTCP3cAqIiQC8HsEGT16ktGT
   w==;
X-CSE-ConnectionGUID: rzrpamRYRr+wg6zkrR1UUQ==
X-CSE-MsgGUID: K+SRVmdZQe6fEGsrCF3aag==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="18449845"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="18449845"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 20:51:25 -0700
X-CSE-ConnectionGUID: 6xy96Xf9Qi6E3TpvdFBKtA==
X-CSE-MsgGUID: CcnMDP+3SzCZOe8y0spPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="41522553"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa009.jf.intel.com with ESMTP; 17 Jun 2024 20:51:24 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rafael@kernel.org,
	viresh.kumar@linaro.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/2] cpufreq: intel_pstate: Support highest performance change interrupt
Date: Mon, 17 Jun 2024 20:51:21 -0700
Message-ID: <20240618035122.438822-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
References: <20240618035122.438822-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some systems, the HWP (Hardware P-states) highest performance level
can change from the value set at boot-up. This behavior can lead to two
issues:

- The 'cpuinfo_max_freq' within the 'cpufreq' sysfs will not reflect
the CPU's highest achievable performance.
- Even if the CPU's highest performance level is increased after booting,
the CPU may not reach the full expected performance.

The availability of this feature is indicated by the CPUID instruction:
if CPUID[6].EAX[15] is set to 1, the feature is supported. When supported,
setting bit 2 of the MSR_HWP_INTERRUPT register enables notifications of
the highest performance level changes. Therefore, as part of enabling the
HWP interrupt, bit 2 of the MSR_HWP_INTERRUPT should also be set when this
feature is supported.

Upon a change in the highest performance level, a new HWP interrupt is
generated, with bit 3 of the MSR_HWP_STATUS register set, and the
MSR_HWP_CAPABILITIES register is updated with the new highest performance
limit.

The processing of the interrupt is the same as the guaranteed performance
change. Notify change to cpufreq core and update MSR_HWP_REQUEST with new
performance limits.

The current driver implementation already takes care of the highest
performance change as part of:
commit dfeeedc1bf57 ("cpufreq: intel_pstate: Update cpuinfo.max_freq
on HWP_CAP changes")

For example:
Before highest performance change interrupt:
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
3700000
cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
3700000

After highest performance changes interrupt:
cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
3900000
cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
3900000

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/cpufreq/intel_pstate.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 69d85b5bf366..708e62080a83 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1620,17 +1620,24 @@ static void intel_pstate_notify_work(struct work_struct *work)
 static DEFINE_SPINLOCK(hwp_notify_lock);
 static cpumask_t hwp_intr_enable_mask;
 
+#define HWP_GUARANTEED_PERF_CHANGE_STATUS      BIT(0)
+#define HWP_HIGHEST_PERF_CHANGE_STATUS         BIT(3)
+
 void notify_hwp_interrupt(void)
 {
 	unsigned int this_cpu = smp_processor_id();
+	u64 value, status_mask;
 	unsigned long flags;
-	u64 value;
 
 	if (!hwp_active || !boot_cpu_has(X86_FEATURE_HWP_NOTIFY))
 		return;
 
+	status_mask = HWP_GUARANTEED_PERF_CHANGE_STATUS;
+	if (boot_cpu_has(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
+		status_mask |= HWP_HIGHEST_PERF_CHANGE_STATUS;
+
 	rdmsrl_safe(MSR_HWP_STATUS, &value);
-	if (!(value & 0x01))
+	if (!(value & status_mask))
 		return;
 
 	spin_lock_irqsave(&hwp_notify_lock, flags);
@@ -1668,17 +1675,25 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
 }
 
+#define HWP_GUARANTEED_PERF_CHANGE_REQ BIT(0)
+#define HWP_HIGHEST_PERF_CHANGE_REQ    BIT(2)
+
 static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 {
-	/* Enable HWP notification interrupt for guaranteed performance change */
+	/* Enable HWP notification interrupt for performance change */
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
+		u64 interrupt_mask = HWP_GUARANTEED_PERF_CHANGE_REQ;
+
 		spin_lock_irq(&hwp_notify_lock);
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
 		spin_unlock_irq(&hwp_notify_lock);
 
+		if (boot_cpu_has(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
+			interrupt_mask |= HWP_HIGHEST_PERF_CHANGE_REQ;
+
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
-		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, interrupt_mask);
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 	}
 }
-- 
2.44.0


