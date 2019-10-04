Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82B22CB7C2
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2019 12:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbfJDKA3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 4 Oct 2019 06:00:29 -0400
Received: from mga14.intel.com ([192.55.52.115]:26012 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726393AbfJDKA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 4 Oct 2019 06:00:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Oct 2019 03:00:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,256,1566889200"; 
   d="scan'208";a="392246707"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 04 Oct 2019 03:00:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 55401159; Fri,  4 Oct 2019 13:00:25 +0300 (EEST)
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
Subject: [PATCH 1/2] bdi: Do not use freezable workqueue
Date:   Fri,  4 Oct 2019 13:00:24 +0300
Message-Id: <20191004100025.70798-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

A removable block device, such as NVMe or SSD connected over Thunderbolt
can be hot-removed any time including when the system is suspended. When
device is hot-removed during suspend and the system gets resumed, kernel
first resumes devices and then thaws the userspace including freezable
workqueues. What happens in that case is that the NVMe driver notices
that the device is unplugged and removes it from the system. This ends
up calling bdi_unregister() for the gendisk which then schedules
wb_workfn() to be run one more time.

However, since the bdi_wq is still frozen flush_delayed_work() call in
wb_shutdown() blocks forever halting system resume process. User sees
this as hang as nothing is happening anymore.

Triggering sysrq-w reveals this:

  Workqueue: nvme-wq nvme_remove_dead_ctrl_work [nvme]
  Call Trace:
   ? __schedule+0x2c5/0x630
   ? wait_for_completion+0xa4/0x120
   schedule+0x3e/0xc0
   schedule_timeout+0x1c9/0x320
   ? resched_curr+0x1f/0xd0
   ? wait_for_completion+0xa4/0x120
   wait_for_completion+0xc3/0x120
   ? wake_up_q+0x60/0x60
   __flush_work+0x131/0x1e0
   ? flush_workqueue_prep_pwqs+0x130/0x130
   bdi_unregister+0xb9/0x130
   del_gendisk+0x2d2/0x2e0
   nvme_ns_remove+0xed/0x110 [nvme_core]
   nvme_remove_namespaces+0x96/0xd0 [nvme_core]
   nvme_remove+0x5b/0x160 [nvme]
   pci_device_remove+0x36/0x90
   device_release_driver_internal+0xdf/0x1c0
   nvme_remove_dead_ctrl_work+0x14/0x30 [nvme]
   process_one_work+0x1c2/0x3f0
   worker_thread+0x48/0x3e0
   kthread+0x100/0x140
   ? current_work+0x30/0x30
   ? kthread_park+0x80/0x80
   ret_from_fork+0x35/0x40

This is not limited to NVMes so exactly same issue can be reproduced by
hot-removing SSD (over Thunderbolt) while the system is suspended.

Prevent this from happening by removing WQ_FREEZABLE from bdi_wq.

Reported-by: AceLan Kao <acelan.kao@canonical.com>
Link: https://marc.info/?l=linux-kernel&m=138695698516487
Link: https://bugzilla.kernel.org/show_bug.cgi?id=204385
Link: https://lore.kernel.org/lkml/20191002122136.GD2819@lahna.fi.intel.com/#t
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
I'm not too familiar with the bdi and block layer so it may be there is a
good reason having freezabe bdi_wq and we need to re-think how this could
be solved.

This problem is easy to reproduce with Thunderbolt capable systems by doing
following steps:

  1. Connect NVMe or SSD over Thunderbolt
  2. Suspend the system (mem, s2idle)
  3. Detach the NVMe or SSD
  4. Resume system

 mm/backing-dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index d9daa3e422d0..c360f6a6c844 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -239,8 +239,8 @@ static int __init default_bdi_init(void)
 {
 	int err;
 
-	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_FREEZABLE |
-					      WQ_UNBOUND | WQ_SYSFS, 0);
+	bdi_wq = alloc_workqueue("writeback", WQ_MEM_RECLAIM | WQ_UNBOUND |
+				 WQ_SYSFS, 0);
 	if (!bdi_wq)
 		return -ENOMEM;
 
-- 
2.23.0

