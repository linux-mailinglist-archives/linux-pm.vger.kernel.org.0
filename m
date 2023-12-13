Return-Path: <linux-pm+bounces-1036-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21434810BA1
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 08:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE88D282953
	for <lists+linux-pm@lfdr.de>; Wed, 13 Dec 2023 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6D718E35;
	Wed, 13 Dec 2023 07:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMRQ5Iqx"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A08182D4
	for <linux-pm@vger.kernel.org>; Wed, 13 Dec 2023 07:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B061DC433C8;
	Wed, 13 Dec 2023 07:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702453170;
	bh=MrwMDA0p5hY5rMSLNC9Zaa/t5Tz7gjiSVAxMeg+6Sb8=;
	h=From:To:Cc:Subject:Date:From;
	b=dMRQ5Iqx4PXs6K2Q47pf59XzYjsXfJnNRhN8N5o383oM4fBQacN4vWebnmCE0TDvD
	 v5hgcZsvfyuWh2o83IUTB9PbulFPAKPQOYKM9nTpsSRkcXHAqrhXwVgI3YFFhFOshL
	 nDeNHjjn5IjIpnbq5/GvrXsBsJu3kWarJ/7oKva1MgKXpGmbRyTT7ZZbnxRYkNmeSN
	 4Cgl1RY/CMqkfdcdriRRFWoI/ofJ8EtfuzghImwqrKWJrwbzUVp3EMe9207nod8s2c
	 QV2th3u3ck+qetg2hdeyntf/ejq8i1XZ6eNNqPtufmGdyABmZSlEq4fizGb/K529gz
	 25ojSxIWFh9Rw==
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
Subject: [PATCH v6 0/1] PM: sleep: Expose last succeeded resumed timestamp in sysfs
Date: Wed, 13 Dec 2023 16:39:26 +0900
Message-ID:  <170245316678.651355.6640896026073025688.stgit@mhiramat.roam.corp.google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
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

Here is the 6th version of the patch to expose last succeeded resumed
timestamp in sysfs as /sys/power/suspend_stats/last_success_resume_time.
The previous version is here.

https://lore.kernel.org/all/170108151076.780347.2482745314490930894.stgit@mhiramat.roam.corp.google.com/

This version fixes the timestamp recording timing to right before thawing
user processes and is rebased on v6.7-rc5. 

This allows us to find when the kernel resume process successfully done
in the sysfs in MONOTONIC clock. Thus user processes can measure the
elapsed time taken by its resume process at any point in time.

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


 Documentation/ABI/testing/sysfs-power |   10 ++++++++++
 include/linux/suspend.h               |    2 ++
 kernel/power/main.c                   |   15 +++++++++++++++
 kernel/power/suspend.c                |    3 +++
 4 files changed, 30 insertions(+)

--
Masami Hiramatsu (Google) <mhiramat@kernel.org>

