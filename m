Return-Path: <linux-pm+bounces-26958-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C93FAB191A
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 17:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AAEE524008
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6FA8230270;
	Fri,  9 May 2025 15:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOVmZlQv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YvMPRd6E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TOVmZlQv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YvMPRd6E"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054FF22FE15
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805518; cv=none; b=b4+KD1PeXsLXXnrUlmtKRXJ76npXrXnSIXruyvn+gCnpnTbmbprhNlcktONp3W+/g7sYG602K1nlfdQWxZ810ppje5TynSqxbGmPqFIse+2nkShL6HZlEzq2bIgMcyCy/YazgfHEwGO47X8m9XBAWRpcw0qtLUdGyAOzUGCaF9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805518; c=relaxed/simple;
	bh=jISMaVTCuZ62q8gMPfRMQDUSCwRU8HAyp2qRjFJ5nAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ELEVxEnexXMDBSc8LdoaEqD+o8kDUSMbfCJTNKVwo2BIEDyhazaxcyUAnmzNt8mFNDqRXcylSitfQTmdOwD8hgrpM57Y8dEs62tixR7/k6KcPWL0YrwwchZ3d6cI7ql4T2Hw6SGwHWxDUwA44Hf4yhTm63SEKuSOZcEOZ7L+FLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOVmZlQv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YvMPRd6E; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TOVmZlQv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YvMPRd6E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 004D321165;
	Fri,  9 May 2025 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8PrLdxV38IJyAFKHLATwxryc+mXzrW095ZigaMenQFY=;
	b=TOVmZlQv21Ops8+YcQb0hAhgV29QckidURixF4QUCuOxtiunDlsfOC2NBkiOWU1OQraHQF
	TiY5OaXFuANwUXcZ+KOYjL1ZjClWPTFmckJUHrUQpk4F7qmLy3h0ZfGIosB7vLWPJCFw7P
	1g14Cplw5dU0svLb7WtKigYfmVTneT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8PrLdxV38IJyAFKHLATwxryc+mXzrW095ZigaMenQFY=;
	b=YvMPRd6EShAohSVKMgyPobfXhNH8FGWbzTU0bt+Bd9mQQ2CxAXipVTW6mySMiIAQ8GrY9h
	i1B8oW4o9NHE4RBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TOVmZlQv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YvMPRd6E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8PrLdxV38IJyAFKHLATwxryc+mXzrW095ZigaMenQFY=;
	b=TOVmZlQv21Ops8+YcQb0hAhgV29QckidURixF4QUCuOxtiunDlsfOC2NBkiOWU1OQraHQF
	TiY5OaXFuANwUXcZ+KOYjL1ZjClWPTFmckJUHrUQpk4F7qmLy3h0ZfGIosB7vLWPJCFw7P
	1g14Cplw5dU0svLb7WtKigYfmVTneT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8PrLdxV38IJyAFKHLATwxryc+mXzrW095ZigaMenQFY=;
	b=YvMPRd6EShAohSVKMgyPobfXhNH8FGWbzTU0bt+Bd9mQQ2CxAXipVTW6mySMiIAQ8GrY9h
	i1B8oW4o9NHE4RBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD3A11399F;
	Fri,  9 May 2025 15:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id aXOnLAojHmgrYwAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 09 May 2025 15:45:14 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	mmayer@broadcom.com,
	Wolfgang Frisch <wolfgang.frisch@suse.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Thomas Renninger <trenn@suse.de>
Subject: [PATCH 0/3] tools/thermal/tmon: Fix predictable temporary path /var/log/tmon.log
Date: Fri,  9 May 2025 17:44:32 +0200
Message-ID: <20250509154435.14670-1-trenn@suse.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 004D321165
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,localhost:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action

Wolfgang Frisch identified and reported:
tmon only runs as root and logs event to /var/tmp/tmon.log.
If fs.protected_symlinks=0, an unprivileged user can overwrite
arbitrary files on the system.

nobody@localhost:/var/tmp> ln -s /test/shadow tmon.log
root@localhost:/> tmon -l

I could reproduce the issue and after some discussion we came
to 3 possible solutions:
1. Use /var/log/tmon.log instead of world-readable /var/tmp
2. Add randomness to the file name, e.g. /var/log/tmon.log.QipZjI
3. Make /var/tmp/tmon.log safe (TM), or say more robust.

Wolfgang came up with a patch which is part of this submission.
His intention is to keep /var/tmp/tmon.log, in case other tools/scripts
or docs rely on it.

If 3. is a suitable solution, it would be great if someone could
pile these patches for next submission round.

Thanks,

       Thomas

Thomas Renninger (3):
  tools/thermal/tmon: Prevent symlink attack on log file
  tools/thermal/tmon: Make sure ctrl_cdev is a Null terminated string
  tools/thermal/tmon: Cleanup only: Use LOG_FILE vars

 tools/thermal/tmon/tmon.c | 57 +++++++++++++++++++++++++++------------
 tools/thermal/tmon/tmon.h |  3 ++-
 2 files changed, 42 insertions(+), 18 deletions(-)

-- 
2.49.0


