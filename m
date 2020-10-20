Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAAC42934E5
	for <lists+linux-pm@lfdr.de>; Tue, 20 Oct 2020 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgJTGWh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Oct 2020 02:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgJTGWh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Oct 2020 02:22:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36116C0613D1
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 23:22:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x125so1002611yba.17
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2020 23:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=3WTd3vJrc59gxxVkJqACc6QhdOqrRjexa8OBCSaqZgU=;
        b=OdmweLia1oz4xqJhHNKdWEAuMUEhYrGUkpBOY+Z6fdy8yDxOyamkwHxcBaTlC7l0KH
         kyeYiLAA/kF1/A1s/rPo8MgKkXM444o15br6Ppq4iqUOi9qwrHqJqd3GFB8dCRIjyVov
         4vTyMG9PR27M3ud6e/RWn+vhiePmgQ4/rq9qX7cE7tXAR6SjiUSxq8VYXVh0wN7bbHti
         tjii1qLwYwk68M3ycjs1pftkvHdyTmOlqAK7V1YFbfyQlcFRrKaAom3OpqdGYlfN7cKc
         LkRt07UTI5Qd4zrgmIDbGLzmnDYBMq4EmTJzGd6pQakrN3ZxGE1Fa3IOo9jdCJ7Z185J
         RUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=3WTd3vJrc59gxxVkJqACc6QhdOqrRjexa8OBCSaqZgU=;
        b=FL++1Ev9UWHo+dDiZZK6kSAhFm4dxzXPA+9mEwp4eV1KS9BwqsBrPZgZf6mq+r+Mij
         o/QKlFZdCv6vVA1uBPztcAwtUlPfdCk3H+9u1UQ62GQi8xQVOOaUCRj0lychRq5QnqES
         6/6wSg3OfwjtUqlZ54Pm4GrKw+Yppprog+dIuWHYKlN4D49qfsfILG16eYr/FBSEQsca
         cDUdo09f3d2w0TTRuxoFFuyPKlL6msl0fRKEeiZ+njd52vtG+bCaktWTFSRBMwzNbdww
         Oxba3DeCLibcGW8ga4xXdyGF5BM2Wjrt6lh5zKBgMNtKDvm1++i94plxZMlUdk6iTWpZ
         vRlg==
X-Gm-Message-State: AOAM5339rOTQNz/CWyce4rKiMMyYHD9+9Sf+yaPwUvLwlRg5ggUPzFDv
        L0QJuD33iK6+ODr0EP+LIPy8/11n3WYeqgGo
X-Google-Smtp-Source: ABdhPJwe1CPwLj3k2q7tsggk34ksnF+E/8Moczo7uOISRu7SWd66/fsVQ+GwTBXtdEDgNdetgkfc6TEhVIexPzW4
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a25:2d03:: with SMTP id
 t3mr2102063ybt.149.1603174956342; Mon, 19 Oct 2020 23:22:36 -0700 (PDT)
Date:   Tue, 20 Oct 2020 14:22:26 +0800
Message-Id: <20201020062226.1457732-1-josephjang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] power: suspend: Add sleep timer and timeout handler
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

Add sleep timer and timeout handler to prevent device stuck during suspend/
resume process. The timeout handler will dump disk sleep task at first
round timeout and trigger kernel panic at second round timeout.
The default timer for each round is defined in
CONFIG_PM_SLEEP_TIMER_TIMEOUT.

Signed-off-by: Joseph Jang <josephjang@google.com>
---
 MAINTAINERS                   |  2 +
 include/linux/console.h       |  1 +
 include/linux/suspend_timer.h | 90 +++++++++++++++++++++++++++++++++++
 kernel/power/Kconfig          | 15 ++++++
 kernel/power/suspend.c        | 19 ++++++++
 kernel/printk/printk.c        |  5 ++
 6 files changed, 132 insertions(+)
 create mode 100644 include/linux/suspend_timer.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 867157311dc8..8ae91f5ff3ff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7787,6 +7787,7 @@ F:	drivers/base/power/
 F:	include/linux/freezer.h
 F:	include/linux/pm.h
 F:	include/linux/suspend.h
+F:	include/linux/suspend_timer.h
 F:	kernel/power/
 
 HID CORE LAYER
@@ -16629,6 +16630,7 @@ F:	drivers/base/power/
 F:	include/linux/freezer.h
 F:	include/linux/pm.h
 F:	include/linux/suspend.h
+F:	include/linux/suspend_timer.h
 F:	kernel/power/
 
 SVGA HANDLING
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
diff --git a/include/linux/suspend_timer.h b/include/linux/suspend_timer.h
new file mode 100644
index 000000000000..7e4c9e31bf09
--- /dev/null
+++ b/include/linux/suspend_timer.h
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
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index a7320f07689d..9e2b274db0c1 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -207,6 +207,21 @@ config PM_SLEEP_DEBUG
 	def_bool y
 	depends on PM_DEBUG && PM_SLEEP
 
+config PM_SLEEP_MONITOR
+	bool "Linux kernel suspend/resume process monitor"
+	depends on PM_SLEEP
+	help
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
+
 config DPM_WATCHDOG
 	bool "Device suspend/resume watchdog"
 	depends on PM_DEBUG && PSTORE && EXPERT
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5ee7e5d..366ebd49a353 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/export.h>
 #include <linux/suspend.h>
+#include <linux/suspend_timer.h>
 #include <linux/syscore_ops.h>
 #include <linux/swait.h>
 #include <linux/ftrace.h>
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

