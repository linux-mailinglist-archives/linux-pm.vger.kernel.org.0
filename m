Return-Path: <linux-pm+bounces-9902-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB45C915334
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 18:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A248F284B13
	for <lists+linux-pm@lfdr.de>; Mon, 24 Jun 2024 16:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF919DF5B;
	Mon, 24 Jun 2024 16:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RnKtI2gH"
X-Original-To: linux-pm@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B9919D8AD;
	Mon, 24 Jun 2024 16:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719245485; cv=none; b=FboE5vYTOsl8d7Ra2Y8McQvBWsLNBbkfkcL6SQ3zhe3/WT0PvQ2GcS+OeRrwVMWi2w9FLciy5ZuQL6VOOydABF1Ab6+3RHgiW6R30w5mYed7mEdmcFbn2TmZcosxBYaex7KfWEVTRNWd5Hx628ANqdiHBdXTcn/HF9xcs82Wm68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719245485; c=relaxed/simple;
	bh=vRl+X9yYWRM1aDJKdoXKKmE8TKr/CD1+xVJPTQJOtLo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsKi3Q2aWX1JUAl+QQ7b4UAJFHAkJSNgvno/CZ5JUiFTL2+VCoEP564+YoWJ1M0HXdECgiitEHrX9DC7TDFqt+NZsfhBUol04V92nGNI53+Yki2mgiAU4rU9i1sXek63xIhvfsZ/BCGIqEDEGo4jX9NDtuvIm/iVgQqQMpUWH+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RnKtI2gH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719245484; x=1750781484;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vRl+X9yYWRM1aDJKdoXKKmE8TKr/CD1+xVJPTQJOtLo=;
  b=RnKtI2gHB51kMNLknpF7T9v9Tdh10T/XC3WyQtSymuexeLcM6tnzmEp5
   L7gN8eXBrrPGK6IGkoownaizcXpdh6P9IJP5qH9Z1yzdibBmSnEYk/JE9
   Fw4VX/FkfppLBKcnZcVxRTjUK3h7B0fBmJaAOHtrlwikoLn5mS/OKyaGL
   FTUw78WTiMZVNgaaSHR4wDwCyBKiEDtk+vFPIcuJC/H75ujl02WMAPjDp
   OC5zNqAGRj66YASuB5EnxxaK0/WE7Mzw1E462yqyeQR8+yWoMIf1ynXX9
   z2tP84CcgmyAAGGpQlYAuxvJyEbq+kM8/Zh0ps7hMgr5+xbb3SWjR9ON1
   w==;
X-CSE-ConnectionGUID: t/rCqDxuRyOARrCnvJIg9Q==
X-CSE-MsgGUID: rl42a6JPSjWWLLdr9rZu6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="12218615"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="12218615"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 09:11:12 -0700
X-CSE-ConnectionGUID: 6OiU0xDVQaqvFmzmLyq/ww==
X-CSE-MsgGUID: 6F4wmaYAT2msWhYizh3EKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44012675"
Received: from spandruv-desk.jf.intel.com ([10.54.75.19])
  by orviesa007.jf.intel.com with ESMTP; 24 Jun 2024 09:11:13 -0700
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
Subject: [PATCH v2 2/2] cpufreq: intel_pstate: Support highest performance change interrupt
Date: Mon, 24 Jun 2024 09:11:09 -0700
Message-ID: <20240624161109.1427640-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
References: <20240624161109.1427640-1-srinivas.pandruvada@linux.intel.com>
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
v2
- Change from boot_cpu_has() to cpu_feature_enabled()
	as suggested by Borris

 drivers/cpufreq/intel_pstate.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 15de5e3d96fd..8652555cbaae 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1626,17 +1626,24 @@ static void intel_pstate_notify_work(struct work_struct *work)
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
+	if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
+		status_mask |= HWP_HIGHEST_PERF_CHANGE_STATUS;
+
 	rdmsrl_safe(MSR_HWP_STATUS, &value);
-	if (!(value & 0x01))
+	if (!(value & status_mask))
 		return;
 
 	spin_lock_irqsave(&hwp_notify_lock, flags);
@@ -1674,17 +1681,25 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
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
 
+		if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
+			interrupt_mask |= HWP_HIGHEST_PERF_CHANGE_REQ;
+
 		/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
-		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x01);
+		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, interrupt_mask);
 		wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 	}
 }
-- 
2.40.1


