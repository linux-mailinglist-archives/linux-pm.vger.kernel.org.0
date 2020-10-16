Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDA4B28FCFD
	for <lists+linux-pm@lfdr.de>; Fri, 16 Oct 2020 05:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394288AbgJPDvz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 15 Oct 2020 23:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394286AbgJPDvz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2020 23:51:55 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFF0C061755
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 20:51:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id d6so651394qtp.2
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2020 20:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=sXKdKantA/B/7cvE0+qZ4RzzDFtgj1YOKdlFx3pZlLI=;
        b=UHsCEm8fXfGbfL3c5+IndcCPSASh1WbhRutKWoqlLFmvep8nBKqfSw7K/X/RW8cS+p
         OH5XQic+pFKMnQKELXAR+rGvxKTFeVqMUR2YKKMRe352ZpGEJ/ZKYqmgEPuFmBsDud+i
         iAPVYbyv7hPo4tlRqge2soLKc03PPGomPd0wLtgQmuVSxFEEqFQfc/b9jTvatymwKxaO
         K6kGPYGFKNcEUshGZrs0Q7lNA39s9H/SPi/qDj5aLNII8xZhREVynD2TQT50qKL0yPpR
         2JQfmMzrANtSk8hO8ZgWh+w5u2vEfkXuD/i6V3jOzI7f25r8d4ldyRONnsbzvAD8wv95
         2uaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=sXKdKantA/B/7cvE0+qZ4RzzDFtgj1YOKdlFx3pZlLI=;
        b=IKYYzLoIqeOkbagyi2Ga97b5tFIrpLqXg76fXtWdH6puHGfKw5dQtN8mXqYDYgXS2p
         iz6LqMpyu9cCcXKCCUa/ursMaYkqdU4xukEQzaY1Wf521E2DTjZHCeABYmtQymkENJiR
         4P5OrMnSGq85K8JDyaGnyEPGkDNiL7Mm06ORvF1h7oTEY3gWf02XICbTfXmk8mMt313C
         Py2x7l93kq3iXoF9uG8jtdV4OlD1UlzWbPjyHCjGkgpfUzZL2yUXwEfcXDoqa/d0BPx/
         zpnXfSAkSQsPBYM9eLTnNK4B7fm/9LF412YdxR8eYHxBqDJY0Ma9ptcTqF+420NEyNeT
         OdBg==
X-Gm-Message-State: AOAM530JhglkG9fXTKKvV6msIArmsiwzedpuDMN2CmbNpfMSf3PII7LM
        qfimcKN7VO0LEejoagRqhBXSdJ6gScbOOcC2
X-Google-Smtp-Source: ABdhPJzAnZVGRYo5RLAZQrtAuq/EUy0az6RkY0ZXdHtn+6Gnu4lLiCda1rBtWXnGQyVsSxX/M7AQXtO6xS1HOA+O
Sender: "josephjang via sendgmr" 
        <josephjang@josephjang-p920.ntc.corp.google.com>
X-Received: from josephjang-p920.ntc.corp.google.com ([2401:fa00:fc:1:7220:84ff:fe09:41e0])
 (user=josephjang job=sendgmr) by 2002:a05:6214:10c4:: with SMTP id
 r4mr1867612qvs.62.1602820314322; Thu, 15 Oct 2020 20:51:54 -0700 (PDT)
Date:   Fri, 16 Oct 2020 11:51:09 +0800
Message-Id: <20201016035109.3952356-1-josephjang@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] power: suspend: Add suspend timeout handler
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

From: josephjang <josephjang@google.com>

Add suspend timeout handler to prevent device stuck during suspend/
resume process. Suspend timeout handler will dump disk sleep task
at first round timeout and trigger kernel panic at second round timeout.
The default timer for each round is 30 seconds.

Note: Can use following command to simulate suspend hang for testing.
    adb shell echo 1 > /sys/power/pm_hang
    adb shell echo mem > /sys/power/state
Signed-off-by: josephjang <josephjang@google.com>
---
 include/linux/console.h |   1 +
 kernel/power/Kconfig    |   9 +++
 kernel/power/main.c     |  66 ++++++++++++++++
 kernel/power/suspend.c  | 162 ++++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c  |   5 ++
 5 files changed, 243 insertions(+)

diff --git a/include/linux/console.h b/include/linux/console.h
index 0670d3491e0e..ac468c602c0b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -192,6 +192,7 @@ static inline void console_sysfs_notify(void)
 { }
 #endif
 extern bool console_suspend_enabled;
+extern int is_console_suspended(void);
 
 /* Suspend and resume console messages over PM events */
 extern void suspend_console(void);
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index a7320f07689d..52b7a181b6d8 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -207,6 +207,15 @@ config PM_SLEEP_DEBUG
 	def_bool y
 	depends on PM_DEBUG && PM_SLEEP
 
+config PM_SLEEP_MONITOR
+	bool "Linux kernel suspend/resume process monitor"
+	depends on PM_SLEEP
+	help
+	This option will enable suspend/resume monitor to prevent device
+	stuck during suspend/resume process. Suspend timeout handler will
+	dump disk sleep task at first round timeout and trigger kernel panic
+	at second round timeout. The default timer for each round is 30 seconds.
+
 config DPM_WATCHDOG
 	bool "Device suspend/resume watchdog"
 	depends on PM_DEBUG && PSTORE && EXPERT
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 40f86ec4ab30..f25b8a47583e 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -575,6 +575,69 @@ void __pm_pr_dbg(bool defer, const char *fmt, ...)
 static inline void pm_print_times_init(void) {}
 #endif /* CONFIG_PM_SLEEP_DEBUG */
 
+#ifdef CONFIG_PM_SLEEP_MONITOR
+/* If set, devices will stuck at suspend for verification */
+static bool pm_hang_enabled;
+
+static int pm_notify_test(struct notifier_block *nb,
+			     unsigned long mode, void *_unused)
+{
+	pr_info("Jump into infinite loop now\n");
+
+	/* Suspend thread stuck at a loop forever */
+	for (;;)
+		;
+
+	pr_info("Fail to stuck at loop\n");
+
+	return 0;
+}
+
+static struct notifier_block pm_notify_nb = {
+	.notifier_call = pm_notify_test,
+};
+
+static ssize_t pm_hang_show(struct kobject *kobj, struct kobj_attribute *attr,
+			     char *buf)
+{
+	return snprintf(buf, 10, "%d\n", pm_hang_enabled);
+}
+
+static ssize_t pm_hang_store(struct kobject *kobj, struct kobj_attribute *attr,
+			      const char *buf, size_t n)
+{
+	unsigned long val;
+	int result;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	pm_hang_enabled = !!val;
+
+	if (pm_hang_enabled == true) {
+
+		result = register_pm_notifier(&pm_notify_nb);
+		if (result)
+			pr_warn("Can not register suspend notifier, return %d\n",
+				result);
+
+	} else {
+
+		result = unregister_pm_notifier(&pm_notify_nb);
+		if (result)
+			pr_warn("Can not unregister suspend notifier, return %d\n",
+				result);
+	}
+
+	return n;
+}
+
+power_attr(pm_hang);
+#endif
+
 struct kobject *power_kobj;
 
 /**
@@ -909,6 +972,9 @@ static struct attribute * g[] = {
 	&pm_wakeup_irq_attr.attr,
 	&pm_debug_messages_attr.attr,
 #endif
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	&pm_hang_attr.attr,
+#endif
 #endif
 #ifdef CONFIG_FREEZER
 	&pm_freeze_timeout_attr.attr,
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 8b1bb5ee7e5d..6f2679cfd9d1 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -30,6 +30,12 @@
 #include <trace/events/power.h>
 #include <linux/compiler.h>
 #include <linux/moduleparam.h>
+#ifdef CONFIG_PM_SLEEP_MONITOR
+#include <linux/sched/debug.h>
+#include <linux/kthread.h>
+#include <linux/sched.h>
+#include <uapi/linux/sched/types.h>
+#endif
 
 #include "power.h"
 
@@ -61,6 +67,133 @@ static DECLARE_SWAIT_QUEUE_HEAD(s2idle_wait_head);
 enum s2idle_states __read_mostly s2idle_state;
 static DEFINE_RAW_SPINLOCK(s2idle_lock);
 
+#ifdef CONFIG_PM_SLEEP_MONITOR
+/* Suspend monitor thread toggle reason */
+enum toggle_reason {
+	TOGGLE_NONE,
+	TOGGLE_START,
+	TOGGLE_STOP,
+};
+
+#define SUSPEND_TIMER_TIMEOUT_MS 30000
+static struct task_struct *ksuspend_mon_tsk;
+static DECLARE_WAIT_QUEUE_HEAD(power_suspend_waitqueue);
+static enum toggle_reason suspend_mon_toggle;
+static DEFINE_MUTEX(suspend_mon_lock);
+
+static void start_suspend_mon(void)
+{
+	mutex_lock(&suspend_mon_lock);
+	suspend_mon_toggle = TOGGLE_START;
+	mutex_unlock(&suspend_mon_lock);
+	wake_up(&power_suspend_waitqueue);
+}
+
+static void stop_suspend_mon(void)
+{
+	mutex_lock(&suspend_mon_lock);
+	suspend_mon_toggle = TOGGLE_STOP;
+	mutex_unlock(&suspend_mon_lock);
+	wake_up(&power_suspend_waitqueue);
+}
+
+static void suspend_timeout(int timeout_count)
+{
+	char *null_pointer = NULL;
+
+	pr_info("Suspend monitor timeout (timer is %d seconds)\n",
+		(SUSPEND_TIMER_TIMEOUT_MS/1000));
+
+	show_state_filter(TASK_UNINTERRUPTIBLE);
+
+	if (timeout_count < 2)
+		return;
+
+	if (is_console_suspended())
+		resume_console();
+
+	pr_info("Trigger a panic\n");
+
+	/* Trigger a NULL pointer dereference */
+	*null_pointer = 'a';
+
+	/* Should not reach here */
+	pr_err("Trigger panic failed!\n");
+}
+
+static int suspend_monitor_kthread(void *arg)
+{
+	long err;
+	struct sched_param param = {.sched_priority
+		= MAX_RT_PRIO-1};
+	static int timeout_count;
+	static long timeout;
+
+	pr_info("Init ksuspend_mon thread\n");
+
+	sched_setscheduler(current, SCHED_FIFO, &param);
+
+	timeout_count = 0;
+	timeout = MAX_SCHEDULE_TIMEOUT;
+
+	do {
+		/* Wait suspend timer timeout */
+		err = wait_event_interruptible_timeout(
+			power_suspend_waitqueue,
+			(suspend_mon_toggle != TOGGLE_NONE),
+			timeout);
+
+		mutex_lock(&suspend_mon_lock);
+		/* suspend monitor state change */
+		if (suspend_mon_toggle != TOGGLE_NONE) {
+			if (suspend_mon_toggle == TOGGLE_START) {
+				timeout = msecs_to_jiffies(
+					SUSPEND_TIMER_TIMEOUT_MS);
+				pr_info("Start suspend monitor\n");
+			} else if (suspend_mon_toggle == TOGGLE_STOP) {
+				timeout = MAX_SCHEDULE_TIMEOUT;
+				timeout_count = 0;
+				pr_info("Stop suspend monitor\n");
+			}
+			suspend_mon_toggle = TOGGLE_NONE;
+			mutex_unlock(&suspend_mon_lock);
+			continue;
+		}
+		mutex_unlock(&suspend_mon_lock);
+
+		/* suspend monitor event handler */
+		if (err == 0) {
+			timeout_count++;
+			suspend_timeout(timeout_count);
+		} else if (err == -ERESTARTSYS) {
+			pr_info("Exit ksuspend_mon!");
+			break;
+		}
+	} while (1);
+
+	return 0;
+}
+
+static void init_suspend_monitor_thread(void)
+{
+	int ret;
+
+	ksuspend_mon_tsk = kthread_create(suspend_monitor_kthread,
+		NULL, "ksuspend_mon");
+	if (IS_ERR(ksuspend_mon_tsk)) {
+		ret = PTR_ERR(ksuspend_mon_tsk);
+		ksuspend_mon_tsk = NULL;
+		pr_err("Create suspend_monitor_kthread failed! ret = %d\n",
+			ret);
+		return;
+	}
+
+	suspend_mon_toggle = TOGGLE_NONE;
+	wake_up_process(ksuspend_mon_tsk);
+
+}
+#endif
+
 /**
  * pm_suspend_default_s2idle - Check if suspend-to-idle is the default suspend.
  *
@@ -89,6 +222,10 @@ static void s2idle_enter(void)
 {
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, true);
 
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	stop_suspend_mon();
+#endif
+
 	raw_spin_lock_irq(&s2idle_lock);
 	if (pm_wakeup_pending())
 		goto out;
@@ -114,6 +251,10 @@ static void s2idle_enter(void)
 	s2idle_state = S2IDLE_STATE_NONE;
 	raw_spin_unlock_irq(&s2idle_lock);
 
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	start_suspend_mon();
+#endif
+
 	trace_suspend_resume(TPS("machine_suspend"), PM_SUSPEND_TO_IDLE, false);
 }
 
@@ -179,6 +320,9 @@ void __init pm_states_init(void)
 	 * initialize mem_sleep_states[] accordingly here.
 	 */
 	mem_sleep_states[PM_SUSPEND_TO_IDLE] = mem_sleep_labels[PM_SUSPEND_TO_IDLE];
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	init_suspend_monitor_thread();
+#endif
 }
 
 static int __init mem_sleep_default_setup(char *str)
@@ -426,6 +570,10 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	if (error || suspend_test(TEST_CPUS))
 		goto Enable_cpus;
 
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	stop_suspend_mon();
+#endif
+
 	arch_suspend_disable_irqs();
 	BUG_ON(!irqs_disabled());
 
@@ -451,6 +599,10 @@ static int suspend_enter(suspend_state_t state, bool *wakeup)
 	arch_suspend_enable_irqs();
 	BUG_ON(irqs_disabled());
 
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	start_suspend_mon();
+#endif
+
  Enable_cpus:
 	suspend_enable_secondary_cpus();
 
@@ -610,6 +762,11 @@ int pm_suspend(suspend_state_t state)
 		return -EINVAL;
 
 	pr_info("suspend entry (%s)\n", mem_sleep_labels[state]);
+
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	start_suspend_mon();
+#endif
+
 	error = enter_state(state);
 	if (error) {
 		suspend_stats.fail++;
@@ -617,6 +774,11 @@ int pm_suspend(suspend_state_t state)
 	} else {
 		suspend_stats.success++;
 	}
+
+#ifdef CONFIG_PM_SLEEP_MONITOR
+	stop_suspend_mon();
+#endif
+
 	pr_info("suspend exit\n");
 	return error;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9b75f6bfc333..58db8762eeda 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2259,6 +2259,11 @@ module_param_named(console_suspend, console_suspend_enabled,
 MODULE_PARM_DESC(console_suspend, "suspend console during suspend"
 	" and hibernate operations");
 
+int is_console_suspended(void)
+{
+	return console_suspended;
+}
+
 /**
  * suspend_console - suspend the console subsystem
  *
-- 
2.29.0.rc1.297.gfa9743e501-goog

