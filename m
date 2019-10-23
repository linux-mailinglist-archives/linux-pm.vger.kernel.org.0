Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E577E24D7
	for <lists+linux-pm@lfdr.de>; Wed, 23 Oct 2019 22:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405522AbfJWU4l (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Oct 2019 16:56:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37740 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405172AbfJWU4l (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Oct 2019 16:56:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id q130so176673wme.2;
        Wed, 23 Oct 2019 13:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=32v8K2RHKvWo9eMjAZ2zLlE2KejEYDR1L/fOwlpiWkU=;
        b=sNlbQcnr4Qcave2hUpGJBUHxgmyXmJgFUOM+7kuZ9Edt5XuTjDQ/L/c9t4SMrB1lnU
         335vBCfSgBd0z/iA42ZO7YkIPg+x0UVDXKi6ztAa8sNGzF080Z8c8su0upppYlsflTz2
         I6daSbVbf/fMsuxmUEgNWEyArKBWD45gNeNThKVgpBHV47ONPHJJ3/AG7CUzhbgSrZot
         LoxU9GDTe/P7kMeleltAFMrXTuBkqk+QwniV08/JmL3iON7nJYNxxGZFbR67TeoUGpbb
         FgmxD73umW8AX/RDTSNNXBB0S4PJJM26Riv8TIdnatnz+xW/OgzYVN7YSTg9T7WJ8/3y
         V4fQ==
X-Gm-Message-State: APjAAAXr9OJu9v7iNfGwwsXfC+gcp6mpNYnELtYFgkaA6+PIzmOMCB0D
        YzUJa2SiIlpcG4SbhRS5HzgJf/JCtM8BnVD8
X-Google-Smtp-Source: APXvYqx3/CV7TtgBkFCYKsLwC9Yvg+bNsX7rQNs1v1Im2R4whylc7FoGZ8LrNsu0JT58IAfGfzwGDg==
X-Received: by 2002:a1c:7e10:: with SMTP id z16mr1586651wmc.11.1571864199028;
        Wed, 23 Oct 2019 13:56:39 -0700 (PDT)
Received: from localhost ([109.70.119.5])
        by smtp.gmail.com with ESMTPSA id o18sm26164584wrm.11.2019.10.23.13.56.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Oct 2019 13:56:38 -0700 (PDT)
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Douglas Raillard <douglas.raillard@arm.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.com>
Subject: [PATCH v2] sched/fair: util_est: fast ramp-up EWMA on utilization increases
Date:   Wed, 23 Oct 2019 21:56:30 +0100
Message-Id: <20191023205630.14469-1-patrick.bellasi@matbug.net>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The estimated utilization for a task:

   util_est = max(util_avg, est.enqueue, est.ewma)

is defined based on:
 - util_avg: the PELT defined utilization
 - est.enqueued: the util_avg at the end of the last activation
 - est.ewma:     a exponential moving average on the est.enqueued
                 samples

According to this definition, when a task suddenly change its bandwidth
requirements from small to big, the EWMA will need to collect multiple
samples before converging up to track the new big utilization.

This slow convergence towards bigger utilization values is not
aligned to the default scheduler behavior, which is to optimize for
performance. Moreover, the est.ewma component fails to compensate for
temporarely utilization drops which spans just few est.enqueued samples.

To let util_est do a better job in the scenario depicted above, change
its definition by making util_est directly follow upward motion and
only decay the est.ewma on downward.

Signed-off-by: Patrick Bellasi <patrick.bellasi@matbug.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/fair.c     | 14 +++++++++++++-
 kernel/sched/features.h |  1 +
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a81c36472822..a14487462b6c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3768,11 +3768,22 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	if (ue.enqueued & UTIL_AVG_UNCHANGED)
 		return;
 
+	/*
+	 * Reset EWMA on utilization increases, the moving average is used only
+	 * to smooth utilization decreases.
+	 */
+	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
+	if (sched_feat(UTIL_EST_FASTUP)) {
+		if (ue.ewma < ue.enqueued) {
+			ue.ewma = ue.enqueued;
+			goto done;
+		}
+	}
+
 	/*
 	 * Skip update of task's estimated utilization when its EWMA is
 	 * already ~1% close to its last activation value.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
 	last_ewma_diff = ue.enqueued - ue.ewma;
 	if (within_margin(last_ewma_diff, (SCHED_CAPACITY_SCALE / 100)))
 		return;
@@ -3805,6 +3816,7 @@ util_est_dequeue(struct cfs_rq *cfs_rq, struct task_struct *p, bool task_sleep)
 	ue.ewma <<= UTIL_EST_WEIGHT_SHIFT;
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
+done:
 	WRITE_ONCE(p->se.avg.util_est, ue);
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 2410db5e9a35..7481cd96f391 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -89,3 +89,4 @@ SCHED_FEAT(WA_BIAS, true)
  * UtilEstimation. Use estimated CPU utilization.
  */
 SCHED_FEAT(UTIL_EST, true)
+SCHED_FEAT(UTIL_EST_FASTUP, true)
-- 
2.17.1

