Return-Path: <linux-pm+bounces-28180-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C6FACFC89
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 08:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E53189130A
	for <lists+linux-pm@lfdr.de>; Fri,  6 Jun 2025 06:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD611E32C6;
	Fri,  6 Jun 2025 06:25:27 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B4A1A275;
	Fri,  6 Jun 2025 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749191127; cv=none; b=naUitZDtN36Ds+xe+YGd8eYEH9Ns2kHFHQmmVsD91wvnzl+Z3SIR8t+zaXraNQ/Qklk2ppWGdH/JVwgUoe02wOk5jK0rKXrZwVcwAot5fP79YIpK4eyDY6pNvqF7zlRjMCSfPYSJP5S+8swAMPjTO+zdZag9ut1sl70jvOQM8MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749191127; c=relaxed/simple;
	bh=0LH66iRzEVsVMWZQ16gFXqlqRT/3q47LJ3MHGQz1594=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DstT/CG7RJQMIXyW+rP84PTZLSm/ZLnKW6E7o56EObZw7S78TQGCSVj55vzrXQtqpKilsiP3VVYWn5el0gvq3ihx9KiFWnDc5zLC+dNMoGaKsXmIRtb5R3x05bHWptYP30lI8AvKxV6MhzTBTmQWrr3DLqUVkXb88eWk1ZKhTr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 02d87ffe429f11f0b29709d653e92f7d-20250606
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:6b42408c-7026-429f-9e4d-3d0f5f2d21bc,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:a6a3df80516d00628685e0315a2f7149,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:nil,UR
	L:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 02d87ffe429f11f0b29709d653e92f7d-20250606
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <zhangzihuan@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 855462109; Fri, 06 Jun 2025 14:25:16 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id A9EBAE00891C;
	Fri,  6 Jun 2025 14:25:15 +0800 (CST)
X-ns-mid: postfix-684289CB-4926953
Received: from localhost.localdomain (unknown [172.25.120.24])
	by mail.kylinos.cn (NSMail) with ESMTPA id 5F529E008900;
	Fri,  6 Jun 2025 14:25:11 +0800 (CST)
From: Zihuan Zhang <zhangzihuan@kylinos.cn>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@kernel.org,
	kees@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Zihuan Zhang <zhangzihuan@kylinos.cn>
Subject: [RFC PATCH] PM: Optionally block user fork during freeze to improve performance
Date: Fri,  6 Jun 2025 14:25:02 +0800
Message-Id: <20250606062502.19607-1-zhangzihuan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently, the freezer traverses all tasks to freeze them during
system suspend or hibernation. If a user process forks during this
window, the new child may escape freezing and require a second
traversal or retry, adding non-trivial overhead.

This patch introduces a CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
option. When enabled, it prevents user processes from creating new
processes (via fork/clone) during the freezing period. This guarantees
a stable task list and avoids re-traversing the process list due to
late-created user tasks, thereby improving performance.

The restriction is only active during the window when the system is
freezing user tasks. Once all tasks are frozen, or if the system aborts
the suspend/hibernate process, the restriction is lifted.
No kernel threads are affected, and kernel_create_* functions remain
unrestricted.

Signed-off-by: Zihuan Zhang <zhangzihuan@kylinos.cn>
---
 include/linux/suspend.h |  8 ++++++++
 kernel/fork.c           |  6 ++++++
 kernel/power/Kconfig    | 10 ++++++++++
 kernel/power/main.c     | 44 +++++++++++++++++++++++++++++++++++++++++
 kernel/power/power.h    |  4 ++++
 kernel/power/process.c  |  7 +++++++
 6 files changed, 79 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index b1c76c8f2c82..2dd8b3eb50f0 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -591,4 +591,12 @@ enum suspend_stat_step {
 void dpm_save_failed_dev(const char *name);
 void dpm_save_failed_step(enum suspend_stat_step step);
=20
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+extern bool pm_block_user_fork;
+bool pm_should_block_fork(void);
+bool pm_freeze_process_in_progress(void);
+#else
+static inline bool pm_should_block_fork(void) { return false; };
+static inline bool pm_freeze_process_in_progress(void) { return false; }=
;
+#endif /* CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE */
 #endif /* _LINUX_SUSPEND_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 1ee8eb11f38b..b0bd0206b644 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -105,6 +105,7 @@
 #include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/tick.h>
+#include <linux/suspend.h>
=20
 #include <asm/pgalloc.h>
 #include <linux/uaccess.h>
@@ -2596,6 +2597,11 @@ pid_t kernel_clone(struct kernel_clone_args *args)
 			trace =3D 0;
 	}
=20
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+	if (pm_should_block_fork() && !(current->flags & PF_KTHREAD))
+		return -EBUSY;
+#endif
+
 	p =3D copy_process(NULL, trace, NUMA_NO_NODE, args);
 	add_latent_entropy();
=20
diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
index 54a623680019..d3d4d23b8f04 100644
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -375,6 +375,16 @@ config PM_GENERIC_DOMAINS_OF
 	def_bool y
 	depends on PM_GENERIC_DOMAINS && OF
=20
+config PM_DISABLE_USER_FORK_DURING_FREEZE
+	bool "Disable user fork during process freeze"
+	depends on PM
+	default n
+	help
+	If enabled, user space processes will be forbidden from creating
+	new tasks (via fork/clone) during the process freezing stage of
+	system suspend/hibernate.
+	This can avoid process list races and reduce retries during suspend.
+
 config CPU_PM
 	bool
=20
diff --git a/kernel/power/main.c b/kernel/power/main.c
index 3d484630505a..99f5689dc8ac 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -994,6 +994,47 @@ static ssize_t freeze_filesystems_store(struct kobje=
ct *kobj,
 power_attr(freeze_filesystems);
 #endif /* CONFIG_SUSPEND || CONFIG_HIBERNATION */
=20
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+bool strict_fork_enabled;
+bool pm_block_user_fork;
+
+bool pm_freeze_process_in_progress(void)
+{
+	return pm_block_user_fork;
+}
+
+bool pm_should_block_fork(void)
+{
+	return strict_fork_enabled && pm_freeze_process_in_progress();
+}
+EXPORT_SYMBOL_GPL(pm_should_block_fork);
+
+static ssize_t strict_fork_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", strict_fork_enabled);
+}
+
+static ssize_t strict_fork_store(struct kobject *kobj,
+				 struct kobj_attribute *attr,
+				 const char *buf, size_t n)
+{
+	unsigned long val;
+
+	if (kstrtoul(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > 1)
+		return -EINVAL;
+
+	strict_fork_enabled =3D !!val;
+	return n;
+}
+
+power_attr(strict_fork);
+
+#endif /* CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE */
+
 static struct attribute * g[] =3D {
 	&state_attr.attr,
 #ifdef CONFIG_PM_TRACE
@@ -1026,6 +1067,9 @@ static struct attribute * g[] =3D {
 #endif
 #if defined(CONFIG_SUSPEND) || defined(CONFIG_HIBERNATION)
 	&freeze_filesystems_attr.attr,
+#endif
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+	&strict_fork_attr.attr,
 #endif
 	NULL,
 };
diff --git a/kernel/power/power.h b/kernel/power/power.h
index cb1d71562002..45a52d7b899d 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -22,6 +22,10 @@ struct swsusp_info {
 extern bool filesystem_freeze_enabled;
 #endif
=20
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+extern bool strict_fork_enabled;
+#endif
+
 #ifdef CONFIG_HIBERNATION
 /* kernel/power/snapshot.c */
 extern void __init hibernate_reserved_size_init(void);
diff --git a/kernel/power/process.c b/kernel/power/process.c
index dc0dfc349f22..a6f7ba2d283d 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -134,7 +134,14 @@ int freeze_processes(void)
=20
 	pm_wakeup_clear(0);
 	pm_freezing =3D true;
+
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+	pm_block_user_fork =3D true;
+#endif
 	error =3D try_to_freeze_tasks(true);
+#ifdef CONFIG_PM_DISABLE_USER_FORK_DURING_FREEZE
+	pm_block_user_fork =3D false;
+#endif
 	if (!error)
 		__usermodehelper_set_disable_depth(UMH_DISABLED);
=20
--=20
2.25.1


