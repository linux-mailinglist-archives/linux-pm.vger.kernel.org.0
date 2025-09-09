Return-Path: <linux-pm+bounces-34243-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B9B4AC60
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 13:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5489189567B
	for <lists+linux-pm@lfdr.de>; Tue,  9 Sep 2025 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51858321F5F;
	Tue,  9 Sep 2025 11:41:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta21.hihonor.com (mta21.honor.com [81.70.160.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1564B322A0B;
	Tue,  9 Sep 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.160.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757418101; cv=none; b=AWRgcu5Ko8FRGawrumG1mGIv8HlVl/EIkNIguhgMZNqLK0P760S2j9jv7gF/212XsdKbPQdGqPHhMT41tM7wZn7YB+KR9wA8lPBhrOJ8DKjnJT0tiFhsv5XcZe7o8NTygsmMgfUj04j8CYxpZwusWGArqdMmYViBoBhGbPBuTa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757418101; c=relaxed/simple;
	bh=C+uf5IBluj9YQrfhI/M2G92uJiB6N+3560JE03SQbwk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pKmekVBs0WCIxvVobKpzLn3beByZ9i7XttLeRDf0OKOQLG96ugwM9FfMh35TkV9ordpe0GyEc9+i5M5lqT1IsphilVjv4JcKHp6eJX6fudEm1QmsE/410BStaQgEWe+SUd556kxu2aH+/33DPm7F/plmo7yz7ZjMP7KoRs4EJXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.160.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w012.hihonor.com (unknown [10.68.27.189])
	by mta21.hihonor.com (SkyGuard) with ESMTPS id 4cLhjK61cwzYlVrN;
	Tue,  9 Sep 2025 19:41:09 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w012.hihonor.com
 (10.68.27.189) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 19:41:36 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Sep
 2025 19:41:35 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <akpm@linux-foundation.org>, <feng.han@honor.com>, <lenb@kernel.org>,
	<liam.howlett@oracle.com>, <linux-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-pm@vger.kernel.org>, <liulu.liu@honor.com>,
	<lorenzo.stoakes@oracle.com>, <pavel@kernel.org>, <rafael@kernel.org>,
	<rientjes@google.com>, <shakeel.butt@linux.dev>, <surenb@google.com>,
	<tglx@linutronix.de>, <zhongjinji@honor.com>
Subject: Re: [PATCH v8 1/3] mm/oom_kill: Introduce thaw_oom_process() for thawing OOM victims
Date: Tue, 9 Sep 2025 19:41:31 +0800
Message-ID: <20250909114131.13519-1-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <aL_wQkwBZ7uLM2ND@tiehlicka>
References: <aL_wQkwBZ7uLM2ND@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: w010.hihonor.com (10.68.28.113) To a018.hihonor.com
 (10.68.17.250)

> On Tue 09-09-25 17:06:57, zhongjinji wrote:
> > OOM killer is a mechanism that selects and kills processes when the system
> > runs out of memory to reclaim resources and keep the system stable.
> > However, the oom victim cannot terminate on its own when it is frozen,
> > because __thaw_task() only thaws one thread of the victim, while
> > the other threads remain in the frozen state.
> > 
> > Since __thaw_task did not fully thaw the OOM victim for self-termination,
> > introduce thaw_oom_process() to properly thaw OOM victims.
> 
> You will need s@thaw_oom_process@thaw_processes@

The reason for using thaw_oom_process is that the TIF_MEMDIE flag of the
thawed thread will be set, which means this function can only be used to
thaw processes terminated by the OOM killer.

thaw_processes has already been defined in kernel/power/process.c.
Would it be better to use thaw_process instead?

I am concerned that others might misunderstand the thaw_process function.
thaw_process sets all threads to the TIF_MEMDIE state, so it can only be
used to thaw processes killed by the OOM killer.

If the TIF_MEMDIE flag of a thread is not set, the thread cannot be thawed
regardless of the cgroup state. Should we add a function to set the TIF_MEMDIE
state for all threads, like the implementation below?

-/*
- * thaw_oom_process - thaw the OOM victim process
- * @p: process to be thawed
- *
- * Sets TIF_MEMDIE for all threads in the process group and thaws them.
- * Threads with TIF_MEMDIE are ignored by the freezer.
- */
-void thaw_oom_process(struct task_struct *p)
+void thaw_process(struct task_struct *p)
 {
        struct task_struct *t;

        rcu_read_lock();
        for_each_thread(p, t) {
-               set_tsk_thread_flag(t, TIF_MEMDIE);
                __thaw_task(t);
        }
        rcu_read_unlock();
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 52d285da5ba4..67b65b249757 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -753,6 +753,17 @@ static inline void queue_oom_reaper(struct task_struct *tsk)
 }
 #endif /* CONFIG_MMU */

+void mark_oom_victim_die(struct task_struct *p)
+{
+       struct task_struct *t;
+
+       rcu_read_lock();
+       for_each_thread(p, t) {
+               set_tsk_thread_flag(t, TIF_MEMDIE);
+       }
+       rcu_read_unlock();
+}
+
 /**
  * mark_oom_victim - mark the given task as OOM victim
  * @tsk: task to mark
@@ -782,7 +793,8 @@ static void mark_oom_victim(struct task_struct *tsk)
         * if it is frozen because OOM killer wouldn't be able to free
         * any memory and livelock.
         */
-       thaw_oom_process(tsk);
+       mark_oom_victim_die(tsk);
+       thaw_process(tsk);

> I would also add the caller in this patch.
>
> > Signed-off-by: zhongjinji <zhongjinji@honor.com>
> 
> Other than that looks good to me. With the above fixed feel free to add
> Acked-by: Michal Hocko <mhocko@suse.com>

