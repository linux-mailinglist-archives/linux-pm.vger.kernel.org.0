Return-Path: <linux-pm+bounces-14433-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A87897C5BF
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 10:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12E3C1F21E94
	for <lists+linux-pm@lfdr.de>; Thu, 19 Sep 2024 08:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6981957E7;
	Thu, 19 Sep 2024 08:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="sD8ua67e"
X-Original-To: linux-pm@vger.kernel.org
Received: from master.debian.org (master.debian.org [82.195.75.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE849190664;
	Thu, 19 Sep 2024 08:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734284; cv=none; b=UrlPUAVCnmBQhf1Sh4ijMQs6ADZJ2t5D52amUcc5C9WcFCB8Asv/bIZ7JfnBXAlE3pTKiRJlZzhZFj6IQyfNGJcE3OtMPQUTWW8+ScblaUHTk1DfBLxEXUVlgDGNFtwXTWrFWNwuZ8t71ESgIPojXDTws8jQkvWeilUAuv/QxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734284; c=relaxed/simple;
	bh=AufR2rC810Q4YjbnIq0502kZyRC7aU9Fu0Tte+Po0X8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TT2Z8bIB0+D1v+v3sdSSX63WKJdRv23vCDc5yGp5nUslzz1YzZcV63TrWibAe69mO6XQ5CBMZj1ipAbIKVlS+XeV7+TCZMa/j61l5fhb6vrYdBvEysVHO2LaAUFUQqZQMpPUqm08lfyFD+T0cwPJ5E/cnDwAPaEXE71VJEZkLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=master.debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=sD8ua67e; arc=none smtp.client-ip=82.195.75.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=master.debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.master; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	In-Reply-To:References; bh=sxmYL+nS7Az6jrXUJv7A/FowDRA+Yf3UwSxFM9lo31A=; b=sD
	8ua67eq5C4H2MnppB9UIj5vy1zi6Yc4PGZfJJQCNNEz88wxCsth8I5NGtrlLAhlRDf/hbpENblKsQ
	J0ZBjVrVTCG8/I9Fsw4O/fc5UxbfEIgubM2DqvnRE0QJ6DEGx9YhwQakRO0bT2VQrFYaj5cRDBD2t
	FAyjOk91Jnz98aoCHKN37cHhjBDowxLPzM9EBBC3gS+J95AVSfWqJfnu7l/tBUvqtk8XIZ1Oj2i6T
	8VebJ3mR3lmkqlS2qTzaURHJdvzcsXmKTfqfLyY86RG4JayzhaclREkI8UKdZfK1fOXQRQjx/gUti
	ujoEUwUcGnu4CevZaPy7f6PDCSWBtyeg==;
Received: from ukleinek by master.debian.org with local (Exim 4.94.2)
	(envelope-from <ukleinek@master.debian.org>)
	id 1srCGW-000MYs-JV; Thu, 19 Sep 2024 08:11:52 +0000
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@debian.org>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-pm@vger.kernel.org,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-rt-users@vger.kernel.org,
	xiao sheng wen <atzlinux@sina.com>
Subject: [PATCH] cpufreq: intel_pstate: Make hwp_notify_lock a raw spinlock
Date: Thu, 19 Sep 2024 10:11:21 +0200
Message-ID: <20240919081121.10784-2-ukleinek@debian.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3401; i=ukleinek@debian.org; h=from:subject; bh=AufR2rC810Q4YjbnIq0502kZyRC7aU9Fu0Tte+Po0X8=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBm69yp8uS182CL8KAYt+yDqMzeLt/dhwoj+m2O9 bazfmXoTsyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZuvcqQAKCRCPgPtYfRL+ TqW0CACJwbFamuKiP+ypB3yZbzct/y5pE5qttG5mi/bDPi51UU/NlBWR51cofnPFX9lWJFBjccn JvjQkeHvT8A31EpsZ0K13h7ZCQywqRf2BAiy/olKI4D2Wflp7NuLh3gS0mZBgEKfwU9SErA1mEu sUOlYybUXenbgLpbQRC83S5jlwagUxAHc+AybmdP28DEfsH367xDI6LUX4UAB3ELoMWqzXy7FMr lfHqOcDZFBMiBymY3I3b4AEaNzgL5TezPMTI+HEq+f+RAZtmRg/93pfQwFlKmGWGUDvyMGLWMtr EibPvWgHL+dbJkRfDGorurzfTBaB+nWN91r/QrQW88eim2mB
X-Developer-Key: i=ukleinek@debian.org; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

notify_hwp_interrupt() is called via sysvec_thermal() ->
smp_thermal_vector() -> intel_thermal_interrupt() in hard irq context.
For this reason it must not use a simple spin_lock that sleeps with
PREEMPT_RT enabled. So convert it to a raw spinlock.

Reported-by: xiao sheng wen <atzlinux@sina.com>
Link: https://bugs.debian.org/1076483
Signed-off-by: Uwe Kleine-König <ukleinek@debian.org>
---
Hello,

this is deep in x86 land where I have *very* little experience and
knowledge. Is sysvec_thermal() (defined in arch/x86/kernel/irq.c) really
running in hard irq context? The stacktrace in the Debian bug report
suggests that.

So please double check my reasoning before applying this patch.

Thanks
Uwe

 drivers/cpufreq/intel_pstate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index aaea9a39eced..b0018f371ea3 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -1845,7 +1845,7 @@ static void intel_pstate_notify_work(struct work_struct *work)
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_STATUS, 0);
 }
 
-static DEFINE_SPINLOCK(hwp_notify_lock);
+static DEFINE_RAW_SPINLOCK(hwp_notify_lock);
 static cpumask_t hwp_intr_enable_mask;
 
 #define HWP_GUARANTEED_PERF_CHANGE_STATUS      BIT(0)
@@ -1868,7 +1868,7 @@ void notify_hwp_interrupt(void)
 	if (!(value & status_mask))
 		return;
 
-	spin_lock_irqsave(&hwp_notify_lock, flags);
+	raw_spin_lock_irqsave(&hwp_notify_lock, flags);
 
 	if (!cpumask_test_cpu(this_cpu, &hwp_intr_enable_mask))
 		goto ack_intr;
@@ -1876,13 +1876,13 @@ void notify_hwp_interrupt(void)
 	schedule_delayed_work(&all_cpu_data[this_cpu]->hwp_notify_work,
 			      msecs_to_jiffies(10));
 
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 
 	return;
 
 ack_intr:
 	wrmsrl_safe(MSR_HWP_STATUS, 0);
-	spin_unlock_irqrestore(&hwp_notify_lock, flags);
+	raw_spin_unlock_irqrestore(&hwp_notify_lock, flags);
 }
 
 static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
@@ -1895,9 +1895,9 @@ static void intel_pstate_disable_hwp_interrupt(struct cpudata *cpudata)
 	/* wrmsrl_on_cpu has to be outside spinlock as this can result in IPC */
 	wrmsrl_on_cpu(cpudata->cpu, MSR_HWP_INTERRUPT, 0x00);
 
-	spin_lock_irq(&hwp_notify_lock);
+	raw_spin_lock_irq(&hwp_notify_lock);
 	cancel_work = cpumask_test_and_clear_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-	spin_unlock_irq(&hwp_notify_lock);
+	raw_spin_unlock_irq(&hwp_notify_lock);
 
 	if (cancel_work)
 		cancel_delayed_work_sync(&cpudata->hwp_notify_work);
@@ -1912,10 +1912,10 @@ static void intel_pstate_enable_hwp_interrupt(struct cpudata *cpudata)
 	if (boot_cpu_has(X86_FEATURE_HWP_NOTIFY)) {
 		u64 interrupt_mask = HWP_GUARANTEED_PERF_CHANGE_REQ;
 
-		spin_lock_irq(&hwp_notify_lock);
+		raw_spin_lock_irq(&hwp_notify_lock);
 		INIT_DELAYED_WORK(&cpudata->hwp_notify_work, intel_pstate_notify_work);
 		cpumask_set_cpu(cpudata->cpu, &hwp_intr_enable_mask);
-		spin_unlock_irq(&hwp_notify_lock);
+		raw_spin_unlock_irq(&hwp_notify_lock);
 
 		if (cpu_feature_enabled(X86_FEATURE_HWP_HIGHEST_PERF_CHANGE))
 			interrupt_mask |= HWP_HIGHEST_PERF_CHANGE_REQ;

base-commit: 3621a2c9142bd490af0666c0c02d52d60ce0d2a5
-- 
2.45.2


