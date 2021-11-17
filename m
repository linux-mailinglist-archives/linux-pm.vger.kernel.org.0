Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0967454D4A
	for <lists+linux-pm@lfdr.de>; Wed, 17 Nov 2021 19:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240102AbhKQSk0 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Nov 2021 13:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240099AbhKQSk0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Nov 2021 13:40:26 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AD5C061570;
        Wed, 17 Nov 2021 10:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=PRlOqQGL2CKYCxnjodfVGxm0OsG0EFFVuhETKS3dNmc=; b=2B
        ewCb7mv+a20OOJ4uvV/cJwtmtOhXgoWG374d62V0s8V5KiVK0DpvPB+YlMgUVJxBKKLkZF8vIWZdw
        jJCDKZC5ClDqu7g0zZMZBYqqjCA/AepGAnkxw/+BDf2xtV8ccNQs+TRNqYYCqdhN5jItpV21gsOor
        CijzgTHsgKBmpBvHA0DfFawcZkUbRp/mLaygdaB4ekWgvjKd20TvTTAoduSJAdeCJFXfc4ybd1HWo
        2WlDbZYrLlKwE0q7UgXNEbDtHlntYbjknIMjk8fxC34XiLcu/q7XNbKpzhnURpT2J49s+m6LKg1ll
        6KH6y4cfa4WCdqEMfiAvLoIladBIV9Hg==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1mnPo8-0003sm-Gd; Wed, 17 Nov 2021 18:37:20 +0000
From:   John Keeping <john@metanate.com>
To:     linux-pm@vger.kernel.org
Cc:     John Keeping <john@metanate.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: runtime: avoid priority inversion on PREEMPT_RT
Date:   Wed, 17 Nov 2021 18:37:09 +0000
Message-Id: <20211117183709.1832925-1-john@metanate.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With PREEMPT_RT the cpu_relax() loops in rpm_suspend and rpm_resume can
cause unbounded latency if they preempt an asynchronous suspend.  The
main scenario where this can happen is when a realtime thread resumes a
device while it is asynchronously suspending on a worker thread.

I'm not convinced this can actually happen in the rpm_suspend case, or
at least it's a lot less likely for a synchronous suspend to run at the
same time as an asynchronous suspend, but both functions are updated
here for symmetry.

For devices setting power.irq_safe, it is possible that RPM functions
will be called with a spinlock held (for example in
pl330_issue_pending()).  This means a normal call to schedule() can't be
used, but to avoid the priority inversion it is necessary to wait and
schedule.  schedule_rtlock() is only available when CONFIG_PREEMPT_RT is
defined, so even though the logic is correct without any preprocessor
guards around schedule_rtlock(), they are necessary for compilation.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Signed-off-by: John Keeping <john@metanate.com>
---
Changes since v1:
- Use schedule_rtlock() instead of schedule() for PREEMPT_RT & irq_safe
- Rewritten commit description

 drivers/base/power/runtime.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index f3de7bfc7f5b..fdf461bfae8c 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -596,7 +596,7 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 			goto out;
 		}
 
-		if (dev->power.irq_safe) {
+		if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			spin_unlock(&dev->power.lock);
 
 			cpu_relax();
@@ -614,7 +614,12 @@ static int rpm_suspend(struct device *dev, int rpmflags)
 
 			spin_unlock_irq(&dev->power.lock);
 
-			schedule();
+#ifdef CONFIG_PREEMPT_RT
+			if (dev->power.irq_safe)
+				schedule_rtlock();
+			else
+#endif
+				schedule();
 
 			spin_lock_irq(&dev->power.lock);
 		}
@@ -779,7 +784,7 @@ static int rpm_resume(struct device *dev, int rpmflags)
 			goto out;
 		}
 
-		if (dev->power.irq_safe) {
+		if (dev->power.irq_safe && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 			spin_unlock(&dev->power.lock);
 
 			cpu_relax();
@@ -798,7 +803,12 @@ static int rpm_resume(struct device *dev, int rpmflags)
 
 			spin_unlock_irq(&dev->power.lock);
 
-			schedule();
+#ifdef CONFIG_PREEMPT_RT
+			if (dev->power.irq_safe)
+				schedule_rtlock();
+			else
+#endif
+				schedule();
 
 			spin_lock_irq(&dev->power.lock);
 		}
-- 
2.34.0

