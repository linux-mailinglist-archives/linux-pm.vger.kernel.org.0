Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D734A5F0
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCZK4p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 06:56:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:2701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229963AbhCZK4P (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Mar 2021 06:56:15 -0400
IronPort-SDR: gAGv8KC/PN1OjQFwLNKhpSMBFTMPkTpvbkbCSlczm2gxTUUYlFgGUl6O/oHPJerszwdXPrWFyz
 AkyXzXGoGGEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191220953"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="191220953"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 03:56:15 -0700
IronPort-SDR: nSI2OFo0sWAKYJqNz0xXOPiqhkfcQMAUU5L08NK8tzxmRJ5e4ahVQRnFosmc++H3neH3xBLFRB
 XwkWC3sYVW/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="409849762"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 03:56:12 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH 2/2] PM: runtime: Fix race getting/putting suppliers at probe
Date:   Fri, 26 Mar 2021 12:56:19 +0200
Message-Id: <20210326105619.27570-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326105619.27570-1-adrian.hunter@intel.com>
References: <20210326105619.27570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

pm_runtime_put_suppliers() must not decrement rpm_active unless the
consumer is suspended. That is because, otherwise, it could suspend
suppliers for an active consumer.

That can happen as follows:

 static int driver_probe_device(struct device_driver *drv, struct device *dev)
 {
	int ret = 0;

	if (!device_is_registered(dev))
		return -ENODEV;

	dev->can_match = true;
	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
		 drv->bus->name, __func__, dev_name(dev), drv->name);

	pm_runtime_get_suppliers(dev);
	if (dev->parent)
		pm_runtime_get_sync(dev->parent);

 At this point, dev can runtime suspend so rpm_put_suppliers() can run,
 rpm_active becomes 1 (the lowest value).

	pm_runtime_barrier(dev);
	if (initcall_debug)
		ret = really_probe_debug(dev, drv);
	else
		ret = really_probe(dev, drv);

 Probe callback can have runtime resumed dev, and then runtime put
 so dev is awaiting autosuspend, but rpm_active is 2.

	pm_request_idle(dev);

	if (dev->parent)
		pm_runtime_put(dev->parent);

	pm_runtime_put_suppliers(dev);

 Now pm_runtime_put_suppliers() will put the supplier
 i.e. rpm_active 2 -> 1, but consumer can still be active.

	return ret;
 }

Fix by checking the runtime status. For any status other than
RPM_SUSPENDED, rpm_active can be considered to be "owned" by
rpm_[get/put]_suppliers() and pm_runtime_put_suppliers() need do nothing.

Reported-by: Asutosh Das <asutoshd@codeaurora.org>
Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/base/power/runtime.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 4fde37713c58..fe1dad68aee4 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1704,6 +1704,8 @@ void pm_runtime_get_suppliers(struct device *dev)
 void pm_runtime_put_suppliers(struct device *dev)
 {
 	struct device_link *link;
+	unsigned long flags;
+	bool put;
 	int idx;
 
 	idx = device_links_read_lock();
@@ -1712,7 +1714,11 @@ void pm_runtime_put_suppliers(struct device *dev)
 				device_links_read_lock_held())
 		if (link->supplier_preactivated) {
 			link->supplier_preactivated = false;
-			if (refcount_dec_not_one(&link->rpm_active))
+			spin_lock_irqsave(&dev->power.lock, flags);
+			put = pm_runtime_status_suspended(dev) &&
+			      refcount_dec_not_one(&link->rpm_active);
+			spin_unlock_irqrestore(&dev->power.lock, flags);
+			if (put)
 				pm_runtime_put(link->supplier);
 		}
 
-- 
2.17.1

