Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB5929389A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 11:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404844AbgJTJ4T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 05:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404843AbgJTJ4S (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 05:56:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A303BC0613CE
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:56:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x125so1490258yba.17
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2020 02:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=mTHvR51/zIOH5Wylk5aPNeS740zb8DyOzJ1y2CasJqY=;
        b=Yot/gHp/NaTMG9SVBXALbBe7esFIQ4U1TjBZRXHJFXY/AsZuWnLshkaJvOLWCiob9d
         LOLaGC7YUC26FMbWASxvW4/9o2jq3B+DfYgDujSSLp/mNt6NTxNg/AxQrp4BTiFhlbuI
         TKLhq7EzoQYvAXNOhveILGMYTU7b/MGPilTLZQxciApjXIDwznFd3hs0sdwBNJP46cw/
         9TpM4IOsbw5OYJgj5gHY48zAMkNYESDhL16YTbBzIulM9Qz5sM4d5tASF+cs/c2lKoRD
         4YZ+2PjokPfOuLuSEQJ6kkM6r8njk0gQxQt5g0I7d6dtM49GILUWUy/ssHyw5gpABrqr
         YTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=mTHvR51/zIOH5Wylk5aPNeS740zb8DyOzJ1y2CasJqY=;
        b=JqI12r7vcOJdeC+lIaa8SPbIhze7Iimes0RA2vU1j8SVVMtsG38HtGGNn1J7oNWt4S
         YDs1lnSbDLN5Vie6IF7bjp0u9Nj9o5iqHtkd6ZGCM9Cp8zUTv2vpY0ZIkexVrxDAq5bt
         UjAdgR5iBkyjW0x8NeAad9bSE5GC5Uj88q83VSJZF2YNk+44pIdj/768pU6nx9yWc1Es
         1ZziMFT4vPxN1E/VhDZ4djW8z7KDxQIzez1NO4AIwpzYc9tSVCIWtrDSdwRidYwS2dAn
         hEMawyPvjK0qIw+2LiMDgerb1vonLCQ1pQtvySj4mWUp8HR6bZZsqxx9wT6syR7veE2Q
         QZWg==
X-Gm-Message-State: AOAM530XD8Vxu8VE5HlONI28CicZKqFaYOFRnq5Hc7+HJDmqRieSsr6a
        6+pvS8iRPlyHfwGWthuFJ8GPFWPDR6VMufch
X-Google-Smtp-Source: ABdhPJwUqVZqxiRETKH2FvaHiDXbNjMiybsOopNYm1NPWOYfwjZ/9wcTFw3ZtX15gMUIn2ddUMF/MFApYE5hWJzd
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a25:b8a:: with SMTP id
 132mr2831478ybl.88.1603187777742; Tue, 20 Oct 2020 02:56:17 -0700 (PDT)
Date:   Tue, 20 Oct 2020 17:56:11 +0800
Message-Id: <20201020095611.1763815-1-josephjang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] power: suspend: Replace dpm_watchdog by sleep timer
From:   Joseph Jang <josephjang@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        jonglin@google.com, woodylin@google.com, markcheng@google.com,
        josephjang@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since dpm_watchdog just cover device power management,
we proposed sleep timer to cover not only device power management
issues, but also core power management hand issue.

Add sleep timer and timeout handler to prevent device stuck during suspend/
resume process. The timeout handler will dump disk sleep task at first
round timeout and trigger kernel panic at second round timeout.
The default timer for each round is defined in
CONFIG_PM_SLEEP_TIMER_TIMEOUT.

Signed-off-by: Joseph Jang <josephjang@google.com>
---
 drivers/base/power/main.c    | 69 ---------------------------
 include/linux/console.h      |  1 +
 kernel/power/Kconfig         | 27 ++++++-----
 kernel/power/suspend.c       | 19 ++++++++
 kernel/power/suspend_timer.h | 90 ++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c       |  5 ++
 6 files changed, 128 insertions(+), 83 deletions(-)
 create mode 100644 kernel/power/suspend_timer.h

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
diff --git a/include/linux/console.h b/include/linux/console.h
index 0670d3491e0e..5436d8dc600f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
 { }
 #endif
 extern bool console_suspend_enabled;
+extern int console_is_suspended(void);
 
 /* Suspend and resume console messages over PM events */
 extern void suspend_console(void);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index a7320f07689d..fa021837473b 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -207,21 +207,20 @@ config PM_SLEEP_DEBUG
 	def_bool y
 	depends on PM_DEBUG && PM_SLEEP
 
-config DPM_WATCHDOG
-	bool "Device suspend/resume watchdog"
-	depends on PM_DEBUG && PSTORE && EXPERT
+config PM_SLEEP_MONITOR
+	bool "Linux kernel suspend/resume process monitor"
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
+	This option will enable sleep timer to prevent device stuck
+	during suspend/resume process. Sleep timeout handler will dump
+	disk sleep task at first round timeout and trigger kernel panic
+	at second round timeout. The timer for each round is defined in
+	CONFIG_PM_SLEEP_TIMER_TIMEOUT.
+
+config PM_SLEEP_TIMER_TIMEOUT
+	int "Sleep timer timeout in seconds"
+	range 30 120
+	depends on PM_SLEEP_MONITOR
 
 config PM_TRACE
 	bool
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5ee7e5d..0272494e0d0e 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -32,6 +32,7 @@
 #include <linux/moduleparam.h>
 
 #include "power.h"
+#include "suspend_timer.h"
 
 const char * const pm_labels[] = {
 	[PM_SUSPEND_TO_IDLE] = "freeze",
@@ -61,6 +62,8 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+DECLARE_SLEEP_TIMER(st);
+
 /**
  * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
@@ -89,6 +92,8 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
+	stop_sleep_timer(&st);
+
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -114,6 +119,8 @@ static void s2idle_enter(void)
 	s2idle_state = S2IDLE_STATE_NONE;
 	raw_spin_unlock_irq(&s2idle_lock);
 
+	start_sleep_timer(&st);
+
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
 
@@ -179,6 +186,8 @@ void __init pm_states_init(void)
 	 * initialize mem_sleep_states[] accordingly here.
 	 */
 	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
+
+	init_sleep_timer(&st, sleep_timeout_handler);
 }
 
 static int __init mem_sleep_default_setup(char *str)
@@ -426,6 +435,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
+	stop_sleep_timer(&st);
+
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
@@ -451,6 +462,8 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
+	start_sleep_timer(&st);
+
  Enable_cpus:
 	suspend_enable_secondary_cpus();
 
@@ -610,6 +623,9 @@ int pm_suspend(suspend_state_t state)
 		return -EINVAL;
 
 	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
+
+	start_sleep_timer(&st);
+
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -617,6 +633,9 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+
+	stop_sleep_timer(&st);
+
 	pr_info("suspend exit\n");
 	return error;
 }
diff --git a/kernel/power/suspend_timer.h b/kernel/power/suspend_timer.h
new file mode 100644
index 000000000000..7e4c9e31bf09
--- /dev/null
+++ b/kernel/power/suspend_timer.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_SLEEP_TIMER_H
+#define _LINUX_SLEEP_TIMER_H
+
+#include <linux/sched/debug.h>
+
+#ifdef CONFIG_PM_SLEEP_MONITOR
+struct sleep_timer {
+	struct task_struct	*tsk;
+	struct timer_list	timer;
+};
+
+#define DECLARE_SLEEP_TIMER(st) \
+	struct sleep_timer st
+
+/**
+ * init_sleep_timer - Initialize sleep timer.
+ * @st: Sleep timer to initialize.
+ * @func: Sleep timer timeout handler.
+ */
+static void init_sleep_timer(struct sleep_timer *st, void (*func))
+{
+	struct timer_list *timer = &st->timer;
+
+	timer_setup(timer, func, 0);
+}
+
+/**
+ * start_sleep_timer - Enable sleep timer to monitor suspend thread.
+ * @st: Sleep timer to enable.
+ */
+static void start_sleep_timer(struct sleep_timer *st)
+{
+	struct timer_list *timer = &st->timer;
+
+	st->tsk = current;
+
+	/* use same timeout value for both suspend and resume */
+	timer->expires = jiffies + HZ * CONFIG_PM_SLEEP_TIMER_TIMEOUT;
+	add_timer(timer);
+}
+
+/**
+ * stop_sleep_timer - Disable sleep timer.
+ * @st: sleep timer to disable.
+ */
+static void stop_sleep_timer(struct sleep_timer *st)
+{
+	struct timer_list *timer = &st->timer;
+
+	del_timer_sync(timer);
+}
+
+/**
+ * sleep_timeout_handler - sleep timer timeout handler.
+ * @t: The timer list that sleep timer depends on.
+ *
+ * Called when suspend thread has timeout suspending or resuming.
+ * Dump all uninterruptible tasks' call stack and call panic() to
+ * reboot system in second round timeout.
+ */
+static void sleep_timeout_handler(struct timer_list *t)
+{
+	struct sleep_timer *st = from_timer(st, t, timer);
+	static int timeout_count;
+
+	pr_info("Sleep timeout (timer is %d seconds)\n",
+		(CONFIG_PM_SLEEP_TIMER_TIMEOUT));
+	show_stack(st->tsk, NULL, KERN_EMERG);
+	show_state_filter(TASK_UNINTERRUPTIBLE);
+
+	if (timeout_count < 1) {
+		timeout_count++;
+		start_sleep_timer(st);
+		return;
+	}
+
+	if (console_is_suspended())
+		resume_console();
+
+	panic("Sleep timeout and panic\n");
+}
+#else
+#define DECLARE_SLEEP_TIMER(st)
+#define init_sleep_timer(x, y)
+#define start_sleep_timer(x)
+#define stop_sleep_timer(x)
+#endif
+
+#endif /* _LINUX_SLEEP_TIMER_H */
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9b75f6bfc333..488cbc9abaaf 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2259,6 +2259,11 @@ module_param_named(console_suspend, console_suspend_enabled,
 MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
 	" and hibernate operations");
 
+int console_is_suspended(void)
+{
+	return console_suspended;
+}
+
 /**
  * suspend_console - suspend the console subsystem
  *
-- 
2.29.0.rc1.297.gfa9743e501-goog

