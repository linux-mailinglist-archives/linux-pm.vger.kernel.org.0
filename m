Return-Path: <linux-pm+bounces-23027-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D71BA46BC9
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D0516E341
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC1C25C719;
	Wed, 26 Feb 2025 19:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gHJfNanN";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gHJfNanN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90625C6F0
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599964; cv=none; b=bgw/j3XLDlX3V3UU08NLvuIDZimWY8f7xBzFrtVKJbU70NKeWAF3PNhpBb6nqOtzRX/B9IY8HFfPimQPWYIZKyBALcRejE05B+MGWrD7JKe4jrGikJLxQdTbMTFVrxgqXFu9rdHxg2K/drQ80kbnB0hGFGkanHwP2eOpJantxzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599964; c=relaxed/simple;
	bh=3mnkmbgrg6fvlcvRcHnS6RS4+e5nVoMg1rbp3WZ9G7k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=orR3cjdVPNZJ6Mr2xYYbq4SHIDIhdjVYO4X9wtqI5w3qtPJHa4rVmPdRMgGKIfvErRh5YNgIsY6+EcTIqZRxvCISNoyMDh1grwB2WJdjIl7uc7Qfw3kOfWUVrWYV6VN2ULLdvR5/yeiCBmsu58KXH1/QAlDc8k1Y0OKEw0BwkfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gHJfNanN; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gHJfNanN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3A6DF2119E;
	Wed, 26 Feb 2025 19:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hztst8rCope3yPsUAByJQrdEWrA738Z2BNiSTBEfhvg=;
	b=gHJfNanNPJP3h+Lf3chmY0WpPbVmRWlcpFMZbByp4s0josKGNeawbMeniIkTaRpaadAFKZ
	N/iXUQRKgKWzjFMzru4EH1xyrpO0/ARopQ7uFffY2P+MlsasDdBBZp7jbpjFpm+aokkG1F
	ITUeQsj0lhHqyH4SXnd7PZxrAok0ZS0=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hztst8rCope3yPsUAByJQrdEWrA738Z2BNiSTBEfhvg=;
	b=gHJfNanNPJP3h+Lf3chmY0WpPbVmRWlcpFMZbByp4s0josKGNeawbMeniIkTaRpaadAFKZ
	N/iXUQRKgKWzjFMzru4EH1xyrpO0/ARopQ7uFffY2P+MlsasDdBBZp7jbpjFpm+aokkG1F
	ITUeQsj0lhHqyH4SXnd7PZxrAok0ZS0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B996113A53;
	Wed, 26 Feb 2025 19:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Rjn+H5hyv2dUMgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:20 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 26 Feb 2025 16:59:03 -0300
Subject: [PATCH 3/5] printk: Rename console_stop to console_suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-printk-renaming-v1-3-0b878577f2e6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=2479;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=3mnkmbgrg6fvlcvRcHnS6RS4+e5nVoMg1rbp3WZ9G7k=;
 b=H/7BdSR/6yQobDX4aZH1XWsHy0Ldvwt4jJC4N5C8ZP9FzPgppEFsl9KC/P/8XwMv2JcTOCFVE
 44S9dI7kSk0DDjWP0Vza6VKVEAwh+2it5qfL1vHgeziHcGBCKAnIOwF
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLsew83exbyfiapi7twtunf83p)];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

The intent of console_stop was in fact to suspend it, so rename the
function accordly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 include/linux/console.h          | 2 +-
 kernel/printk/printk.c           | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 74fa02b23772..ff2499dbbb82 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2442,10 +2442,10 @@ int uart_suspend_port(struct uart_driver *drv, struct uart_port *uport)
 	}
 
 	/*
-	 * Disable the console device before suspending.
+	 * Suspend the console device before suspending the port.
 	 */
 	if (uart_console(uport))
-		console_stop(uport->cons);
+		console_suspend(uport->cons);
 
 	uart_change_pm(state, UART_PM_STATE_OFF);
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 0d48e0deb213..74587eeea3c7 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -633,7 +633,7 @@ extern void console_conditional_schedule(void);
 extern void console_unblank(void);
 extern void console_flush_on_panic(enum con_flush_mode mode);
 extern struct tty_driver *console_device(int *);
-extern void console_stop(struct console *);
+extern void console_suspend(struct console *);
 extern void console_start(struct console *);
 extern int is_console_locked(void);
 extern int braille_register_console(struct console *, int index,
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ef259660563a..c40b841c191b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3497,10 +3497,10 @@ struct tty_driver *console_device(int *index)
 
 /*
  * Prevent further output on the passed console device so that (for example)
- * serial drivers can disable console output before suspending a port, and can
+ * serial drivers can suspend console output before suspending a port, and can
  * re-enable output afterwards.
  */
-void console_stop(struct console *console)
+void console_suspend(struct console *console)
 {
 	__pr_flush(console, 1000, true);
 	console_list_lock();
@@ -3515,7 +3515,7 @@ void console_stop(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 }
-EXPORT_SYMBOL(console_stop);
+EXPORT_SYMBOL(console_suspend);
 
 void console_start(struct console *console)
 {

-- 
2.48.1


