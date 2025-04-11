Return-Path: <linux-pm+bounces-25270-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F349A861CA
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 17:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47AC2171A4F
	for <lists+linux-pm@lfdr.de>; Fri, 11 Apr 2025 15:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AB420E00A;
	Fri, 11 Apr 2025 15:27:29 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from alt2.a-painless.mh.aa.net.uk (alt2.a-painless.mh.aa.net.uk [81.187.30.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3D1F91F6;
	Fri, 11 Apr 2025 15:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.187.30.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744385249; cv=none; b=HQNNppIU6WWLAC4LmYohJaGzygrQ5NKvyL7EAmvXIC226LCqWgBu0m23ZIBTdG23vIQKkFoL4rBZI5Vp+EaLFde+prR/Pt9MB0QkDRGNAVMaB2lJ+LayLvfqb7Ig9e2Sy/21QYIToMSvlbhiQlo0pZF1+OL/dSCmntc/ymoZBac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744385249; c=relaxed/simple;
	bh=WpttMGEFACYtJqJnUwkPCWw+acWMM2hKAWZzdH4zkVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X9yvqDIFG8+5yPNTUZNTq4Ul7tYE4/h+J6FPAEBtxgOb3v+0nBLFU+j6YjS334ZEwOo9BVtEla7cGI/6awENJRF+vLkT8XXfw3sECJwfInxyAkAneysgyrKN01vIKu03u+cmP6ApVbvzWfUfD54AwAG2X8hpvZU1h+YtYxmtwH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org; spf=pass smtp.mailfrom=pileofstuff.org; arc=none smtp.client-ip=81.187.30.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pileofstuff.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pileofstuff.org
Received: from 5.d.5.f.e.3.5.0.9.5.6.b.1.c.c.2.0.5.8.0.9.1.8.0.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:819:850:2cc1:b659:53e:f5d5] helo=andrews-2024-laptop.lan)
	by painless-a.thn.aa.net.uk with esmtp (Exim 4.96)
	(envelope-from <kernel.org@pileofstuff.org>)
	id 1u3GHp-001I64-17;
	Fri, 11 Apr 2025 16:27:21 +0100
From: Andrew Sayers <kernel.org@pileofstuff.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>,
	Todd E Brandt <todd.e.brandt@linux.intel.com>
Cc: Andrew Sayers <kernel.org@pileofstuff.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] PM: Use two lines for "Restarting..." / "done" messages
Date: Fri, 11 Apr 2025 16:25:04 +0100
Message-ID: <20250411152632.2806038-1-kernel.org@pileofstuff.org>
X-Mailer: git-send-email 2.49.0
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

Change the messages to "<event>..." / "Done <event>.", unlike a449dfbfc089
which uses "<event>..." / "<event> completed.".  Front-loading the unique
part of the message makes it easier to scan the log, and reduces ambiguity
for users who aren't confident in their English comprehension.

Reviewed-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Andrew Sayers <kernel.org@pileofstuff.org>
---
v1 -> v2: mentioned a449dfbfc089 in commit message (thanks Lucas De Marchi)

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
index e2261f33a082..1555b51a7d55 100755
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
2.49.0


