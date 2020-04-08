Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DB441A1AD9
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 06:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgDHET1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 00:19:27 -0400
Received: from mga11.intel.com ([192.55.52.93]:49178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHET1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 00:19:27 -0400
IronPort-SDR: NiTNxjS5LNo/EJO7p6wMtmndOtuGZPWcjFbiC/TPu9b4m8M7WyvLpvEZ22C3dzABHEiDiMxTLY
 LrNl137V/13Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 21:19:27 -0700
IronPort-SDR: TW3IYBidF6SyvVkoBppYF0QA3DFGkleFh+qylxLU393M/DPVwLLJeT5jVmHaXRK+6e2w5WdlIf
 Nf24RgGkBgCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="451470370"
Received: from tliao1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.172.195])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 21:19:25 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, tiwai@suse.de,
        viresh.kumar@linaro.org
Subject: [RFC PATCH 1/5] thermal: rename thermal_cooling_device_stats_update()
Date:   Wed,  8 Apr 2020 12:19:13 +0800
Message-Id: <20200408041917.2329-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rename thermal_cooling_device_stats_update() to
thermal_cdev_stats_update_cur()

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_core.h    | 4 ++--
 drivers/thermal/thermal_helpers.c | 2 +-
 drivers/thermal/thermal_sysfs.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/thermal_core.h b/drivers/thermal/thermal_core.h
index a9bf00e91d64..722902d5724a 100644
--- a/drivers/thermal/thermal_core.h
+++ b/drivers/thermal/thermal_core.h
@@ -81,11 +81,11 @@ ssize_t weight_store(struct device *, struct device_attribute *, const char *,
 		     size_t);
 
 #ifdef CONFIG_THERMAL_STATISTICS
-void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
 					 unsigned long new_state);
 #else
 static inline void
-thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
 				    unsigned long new_state) {}
 #endif /* CONFIG_THERMAL_STATISTICS */
 
diff --git a/drivers/thermal/thermal_helpers.c b/drivers/thermal/thermal_helpers.c
index 2ba756af76b7..3af895e5dfce 100644
--- a/drivers/thermal/thermal_helpers.c
+++ b/drivers/thermal/thermal_helpers.c
@@ -186,7 +186,7 @@ void thermal_cdev_update(struct thermal_cooling_device *cdev)
 	}
 
 	if (!cdev->ops->set_cur_state(cdev, target))
-		thermal_cooling_device_stats_update(cdev, target);
+		thermal_cdev_stats_update_cur(cdev, target);
 
 	cdev->updated = true;
 	mutex_unlock(&cdev->lock);
diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index aa99edb4dff7..00caa7787b71 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -716,7 +716,7 @@ cur_state_store(struct device *dev, struct device_attribute *attr,
 
 	result = cdev->ops->set_cur_state(cdev, state);
 	if (!result)
-		thermal_cooling_device_stats_update(cdev, state);
+		thermal_cdev_stats_update_cur(cdev, state);
 
 	mutex_unlock(&cdev->lock);
 	return result ? result : count;
@@ -765,7 +765,7 @@ static void update_time_in_state(struct cooling_dev_stats *stats)
 	stats->last_time = now;
 }
 
-void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
+void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
 					 unsigned long new_state)
 {
 	struct cooling_dev_stats *stats = cdev->stats;
-- 
2.17.1

