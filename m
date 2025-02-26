Return-Path: <linux-pm+bounces-23026-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABDA46BC4
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5B918867C9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DEB25A655;
	Wed, 26 Feb 2025 19:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MGCvkUf9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MGCvkUf9"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1FC256C95
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599958; cv=none; b=VHaY67liVQ3Wkjs/qUeF1gef0YkdFeitmIj5oN0Cu9RPPulb9VnlBznMbvZeE8WNMkslSd61J2nq00OGTiHMNM+7M5bTiGto5FYvA1dQOLeKJb3OSeQ+mOkEP708EQML2AXQGK7cbP9CJUBEEBzt4ycsQ3kfy2LT9UPvvZ7UIZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599958; c=relaxed/simple;
	bh=yBYQ10xYqvupj3cLB6Z51JIzDI6B7P/SvNMp935zzWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZPxVmGaIl1LB3b/Bgj7mGA0KgfkmxnMEplvLqy7YIM6ZwFlM9Zo7y8kNzHS5haGwJ2KE7SgHJR+N/1R2upHkiey9jGt0MOlPrD6IbcZ4HDvI/FTubFBB0ttc7X5De4XYKR85BtRLASJhbQQKsMoLgZ5AcbXKAslfXU+WsxPvF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MGCvkUf9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MGCvkUf9; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 719DF1F387;
	Wed, 26 Feb 2025 19:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwO0/gaDg8J0sH8a6P82P5z42V5b4mLRLuPZ7KLgpvQ=;
	b=MGCvkUf9Qbsw/U7pv72/zu6zjQDtt5Ydf+v64PyGsUy4fEmghMNtDsMJQwg6b+4nyA6bv0
	oBXE6LMomLoHFX1OAXgseXXOQHIAQ2a34zi5dHYSanwd7Ux6WINkuWgpuKvnGdLS0ZeoHy
	cW25UDmxIhq0NzLwu7mTJjbuFK//W9Y=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=MGCvkUf9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599954; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JwO0/gaDg8J0sH8a6P82P5z42V5b4mLRLuPZ7KLgpvQ=;
	b=MGCvkUf9Qbsw/U7pv72/zu6zjQDtt5Ydf+v64PyGsUy4fEmghMNtDsMJQwg6b+4nyA6bv0
	oBXE6LMomLoHFX1OAXgseXXOQHIAQ2a34zi5dHYSanwd7Ux6WINkuWgpuKvnGdLS0ZeoHy
	cW25UDmxIhq0NzLwu7mTJjbuFK//W9Y=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0EAB13A53;
	Wed, 26 Feb 2025 19:59:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bW2ELZFyv2dLMgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:13 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 26 Feb 2025 16:59:01 -0300
Subject: [PATCH 1/5] printk: Rename suspend_console to console_suspend_all
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-printk-renaming-v1-1-0b878577f2e6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=4788;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=yBYQ10xYqvupj3cLB6Z51JIzDI6B7P/SvNMp935zzWg=;
 b=zrnT3yx0F2MoLtIJp2AhyC1iNzfy4fhxdeGTi2s5QJTPVqhMhNXC2FD35987w1tZZZQsH6OsE
 RHljdJwQpf5AJ/+2nwp0001WVLBTm8OYWbiGe1dbrE8QPqeFbnzoTQU
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Rspamd-Queue-Id: 719DF1F387
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL95jnbcaqr857snmuoeu7oxeq)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DKIM_TRACE(0.00)[suse.com:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

The function suspend_console has a misleading name, since it suspends all
consoles, so rename it accordly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h                                   | 2 +-
 kernel/kexec_core.c                                       | 2 +-
 kernel/power/hibernate.c                                  | 8 ++++----
 kernel/power/suspend.c                                    | 2 +-
 kernel/printk/printk.c                                    | 4 ++--
 tools/power/pm-graph/config/custom-timeline-functions.cfg | 2 +-
 tools/power/pm-graph/sleepgraph.py                        | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index eba367bf605d..fa5941f4f9c5 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -648,7 +648,7 @@ static inline void console_sysfs_notify(void)
 extern bool console_suspend_enabled;
 
 /* Suspend and resume console messages over PM events */
-extern void suspend_console(void);
+extern void console_suspend_all(void);
 extern void resume_console(void);
 
 int mda_console_init(void);
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index c0caa14880c3..8f95870030a3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1007,7 +1007,7 @@ int kernel_kexec(void)
 			error = -EBUSY;
 			goto Restore_console;
 		}
-		suspend_console();
+		console_suspend_all();
 		error = dpm_suspend_start(PMSG_FREEZE);
 		if (error)
 			goto Resume_console;
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 1f87aa01ba44..a18f6016ce6c 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -411,7 +411,7 @@ int hibernation_snapshot(int platform_mode)
 		goto Thaw;
 	}
 
-	suspend_console();
+	console_suspend_all();
 	pm_restrict_gfp_mask();
 
 	error = dpm_suspend(PMSG_FREEZE);
@@ -547,7 +547,7 @@ int hibernation_restore(int platform_mode)
 	int error;
 
 	pm_prepare_console();
-	suspend_console();
+	console_suspend_all();
 	pm_restrict_gfp_mask();
 	error = dpm_suspend_start(PMSG_QUIESCE);
 	if (!error) {
@@ -586,7 +586,7 @@ int hibernation_platform_enter(void)
 		goto Close;
 
 	entering_platform_hibernation = true;
-	suspend_console();
+	console_suspend_all();
 	error = dpm_suspend_start(PMSG_HIBERNATE);
 	if (error) {
 		if (hibernation_ops->recover)
@@ -896,7 +896,7 @@ int hibernate_quiet_exec(int (*func)(void *data), void *data)
 	if (error)
 		goto dpm_complete;
 
-	suspend_console();
+	console_suspend_all();
 
 	error = dpm_suspend(PMSG_FREEZE);
 	if (error)
diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 09f8397bae15..f296dd0a1a18 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -502,7 +502,7 @@ int suspend_devices_and_enter(suspend_state_t state)
 	if (error)
 		goto Close;
 
-	suspend_console();
+	console_suspend_all();
 	suspend_test_start();
 	error = dpm_suspend_start(PMSG_SUSPEND);
 	if (error) {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80910bc3470c..6cfb1e6d3613 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2733,11 +2733,11 @@ module_param_named(console_no_auto_verbose, printk_console_no_auto_verbose, bool
 MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to highest on oops/panic/etc");
 
 /**
- * suspend_console - suspend the console subsystem
+ * console_suspend_all - suspend the console subsystem
  *
  * This disables printk() while we go into suspend states
  */
-void suspend_console(void)
+void console_suspend_all(void)
 {
 	struct console *con;
 
diff --git a/tools/power/pm-graph/config/custom-timeline-functions.cfg b/tools/power/pm-graph/config/custom-timeline-functions.cfg
index 4f80ad7d7275..80ba55250163 100644
--- a/tools/power/pm-graph/config/custom-timeline-functions.cfg
+++ b/tools/power/pm-graph/config/custom-timeline-functions.cfg
@@ -122,7 +122,7 @@ freeze_processes:
 freeze_kernel_threads:
 pm_restrict_gfp_mask:
 acpi_suspend_begin:
-suspend_console:
+console_suspend_all:
 acpi_pm_prepare:
 syscore_suspend:
 arch_enable_nonboot_cpus_end:
diff --git a/tools/power/pm-graph/sleepgraph.py b/tools/power/pm-graph/sleepgraph.py
index 918eae58b0b4..114c3d0c6619 100755
--- a/tools/power/pm-graph/sleepgraph.py
+++ b/tools/power/pm-graph/sleepgraph.py
@@ -210,7 +210,7 @@ class SystemValues:
 		'hibernate_preallocate_memory': {},
 		'create_basic_memory_bitmaps': {},
 		'swsusp_write': {},
-		'suspend_console': {},
+		'console_suspend_all': {},
 		'acpi_pm_prepare': {},
 		'syscore_suspend': {},
 		'arch_enable_nonboot_cpus_end': {},

-- 
2.48.1


