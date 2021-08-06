Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0DA3E2B1B
	for <lists+linux-pm@lfdr.de>; Fri,  6 Aug 2021 15:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343898AbhHFNEd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Aug 2021 09:04:33 -0400
Received: from mga11.intel.com ([192.55.52.93]:11073 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343883AbhHFNEb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Aug 2021 09:04:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10067"; a="211261951"
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="211261951"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2021 06:04:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,300,1620716400"; 
   d="scan'208";a="504017952"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 06 Aug 2021 06:04:09 -0700
Subject: [PATCH V5] scsi: ufshcd: Fix device links when BOOT WLUN fails to
 probe
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
 <20210716114408.17320-3-adrian.hunter@intel.com>
 <c78aac34-5c55-f6b6-3450-d5c3f09781fa@intel.com>
 <35b2bd0f-5766-debd-2b4c-c642a85df367@acm.org>
 <yq1czqrguch.fsf@ca-mkp.ca.oracle.com>
 <739a1abf-fca0-458e-5c8c-1d6ed90b56e0@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <a1c9bac8-b560-b662-f0aa-58c7e000cbbd@intel.com>
Date:   Fri, 6 Aug 2021 16:04:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <739a1abf-fca0-458e-5c8c-1d6ed90b56e0@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Managed device links are deleted by device_del(). However it is possible to
add a device link to a consumer before device_add(), and then discovering
an error prevents the device from being used. In that case normally
references to the device would be dropped and the device would be deleted.
However the device link holds a reference to the device, so the device link
and device remain indefinitely (unless the supplier is deleted).

For UFSHCD, if a LUN fails to probe (e.g. absent BOOT WLUN), the device
will not have been registered but can still have a device link holding a
reference to the device. The unwanted device link will prevent runtime
suspend indefinitely.

Amend device link removal to accept removal of a link with an unregistered
consumer device (suggested by Rafael), and fix UFSHCD by explicitly
deleting the device link when SCSI destroys the SCSI device.

Fixes: b294ff3e34490 ("scsi: ufs: core: Enable power management for wlun")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>
---


Patch "driver core: Prevent warning when removing a device link from
unregistered consumer" is already in Linus' tree:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e64daad660a0c9ace3acdc57099fffe5ed83f977


Changes in V5:

  Rebase on 5.15/scsi-staging



 drivers/base/core.c       |  2 ++
 drivers/scsi/ufs/ufshcd.c | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index cadcade65825..9badd7f7fe62 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -884,6 +884,8 @@ static void device_link_put_kref(struct device_link *link)
 {
 	if (link->flags & DL_FLAG_STATELESS)
 		kref_put(&link->kref, __device_link_del);
+	else if (!device_is_registered(link->consumer))
+		__device_link_del(&link->kref);
 	else
 		WARN(1, "Unable to drop a managed device link reference\n");
 }
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 6c263e94144b..9f72698ff597 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5028,6 +5028,7 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
+	unsigned long flags;
 
 	hba = shost_priv(sdev->host);
 
@@ -5035,11 +5036,29 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 
 	/* Drop the reference as it won't be needed anymore */
 	if (ufshcd_scsi_to_upiu_lun(sdev->lun) == UFS_UPIU_UFS_DEVICE_WLUN) {
-		unsigned long flags;
-
 		spin_lock_irqsave(hba->host->host_lock, flags);
 		hba->sdev_ufs_device = NULL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
+	} else if (hba->sdev_ufs_device) {
+		struct device *supplier = NULL;
+
+		/* Ensure UFS Device WLUN exists and does not disappear */
+		spin_lock_irqsave(hba->host->host_lock, flags);
+		if (hba->sdev_ufs_device) {
+			supplier = &hba->sdev_ufs_device->sdev_gendev;
+			get_device(supplier);
+		}
+		spin_unlock_irqrestore(hba->host->host_lock, flags);
+
+		if (supplier) {
+			/*
+			 * If a LUN fails to probe (e.g. absent BOOT WLUN), the
+			 * device will not have been registered but can still
+			 * have a device link holding a reference to the device.
+			 */
+			device_link_remove(&sdev->sdev_gendev, supplier);
+			put_device(supplier);
+		}
 	}
 }
 
-- 
2.17.1

