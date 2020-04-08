Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF61A1ADA
	for <lists+linux-pm@lfdr.de>; Wed,  8 Apr 2020 06:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgDHETc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 8 Apr 2020 00:19:32 -0400
Received: from mga11.intel.com ([192.55.52.93]:49178 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725763AbgDHETb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 8 Apr 2020 00:19:31 -0400
IronPort-SDR: PzkXhYO9vke/NuhMUw4/sxHbZzOZYyfNv4TwgqBczXugj9ZnvGzEd1Dl8R6IfQYSYWGH9/Kbk8
 fCDMTgD/oTMg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2020 21:19:31 -0700
IronPort-SDR: o7yHOJVZg29UVPBaxHBmkJS2OQ5FC8ygeHI1a+hirdEpSoNm0dahrtN+zMe3d7X4fWj5tNCi+a
 QC8vSelTmcfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; 
   d="scan'208";a="451470384"
Received: from tliao1-mobl2.ccr.corp.intel.com (HELO rzhang1-mobile.ccr.corp.intel.com) ([10.249.172.195])
  by fmsmga005.fm.intel.com with ESMTP; 07 Apr 2020 21:19:30 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, daniel.lezcano@linaro.org, tiwai@suse.de,
        viresh.kumar@linaro.org
Subject: [RFC PATCH 2/5] thermal: create statistics table in two steps
Date:   Wed,  8 Apr 2020 12:19:14 +0800
Message-Id: <20200408041917.2329-2-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200408041917.2329-1-rui.zhang@intel.com>
References: <20200408041917.2329-1-rui.zhang@intel.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Part of cooling device stats table is created based on the number of
cooling states supported, and this may be changed at runtime.
Introduce cooling_device_stats_resize() to handle this piece of the
statistics table.

Plus, check the existence of the statistics table before access because
the table may fail to be created during cooling device registration.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/thermal/thermal_sysfs.c | 56 ++++++++++++++++++++++++---------
 1 file changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index 00caa7787b71..45cfc2746874 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -770,6 +770,9 @@ void thermal_cdev_stats_update_cur(struct thermal_cooling_device *cdev,
 {
 	struct cooling_dev_stats *stats = cdev->stats;
 
+	if (!stats)
+		return;
+
 	spin_lock(&stats->lock);
 
 	if (stats->state == new_state)
@@ -904,33 +907,52 @@ static const struct attribute_group cooling_device_stats_attr_group = {
 	.name = "stats"
 };
 
-static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
+static int cooling_device_stats_resize(struct thermal_cooling_device *cdev)
 {
-	struct cooling_dev_stats *stats;
+	struct cooling_dev_stats *stats = cdev->stats;
 	unsigned long states;
-	int var;
+	int ret;
 
-	if (cdev->ops->get_max_state(cdev, &states))
-		return;
+	ret = cdev->ops->get_max_state(cdev, &states);
+	if (ret)
+		return ret;
 
 	states++; /* Total number of states is highest state + 1 */
 
-	var = sizeof(*stats);
-	var += sizeof(*stats->time_in_state) * states;
-	var += sizeof(*stats->trans_table) * states * states;
+	stats->time_in_state = kcalloc(states, sizeof(*stats->time_in_state), GFP_KERNEL);
+	if (!stats->time_in_state)
+		return -ENOMEM;
 
-	stats = kzalloc(var, GFP_KERNEL);
-	if (!stats)
-		return;
+	stats->trans_table = kcalloc(states, sizeof(*stats->trans_table) * states, GFP_KERNEL);
+	if (!stats->trans_table) {
+		kfree(stats->time_in_state);
+		return -ENOMEM;
+	}
 
-	stats->time_in_state = (ktime_t *)(stats + 1);
-	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
-	cdev->stats = stats;
 	stats->last_time = ktime_get();
 	stats->max_states = states;
 
+	return 0;
+}
+static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
+{
+	struct cooling_dev_stats *stats;
+	int var, ret;
+
+	stats = kzalloc(sizeof(*stats), GFP_KERNEL);
+	if (!stats)
+		return;
+
+	cdev->stats = stats;
 	spin_lock_init(&stats->lock);
 
+	ret = cooling_device_stats_resize(cdev);
+	if (ret) {
+		kfree(cdev->stats);
+		cdev->stats = NULL;
+		return;
+	}
+
 	/* Fill the empty slot left in cooling_device_attr_groups */
 	var = ARRAY_SIZE(cooling_device_attr_groups) - 2;
 	cooling_device_attr_groups[var] = &cooling_device_stats_attr_group;
@@ -938,6 +960,12 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 
 static void cooling_device_stats_destroy(struct thermal_cooling_device *cdev)
 {
+	struct cooling_dev_stats *stats = cdev->stats;
+
+	if (!stats)
+		return;
+	kfree(stats->time_in_state);
+	kfree(stats->trans_table);
 	kfree(cdev->stats);
 	cdev->stats = NULL;
 }
-- 
2.17.1

