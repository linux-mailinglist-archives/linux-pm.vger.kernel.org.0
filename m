Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01BFF25A6AC
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 09:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgIBHZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 03:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBHZF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 03:25:05 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04672C061246
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 00:25:05 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ds1so1953445pjb.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 00:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tJBzI8lB5wRp0GmHPQXlUe4WhX44ejADtz0Zhvnig4=;
        b=aWhkyKDWAf5betm7xqDa2cSgBjrX/ykPr83ItMwjnU8aSuoXBr6L5cgQA2wfKMApbI
         kw6gED2PvEapoNJZ5BuBEykbjCWuQVICq/DMqc9hIa3OSwLAOaTaa5GOiwPaoA4Lb3PP
         CT2A1RTX68yyGQtdLtMZBJUSgLmMs0jz2zo6bjcSIXqAnbk/LTUtwuA8UMskxth+Am+0
         8orfpjeS8IeUv2Dxfxy3FxWqrxMYFukMWwuBF96mREo+fRklhDq/As1WbMpBJscIG3SD
         AIqPjjmMpZFmNZlVK5tf6Lr1TVOR/ynpstIrM7IQKckzLhg4Ot8zqA/EHZ93B2YMxY9z
         BBIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tJBzI8lB5wRp0GmHPQXlUe4WhX44ejADtz0Zhvnig4=;
        b=me1SWiYA6rLizbMYX20zB2GvUu8AtWx/BKmGJ17znfaxnxDtDXMYCGrcgF7h2ROLMM
         BV+qZq1rFcYkbMD5WOfZznolV30iSdQW5JycBmgphMd8mE9HiC5XINxuAXr4RJEjFZ9z
         /x3YZzhmPmEE5KWphuVUgiMHmeWS7o/YO4QSXZFFj5XKGKAX/ZC+vFhQt+0MJi3Rsj8z
         Q01YqJ11jgo3Tm9mcitkRhGPAbjKUWNrsSISOqd/rsLx5bPfYgimwPDRoyxXTHKGMxiD
         kM5E2h032Yjs4+L560VX27w6ZwQauW43JnbIir5JVCWqeBae+x/gM1R3Tami7SD+nMSH
         6Kcg==
X-Gm-Message-State: AOAM531+cRlt4CSBP9A0uRqiE2zNQF+eQ6TgDjEwgewskPc0vIW8PhhK
        4qS/eLQi6A33yA0biml0MJAHYoUlfdUk2Q==
X-Google-Smtp-Source: ABdhPJxBiV6IU6Th5b0VjfN5Yh4wllGr8D63b3s0G1pEnxDa/etejmq6Y08SyqhjURtrz+Er6DVkog==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr1053168plq.164.1599031504547;
        Wed, 02 Sep 2020 00:25:04 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id h11sm4240987pgm.79.2020.09.02.00.25.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:25:03 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] cpufreq: stats: Remove locking
Date:   Wed,  2 Sep 2020 12:54:42 +0530
Message-Id: <d4a64a4310805b1641c2582e56fbda503688b789.1599031227.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1599031227.git.viresh.kumar@linaro.org>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The locking isn't required anymore as stats can get updated only from
one place at a time. Remove it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index fdf9e8556a49..d86ea9744649 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -19,7 +19,6 @@ struct cpufreq_stats {
 	unsigned int state_num;
 	unsigned int last_index;
 	u64 *time_in_state;
-	spinlock_t lock;
 	unsigned int *freq_table;
 	unsigned int *trans_table;
 
@@ -41,7 +40,6 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 {
 	unsigned int count = stats->max_state;
 
-	spin_lock(&stats->lock);
 	memset(stats->time_in_state, 0, count * sizeof(u64));
 	memset(stats->trans_table, 0, count * count * sizeof(int));
 	stats->last_time = get_jiffies_64();
@@ -50,7 +48,6 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 	/* Adjust for the time elapsed since reset was requested */
 	atomic_set(&stats->reset_pending, 0);
 	cpufreq_stats_update(stats, stats->reset_time);
-	spin_unlock(&stats->lock);
 }
 
 static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
@@ -244,7 +241,6 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 	stats->state_num = i;
 	stats->last_time = get_jiffies_64();
 	stats->last_index = freq_table_get_index(stats, policy->cur);
-	spin_lock_init(&stats->lock);
 
 	policy->stats = stats;
 	ret = sysfs_create_group(&policy->kobj, &stats_attr_group);
@@ -277,11 +273,9 @@ void cpufreq_stats_record_transition(struct cpufreq_policy *policy,
 	if (old_index == -1 || new_index == -1 || old_index == new_index)
 		return;
 
-	spin_lock(&stats->lock);
 	cpufreq_stats_update(stats, stats->last_time);
 
 	stats->last_index = new_index;
 	stats->trans_table[old_index * stats->max_state + new_index]++;
 	stats->total_trans++;
-	spin_unlock(&stats->lock);
 }
-- 
2.25.0.rc1.19.g042ed3e048af

