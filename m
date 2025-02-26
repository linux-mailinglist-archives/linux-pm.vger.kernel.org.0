Return-Path: <linux-pm+bounces-23029-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1E39A46BD2
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83CB16EB66
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8D25EFB7;
	Wed, 26 Feb 2025 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gu5rAJ4l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="gu5rAJ4l"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D2E25E478
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 19:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599972; cv=none; b=S7Sh6swfCRtEOP8UFLOOgVaXT4BC3xbb7ycoVeef5YZYbGByjIhGXBoVfYWUk7IxU5VATgmXkx9bBb61tGjC3NUDLJC3nbK8yNRPQ/BbbHrykddrNlKKuBr3jZMhG94KFczn3xflWAcHupwmoEsbHVhYFMf1uYVV8rIVf05ILPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599972; c=relaxed/simple;
	bh=JRnPNS2R+SoIrKYk5hs0jEUL60OqbTaEnku8x/ZnQT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dbNkeLOv63ftzQWGFSzaYBLNOdRe/93UWVueN7TWbxCTS+yVWxtA5iQ3dGmvYseytO00BPCLZjiD19C4pCs3owIOf3hDWFaxz2MiO2Jr6r5q/zU2I5JPwiefLbj/57VnN/VP0VDGBeTI0Vr0kthCeY1NB1XR0kynO2se3jV4Ba0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gu5rAJ4l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=gu5rAJ4l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2A803211A1;
	Wed, 26 Feb 2025 19:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3WmfFEnCvDs4KrvRf1+gcJdaZ6nkRrsX2UH5OZ2D/Y=;
	b=gu5rAJ4ln2UxWzssNDciupNk61EvKVzSJankbY07PY9XaK3SnqBmfZj8lsUw62H0oO5eMj
	GMJoxtpmApYaTW1HI3w0aoDX8Gr58rp2mmDyTi1yM5GLcISMc6wo7pvpRZ4sXtKpyOtgCr
	u2LGAjokAzm1aecIi73WSBfpa6jYdTw=
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599969; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P3WmfFEnCvDs4KrvRf1+gcJdaZ6nkRrsX2UH5OZ2D/Y=;
	b=gu5rAJ4ln2UxWzssNDciupNk61EvKVzSJankbY07PY9XaK3SnqBmfZj8lsUw62H0oO5eMj
	GMJoxtpmApYaTW1HI3w0aoDX8Gr58rp2mmDyTi1yM5GLcISMc6wo7pvpRZ4sXtKpyOtgCr
	u2LGAjokAzm1aecIi73WSBfpa6jYdTw=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA30713A53;
	Wed, 26 Feb 2025 19:59:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id myk8HKByv2ddMgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:28 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Wed, 26 Feb 2025 16:59:05 -0300
Subject: [PATCH 5/5] printk: Check CON_SUSPEND when unblanking a console
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250226-printk-renaming-v1-5-0b878577f2e6@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=1376;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=JRnPNS2R+SoIrKYk5hs0jEUL60OqbTaEnku8x/ZnQT4=;
 b=YZG7GhXC7DlbzU/tfnWu5ZJWEdMcKKy+w3hDjFcb440sfvdbAMzpmhJ3Bxk21gPTiahZl9MRA
 xAt8RkWljJoCoHFjFTT5BAcz42UiIfBD1jRnQDzOo0STCf7ts7Cddnd
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
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

The commit 9e70a5e109a4 ("printk: Add per-console suspended state")
introduced the CON_SUSPENDED flag for consoles. The suspended consoles
will stop receiving messages, so don't unblank suspended consoles
because it won't be showing anything either way.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/printk/printk.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index fbbaec06c9f3..4b7ed40bf808 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3342,7 +3342,12 @@ void console_unblank(void)
 	 */
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank) {
+		short flags = console_srcu_read_flags(c);
+
+		if (flags & CON_SUSPENDED)
+			continue;
+
+		if ((flags & CON_ENABLED) && c->unblank) {
 			found_unblank = true;
 			break;
 		}
@@ -3379,7 +3384,12 @@ void console_unblank(void)
 
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(c) {
-		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank)
+		short flags = console_srcu_read_flags(c);
+
+		if (flags & CON_SUSPENDED)
+			continue;
+
+		if ((flags & CON_ENABLED) && c->unblank)
 			c->unblank();
 	}
 	console_srcu_read_unlock(cookie);

-- 
2.48.1


