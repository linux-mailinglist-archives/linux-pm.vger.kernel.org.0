Return-Path: <linux-pm+bounces-10345-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4399240A2
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 16:25:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8F7CB260B1
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 14:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A9F1BA86C;
	Tue,  2 Jul 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iecGdUr6"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22CF1BA067;
	Tue,  2 Jul 2024 14:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930289; cv=none; b=sNsNFvVGQZ3fiUIkbIkHm6lfu+fk4n7S+Iuk3iP/O0OGbMIDuIaxOfNnDHmZVxvbRS/5qFDfgBIzVkNiqTx5CEPtXEB7x6i5AipsQYVNyCt/n+m3R7ZdUUgZ+KIbxYS0NuO/JRX2vME7U0ao/2Nd409o5aoX0q6J+2rtO4qz2d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930289; c=relaxed/simple;
	bh=g3/8sR4OH8c20K/Buo1WahFsemqahwgvChuPN8IsSII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XtFPaB64cMefBQ7FjXXxFS9lpJdNpXocdA88jGa/7qp4iJpRElcVEvi7m7NiDlt/r+BVpUERkYXdfrXIMebWJQ0VUXAG/rZDfc0U1NAj5QnU9QPSaeUCyRV+BV5q29Of7NEJ2CHD+XE89Ofc5uIKHH72hYBClae+pkOSyiDQePc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iecGdUr6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67B55C116B1;
	Tue,  2 Jul 2024 14:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719930288;
	bh=g3/8sR4OH8c20K/Buo1WahFsemqahwgvChuPN8IsSII=;
	h=From:To:Cc:Subject:Date:From;
	b=iecGdUr6T3xYlMFw8t+bEIVuqByJouOiYc5zdBcPvk7EVLnyiIe22T8OXWHnCvcFn
	 anxYOBDR59TmINLSxG095yMx2TxEhFuURdHNR76HRz3lZPmncuit42MPm2uHbzQoyB
	 3931ngOgN76QIUMRUvDoYEMVGg0VuS6UMqitymaL1mi5U2ilRPvIY7a16BZiF1ntZS
	 aUjKz1GXMy2SMxWeoN53UEIa7Hn58sUsUv1pmNsw3oIBvBimX/JfsGSQdvXAwoe/YC
	 ojLS01Fgaj6xCPaR7/w6ERl2juRhYcSmuzC5Pa6JrkCQQWyIXjYQ7fB5GDgdfBiSx/
	 F+2Ywy2oMlAcg==
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
Subject: [PATCH v8 0/1] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date: Tue,  2 Jul 2024 23:24:43 +0900
Message-ID:  <171993028355.95379.9391483220285994310.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Hi,

Here is the 8th version of the patch to expose last succeeded resumed
timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
The previous version is here.

https://lore.kernel.org/lkml/170359668692.1864392.6909734045167510522.stgit@mhiramat.roam.corp.google.com/

This version is just update against for the upstream kernel.


On some system like the ChromeOS, the system suspend and resume are
controlled by a power management process. The user-space tasks will be
noticed the suspend and the resume signal from it.
To improve the suspend/resume performance and/or to find regressions,
we would like to know how long the resume processes are taken in kernel
and in user-space.

This patch introduces a last succeeded resumed timestamp (just before
thawing processes) on sysfs which allows us to find when the kernel
resume process successfully done in MONOTONIC clock. Thus user processes
can measure the elapsed time taken by its resume process at any point
in time.

This will help us to detect abnormal value (longer time) process in
the resuming and quickly decide the root cause is in the kernel or
user-space. The kernel side we can use many tools (e.g. printk or
ftrace) but for user-space we need to define the starting point of
the resuming process. Actually, the kernel side needs to use local
clock because the clock subsystem is also suspended. But in that
case, user space can not use that timestamp because the local clock
is not exposed.

So this will be used something like

where_the_user_space_resume_finish() {
	clock_gettime(CLOCK_MONOTONIC, &etime_ts);
	fileread("/sys/.../last_success_resume_time", stime);
	convert_timespec(stime, &stime_ts);
	user_resume_time = timespec_delta(&etime_ts, &stime_ts);
	...
}

Thank you,

---

Masami Hiramatsu (1):
      PM: sleep: Expose last succeeded resumed timestamp in sysfs


 Documentation/ABI/testing/sysfs-power |   11 +++++++++++
 kernel/power/main.c                   |   28 ++++++++++++++++++++++++++++
 kernel/power/power.h                  |    1 +
 kernel/power/suspend.c                |    1 +
 4 files changed, 41 insertions(+)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

