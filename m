Return-Path: <linux-pm+bounces-23028-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6915CA46BCA
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230AD188CE1E
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920125D539;
	Wed, 26 Feb 2025 19:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qPwVt1Cc";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="qPwVt1Cc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9AC25C6F1
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599965; cv=none; b=U7nma3QEcsFRXde4oTHkIQ0wlSDYSTY1dnuGYCMmOxL8bUU/xqXdSJF1myFwYREMAc1eAkb5llkGLGDnV1RgFyIPTJixJqO+D6gN+sfJNGv7P8rcSVuZ9HmdOSJWq2fqShIPEzl6lo9kdjZDJLK8cCOqr/4DLMdIFoieYhp9Mdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599965; c=relaxed/simple;
	bh=o4dSv2Q4KBStBPNP7ZCwyp3Xj3sypPx1cqkkCUPu63k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbcAFjOyBwelkzRiOVyLfCTwao7Kjb//KXxJoNy39QSGtqol3fHcOkCbRD5MImKobvo/Dh7E0kiirdSaAvV0erVdppBWLQnLWgZ6/48K/KE/HW7xjGJN+QQizlvd0YRRUkJujHoX18fxEUJsyZMCmL6Fx/npaTRyPHQ+qC/X3eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qPwVt1Cc; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=qPwVt1Cc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CD89D1F38A;
	Wed, 26 Feb 2025 19:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u40wel1uByZ+NuxZjQ9Eq88cyevFevGwKfBlTGuYmDo=;
	b=qPwVt1Cc1fHH2nKJ8cMSNKZCYR1By1k9TyvRld0TI3KeJGKI8VldjC1kuB9+MsU+DAQ1QR
	nFgfd/t8ZMzNPLBY1iT2Hs5MQt/Vjs3Qtob6Ng5/OP6IKavzpORqtOE9Eyt9utVe7Rnqny
	o6To2KvLf/QIST3K6K1DqIjN3HD1ZTs=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599957; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u40wel1uByZ+NuxZjQ9Eq88cyevFevGwKfBlTGuYmDo=;
	b=qPwVt1Cc1fHH2nKJ8cMSNKZCYR1By1k9TyvRld0TI3KeJGKI8VldjC1kuB9+MsU+DAQ1QR
	nFgfd/t8ZMzNPLBY1iT2Hs5MQt/Vjs3Qtob6Ng5/OP6IKavzpORqtOE9Eyt9utVe7Rnqny
	o6To2KvLf/QIST3K6K1DqIjN3HD1ZTs=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58CB213A53;
	Wed, 26 Feb 2025 19:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4cFaCJVyv2dPMgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:17 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 26 Feb 2025 16:59:02 -0300
Subject: [PATCH 2/5] printk: Rename resume_console to console_resume_all
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-printk-renaming-v1-2-0b878577f2e6@suse.com>
References: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
In-Reply-To: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Eric Biederman <ebiederm@xmission.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>, 
 Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Todd E Brandt <todd.e.brandt@linux.intel.com>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, kexec@lists.infradead.org, 
 linux-pm@vger.kernel.org, linux-serial@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=5062;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=o4dSv2Q4KBStBPNP7ZCwyp3Xj3sypPx1cqkkCUPu63k=;
 b=eMPqNrB0UnFvEc27q5UbM6ptmyIqQUxeZ1y9TkP23XXXhdu3RbT7teaugAudqjEZZDtKG3DdZ
 1fnkdYMObgrBMG2Ucq75IhCtkaDgjnwlPypdFhWKFZWL7yZEQlSelfg
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

The function resume_console has a misleading name,  since it resumes all
consoles, so rename it accordly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h                                   | 2 +-
 kernel/kexec_core.c                                       | 2 +-
 kernel/power/hibernate.c                                  | 8 ++++----
 kernel/power/suspend.c                                    | 6 +++---
 kernel/printk/printk.c                                    | 2 +-
 tools/power/pm-graph/config/custom-timeline-functions.cfg | 2 +-
 tools/power/pm-graph/sleepgraph.py                        | 4 ++--
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index fa5941f4f9c5..0d48e0deb213 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -649,7 +649,7 @@ extern bool console_suspend_enabled;
 
 /* Suspend and resume console messages over PM events */
 extern void console_suspend_all(void);
-extern void resume_console(void);
+extern void console_resume_all(void);
 
 int mda_console_init(void);
 
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 8f95870030a3..6fcc46f3eb39 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1061,7 +1061,7 @@ int kernel_kexec(void)
  Resume_devices:
 		dpm_resume_end(PMSG_RESTORE);
  Resume_console:
-		resume_console();
+		console_resume_all();
 		thaw_processes();
  Restore_console:
 		pm_restore_console();
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a18f6016ce6c..c9f60670a261 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -437,7 +437,7 @@ int hibernation_snapshot(int platform_mode)
 	if (error || !in_suspend)
 		pm_restore_gfp_mask();
 
-	resume_console();
+	console_resume_all();
 	dpm_complete(msg);
 
  Close:
@@ -561,7 +561,7 @@ int hibernation_restore(int platform_mode)
 	}
 	dpm_resume_end(PMSG_RECOVER);
 	pm_restore_gfp_mask();
-	resume_console();
+	console_resume_all();
 	pm_restore_console();
 	return error;
 }
@@ -634,7 +634,7 @@ int hibernation_platform_enter(void)
  Resume_devices:
 	entering_platform_hibernation = false;
 	dpm_resume_end(PMSG_RESTORE);
-	resume_console();
+	console_resume_all();
 
  Close:
 	hibernation_ops->end();
@@ -920,7 +920,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 dpm_resume:
 	dpm_resume(PMSG_THAW);
 
-	resume_console();
+	console_resume_all();
 
 dpm_complete:
 	dpm_complete(PMSG_THAW);
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index f296dd0a1a18..c3da3db58cdf 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -521,9 +521,9 @@ int suspend_devices_and_enter(suspend_state_t state)
 	suspend_test_start();
 	dpm_resume_end(PMSG_RESUME);
 	suspend_test_finish("resume devices");
-	trace_suspend_resume(TPS("resume_console"), state, true);
-	resume_console();
-	trace_suspend_resume(TPS("resume_console"), state, false);
+	trace_suspend_resume(TPS("console_resume_all"), state, true);
+	console_resume_all();
+	trace_suspend_resume(TPS("console_resume_all"), state, false);
 
  Close:
 	platform_resume_end(state);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6cfb1e6d3613..ef259660563a 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2760,7 +2760,7 @@ void console_suspend_all(void)
 	synchronize_srcu(&console_srcu);
 }
 
-void resume_console(void)
+void console_resume_all(void)
 {
 	struct console_flush_type ft;
 	struct console *con;
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 80ba55250163..0321b59518f3 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -128,7 +128,7 @@ syscore_suspend:
 arch_enable_nonboot_cpus_end:
 syscore_resume:
 acpi_pm_finish:
-resume_console:
+console_resume_all:
 acpi_pm_end:
 pm_restore_gfp_mask:
 thaw_processes:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 114c3d0c6619..e2261f33a082 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -216,7 +216,7 @@ class SystemValues:
 		'arch_enable_nonboot_cpus_end': {},
 		'syscore_resume': {},
 		'acpi_pm_finish': {},
-		'resume_console': {},
+		'console_resume_all': {},
 		'acpi_pm_end': {},
 		'pm_restore_gfp_mask': {},
 		'thaw_processes': {},
@@ -3459,7 +3459,7 @@ def parseTraceLog(live=False):
 	tracewatch = ['irq_wakeup']
 	if sysvals.usekprobes:
 		tracewatch += ['sync_filesystems', 'freeze_processes', 'syscore_suspend',
-			'syscore_resume', 'resume_console', 'thaw_processes', 'CPU_ON',
+			'syscore_resume', 'console_resume_all', 'thaw_processes', 'CPU_ON',
 			'CPU_OFF', 'acpi_suspend']
 
 	# extract the callgraph and traceevent data

-- 
2.48.1


