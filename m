Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3667E1EA785
	for <lists+linux-pm@lfdr.de>; Mon,  1 Jun 2020 18:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgFAQGw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Jun 2020 12:06:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55328 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQGv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Jun 2020 12:06:51 -0400
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <andrea.righi@canonical.com>)
        id 1jfmxc-0006t7-Dd
        for linux-pm@vger.kernel.org; Mon, 01 Jun 2020 16:06:48 +0000
Received: by mail-wr1-f71.google.com with SMTP id n6so184342wrv.6
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2020 09:06:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rb4DorW2DTSvKQhxTeczpFcq7NmU3NcOTRxb6hpieGg=;
        b=PdlO9MestJprql1dhURox8Ienyro1O3yE28vyYRCMAAbtB66NtG3k9RIbiyPlvu6zM
         MS8CuweMopYmDKCdpzkdtHac1wkk2uviFclbHVmqEpkAmt6qS5w8t2s7pmmE/oCNvtn4
         NZAHBez/HI9DCro1e1SqMoxh0FYM2IhSujYVwW525OFPAJId9Yfzq1hRRxgJer7O3A+w
         RXEZk4PjIEtLeUOCSAMRHyfDyKdE6C68PGFNqo++wM06Y61ovim99EYlKNJrfqz5+gAE
         WDFWgmfekGCq8UWvRqsbxGxeZb4ev5bCgcmktP+CabeUXtiqD5ZNBs/03Msu3+sBabBW
         M5Aw==
X-Gm-Message-State: AOAM532AjAxJHwZGpNnQ965B/FdwpTI/P9aEjoMLp3ylUx3dmPvHgVAn
        jHD3z4C29tR0OCojuUipMSfED+OLD5zOIBCvA6mTHIl/rCBX6T86jCs3FYyLQ86dl8HAMiKtu74
        QgFq91zeZXrJRJgGPdQNJobOPfac9dXW6qMPp
X-Received: by 2002:adf:f847:: with SMTP id d7mr1098532wrq.261.1591027607713;
        Mon, 01 Jun 2020 09:06:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLTpp25Ny6dKQjmgdteuceFco5fZeCOLru4FBdl5AKKV0A8ZkU98XKhIVVEEGzpE9X9OIl8A==
X-Received: by 2002:adf:f847:: with SMTP id d7mr1098511wrq.261.1591027607358;
        Mon, 01 Jun 2020 09:06:47 -0700 (PDT)
Received: from xps-13.homenet.telecomitalia.it (host105-135-dynamic.43-79-r.retail.telecomitalia.it. [79.43.135.105])
        by smtp.gmail.com with ESMTPSA id k16sm19719262wrp.66.2020.06.01.09.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:06:46 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Len Brown <len.brown@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-pm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] PM: hibernate: introduce opportunistic memory reclaim
Date:   Mon,  1 Jun 2020 18:06:36 +0200
Message-Id: <20200601160636.148346-3-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200601160636.148346-1-andrea.righi@canonical.com>
References: <20200601160636.148346-1-andrea.righi@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

== Overview ==

When a system is going to be hibernated, the kernel needs to allocate
and dump the content of the entire memory to the resume device (swap) by
creating a "hibernation image".

To make sure this image fits in the available free memory, the kernel
can induce an artificial memory pressure condition that allows to free
up some pages (i.e., drop clean page cache pages, writeback dirty page
cache pages, swap out anonymous memory, etc.).

How much the kernel is pushing to free up memory is determined by
/sys/power/image_size: a smaller size will cause more memory to be
dropped, cutting down the amount of I/O required to write the
hibernation image; a larger image size, instead, is going to generate
more I/O, but the system will likely be less sluggish at resume, because
more caches will be restored, reducing the paging time.

The I/O generated to free up memory, write the hibernation image to disk
and load it back to memory is the main bottleneck of hibernation [1].

== Proposed solution ==

The "opportunistic memory reclaim" aims to provide an interface to the
user-space to control the artificial memory pressure. With this feature
user-space can trigger the memory reclaim before the actual hibernation
is started (e.g., if the system is idle for a certain amount of time).

This allows to consistently speed up hibernation performance when needed
(in terms of time to hibernate) by reducing the size of the hibernation
image in advance.

== Interface ==

The accomplish this goal the following new files are provided in sysfs:

 - /sys/power/mm_reclaim/run
 - /sys/power/mm_reclaim/release

The former can be used to start the memory reclaim by writing a number
representing the desired amount of pages to be reclaimed (with "0" the
kernel will try to reclaim as many pages as possible).

The latter can be used in the same way to force the kernel to pull a
certain amount of swapped out pages back to memory (by writing the
number of pages or "0" to load back to memory as many pages as
possible); this can be useful immediately after resume to speed up the
paging time and get the system back to full speed faster.

Memory reclaim and release can be interrupted sending a signal to the
process that is writing to /sys/power/mm_reclaim/{run,release} (i.e.,
to set a timeout for the particular operation).

== Testing ==

Environment:
   - VM (kvm):
     8GB of RAM
     disk speed: 100 MB/s
     8GB swap file on ext4 (/swapfile)

Use case:
  - allocate 85% of memory, wait for 60s almost in idle, then hibernate
    and resume (measuring the time)

Result (average of 10 runs):
                                 5.7-vanilla   5.7-mm_reclaim
                                 -----------   --------------
  [hibernate] image_size=default      51.56s            4.19s
     [resume] image_size=default      26.34s            5.01s
  [hibernate] image_size=0            73.22s            5.36s
     [resume] image_size=0             5.32s            5.26s

NOTE #1: in the 5.7-mm_reclaim case a user-space daemon detects when the
system is idle and triggers the opportunistic memory reclaim via
/sys/power/mm_reclaim/run.

NOTE #2: in the 5.7-mm_reclaim case, after the system is resumed, a
user-space process can (optionally) use /sys/power/mm_reclaim/release to
pre-load back to memory all (or some) of the swapped out pages in order
to have a more responsive system.

== Conclusion ==

Opportunistic memory reclaim can provide a significant benefit to those
systems where being able to hibernate quickly is important.

The typical use case is with "spot" cloud instances: low-priority
instances that can be stopped at any time (prior advice) to prioritize
other more privileged instances [2].

Being able to quickly stop low-priority instances that are mostly idle
for the majority of time can be critical to provide a better quality of
service in the overall cloud infrastructure.

== See also ==

[1] https://lwn.net/Articles/821158/
[2] https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/spot-interruptions.html

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 Documentation/ABI/testing/sysfs-power | 38 +++++++++++
 include/linux/swapfile.h              |  1 +
 kernel/power/hibernate.c              | 94 ++++++++++++++++++++++++++-
 mm/swapfile.c                         | 30 +++++++++
 4 files changed, 162 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index 5e6ead29124c..b33db9816a8c 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -192,6 +192,44 @@ Description:
 		Reading from this file will display the current value, which is
 		set to 1 MB by default.
 
+What:		/sys/power/mm_reclaim/
+Date:		May 2020
+Contact:	Andrea Righi <andrea.righi@canonical.com>
+Description:
+		The /sys/power/mm_reclaim directory contains all the
+		opportunistic memory reclaim files.
+
+What:		/sys/power/mm_reclaim/run
+Date:		May 2020
+Contact:	Andrea Righi <andrea.righi@canonical.com>
+Description:
+		The /sys/power/mm_reclaim/run file allows user space to trigger
+		opportunistic memory reclaim. When a string representing a
+		non-negative number is written to this file, it will be assumed
+		to represent the amount of pages to be reclaimed (0 is a special
+		value that means "as many pages as possible").
+
+		When opportunistic memory reclaim is started the system will be
+		put into an artificial memory pressure condition and memory
+		will be reclaimed by dropping clean page cache pages, swapping
+		out anonymous pages, etc.
+
+		NOTE: it is possible to interrupt the memory reclaim sending a
+		signal to writer of this file.
+
+What:		/sys/power/mm_reclaim/release
+Date:		May 2020
+Contact:	Andrea Righi <andrea.righi@canonical.com>
+Description:
+		Force swapped out pages to be loaded back to memory. When a
+		string representing a non-negative number is written to this
+		file, it will be assumed to represent the amount of pages to be
+		pulled back to memory from the swap device(s) (0 is a special
+		value that means "as many pages as possible").
+
+		NOTE: it is possible to interrupt the memory release sending a
+		signal to writer of this file.
+
 What:		/sys/power/autosleep
 Date:		April 2012
 Contact:	Rafael J. Wysocki <rjw@rjwysocki.net>
diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index ac4d0ccd1f7b..6f4144099958 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -9,6 +9,7 @@
 extern spinlock_t swap_lock;
 extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
+extern void swap_unuse(unsigned long pages);
 extern int try_to_unuse_wait(unsigned int type, bool frontswap, bool wait,
 			     unsigned long pages_to_unuse);
 static inline int
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 30bd28d1d418..caa06eb5a09f 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -31,6 +31,7 @@
 #include <linux/genhd.h>
 #include <linux/ktime.h>
 #include <linux/security.h>
+#include <linux/swapfile.h>
 #include <trace/events/power.h>
 
 #include "power.h"
@@ -1150,6 +1151,92 @@ static ssize_t reserved_size_store(struct kobject *kobj,
 
 power_attr(reserved_size);
 
+/*
+ * Try to reclaim some memory in the system, stop when one of the following
+ * conditions occurs:
+ *  - at least "nr_pages" have been reclaimed
+ *  - no more pages can be reclaimed
+ *  - current task explicitly interrupted by a signal (e.g., user space
+ *    timeout)
+ *
+ *  @nr_pages - amount of pages to be reclaimed (0 means "as many pages as
+ *  possible").
+ */
+static void do_mm_reclaim(unsigned long nr_pages)
+{
+	while (nr_pages > 0) {
+		unsigned long reclaimed;
+
+		if (signal_pending(current))
+			break;
+		reclaimed = shrink_all_memory(nr_pages);
+		if (!reclaimed)
+			break;
+		nr_pages -= min_t(unsigned long, reclaimed, nr_pages);
+	}
+}
+
+static ssize_t run_show(struct kobject *kobj,
+			struct kobj_attribute *attr, char *buf)
+{
+	return -EINVAL;
+}
+
+static ssize_t run_store(struct kobject *kobj,
+			 struct kobj_attribute *attr,
+			 const char *buf, size_t n)
+{
+	unsigned long nr_pages;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &nr_pages);
+	if (ret)
+		return ret;
+	if (!nr_pages)
+		nr_pages = ULONG_MAX;
+	do_mm_reclaim(nr_pages);
+
+	return n;
+}
+
+power_attr(run);
+
+static ssize_t release_show(struct kobject *kobj,
+			    struct kobj_attribute *attr, char *buf)
+{
+	return -EINVAL;
+}
+
+static ssize_t release_store(struct kobject *kobj,
+			     struct kobj_attribute *attr,
+			     const char *buf, size_t n)
+{
+	unsigned long nr_pages;
+	int ret;
+
+	ret = kstrtoul(buf, 0, &nr_pages);
+	if (ret)
+		return ret;
+	if (!nr_pages)
+		nr_pages = ULONG_MAX;
+	swap_unuse(nr_pages);
+
+	return n;
+}
+
+power_attr(release);
+
+static struct attribute *mm_reclaim_attrs[] = {
+	&run_attr.attr,
+	&release_attr.attr,
+	NULL,
+};
+
+static struct attribute_group mm_reclaim_attr_group = {
+	.name = "mm_reclaim",
+	.attrs = mm_reclaim_attrs,
+};
+
 static struct attribute * g[] = {
 	&disk_attr.attr,
 	&resume_offset_attr.attr,
@@ -1164,10 +1251,15 @@ static const struct attribute_group attr_group = {
 	.attrs = g,
 };
 
+static const struct attribute_group *attr_groups[] = {
+	&attr_group,
+	&mm_reclaim_attr_group,
+	NULL,
+};
 
 static int __init pm_disk_init(void)
 {
-	return sysfs_create_group(power_kobj, &attr_group);
+	return sysfs_create_groups(power_kobj, attr_groups);
 }
 
 core_initcall(pm_disk_init);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 651471ccf133..7391f122ad73 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1749,6 +1749,36 @@ int free_swap_and_cache(swp_entry_t entry)
 }
 
 #ifdef CONFIG_HIBERNATION
+/*
+ * Force pages to be pulled back to memory from all swap devices.
+ *
+ * @nr_pages - number of pages to be pulled from all swap devices
+ * (0 = all pages from any swap device).
+ */
+void swap_unuse(unsigned long pages)
+{
+	int type;
+
+	spin_lock(&swap_lock);
+	for (type = 0; type < nr_swapfiles; type++) {
+		struct swap_info_struct *sis = swap_info[type];
+		struct block_device *bdev;
+
+		if (!(sis->flags & SWP_WRITEOK))
+			continue;
+		bdev = bdgrab(sis->bdev);
+		if (!bdev)
+			continue;
+		spin_unlock(&swap_lock);
+
+		try_to_unuse_wait(type, false, false, pages);
+
+		bdput(sis->bdev);
+		spin_lock(&swap_lock);
+	}
+	spin_unlock(&swap_lock);
+}
+
 /*
  * Find the swap type that corresponds to given device (if any).
  *
-- 
2.25.1

