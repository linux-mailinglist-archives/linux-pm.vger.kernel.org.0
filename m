Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C9D1307309
	for <lists+linux-pm@lfdr.de>; Thu, 28 Jan 2021 10:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232396AbhA1Jmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 28 Jan 2021 04:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232430AbhA1JlB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Jan 2021 04:41:01 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316EC061786
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 01:39:35 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d38so5356313ybe.15
        for <linux-pm@vger.kernel.org>; Thu, 28 Jan 2021 01:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tEe1QCE3yqwNiMVafw6huRMzoV/OBPB4cid1d9n9GWs=;
        b=v7k69y/LY2pfhHof/y+CRII91Kcu3A6oRaBpc6VBJ67yQfkKaZWE5yGbLLiJBy1F6E
         t7KaRx/MrRC3ypfvi+eTamV0HEOYaLUk8YxXilS2NqUeCuNtvK+MdOcbCwZ5EyV0ru62
         Wd+efD4OeGZ58WldMoX/RQSg+vyUbFsVTMjWIJuwaLaNYs02Ubk4ois08AOJRSUmA7iZ
         abA2dFbPJwFrPzTEWXCRgJXnfwECvXmTPewywKRMIVyk0sWAdYGB+b4I0iMyR6m/FCVd
         qK9Uas7TOVNt5YkMCiJekeoMAv1q6+LvzgtgvTkfKCoAVoD2Lfwx4xYH8D5Ka7lS+OIg
         5LAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tEe1QCE3yqwNiMVafw6huRMzoV/OBPB4cid1d9n9GWs=;
        b=TQIf7EH3x6mZeR/Bj39aDW94WfLP1MdCRroPJB7AP8ugAxldBW1PUsigqAJh0Dc8pJ
         cjyDblSwvBOLvQHQ85TbYV56TVX0nyJaJMA9dAsRZCaynoe1KBhf6RhU5JVW21tVxBAJ
         qNlGvr3832jdU2mr1jz8f95okwrbBEirW2IEnAb/xsxavzHwsYA6iRooXQ9cWjqsfzb4
         aE5fLfbruDM3LIrQFa2nWHRKihvt4GSkeTP99OUckwchLRLTJZSWv6Fvklgn7R5+6CDf
         v9yiGiCCIi5mRMjqj/D7sOMbo/XZaSZtyw9W/MC9K+MWS+iumRS7FagD6v/2eL2UUMUA
         c3jQ==
X-Gm-Message-State: AOAM530lkAQRe3W3CqbU6sZEyJ3bnvKro8dQwMoa+MUvjsUTXXdGWpCG
        ICEY4l3YoAg/L0Rq0UfSw+tBRACqq5ckP6P7
X-Google-Smtp-Source: ABdhPJzRoquTKL5wcnqZPxvSM5UOmL5r8LmZ2bZABKItUgfML7dcoU+AQXjox1nicj0KjSQcCceLbNebYgK+Y3Wm
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:a5e2:e68a:ef67:8128])
 (user=josephjang job=sendgmr) by 2002:a25:e644:: with SMTP id
 d65mr22500833ybh.224.1611826774161; Thu, 28 Jan 2021 01:39:34 -0800 (PST)
Date:   Thu, 28 Jan 2021 17:39:27 +0800
Message-Id: <20210128093927.2206179-1-josephjang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.365.g02bc693789-goog
Subject: [PATCH v6] power: suspend: Move dpm_watchdog to suspend.c and enhance it
From:   Joseph Jang <josephjang@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        "David S . Miller " <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since dpm_watchdog just cover two functions __device_suspend() and
device_resume(), we proposed to move it to core power suspend.c to extend
its coverage and monitor more devices suspend hand issues.

We propose to use new name suspend watchdog and new timeout handler to
cover more sleep hang issues. The new timeout handler will dump disk
sleep task call trace at first round timeout and trigger kernel panic
at second round timeout.
The default timer for each round is defined in
CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT.

Signed-off-by: Joseph Jang <josephjang@google.com>
---
Changes since v5:
 - Remove MAINTAINERS update since we current MAINTAINERS already cover kernel/power/

Changes since v4:
 - Change #define PM_SUSPEND_WATCHDOG to CONFIG_PM_SUSPEND_WATCHDOG in suspend_watchdog.c
   to make sure we compile all suspend watchdog functions.
 - Add suspend watchdog functions declared in suspend_watchdog.h to prevent compile errors.

Changes since v3:
 - Change the naming from sleep timer to suspend watchdog.
 - Remove console_is_suspended() from console.h and printk.c
 - Add static declaration for suspend_watchdog struct since we use it in suspend.c only.
 - Move suspend watchdog real logic to suspend_watchdog.c.
 - Put the function prototypes in suspend_watchdog.h
 - Use inline functions for function prototypes definition.

Changes since v2:
 - Add kernel/power/suspend_timer.h in MAINTAINERS
 - Share some corner cases that dpm_watchdog cannot cover.
  Case#A: dpm_watchdog cannot cover suspend hang in suspend_enter().
  File: kernel/power/suspend.c
  int suspend_devices_and_enter(suspend_state_t state)
  {
   ... <SNIP>

         suspend_test_start();
         error = dpm_suspend_start(PMSG_SUSPEND);  <== dpm_watchdog will be enabled/disabled in this fucntion ...
         if (error) {
                 pr_err("Some devices failed to suspend, or early wake event detected\n");
                 goto Recover_platform;
         }
         suspend_test_finish("suspend devices");
         if (suspend_test(TEST_DEVICES))
                 goto Recover_platform;

         do {
                 error = suspend_enter(state, &wakeup);  <== but we encounter hang inside function suspend_enter() ...
         } while (!error && !wakeup && platform_suspend_again(state));

  Case#B: dpm_watchdog cannot cover resume hang in dpm_resume_early() because it enable/disable in device_resume().
  Call trace:
   __switch_to+0x174/0x194
   __schedule+0xa60/0x1464
   __cancel_work_timer+0x120/0x234
   chg_pm_resume+0x2c/0xd8
   dpm_run_callback+0x27c/0x624
   device_resume_early+0x1e4/0x1f8
   dpm_resume_early+0x350/0x8f4
   suspend_devices_and_enter+0xffc/0x168c
   pm_suspend+0xb54/0xdac

  File: drivers/base/power/main.c.
  static int device_resume(struct device *dev, pm_message_t state, bool async)
      if (!dpm_wait_for_superior(dev, async))
          goto Complete;
  
      dpm_watchdog_set(&wd, dev);
      device_lock(dev);
  
      /*
   ... <SNIP>
 
      Unlock:
          device_unlock(dev);
          dpm_watchdog_clear(&wd);

  Case#C: dpm_watchdog cannot cover suspend hang in ksys_sync().
   Call trace:
    __switch_to+0x1b0/0x1cc
    __schedule+0xac8/0x1314
    io_schedule+0x94/0xc8
    wait_on_page_bit+0x1f8/0x3a4
    __filemap_fdatawait_range+0x134/0x150
    sync_inodes_sb+0x368/0x584
    sync_inodes_one_sb+0x18/0x24
    iterate_supers+0x12c/0x2b8
    ksys_sync+0x48/0x12c
    enter_state+0x294/0x7bc
    pm_suspend+0x164/0x2a8

 - Explain some enhancement by following.
  Q1: Why not use the existing one?
  struct dpm_watchdog {
      struct device           *dev;
      struct task_struct      *tsk;
      struct timer_list       timer;
  };
  
  A1: In kernel/power/suspend.c, we don't have "struct device " because suspend.c is for core PM instead of device PM.
  So we propose to use sleep_timer struct.
  
  struct sleep_timer {
      struct task_struct	*tsk;
      struct timer_list	timer;
  };
  
  
  Q2: Why not use stack memory for timer struct?
  static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
  {
      ... <SNIP>  
      timer_setup_on_stack(timer, dpm_watchdog_handler, 0);  <== dpm_watchdog use stack memory for timer struct.
      /* use same timeout value for both suspend and resume */
      timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
      add_timer(timer);
  }
  
  A2: dpm_watchdog use stack memory has limitation.
  It cannot support starting watchdog at end of function like s2idle_enter().
  We cannot use stack memory for this case because the timer struct will be free when go back to caller.
  
  File: kernel/power/suspend.c
  static void s2idle_enter(void)
    {
          trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
  
  +       stop_sleep_timer(&st);
  +
          raw_spin_lock_irq(&s2idle_lock);
          if (pm_wakeup_pending())
                  goto out;
  ... <SNIP>
          s2idle_state = S2IDLE_STATE_NONE;
          raw_spin_unlock_irq(&s2idle_lock);
  
  +       start_sleep_timer(&st);
  +
          trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
    }
  
  So we propose to declare a global sleep timer struct in suspend.c like following.
  
  File: kernel/power/suspend.c
   static DEFINE_RAW_SPINLOCK(s2idle_lock);
   
  +DECLARE_SLEEP_TIMER(st);
  +
   /**
    * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  
  Using global timer has another advantage is we could support double calling add_timer()
  because add_timer() can easily to delete pending timer and add new timer by using the
  same timer struct.

  Q3: Why do you need to change the timeout handler?
  A3: dpm_watchdog_handler() need device struct to get device information, but suspend.c doesn't have it.
  In most of cases, we could know which device driver hang by tracing the suspend thread call stack logs
  without device struct information for debugging. So we propose to remove device struct and related
  information like "dev_driver_string(wd->dev)" and "dev_name(wd->dev)" from timeout handler.
  
   static void dpm_watchdog_handler(struct timer_list *t)
   {
       struct dpm_watchdog *wd = from_timer(wd, t, timer);
  
       dev_emerg(wd->dev, "**** DPM device timeout ****\n");
       show_stack(wd->tsk, NULL, KERN_EMERG);
       panic("%s %s: unrecoverable failure\n",
           dev_driver_string(wd->dev), dev_name(wd->dev));  <== we don't need it.
   }
  
   We propose to dump all disk sleep tasks call stack log twice to double confirm suspend thread hang at
   the same function and make sure other sleep tasks were stuck at the same function for a long time.
   We also try to resume conole if the console is suspended.
   At the end of watchdog timeout handler, we propose to trigger kernel panic to prevent system hang like
   dpm_watchdog.
  
  
  static void sleep_timeout_handler(struct timer_list *t)
  {
      struct sleep_timer *st = from_timer(st, t, timer);
      static int timeout_count;
  
      pr_info("Sleep timeout (timer is %d seconds)\n",
          (CONFIG_PM_SLEEP_TIMER_TIMEOUT));
      show_stack(st->tsk, NULL, KERN_EMERG);
      show_state_filter(TASK_UNINTERRUPTIBLE);
  
      if (timeout_count < 1) {
          timeout_count++;
          start_sleep_timer(st);
          return;
      }
  
      if (console_is_suspended())
          resume_console();
  
      panic("Sleep timeout and panic\n");
  }

Changes since v1:
  - Add commit message to explain why move dpm_watchdog to kernel/power/suspend.c.
  - Remove dpm_watchdog related functions in drivers/base/power/main.c.
  - Move suspend_timer.h from include/linux/ to kernel/power/.
---
 drivers/base/power/main.c       | 69 ---------------------------
 kernel/power/Kconfig            | 27 +++++------
 kernel/power/Makefile           |  1 +
 kernel/power/suspend.c          | 19 ++++++++
 kernel/power/suspend_watchdog.c | 84 +++++++++++++++++++++++++++++++++
 kernel/power/suspend_watchdog.h | 40 ++++++++++++++++
 kernel/printk/printk.c          |  2 +-
 7 files changed, 158 insertions(+), 84 deletions(-)
 create mode 100644 kernel/power/suspend_watchdog.c
 create mode 100644 kernel/power/suspend_watchdog.h

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 205a06752ca9..b08f91e31a70 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -496,69 +496,6 @@ static int dpm_run_callback(pm_callback_t cb, struct device *dev,
 	return error;
 }
 
-#ifdef CONFIG_DPM_WATCHDOG
-struct dpm_watchdog {
-	struct device		*dev;
-	struct task_struct	*tsk;
-	struct timer_list	timer;
-};
-
-#define DECLARE_DPM_WATCHDOG_ON_STACK(wd) \
-	struct dpm_watchdog wd
-
-/**
- * dpm_watchdog_handler - Driver suspend / resume watchdog handler.
- * @t: The timer that PM watchdog depends on.
- *
- * Called when a driver has timed out suspending or resuming.
- * There's not much we can do here to recover so panic() to
- * capture a crash-dump in pstore.
- */
-static void dpm_watchdog_handler(struct timer_list *t)
-{
-	struct dpm_watchdog *wd = from_timer(wd, t, timer);
-
-	dev_emerg(wd->dev, "**** DPM device timeout ****\n");
-	show_stack(wd->tsk, NULL, KERN_EMERG);
-	panic("%s %s: unrecoverable failure\n",
-		dev_driver_string(wd->dev), dev_name(wd->dev));
-}
-
-/**
- * dpm_watchdog_set - Enable pm watchdog for given device.
- * @wd: Watchdog. Must be allocated on the stack.
- * @dev: Device to handle.
- */
-static void dpm_watchdog_set(struct dpm_watchdog *wd, struct device *dev)
-{
-	struct timer_list *timer = &wd->timer;
-
-	wd->dev = dev;
-	wd->tsk = current;
-
-	timer_setup_on_stack(timer, dpm_watchdog_handler, 0);
-	/* use same timeout value for both suspend and resume */
-	timer->expires = jiffies + HZ * CONFIG_DPM_WATCHDOG_TIMEOUT;
-	add_timer(timer);
-}
-
-/**
- * dpm_watchdog_clear - Disable suspend/resume watchdog.
- * @wd: Watchdog to disable.
- */
-static void dpm_watchdog_clear(struct dpm_watchdog *wd)
-{
-	struct timer_list *timer = &wd->timer;
-
-	del_timer_sync(timer);
-	destroy_timer_on_stack(timer);
-}
-#else
-#define DECLARE_DPM_WATCHDOG_ON_STACK(wd)
-#define dpm_watchdog_set(x, y)
-#define dpm_watchdog_clear(x)
-#endif
-
 /*------------------------- Resume routines -------------------------*/
 
 /**
@@ -899,7 +836,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
 	int error = 0;
-	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
 	TRACE_RESUME(0);
@@ -916,7 +852,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 	if (!dpm_wait_for_superior(dev, async))
 		goto Complete;
 
-	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
 	/*
@@ -969,7 +904,6 @@ static int device_resume(struct device *dev, pm_message_t state, bool async)
 
  Unlock:
 	device_unlock(dev);
-	dpm_watchdog_clear(&wd);
 
  Complete:
 	complete_all(&dev->power.completion);
@@ -1593,7 +1527,6 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	pm_callback_t callback = NULL;
 	const char *info = NULL;
 	int error = 0;
-	DECLARE_DPM_WATCHDOG_ON_STACK(wd);
 
 	TRACE_DEVICE(dev);
 	TRACE_SUSPEND(0);
@@ -1647,7 +1580,6 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	dev->power.may_skip_resume = true;
 	dev->power.must_resume = false;
 
-	dpm_watchdog_set(&wd, dev);
 	device_lock(dev);
 
 	if (dev->pm_domain) {
@@ -1699,7 +1631,6 @@ static int __device_suspend(struct device *dev, pm_message_t state, bool async)
 	}
 
 	device_unlock(dev);
-	dpm_watchdog_clear(&wd);
 
  Complete:
 	if (error)
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index a7320f07689d..c1154e53d834 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -207,21 +207,20 @@ config PM_SLEEP_DEBUG
 	def_bool y
 	depends on PM_DEBUG && PM_SLEEP
 
-config DPM_WATCHDOG
-	bool "Device suspend/resume watchdog"
-	depends on PM_DEBUG && PSTORE && EXPERT
+config PM_SUSPEND_WATCHDOG
+	bool "Watchdog for linux kernel suspend/resume process"
+	depends on PM_SLEEP
 	help
-	  Sets up a watchdog timer to capture drivers that are
-	  locked up attempting to suspend/resume a device.
-	  A detected lockup causes system panic with message
-	  captured in pstore device for inspection in subsequent
-	  boot session.
-
-config DPM_WATCHDOG_TIMEOUT
-	int "Watchdog timeout in seconds"
-	range 1 120
-	default 120
-	depends on DPM_WATCHDOG
+	This option will enable suspend watchdog to prevent device stuck
+	during suspend/resume process. Suspend watchdog timeout handler
+	will dump disk sleep task at first round timeout and trigger
+	kernel panic at second round timeout. The timer for each round
+	is defined in CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT.
+
+config PM_SUSPEND_WATCHDOG_TIMEOUT
+	int "Suspend watchdog timeout in seconds"
+	range 30 120
+	depends on PM_SUSPEND_WATCHDOG
 
 config PM_TRACE
 	bool
diff --git a/kernel/power/Makefile b/kernel/power/Makefile
index 5899260a8bef..f711e391004b 100644
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PM)		+= main.o
 obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= console.o
 obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
+obj-$(CONFIG_PM_SUSPEND_WATCHDOG)	+= suspend_watchdog.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
 obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o
 obj-$(CONFIG_HIBERNATION_SNAPSHOT_DEV) += user.o
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5ee7e5d..a0e3dfb39f6e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -32,6 +32,7 @@
 #include <linux/moduleparam.h>
 
 #include "power.h"
+#include "suspend_watchdog.h"
 
 const char * const pm_labels[] = {
 	[PM_SUSPEND_TO_IDLE] = "freeze",
@@ -61,6 +62,8 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+static DECLARE_SUSPEND_WATCHDOG(suspend_wd);
+
 /**
  * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
@@ -89,6 +92,8 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
+	stop_suspend_watchdog(&suspend_wd);
+
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -114,6 +119,8 @@ static void s2idle_enter(void)
 	s2idle_state = S2IDLE_STATE_NONE;
 	raw_spin_unlock_irq(&s2idle_lock);
 
+	start_suspend_watchdog(&suspend_wd);
+
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
 
@@ -179,6 +186,8 @@ void __init pm_states_init(void)
 	 * initialize mem_sleep_states[] accordingly here.
 	 */
 	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
+
+	init_suspend_watchdog(&suspend_wd, suspend_timeout_handler);
 }
 
 static int __init mem_sleep_default_setup(char *str)
@@ -426,6 +435,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
+	stop_suspend_watchdog(&suspend_wd);
+
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
@@ -451,6 +462,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
+	start_suspend_watchdog(&suspend_wd);
+
  Enable_cpus:
 	suspend_enable_secondary_cpus();
 
@@ -610,6 +623,9 @@ int pm_suspend(suspend_state_t state)
 		return -EINVAL;
 
 	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
+
+	start_suspend_watchdog(&suspend_wd);
+
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -617,6 +633,9 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+
+	stop_suspend_watchdog(&suspend_wd);
+
 	pr_info("suspend exit\n");
 	return error;
 }
diff --git a/kernel/power/suspend_watchdog.c b/kernel/power/suspend_watchdog.c
new file mode 100644
index 000000000000..e6828f8dfb54
--- /dev/null
+++ b/kernel/power/suspend_watchdog.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kernel/power/suspend_watchdog.c - Suspend watchdog functionality.
+ *
+ * Copyright (c) 2020 Joseph Jang
+ */
+
+#define pr_fmt(fmt) "SWD: " fmt
+
+#include <linux/mm.h>
+#include <linux/sched/debug.h>
+#include <linux/console.h>
+
+#include "suspend_watchdog.h"
+
+#ifdef CONFIG_PM_SUSPEND_WATCHDOG
+
+/**
+ * init_suspend_watchdog - Initialize suspend watchdog timer.
+ * @suspend_wd: Suspend watchdog to initialize.
+ * @func: Suspend watchdog timeout handler.
+ */
+inline void init_suspend_watchdog(struct suspend_watchdog *suspend_wd, void *func)
+{
+	struct timer_list *timer = &suspend_wd->timer;
+
+	timer_setup(timer, func, 0);
+}
+
+/**
+ * start_suspend_watchdog - Enable suspend watchdog to monitor suspend thread.
+ * @suspend_wd: Suspend watchdog to enable.
+ */
+inline void start_suspend_watchdog(struct suspend_watchdog *suspend_wd)
+{
+	struct timer_list *timer = &suspend_wd->timer;
+
+	suspend_wd->tsk = current;
+
+	/* use same timeout value for both suspend and resume */
+	timer->expires = jiffies + HZ * CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT;
+	add_timer(timer);
+}
+
+/**
+ * stop_suspend_watchdog - Disable suspend watchdog.
+ * @suspend_wd: Suspend watchdog to disable.
+ */
+inline void stop_suspend_watchdog(struct suspend_watchdog *suspend_wd)
+{
+	struct timer_list *timer = &suspend_wd->timer;
+
+	del_timer_sync(timer);
+}
+
+/**
+ * suspend_timeout_handler - suspend watchdog timeout handler.
+ * @t: The timer list that suspend watchdog timer depends on.
+ *
+ * Called when suspend thread has timeout suspending or resuming.
+ * Dump all uninterruptible tasks' call stack and call panic() to
+ * reboot system in second round timeout.
+ */
+inline void suspend_timeout_handler(struct timer_list *t)
+{
+	struct suspend_watchdog *suspend_wd = from_timer(suspend_wd, t, timer);
+	static int timeout_count;
+
+	pr_info("Suspend watchdog timeout (timer is %d seconds)\n",
+		(CONFIG_PM_SUSPEND_WATCHDOG_TIMEOUT));
+	show_stack(suspend_wd->tsk, NULL, KERN_EMERG);
+	show_state_filter(TASK_UNINTERRUPTIBLE);
+
+	if (timeout_count < 1) {
+		timeout_count++;
+		start_suspend_watchdog(suspend_wd);
+		return;
+	}
+
+	resume_console();
+
+	panic("Sleep timeout and panic\n");
+}
+#endif
diff --git a/kernel/power/suspend_watchdog.h b/kernel/power/suspend_watchdog.h
new file mode 100644
index 000000000000..18037445a77b
--- /dev/null
+++ b/kernel/power/suspend_watchdog.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SUSPEND_WATCHDOG_H
+#define _LINUX_SUSPEND_WATCHDOG_H
+
+#include <linux/sched/debug.h>
+
+struct suspend_watchdog {
+	struct task_struct *tsk;
+	struct timer_list timer;
+};
+
+#define DECLARE_SUSPEND_WATCHDOG(suspend_wd) \
+	struct suspend_watchdog suspend_wd
+
+#ifdef CONFIG_PM_SUSPEND_WATCHDOG
+inline void init_suspend_watchdog(struct suspend_watchdog *suspend_wd,
+					 void *func);
+
+inline void start_suspend_watchdog(struct suspend_watchdog *suspend_wd);
+
+inline void stop_suspend_watchdog(struct suspend_watchdog *suspend_wd);
+
+inline void suspend_timeout_handler(struct timer_list *t);
+#else
+static inline void init_suspend_watchdog(struct suspend_watchdog *suspend_wd,
+					 void *func)
+{
+}
+static inline void start_suspend_watchdog(struct suspend_watchdog *suspend_wd)
+{
+}
+static inline void stop_suspend_watchdog(struct suspend_watchdog *suspend_wd)
+{
+}
+static inline void suspend_timeout_handler(struct timer_list *t)
+{
+}
+#endif
+
+#endif /* _LINUX_SUSPEND_WATCHDOG_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9b75f6bfc333..168cb7b3148b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2276,7 +2276,7 @@ void suspend_console(void)
 
 void resume_console(void)
 {
-	if (!console_suspend_enabled)
+	if ((!console_suspend_enabled) || (!console_suspended))
 		return;
 	down_console_sem();
 	console_suspended = 0;
-- 
2.30.0.365.g02bc693789-goog

