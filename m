Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F8C3BED13
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbhGGRc1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:32:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:29423 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230518AbhGGRcY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:32:24 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196517867"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="196517867"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 10:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="563990009"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2021 10:29:40 -0700
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
Subject: [PATCH RFC 2/2] scsi: ufshcd: Fix device links when BOOT WLUN fails to probe
Date:   Wed,  7 Jul 2021 20:29:48 +0300
Message-Id: <20210707172948.1025-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707172948.1025-1-adrian.hunter@intel.com>
References: <20210707172948.1025-1-adrian.hunter@intel.com>
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

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/scsi/ufs/ufshcd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 708b3b62fc4d..483aa74fe2c8 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -5029,6 +5029,13 @@ static void ufshcd_slave_destroy(struct scsi_device *sdev)
 		spin_lock_irqsave(hba->host->host_lock, flags);
 		hba->sdev_ufs_device = NULL;
 		spin_unlock_irqrestore(hba->host->host_lock, flags);
+	} else {
+		/*
+		 * If a LUN fails to probe (e.g. absent BOOT WLUN), the device
+		 * will not have been registered but can still have a device
+		 * link holding a reference to the device.
+		 */
+		device_links_scrap(&sdev->sdev_gendev);
 	}
 }
 
-- 
2.17.1

