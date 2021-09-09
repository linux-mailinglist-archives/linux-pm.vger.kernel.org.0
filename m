Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370E640598D
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbhIIOrv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhIIOrp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E19C06122E
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:36 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Znnfd6L3YtZePZ9dV43aql9tRED8QjBniKRdun5Vm/8=;
        b=h8YPUG6fM+N63/jJExIrXs/mTuSC0I4qhkJhuThV7DEiVrZcKONNb6Sak/hzHmS/NrAqOI
        0x55jruXbIc83iLQu09TfslvrfJl1W9j4KkcClyRYqyCZ/FmWiXMiBkZFZZEU/yOluGsrL
        AHbo7yw5VkO9V3thP8y0ymXjr3kOZS1rH9xhE96QvS8GMOH/qvi8dzLzNTLECCoueyYvtd
        TYRLFkzHsVLi6nMrarOAeJJAeSnU5FulVTiGQsccMM14CvQ5jlYD1tN6fJF+Qx57ADwMCa
        D3vAkKoOjRy+eNM2k0rX3wY4Fgn4aMdlLQVASOC+WHo8RJDDqYYTOgcqEqPRDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198315;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Znnfd6L3YtZePZ9dV43aql9tRED8QjBniKRdun5Vm/8=;
        b=PfAfvpjgdVln5k3I4RB9v0uJQMZ8rnHWJL4cx54FlJDvcGLZBHv0o1xc2VnQHAJ3v8zEey
        MtaPub35+q1JyHAA==
From:   "thermal-bot for Srinivas Pandruvada" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/drivers/intel: Allow processing of
 HWP interrupt
Cc:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org
In-Reply-To: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
References: <20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163119831420.25758.11429959271479471020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     5950fc44a57ace59f21dccfd792250019348a182
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//5950fc44a57ace59f21dccfd792250019348a182
Author:        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
AuthorDate:    Thu, 19 Aug 2021 19:40:05 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 09 Sep 2021 16:33:20 +02:00

thermal/drivers/intel: Allow processing of HWP interrupt

Add a weak function to process HWP (Hardware P-states) notifications and
move updating HWP_STATUS MSR to this function.

This allows HWP interrupts to be processed by the intel_pstate driver in
HWP mode by overriding the implementation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Acked-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210820024006.2347720-1-srinivas.pandruvada@linux.intel.com
---
 drivers/thermal/intel/therm_throt.c       | 7 ++++++-
 drivers/thermal/intel/thermal_interrupt.h | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/therm_throt.c b/drivers/thermal/intel/therm_throt.c
index 99abdc0..dab7e8f 100644
--- a/drivers/thermal/intel/therm_throt.c
+++ b/drivers/thermal/intel/therm_throt.c
@@ -569,13 +569,18 @@ static void notify_thresholds(__u64 msr_val)
 		platform_thermal_notify(msr_val);
 }
 
+void __weak notify_hwp_interrupt(void)
+{
+	wrmsrl_safe(MSR_HWP_STATUS, 0);
+}
+
 /* Thermal transition interrupt handler */
 void intel_thermal_interrupt(void)
 {
 	__u64 msr_val;
 
 	if (static_cpu_has(X86_FEATURE_HWP))
-		wrmsrl_safe(MSR_HWP_STATUS, 0);
+		notify_hwp_interrupt();
 
 	rdmsrl(MSR_IA32_THERM_STATUS, msr_val);
 
diff --git a/drivers/thermal/intel/thermal_interrupt.h b/drivers/thermal/intel/thermal_interrupt.h
index 53f427b..01e7bed 100644
--- a/drivers/thermal/intel/thermal_interrupt.h
+++ b/drivers/thermal/intel/thermal_interrupt.h
@@ -12,4 +12,7 @@ extern int (*platform_thermal_notify)(__u64 msr_val);
  * callback has rate control */
 extern bool (*platform_thermal_package_rate_control)(void);
 
+/* Handle HWP interrupt */
+extern void notify_hwp_interrupt(void);
+
 #endif /* _INTEL_THERMAL_INTERRUPT_H */
