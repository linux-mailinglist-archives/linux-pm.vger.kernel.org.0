Return-Path: <linux-pm+bounces-23843-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F78A5C1D2
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 14:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B93A6188CFD4
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 13:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AA41E493;
	Tue, 11 Mar 2025 13:03:10 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [81.187.30.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0F88836;
	Tue, 11 Mar 2025 13:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741698190; cv=none; b=BwfUCQCIoUobet8qC6DKXwTpL0Zz8FDzvVNwYlwaB9ZWqu2T8OpyS1AAxFztIktRjkp6vAKihvntlClCANR44QFuxzwNvBLp4wlriVXZH6gGcm+odE8dU+UtvWFH4T46VF5eMM7jly6dn6P+uIXPySIfq0F+UY5nrwPtNIq+6pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741698190; c=relaxed/simple;
	bh=O9TwnmR4AKXxhgiL3DZPmOcqYMRKkKpfdbXTiuRl3HA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbuwQ7q4s2blPoP8K6lI2c4gkIkklODK+Loz37bQEGRX4lGQHEywSoJ7ujmeoSrxv/VNkqy84SAsFgKBgD9/KUjj9vli6VwAJZzRRD+J0NumU22xIo4/A6b7vtZyL222+7937MYuIgmJdMHogjimxNC04i4Sowj6BRhFd5CasE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 0.9.9.0.0.0.0.0.0.0.0.0.0.0.0.0.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850::990] helo=andrews-2024-laptop.lan)
	by painless-b.tch.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1trzGC-0066tT-1n;
	Tue, 11 Mar 2025 13:03:04 +0000
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: Andrew Sayers <kernel.org@pileofstuff.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PM: Use two lines for "Restarting..." / "done" messages
Date: Tue, 11 Mar 2025 13:00:37 +0000
Message-ID: <20250311130204.216345-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other messages are occasionally printed between these two, for example:

    [203104.106534] Restarting tasks ...
    [203104.106559] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
    [203104.112354] done.

This seems to be a timing issue, seen in two of the eleven
hibernation exits in my current `dmesg` output.

When printed on its own, the "done" message has the default log level.
This makes the output of `dmesg --level=warn` quite misleading.

Add enough context for the "done" messages to make sense on their own,
and use the same log level for all messages.

Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---

I haven't been able to trigger "Restarting kernel threads" at all,
so can only prove the above occurs for "Restarting tasks".
But inspecting the code suggests it's possible, and it
seems more elegant for both pairs to look the same.

 kernel/power/process.c             | 8 ++++----
 tools/power/pm-graph/sleepgraph.py | 3 ++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/power/process.c b/kernel/power/process.c
index 66ac067d9ae6..4c674282df03 100644
--- a/kernel/power/process.c
+++ b/kernel/power/process.c
@@ -189,7 +189,7 @@ void thaw_processes(void)
 
 	oom_killer_enable();
 
-	pr_info("Restarting tasks ... ");
+	pr_info("Restarting tasks ...\n");
 
 	__usermodehelper_set_disable_depth(UMH_FREEZING);
 	thaw_workqueues();
@@ -208,7 +208,7 @@ void thaw_processes(void)
 	usermodehelper_enable();
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info("Done restarting tasks.\n");
 	trace_suspend_resume(TPS("thaw_processes"), 0, false);
 }
 
@@ -217,7 +217,7 @@ void thaw_kernel_threads(void)
 	struct task_struct *g, *p;
 
 	pm_nosig_freezing = false;
-	pr_info("Restarting kernel threads ... ");
+	pr_info("Restarting kernel threads ...\n");
 
 	thaw_workqueues();
 
@@ -229,5 +229,5 @@ void thaw_kernel_threads(void)
 	read_unlock(&tasklist_lock);
 
 	schedule();
-	pr_cont("done.\n");
+	pr_info("Done restarting kernel threads.\n");
 }
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 918eae58b0b4..b608c7b44b5d 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -4017,7 +4017,8 @@ def parseKernelLog(data):
 							'PM: early restore of devices complete after.*'],
 		'resume_complete': ['PM: resume of devices complete after.*',
 							'PM: restore of devices complete after.*'],
-		    'post_resume': [r'.*Restarting tasks \.\.\..*'],
+		    'post_resume': [r'.*Restarting tasks \.\.\..*',
+							'Done restarting tasks.*'],
 	}
 
 	# action table (expected events that occur and show up in dmesg)
-- 
2.47.2


