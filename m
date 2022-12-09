Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77C6648575
	for <lists+linux-pm@lfdr.de>; Fri,  9 Dec 2022 16:27:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiLIP1y (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Dec 2022 10:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiLIP0t (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Dec 2022 10:26:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC0A8F0A3
        for <linux-pm@vger.kernel.org>; Fri,  9 Dec 2022 07:26:44 -0800 (PST)
Date:   Fri, 09 Dec 2022 15:26:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1670599600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lggtfZFhH07x9piK9rGRZ0bdKB3QcWneHr9M2FH6xZE=;
        b=vPa+pZ+IM76KDczCvNIl1cJtxB+9DsPJq5lZxBREMnQwC/HFSjgDqR5EVR0pnq80LsrthN
        rTz80QvXGMry3eMGCAFKZrqWN5mD/wnA8GFCzWZOPsbZIpW5p2tIxzlbN5RW0v4ammamdw
        PozQQW49bwwBGklZJsX5l4B/pOFMKS4K+yaT1oxRQNJ65Ec42sU/nsGhkWqNosObIddtPY
        sKrYWKEjWk6CtF5Y5e89cmyjU3mS9clgz5yaHoLcGlKdXaZFR/+CPDlIYgEF3RIouFVk0E
        lWlAZ6KRfcgTfudlOOqgriWDxzYYYdnuWJAYvR1Lqvk8gxh4HYa4i4+EGGHl6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1670599600;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lggtfZFhH07x9piK9rGRZ0bdKB3QcWneHr9M2FH6xZE=;
        b=wuubmJcOc7rXKHMqiHaQT4UAWtVF1/1j0Nm0dVPW9dtVURpFGnktcGT9FL3BjIh/4+n+4f
        qIWGFhb2SNJRPrBQ==
From:   "thermal-bot for Viresh Kumar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal: sysfs: Reuse cdev->max_state
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rui.zhang@intel.com, daniel.lezcano@linaro.org, amitk@kernel.org
MIME-Version: 1.0
Message-ID: <167059959973.4906.10195213058467230208.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     a365105c685cad63e3c185c294373a7b81d3ea63
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//a365105c685cad63e3c185c294373a7b81d3ea63
Author:        Viresh Kumar <viresh.kumar@linaro.org>
AuthorDate:    Mon, 17 Oct 2022 15:33:02 +05:30
Committer:     Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CommitterDate: Tue, 25 Oct 2022 18:58:11 +02:00

thermal: sysfs: Reuse cdev->max_state

Now that the cooling device structure stores the max_state value, reuse
it and drop max_states from struct cooling_dev_stats.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/thermal_sysfs.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/thermal/thermal_sysfs.c b/drivers/thermal/thermal_sysfs.c
index bd75961..febf9e7 100644
--- a/drivers/thermal/thermal_sysfs.c
+++ b/drivers/thermal/thermal_sysfs.c
@@ -661,7 +661,6 @@ struct cooling_dev_stats {
 	spinlock_t lock;
 	unsigned int total_trans;
 	unsigned long state;
-	unsigned long max_states;
 	ktime_t last_time;
 	ktime_t *time_in_state;
 	unsigned int *trans_table;
@@ -691,7 +690,7 @@ void thermal_cooling_device_stats_update(struct thermal_cooling_device *cdev,
 		goto unlock;
 
 	update_time_in_state(stats);
-	stats->trans_table[stats->state * stats->max_states + new_state]++;
+	stats->trans_table[stats->state * (cdev->max_state + 1) + new_state]++;
 	stats->state = new_state;
 	stats->total_trans++;
 
@@ -725,7 +724,7 @@ time_in_state_ms_show(struct device *dev, struct device_attribute *attr,
 	spin_lock(&stats->lock);
 	update_time_in_state(stats);
 
-	for (i = 0; i < stats->max_states; i++) {
+	for (i = 0; i <= cdev->max_state; i++) {
 		len += sprintf(buf + len, "state%u\t%llu\n", i,
 			       ktime_to_ms(stats->time_in_state[i]));
 	}
@@ -740,7 +739,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 {
 	struct thermal_cooling_device *cdev = to_cooling_device(dev);
 	struct cooling_dev_stats *stats = cdev->stats;
-	int i, states = stats->max_states;
+	int i, states = cdev->max_state + 1;
 
 	spin_lock(&stats->lock);
 
@@ -749,7 +748,7 @@ reset_store(struct device *dev, struct device_attribute *attr, const char *buf,
 	memset(stats->trans_table, 0,
 	       states * states * sizeof(*stats->trans_table));
 
-	for (i = 0; i < stats->max_states; i++)
+	for (i = 0; i < states; i++)
 		stats->time_in_state[i] = ktime_set(0, 0);
 
 	spin_unlock(&stats->lock);
@@ -767,7 +766,7 @@ static ssize_t trans_table_show(struct device *dev,
 
 	len += snprintf(buf + len, PAGE_SIZE - len, " From  :    To\n");
 	len += snprintf(buf + len, PAGE_SIZE - len, "       : ");
-	for (i = 0; i < stats->max_states; i++) {
+	for (i = 0; i <= cdev->max_state; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u  ", i);
@@ -777,17 +776,17 @@ static ssize_t trans_table_show(struct device *dev,
 
 	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
 
-	for (i = 0; i < stats->max_states; i++) {
+	for (i = 0; i <= cdev->max_state; i++) {
 		if (len >= PAGE_SIZE)
 			break;
 
 		len += snprintf(buf + len, PAGE_SIZE - len, "state%2u:", i);
 
-		for (j = 0; j < stats->max_states; j++) {
+		for (j = 0; j <= cdev->max_state; j++) {
 			if (len >= PAGE_SIZE)
 				break;
 			len += snprintf(buf + len, PAGE_SIZE - len, "%8u ",
-				stats->trans_table[i * stats->max_states + j]);
+				stats->trans_table[i * (cdev->max_state + 1) + j]);
 		}
 		if (len >= PAGE_SIZE)
 			break;
@@ -823,14 +822,10 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 {
 	const struct attribute_group *stats_attr_group = NULL;
 	struct cooling_dev_stats *stats;
-	unsigned long states;
+	/* Total number of states is highest state + 1 */
+	unsigned long states = cdev->max_state + 1;
 	int var;
 
-	if (cdev->ops->get_max_state(cdev, &states))
-		goto out;
-
-	states++; /* Total number of states is highest state + 1 */
-
 	var = sizeof(*stats);
 	var += sizeof(*stats->time_in_state) * states;
 	var += sizeof(*stats->trans_table) * states * states;
@@ -843,7 +838,6 @@ static void cooling_device_stats_setup(struct thermal_cooling_device *cdev)
 	stats->trans_table = (unsigned int *)(stats->time_in_state + states);
 	cdev->stats = stats;
 	stats->last_time = ktime_get();
-	stats->max_states = states;
 
 	spin_lock_init(&stats->lock);
 
