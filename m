Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584163CB6E1
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jul 2021 13:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhGPLrF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 16 Jul 2021 07:47:05 -0400
Received: from mga04.intel.com ([192.55.52.120]:40164 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234803AbhGPLrE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Jul 2021 07:47:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="208902317"
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="208902317"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 04:44:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,244,1620716400"; 
   d="scan'208";a="467107154"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga008.fm.intel.com with ESMTP; 16 Jul 2021 04:44:06 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/2] scsi: ufshcd: Fix device links when BOOT WLUN fails to probe
Date:   Fri, 16 Jul 2021 14:44:08 +0300
Message-Id: <20210716114408.17320-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210716114408.17320-1-adrian.hunter@intel.com>
References: <20210716114408.17320-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
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
 drivers/base/core.c       |  2 ++
 drivers/scsi/ufs/ufshcd.c | 23 +++++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 2de8f7d8cf54..983e895d4ced 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -887,6 +887,8 @@ static void device_link_put_kref(struct device_link *link)
 {
 	if (link->flags & DL_FLAG_STATELESS)
 		kref_put(&link->kref, __device_link_del);
+	else if (!device_is_registered(link->consumer))
+		__device_link_del(&link->kref);
 	else
 		WARN(1, "Unable to drop a managed device link reference\n");
 }
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 708b3b62fc4d..9864a8ee0263 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5020,15 +5020,34 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 static void ufshcd_slave_destroy(struct scsi_device *sdev)
 {
 	struct ufs_hba *hba;
+	unsigned long flags;
 
 	hba = shost_priv(sdev->host);
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

