Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFF63C1F81
	for <lists+linux-pm@lfdr.de>; Fri,  9 Jul 2021 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbhGIGqT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Jul 2021 02:46:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:41600 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230494AbhGIGqR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 9 Jul 2021 02:46:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10039"; a="295293993"
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="295293993"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2021 23:43:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,226,1620716400"; 
   d="scan'208";a="648869602"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jul 2021 23:43:31 -0700
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
Subject: [PATCH V2 1/2] driver core: Add ability to delete device links of unregistered devices
Date:   Fri,  9 Jul 2021 09:43:40 +0300
Message-Id: <20210709064341.6206-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210709064341.6206-1-adrian.hunter@intel.com>
References: <20210709064341.6206-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Managed device links are deleted by device_del(). However it is possible to
add a device link to a consumer before device_add(), and then discover an
error prevents the device from being used. In that case normally references
to the device would be dropped and the device would be deleted. However the
device link holds a reference to the device, so the device link and device
remain indefinitely.

Amend device link removal to accept removal of a link with an
unregistered consumer device.

To make that work nicely, the devlink_remove_symlinks() function must be
amended to cope with the absence of the consumer's sysfs presence,
otherwise sysfs_remove_link() will generate a warning.

Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Fixes: b294ff3e34490 ("scsi: ufs: core: Enable power management for wlun")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/base/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index ea5b85354526..24bacdb315c6 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -562,7 +562,8 @@ static void devlink_remove_symlinks(struct device *dev,
 	struct device *con = link->consumer;
 	char *buf;
 
-	sysfs_remove_link(&link->link_dev.kobj, "consumer");
+	if (device_is_registered(con))
+		sysfs_remove_link(&link->link_dev.kobj, "consumer");
 	sysfs_remove_link(&link->link_dev.kobj, "supplier");
 
 	len = max(strlen(dev_bus_name(sup)) + strlen(dev_name(sup)),
@@ -575,8 +576,10 @@ static void devlink_remove_symlinks(struct device *dev,
 		return;
 	}
 
-	snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
-	sysfs_remove_link(&con->kobj, buf);
+	if (device_is_registered(con)) {
+		snprintf(buf, len, "supplier:%s:%s", dev_bus_name(sup), dev_name(sup));
+		sysfs_remove_link(&con->kobj, buf);
+	}
 	snprintf(buf, len, "consumer:%s:%s", dev_bus_name(con), dev_name(con));
 	sysfs_remove_link(&sup->kobj, buf);
 	kfree(buf);
@@ -885,6 +888,8 @@ static void device_link_put_kref(struct device_link *link)
 {
 	if (link->flags & DL_FLAG_STATELESS)
 		kref_put(&link->kref, __device_link_del);
+	else if (!device_is_registered(link->consumer))
+		__device_link_del(&link->kref);
 	else
 		WARN(1, "Unable to drop a managed device link reference\n");
 }
-- 
2.17.1

