Return-Path: <linux-pm+bounces-34685-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A33BEB58220
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 18:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90C4E1892A0C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 16:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4095F27FD68;
	Mon, 15 Sep 2025 16:29:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5A279DA6;
	Mon, 15 Sep 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953796; cv=none; b=fcKoBX7NE98dQRO9RHcfm8qk4JVnnCMPGN4ZT7FEH7MA/iAFh4M/85vSo8LQ0jBmoACgc6gx0mLj+f6DxVkm2xTgHVExHEkm16ENnoCUIDt2TXwd+lOHgou1bsAhKOrFUmZXqh3iY5ohgrqUnZGfTEW2KzLJnmXo0CkeEWjRKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953796; c=relaxed/simple;
	bh=5M9RCTneYtynRUvLp/tn4DMaeBZgP/6Qm3emI5y9yus=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qw7ErIt4/0h0ofjGRWxRSsjT9X3dXyLHyjRicRx+W0rmwIZL4Xr0mkU9c4oyjj7Qz5aqM/NH0fEpWIkUizChelpKanfCezW2spKjJBXaUCIhOM715mihw+csINhwi/NC9J8CAbGOfHgmzqVosnzbYuCEPaAfJb1pMF3jmWsMu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w001.hihonor.com (unknown [10.68.25.235])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4cQVq546x0zYkxsl;
	Tue, 16 Sep 2025 00:29:21 +0800 (CST)
Received: from a018.hihonor.com (10.68.17.250) by w001.hihonor.com
 (10.68.25.235) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:29:51 +0800
Received: from localhost.localdomain (10.144.20.219) by a018.hihonor.com
 (10.68.17.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Sep
 2025 00:29:50 +0800
From: zhongjinji <zhongjinji@honor.com>
To: <mhocko@suse.com>
CC: <rientjes@google.com>, <shakeel.butt@linux.dev>,
	<akpm@linux-foundation.org>, <tglx@linutronix.de>, <liam.howlett@oracle.com>,
	<lorenzo.stoakes@oracle.com>, <surenb@google.com>, <lenb@kernel.org>,
	<rafael@kernel.org>, <pavel@kernel.org>, <linux-mm@kvack.org>,
	<linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulu.liu@honor.com>, <feng.han@honor.com>, <zhongjinji@honor.com>
Subject: [PATCH v10 1/2] mm/oom_kill: Thaw the entire OOM victim process
Date: Tue, 16 Sep 2025 00:29:45 +0800
Message-ID: <20250915162946.5515-2-zhongjinji@honor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250915162946.5515-1-zhongjinji@honor.com>
References: <20250915162946.5515-1-zhongjinji@honor.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: w003.hihonor.com (10.68.17.88) To a018.hihonor.com
 (10.68.17.250)

OOM killer is a mechanism that selects and kills processes when the system
runs out of memory to reclaim resources and keep the system stable. But the
oom victim cannot terminate on its own when it is frozen, even if the OOM
victim task is thawed through __thaw_task(). This is because __thaw_task() can
only thaw a single OOM victim thread, and cannot thaw the entire OOM victim
process.

In addition, freezing_slow_path() determines whether a task is an OOM victim
by checking the task’s TIF_MEMDIE flag. When a task is identified as an OOM
victim, the freezer bypasses both PM freezing and cgroup freezing states to
thaw it.

Historically, TIF_MEMDIE was a "this is the oom victim & it has access to
memory reserves" flag in the past. It has that thread vs. process problems
and tsk_is_oom_victim was introduced later to get rid of them and other
issues as well as the guarantee that we can identify the oom victim's mm
reliably for other oom_reaper.

Therefore, thaw_process() is introduced to unfreeze all threads within the
OOM victim process, ensuring that every thread is properly thawed. The freezer
now uses tsk_is_oom_victim() to determine OOM victim status, allowing all
victim threads to be unfrozen as necessary.

With this change, the entire OOM victim process will be thawed when an OOM
event occurs, ensuring that the victim can terminate on its own.

Signed-off-by: zhongjinji <zhongjinji@honor.com>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 include/linux/freezer.h |  2 ++
 kernel/freezer.c        | 20 +++++++++++++++++++-
 mm/oom_kill.c           | 10 +++++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index b303472255be..32884c9721e5 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -47,6 +47,7 @@ extern int freeze_processes(void);
 extern int freeze_kernel_threads(void);
 extern void thaw_processes(void);
 extern void thaw_kernel_threads(void);
+extern void thaw_process(struct task_struct *p);
 
 static inline bool try_to_freeze(void)
 {
@@ -80,6 +81,7 @@ static inline int freeze_processes(void) { return -ENOSYS; }
 static inline int freeze_kernel_threads(void) { return -ENOSYS; }
 static inline void thaw_processes(void) {}
 static inline void thaw_kernel_threads(void) {}
+static inline void thaw_process(struct task_struct *p) {}
 
 static inline bool try_to_freeze(void) { return false; }
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index 6a96149aede9..ddc11a8bd2ea 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 #include <linux/syscalls.h>
 #include <linux/freezer.h>
+#include <linux/oom.h>
 #include <linux/kthread.h>
 
 /* total number of freezing conditions in effect */
@@ -40,7 +41,7 @@ bool freezing_slow_path(struct task_struct *p)
 	if (p->flags & (PF_NOFREEZE | PF_SUSPEND_TASK))
 		return false;
 
-	if (test_tsk_thread_flag(p, TIF_MEMDIE))
+	if (tsk_is_oom_victim(p))
 		return false;
 
 	if (pm_nosig_freezing || cgroup_freezing(p))
@@ -206,6 +207,23 @@ void __thaw_task(struct task_struct *p)
 		wake_up_state(p, TASK_FROZEN);
 }
 
+/*
+ * thaw_process - Thaw a frozen process
+ * @p: the process to be thawed
+ *
+ * Iterate over all threads of @p and call __thaw_task() on each.
+ */
+void thaw_process(struct task_struct *p)
+{
+	struct task_struct *t;
+
+	rcu_read_lock();
+	for_each_thread(p, t) {
+		__thaw_task(t);
+	}
+	rcu_read_unlock();
+}
+
 /**
  * set_freezable - make %current freezable
  *
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 25923cfec9c6..88356b66cc35 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -772,12 +772,12 @@ static void mark_oom_victim(struct task_struct *tsk)
 		mmgrab(tsk->signal->oom_mm);
 
 	/*
-	 * Make sure that the task is woken up from uninterruptible sleep
-	 * if it is frozen because OOM killer wouldn't be able to free
-	 * any memory and livelock. freezing_slow_path will tell the freezer
-	 * that TIF_MEMDIE tasks should be ignored.
+	 * Make sure that the process is woken up from uninterruptible sleep
+	 * if it is frozen because OOM killer wouldn't be able to free any
+	 * memory and livelock. The freezer will thaw the tasks that are OOM
+	 * victims regardless of the PM freezing and cgroup freezing states.
 	 */
-	__thaw_task(tsk);
+	thaw_process(tsk);
 	atomic_inc(&oom_victims);
 	cred = get_task_cred(tsk);
 	trace_mark_victim(tsk, cred->uid.val);
-- 
2.17.1


