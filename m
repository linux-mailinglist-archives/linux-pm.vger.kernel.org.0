Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CC83C3436
	for <lists+linux-pm@lfdr.de>; Sat, 10 Jul 2021 12:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232689AbhGJKlG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 10 Jul 2021 06:41:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:34009 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232701AbhGJKlG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 06:41:06 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10040"; a="209638439"
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="209638439"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2021 03:38:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,229,1620716400"; 
   d="scan'208";a="429090460"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by orsmga002.jf.intel.com with ESMTP; 10 Jul 2021 03:38:18 -0700
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
Subject: [PATCH V3 3/3] scsi: ufshcd: Fix device links when BOOT WLUN fails to probe
Date:   Sat, 10 Jul 2021 13:38:19 +0300
Message-Id: <20210710103819.12532-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210710103819.12532-1-adrian.hunter@intel.com>
References: <20210710103819.12532-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If a LUN fails to probe (e.g. absent BOOT WLUN), the device will not have
been registered but can still have a device link holding a reference to the
device. The unwanted device link will prevent runtime suspend indefinitely,
and cause some warnings if the supplier is ever deleted (e.g. by unbinding
the UFS host controller). Fix by explicitly deleting the device link when
SCSI destroys the SCSI device.

Fixes: b294ff3e34490 ("scsi: ufs: core: Enable power management for wlun")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

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

