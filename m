Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAFD34A5ED
	for <lists+linux-pm@lfdr.de>; Fri, 26 Mar 2021 11:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCZK4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Mar 2021 06:56:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:2701 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCZK4M (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 26 Mar 2021 06:56:12 -0400
IronPort-SDR: a3UCcsAmfVdwIpNRFtiDUaydwric6DO1VDmL91e7tPlaMNOgc6XYgYGsAUX4+o0r6djrzD0iKh
 RSPU054QLN7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9934"; a="191220951"
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="191220951"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2021 03:56:12 -0700
IronPort-SDR: TwwsbXPvPShzxA1WoJLivEWVb/MpKWvrSjBdJkfhAqvPMl/zhPVf5/QcFQaVhCgeG5eJOYkdbF
 cTrbZQWEQF/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,280,1610438400"; 
   d="scan'208";a="409849741"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 26 Mar 2021 03:56:09 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     linux-pm@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, Avri Altman <avri.altman@wdc.com>,
        Bean Huo <huobean@gmail.com>, Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>
Subject: [PATCH 1/2] PM: runtime: Fix ordering in pm_runtime_get_suppliers()
Date:   Fri, 26 Mar 2021 12:56:18 +0200
Message-Id: <20210326105619.27570-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210326105619.27570-1-adrian.hunter@intel.com>
References: <20210326105619.27570-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

rpm_active indicates how many times the supplier usage_count has been
incremented. Consequently it must be updated after pm_runtime_get_sync() of
the supplier, not before.

Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/base/power/runtime.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index d54e540067bf..4fde37713c58 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1690,8 +1690,8 @@ void pm_runtime_get_suppliers(struct device *dev)
 				device_links_read_lock_held())
 		if (link->flags & DL_FLAG_PM_RUNTIME) {
 			link->supplier_preactivated = true;
-			refcount_inc(&link->rpm_active);
 			pm_runtime_get_sync(link->supplier);
+			refcount_inc(&link->rpm_active);
 		}
 
 	device_links_read_unlock(idx);
-- 
2.17.1

