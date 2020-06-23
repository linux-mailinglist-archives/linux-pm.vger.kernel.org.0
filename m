Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3162049EE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 08:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgFWGan (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 02:30:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:21452 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbgFWGan (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 02:30:43 -0400
IronPort-SDR: dLiEMUWawMGH8i41DCab/iLjZidrLC8G6LBfXvgN3xD8e9wcSh0TpaR20p+wmgM14is9JHNldn
 ABQhsmtaMu3Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="123650428"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="123650428"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 23:30:43 -0700
IronPort-SDR: W8NKYYcgp++Sp08vRstab/P6xSPfzuvhS4KS78Lq1LK6adkFBxCId0atgy/7XzBvBdXvlynAX/
 UMx0VJu89Vwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="279007642"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2020 23:30:40 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH 1/2][v3] PM / s2idle: Clear _TIF_POLLING_NRFLAG before suspend to idle
Date:   Tue, 23 Jun 2020 14:31:31 +0800
Message-Id: <55caab9c03a0d6c3c0a1f45294d6c274b73c954b.1592892767.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1592892767.git.yu.c.chen@intel.com>
References: <cover.1592892767.git.yu.c.chen@intel.com>
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

Clear the _TIF_POLLING_NRFLAG flag before entering suspend to idle,
and let the driver's enter_s2idle() to decide whether to set
_TIF_POLLING_NRFLAG or not. So that to avoid the scenario described
above and keep the context consistent with before.

Fixes: b2a02fc43a1f ("smp: Optimize send_call_function_single_ipi()")
Reported-by: kbuild test robot <lkp@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Len Brown <lenb@kernel.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
v2: According to Peter's review, v1 is racy, if someone already
    set TIF_NEED_RESCHED this patch just clear POLLING and go to sleep.
    Check TIF_NEED_RESCHED before entering suspend to idle and
    adjust the naming to be consistent with call_cpuidle().

v3: According to Rafael, it would be better to do the simplest fix
   first and then do the cleanup on top of it.
---
 drivers/cpuidle/cpuidle.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index c149d9e20dfd..e092789187c6 100644
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
@@ -186,7 +187,7 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
-	if (index > 0)
+	if (index > 0 && !current_clr_polling_and_test())
 		enter_s2idle_proper(drv, dev, index);
 
 	return index;
-- 
2.17.1

