Return-Path: <linux-pm+bounces-23025-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9067A46BC3
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 21:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3D80188D169
	for <lists+linux-pm@lfdr.de>; Wed, 26 Feb 2025 20:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D690256C9F;
	Wed, 26 Feb 2025 19:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="exazJCv4";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="exazJCv4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2495A256C7F
	for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2025 19:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740599956; cv=none; b=lsyw5hJrtKmdN4A5k2qBWgWnnJ+BmEzuTbkXuiQp6YTC/rcAwkxBuDcyHuaQDv2skiivmDddF4F49+ztGJqgWr8qshQ/O3mFcnu24On5jHWmHxT0PB73jlQzof4hu4bTRlhoOT1eExsI1rIZXAm2BJffjfULvubKmGGWpwX5N8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740599956; c=relaxed/simple;
	bh=g10VNxu+J+WpDkUkbQm/mJqITFnxcJsd5sZ1tSpU5sM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=AZEwBO5jceSL3BnDCz19/GSja7o8zC2Dh0cIPz20vwr+6cMrSknir1lMZDjcxOIrPhDtmPuO+b6/WZ5sTztLxI/6ficUV7HV+QVXkIuOZiXNJ81b3lHAJ8PABLK5W/G2p8A5txhnEYfDXqw0nrpXhYCu1BksyqCgPxk4IK4MU4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=exazJCv4; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=exazJCv4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1C4452119B;
	Wed, 26 Feb 2025 19:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iRBPg6dcRG/frt2aeGEkFVcsNiGZUVEbU71z9ho3GW8=;
	b=exazJCv4CCpSOv+6z3lE6sioVYMw5udqsKf6GPDwIi8dbvReIAYuXfTrQgPfe8b4LWW3bH
	sYxcpi6th/VtY5VZRvmjY4/5z24waOjFbXlOO79ya67zOwR4Caz5fkiAf7pXAw6oyoirZX
	7DJ28eE9b0xOu4lCOkkj3vYl9BdX7NI=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=exazJCv4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1740599951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iRBPg6dcRG/frt2aeGEkFVcsNiGZUVEbU71z9ho3GW8=;
	b=exazJCv4CCpSOv+6z3lE6sioVYMw5udqsKf6GPDwIi8dbvReIAYuXfTrQgPfe8b4LWW3bH
	sYxcpi6th/VtY5VZRvmjY4/5z24waOjFbXlOO79ya67zOwR4Caz5fkiAf7pXAw6oyoirZX
	7DJ28eE9b0xOu4lCOkkj3vYl9BdX7NI=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DF1E13A53;
	Wed, 26 Feb 2025 19:59:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mdxnFY5yv2c/MgAAD6G6ig
	(envelope-from <mpdesouza@suse.com>); Wed, 26 Feb 2025 19:59:10 +0000
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH 0/5] printk: renaming some suspend/resume functions and one
 fix for unblanking
Date: Wed, 26 Feb 2025 16:59:00 -0300
Message-Id: <20250226-printk-renaming-v1-0-0b878577f2e6@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIVyv2cC/x3MwQpAQBCA4VfRnG2ZKZRXkcNkB5MMzUpK3t3m+
 B3+/4EkrpKgKx5wuTTpbhlYFjAubLMEjdlAFdUVUR0OVzvX4GK8qc0BqRmRETm2DLk6XCa9/2M
 /vO8H9BTQImEAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740599947; l=1675;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=g10VNxu+J+WpDkUkbQm/mJqITFnxcJsd5sZ1tSpU5sM=;
 b=QNm2ZQ2aUdO0uJpHRox2rnWzw+hwkQdsqRU9EXSRQeDPxZXkfT6tNb98fsSiJ+tXAdlHyQ2Yr
 vdTFP8Of308CSXcTnV03u7iq6vWGJcJ/6i6gPtVLowOL2VJ/zyDIMyJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=
X-Rspamd-Queue-Id: 1C4452119B
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:dkim,suse.com:mid];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

Hello, I've being working on some patches that help to clarify the suspend/resume
of printk machinery. The last patch on this patchset address one issue regarding
suspended consoles and blanking.

This is a part one patchset that I would like to see merged before I send more patches
that will rework the suspend flag (a global suspend flag istead of per console) and
the removal of CON_ENABLED flag later on (I've created a function that will forcibly)
register the console instead of using this flag.

Please review!

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Marcos Paulo de Souza (5):
      printk: Rename suspend_console to console_suspend_all
      printk: Rename resume_console to console_resume_all
      printk: Rename console_stop to console_suspend
      printk: Rename console_start to console_resume
      printk: Check CON_SUSPEND when unblanking a console

 drivers/tty/serial/serial_core.c                   |  6 ++---
 include/linux/console.h                            |  8 +++---
 kernel/kexec_core.c                                |  4 +--
 kernel/power/hibernate.c                           | 16 ++++++------
 kernel/power/suspend.c                             |  8 +++---
 kernel/printk/printk.c                             | 30 ++++++++++++++--------
 .../pm-graph/config/custom-timeline-functions.cfg  |  4 +--
 tools/power/pm-graph/sleepgraph.py                 |  6 ++---
 8 files changed, 46 insertions(+), 36 deletions(-)
---
base-commit: ffd294d346d185b70e28b1a28abe367bbfe53c04
change-id: 20250225-printk-renaming-126c1a11ad7a

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


