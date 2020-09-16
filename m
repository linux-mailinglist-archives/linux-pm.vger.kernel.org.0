Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF5526BD75
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgIPGp7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 02:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgIPGpv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 02:45:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5703C06174A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:49 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so1026018pjd.4
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hZYCz5nzNahLD9wsdHTKADWsrq22uAWjN70xaMi6z60=;
        b=n2XHtFO9+VtbH/rlGPlB4k4m2Tlk1t+XAlgn/+W/9KolZcZ/wbfFx+FBCfDYKoM8Y+
         QqvBTdFfFTBwWFY3p8C7N0gKWAycS8Ov0T1gK8rdXYolO34yYi5JtrFssFI/welnC+p5
         l4/XLfLa7BRm/V0TgL3v6++Mp/ViknUGx90pUVo+odHSeXoNdXcKFytsQMC7q97op0PA
         9DP5qLVUVMUnvCMaQtikQOagPILRRsi/CCdKQfxgGnjd8s/HO3uJtQRJLGsBbL07GMpp
         fzcHCFQ0hR4LT8/iV8qx3s/RTtzmXbUKphL+31S9rpot7mgKZzfHK06n0oor9bJzUB8s
         R1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hZYCz5nzNahLD9wsdHTKADWsrq22uAWjN70xaMi6z60=;
        b=YUEsvpnfvp8G6wxllPMMjRR8tZ8bPbMr+4QaDQuUvY/Da92mYPYZ5HzCoSl/DqhmxN
         janUNwPegSC/hb+0N2f8YDAb8QfgoYlhEzmuxTgpCJP4FsWoe5LfnQ29Vx8BbBYh/klo
         O7fBD4zHFmPe7GgPs5JEssr/1Gfeh01dFXP6FI9xJxPJ5+c0Eh0dyJUSac8qwQqS3tfe
         9i/Up8rY0u1mII6wwMCamIFyATu1M8QfYWdW8UxwA1FOZmakT4+2AVU0Y5R+u0xYR7vS
         qhASK7gJzXocXfwLuWp1RvPgE0hgbUib/4onxuWeqzl4OHZpp5MGgWvqKur8DSDRLtis
         /ntg==
X-Gm-Message-State: AOAM530bIegkqoCRjRCagb6/bPZJylDiZJhfSYyT4aQfbhsUT5uvN1mm
        GY2mhPi9TE+0ey5JtCtD88ZHjQ==
X-Google-Smtp-Source: ABdhPJxB8nLngvmMpf3Pyv7Pfp2yrzRvcH3mr/M62gU4ciHkgNYxsRm3TMFyh056FAcIMRiQ1AiqqA==
X-Received: by 2002:a17:902:aa49:b029:d0:cbe1:e7b3 with SMTP id c9-20020a170902aa49b02900d0cbe1e7b3mr23073632plr.36.1600238749479;
        Tue, 15 Sep 2020 23:45:49 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id x3sm15458102pfq.49.2020.09.15.23.45.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:45:48 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/4] cpufreq: stats: Remove locking
Date:   Wed, 16 Sep 2020 12:15:29 +0530
Message-Id: <2b378277fe1acfd2567a3a639cc4d9b0292b99f7.1600238586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1600238586.git.viresh.kumar@linaro.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
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
index 3e7eee29ee86..314fa1d506d0 100644
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
 	WRITE_ONCE(stats->reset_pending, 0);
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

