Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2216CB7C4
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbfJDKAc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 06:00:32 -0400
Received: from mga14.intel.com ([192.55.52.115]:26012 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbfJDKA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 06:00:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 03:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="392246706"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2019 03:00:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 646BC14E; Fri,  4 Oct 2019 13:00:25 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Pavel Machek <pavel@ucw.cz>, Jan Kara <jack@suse.cz>,
        Tejun Heo <tj@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        AceLan Kao <acelan.kao@canonical.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] Revert "libata, freezer: avoid block device removal while system is frozen"
Date:   Fri,  4 Oct 2019 13:00:25 +0300
Message-Id: <20191004100025.70798-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
References: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This reverts commit 85fbd722ad0f5d64d1ad15888cd1eb2188bfb557.

The commit was added as a quick band-aid for a hang that happened when a
block device was removed during system suspend. Now that bdi_wq is not
freezable anymore the hang should not be possible and we can get rid of
this hack by reverting it.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/ata/libata-scsi.c | 21 ---------------------
 kernel/freezer.c          |  6 ------
 2 files changed, 27 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 76d0f9de767b..58e09ffe8b9c 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4791,27 +4791,6 @@ void ata_scsi_hotplug(struct work_struct *work)
 		return;
 	}
 
-	/*
-	 * XXX - UGLY HACK
-	 *
-	 * The block layer suspend/resume path is fundamentally broken due
-	 * to freezable kthreads and workqueue and may deadlock if a block
-	 * device gets removed while resume is in progress.  I don't know
-	 * what the solution is short of removing freezable kthreads and
-	 * workqueues altogether.
-	 *
-	 * The following is an ugly hack to avoid kicking off device
-	 * removal while freezer is active.  This is a joke but does avoid
-	 * this particular deadlock scenario.
-	 *
-	 * https://bugzilla.kernel.org/show_bug.cgi?id=62801
-	 * http://marc.info/?l=linux-kernel&m=138695698516487
-	 */
-#ifdef CONFIG_FREEZER
-	while (pm_freezing)
-		msleep(10);
-#endif
-
 	DPRINTK("ENTER\n");
 	mutex_lock(&ap->scsi_scan_mutex);
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index c0738424bb43..dc520f01f99d 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -22,12 +22,6 @@ EXPORT_SYMBOL(system_freezing_cnt);
 bool pm_freezing;
 bool pm_nosig_freezing;
 
-/*
- * Temporary export for the deadlock workaround in ata_scsi_hotplug().
- * Remove once the hack becomes unnecessary.
- */
-EXPORT_SYMBOL_GPL(pm_freezing);
-
 /* protects freezing and frozen transitions */
 static DEFINE_SPINLOCK(freezer_lock);
 
-- 
2.23.0

