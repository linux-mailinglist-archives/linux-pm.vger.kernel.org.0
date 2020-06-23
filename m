Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AEA2049F0
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jun 2020 08:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgFWGbA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 23 Jun 2020 02:31:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:36093 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730708AbgFWGbA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 02:31:00 -0400
IronPort-SDR: cDAWf8GMQ2+Ob/PDzKUpVYrR4YGS9MCjqBiNg5XyzoC0SmMsmf0XTyUbKJQQKWr1cjauISktbS
 qxBnC/4jf4Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="141476614"
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="141476614"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 23:31:00 -0700
IronPort-SDR: xE8N5qXUJHEnOuz2BAuzA8va+q19yxoPMk8TBSd8R/3vVgZqnYP1sfH7QEf5HMdJKqa+gehjZ8
 1aADiwTK1tFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,270,1589266800"; 
   d="scan'208";a="279007713"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2020 23:30:57 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH 2/2][v3] PM / s2idle: Code cleanup to make s2idle consistent with normal idle path
Date:   Tue, 23 Jun 2020 14:31:52 +0800
Message-Id: <a00278cc5db9f4845006cff130fd91a58c0d92d1.1592892767.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1592892767.git.yu.c.chen@intel.com>
References: <cover.1592892767.git.yu.c.chen@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently s2idle is a little different from the normal idle path. This
patch makes call_s2idle() consistent with call_cpuidle(), and also
s2idle_enter() is analogous to cpuidle_enter().

No functional change.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/cpuidle/cpuidle.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index e092789187c6..b2e764d1ac99 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -134,8 +134,8 @@ int cpuidle_find_deepest_state(struct cpuidle_driver *drv,
 }
 
 #ifdef CONFIG_SUSPEND
-static void enter_s2idle_proper(struct cpuidle_driver *drv,
-				struct cpuidle_device *dev, int index)
+static void s2idle_enter(struct cpuidle_driver *drv,
+			 struct cpuidle_device *dev, int index)
 {
 	ktime_t time_start, time_end;
 
@@ -169,6 +169,15 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	dev->states_usage[index].s2idle_usage++;
 }
 
+static int call_s2idle(struct cpuidle_driver *drv,
+		       struct cpuidle_device *dev, int index)
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
@@ -187,8 +196,8 @@ int cpuidle_enter_s2idle(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	 * be frozen safely.
 	 */
 	index = find_deepest_state(drv, dev, U64_MAX, 0, true);
-	if (index > 0 && !current_clr_polling_and_test())
-		enter_s2idle_proper(drv, dev, index);
+	if (index > 0)
+		call_s2idle(drv, dev, index);
 
 	return index;
 }
-- 
2.17.1

