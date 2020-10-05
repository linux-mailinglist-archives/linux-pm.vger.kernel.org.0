Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307AA28312F
	for <lists+linux-pm@lfdr.de>; Mon,  5 Oct 2020 09:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgJEH4m (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Oct 2020 03:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgJEH4i (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2020 03:56:38 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E58C0613A6
        for <linux-pm@vger.kernel.org>; Mon,  5 Oct 2020 00:56:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id g10so3049788pfc.8
        for <linux-pm@vger.kernel.org>; Mon, 05 Oct 2020 00:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J4qdGO1JzbarEAt5kXWVquFeUU4w8XJCRXx1wssOX40=;
        b=glhwHwWoSPB7vbpkNltzCZuIRGmvdyF6aRXSvux7O0gh5RDnah9YJzBYE9y2Xx44M/
         zwHQJY+Fgh/LqIs5bqvnnxpiqx+pExQIHmT9Ll7y7kKqV3fxk+NcEsv3N9BSma9+eGWD
         o5wweXxZMJEBbpXKu2pV65Wxdz4yxYUEO69GSmfju/ZuaoSjSIcrjz+e4FJXifMSIgqH
         NaJ6vLSkY4c9IhJDFdQylXKYC+thaP7DlFZp24MQSrmulZs4IcJbkMdhLQF61BielJOS
         Uu6OnbbC2DfMp9xXIZtc+U3yAPJqZng/TqzzsONmA86UFq0l9i8i68hfRgzXA+eZz5SA
         TI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J4qdGO1JzbarEAt5kXWVquFeUU4w8XJCRXx1wssOX40=;
        b=Zfmz1d7IvDVgY1jCCgs0sJtup5atj5974lFr0oIVQOYzzzwr52kplPPl2gxoRJ1V7Z
         OAYTN9w4OrM/hQULvEFgP7t7PyJEz5eKKhHdMCCtwrBlLBX0V7WtZtcMP9cRScXGN/nt
         BSOFgGcCKXcr7yjj4mcz77i02B0R4wb1TAhWi/0+ccPJXlBdftmS491ZrpkydqTJXhpx
         sqp4hs4MroFkCIW26fgW/DsLzRqeLEF3LUaPHEaGJjsDWoT987xIhiYwXSW18VhtgDPM
         l8P0BsW8bB+I6RRZ+3vohefY1z32ImU6m3AGGI0ptG1iM1DfinIOEsd231hN4FtYPtla
         CXwQ==
X-Gm-Message-State: AOAM5323YqioWahIcfwpz/2tZEBsA02hUwhGy42XWrzTxxBkFnTiWcJz
        kISUOuyVMdvnllx3qmLQmNthwA==
X-Google-Smtp-Source: ABdhPJxAPv4l/65ZQQxBev3hTwT1tahpTGcKOaCmgb9omR+AFrSB6szG8y8TZQb+6Qc7oC6P5QWnqg==
X-Received: by 2002:a63:c547:: with SMTP id g7mr13254623pgd.234.1601884598314;
        Mon, 05 Oct 2020 00:56:38 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n8sm9215326pff.188.2020.10.05.00.56.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2020 00:56:37 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/5] cpufreq: stats: Remove locking
Date:   Mon,  5 Oct 2020 13:26:02 +0530
Message-Id: <d2dadb9656aa49a8ba1a5ddaf9ccab6c32383539.1601884370.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1601884370.git.viresh.kumar@linaro.org>
References: <cover.1601884370.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 498d962ba224..45a067855367 100644
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
 	cpufreq_stats_update(stats, READ_ONCE(stats->reset_time));
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

