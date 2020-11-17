Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0164A2B5E67
	for <lists+linux-pm@lfdr.de>; Tue, 17 Nov 2020 12:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgKQLcQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 17 Nov 2020 06:32:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgKQLcP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Nov 2020 06:32:15 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7EEC0617A6
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 03:32:15 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so6570990pfb.9
        for <linux-pm@vger.kernel.org>; Tue, 17 Nov 2020 03:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiNLBAz3BX1KIFm2JNjthX8cwAVQmDEzefgF+x8ny1U=;
        b=vraFpE5FI22YwriZY/wUgYJ9/sksC+hGBQP35PmeDMFy89LeOkwLucbEk+63ax0FBq
         vF4PTSetvSbgHIz1RbiPiE9h8HHS4UXT+JwI/UI9Xupzx2ReVRHx1KrvRO6DseHhs98a
         o5bU+fzvXTOKKwCCzdZTiHZ4V2/N9CPW7cgDAY1gW+2czgUu03k41bvvOiHh6Stm1rSM
         9odQ8EtVUjWyC3gpgFTkAd02qfZ0DjXJ46ktjVRFRsmDD/Oq+LjaaSuxn5Yw03ZI5L6+
         gVSE0HMssZvtTdxGzKqYV2+0nwxBtczkWmVtaTn+qRlqQpu3IM/D8kesaYj74unXdpUF
         SY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xiNLBAz3BX1KIFm2JNjthX8cwAVQmDEzefgF+x8ny1U=;
        b=DJNSYlSeNVR3PtND5WbMU+BE1TyeJ++wf0gWAjB7jIPresOKKm6dkrdbrXjtBHpiCb
         otwHE/VbtoCqX8LBescHM+u8uNM6xBkMaWeikDl+z3myjCwjeN7aP1L3ALXpgvCLtbGl
         mmqa8tygMCrwYCwjNFoAt7H6GF6y/jTMFjb5LuWWQjhsFPXBWrbCEi9MSkivn/wDX2HZ
         dx5WGuI5lsVYnilRm8rUNB6Yv7a6iyKg6/q1zidntFyle1gPS6esLxDUa/ANnEMf2Ns/
         2a/jd0PffiTpG2PZ9b2qOgc4EGskcJ60ZRVXEfkVIb+zX+NV2OHGexzvipD+MK4atndH
         WTKA==
X-Gm-Message-State: AOAM532tTnBnDn7k6treXoscoAE0AbnR+/i9LeQ67VORnmWKc7Die6Ti
        DEOv6VU8e6vxCaQ0zbmRn2pTAh0kVOyVWA==
X-Google-Smtp-Source: ABdhPJyFC/WI2JO0kAdAFeaA4lNlodJdkTxwerz1QrDsM7ZTcad7JdlaaZ2b8T0pHigkkmojyGEXtA==
X-Received: by 2002:a63:f84d:: with SMTP id v13mr3129393pgj.234.1605612735131;
        Tue, 17 Nov 2020 03:32:15 -0800 (PST)
Received: from localhost ([122.172.12.172])
        by smtp.gmail.com with ESMTPSA id w131sm20732519pfd.14.2020.11.17.03.32.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Nov 2020 03:32:14 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        lukasz.luba@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: stats: Use local_clock() instead of jiffies
Date:   Tue, 17 Nov 2020 17:02:10 +0530
Message-Id: <d6d9193249832c54fdd29656558f48914a4015dd.1605612661.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

local_clock() has better precision and accuracy as compared to jiffies,
lets use it for time management in cpufreq stats.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V2:
- Doesn't change the units to msec and use local_clock() instead of
  ktime.

 drivers/cpufreq/cpufreq_stats.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 6cd5c8ab5d49..da717f7cd9a9 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -9,9 +9,9 @@
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/module.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 
-
 struct cpufreq_stats {
 	unsigned int total_trans;
 	unsigned long long last_time;
@@ -30,7 +30,7 @@ struct cpufreq_stats {
 static void cpufreq_stats_update(struct cpufreq_stats *stats,
 				 unsigned long long time)
 {
-	unsigned long long cur_time = get_jiffies_64();
+	unsigned long long cur_time = local_clock();
 
 	stats->time_in_state[stats->last_index] += cur_time - time;
 	stats->last_time = cur_time;
@@ -42,7 +42,7 @@ static void cpufreq_stats_reset_table(struct cpufreq_stats *stats)
 
 	memset(stats->time_in_state, 0, count * sizeof(u64));
 	memset(stats->trans_table, 0, count * count * sizeof(int));
-	stats->last_time = get_jiffies_64();
+	stats->last_time = local_clock();
 	stats->total_trans = 0;
 
 	/* Adjust for the time elapsed since reset was requested */
@@ -82,18 +82,18 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 				 * before the reset_pending read above.
 				 */
 				smp_rmb();
-				time = get_jiffies_64() - READ_ONCE(stats->reset_time);
+				time = local_clock() - READ_ONCE(stats->reset_time);
 			} else {
 				time = 0;
 			}
 		} else {
 			time = stats->time_in_state[i];
 			if (i == stats->last_index)
-				time += get_jiffies_64() - stats->last_time;
+				time += local_clock() - stats->last_time;
 		}
 
 		len += sprintf(buf + len, "%u %llu\n", stats->freq_table[i],
-			       jiffies_64_to_clock_t(time));
+			       nsec_to_clock_t(time));
 	}
 	return len;
 }
@@ -109,7 +109,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
 	 * Defer resetting of stats to cpufreq_stats_record_transition() to
 	 * avoid races.
 	 */
-	WRITE_ONCE(stats->reset_time, get_jiffies_64());
+	WRITE_ONCE(stats->reset_time, local_clock());
 	/*
 	 * The memory barrier below is to prevent the readers of reset_time from
 	 * seeing a stale or partially updated value.
@@ -249,7 +249,7 @@ void cpufreq_stats_create_table(struct cpufreq_policy *policy)
 			stats->freq_table[i++] = pos->frequency;
 
 	stats->state_num = i;
-	stats->last_time = get_jiffies_64();
+	stats->last_time = local_clock();
 	stats->last_index = freq_table_get_index(stats, policy->cur);
 
 	policy->stats = stats;
-- 
2.25.0.rc1.19.g042ed3e048af

