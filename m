Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 410821A1ADB
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 06:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDHETg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 00:19:36 -0400
Received: from mga11.intel.com ([192.55.52.93]:49178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHETg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 00:19:36 -0400
IronPort-SDR: wiMRAWE719wQk/c9NVUVFUe0IkiIxcMAv9blDaEiIwI8pArudZma/1eZLuN6/Qu1zCCzWhoWPW
 kkPm54I+SaTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 21:19:36 -0700
IronPort-SDR: 7QAtOA5qb/lU7NSXiHQNlNsHIwZOQFw/nqdz/mF608nMq6WAQ6TOaSdfOdAtqjkwx56MgsfX3/
 nSDKFmisbnXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="451470401"
Received: from tliao1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.172.195])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 21:19:34 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, tiwai@suse.de,
        viresh.kumar@linaro.org
Subject: [RFC PATCH 3/5] thermal: support statistics table resizing at runtime
Date:   Wed,  8 Apr 2020 12:19:15 +0800
Message-Id: <20200408041917.2329-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408041917.2329-1-rui.zhang@intel.com>
References: <20200408041917.2329-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Introduce thermal_cdev_stats_update_max() which can be used to update
the cooling device statistics table when maximum cooling state of a
cooling device is changed.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sysfs.c | 65 ++++++++++++++++++++++++++-------
 include/linux/thermal.h         |  7 ++++
 2 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 45cfc2746874..96e4a445952f 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -745,6 +745,10 @@ static const struct attribute_group *cooling_device_attr_groups[] = {
 };
 
 #ifdef CONFIG_THERMAL_STATISTICS
+static int cooling_device_stats_resize(struct thermal_cooling_device *cdev,
+					unsigned long cur_state,
+					unsigned long max_state);
+
 struct cooling_dev_stats {
 	spinlock_t lock;
 	unsigned int total_trans;
@@ -787,6 +791,23 @@ void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
 	spin_unlock(&stats->lock);
 }
 
+void thermal_cdev_stats_update_max(struct thermal_cooling_device *cdev)
+{
+	struct cooling_dev_stats *stats = cdev->stats;
+	unsigned long cur_state, max_state;
+
+	if (!stats)
+		return;
+
+	if (cdev->ops->get_max_state(cdev, &max_state))
+		return;
+
+	if (cdev->ops->get_cur_state(cdev, &cur_state))
+		return;
+
+	cooling_device_stats_resize(cdev, cur_state, max_state);
+}
+
 static ssize_t total_trans_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -907,36 +928,44 @@ static const struct attribute_group cooling_device_stats_attr_group = {
 	.name = "stats"
 };
 
-static int cooling_device_stats_resize(struct thermal_cooling_device *cdev)
+static int cooling_device_stats_resize(struct thermal_cooling_device *cdev,
+					unsigned long cur_state,
+					unsigned long max_state)
 {
 	struct cooling_dev_stats *stats = cdev->stats;
-	unsigned long states;
-	int ret;
-
-	ret = cdev->ops->get_max_state(cdev, &states);
-	if (ret)
-		return ret;
+	unsigned long states = max_state + 1;
+	void *time_in_state, *trans_table;
 
-	states++; /* Total number of states is highest state + 1 */
+	if (stats->max_states == states)
+		return 0;
 
-	stats->time_in_state = kcalloc(states, sizeof(*stats->time_in_state), GFP_KERNEL);
-	if (!stats->time_in_state)
+	time_in_state = kcalloc(states, sizeof(*stats->time_in_state), GFP_KERNEL);
+	if (!time_in_state)
 		return -ENOMEM;
 
-	stats->trans_table = kcalloc(states, sizeof(*stats->trans_table) * states, GFP_KERNEL);
-	if (!stats->trans_table) {
-		kfree(stats->time_in_state);
+	trans_table = kcalloc(states, sizeof(*stats->trans_table) * states, GFP_KERNEL);
+	if (!trans_table) {
+		kfree(time_in_state);
 		return -ENOMEM;
 	}
 
+	spin_lock(&stats->lock);
+	kfree(stats->time_in_state);
+	kfree(stats->trans_table);
+	stats->time_in_state = time_in_state;
+	stats->trans_table = trans_table;
 	stats->last_time = ktime_get();
 	stats->max_states = states;
+	stats->state = cur_state;
+	stats->total_trans = 0;
+	spin_unlock(&stats->lock);
 
 	return 0;
 }
 static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 {
 	struct cooling_dev_stats *stats;
+	unsigned long max_state;
 	int var, ret;
 
 	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
@@ -946,7 +975,15 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	cdev->stats = stats;
 	spin_lock_init(&stats->lock);
 
-	ret = cooling_device_stats_resize(cdev);
+	ret = cdev->ops->get_max_state(cdev, &max_state);
+	if (ret)
+		return;
+
+	/**
+	 *  cooling device current state will be updated soon
+	 *  during registration
+	 **/
+	ret = cooling_device_stats_resize(cdev, 0, max_state);
 	if (ret) {
 		kfree(cdev->stats);
 		cdev->stats = NULL;
diff --git a/include/linux/thermal.h b/include/linux/thermal.h
index 126913c6a53b..cf3fad92f473 100644
--- a/include/linux/thermal.h
+++ b/include/linux/thermal.h
@@ -533,4 +533,11 @@ static inline void thermal_notify_framework(struct thermal_zone_device *tz,
 { }
 #endif /* CONFIG_THERMAL */
 
+#ifdef CONFIG_THERMAL_STATISTICS
+void thermal_cdev_stats_update_max(struct thermal_cooling_device *cdev);
+#else
+static inline void
+thermal_cdev_stats_update_max(struct thermal_cooling_device *cdev) {}
+#endif /* CONFIG_THERMAL_STATISTICS */
+
 #endif /* __THERMAL_H__ */
-- 
2.17.1

