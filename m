Return-Path: <linux-pm+bounces-10346-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE969240AF
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9EC1F252E3
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6CF1BA084;
	Tue,  2 Jul 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i5nDx4WK"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431451BA081;
	Tue,  2 Jul 2024 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930298; cv=none; b=fWHSZCpRezjk8JLAds93eGCnOnr1pO8BHEXTz6gfJpPLmwKsK3fyDDFfGsZ62nHlkcx8mO9O/s6i1Ikaa845eSOTbaYuhMyfXPJDH0wDZI5MQoyj9GosFGjsBPIdBFXelJTtdOvtMxl5i6ww6A+07xnr1KpJSjJ2X73wnsV+Lns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930298; c=relaxed/simple;
	bh=KRo+VTADaqii3BC3HatcoVDFPzZKRCbP13qZos3qpj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnyyN0i0GAPClAsoliHHZ4PYVX+FVIFRSV/QTnLWJNzV8/aU/9kGOwU3Fs78W8hJOjz91DxElfNqZDOaDFFj3Pz9gwcZNFDqBF1HO/rlXBbAmn9pkLiWk99wAnM9mXbJXxFljpyL0G7pCH3KvS01JzVDvNv0iDQrLooX7R/Hzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i5nDx4WK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48483C116B1;
	Tue,  2 Jul 2024 14:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719930298;
	bh=KRo+VTADaqii3BC3HatcoVDFPzZKRCbP13qZos3qpj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5nDx4WKvXiMLVMGSn3hD/tjgepRUKlKl4we5q0ersHxOzNwwpYxmg6wpU4HJraV/
	 CjoudyhdpE4vT32jXK6meDNil+4pg78joCTUNJgghl4nJ6aBIedg8oCaYMtAbkJVDA
	 GiwKBeTiw9QgAOjXFRwLDRzdn1FcVVD1cZDCg39Kw3DKFPzsbsLRhaJ8BdyyA400HO
	 QRYSdZn5vO0Zyb0v08YwVtxp2v68dpAHuN7mDU6u7K/KB5QO2HWRtn5//Hc8eJfIZz
	 +NsXj8M1yuez9zbkvv+NOe5xFbaZsv3MRYokOQ/AHwll054DzjTn9qbjeEmpHwSvek
	 wRvyvH1te9lQg==
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
Subject: [PATCH v8] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date: Tue,  2 Jul 2024 23:24:54 +0900
Message-ID:  <171993029390.95379.9256588060965749271.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To:  <171993028355.95379.9391483220285994310.stgit@mhiramat.roam.corp.google.com>
References:  <171993028355.95379.9391483220285994310.stgit@mhiramat.roam.corp.google.com>
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
attribute of suspend_stats in sysfs so that user can use this time
stamp as a reference point of resuming user space.

On some system like the ChromeOS, the system suspend and resume are
controlled by a power management process. The user-space tasks will be
noticed the suspend and the resume signal from it.
To improve the suspend/resume performance and/or to find regressions,
we would like to know how long the resume processes are taken in kernel
and in user-space.
For this purpose, expose the accarate time when the kernel is finished
to resume so that we can distinguish the duration of kernel resume and
user space resume.

This suspend_stats attribute is easy to access and only expose the
timestamp in CLOCK_MONOTONIC. User can find the accarate time when the
kernel finished to resume its drivers/subsystems and start thawing, and
measure the elapsed time from the time when the kernel finished the
resume to a user-space action (e.g. displaying the UI).

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v8:
  - Update against the latest kernel.
  - Introduce dpm_save_success_time() to update last_succeess_resume_time.
 Changes in v7:
  - Update patch description.
  - Update sysfs documentation to say the exact timing.
  - Update the comment.
 Changes in v6:
  - Fix to record resume time before thawing user processes.
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
 Documentation/ABI/testing/sysfs-power |   11 +++++++++++
 kernel/power/main.c                   |   28 ++++++++++++++++++++++++++++
 kernel/power/power.h                  |    1 +
 kernel/power/suspend.c                |    1 +
 4 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-power b/Documentation/ABI/testing/sysfs-power
index a3942b1036e2..ee567e7e9d4a 100644
--- a/Documentation/ABI/testing/sysfs-power
+++ b/Documentation/ABI/testing/sysfs-power
@@ -442,6 +442,17 @@ Description:
 		'total_hw_sleep' and 'last_hw_sleep' may not be accurate.
 		This number is measured in microseconds.
 
+What:		/sys/power/suspend_stats/last_success_resume_time
+Date:		Dec 2023
+Contact:	Masami Hiramatsu <mhiramat@kernel.org>
+Description:
+		The /sys/power/suspend_stats/last_success_resume_time file
+		contains the timestamp of when the kernel successfully
+		resumed drivers/subsystems from suspend/hibernate. This is
+		just before thawing the user processes.
+		This floating point number is measured in seconds by monotonic
+		clock.
+
 What:		/sys/power/sync_on_suspend
 Date:		October 2019
 Contact:	Jonas Meurer <jonas@freesources.org>
diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..d9236bdab42a 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -16,6 +16,7 @@
 #include <linux/seq_file.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
+#include <linux/timekeeping.h>
 #include <linux/pm_runtime.h>
 
 #include "power.h"
@@ -321,6 +322,7 @@ struct suspend_stats {
 	u64 last_hw_sleep;
 	u64 total_hw_sleep;
 	u64 max_hw_sleep;
+	struct timespec64 last_success_resume_time;
 	enum suspend_stat_step failed_steps[REC_FAILED_NUM];
 };
 
@@ -361,6 +363,17 @@ void dpm_save_errno(int err)
 	suspend_stats.last_failed_errno %= REC_FAILED_NUM;
 }
 
+void dpm_save_success_time(int err)
+{
+	/*
+	 * Record last succeeded resume timestamp just before thawing processes.
+	 * This is for helping users to measure user-space resume performance
+	 * for improving their programs or finding regressions.
+	 */
+	if (!err)
+		ktime_get_ts64(&suspend_stats.last_success_resume_time);
+}
+
 void pm_report_hw_sleep_time(u64 t)
 {
 	suspend_stats.last_hw_sleep = t;
@@ -460,6 +473,17 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
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
@@ -477,6 +501,7 @@ static struct attribute *suspend_attrs[] = {
 	&last_hw_sleep.attr,
 	&total_hw_sleep.attr,
 	&max_hw_sleep.attr,
+	&last_success_resume_time.attr,
 	NULL,
 };
 
@@ -542,6 +567,9 @@ static int suspend_stats_show(struct seq_file *s, void *unused)
 		seq_printf(s, "\t\t\t%-s\n",
 			   suspend_step_names[suspend_stats.failed_steps[index]]);
 	}
+	seq_printf(s,	"last_success_resume_time:\t%-llu.%llu\n",
+		   (unsigned long long)suspend_stats.last_success_resume_time.tv_sec,
+		   (unsigned long long)suspend_stats.last_success_resume_time.tv_nsec);
 
 	return 0;
 }
diff --git a/kernel/power/power.h b/kernel/power/power.h
index de0e6b1077f2..70726a55a9d1 100644
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -348,3 +348,4 @@ static inline void pm_sleep_enable_secondary_cpus(void)
 }
 
 void dpm_save_errno(int err);
+void dpm_save_success_time(int err);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..1e561eb6681a 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -601,6 +601,7 @@ static int enter_state(suspend_state_t state)
  Finish:
 	events_check_enabled = false;
 	pm_pr_dbg("Finishing wakeup.\n");
+	dpm_save_success_time(error);
 	suspend_finish();
  Unlock:
 	mutex_unlock(&system_transition_mutex);


