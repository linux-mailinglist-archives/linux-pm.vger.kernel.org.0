Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70DA426BD73
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 08:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgIPGps (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 02:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgIPGpr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 02:45:47 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E77C061788
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:46 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1056811pjb.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eVoj/Y7hhEmWcOFF7SkEdYZfa2skHwatr+eS0o7Q9yk=;
        b=n+szBhQ/7hLOh3i8vQAg7nmEUOn/cXc5TXnyfxzZEitj/nyEyJyEP2jCyGxE9Sv5T9
         e2VmbDKzMs3liv8Pzc4XkUsF0OeCJVb3Y/5B8R0dziN8MQYeXPpqhVg4M7EfcOSwWoKV
         qcWblFbTv/eHecb9sRu5TILzCukoXdEgQEGRNWprxAbSNY66jt3zVPb9klsM1kf7zyJq
         t40SyHfHQUrHpCk1XWtdyhlqmgUNYDtvLWs4eMPV+q1PQtHSG8VhwcEk6XFIYLynN/U9
         06tOy+rbumit3iRseFtPFjE/xE5jwLK4fYnchCliiPJ0eXDibtSt/bUMLXl8uj7SXYLG
         GLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eVoj/Y7hhEmWcOFF7SkEdYZfa2skHwatr+eS0o7Q9yk=;
        b=TFHhzB6GgAePgbPN3SUW+nLiqBe8j+0dXUE5rp1Ln4JvV0wxXdBDyQDTQ+TbjqIshT
         xgJODhZt4ZCtEvpds/I1k8gdgZiyIOZZyLWq4uFO3B+mPhj2aA5uE8e9CuHmepvOIZwR
         7rJtcxpsc6lYMtzssjkwLMrrH6eB5Jhc3USDXSXAUKcZB2A7hLJdlziwGRkYJ+TD+CLm
         Wu6I1CdDW6E3lYQXBWqOZCDhehelbN+1z9LNSrr5EuAXtWqnN8lahgYil2y7ZMypl/IN
         6NarUihql6Litymf6J8rJOx8w6AW5FhUSG+N3GIsbKaAR9DGDLNJ4vuGNy2pK1GdG117
         ZVJg==
X-Gm-Message-State: AOAM532wip+hNFM+c1jUj7KO82Jmg46YNUoDXeMUHxnv2shoH9d/m2h+
        OsjQg40eVrCxrvYyu0YjeAwE8Q==
X-Google-Smtp-Source: ABdhPJwYSxPJhKE9AWiA5IBejWBYN+GiAYyaL9vZu/cmrDJZ8jZfy5LbHajV2rLB7DeIWFauGzxbhg==
X-Received: by 2002:a17:90a:f117:: with SMTP id cc23mr2627310pjb.155.1600238746495;
        Tue, 15 Sep 2020 23:45:46 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id a27sm15586944pfk.52.2020.09.15.23.45.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:45:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/4] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
Date:   Wed, 16 Sep 2020 12:15:28 +0530
Message-Id: <31999d801bfb4d8063dc1ceec1234b6b80b4ae68.1600238586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1600238586.git.viresh.kumar@linaro.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
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
index 94d959a8e954..3e7eee29ee86 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -22,17 +22,22 @@ struct cpufreq_stats {
 	spinlock_t lock;
 	unsigned int *freq_table;
 	unsigned int *trans_table;
+
+	/* Deferred reset */
+	unsigned int reset_pending;
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
+	WRITE_ONCE(stats->reset_pending, 0);
+	cpufreq_stats_update(stats, stats->reset_time);
 	spin_unlock(&stats->lock);
 }
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 {
-	return sprintf(buf, "%d\n", policy->stats->total_trans);
+	struct cpufreq_stats *stats = policy->stats;
+
+	if (READ_ONCE(stats->reset_pending))
+		return sprintf(buf, "%d\n", 0);
+	else
+		return sprintf(buf, "%d\n", stats->total_trans);
 }
 cpufreq_freq_attr_ro(total_trans);
 
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
 	struct cpufreq_stats *stats = policy->stats;
+	bool pending = READ_ONCE(stats->reset_pending);
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
+	WRITE_ONCE(stats->reset_pending, 1);
+	stats->reset_time = get_jiffies_64();
+
 	return count;
 }
 cpufreq_freq_attr_wo(reset);
@@ -84,8 +114,9 @@ cpufreq_freq_attr_wo(reset);
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
 	struct cpufreq_stats *stats = policy->stats;
+	bool pending = READ_ONCE(stats->reset_pending);
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
+	if (READ_ONCE(stats->reset_pending))
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

