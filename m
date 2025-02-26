Return-Path: <linux-pm+bounces-23030-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B70F9A46BD3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9509C3B217B
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E33BE25EFBF;
	Wed, 26 Feb 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jBpRUffi";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jBpRUffi"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B33625E47A
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 19:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599972; cv=none; b=pOVTCSSPZlq7V0XHrgG2TyzFxvnj/BFddGxSIuCV4+qR1i0DIaQuUQD3gXrH44ae0AmqH8g+Z1XkzE3lSxYJxWusD35uTsx1HwAs6u/OZ7BtdTt6QXuHvsiEP8iw2bWz0Imo8u8TzZUYIt6YXb8Na2KYHotZr3EqJWAX3EV4NQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599972; c=relaxed/simple;
	bh=w5VO+oRXeQA2tzKp+Ki2raOgvFvjyAZ7O1+whc7zoyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NQWPIt06qXKJyMCXgRwPsZl5m19jr9xSbleT9NHOfhHZP9l4f7TWLe80q+vkzAefC6ks7PJFtQN8EKiQ5zbmBkLNU509+Msy22bmv15gTmQTTjCgrFbLAguGk1DWKNnD8+/F9xv7rdlE3IZz/aDPAUJmNIwro2F2ygYq9pXTmq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jBpRUffi; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jBpRUffi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A61571F38F;
	Wed, 26 Feb 2025 19:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9hLbnXassT/V3Jk+YjNRU+hmDwAv67Hc8h4w4noxGs=;
	b=jBpRUffiOvKnLry2cBIvbx9HTN0o/PyoenfX1kefKCc0OKoYvpEeYpPQqqISOWV3GdJL6j
	Urx6UAY4LpmcvqHbsp0YcvKP6VqeR8d4Mu8t4OShro4QkXpWeDlIiIafeTL6WhBlcdMPDE
	/cqY4U0kNHRRRvcgAV3OTAdiAUXNplc=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q9hLbnXassT/V3Jk+YjNRU+hmDwAv67Hc8h4w4noxGs=;
	b=jBpRUffiOvKnLry2cBIvbx9HTN0o/PyoenfX1kefKCc0OKoYvpEeYpPQqqISOWV3GdJL6j
	Urx6UAY4LpmcvqHbsp0YcvKP6VqeR8d4Mu8t4OShro4QkXpWeDlIiIafeTL6WhBlcdMPDE
	/cqY4U0kNHRRRvcgAV3OTAdiAUXNplc=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26F5F13A53;
	Wed, 26 Feb 2025 19:59:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0rDON5tyv2dXMgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:23 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 26 Feb 2025 16:59:04 -0300
Subject: [PATCH 4/5] printk: Rename console_start to console_resume
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-printk-renaming-v1-4-0b878577f2e6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=2165;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=w5VO+oRXeQA2tzKp+Ki2raOgvFvjyAZ7O1+whc7zoyo=;
 b=zWXJBssCbR3hm4WbbynsGLrujAmM12datM6pdRySPk16/u4JYX2jMFr1TuPsxZT7Ddfm2z/Et
 sQNm9u9T93zBWRkWP+NORyKRquNYPSX00PeGqXq/z9DdR0JdmmpzTko
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

The intent of console_start was to resume a previosly suspended console,
so rename it accordly.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/serial/serial_core.c | 2 +-
 include/linux/console.h          | 2 +-
 kernel/printk/printk.c           | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index ff2499dbbb82..4e6bbbeeb2bf 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2500,7 +2500,7 @@ int uart_resume_port(struct uart_driver *drv, struct uart_port *uport)
 			uart_port_unlock_irq(uport);
 		}
 		if (console_suspend_enabled)
-			console_start(uport->cons);
+			console_resume(uport->cons);
 	}
 
 	if (tty_port_suspended(port)) {
diff --git a/include/linux/console.h b/include/linux/console.h
index 74587eeea3c7..8f10d0a85bb4 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -634,7 +634,7 @@ extern void console_unblank(void);
 extern void console_flush_on_panic(enum con_flush_mode mode);
 extern struct tty_driver *console_device(int *);
 extern void console_suspend(struct console *);
-extern void console_start(struct console *);
+extern void console_resume(struct console *);
 extern int is_console_locked(void);
 extern int braille_register_console(struct console *, int index,
 		char *console_options, char *braille_options);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index c40b841c191b..fbbaec06c9f3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3517,7 +3517,7 @@ void console_suspend(struct console *console)
 }
 EXPORT_SYMBOL(console_suspend);
 
-void console_start(struct console *console)
+void console_resume(struct console *console)
 {
 	struct console_flush_type ft;
 	bool is_nbcon;
@@ -3542,7 +3542,7 @@ void console_start(struct console *console)
 
 	__pr_flush(console, 1000, true);
 }
-EXPORT_SYMBOL(console_start);
+EXPORT_SYMBOL(console_resume);
 
 #ifdef CONFIG_PRINTK
 static int unregister_console_locked(struct console *console);

-- 
2.48.1


