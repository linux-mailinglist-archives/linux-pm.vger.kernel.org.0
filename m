Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9AEF26BD76
	for <lists+linux-pm@lfdr.de>; Wed, 16 Sep 2020 08:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgIPGqE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Sep 2020 02:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbgIPGpx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Sep 2020 02:45:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B7FC06178A
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so2662771plt.9
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2020 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=McEf55q90LKX19rNTKkq9dZfRHRoQFlPTj7IjRPXpZk=;
        b=pv86wScJOEde8s9UC/74KhTAK9uJRxO43Wb7FdGsoH3TnuDTgoaCaNqNDjAVwRTtx/
         kidu/cjHQUNSr0xC0VzVnBZ7vqAYETM5LD0AScTJS6TvdBGmhulR8RjnItFwH8eFfV0M
         KwRU1TVHtyDI5XnOnzToeXbju9xjxkRc3Eth7s0LkrFFF/q6HsOsZPbYhqlfI2bWT3ec
         Zykx9TF4yv5sRm30HAs7H+w3Zg51/7on3JvJyimXGOBq+zerFIYkEmrGzHSZLu6nT1qL
         z7QBTzmi14cEr6MkJ57c0TcscE/iX7NsvoTia6w+Q0YKcf36EX+UUSGUmq4H+UJCdioL
         Ksfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=McEf55q90LKX19rNTKkq9dZfRHRoQFlPTj7IjRPXpZk=;
        b=ICfvPgFrsGtKIc7V2rebLmLQfxs1PmuMoTCSQFk6VWU2or+3c5/jK6a0+Z5XxDX5CH
         Bf5jFytAYmVMtoW/XQE3cKWUKR73mmV91pYOvocw5bF6/OVyRvrVveG5zxjfAiXLZAoc
         CamTGzWnG3VVjFdxUWt74uM9sXnbAE4ffCxP+u0CEyVmQTsokGylQ3Y9fIyQesjo9Msp
         7XYUnDnOWAqECKlk7mYP7vKnKF+FBtLy8eAlaAO+WSHveYAPQEWi4JPMAa/t9aXtTPwf
         U20nkuggBOMaR1cIQhAS7/m9UXuXNDe+qE1Bs9Vc6MDbyaxyEGWvW+iRtxh3T4XOAkD5
         yx4Q==
X-Gm-Message-State: AOAM530A+yfWqUEEM+si1ssyPwM/nwOVMqRjzTqoNc7ITHiA9KAJBby/
        um4Ffbip36rUlAlhznOKrdzqMw==
X-Google-Smtp-Source: ABdhPJwAJfZFG7omNOVziytcj6Q6FgpVIo7pPO6hbQwG7kQBV4JaLfoZt743eQVXAJYsxTrFpNERjg==
X-Received: by 2002:a17:902:e9d3:b029:d1:f370:1e90 with SMTP id 19-20020a170902e9d3b02900d1f3701e90mr157085plk.76.1600238752568;
        Tue, 15 Sep 2020 23:45:52 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id ml20sm1452102pjb.20.2020.09.15.23.45.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 23:45:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/4] cpufreq: stats: Enable stats for fast-switch as well
Date:   Wed, 16 Sep 2020 12:15:30 +0530
Message-Id: <c9dc39f9956ad9851511d6710e8f8a5cb142789e.1600238586.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1600238586.git.viresh.kumar@linaro.org>
References: <cover.1600238586.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Now that all the blockers are gone for enabling stats in fast-switching
case, enable it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c       | 6 +++++-
 drivers/cpufreq/cpufreq_stats.c | 6 ------
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 47aa90f9a7c2..d5fe64e96be9 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2057,8 +2057,12 @@ unsigned int cpufreq_driver_fast_switch(struct cpufreq_policy *policy,
 					unsigned int target_freq)
 {
 	target_freq = clamp_val(target_freq, policy->min, policy->max);
+	target_freq = cpufreq_driver->fast_switch(policy, target_freq);
 
-	return cpufreq_driver->fast_switch(policy, target_freq);
+	if (target_freq)
+		cpufreq_stats_record_transition(policy, target_freq);
+
+	return target_freq;
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_fast_switch);
 
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 314fa1d506d0..daea17f0c36c 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -69,9 +69,6 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	for (i = 0; i < stats->state_num; i++) {
 		if (pending) {
 			if (i == stats->last_index)
@@ -115,9 +112,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 	ssize_t len = 0;
 	int i, j, count;
 
-	if (policy->fast_switch_enabled)
-		return 0;
-
 	len += scnprintf(buf + len, PAGE_SIZE - len, "   From  :    To\n");
 	len += scnprintf(buf + len, PAGE_SIZE - len, "         : ");
 	for (i = 0; i < stats->state_num; i++) {
-- 
2.25.0.rc1.19.g042ed3e048af

