Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFB481A6C9A
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 21:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387957AbgDMTjV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387935AbgDMTjV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 15:39:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCACC0A3BE2
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 12:39:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d77so10388825wmd.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=V83imqQb2qNmDiJRPRI1BMuIzIfhNM48BRTbILOL2dM=;
        b=Vo0jqxojx9XvSPd/32dJjgoAQhWlsOGBsiRaPnKtNwJZAY/Feet/MB9n5TroXxfzMw
         yj3Zn+cTMnWO9SqdWstbFMvYGxUcReeaMBLkv2t3grfUW+i0od0c0ILEI36Gt7H0ibKZ
         gXPjipIQdQ53gkuAm6HkVaFywnNT+oK4my1Lg0t9XbNZIy/RRibFKOY1J3Dn/iIGfwku
         o0X5lGRdGDJmHiSwb1slxz7ZfkeHaDPGP1dFllXLsvE5tBHwjDrUvkpEI+4RTxDA0BL1
         ynjQq4BR3Egmc16cwR4umpaGcwGvtMLDjZicyUqYAIft+LUAyNyoHHODW0hI/SAH+cN8
         30Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=V83imqQb2qNmDiJRPRI1BMuIzIfhNM48BRTbILOL2dM=;
        b=MrqaAGrf4ueXFLnEBAnlpkwaUcoEX8Y9q523ey2+uJl18Vn4WXcz5++1iEOY9SF6zl
         q7irTyUVIN/Zz5aZ/kBWE83GjtLEBPcKlu3VMD63px9Ava8l4sxSzlhYAzQzQB0uUhY5
         fBlBkGh4CQwEKtqJyDlc4JPLskIVZvx4wGof50XjdgiZ6pRPAvlU0FIgxLjDVxmBsiaW
         +QPUL6CjhaTzvK01Dnwx0iaBFKYjjNPD3xOoRUxeTfg0Tp+nKNWWo2qJuBOnjMSY3B2v
         4GmNvl7l/ptPRD8zNKeA9fjUNdzA3Kh2QvCOWX5U4yqd6QlFnSVm9h11MydpjbS2+Q2O
         KmWg==
X-Gm-Message-State: AGi0Pubnl3b+nJ4fmx7nFKj6KW4+rcfqAhVBoDJL95hpKXsfHmW5ctA1
        ZOGo3uclivD7kNbCbMQSfrQ=
X-Google-Smtp-Source: APiQypKLjalHdDSgThiXPkn5ho6I+RBdA776uc/PM5fVAgJ+OT7HW/LzjMALGP1h7+EA15oC50hLZg==
X-Received: by 2002:a1c:3281:: with SMTP id y123mr19829887wmy.30.1586806758025;
        Mon, 13 Apr 2020 12:39:18 -0700 (PDT)
Received: from dumbo ([2a06:1700:1::7])
        by smtp.gmail.com with ESMTPSA id h2sm15035823wmb.16.2020.04.13.12.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:39:16 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jO4vK-0005xv-OU; Mon, 13 Apr 2020 21:39:14 +0200
Message-Id: <20200413193718.883336371@gmail.com>
User-Agent: quilt/0.65
Date:   Mon, 13 Apr 2020 21:08:44 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 1/2] uswsusp: use enter/leave helpers and make a global variable static
References: <20200413190843.044112674@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=add-swsusp-enter-leave
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Regulate access to the userspace software suspend state via helper
functions instead of a global variable.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>

---
 kernel/power/hibernate.c |    8 ++++----
 kernel/power/power.h     |    6 +++---
 kernel/power/user.c      |   20 +++++++++++++++-----
 3 files changed, 22 insertions(+), 12 deletions(-)

Index: b/kernel/power/user.c
===================================================================
--- a/kernel/power/user.c
+++ b/kernel/power/user.c
@@ -37,7 +37,17 @@ static struct snapshot_data {
 	bool free_bitmaps;
 } snapshot_state;
 
-atomic_t snapshot_device_available = ATOMIC_INIT(1);
+static atomic_t snapshot_device_available = ATOMIC_INIT(1);
+
+bool swsusp_try_enter(void)
+{
+	return atomic_add_unless(&snapshot_device_available, -1, 0);
+}
+
+void swsusp_leave(void)
+{
+	atomic_inc(&snapshot_device_available);
+}
 
 static int snapshot_open(struct inode *inode, struct file *filp)
 {
@@ -49,13 +59,13 @@ static int snapshot_open(struct inode *i
 
 	lock_system_sleep();
 
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!swsusp_try_enter()) {
 		error = -EBUSY;
 		goto Unlock;
 	}
 
 	if ((filp->f_flags & O_ACCMODE) == O_RDWR) {
-		atomic_inc(&snapshot_device_available);
+		swsusp_leave();
 		error = -ENOSYS;
 		goto Unlock;
 	}
@@ -92,7 +102,7 @@ static int snapshot_open(struct inode *i
 			__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	}
 	if (error)
-		atomic_inc(&snapshot_device_available);
+		swsusp_leave();
 
 	data->frozen = false;
 	data->ready = false;
@@ -122,7 +132,7 @@ static int snapshot_release(struct inode
 	}
 	pm_notifier_call_chain(data->mode == O_RDONLY ?
 			PM_POST_HIBERNATION : PM_POST_RESTORE);
-	atomic_inc(&snapshot_device_available);
+	swsusp_leave();
 
 	unlock_system_sleep();
 
Index: b/kernel/power/power.h
===================================================================
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -154,13 +154,13 @@ extern int snapshot_write_next(struct sn
 extern void snapshot_write_finalize(struct snapshot_handle *handle);
 extern int snapshot_image_loaded(struct snapshot_handle *handle);
 
-/* If unset, the snapshot device cannot be open. */
-extern atomic_t snapshot_device_available;
-
 extern sector_t alloc_swapdev_block(int swap);
 extern void free_all_swap_pages(int swap);
 extern int swsusp_swap_in_use(void);
 
+bool swsusp_try_enter(void);
+void swsusp_leave(void);
+
 /*
  * Flags that can be passed from the hibernatig hernel to the "boot" kernel in
  * the image header.
Index: b/kernel/power/hibernate.c
===================================================================
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -704,7 +704,7 @@ int hibernate(void)
 
 	lock_system_sleep();
 	/* The snapshot device should not be opened while we're running */
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!swsusp_try_enter()) {
 		error = -EBUSY;
 		goto Unlock;
 	}
@@ -775,7 +775,7 @@ int hibernate(void)
  Exit:
 	__pm_notifier_call_chain(PM_POST_HIBERNATION, nr_calls, NULL);
 	pm_restore_console();
-	atomic_inc(&snapshot_device_available);
+	swsusp_leave();
  Unlock:
 	unlock_system_sleep();
 	pr_info("hibernation exit\n");
@@ -880,7 +880,7 @@ static int software_resume(void)
 		goto Unlock;
 
 	/* The snapshot device should not be opened while we're running */
-	if (!atomic_add_unless(&snapshot_device_available, -1, 0)) {
+	if (!swsusp_try_enter()) {
 		error = -EBUSY;
 		swsusp_close(FMODE_READ);
 		goto Unlock;
@@ -904,7 +904,7 @@ static int software_resume(void)
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
 	pr_info("resume failed (%d)\n", error);
-	atomic_inc(&snapshot_device_available);
+	swsusp_leave();
 	/* For success case, the suspend path will release the lock */
  Unlock:
 	mutex_unlock(&system_transition_mutex);

