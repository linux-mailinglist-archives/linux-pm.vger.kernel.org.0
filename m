Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6567C1C196A
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729004AbgEAPZH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAPZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 11:25:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D873AC061A0C
        for <linux-pm@vger.kernel.org>; Fri,  1 May 2020 08:25:05 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so47059wmc.5
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2020 08:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=erJNQr0Rfhi8WM3USTM5ZowAbwumtVVITXyP8kHOOKc=;
        b=N4CaCQn3kBMztIEdTmfhkxKUlgDiAZA9wh2vKfcr4Dp8Qv/F4zXFxTA3gkxhcHa2GB
         4sz9KSZed8UL34bBU33bAX/ZDiLv1eVRMWvbRhPgog4IM3r1sn220OwwgGv5hEPESHwf
         VhfW2Fgnb5mfWkbHfESW+JoLvMrgn4BGMSv6A3CuDf6h3bdCg1k0XbXHZL8jWYpO6KAL
         FbOacfLMihJ95366rhunChTq+LbxPnnFRy8E/30uQmKf3EetfLxEV/KlHPpiSaF4PvW4
         EAjONSjyIrdzF7XP+URfi35UvUPpITlW2LWqs5AInniLd9wa07xjvypHNi+pRba/qfmm
         Rp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=erJNQr0Rfhi8WM3USTM5ZowAbwumtVVITXyP8kHOOKc=;
        b=Rk/+uitOKtzzXYKG7dbsouyjJk3+4yACICaxLP768V6qr11HU9daRJWB9ACBzz12V3
         HRPiv+nnpqkZThMDDcpuMM87a5OXcYTTotsHWmdjwfoY4alBHYKRzcWGV8OIsuJR+aLO
         zXj8VJ2xNbYKH+8WqgNr5O9GZ/bp+UQBsZ8hkVBOE9VmVH0vqXCIeAZG53bQT1aXryfB
         uAq8mSkS/+p+dQ0gbCyQMxHoSaCbEeW+Xzcueb3YI27C2ZKEK5PW6z4wFuyMixB7KRBt
         jVmL2w5orhi12BPKEaCgG3TrcICjlaL757DGftUO1Ux5QjNzxIoUZ7ClH2tGkPbifOK7
         2r8Q==
X-Gm-Message-State: AGi0PubC3u/MNJgBRoNAgkbPAloWKjoT5rO0yyhbJ7gs5oybgVqWYlJe
        hVeU6Le0LwEUdOFPWQjkJyo=
X-Google-Smtp-Source: APiQypKR/+jvB6rYqRXPhVgjh6RmqH/jH1O68TseqbScXphpjKUoX09hxrWtFXY9MxXd9d0b527OrA==
X-Received: by 2002:a1c:1dc3:: with SMTP id d186mr104354wmd.90.1588346684334;
        Fri, 01 May 2020 08:24:44 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2::1])
        by smtp.gmail.com with ESMTPSA id a7sm9559wmj.12.2020.05.01.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:24:42 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jUXWr-0006YL-0e; Fri, 01 May 2020 17:24:41 +0200
Message-Id: <20200501152304.523890160@gmail.com>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 17:14:53 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH v2 1/2] hibernate: incorporate concurrency handling
References: <20200501151452.621900831@gmail.com>
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
 
+static refcount_t hibernate_refcount = REFCOUNT_INIT(1);
+
+bool hibernate_acquire(void)
+{
+	return refcount_add_not_zero(-1, &hibernate_refcount);
+}
+
+void hibernate_release(void)
+{
+	refcount_inc(&hibernate_refcount);
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
@@ -904,7 +916,7 @@ static int software_resume(void)
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
 	pr_info("resume failed (%d)\n", error);
-	atomic_inc(&snapshot_device_available);
+	hibernate_release();
 	/* For success case, the suspend path will release the lock */
  Unlock:
 	mutex_unlock(&system_transition_mutex);

