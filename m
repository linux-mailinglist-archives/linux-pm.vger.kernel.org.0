Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A275E6772
	for <lists+linux-pm@lfdr.de>; Thu, 22 Sep 2022 17:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiIVPpA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 22 Sep 2022 11:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbiIVPoa (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 22 Sep 2022 11:44:30 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F14EEB4F
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 08:44:08 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d24so9154607pls.4
        for <linux-pm@vger.kernel.org>; Thu, 22 Sep 2022 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=NpyPMjzwtKQ4w+0odjsEFihdg4KtQVQ3rpmkouPDohM=;
        b=dW37y8AN0pwrvhwV7kSpnkxlH4uRaI3RxfoqrOFjo0/MI8rHPpupF4kVWiGMaefQhB
         xiq0+5q9QZuKOGxoeTvK9uuwowqAKAR6rZO3AO0FMcvs4poig96f8fZPKYoAIv8tXzPi
         4FmfMiwHGVRUI2QkHAsu6hDvFX1sfoRdndE0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=NpyPMjzwtKQ4w+0odjsEFihdg4KtQVQ3rpmkouPDohM=;
        b=L1xo2ZWTVEQX3S8tKO/P0MjS1FNUkvUcv8Foi4AMkjfR/fCOYqaB22ZfoOKSpqEz8f
         trDACY0ayf96JflwAfayOh3HADIpTn/Wa1+wQVgRh6RqmhMh10sjYal1Hx1qK7tZwffy
         t4eVgMgtqQnCezD04vIZjPYFNo284KaBbaly7rV3SPLXTP7XC/USnhXvzqPGzRj/AkrO
         EjCIsKATw6uAqG4GdI5zdG8OctZFtDxwBBRe/aAgImnOh8YedydE8rOgI9uihP/mqyqR
         Q6Ndml3+ZfZ5xAM0+9gsxWFi0J/IO6O4DiWnBpA9/Oy49GecEL3Be8gypesOo3KJ98ZG
         0DJQ==
X-Gm-Message-State: ACrzQf2NVHT6INyk35yPUlWGwx1ErMy/V/NYiWFjayT6QBdXb/XBeRPX
        mjd5rYs6oOnVjlbZan2G8q4mCQ==
X-Google-Smtp-Source: AMsMyM4XKRlVx4UCagdXcjE6UiEGv+nHjxsCwSVRGgWYODG1SUSakSsYUykkeMGaIGt0d26WS/9WxA==
X-Received: by 2002:a17:90b:3b91:b0:202:91d7:6a5d with SMTP id pc17-20020a17090b3b9100b0020291d76a5dmr4277529pjb.101.1663861448468;
        Thu, 22 Sep 2022 08:44:08 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:5321:6ad9:3932:13d8])
        by smtp.gmail.com with ESMTPSA id a19-20020a621a13000000b0053e8fe8a705sm4685492pfa.17.2022.09.22.08.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 08:44:07 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     rafael@kernel.org, sboyd@kernel.org
Cc:     pavel@ucw.cz, linux-pm@vger.kernel.org, len.brown@intel.com,
        linux-clk@vger.kernel.org, gregkh@linuxfoundation.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] clk: core: Avoid potential deadlock when disabling unused clocks
Date:   Thu, 22 Sep 2022 08:43:54 -0700
Message-Id: <20220922084322.RFC.2.I375b6b9e0a0a5348962f004beb3dafee6a12dfbb@changeid>
X-Mailer: git-send-email 2.37.3.968.ga6b4b080e4-goog
In-Reply-To: <20220922154354.2486595-1-dianders@chromium.org>
References: <20220922154354.2486595-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

While booting up my system, I seem to have hit the lucky jackpot and
my system was consistently deadlocking from an issue that seems to
have been possible for a long time. Analysis via kgdb made it obvious
what was happening.

The quick summary is here (gory details below):
* Task A:
  - running clk_disable_unused() which holds the prepare lock.
  - doing a synchronous runtime resume on a device; blocked waiting
    for the device which is marked as midway through suspending.
* Task B:
  - midway through suspending the same device on a work thread.
  - trying to unprepare a clock and grab the prepare lock.

That's a pretty clear deadlock.

Fixing the deadlock isn't amazingly straightforward. It should be
pretty clear that a random device's PM Runtime callbacks should be
able to prepare/unprepare clocks, so pretty much the only action would
be to drop the "prepare" lock while disabling unused clocks. That's
not super safe, though.

Instead of rejiggering the locking design of the whole clock
framework, let's use the following observations to fix this:
1. Disabling unused clocks is not terribly urgent. It can be delayed
   for a bit.
2. Disabling unused clocks can be retried. In other words, at any
   point in time we can stop, drop the prepare lock, and start all
   over again from the beginning.
This means that we can "fix" the problem by just backing off, delaying
a bit, and trying again.

At the moment we'll do an exponential type backoff (start at 1 ms and
double each time) and try at most 10 times. These numbers were picked
arbitrarily but seem like they'll work.

Gory detail of the analysis follow. This was from the chromeos-5.15
kernel, not pure upstream. The race hits as part of a lucky jackpot of
timings so I had to analyze it on the kernel I was on, but as far as I
know everything about this analysis applies to upstream:

Task A stack crawl (doing the clk_disable_unused()):
  task:swapper/0 state:D stack: 0 pid: 1 ppid: 0 flags:0x00000008
  Call trace:
   schedule()
   rpm_resume()
   __pm_runtime_resume()
   clk_pm_runtime_get()
   clk_disable_unused_subtree()
   clk_disable_unused_subtree()
   clk_disable_unused_subtree()
   clk_disable_unused_subtree()
   clk_disable_unused()
   do_one_initcall()

In kgdb you can see the "dev" being resumed:
(gdb) frame 4
    at .../drivers/base/power/runtime.c:819
819                             schedule();
(gdb) print dev->driver
$2 = (struct device_driver *) 0x... <lpass_aon_cc_sc7280_driver+40>

Task B stack crawl
   schedule()
   schedule_preempt_disabled()
   __mutex_lock_common()
   mutex_lock_nested()
   clk_prepare_lock()
   clk_unprepare()
   pm_clk_suspend()
   pm_generic_runtime_suspend()
   __rpm_callback()
   rpm_callback()
   rpm_suspend()
   pm_runtime_work()
   process_one_work()
   worker_thread()
   kthread()

In kgdb you can see the "dev" being suspended
(gdb) frame 15
    at .../drivers/base/power/runtime.c:522
522                     retval = __rpm_callback(cb, dev);
(gdb) print dev->driver
$3 = (struct device_driver *) 0x... <lpass_aon_cc_sc7280_driver+40>

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/clk/clk.c | 137 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 110 insertions(+), 27 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index bd0b35cac83e..723e57a9d60d 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -9,6 +9,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/clk-conf.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -114,6 +115,22 @@ static int clk_pm_runtime_get(struct clk_core *core)
 	return pm_runtime_resume_and_get(core->dev);
 }
 
+static int clk_pm_runtime_try_get(struct clk_core *core)
+{
+	int ret;
+
+	if (!core->rpm_enabled)
+		return 0;
+
+	ret = pm_runtime_try_get_sync(core->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(core->dev);
+		return ret;
+	}
+
+	return 0;
+}
+
 static void clk_pm_runtime_put(struct clk_core *core)
 {
 	if (!core->rpm_enabled)
@@ -122,6 +139,14 @@ static void clk_pm_runtime_put(struct clk_core *core)
 	pm_runtime_put_sync(core->dev);
 }
 
+static void clk_pm_runtime_put_async(struct clk_core *core)
+{
+	if (!core->rpm_enabled)
+		return;
+
+	pm_runtime_put(core->dev);
+}
+
 /***           locking             ***/
 static void clk_prepare_lock(void)
 {
@@ -1217,23 +1242,31 @@ static void clk_core_disable_unprepare(struct clk_core *core)
 	clk_core_unprepare_lock(core);
 }
 
-static void __init clk_unprepare_unused_subtree(struct clk_core *core)
+static int __init clk_unprepare_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
+	int ret;
 
 	lockdep_assert_held(&prepare_lock);
 
-	hlist_for_each_entry(child, &core->children, child_node)
-		clk_unprepare_unused_subtree(child);
+	hlist_for_each_entry(child, &core->children, child_node) {
+		ret = clk_unprepare_unused_subtree(child);
+		if (ret)
+			return ret;
+	}
 
 	if (core->prepare_count)
-		return;
+		return 0;
 
 	if (core->flags & CLK_IGNORE_UNUSED)
-		return;
+		return 0;
 
-	if (clk_pm_runtime_get(core))
-		return;
+	/* Backoff if the device is busy; see clk_disable_unused_subtree() */
+	ret = clk_pm_runtime_try_get(core);
+	if (ret == -EINPROGRESS)
+		return -EAGAIN;
+	else if (ret)
+		return ret;
 
 	if (clk_core_is_prepared(core)) {
 		trace_clk_unprepare(core);
@@ -1244,23 +1277,39 @@ static void __init clk_unprepare_unused_subtree(struct clk_core *core)
 		trace_clk_unprepare_complete(core);
 	}
 
-	clk_pm_runtime_put(core);
+	clk_pm_runtime_put_async(core);
+
+	return 0;
 }
 
-static void __init clk_disable_unused_subtree(struct clk_core *core)
+static int __init clk_disable_unused_subtree(struct clk_core *core)
 {
 	struct clk_core *child;
 	unsigned long flags;
+	int ret;
 
 	lockdep_assert_held(&prepare_lock);
 
-	hlist_for_each_entry(child, &core->children, child_node)
-		clk_disable_unused_subtree(child);
+	hlist_for_each_entry(child, &core->children, child_node) {
+		ret = clk_disable_unused_subtree(child);
+		if (ret)
+			return ret;
+	}
 
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_prepare_enable(core->parent);
 
-	if (clk_pm_runtime_get(core))
+	/*
+	 * If the device is already busy resuming / suspending then we need
+	 * to back off and try the whole subtree disable again. This is because
+	 * the resume / suspend may be happening on another CPU. The resume /
+	 * suspend code on the other CPU might be trying to prepare a clock, but
+	 * we're already holding the lock. That's deadlock unless we stand down.
+	 */
+	ret = clk_pm_runtime_try_get(core);
+	if (ret == -EINPROGRESS)
+		ret = -EAGAIN;
+	if (ret)
 		goto unprepare_out;
 
 	flags = clk_enable_lock();
@@ -1287,10 +1336,12 @@ static void __init clk_disable_unused_subtree(struct clk_core *core)
 
 unlock_out:
 	clk_enable_unlock(flags);
-	clk_pm_runtime_put(core);
+	clk_pm_runtime_put_async(core);
 unprepare_out:
 	if (core->flags & CLK_OPS_PARENT_ENABLE)
 		clk_core_disable_unprepare(core->parent);
+
+	return ret;
 }
 
 static bool clk_ignore_unused __initdata;
@@ -1301,32 +1352,64 @@ static int __init clk_ignore_unused_setup(char *__unused)
 }
 __setup("clk_ignore_unused", clk_ignore_unused_setup);
 
-static int __init clk_disable_unused(void)
+static int __init _clk_disable_unused(void)
 {
 	struct clk_core *core;
+	int ret;
+
+	hlist_for_each_entry(core, &clk_root_list, child_node) {
+		ret = clk_disable_unused_subtree(core);
+		if (ret)
+			return ret;
+	}
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node) {
+		ret = clk_disable_unused_subtree(core);
+		if (ret)
+			return ret;
+	}
+
+	hlist_for_each_entry(core, &clk_root_list, child_node) {
+		ret = clk_unprepare_unused_subtree(core);
+		if (ret)
+			return ret;
+	}
+
+	hlist_for_each_entry(core, &clk_orphan_list, child_node) {
+		ret = clk_unprepare_unused_subtree(core);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int __init clk_disable_unused(void)
+{
+	int ret;
+	int backoff_ms = 1;
+	int tries_left;
 
 	if (clk_ignore_unused) {
 		pr_warn("clk: Not disabling unused clocks\n");
 		return 0;
 	}
 
-	clk_prepare_lock();
+	for (tries_left = 10; tries_left; tries_left--) {
+		clk_prepare_lock();
+		ret = _clk_disable_unused();
+		clk_prepare_unlock();
 
-	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_disable_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_disable_unused_subtree(core);
-
-	hlist_for_each_entry(core, &clk_root_list, child_node)
-		clk_unprepare_unused_subtree(core);
+		if (ret != -EAGAIN)
+			return ret;
 
-	hlist_for_each_entry(core, &clk_orphan_list, child_node)
-		clk_unprepare_unused_subtree(core);
+		msleep(backoff_ms);
+		backoff_ms *= 2;
+	}
 
-	clk_prepare_unlock();
+	pr_warn("clk: Failed to disable unused clocks\n");
 
-	return 0;
+	return ret;
 }
 late_initcall_sync(clk_disable_unused);
 
-- 
2.37.3.968.ga6b4b080e4-goog

