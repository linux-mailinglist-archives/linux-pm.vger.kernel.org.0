Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7561C1F9E9D
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jun 2020 19:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbgFORfT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 15 Jun 2020 13:35:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:60144 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729847AbgFORfS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 15 Jun 2020 13:35:18 -0400
IronPort-SDR: YwrT5Lkv5HZDZsACtBnspln9ds2k3+nKIKngwPmAg5bR7NfA9dw6hD+YURDvD7KXcbNhvWd2zj
 GMR7msC99AmQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 10:35:18 -0700
IronPort-SDR: 51+mZbATzb7maRcHc1mjVbVrxDqDO6M2cv45SsM7b+oxHngCDcFSqacinDVTDXr7OPEcmXRB/a
 d40MxvSKq9pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="298594064"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2020 10:35:16 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH][RFC] PM / s2idle: Clear _TIF_POLLING_NRFLAG before suspend to idle
Date:   Tue, 16 Jun 2020 01:36:11 +0800
Message-Id: <20200615173611.15349-1-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Suspend to idle was found to not work on Goldmont CPU recently.
And the issue was triggered due to:

1. On Goldmont the CPU in idle can only be woken up via IPIs,
   not POLL mode:
   Commit 08e237fa56a1 ("x86/cpu: Add workaround for MONITOR
   instruction erratum on Goldmont based CPUs")
2. When the CPU is entering suspend to idle process, the
  _TIF_POLLING_NRFLAG is kept on.
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
above and keep the context consistent with before.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpuidle/cpuidle.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c149d9e20dfd..d17dad362d34 100644
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
@@ -186,8 +187,10 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
-	if (index > 0)
+	if (index > 0) {
+		__current_clr_polling();
 		enter_s2idle_proper(drv, dev, index);
+	}
 
 	return index;
 }
-- 
2.17.1

