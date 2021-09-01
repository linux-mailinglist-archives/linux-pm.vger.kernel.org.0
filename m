Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D59F3FD5AF
	for <lists+linux-pm@lfdr.de>; Wed,  1 Sep 2021 10:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243192AbhIAIgC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 Sep 2021 04:36:02 -0400
Received: from first.geanix.com ([116.203.34.67]:37290 "EHLO first.geanix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243224AbhIAIgB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 1 Sep 2021 04:36:01 -0400
Received: from zen.. (unknown [185.17.218.86])
        by first.geanix.com (Postfix) with ESMTPSA id 4BC3C440F5F;
        Wed,  1 Sep 2021 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=geanix.com; s=first;
        t=1630485302; bh=IrFgfhIfMtYxjCmgturAExJe7UDGUvUwMIkPGhYH5o0=;
        h=From:To:Cc:Subject:Date;
        b=Yy8YTNeC7q1OmsyX4zkFnJRAuSZY1GDWU7P4DSRfXT7ihT2vQstfDsXZilY7EFglA
         K54Kd2v3AfT5ODifASS5NKQD1PhEGkov5yoVvMYMeZreVhOg80ZfdsbqjsIRgbbjTt
         N4ERFczGw4uGULKeCaXk5xaE1g/aeKs8rcslCJlYEFcS11b5+dDDaaJFxKv/CNKT19
         78MT6sx/+yN/izxHjZ3CnThtsw8aLGhKIroH8G7n5mIKCuaJCuENpNjOzUT85afOi8
         bWwKowOaiGE2lswTSyvVoKwZ/vDA4ezUFLrMKGpI5tsMcQHHokMyF2OcFjPg1hvRqt
         +ja43jaiJKPQA==
From:   Sean Nyekjaer <sean@geanix.com>
To:     miquel.raynal@bootlin.com, s.hauer@pengutronix.de, richard@nod.at,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com
Cc:     Sean Nyekjaer <sean@geanix.com>, linux-mtd@lists.infradead.org
Subject: [PATCH] PM / suspend: move userspace freeze before disk sync
Date:   Wed,  1 Sep 2021 10:34:42 +0200
Message-Id: <20210901083442.210230-1-sean@geanix.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=4.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,URIBL_BLOCKED
        autolearn=disabled version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on 13e2a5895688
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This fixes an issue where data remains unwritten before suspend.
UBI tried to write data, before the mtd device had been unsuspended.

Seen on an iMX6ULL board fitted with rawnand flash.

Before:
PM: suspend entry (deep)
Filesystems sync: 0.088 seconds
Freezing user space processes ... (elapsed 0.000 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
printk: Suspending console(s) (use no_console_suspend to debug)
PM: suspend devices took 0.030 seconds
Disabling non-boot CPUs ...
ubi0 error: ubi_io_write: error -16 while writing 4096 bytes to PEB 1762:94208, written 0 bytes

After:
PM: suspend entry (deep)
Freezing user space processes ... (elapsed 0.001 seconds) done.
OOM killer disabled.
Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
Filesystems sync: 0.060 seconds
printk: Suspending console(s) (use no_console_suspend to debug)
PM: suspend devices took 0.040 seconds
Disabling non-boot CPUs ...
PM: resume devices took 0.100 seconds

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---

Some explanation/discussion here:
http://lists.infradead.org/pipermail/linux-mtd/2021-July/087390.html

 kernel/power/suspend.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 87331565e505..4ee3fcbb0e7a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -562,6 +562,12 @@ static int enter_state(suspend_state_t state)
 	if (state == PM_SUSPEND_TO_IDLE)
 		s2idle_begin();
 
+	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
+	pm_suspend_clear_flags();
+	error = suspend_prepare(state);
+	if (error)
+		goto Unlock;
+
 #ifndef CONFIG_SUSPEND_SKIP_SYNC
 	trace_suspend_resume(TPS("sync_filesystems"), 0, true);
 	pr_info("Syncing filesystems ... ");
@@ -570,12 +576,6 @@ static int enter_state(suspend_state_t state)
 	trace_suspend_resume(TPS("sync_filesystems"), 0, false);
 #endif
 
-	pm_pr_dbg("Preparing system for sleep (%s)\n", mem_sleep_labels[state]);
-	pm_suspend_clear_flags();
-	error = suspend_prepare(state);
-	if (error)
-		goto Unlock;
-
 	if (suspend_test(TEST_FREEZER))
 		goto Finish;
 
-- 
2.33.0

