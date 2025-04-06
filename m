Return-Path: <linux-pm+bounces-24855-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C181A7CFD5
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 20:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C5D188939F
	for <lists+linux-pm@lfdr.de>; Sun,  6 Apr 2025 18:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE5B1A5BAF;
	Sun,  6 Apr 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPoCD9OO"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CB51A5BAA
	for <linux-pm@vger.kernel.org>; Sun,  6 Apr 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743965908; cv=none; b=siDrQTeFUKDo8IJ9v5Oc/tsWExZO7aQomVEboisuqfIBtZANlUjR6BilBIO0OBN5kh91IoQlQvjYi1fOg+PR27kwHSt6Vh8MjFUIwf593O5fom8lW6yAJ/IPitcsLNzouiPOP8arThVkpREzT2YslfygSSxmMYRx+yXh5fQEhmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743965908; c=relaxed/simple;
	bh=SrTQ4lnExfcVBAPUvpG0KoCK7k3TVe7FjaH/+OBRulw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FS+5muY5cojxmBDPmPbH36KVJQ7pyCTRPPWvdbBidUF9iB8h+2WNLLqR2T0TLZT+zQzjb7lE9EKxP1MbAIRwR30yh1gh4Bc8+tdJRNu/LsP9FxsfcUyojcr7ieQqcbl4BRTKbhhwgU/imMSj4/VaRh0uzvpsMgx6f94s5H9iAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPoCD9OO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9299EC4CEE3;
	Sun,  6 Apr 2025 18:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743965908;
	bh=SrTQ4lnExfcVBAPUvpG0KoCK7k3TVe7FjaH/+OBRulw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To:From;
	b=nPoCD9OOWhZtB2snMMnr8ye/QdWm4rqkYkWZ6BuwET13CGsMUSZ4LE0fBXoceYjk/
	 BKveyMdc0UzB+JgiO2IOeYBbcVhd/Sy/MrIxzkEL0oEpKUDufxQDcyNX23VfFsDfJs
	 rHvbDg5ADGmw1TRSruTAgpqQv+iRPX1Td3L3uwupS8Mv0it/juwb7xY+mEihzXHicN
	 6PH9HxPs6vTvltCPWjD590lkX5SFPOCN2jxv5H+C7eDo9i/lHf98/sIvM1Olfaaz79
	 oUkUj9WgybmvBob1tE0MBftzTGnDtziArbIwQ6Ii20F1XBJUpYyS9ERRnLWltQdzk8
	 ZQ7PBJhdfw2og==
From: Len Brown <lenb@kernel.org>
To: linux-pm@vger.kernel.org
Cc: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 04/10] tools/power turbostat: Add idle governor statistics reporting
Date: Sun,  6 Apr 2025 14:57:13 -0400
Message-ID: <ed625c61b85c2333324dca43146c4ebabf8b236f.1743965272.git.len.brown@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
References: <1c7c7388e6c31f46b26a884d80b45efbad8237b2.1743965272.git.len.brown@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
Content-Transfer-Encoding: 8bit

From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>

The idle governor provides the following per-idle state sysfs files:
  * above - Indicates overshoots, where a more shallow state should have
            been requested (if avaliale and enabled).
  * below - Indicates undershoots, where a deeper state should have been
            requested (if available and enabled).

These files offer valuable insights into how effectively the Linux kernel
idle governor selects idle states for a given workload. This commit adds
support for these files in turbostat.

Expose the contents of these files with the following naming convention:
* C1: The number of times the C1 state was requested (existing counter).
* C1+: The number of times the idle governor selected C1, but a deeper
  idle state should have been selected instead.
* C1-: The number of times the idle governor selected C1, but a shallower
  idle state should have been selected instead.

Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 tools/power/x86/turbostat/turbostat.8 |  4 +++
 tools/power/x86/turbostat/turbostat.c | 48 ++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 8 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.8 b/tools/power/x86/turbostat/turbostat.8
index ed258f248152..52d727e29ea7 100644
--- a/tools/power/x86/turbostat/turbostat.8
+++ b/tools/power/x86/turbostat/turbostat.8
@@ -160,6 +160,10 @@ The system configuration dump (if --quiet is not used) is followed by statistics
 .PP
 \fBC1, C2, C3...\fP The number times Linux requested the C1, C2, C3 idle state during the measurement interval.  The system summary line shows the sum for all CPUs.  These are C-state names as exported in /sys/devices/system/cpu/cpu*/cpuidle/state*/name.  While their names are generic, their attributes are processor specific. They the system description section of output shows what MWAIT sub-states they are mapped to on each system.
 .PP
+\fBC1+, C2+, C3+...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a deeper idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/below file.
+.PP
+\fBC1-, C2-, C3-...\fP The idle governor idle state misprediction statistics. Inidcates the number times Linux requested the C1, C2, C3 idle state during the measurement interval, but should have requested a shallower idle state (if it exists and enabled). These statistics come from the /sys/devices/system/cpu/cpu*/cpuidle/state*/above file.
+.PP
 \fBC1%, C2%, C3%\fP The residency percentage that Linux requested C1, C2, C3....  The system summary is the average of all CPUs in the system.  Note that these are software, reflecting what was requested.  The hardware counters reflect what was actually achieved.
 .PP
 \fBCPU%c1, CPU%c3, CPU%c6, CPU%c7\fP show the percentage residency in hardware core idle states.  These numbers are from hardware residency counters.
diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index d3af2bf307e1..f29e47fe4249 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -10265,6 +10265,7 @@ void probe_sysfs(void)
 	char name_buf[16];
 	FILE *input;
 	int state;
+	int min_state = 1024, max_state = 0;
 	char *sp;
 
 	for (state = 10; state >= 0; --state) {
@@ -10296,6 +10297,11 @@ void probe_sysfs(void)
 			continue;
 
 		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_USEC, FORMAT_PERCENT, SYSFS_PERCPU, 0);
+
+		if (state > max_state)
+			max_state = state;
+		if (state < min_state)
+			min_state = state;
 	}
 
 	for (state = 10; state >= 0; --state) {
@@ -10306,26 +10312,52 @@ void probe_sysfs(void)
 			continue;
 		if (!fgets(name_buf, sizeof(name_buf), input))
 			err(1, "%s: failed to read file", path);
-		/* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
-		sp = strchr(name_buf, '-');
-		if (!sp)
-			sp = strchrnul(name_buf, '\n');
-		*sp = '\0';
 		fclose(input);
 
 		remove_underbar(name_buf);
 
-		sprintf(path, "cpuidle/state%d/usage", state);
-
 		if (!DO_BIC(BIC_sysfs) && !is_deferred_add(name_buf))
 			continue;
 
 		if (is_deferred_skip(name_buf))
 			continue;
 
+		/* truncate "C1-HSW\n" to "C1", or truncate "C1\n" to "C1" */
+		sp = strchr(name_buf, '-');
+		if (!sp)
+			sp = strchrnul(name_buf, '\n');
+
+		/*
+		 * The 'below' sysfs file always contains 0 for the deepest state (largest index),
+		 * do not add it.
+		 */
+		if (state != max_state) {
+			/*
+			 * Add 'C1+' for C1, and so on. The 'below' sysfs file always contains 0 for
+			 * the last state, so do not add it.
+			 */
+
+			*sp = '+';
+			*(sp + 1) = '\0';
+			sprintf(path, "cpuidle/state%d/below", state);
+			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		}
+
+		*sp = '\0';
+		sprintf(path, "cpuidle/state%d/usage", state);
 		add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
-	}
 
+		/*
+		 * The 'above' sysfs file always contains 0 for the shallowest state (smallest
+		 * index), do not add it.
+		 */
+		if (state != min_state) {
+			*sp = '-';
+			*(sp + 1) = '\0';
+			sprintf(path, "cpuidle/state%d/above", state);
+			add_counter(0, path, name_buf, 64, SCOPE_CPU, COUNTER_ITEMS, FORMAT_DELTA, SYSFS_PERCPU, 0);
+		}
+	}
 }
 
 /*
-- 
2.45.2


