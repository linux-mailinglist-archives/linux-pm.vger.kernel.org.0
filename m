Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F142F3236FB
	for <lists+linux-pm@lfdr.de>; Wed, 24 Feb 2021 06:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbhBXFoH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 24 Feb 2021 00:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbhBXFoG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 24 Feb 2021 00:44:06 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF7BC061574;
        Tue, 23 Feb 2021 21:43:26 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o22so2785733pjs.1;
        Tue, 23 Feb 2021 21:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeOAJg9FKeSFi8JUeRunyI4ewgAgU/gYkk0wbUE3MMo=;
        b=ENGKoPwmhF5aq64yBqBKs+Df45aecC5/KDF+0CGujsPtHOUQXy1VTk5llja8JYBaYe
         znSJeq2cBEwfRG2aADDw1RK+b6W/RuddFpVSXf79b1CSZLHZLOLyI2U6O7CiRkk9JQVi
         cGPXoDrcPcCBD1UtAPvVHOlsZ5PLX94221gxS2Muz1UNZ+8+/bzQi9iu/YMjkF+j4zoz
         IB9dj2xHnb3mMQZsr5eRUKOrkb93QqIH52ya9ni7cRmi0WtamtDhsAockVdxScWdS0DY
         7fQ8KBzS+ehVwzuf8dPMfSbHoKKkGg1EdzkZgm7mC/5bs8xYFqAjJaGSzyX3pTBT05f8
         Jv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EeOAJg9FKeSFi8JUeRunyI4ewgAgU/gYkk0wbUE3MMo=;
        b=Ud8Gl/fE9LIa55xuBLxbwAFh33hzqBQ3kkqbgP5sVW03MtLcD8maW9uuRIP2ohd0e5
         aOONCv5SQJeSaPE17bUmMMuRDdr6j6AVdu9DWQ3hhku/3XrORJacueayFdIkxopSpC/b
         aO/0Zp8er5t3a+09sUIqWtFfIUNQW8FuE24Y/zC4iJYEFpFe5GkJGuo+tfR5hoqc0WzU
         ALWD5IKYUMTkj+1W8bva7PDnhYnwiVLA7iYk7TLg5B/zcNDv9Cn91ByEaJDCnWjU+0YB
         SvQyhIs77jZA30Te1Ul0/GKYjGFL8AYr/6pKxK8eXZMTljAkRCkLbLrvR4diXHkS/QJ+
         YmAA==
X-Gm-Message-State: AOAM530mnH/TAPbXBzINjI1r7Jvw7n0tuYNi2D9Qhdfmx3EWjhRvpUd1
        UfDhhOVzhrXB/xWpLRfkap4=
X-Google-Smtp-Source: ABdhPJxv7hQd+dody8WrVrDzLEBnZCzzFNIPjcvVtwdIbfCtL9MhfWvPGh/5eZrL8TTyLk/PeMSY0w==
X-Received: by 2002:a17:902:8342:b029:e1:6aa:d770 with SMTP id z2-20020a1709028342b02900e106aad770mr30536878pln.27.1614145405757;
        Tue, 23 Feb 2021 21:43:25 -0800 (PST)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id h2sm835264pgd.32.2021.02.23.21.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 21:43:25 -0800 (PST)
From:   Yue Hu <zbestahu@gmail.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] cpufreq: schedutil: Call sugov_update_next_freq() before check to fast_switch_enabled
Date:   Wed, 24 Feb 2021 13:42:32 +0800
Message-Id: <20210224054232.1222-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Note that sugov_update_next_freq() may return false, that means the
caller sugov_fast_switch() will do nothing except fast switch check.

Similarly, sugov_deferred_update() also has unnecessary operations
of raw_spin_{lock,unlock} in sugov_update_single_freq() for that case.

So, let's call sugov_update_next_freq() before the fast switch check
to avoid unnecessary behaviors above. Update the related interface
definitions accordingly.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 kernel/sched/cpufreq_schedutil.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 41e498b..d23e5be 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -114,19 +114,13 @@ static bool sugov_update_next_freq(struct sugov_policy *sg_policy, u64 time,
 	return true;
 }
 
-static void sugov_fast_switch(struct sugov_policy *sg_policy, u64 time,
-			      unsigned int next_freq)
+static void sugov_fast_switch(struct sugov_policy *sg_policy, unsigned int next_freq)
 {
-	if (sugov_update_next_freq(sg_policy, time, next_freq))
-		cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
+	cpufreq_driver_fast_switch(sg_policy->policy, next_freq);
 }
 
-static void sugov_deferred_update(struct sugov_policy *sg_policy, u64 time,
-				  unsigned int next_freq)
+static void sugov_deferred_update(struct sugov_policy *sg_policy)
 {
-	if (!sugov_update_next_freq(sg_policy, time, next_freq))
-		return;
-
 	if (!sg_policy->work_in_progress) {
 		sg_policy->work_in_progress = true;
 		irq_work_queue(&sg_policy->irq_work);
@@ -368,16 +362,19 @@ static void sugov_update_single_freq(struct update_util_data *hook, u64 time,
 		sg_policy->cached_raw_freq = cached_freq;
 	}
 
+	if (!sugov_update_next_freq(sg_policy, time, next_f))
+		return;
+
 	/*
 	 * This code runs under rq->lock for the target CPU, so it won't run
 	 * concurrently on two different CPUs for the same target and it is not
 	 * necessary to acquire the lock in the fast switch case.
 	 */
 	if (sg_policy->policy->fast_switch_enabled) {
-		sugov_fast_switch(sg_policy, time, next_f);
+		sugov_fast_switch(sg_policy, next_f);
 	} else {
 		raw_spin_lock(&sg_policy->update_lock);
-		sugov_deferred_update(sg_policy, time, next_f);
+		sugov_deferred_update(sg_policy);
 		raw_spin_unlock(&sg_policy->update_lock);
 	}
 }
@@ -456,12 +453,15 @@ static unsigned int sugov_next_freq_shared(struct sugov_cpu *sg_cpu, u64 time)
 	if (sugov_should_update_freq(sg_policy, time)) {
 		next_f = sugov_next_freq_shared(sg_cpu, time);
 
+		if (!sugov_update_next_freq(sg_policy, time, next_f))
+			goto unlock;
+
 		if (sg_policy->policy->fast_switch_enabled)
-			sugov_fast_switch(sg_policy, time, next_f);
+			sugov_fast_switch(sg_policy, next_f);
 		else
-			sugov_deferred_update(sg_policy, time, next_f);
+			sugov_deferred_update(sg_policy);
 	}
-
+unlock:
 	raw_spin_unlock(&sg_policy->update_lock);
 }
 
-- 
1.9.1

