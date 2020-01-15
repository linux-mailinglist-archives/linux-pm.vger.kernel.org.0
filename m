Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2C41513BD40
	for <lists+linux-pm@lfdr.de>; Wed, 15 Jan 2020 11:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgAOKUc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 Jan 2020 05:20:32 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37278 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbgAOKUb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 15 Jan 2020 05:20:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id w15so15181116wru.4
        for <linux-pm@vger.kernel.org>; Wed, 15 Jan 2020 02:20:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=3cRilsDs76jGrovYQZExnc/eKy0S8FlJfJBuDeunHFU=;
        b=Y9SrQ6pci2o89dG5fviHgoM47ni1sll2QE5Dm11rXWoAgbu+dTfYRC+SFcqKp84qee
         R1zybaPfUMz4epsA8yQcd7K8PtbMSvKikO2HHPgB99o8eViniPjgNHHFnCkF087jSvHw
         b3D0+G8s9xoetAjNi4AiLHnoQeO5IEM2vOqwe2IfA1l84SXh/G2+XiRFGplAnOq3Jr7a
         w+9sPsdEwgWFCzBG+md5Zl3tN+Dqu6fqWlU2eV/mfJ7vtk9dUCSEloObYMKRF11IOE9M
         JWfa280mixVBLpv/MIrBVUn/8MSrNa0B3NrqjNPrEFNznXaTweliiHuxmRk88Zzu77xk
         VUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=3cRilsDs76jGrovYQZExnc/eKy0S8FlJfJBuDeunHFU=;
        b=b7wGBzMcwNFx2SagcgAosEfmrV7GiNheJSSbnGR1mLMLQe0d+JakhtVdyCLtDRRDZU
         4p3zrIl83r2rgjFLt+c7DlQSd+ilD+LUNSRwCG73qazRDBWjqTbWo/CCGfjTAYizWAtC
         AJQ2Z8YMiO2BB5UP14tJ3NBRRe0LOLupi8NAqr52K0257p4rS4JqfWROpZJNSHsEL72D
         6K+V1IBs2EsFGLl9opnDj3Gog8O/+cQI0fJB1DkH62EryoV7p6JM+IQ8+kh11JWWo0TL
         hqenJa2zR/fsqmV3YcbJA1SB7gGfsYWtGw+INwBkmd4O8dWSS/hFdmo3zVaa7J8CNoi9
         SU/g==
X-Gm-Message-State: APjAAAW4aw8UCD3hmRKY4fAvkbeIqETKbAJ+0kpZUPO4B0eN4BZb/8qJ
        fjUfop2bYFC53VJa0y6fSBHAiw==
X-Google-Smtp-Source: APXvYqyLrSNjzSvJchLXd4GTfH7RH75LkIkuPITuFZkkr1mSKyL1QGzD9VY7fyjrYCpqZiAmVmZMGg==
X-Received: by 2002:adf:ff8a:: with SMTP id j10mr31002460wrr.312.1579083628600;
        Wed, 15 Jan 2020 02:20:28 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:d7b:8f95:a347:1d76])
        by smtp.gmail.com with ESMTPSA id t25sm22633935wmj.19.2020.01.15.02.20.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 15 Jan 2020 02:20:27 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: remove redundant call to cpufreq_update_util
Date:   Wed, 15 Jan 2020 11:20:20 +0100
Message-Id: <1579083620-24943-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

With commit bef69dd87828 ("sched/cpufreq: Move the cfs_rq_util_change() call to cpufreq_update_util()")
update_load_avg() has become the central point for calling cpufreq (not
including the update of blocked load). This change helps to simplify
further the number of call to cpufreq_update_util() and to remove last
redundant ones. With update_load_avg(), we are now sure that
cpufreq_update_util() will be called after every task attachment to a
cfs_rq and especially after propagating this event down to the util_avg of
the root cfs_rq, which is the level that is used by cpufreq governors like
schedutil to set the frequency of a CPU.

The SCHED_CPUFREQ_MIGRATION flag forces an early call to cpufreq when the
migration happens in a cgroup whereas util_avg of root cfs_rq is not yet
updated and this call is duplicated with the one that happens immediately
after when the migration event reaches the root cfs_rq. The dedicated flag
SCHED_CPUFREQ_MIGRATION is now useless and can be removed. The interface of
attach_entity_load_avg() can also be simplified accordingly.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/sched/cpufreq.h |  1 -
 kernel/sched/fair.c           | 14 +++++++-------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index cc6bcc1e96bc..3ed5aa18593f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -9,7 +9,6 @@
  */
 
 #define SCHED_CPUFREQ_IOWAIT	(1U << 0)
-#define SCHED_CPUFREQ_MIGRATION	(1U << 1)
 
 #ifdef CONFIG_CPU_FREQ
 struct cpufreq_policy;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2d170b5da0e3..023aa42aaac7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -801,7 +801,7 @@ void post_init_entity_util_avg(struct task_struct *p)
 		 * For !fair tasks do:
 		 *
 		update_cfs_rq_load_avg(now, cfs_rq);
-		attach_entity_load_avg(cfs_rq, se, 0);
+		attach_entity_load_avg(cfs_rq, se);
 		switched_from_fair(rq, p);
 		 *
 		 * such that the next switched_to_fair() has the
@@ -3114,7 +3114,7 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 {
 	struct rq *rq = rq_of(cfs_rq);
 
-	if (&rq->cfs == cfs_rq || (flags & SCHED_CPUFREQ_MIGRATION)) {
+	if (&rq->cfs == cfs_rq) {
 		/*
 		 * There are a few boundary cases this might miss but it should
 		 * get called often enough that that should (hopefully) not be
@@ -3520,7 +3520,7 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
  * Must call update_cfs_rq_load_avg() before this, since we rely on
  * cfs_rq->avg.last_update_time being current.
  */
-static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
+static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	u32 divider = LOAD_AVG_MAX - 1024 + cfs_rq->avg.period_contrib;
 
@@ -3556,7 +3556,7 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 
 	add_tg_cfs_propagate(cfs_rq, se->avg.load_sum);
 
-	cfs_rq_util_change(cfs_rq, flags);
+	cfs_rq_util_change(cfs_rq, 0);
 
 	trace_pelt_cfs_tp(cfs_rq);
 }
@@ -3614,7 +3614,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 		 *
 		 * IOW we're enqueueing a task on a new CPU.
 		 */
-		attach_entity_load_avg(cfs_rq, se, SCHED_CPUFREQ_MIGRATION);
+		attach_entity_load_avg(cfs_rq, se);
 		update_tg_load_avg(cfs_rq, 0);
 
 	} else if (decayed) {
@@ -3871,7 +3871,7 @@ static inline void update_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
 static inline void remove_entity_load_avg(struct sched_entity *se) {}
 
 static inline void
-attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags) {}
+attach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 static inline void
 detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) {}
 
@@ -10439,7 +10439,7 @@ static void attach_entity_cfs_rq(struct sched_entity *se)
 
 	/* Synchronize entity with its cfs_rq */
 	update_load_avg(cfs_rq, se, sched_feat(ATTACH_AGE_LOAD) ? 0 : SKIP_AGE_LOAD);
-	attach_entity_load_avg(cfs_rq, se, 0);
+	attach_entity_load_avg(cfs_rq, se);
 	update_tg_load_avg(cfs_rq, false);
 	propagate_entity_cfs_rq(se);
 }
-- 
2.7.4

