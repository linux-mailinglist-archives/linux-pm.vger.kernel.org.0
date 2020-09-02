Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF6A25A69B
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 09:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727800AbgIBHZF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 03:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHZC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 03:25:02 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA33C061244
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 00:25:02 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id a8so1887748plm.2
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 00:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ABESP1WCpoqEOc5UMRR48HLj5tlVp8CRML1h3CxuOlI=;
        b=wGxNf6Vsr62NPWa9sSB8S86EkWPBNSXgc+Mq4pYSYwOjt+pAPY1oLH3kvydFsr1iJ6
         NfKN7CUnj5um2Nd6UCMKbfQwnuxsCjYK5MFbMlqfy4mJdIjJm9M80Dtzu9KEzyBlfSNx
         Q3BrUEzI+6/FF1cKf1HLvjrBSWlEGXv/tCyDRsGSxYmtjssLlqitl3emPTWxv4dGWpp6
         jLjT2KT+A+hFx9POyyZQjeDo+h3Q7Wdg2wAVF+FbKFms/BzkVmBglDx+zLbLTcHhbUta
         0vElNjHI6rFORD19g0oO4hX+AvtkwB+AVoGsi1h7Yj6zXCDyol0yaT5ZwWqJowyD9mZX
         TvDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ABESP1WCpoqEOc5UMRR48HLj5tlVp8CRML1h3CxuOlI=;
        b=PGgiwhsJ+xafJP8b5pF5lnrwKW3/k5qiYUl2RbXJwevgYYSo6hQldSRLWkX0gweqt0
         qncMKtuL+EzfnnNuv6oRM1Jw7YlVBEr2Qtq0E7p3rA5nSY7hRmnmI3w24v/yEWXv0x9v
         Ebdg46YUMvzMmvQgoyMdLaaFnkg0Mwuops7qfPB01ALVSsAfyxCTANad6aTvmDQnp6M8
         XCsziqf2q5/2ApqSKlq0C5I2GBfyYBUs18PoQZJVCJUCX5GVFJKQ6Vjok3qhgh6Hoyoj
         /edruWXLnvAq5CVgKsAGXQ+Sg0N9iw3EWyef9OfBNKkoAZ88Rn7PhBxrrk28FyX8MgjQ
         UMmQ==
X-Gm-Message-State: AOAM532jXY1VqTITSRzuA0pi6xYWIxFBnGfah0gTn0IFa+MBQcLR8R3E
        mufqRbmTOAO8cLw3kuA9xi1kVQ==
X-Google-Smtp-Source: ABdhPJwFzTjzCThaufD+bIZ9VfbXdUXBllMVgf8NtxhiSWTGGOM3tEBwHrP+DXDAlZZjkYsI4djqxg==
X-Received: by 2002:a17:902:758d:: with SMTP id j13mr1016597pll.174.1599031501559;
        Wed, 02 Sep 2020 00:25:01 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id e12sm3534433pjd.55.2020.09.02.00.25.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:25:00 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
Date:   Wed,  2 Sep 2020 12:54:41 +0530
Message-Id: <973bd0536c4957d03f36447398498cfacb2393d9.1599031227.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1599031227.git.viresh.kumar@linaro.org>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to prepare for lock-less stats update, add support to defer any
updates to it until cpufreq_stats_record_transition() is called.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 94d959a8e954..fdf9e8556a49 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -22,17 +22,22 @@ struct cpufreq_stats {
 	spinlock_t lock;
 	unsigned int *freq_table;
 	unsigned int *trans_table;
+
+	/* Deferred reset */
+	atomic_t reset_pending;
+	unsigned long long reset_time;
 };
 
-static void cpufreq_stats_update(struct cpufreq_stats *stats)
+static void cpufreq_stats_update(struct cpufreq_stats *stats,
+				 unsigned long long time)
 {
 	unsigned long long cur_time = get_jiffies_64();
 
-	stats->time_in_state[stats->last_index] += cur_time - stats->last_time;
+	stats->time_in_state[stats->last_index] += cur_time - time;
 	stats->last_time = cur_time;
 }
 
-static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
+static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 {
 	unsigned int count = stats->max_state;
 
@@ -41,42 +46,67 @@ static void cpufreq_stats_clear_table(struct cpufreq_stats *stats)
 	memset(stats->trans_table, 0, count * count * sizeof(int));
 	stats->last_time = get_jiffies_64();
 	stats->total_trans = 0;
+
+	/* Adjust for the time elapsed since reset was requested */
+	atomic_set(&stats->reset_pending, 0);
+	cpufreq_stats_update(stats, stats->reset_time);
 	spin_unlock(&stats->lock);
 }
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 {
-	return sprintf(buf, "%d\n", policy->stats->total_trans);
+	struct cpufreq_stats *stats = policy->stats;
+
+	if (atomic_read(&stats->reset_pending))
+		return sprintf(buf, "%d\n", 0);
+	else
+		return sprintf(buf, "%d\n", stats->total_trans);
 }
 cpufreq_freq_attr_ro(total_trans);
 
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
 	struct cpufreq_stats *stats = policy->stats;
+	bool pending = atomic_read(&stats->reset_pending);
+	unsigned long long time;
 	ssize_t len = 0;
 	int i;
 
 	if (policy->fast_switch_enabled)
 		return 0;
 
-	spin_lock(&stats->lock);
-	cpufreq_stats_update(stats);
-	spin_unlock(&stats->lock);
-
 	for (i = 0; i < stats->state_num; i++) {
+		if (pending) {
+			if (i == stats->last_index)
+				time = get_jiffies_64() - stats->reset_time;
+			else
+				time = 0;
+		} else {
+			time = stats->time_in_state[i];
+			if (i == stats->last_index)
+				time += get_jiffies_64() - stats->last_time;
+		}
+
 		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
-			(unsigned long long)
-			jiffies_64_to_clock_t(stats->time_in_state[i]));
+			       jiffies_64_to_clock_t(time));
 	}
 	return len;
 }
 cpufreq_freq_attr_ro(time_in_state);
 
+/* We don't care what is written to the attribute */
 static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
 			   size_t count)
 {
-	/* We don't care what is written to the attribute. */
-	cpufreq_stats_clear_table(policy->stats);
+	struct cpufreq_stats *stats = policy->stats;
+
+	/*
+	 * Defer resetting of stats to cpufreq_stats_record_transition() to
+	 * avoid races.
+	 */
+	atomic_set(&stats->reset_pending, 1);
+	stats->reset_time = get_jiffies_64();
+
 	return count;
 }
 cpufreq_freq_attr_wo(reset);
@@ -84,8 +114,9 @@ cpufreq_freq_attr_wo(reset);
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
 	struct cpufreq_stats *stats = policy->stats;
+	bool pending = atomic_read(&stats->reset_pending);
 	ssize_t len = 0;
-	int i, j;
+	int i, j, count;
 
 	if (policy->fast_switch_enabled)
 		return 0;
@@ -113,8 +144,13 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 		for (j = 0; j < stats->state_num; j++) {
 			if (len >= PAGE_SIZE)
 				break;
-			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ",
-					stats->trans_table[i*stats->max_state+j]);
+
+			if (pending)
+				count = 0;
+			else
+				count = stats->trans_table[i * stats->max_state + j];
+
+			len += scnprintf(buf + len, PAGE_SIZE - len, "%9u ", count);
 		}
 		if (len >= PAGE_SIZE)
 			break;
@@ -228,10 +264,11 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	struct cpufreq_stats *stats = policy->stats;
 	int old_index, new_index;
 
-	if (!stats) {
-		pr_debug("%s: No stats found\n", __func__);
+	if (!stats)
 		return;
-	}
+
+	if (atomic_read(&stats->reset_pending))
+		cpufreq_stats_reset_table(stats);
 
 	old_index = stats->last_index;
 	new_index = freq_table_get_index(stats, new_freq);
@@ -241,7 +278,7 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 		return;
 
 	spin_lock(&stats->lock);
-	cpufreq_stats_update(stats);
+	cpufreq_stats_update(stats, stats->last_time);
 
 	stats->last_index = new_index;
 	stats->trans_table[old_index * stats->max_state + new_index]++;
-- 
2.25.0.rc1.19.g042ed3e048af

