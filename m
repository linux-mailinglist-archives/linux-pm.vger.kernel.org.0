Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 674CA3BED0F
	for <lists+linux-pm@lfdr.de>; Wed,  7 Jul 2021 19:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbhGGRcW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 7 Jul 2021 13:32:22 -0400
Received: from mga02.intel.com ([134.134.136.20]:29423 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229717AbhGGRcV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jul 2021 13:32:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="196517859"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="196517859"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2021 10:29:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; 
   d="scan'208";a="563989995"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.79])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2021 10:29:37 -0700
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
Subject: [PATCH RFC 1/2] driver core: Add ability to delete device links of unregistered devices
Date:   Wed,  7 Jul 2021 20:29:47 +0300
Message-Id: <20210707172948.1025-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210707172948.1025-1-adrian.hunter@intel.com>
References: <20210707172948.1025-1-adrian.hunter@intel.com>
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

Add a function to delete device links of an unregistered device, so that
drivers can get rid of unregistered devices and their device links.

To do that, the devlink_remove_symlinks() function must be amended to cope
with the absence of the consumer's sysfs presence, otherwise
sysfs_remove_link() will generate warnings.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 Documentation/driver-api/device_link.rst |  7 +++++--
 drivers/base/core.c                      | 22 +++++++++++++++++++---
 include/linux/device.h                   |  1 +
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/device_link.rst b/Documentation/driver-api/device_link.rst
index ee913ae16371..12c0602822c8 100644
--- a/Documentation/driver-api/device_link.rst
+++ b/Documentation/driver-api/device_link.rst
@@ -75,7 +75,9 @@ driver is compiled as a module, the device link is added on module load and
 orderly deleted on unload.  The same restrictions that apply to device link
 addition (e.g. exclusion of a parallel suspend/resume transition) apply equally
 to deletion.  Device links managed by the driver core are deleted automatically
-by it.
+by it, except if the consumer device is never registered (e.g. because of an
+error), in which case the device links must be explicitly removed using
+:c:func:`device_links_scrap()`.
 
 Several flags may be specified on device link addition, two of which
 have already been mentioned above:  ``DL_FLAG_STATELESS`` to express that no
@@ -317,4 +319,5 @@ State machine
 API
 ===
 
-See device_link_add(), device_link_del() and device_link_remove().
+See device_link_add(), device_link_del(), device_link_remove() and
+device_links_scrap().
diff --git a/drivers/base/core.c b/drivers/base/core.c
index ea5b85354526..2ed32ab50b84 100644
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
@@ -1538,6 +1541,19 @@ static void device_links_purge(struct device *dev)
 	device_links_write_unlock();
 }
 
+/**
+ * device_links_scrap - Device was never registered, delete any device links.
+ * @dev: Target device.
+ */
+void device_links_scrap(struct device *dev)
+{
+	if (WARN_ON(device_is_registered(dev)))
+		return;
+
+	device_links_purge(dev);
+}
+EXPORT_SYMBOL_GPL(device_links_scrap);
+
 #define FW_DEVLINK_FLAGS_PERMISSIVE	(DL_FLAG_INFERRED | \
 					 DL_FLAG_SYNC_STATE_ONLY)
 #define FW_DEVLINK_FLAGS_ON		(DL_FLAG_INFERRED | \
diff --git a/include/linux/device.h b/include/linux/device.h
index 2a22875238a6..90574f9aa8f2 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -967,6 +967,7 @@ struct device_link *device_link_add(struct device *consumer,
 				    struct device *supplier, u32 flags);
 void device_link_del(struct device_link *link);
 void device_link_remove(void *consumer, struct device *supplier);
+void device_links_scrap(struct device *dev);
 void device_links_supplier_sync_state_pause(void);
 void device_links_supplier_sync_state_resume(void);
 
-- 
2.17.1

