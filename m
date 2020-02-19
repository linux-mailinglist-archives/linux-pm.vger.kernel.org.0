Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0EB5164DB3
	for <lists+linux-pm@lfdr.de>; Wed, 19 Feb 2020 19:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgBSSci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 19 Feb 2020 13:32:38 -0500
Received: from mail-pj1-f74.google.com ([209.85.216.74]:55018 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgBSSch (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 19 Feb 2020 13:32:37 -0500
Received: by mail-pj1-f74.google.com with SMTP id a31so664738pje.4
        for <linux-pm@vger.kernel.org>; Wed, 19 Feb 2020 10:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=zFruNTKZBAM8RkLpTspdsuM2wT5ff3lBQN6EhMK/Qfs=;
        b=nZo1hfcm/opYasop1hhcJdvlI7Hd58D/ghHgn6ziaB7sOH5bRpIcqSxkKEAiSQBr2L
         rXeKmlDaDHIOo7qmdUez3nIJdpiOMWZ4F1Zk4kK2toKh0dyCr4BaYArxc1MQ7YNnr9Vt
         t6xNia7JOHOyr88t3SAudJtU/OaXuGX+FADLu2SDEcD6AIesqTXQuPuLtw+s4GVluJk6
         FV7f5eY6SbC+zRBGB2lUvUB/4pHwGjnvjaa+jklZ5S3qWgBel8XccGjLA2jpQqTIAuQ7
         UGxu7jfJ5Zpp7/FpQh/7h+7WMevcjeNEq5nNbzdnZhBFRStGiD6XNk2anBdaUo5Stdbz
         Pj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=zFruNTKZBAM8RkLpTspdsuM2wT5ff3lBQN6EhMK/Qfs=;
        b=LYwT45d+oIXLWuBFPmIlwQTY4yDE9sukwHBgBSaye20dE5/Y5a823f9QVwbBDA0D81
         2hKO+D9MExDssjY6rbkZenVOu0DNl/zjZXzvx2cPoipT7ZXsBEdUhBaEJ0iND6LjRkgm
         Hg2Ke+x38rz727IX0GceP64VshIvhw7qDtckpHeRj1G6nRSpcHfpqr9KymN6icEo+9wv
         dEPy7G5INpys6fUNSuPd7ZL3EWhjJ/uNCjCf98ATl2mzbqQChkAwI+gxDdHWlUfQ+YTD
         8DCdhtJtZ5JFNYdZDKY2/K8MVfvzWwZcY76+x+Bo1qcY9zS9HGtA8BTr9klCw2ImjkSO
         COTw==
X-Gm-Message-State: APjAAAVln8Z9lZtu5gW7/ZSTQgV2+RyljHvUflFSUQ6L3cEpu52n2bV6
        XDlaBvFHh+NrlYS4zFM0D8mYlC9l9Nk=
X-Google-Smtp-Source: APXvYqxhvcKVw/diJCynlqB2lru85+53G3ZpgZcqbCpYVEhha2J9sASo3WL4GOAjY/i8V+Vj8zO6KgdEM0A=
X-Received: by 2002:a65:67c5:: with SMTP id b5mr5600943pgs.138.1582137155236;
 Wed, 19 Feb 2020 10:32:35 -0800 (PST)
Date:   Wed, 19 Feb 2020 10:32:31 -0800
Message-Id: <20200219183231.50985-1-balejs@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
Subject: [PATCH] cgroup-v1: freezer: optionally killable freezer
From:   Marco Ballesio <balejs@google.com>
To:     tj@kernel.org, guro@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, corbet@lwn.net, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, minchan@google.com, surenb@google.com,
        dancol@google.com
Cc:     Marco Ballesio <balejs@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cgroup v2 freezer allows killing frozen processes without the need
to unfreeze them first. This is not possible with the v1 freezer, where
processes are to be unfrozen prior any pending kill signals to take effect.

Add a configurable option to allow killing frozen tasks in a way similar to
cgroups v2. Change the status of frozen tasks to TASK_INTERRUPTIBLE and reset
their PF_FROZEN flag on pending fatal signals.

Use the run-time configurable option freezer.killable to enable killability,
preserve the pre-existing behavior by default.

Signed-off-by: Marco Ballesio <balejs@google.com>
---
 .../cgroup-v1/freezer-subsystem.rst           | 12 ++++
 include/linux/freezer.h                       |  1 +
 kernel/cgroup/legacy_freezer.c                | 69 ++++++++++++++++++-
 kernel/freezer.c                              | 20 +++++-
 4 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
index 582d3427de3f..06485ae9dccd 100644
--- a/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
+++ b/Documentation/admin-guide/cgroup-v1/freezer-subsystem.rst
@@ -94,6 +94,18 @@ The following cgroupfs files are created by cgroup freezer.
   Shows the parent-state.  0 if none of the cgroup's ancestors is
   frozen; otherwise, 1.
 
+* freezer.killable: Read-write
+
+  When read, returns the killable state of a cgroup - "1" if frozen
+  tasks will respond to fatal signals, or "0" if they won't.
+
+  When written, this property sets the killable state of the cgroup.
+  A value equal to "1" will switch the state of all frozen tasks in
+  the cgroup to TASK_INTERRUPTIBLE (similarly to cgroup v2) and will
+  make them react to fatal signals. A value of "0" will switch the
+  state of frozen tasks to TASK_UNINTERRUPTIBLE and they won't respond
+  to signals unless thawed or unfrozen.
+
 The root cgroup is non-freezable and the above interface files don't
 exist.
 
diff --git a/include/linux/freezer.h b/include/linux/freezer.h
index 21f5aa0b217f..1443810ac2bf 100644
--- a/include/linux/freezer.h
+++ b/include/linux/freezer.h
@@ -72,6 +72,7 @@ extern bool set_freezable(void);
 
 #ifdef CONFIG_CGROUP_FREEZER
 extern bool cgroup_freezing(struct task_struct *task);
+extern bool cgroup_freezer_killable(struct task_struct *task);
 #else /* !CONFIG_CGROUP_FREEZER */
 static inline bool cgroup_freezing(struct task_struct *task)
 {
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 08236798d173..5bbc26c4b822 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -35,6 +35,7 @@ enum freezer_state_flags {
 	CGROUP_FREEZING_SELF	= (1 << 1), /* this freezer is freezing */
 	CGROUP_FREEZING_PARENT	= (1 << 2), /* the parent freezer is freezing */
 	CGROUP_FROZEN		= (1 << 3), /* this and its descendants frozen */
+	CGROUP_FREEZER_KILLABLE = (1 << 4), /* frozen pocesses can be killed */
 
 	/* mask for all FREEZING flags */
 	CGROUP_FREEZING		= CGROUP_FREEZING_SELF | CGROUP_FREEZING_PARENT,
@@ -73,6 +74,17 @@ bool cgroup_freezing(struct task_struct *task)
 	return ret;
 }
 
+bool cgroup_freezer_killable(struct task_struct *task)
+{
+	bool ret;
+
+	rcu_read_lock();
+	ret = task_freezer(task)->state & CGROUP_FREEZER_KILLABLE;
+	rcu_read_unlock();
+
+	return ret;
+}
+
 static const char *freezer_state_strs(unsigned int state)
 {
 	if (state & CGROUP_FROZEN)
@@ -111,9 +123,15 @@ static int freezer_css_online(struct cgroup_subsys_state *css)
 
 	freezer->state |= CGROUP_FREEZER_ONLINE;
 
-	if (parent && (parent->state & CGROUP_FREEZING)) {
-		freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
-		atomic_inc(&system_freezing_cnt);
+	if (parent) {
+		if (parent->state & CGROUP_FREEZER_KILLABLE)
+			freezer->state |= CGROUP_FREEZER_KILLABLE;
+
+		if (parent->state & CGROUP_FREEZING) {
+			freezer->state |= CGROUP_FREEZING_PARENT |
+					CGROUP_FROZEN;
+			atomic_inc(&system_freezing_cnt);
+		}
 	}
 
 	mutex_unlock(&freezer_mutex);
@@ -450,6 +468,45 @@ static u64 freezer_parent_freezing_read(struct cgroup_subsys_state *css,
 	return (bool)(freezer->state & CGROUP_FREEZING_PARENT);
 }
 
+static u64 freezer_killable_read(struct cgroup_subsys_state *css,
+				     struct cftype *cft)
+{
+	struct freezer *freezer = css_freezer(css);
+
+	return (bool)(freezer->state & CGROUP_FREEZER_KILLABLE);
+}
+
+static int freezer_killable_write(struct cgroup_subsys_state *css,
+				      struct cftype *cft, u64 val)
+{
+	struct freezer *freezer = css_freezer(css);
+
+	if (val > 1)
+		return -EINVAL;
+
+	mutex_lock(&freezer_mutex);
+
+	if (val == !!(freezer->state & CGROUP_FREEZER_KILLABLE))
+		goto out;
+
+	if (val)
+		freezer->state |= CGROUP_FREEZER_KILLABLE;
+	else
+		freezer->state &= ~CGROUP_FREEZER_KILLABLE;
+
+
+	/*
+	 * Let __refrigerator spin once for each task to set it into the
+	 * appropriate state.
+	 */
+	unfreeze_cgroup(freezer);
+
+out:
+	mutex_unlock(&freezer_mutex);
+
+	return 0;
+}
+
 static struct cftype files[] = {
 	{
 		.name = "state",
@@ -467,6 +524,12 @@ static struct cftype files[] = {
 		.flags = CFTYPE_NOT_ON_ROOT,
 		.read_u64 = freezer_parent_freezing_read,
 	},
+	{
+		.name = "killable",
+		.flags = CFTYPE_NOT_ON_ROOT,
+		.write_u64 = freezer_killable_write,
+		.read_u64 = freezer_killable_read,
+	},
 	{ }	/* terminate */
 };
 
diff --git a/kernel/freezer.c b/kernel/freezer.c
index dc520f01f99d..92de1bfe62cf 100644
--- a/kernel/freezer.c
+++ b/kernel/freezer.c
@@ -42,6 +42,9 @@ bool freezing_slow_path(struct task_struct *p)
 	if (test_tsk_thread_flag(p, TIF_MEMDIE))
 		return false;
 
+	if (cgroup_freezer_killable(p) && fatal_signal_pending(p))
+		return false;
+
 	if (pm_nosig_freezing || cgroup_freezing(p))
 		return true;
 
@@ -63,7 +66,12 @@ bool __refrigerator(bool check_kthr_stop)
 	pr_debug("%s entered refrigerator\n", current->comm);
 
 	for (;;) {
-		set_current_state(TASK_UNINTERRUPTIBLE);
+		bool killable = cgroup_freezer_killable(current);
+
+		if (killable)
+			set_current_state(TASK_INTERRUPTIBLE);
+		else
+			set_current_state(TASK_UNINTERRUPTIBLE);
 
 		spin_lock_irq(&freezer_lock);
 		current->flags |= PF_FROZEN;
@@ -75,6 +83,16 @@ bool __refrigerator(bool check_kthr_stop)
 		if (!(current->flags & PF_FROZEN))
 			break;
 		was_frozen = true;
+
+		/*
+		 * Now we're sure that there is no pending fatal signal.
+		 * Clear TIF_SIGPENDING to not get out of schedule()
+		 * immediately (if there is a non-fatal signal pending), and
+		 * put the task into sleep.
+		 */
+		if (killable)
+			clear_thread_flag(TIF_SIGPENDING);
+
 		schedule();
 	}
 
-- 
2.25.0.265.gbab2e86ba0-goog

