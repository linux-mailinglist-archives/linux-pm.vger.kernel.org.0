Return-Path: <linux-pm+bounces-35060-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 072F7B8A947
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 18:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 369135A7C0F
	for <lists+linux-pm@lfdr.de>; Fri, 19 Sep 2025 16:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD043218A1;
	Fri, 19 Sep 2025 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C9f+WkJb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y90j7YCD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jqvXoi6f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JcgiSYiq"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC49321445
	for <linux-pm@vger.kernel.org>; Fri, 19 Sep 2025 16:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758299533; cv=none; b=m1RwcyEXRmQWOhWYcufD4ta39CAUKzA7HpGLf7FaQQBL7HoBTTyyVNiHcESXcEZhwzeazJuBQYPoBF9WXGq5lqNgnxuwJcoI/MjUYsIdmaRJP4N57rDhcOu+QpM7in+82VaLiTj3rATAMbUShM8Q6pu/CaPHU6Pu+jzQvH2jWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758299533; c=relaxed/simple;
	bh=X4UMxA5PcHA5deWHb6V/zlMJzzYS71/Dlxr9mJ6VDG4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VF9Qx3JtAc/O5lcuI38uz9OQj2i+JoG/WkzUEjVA47H7b3X9e5t9LdO0fUkA5GjTASA9TLg58vYSHFTA9uNHSCnBNDjtA5BJHtgz878luKJWjQ/qRS7AAAV16OUSBST7lcjpGaPwPm0YBz7GbYkMMHZwVkqQ45sukz2cW0rUdNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C9f+WkJb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y90j7YCD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jqvXoi6f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JcgiSYiq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B3E1E2120F;
	Fri, 19 Sep 2025 16:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGJ7Uqfb/EM/zLCvs2Uxp04+tMxwcKGLIRpShwvq/Dg=;
	b=C9f+WkJbkOTZfQR49xLwPbnQjPW5OphUtM+yiNhoTFXGDfP5pN+kNGVXAgwshWkiCn8D+2
	nJErlmBwrMGC4MyGEaxnzpQJ2yRruwc+CAI1XyfUubs9RuLR85TLhGnR8cdEBTYce788ez
	Og6g74Nsk2Va7cF8jfYUFI3vpRy7l8U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGJ7Uqfb/EM/zLCvs2Uxp04+tMxwcKGLIRpShwvq/Dg=;
	b=Y90j7YCDmMVcCNmXCi4GiE16t0ptzm8d6hrmMW6v5w3E46VWH/lbxN1Ff99N1dIhU4wATP
	ELvAXIejpxbqJwCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758299522; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGJ7Uqfb/EM/zLCvs2Uxp04+tMxwcKGLIRpShwvq/Dg=;
	b=jqvXoi6fIjIe8+pKHJHkfPUeNwazsSGJpMiYvsI7EhvStNAZZQhsc8p+lyYkDDQUCw9Gan
	+rx0h27pHwfYykXaKATc7mUyguH/M8SMsl2AoDYDiF76LJvnUsa4g6xH8a8JzAGcE12fRR
	gTWnaf3Xfj9u+8ngGznNnPNF7eTBeko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758299522;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=DGJ7Uqfb/EM/zLCvs2Uxp04+tMxwcKGLIRpShwvq/Dg=;
	b=JcgiSYiq5fStJABFo8FPDFez/maRJpASKpk+oLlsRL2VgEspQWzIJK9e+xNPJHiqvONQlY
	yKa42pWbgjswreDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D49413A39;
	Fri, 19 Sep 2025 16:32:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sLxFHYKFzWg3UwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 19 Sep 2025 16:32:02 +0000
From: Takashi Iwai <tiwai@suse.de>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] PM: runtime: New class macros for auto-cleanup
Date: Fri, 19 Sep 2025 18:31:41 +0200
Message-ID: <20250919163147.4743-1-tiwai@suse.de>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Hi,

this is a patch series to introduce the new class macros for easier
usage of PM runtime auto-cleanup features.

There is only one existing user of __free(pm_runtime_put) in PCI core,
and this is converted with CLASS() macro, too.
Then the pm_runtime_put __free definition is dropped.

The first patch was from Rafael (as found in the thread below), and I
left no sign-off as I expect he'll get and sign later again.


Link: https://lore.kernel.org/878qimv24u.wl-tiwai@suse.de

thanks,

Takashi

===

Rafael J. Wysocki (1):
  PM: runtime: Define class helpers for automatic PM runtime cleanup

Takashi Iwai (2):
  PCI: Use PM runtime class macro for the auto cleanup
  PM: runtime: Drop unused pm_runtime_free __free() definition

 drivers/pci/pci-sysfs.c    |  5 +++--
 include/linux/pm_runtime.h | 45 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 4 deletions(-)

-- 
2.50.1


