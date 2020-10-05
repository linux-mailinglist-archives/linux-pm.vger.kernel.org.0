Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7F828312D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 09:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJEH4h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 03:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbgJEH4f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 03:56:35 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C293BC0613A6
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 00:56:35 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id e10so5736772pfj.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 00:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rXevW3gspEqrbAGRsrOKhUql5m0Aoc1FPHPDeVmOGB0=;
        b=knhU6mtRL+hMoixoMeE5z6HzTd6SQof8JiUtyCx1XosRHhlL0c5Fz2lzDh4WpWsrk+
         hhechBFPkwZa5oUoTuNCk4fDbEHOhfApb1sM5HdWmiR7WGcpEyve7xw+xthFrHWpIlWY
         7jwFPjZUBz5WLZSHSrHVghSOzeVDsrEKwfCuPC5qzZqJPuoUJVUWy2w+nNP/v9XUjMEO
         3xMoRn2/2M4RImjukHEzwRRkIpyDFlL3aRcNBwskrq1PY2KtAOq23EWSlOxHVtiIU/EU
         K/Xz4W1P5xE6xOiVB40EnelI92yZl5YTdr8EcgYb5R6xSYQRBmhejpJT/V3cBs02XCVT
         BGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rXevW3gspEqrbAGRsrOKhUql5m0Aoc1FPHPDeVmOGB0=;
        b=ZuZkURbMj/9aomxuk67JYYRgkxjgJWoGW4W97jhHZ00PexAAmvqS0LQEx8FEWHctqI
         cNELlYZ6YLeDQCO/VsFRwYUACMKhkCQQD8tPv/VMxXNig47xPhtVLXVm6nFMDAWvtcas
         BOfkylI1P0U33UJGZcHluARJz+ZgwGbR4ycEyFehPSkbwBG7OOA+r/GBNELyaDLctvUC
         5BQCmvq8ycRwOHhln20gCISuCmxZIN4L2Ej+/0iGecGr6d9GNdqpijvDfGBOAg7NDA4e
         7jMKjF/t8hAk62TcBr5W/fsTBLkroqjcXgGbJrsrZjzCpp84taZE7I2jgy2yj7wsbYGd
         qnLA==
X-Gm-Message-State: AOAM530kj84CSJV5LAMfyOfWU/2VIqXfs0HlE3xd8rNHjfeiIfklF8Vj
        JiBeuiEzSyO/gBcq1b6QkcT/bAxFK27hDQ==
X-Google-Smtp-Source: ABdhPJwGFoxTy7Ia4fihc+xAupy9E8rnHjAwhi5e5qj8gagwC1Dgw39Rp2LpAkYqkyC7bKzW4NjPPA==
X-Received: by 2002:a63:d841:: with SMTP id k1mr13588737pgj.59.1601884595204;
        Mon, 05 Oct 2020 00:56:35 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x12sm3497294pfr.156.2020.10.05.00.56.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:56:34 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V3 1/5] cpufreq: stats: Defer stats update to cpufreq_stats_record_transition()
Date:   Mon,  5 Oct 2020 13:26:01 +0530
Message-Id: <2570daf8931feeecd3ae94463f736e813c993fc0.1601884370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1601884370.git.viresh.kumar@linaro.org>
References: <cover.1601884370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

In order to prepare for lock-less stats update, add support to defer any
updates to it until cpufreq_stats_record_transition() is called.

The stats were updated from two places earlier:

- show_time_in_state(): This can be easily deferred, all we need is to
  calculate the delta duration again in this routine to show the current
  state's time-in-state.

- store_reset(): This is a bit tricky as we need to clear the stats
  here and avoid races with simultaneous call to
  cpufreq_stats_record_transition().

  This patch fixes it by deferring the reset of the stats (within the
  code) to the next call to cpufreq_stats_record_transition(), but since
  we need to keep showing the right stats until that time, we capture
  the reset time and account for the time since last time reset was
  called until the time cpufreq_stats_record_transition() update the
  stats.

  Userspace will continue seeing the stats correctly, everything will be
  0 after the stats are reset, apart from the time-in-state of the
  current state, until the time a frequency switch happens.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 75 ++++++++++++++++++++++++---------
 1 file changed, 56 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 94d959a8e954..498d962ba224 100644
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
+	cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
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
+				time = get_jiffies_64() - READ_ONCE(stats->reset_time);
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
+	WRITE_ONCE(stats->reset_time, get_jiffies_64());
+	WRITE_ONCE(stats->reset_pending, 1);
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
+	if (unlikely(READ_ONCE(stats->reset_pending)))
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

