Return-Path: <linux-pm+bounces-255-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8A67F9DBE
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 11:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F28281408
	for <lists+linux-pm@lfdr.de>; Mon, 27 Nov 2023 10:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE026AA1;
	Mon, 27 Nov 2023 10:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdiSzZ8T"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7218C24
	for <linux-pm@vger.kernel.org>; Mon, 27 Nov 2023 10:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09490C433C8;
	Mon, 27 Nov 2023 10:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701081523;
	bh=Rj4mqiBm74uqQ7jupy3m57Hn64R7pf9jHFEyrduOPvg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LdiSzZ8T/tVzv0VHjvaO62Q1AdOv5V1EOpN+dXj2AXc28nsLfiCE6X/X8hpWFs2U4
	 yWSwch+0C5Ks81p1c+vknBDoLAgwOf4bJeEXtTXJH44BxiWIJuriub3jZPUSvlPyuz
	 LrqKszDDIKoZkOaXHK/k546cN9po2Iu8zGr9bwX46PfHrweCS4uoRp3asDznUOgRQa
	 UEnoqaP/eq2YnZ/lZX65OYCI2lr6KVfUd/tNou/FzAm2/h2oD8jJe6lkBnlPV6FGu7
	 ya/bAQ9kA8LjiLy/FE8I+m1PUVRxDoOBQS81qPsAgu89yNm6eIL0yR4pjjJtZ//0Jw
	 nKabny2rQMBDg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: suleiman@google.com,
	briannorris@google.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v5] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date: Mon, 27 Nov 2023 19:38:40 +0900
Message-ID:  <170108152012.780347.6355289232990337333.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To:  <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
References:  <170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu <mhiramat@kernel.org>

Expose last succeeded resumed timestamp as last_success_resume_time
attribute of suspend_stats in sysfs.

There are some printk()s for printing the similar resume timing to
dmesg, but those are recorded with local_clock(), and user can not
compare it with current time. We also have tracing events but it
requires CAP_SYS_ADMIN to use it.

This suspend_stats attribute is easy to access and only expose the
timestamp in CLOCK_MONOTONIC. So user can find the actual resumed
time and measure the elapsed time from the time when the kernel
finished the resume to the user-space action (e.g. display the UI).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v5:
  - Just updated for v6.7-rc3.
 Changes in v4.1:
  - Fix document typo (again).
 Changes in v4:
  - Update description to add why.
  - Fix document typo.
 Changes in v3:
  - Add (unsigned long long) casting for %llu.
  - Add a line after last_success_resume_time_show().
 Changes in v2:
  - Use %llu instead of %lu for printing u64 value.
  - Remove unneeded indent spaces from the last_success_resume_time
    line in the debugfs suspend_stat file.
---
 Documentation/ABI/testing/sysfs-power |   10 ++++++++++
 include/linux/suspend.h               |    2 ++
 kernel/power/main.c                   |   15 +++++++++++++++
 kernel/power/suspend.c                |    1 +
 4 files changed, 28 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index a3942b1036e2..e14975859766 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -442,6 +442,16 @@ Description:
 		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
 		This number is measured in microseconds.
 
+What:		/sys/power/suspend_stats/last_success_resume_time
+Date:		Oct 2023
+Contact:	Masami Hiramatsu <mhiramat@kernel.org>
+Description:
+		The /sys/power/suspend_stats/last_success_resume_time file
+		contains the timestamp of when the kernel successfully
+		resumed from suspend/hibernate.
+		This floating point number is measured in seconds by monotonic
+		clock.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index ef503088942d..ddd789044960 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -8,6 +8,7 @@
 #include <linux/pm.h>
 #include <linux/mm.h>
 #include <linux/freezer.h>
+#include <linux/timekeeping.h>
 #include <asm/errno.h>
 
 #ifdef CONFIG_VT
@@ -71,6 +72,7 @@ struct suspend_stats {
 	u64	last_hw_sleep;
 	u64	total_hw_sleep;
 	u64	max_hw_sleep;
+	struct timespec64 last_success_resume_time;
 	enum suspend_stat_step	failed_steps[REC_FAILED_NUM];
 };
 
diff --git a/kernel/power/main.c b/kernel/power/main.c
index f6425ae3e8b0..2ab23fd3daac 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -421,6 +421,17 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
+static ssize_t last_success_resume_time_show(struct kobject *kobj,
+		struct kobj_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%llu.%llu\n",
+		(unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
+		(unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
+}
+
+static struct kobj_attribute last_success_resume_time =
+			__ATTR_RO(last_success_resume_time);
+
 static struct attribute *suspend_attrs[] = {
 	&success.attr,
 	&fail.attr,
@@ -438,6 +449,7 @@ static struct attribute *suspend_attrs[] = {
 	&last_hw_sleep.attr,
 	&total_hw_sleep.attr,
 	&max_hw_sleep.attr,
+	&last_success_resume_time.attr,
 	NULL,
 };
 
@@ -514,6 +526,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
 			suspend_step_name(
 				suspend_stats.failed_steps[index]));
 	}
+	seq_printf(s,	"last_success_resume_time:\t%-llu.%llu\n",
+		   (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
+		   (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
 
 	return 0;
 }
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index fa3bf161d13f..33334565d5a6 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -622,6 +622,7 @@ int pm_suspend(suspend_state_t state)
 		dpm_save_failed_errno(error);
 	} else {
 		suspend_stats.success++;
+		ktime_get_ts64(&suspend_stats.last_success_resume_time);
 	}
 	pr_info("suspend exit\n");
 	return error;


