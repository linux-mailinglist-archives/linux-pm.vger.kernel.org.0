Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E783B2B66
	for <lists+linux-pm@lfdr.de>; Thu, 24 Jun 2021 11:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFXJam (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 24 Jun 2021 05:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhFXJak (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 24 Jun 2021 05:30:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B24C061574;
        Thu, 24 Jun 2021 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=GNFqlEF0rANh8OkcLJ7LNmtgTzh9OpPo8o607WxodYU=; b=kRIuBbTXNbdAXZcEU39EVTryMS
        uCE9+Kybm2qZn0rGwR3TJJ1fYV034gLvLeQhLTA31TZwm12S3IWkujCGR1Pv7C0LSZ2wTutovR2xi
        uEQdYbMJSy4zBaFqlNcVkP65WsXS0mObsjeKY0Ygy0CNwoFVoxaCJdLvizqFOZUrV+DTw1aNGIBof
        KdtyL5OaiamF6Kf7RS7ixksEjxGg9+m8QW5XVMPpM2EutdceqFC+/geBU3hEfQU77PYWqKiDMsuZF
        wGJvel5/gV3hw+mybJs3jvhHCLuqWypizrVOxIWIEzovOzudkRuVIShHShkvYmqrtjBs4GTVeBxgZ
        MLz8j3gg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwLdd-00GOuj-Ft; Thu, 24 Jun 2021 09:27:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BE93C30022B;
        Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id A44A12B64C05C; Thu, 24 Jun 2021 11:27:07 +0200 (CEST)
Message-ID: <20210624092615.824051127@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 24 Jun 2021 11:21:57 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 1/4] freezer: Have {,un}lock_system_sleep() save/restore flags
References: <20210624092156.332208049@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rafael explained that the reason for having both PF_NOFREEZE and
PF_FREEZER_SKIP is that {,un}lock_system_sleep() is callable from
kthread context that has previously called set_freezable().

In preparation of merging the flags, have {,un}lock_system_slee() save
and restore current->flags.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 drivers/scsi/scsi_transport_spi.c |    7 ++++---
 include/linux/suspend.h           |    8 ++++----
 kernel/power/hibernate.c          |   35 ++++++++++++++++++++++-------------
 kernel/power/main.c               |   16 ++++++++++------
 kernel/power/suspend.c            |   12 ++++++++----
 kernel/power/user.c               |   24 ++++++++++++++----------
 6 files changed, 62 insertions(+), 40 deletions(-)

--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -998,8 +998,9 @@ void
 spi_dv_device(struct scsi_device *sdev)
 {
 	struct scsi_target *starget = sdev->sdev_target;
-	u8 *buffer;
 	const int len = SPI_MAX_ECHO_BUFFER_SIZE*2;
+	unsigned int sleep_flags;
+	u8 *buffer;
 
 	/*
 	 * Because this function and the power management code both call
@@ -1007,7 +1008,7 @@ spi_dv_device(struct scsi_device *sdev)
 	 * while suspend or resume is in progress. Hence the
 	 * lock/unlock_system_sleep() calls.
 	 */
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (scsi_autopm_get_device(sdev))
 		goto unlock_system_sleep;
@@ -1058,7 +1059,7 @@ spi_dv_device(struct scsi_device *sdev)
 	scsi_autopm_put_device(sdev);
 
 unlock_system_sleep:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL(spi_dv_device);
 
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -518,8 +518,8 @@ extern bool pm_save_wakeup_count(unsigne
 extern void pm_wakep_autosleep_enabled(bool set);
 extern void pm_print_active_wakeup_sources(void);
 
-extern void lock_system_sleep(void);
-extern void unlock_system_sleep(void);
+extern unsigned int lock_system_sleep(void);
+extern void unlock_system_sleep(unsigned int);
 
 #else /* !CONFIG_PM_SLEEP */
 
@@ -542,8 +542,8 @@ static inline void pm_system_wakeup(void
 static inline void pm_wakeup_clear(bool reset) {}
 static inline void pm_system_irq_wakeup(unsigned int irq_number) {}
 
-static inline void lock_system_sleep(void) {}
-static inline void unlock_system_sleep(void) {}
+static inline unsigned int lock_system_sleep(void) { return 0; }
+static inline void unlock_system_sleep(unsigned int flags) {}
 
 #endif /* !CONFIG_PM_SLEEP */
 
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -90,20 +90,24 @@ bool hibernation_available(void)
  */
 void hibernation_set_ops(const struct platform_hibernation_ops *ops)
 {
+	unsigned int sleep_flags;
+
 	if (ops && !(ops->begin && ops->end &&  ops->pre_snapshot
 	    && ops->prepare && ops->finish && ops->enter && ops->pre_restore
 	    && ops->restore_cleanup && ops->leave)) {
 		WARN_ON(1);
 		return;
 	}
-	lock_system_sleep();
+
+	sleep_flags = lock_system_sleep();
+
 	hibernation_ops = ops;
 	if (ops)
 		hibernation_mode = HIBERNATION_PLATFORM;
 	else if (hibernation_mode == HIBERNATION_PLATFORM)
 		hibernation_mode = HIBERNATION_SHUTDOWN;
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(hibernation_set_ops);
 
@@ -707,6 +711,7 @@ static int load_image_and_restore(void)
 int hibernate(void)
 {
 	bool snapshot_test = false;
+	unsigned int sleep_flags;
 	int error;
 
 	if (!hibernation_available()) {
@@ -714,7 +719,7 @@ int hibernate(void)
 		return -EPERM;
 	}
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -788,7 +793,7 @@ int hibernate(void)
 	pm_restore_console();
 	hibernate_release();
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 	pr_info("hibernation exit\n");
 
 	return error;
@@ -803,9 +808,10 @@ int hibernate(void)
  */
 int hibernate_quiet_exec(int (*func)(void *data), void *data)
 {
+	unsigned int sleep_flags;
 	int error;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -885,7 +891,7 @@ int hibernate_quiet_exec(int (*func)(voi
 	hibernate_release();
 
 unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error;
 }
@@ -1094,11 +1100,12 @@ static ssize_t disk_show(struct kobject
 static ssize_t disk_store(struct kobject *kobj, struct kobj_attribute *attr,
 			  const char *buf, size_t n)
 {
+	int mode = HIBERNATION_INVALID;
+	unsigned int sleep_flags;
 	int error = 0;
-	int i;
 	int len;
 	char *p;
-	int mode = HIBERNATION_INVALID;
+	int i;
 
 	if (!hibernation_available())
 		return -EPERM;
@@ -1106,7 +1113,7 @@ static ssize_t disk_store(struct kobject
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	for (i = HIBERNATION_FIRST; i <= HIBERNATION_MAX; i++) {
 		if (len == strlen(hibernation_modes[i])
 		    && !strncmp(buf, hibernation_modes[i], len)) {
@@ -1136,7 +1143,7 @@ static ssize_t disk_store(struct kobject
 	if (!error)
 		pm_pr_dbg("Hibernation mode set to '%s'\n",
 			       hibernation_modes[mode]);
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 	return error ? error : n;
 }
 
@@ -1152,9 +1159,10 @@ static ssize_t resume_show(struct kobjec
 static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 			    const char *buf, size_t n)
 {
-	dev_t res;
+	unsigned int sleep_flags;
 	int len = n;
 	char *name;
+	dev_t res;
 
 	if (len && buf[len-1] == '\n')
 		len--;
@@ -1167,9 +1175,10 @@ static ssize_t resume_store(struct kobje
 	if (!res)
 		return -EINVAL;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 	swsusp_resume_device = res;
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
+
 	pm_pr_dbg("Configured hibernation resume from disk to %u\n",
 		  swsusp_resume_device);
 	noresume = 0;
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -21,14 +21,16 @@
 
 #ifdef CONFIG_PM_SLEEP
 
-void lock_system_sleep(void)
+unsigned int lock_system_sleep(void)
 {
+	unsigned int flags = current->flags;
 	current->flags |= PF_FREEZER_SKIP;
 	mutex_lock(&system_transition_mutex);
+	return flags;
 }
 EXPORT_SYMBOL_GPL(lock_system_sleep);
 
-void unlock_system_sleep(void)
+void unlock_system_sleep(unsigned int flags)
 {
 	/*
 	 * Don't use freezer_count() because we don't want the call to
@@ -46,7 +48,8 @@ void unlock_system_sleep(void)
 	 * Which means, if we use try_to_freeze() here, it would make them
 	 * enter the refrigerator, thus causing hibernation to lockup.
 	 */
-	current->flags &= ~PF_FREEZER_SKIP;
+	if (!(flags & PF_FREEZER_SKIP))
+		current->flags &= ~PF_FREEZER_SKIP;
 	mutex_unlock(&system_transition_mutex);
 }
 EXPORT_SYMBOL_GPL(unlock_system_sleep);
@@ -260,16 +263,17 @@ static ssize_t pm_test_show(struct kobje
 static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
 				const char *buf, size_t n)
 {
+	unsigned int sleep_flags;
 	const char * const *s;
+	int error = -EINVAL;
 	int level;
 	char *p;
 	int len;
-	int error = -EINVAL;
 
 	p = memchr(buf, '\n', n);
 	len = p ? p - buf : n;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	level = TEST_FIRST;
 	for (s = &pm_tests[level]; level <= TEST_MAX; s++, level++)
@@ -279,7 +283,7 @@ static ssize_t pm_test_store(struct kobj
 			break;
 		}
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error ? error : n;
 }
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -75,9 +75,11 @@ EXPORT_SYMBOL_GPL(pm_suspend_default_s2i
 
 void s2idle_set_ops(const struct platform_s2idle_ops *ops)
 {
-	lock_system_sleep();
+	unsigned int sleep_flags;
+
+	sleep_flags = lock_system_sleep();
 	s2idle_ops = ops;
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 
 static void s2idle_begin(void)
@@ -202,7 +204,9 @@ __setup("mem_sleep_default=", mem_sleep_
  */
 void suspend_set_ops(const struct platform_suspend_ops *ops)
 {
-	lock_system_sleep();
+	unsigned int sleep_flags;
+
+	sleep_flags = lock_system_sleep();
 
 	suspend_ops = ops;
 
@@ -218,7 +222,7 @@ void suspend_set_ops(const struct platfo
 			mem_sleep_current = PM_SUSPEND_MEM;
 	}
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 }
 EXPORT_SYMBOL_GPL(suspend_set_ops);
 
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -46,12 +46,13 @@ int is_hibernate_resume_dev(dev_t dev)
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	int error;
 
 	if (!hibernation_available())
 		return -EPERM;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	if (!hibernate_acquire()) {
 		error = -EBUSY;
@@ -97,7 +98,7 @@ static int snapshot_open(struct inode *i
 	data->dev = 0;
 
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return error;
 }
@@ -105,8 +106,9 @@ static int snapshot_open(struct inode *i
 static int snapshot_release(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	swsusp_free();
 	data = filp->private_data;
@@ -123,7 +125,7 @@ static int snapshot_release(struct inode
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
 	hibernate_release();
 
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return 0;
 }
@@ -131,11 +133,12 @@ static int snapshot_release(struct inode
 static ssize_t snapshot_read(struct file *filp, char __user *buf,
                              size_t count, loff_t *offp)
 {
+	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	ssize_t res;
-	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	data = filp->private_data;
 	if (!data->ready) {
@@ -156,7 +159,7 @@ static ssize_t snapshot_read(struct file
 		*offp += res;
 
  Unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return res;
 }
@@ -164,11 +167,12 @@ static ssize_t snapshot_read(struct file
 static ssize_t snapshot_write(struct file *filp, const char __user *buf,
                               size_t count, loff_t *offp)
 {
+	loff_t pg_offp = *offp & ~PAGE_MASK;
 	struct snapshot_data *data;
+	unsigned int sleep_flags;
 	ssize_t res;
-	loff_t pg_offp = *offp & ~PAGE_MASK;
 
-	lock_system_sleep();
+	sleep_flags = lock_system_sleep();
 
 	data = filp->private_data;
 
@@ -190,7 +194,7 @@ static ssize_t snapshot_write(struct fil
 	if (res > 0)
 		*offp += res;
 unlock:
-	unlock_system_sleep();
+	unlock_system_sleep(sleep_flags);
 
 	return res;
 }


