Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 995CA25A6AA
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 09:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBHZm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 03:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727822AbgIBHZJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 03:25:09 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31120C061245
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 00:25:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f18so2350462pfa.10
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 00:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QakrURdUkg4E7FIP/CypxAR9NETwtzt47NN+BbaWNug=;
        b=RWPSGWqX08GKXFj5iHZkTa+y4XaDiqWxfL0yK70eGkiIQN/S+3ikTN0IFRwKKzRIyd
         Ej9S4ynaTJ8vNfXb1YWWnbA3UTwhzXnj0zsmh4prkdWZFzYo0tPp9PWLbx33SVHDDTaK
         hnL/GS/yLVwSq7nixL0qoJPEOxAbKkRI37eZTn//vbrdPQM5eIPVB67m4BQ5azV4JvmP
         /MP14dCT6xZe3lW9hFQJRu6dmVgpI2yqe1PBG9cLmX+jmK+RIMV/IXgNBQQ+SYJpcdRy
         h4a8vAsrw+ByO0Bi346aRy9Kkhcut78cS0bAtFECh5KYUSzsMjr5oQWOa1OXVY2fhD5t
         dcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QakrURdUkg4E7FIP/CypxAR9NETwtzt47NN+BbaWNug=;
        b=tV5bZpaKMS3BIanQvxPrNDxIDK+6SjEwoK67QFJCuZ5aEaRWQDe+RsIXfONk0iow0H
         EsYghrNDHbhyByRFZeV8XQAWAhLnmQ5xR0M2ScegRtRnVMfr2ch60dP8UWrWHmemRw/q
         L5iCYF0jfxQP/G0QCckYIvtHmDp4AVeND+81FAwFbMRQnRtdRPydCNVy6Q5qBlHKmVgc
         ZW9RStPJVwicbKMJK5FGMmVbjTWpN00aztV8qiemADBubvHpw2wobkWiCy6OHF6C6z7X
         YPLSt1PsJI1tK0QNH4bt57G9xPeTQQaGhYV9ddbViyXPddhgcuxwgnCZX6u/8CWaTIv/
         C0ZQ==
X-Gm-Message-State: AOAM5335eaDxW8vPwnrGC66p0slqpgeEYb1UyVE7BSCuPAa6ECdMDeSc
        58cwxqaVBNbwdZA1Dw9HxrcWKg==
X-Google-Smtp-Source: ABdhPJwYKPhGLgGgRTPpDmiSBrRJWDy3BvG7NKeo7XSr+SuLuefADDOnU7M/eyr65Jt0d2n9JeEtzw==
X-Received: by 2002:aa7:8646:: with SMTP id a6mr2054058pfo.54.1599031507740;
        Wed, 02 Sep 2020 00:25:07 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id k5sm3656831pjq.5.2020.09.02.00.25.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:25:07 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>, cristian.marussi@arm.com,
        sudeep.holla@arm.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] cpufreq: stats: Enable stats for fast-switch as well
Date:   Wed,  2 Sep 2020 12:54:43 +0530
Message-Id: <6a25f7c9c96dc25bb2acf26b4ab58ed954113965.1599031227.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.25.0.rc1.19.g042ed3e048af
In-Reply-To: <cover.1599031227.git.viresh.kumar@linaro.org>
References: <cover.1599031227.git.viresh.kumar@linaro.org>
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
index d86ea9744649..06b5ee12f3b2 100644
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

