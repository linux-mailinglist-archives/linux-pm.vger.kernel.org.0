Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09B012F1C5
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2020 00:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgABXTx (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 2 Jan 2020 18:19:53 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:35381 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgABXTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jan 2020 18:19:52 -0500
Received: by mail-pg1-f202.google.com with SMTP id f15so28420758pgk.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jan 2020 15:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kTofLcNmXcX3nYVPHEEBrADGlNaV6Az4fsaKemr0cv8=;
        b=GUTfDNdQ+oCknFDTvabIrNFpfQZAYHirer10woWB2aUoO6kjyfYNIREdzab/lXwm6k
         so5F1c6u//AZ3GjcEpqgwjO6VVm6fjZO9W7YzCnwE00eBIms7XbYDhR7D2aPs5AbmdR5
         Uupr02p9VF/ElOZzkbi72kJshM9Sgp/ZvhPBBOEXoa+cAOxlyIH6j+gu33cLCm2CLVZQ
         hjpNqo11WktRMkIoCn0IJn6KnapLKioDB54J4PApCeypjfSDClRTrP02m9l9rkZLOI5T
         0JG0O3sK97TFGhT39qK1ShqvqOAK3E1RfFeghAzn071we8LseTPB0WM6O05JQ0hMheX1
         x+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kTofLcNmXcX3nYVPHEEBrADGlNaV6Az4fsaKemr0cv8=;
        b=g7S6YJnEcMwHTChBRrNsswbFQhsjQ5OggzJ4a/buk5LGw08wj82e1KipD0f0VXl8Pv
         PH8hsihSLSFQ51MIz4JS0nEU1IVg8pVF4DQgJRYLCrrP8D5Ig0EU8nJb1D3Czd/sl3gS
         3SmZabEewptv/jWSFFmNDkVWXf5xdCfd1N50q+KdYvk89FictA7WmBMIcnRPO2cB7qIZ
         BtzOH+nSzF6+3xVaXesnMgT6/NPBXm5Kd1/KSPEbl7V+NHnyXS6YG30vQa8LJaUkhFyl
         lThpuay9UkzYfX+QoH8Fqw/R8qJpj1vxtzRYI2FvdIHGwhcwUmpDkx5C9A//eaqODlQd
         QnFQ==
X-Gm-Message-State: APjAAAXyABzXSVgo223sEb7FDhe07Q9D/sCmmcRACFaK5Ac+E3ZMtQTC
        KcPDxpnznq3ezLbioKH7F4lJst8t3dnJHSXH7B4TX4SyY+sP2XpT29ZPxIJOFNezb1CLDgLqI/t
        bjFZ+b0VcMHmsv7/ma3iCkZmCFLPOydWJz7/4+VTJn9S7oSAWczA5/3xgAcpgTwmyj7v/V0/+
X-Google-Smtp-Source: APXvYqxhfHSfZX6SXpAHoOeozy067OcCUgnvrrW6l8o78djIVgFWfqq6pdpULRmFUn7Gbm8dKS5y0nmpGImCjJw=
X-Received: by 2002:a63:454a:: with SMTP id u10mr93722469pgk.248.1578007191655;
 Thu, 02 Jan 2020 15:19:51 -0800 (PST)
Date:   Thu,  2 Jan 2020 15:19:40 -0800
In-Reply-To: <20200102231940.202896-1-semenzato@google.com>
Message-Id: <20200102231940.202896-3-semenzato@google.com>
Mime-Version: 1.0
References: <20200102231940.202896-1-semenzato@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 2/2] pm: add more logging on hibernation failure
From:   Luigi Semenzato <semenzato@google.com>
To:     linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, rafael@kernel.org, gpike@google.com,
        elliott@hpe.com, Luigi Semenzato <semenzato@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hibernation fails when the kernel cannot allocate enough memory
to copy all pages in use.  This patch ensures that the failure
reason is clearly logged, and clearly attributable to the
hibernation module.

Signed-off-by: Luigi Semenzato <semenzato@google.com>
---
 kernel/power/hibernate.c | 23 ++++++++++++-----------
 kernel/power/snapshot.c  | 24 +++++++++++++++---------
 2 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 3c0a5a8170b0..6dbeedb7354c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -9,7 +9,7 @@
  * Copyright (C) 2012 Bojan Smojver <bojan@rexursive.com>
  */
 
-#define pr_fmt(fmt) "PM: " fmt
+#define pr_fmt(fmt) "PM: hibernation: " fmt
 
 #include <linux/export.h>
 #include <linux/suspend.h>
@@ -106,7 +106,7 @@ EXPORT_SYMBOL(system_entering_hibernation);
 #ifdef CONFIG_PM_DEBUG
 static void hibernation_debug_sleep(void)
 {
-	pr_info("hibernation debug: Waiting for 5 seconds.\n");
+	pr_info("debug: Waiting for 5 seconds.\n");
 	mdelay(5000);
 }
 
@@ -277,7 +277,7 @@ static int create_image(int platform_mode)
 
 	error = dpm_suspend_end(PMSG_FREEZE);
 	if (error) {
-		pr_err("Some devices failed to power down, aborting hibernation\n");
+		pr_err("Some devices failed to power down, aborting\n");
 		return error;
 	}
 
@@ -295,7 +295,7 @@ static int create_image(int platform_mode)
 
 	error = syscore_suspend();
 	if (error) {
-		pr_err("Some system devices failed to power down, aborting hibernation\n");
+		pr_err("Some system devices failed to power down, aborting\n");
 		goto Enable_irqs;
 	}
 
@@ -310,7 +310,7 @@ static int create_image(int platform_mode)
 	restore_processor_state();
 	trace_suspend_resume(TPS("machine_suspend"), PM_EVENT_HIBERNATE, false);
 	if (error)
-		pr_err("Error %d creating hibernation image\n", error);
+		pr_err("Error %d creating image\n", error);
 
 	if (!in_suspend) {
 		events_check_enabled = false;
@@ -680,7 +680,7 @@ static int load_image_and_restore(void)
 	if (!error)
 		hibernation_restore(flags & SF_PLATFORM_MODE);
 
-	pr_err("Failed to load hibernation image, recovering.\n");
+	pr_err("Failed to load image, recovering.\n");
 	swsusp_free();
 	free_basic_memory_bitmaps();
  Unlock:
@@ -743,7 +743,7 @@ int hibernate(void)
 		else
 		        flags |= SF_CRC32_MODE;
 
-		pm_pr_dbg("Writing image.\n");
+		pm_pr_dbg("Writing hibernation image.\n");
 		error = swsusp_write(flags);
 		swsusp_free();
 		if (!error) {
@@ -755,7 +755,7 @@ int hibernate(void)
 		in_suspend = 0;
 		pm_restore_gfp_mask();
 	} else {
-		pm_pr_dbg("Image restored successfully.\n");
+		pm_pr_dbg("Hibernation image restored successfully.\n");
 	}
 
  Free_bitmaps:
@@ -894,7 +894,7 @@ static int software_resume(void)
 		goto Close_Finish;
 	}
 
-	pm_pr_dbg("Preparing processes for restore.\n");
+	pm_pr_dbg("Preparing processes for hibernation restore.\n");
 	error = freeze_processes();
 	if (error)
 		goto Close_Finish;
@@ -903,7 +903,7 @@ static int software_resume(void)
  Finish:
 	__pm_notifier_call_chain(PM_POST_RESTORE, nr_calls, NULL);
 	pm_restore_console();
-	pr_info("resume from hibernation failed (%d)\n", error);
+	pr_info("resume failed (%d)\n", error);
 	atomic_inc(&snapshot_device_available);
 	/* For success case, the suspend path will release the lock */
  Unlock:
@@ -1068,7 +1068,8 @@ static ssize_t resume_store(struct kobject *kobj, struct kobj_attribute *attr,
 	lock_system_sleep();
 	swsusp_resume_device = res;
 	unlock_system_sleep();
-	pm_pr_dbg("Configured resume from disk to %u\n", swsusp_resume_device);
+	pm_pr_dbg("Configured hibernation resume from disk to %u\n",
+		  swsusp_resume_device);
 	noresume = 0;
 	software_resume();
 	return n;
diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 26b9168321e7..dcd1376e8fdf 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -8,7 +8,7 @@
  * Copyright (C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
  */
 
-#define pr_fmt(fmt) "PM: " fmt
+#define pr_fmt(fmt) "PM: hibernation: " fmt
 
 #include <linux/version.h>
 #include <linux/module.h>
@@ -1705,16 +1705,20 @@ int hibernate_preallocate_memory(void)
 	ktime_t start, stop;
 	int error;
 
-	pr_info("Preallocating image memory... ");
+	pr_info("Preallocating image memory\n");
 	start = ktime_get();
 
 	error = memory_bm_create(&orig_bm, GFP_IMAGE, PG_ANY);
-	if (error)
+	if (error) {
+		pr_err("Cannot allocate original bitmap\n");
 		goto err_out;
+	}
 
 	error = memory_bm_create(&copy_bm, GFP_IMAGE, PG_ANY);
-	if (error)
+	if (error) {
+		pr_err("Cannot allocate copy bitmap\n");
 		goto err_out;
+	}
 
 	alloc_normal = 0;
 	alloc_highmem = 0;
@@ -1804,8 +1808,11 @@ int hibernate_preallocate_memory(void)
 		alloc -= pages;
 		pages += pages_highmem;
 		pages_highmem = preallocate_image_highmem(alloc);
-		if (pages_highmem < alloc)
+		if (pages_highmem < alloc) {
+			pr_err("Image allocation is %lu pages short\n",
+				alloc - pages_highmem);
 			goto err_out;
+		}
 		pages += pages_highmem;
 		/*
 		 * size is the desired number of saveable pages to leave in
@@ -1836,13 +1843,12 @@ int hibernate_preallocate_memory(void)
 
  out:
 	stop = ktime_get();
-	pr_cont("done (allocated %lu pages)\n", pages);
+	pr_info("Allocated %lu pages for shapshot\n", pages);
 	swsusp_show_speed(start, stop, pages, "Allocated");
 
 	return 0;
 
  err_out:
-	pr_cont("\n");
 	swsusp_free();
 	return -ENOMEM;
 }
@@ -1976,7 +1982,7 @@ asmlinkage __visible int swsusp_save(void)
 {
 	unsigned int nr_pages, nr_highmem;
 
-	pr_info("Creating hibernation image:\n");
+	pr_info("Creating image:\n");
 
 	drain_local_pages(NULL);
 	nr_pages = count_data_pages();
@@ -2010,7 +2016,7 @@ asmlinkage __visible int swsusp_save(void)
 	nr_copy_pages = nr_pages;
 	nr_meta_pages = DIV_ROUND_UP(nr_pages * sizeof(long), PAGE_SIZE);
 
-	pr_info("Hibernation image created (%d pages copied)\n", nr_pages);
+	pr_info("Image created (%d pages copied)\n", nr_pages);
 
 	return 0;
 }
-- 
2.24.1.735.g03f4e72817-goog

