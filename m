Return-Path: <linux-pm+bounces-12573-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125C3958C54
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE5E3283665
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01B51BC9E7;
	Tue, 20 Aug 2024 16:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="H0X/u4lk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D2D1B8E9B
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171809; cv=none; b=QGUT8YvuuDjWZuY2scan61/JSwQgGnIOSK6t7gDkuwCZyWk8x2diYq1g4zJiOprlGpz9nKr+MtH49O8q0ZpIsv1ZpB4OSqjFmgDyKvTgRQtHKUVZGShiiKwoDH5RiWgLQvIuOdeizzwfnAGgmNSwS8BjvEi/xrPl2qMfJFZQZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171809; c=relaxed/simple;
	bh=GQPbKPJztlK6T882OcegVi96fmYLqoqnWFn1+Q/Iecs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ARR/WPpBtcp/Fy3mQkNEQO7bXIsTjtC3mTjWOuAU1D/UkS4sWItnQNczQFITi91bUPjgt6ISxXlVsuZhKGCfq9W8AS5sujhmThShdtiPp3oIvRtWaayT6owSYqXLEU7Tyuw8nkJO22BBI/iaqCSU+dJi60/co6tst8TFwAOl/JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=H0X/u4lk; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5bef4d9e7f8so3396822a12.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171806; x=1724776606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gs4Ks0Kkm98Csg47MQJPALx1GhqbRV6StE7nBUKSXR0=;
        b=H0X/u4lkYVxFQFnzat5w3riIAUl6WVHxxPByZomWAcSHNL+Ptim7h5zZhLrJV3CCx9
         amArqi5HN+roUdYPOTMBeL5bhMY7AIEJvdql9T4gYy/vL3HajjoFV1hh4wxInVuZQdOH
         VtM7oPIiEfB2R+DYHdaHwup+R0WFfFrtXODtyV1MbX/cbEARy5X2gXMLIP0Tzi1+zAzz
         BzkbYZFei4WSydr7Od7zo370kfNVvrIY+AiYwBv5Z6ZaLPVFFqtpt2P7PBOvOGM7G2oH
         CQ9e8wkYgph2Swc0WrTN7m0TLt+PP6waRY9AQQQcT2x+F26lpeB5aLQG7dezsNHHI36L
         KhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171806; x=1724776606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gs4Ks0Kkm98Csg47MQJPALx1GhqbRV6StE7nBUKSXR0=;
        b=BEPw0W0RCjPUaoADSF1mvHQmNN+xve3cL0fRNt7BjXk7qvMxNWfyKUs4pZWhbuLwwb
         9ZCxn4O9jIso8W+jshQp7BkykLwInqBB7aV0ufwcJbZjiRI0tPfyMAC6lVyI2rPvRZie
         x2VPmncB2JM9B9tNBXSyh1CfC9/KC7etrLFVYLl19MyBRjIfUapo8CHjztZ2e432WGX9
         7clLd5EjtqVFZzudkuFsRuurF3HAYF5HMc/AeKdM02jP8C2jaa9J4UtzXVNlvZ6cF4fC
         C2WeV/GPjcmT/ORF6Krtb4t6qVUTteTN0LzMQocgYijvnJPQya6AJZ6VruYZvhcMNRlH
         FHjQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvmQr67598CDiiq7+7wgEf5XexHtD/tsdvXu6izpfKU+ljqA7nMGRIgWHu0Lv9omwFNvxGpBZvUCDFv+BXdQ+hftKUKpfUZkY=
X-Gm-Message-State: AOJu0Yy/huBpdTMAkjt/BORPz0esTI3AphOvVoK5Jz7d0XPKGsMgv96u
	ZU4fKijgSQOqNaH789e5+TngyLFXE7mNigqQY4bNdmeSBRi2uKNV3cCqEyhQoyI=
X-Google-Smtp-Source: AGHT+IGwNTmVgxwt0g3+fIC/ibzEl8NcSRLlNxBxLL/CCcYzyggVVh9aXnQfRJ+/Pw7OoMUPFxuxmw==
X-Received: by 2002:a17:907:6d20:b0:a7d:2f42:db54 with SMTP id a640c23a62f3a-a8392a49851mr940380666b.65.1724171806188;
        Tue, 20 Aug 2024 09:36:46 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:45 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 09/16] sched/fair: util_est: Take into account periodic tasks
Date: Tue, 20 Aug 2024 17:35:05 +0100
Message-Id: <20240820163512.1096301-10-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new faster rampup is great for performance. But terrible for power.
We want the faster rampup to be only applied for tasks that are
transitioning from one periodic/steady state to another periodic/steady
state. But if they are stably periodic, then the faster rampup doesn't
make sense as util_avg describes their computational demand accurately
and we can rely on that to make accurate decision. And preserve the
power savings from being exact with the resources we give to this task
(ie: smaller DVFS headroom).

We detect periodic tasks based on util_avg across util_est_update()
calls. If it is rising, then the task is going through a transition.

We rely on util_avg being stable for periodic tasks with very little
variations around one stable point.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 include/linux/sched.h |  2 ++
 kernel/sched/core.c   |  2 ++
 kernel/sched/fair.c   | 17 ++++++++++++++---
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8db8f4085d84..2e8c5a9ffa76 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -829,6 +829,8 @@ struct task_struct {
 	struct uclamp_se		uclamp[UCLAMP_CNT];
 #endif
 
+	unsigned long			util_avg_dequeued;
+
 	struct sched_statistics         stats;
 
 #ifdef CONFIG_PREEMPT_NOTIFIERS
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e2b4b87ec2b7..c91e6a62c7ab 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4331,6 +4331,8 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.cfs_rq			= NULL;
 #endif
 
+	p->util_avg_dequeued		= 0;
+
 #ifdef CONFIG_SCHEDSTATS
 	/* Even if schedstat is disabled, there should not be garbage */
 	memset(&p->stats, 0, sizeof(p->stats));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a6421e4032c0..0c10e2afb52d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4832,6 +4832,11 @@ static inline unsigned long task_util(struct task_struct *p)
 	return READ_ONCE(p->se.avg.util_avg);
 }
 
+static inline unsigned long task_util_dequeued(struct task_struct *p)
+{
+	return READ_ONCE(p->util_avg_dequeued);
+}
+
 static inline unsigned long task_runnable(struct task_struct *p)
 {
 	return READ_ONCE(p->se.avg.runnable_avg);
@@ -4899,9 +4904,12 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * quickly to settle down to our new util_avg.
 	 */
 	if (!task_sleep) {
-		ewma &= ~UTIL_AVG_UNCHANGED;
-		ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
-		goto done;
+		if (task_util(p) > task_util_dequeued(p)) {
+			ewma &= ~UTIL_AVG_UNCHANGED;
+			ewma = approximate_util_avg(ewma, p->se.delta_exec / 1000);
+			goto done;
+		}
+		return;
 	}
 
 	/*
@@ -4914,6 +4922,9 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	/* Get utilization at dequeue */
 	dequeued = task_util(p);
 
+	if (!task_on_rq_migrating(p))
+		p->util_avg_dequeued = dequeued;
+
 	/*
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
-- 
2.34.1


