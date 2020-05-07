Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4E371C8364
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 09:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbgEGHYr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 03:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgEGHYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 03:24:46 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CFEC061A10
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 00:24:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id v8so6758283wma.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=t1ecVGFN3/YrJ8ElNz0UA7KAgI74/IWaIsFODU8Xoqg=;
        b=jI/ouC4AyTBkQkp2HUzFz/q+l1JZeq7Qmgp9pkd9fROsDvBv3KgDUZtzuv2vymHXs8
         d/ckNg3hv0H4GyQyTfrcexQRCFHFXkb45dckjfJXktJah7dwdMvwgbPziMXlXTVeBwJU
         C7d9LuqrGV5fR2vINrmE9Y+N0O3P0yG6ZXLdn7hV4Nz6nW/Unn8ZQkBc1CVfwFG97MmB
         m3gi4Z/U8vgYLSpHmZw0g4hy4vgnF8KpBRt0Ea1+QY9zd/7/3FOXYf+G4Jh8FeIjP/JR
         sb+ZI30RsKhQZsc+s/CyXgGs5buploJhTHRDJ/0iezyK1VLV+C1hp1s4pCjpUhCoGKZr
         qGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=t1ecVGFN3/YrJ8ElNz0UA7KAgI74/IWaIsFODU8Xoqg=;
        b=JxgYJo1aU7Nk2k12Pp6HWpyfV/S1djTrKelV7X1FZyadnkzjPSbRcpCjc/Kmgab3b6
         CTSRZrUhdRbm8Fky/aQRoMITiSIh4C5cHJ0aI53TptrDTU0vxW72wWMzqNI3Y2VH/+HI
         HQ15Xh2NPjyTrkzhE/+CJRtqIDcOQZiQb3MpstNJbCrToXDkXdM07xwr4RFVvzXM2PZw
         lmAsULj2rF5Sg0LvHh1f3aLADu1SH+Ick+3oFUMsSA2IFbSworSGIpWs9jhKFN1BKBj6
         DSMlYZtda9GhLBbkcg0jAx00NlNKqyYYuVe6vohmUq65lcpN48rpowjGuNLRXMko1rqN
         at+w==
X-Gm-Message-State: AGi0Pua5iGqb/IDi+5myiwFTi7IisRsV/zx0hVfjMonL+SeKgav0QJuo
        HBv8UQmONwoN/dc3C+MV6Ng=
X-Google-Smtp-Source: APiQypKxSXvHiNcZjpcqK1isK8iNlbQo6JQFFcAyE9MKNxtiSvwXH0XFnlof7uHp0O40i2w/g6jooQ==
X-Received: by 2002:a1c:4d07:: with SMTP id o7mr9412620wmh.59.1588836283680;
        Thu, 07 May 2020 00:24:43 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2::1])
        by smtp.gmail.com with ESMTPSA id l16sm6392318wrp.91.2020.05.07.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:24:41 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jWatc-0003zv-3g; Thu, 07 May 2020 09:24:40 +0200
Message-Id: <20200507072357.566380665@linux.com>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 09:19:52 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 1/2] hibernate: incorporate concurrency handling
References: <20200507071951.635743820@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=hibernate-incorporate-concurrency-handling
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Hibernation concurrency handling is currently delegated to user.c,
where it's also used for regulating the access to the snapshot device.

In the prospective of making user.c a separate configuration option,
such mutual exclusion is brought into hibernate.c and made available
through accessor helpers hereby introduced.

v3:
 - switch back to atomic_t API, refcount saturates when incrementing
   from zero
v2:
 - move the mutual exclusion to hibernate.c (it was in user.c)
 - switched to refcount_t API (it was atomic_t)

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>

---
 kernel/power/hibernate.c |   20 ++++++++++++++++----
 kernel/power/power.h     |    4 ++--
 kernel/power/user.c      |   10 ++++------
 3 files changed, 22 insertions(+), 12 deletions(-)

Index: b/kernel/power/user.c
===================================================================
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -37,8 +37,6 @@ static struct snapshot_data {
 	bool free_bitmaps;
 } snapshot_state;
 
-atomic_t snapshot_device_available = ATOMIC_INIT(1);
-
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
 	struct snapshot_data *data;
@@ -49,13 +47,13 @@ static int snapshot_open(struct inode *i
 
 	lock_system_sleep();
 
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!hibernate_acquire()) {
 		error = -EBUSY;
 		goto Unlock;
 	}
 
 	if ((filp->f_flags & O_ACCMODE) == O_RDWR) {
-		atomic_inc(&snapshot_device_available);
+		hibernate_release();
 		error = -ENOSYS;
 		goto Unlock;
 	}
@@ -92,7 +90,7 @@ static int snapshot_open(struct inode *i
 			__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	}
 	if (error)
-		atomic_inc(&snapshot_device_available);
+		hibernate_release();
 
 	data->frozen = false;
 	data->ready = false;
@@ -122,7 +120,7 @@ static int snapshot_release(struct inode
 	}
 	pm_notifier_call_chain(data->mode == O_RDONLY ?
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
-	atomic_inc(&snapshot_device_available);
+	hibernate_release();
 
 	unlock_system_sleep();
 
Index: b/kernel/power/power.h
===================================================================
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -154,8 +154,8 @@ extern int snapshot_write_next(struct sn
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
-/* If unset, the snapshot device cannot be open. */
-extern atomic_t snapshot_device_available;
+extern bool hibernate_acquire(void);
+extern void hibernate_release(void);
 
 extern sector_t alloc_swapdev_block(int swap);
 extern void free_all_swap_pages(int swap);
Index: b/kernel/power/hibernate.c
===================================================================
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -67,6 +67,18 @@ bool freezer_test_done;
 
 static const struct platform_hibernation_ops *hibernation_ops;
 
+static atomic_t hibernate_atomic = ATOMIC_INIT(1);
+
+bool hibernate_acquire(void)
+{
+	return atomic_add_unless(&hibernate_atomic, -1, 0);
+}
+
+void hibernate_release(void)
+{
+	atomic_inc(&hibernate_atomic);
+}
+
 bool hibernation_available(void)
 {
 	return nohibernate == 0 && !security_locked_down(LOCKDOWN_HIBERNATION);
@@ -704,7 +716,7 @@ int hibernate(void)
 
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!hibernate_acquire()) {
 		error = -EBUSY;
 		goto Unlock;
 	}
@@ -775,7 +787,7 @@ int hibernate(void)
  Exit:
 	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
 	pm_restore_console();
-	atomic_inc(&snapshot_device_available);
+	hibernate_release();
  Unlock:
 	unlock_system_sleep();
 	pr_info("hibernation exit\n");
@@ -880,7 +892,7 @@ static int software_resume(void)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!hibernate_acquire()) {
 		error = -EBUSY;
 		swsusp_close(FMODE_READ);
 		goto Unlock;
@@ -911,7 +923,7 @@ static int software_resume(void)
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
 	pr_info("resume failed (%d)\n", error);
-	atomic_inc(&snapshot_device_available);
+	hibernate_release();
 	/* For success case, the suspend path will release the lock */
  Unlock:
 	mutex_unlock(&system_transition_mutex);

