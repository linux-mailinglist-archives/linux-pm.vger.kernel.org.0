Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 532611FA767
	for <lists+linux-pm@lfdr.de>; Tue, 16 Jun 2020 06:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725308AbgFPED7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jun 2020 00:03:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:62660 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgFPED7 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jun 2020 00:03:59 -0400
IronPort-SDR: bTLDGJ7mB+OzzoCoOcAKZF2WHrr3MSXJpOlG2FjQqXkWUM6j2TRUvluDwm+Gl4ZwbwsPRAWcrE
 eWjikO1GGOFw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 21:03:58 -0700
IronPort-SDR: nRMI7s6Bxwgsiy0QG0/AMGXkMLtFc1525NwLHMT0EvN2ASXrIvNC+j9/K/XeZAiLaQ6xccKOKt
 wsSuHV/QCWCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,517,1583222400"; 
   d="scan'208";a="476265878"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2020 21:03:52 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Len Brown <lenb@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rui Zhang <rui.zhang@intel.com>,
        Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][v2] PM / s2idle: Clear _TIF_POLLING_NRFLAG before suspend to idle
Date:   Tue, 16 Jun 2020 12:04:42 +0800
Message-Id: <20200616040442.21515-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suspend to idle was found to not work on Goldmont CPU recently.
And the issue was triggered due to:

1. On Goldmont the CPU in idle can only be woken up via IPIs,
   not POLLING mode:
   Commit 08e237fa56a1 ("x86/cpu: Add workaround for MONITOR
   instruction erratum on Goldmont based CPUs")
2. When the CPU is entering suspend to idle process, the
   _TIF_POLLING_NRFLAG is kept on, due to cpuidle_enter_s2idle()
   doesn't properly match call_cpuidle().
3. Commit b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
   makes use of _TIF_POLLING_NRFLAG to avoid sending IPIs to
   idle CPUs.
4. As a result, some IPIs related functions might not work
   well during suspend to idle on Goldmont. For example, one
   suspected victim:
   tick_unfreeze() -> timekeeping_resume() -> hrtimers_resume()
   -> clock_was_set() -> on_each_cpu() might wait forever,
   because the IPIs will not be sent to the CPUs which are
   sleeping with _TIF_POLLING_NRFLAG set, and Goldmont CPU
   could not be woken up by only setting _TIF_NEED_RESCHED
   on the monitor address.

I don't find a way in Ubuntu to update the firmware of Goldmont
and check if the issue was gone, a fix patch would do no harm.
Clear the _TIF_POLLING_NRFLAG flag before entering suspend to idle,
and let the driver's enter_s2idle() to decide whether to set
_TIF_POLLING_NRFLAG or not. So that to avoid the scenario described
above and keep the context consistent with before. Also adjust
the naming to be consistent with call_cpuidle().

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: kbuild test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: According to Peter's review, v1 is racy, if someone already
    set TIF_NEED_RESCHED this patch just clear POLLING and go to sleep.
    Check TIF_NEED_RESCHED before entering suspend to idle and
    adjust the naming to be consistent with call_cpuidle().
--
 drivers/cpuidle/cpuidle.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c149d9e20dfd..b003767abebd 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -13,6 +13,7 @@
 #include <linux/mutex.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/sched/idle.h>
 #include <linux/notifier.h>
 #include <linux/pm_qos.h>
 #include <linux/cpu.h>
@@ -133,8 +134,8 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 }
 
 #ifdef CONFIG_SUSPEND
-static void enter_s2idle_proper(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev, int index)
+static void s2idle_enter(struct cpuidle_driver *drv,
+			 struct cpuidle_device *dev, int index)
 {
 	ktime_t time_start, time_end;
 
@@ -168,6 +169,15 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	dev->states_usage[index].s2idle_usage++;
 }
 
+static int call_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev,
+		       int index)
+{
+	if (!current_clr_polling_and_test())
+		s2idle_enter(drv, dev, index);
+
+	return index;
+}
+
 /**
  * cpuidle_enter_s2idle - Enter an idle state suitable for suspend-to-idle.
  * @drv: cpuidle driver for the given CPU.
@@ -187,7 +197,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 */
 	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
 	if (index > 0)
-		enter_s2idle_proper(drv, dev, index);
+		call_s2idle(drv, dev, index);
 
 	return index;
 }
-- 
2.17.1

