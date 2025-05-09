Return-Path: <linux-pm+bounces-26961-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968AAB191D
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 17:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DEF23A5197
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24A722F755;
	Fri,  9 May 2025 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cFo+ZIax";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6PUT0UbI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cFo+ZIax";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6PUT0UbI"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205C522D9EA
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805531; cv=none; b=qJ2zf5OnlwXYcKmjaY9blxePXWFeCf67AhA9DJjjsv47XDV+LRZ08GsWdHppTAyiiMJUeLJuX7LDliQxtjns4vrZK3coqoUo/T7d62C1q7+wxAWMZKixUHa3jBduOQVzfDioybGl23bT898RJY3r0yjJxhNGiZAlyIhhjGiyFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805531; c=relaxed/simple;
	bh=JX4b3O3HClIl8xFemtm8sMW5FD47aYIkuMJ7qN29tkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFDGYUBvvmDptlYMmjjyJSfLprd7vpWRz7XBMBFkb7aheSon9K3CGbtG8IL97kHeDehnNTMlmQkzHfVnUisWW6EmjzZtiqJn6fhQpqBfMDjJrOq+qJsRcEa8VMcpwD0bm0+KNrk4K/6JKBsWTcfnKMICCzAgt87fgRB3cznOLjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cFo+ZIax; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6PUT0UbI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cFo+ZIax; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6PUT0UbI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0F492116D;
	Fri,  9 May 2025 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZhL/RJQhO2eG+Sr8jM5jZDRgKoZyxBFdqW1I47ib3Q=;
	b=cFo+ZIaxshzc38b2z3QEWI6oT3GH2syveYRjNnxe0dreQdHV8/vNMlMQa32JTalWwyM7OT
	Ck9/4DlfRbzAqOfKVPJ5LbFRSaKcztmNmVf5eoRshmOpqFBpe77tNIAtDJnf/zBvIrPjM1
	F5RsmkXyA9UWOArEAXqeAEhX4t6mJHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZhL/RJQhO2eG+Sr8jM5jZDRgKoZyxBFdqW1I47ib3Q=;
	b=6PUT0UbIXT8bolYKMHmvgGz6wKibky7TYayOOS6IdWYbaBRV2hBeZR/yUgTePG7nzISkYy
	f0xxUuhwNuYTr6CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZhL/RJQhO2eG+Sr8jM5jZDRgKoZyxBFdqW1I47ib3Q=;
	b=cFo+ZIaxshzc38b2z3QEWI6oT3GH2syveYRjNnxe0dreQdHV8/vNMlMQa32JTalWwyM7OT
	Ck9/4DlfRbzAqOfKVPJ5LbFRSaKcztmNmVf5eoRshmOpqFBpe77tNIAtDJnf/zBvIrPjM1
	F5RsmkXyA9UWOArEAXqeAEhX4t6mJHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZhL/RJQhO2eG+Sr8jM5jZDRgKoZyxBFdqW1I47ib3Q=;
	b=6PUT0UbIXT8bolYKMHmvgGz6wKibky7TYayOOS6IdWYbaBRV2hBeZR/yUgTePG7nzISkYy
	f0xxUuhwNuYTr6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C58E1399F;
	Fri,  9 May 2025 15:45:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CMo4HQsjHmgrYwAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 09 May 2025 15:45:15 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	mmayer@broadcom.com,
	Wolfgang Frisch <wolfgang.frisch@suse.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Thomas Renninger <trenn@suse.de>,
	Thomas Renninger <trenn@suse.com>
Subject: [PATCH 3/3] tools/thermal/tmon: Cleanup only: Use LOG_FILE vars
Date: Fri,  9 May 2025 17:44:35 +0200
Message-ID: <20250509154435.14670-4-trenn@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509154435.14670-1-trenn@suse.de>
References: <20250509154435.14670-1-trenn@suse.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.75 / 50.00];
	BAYES_HAM(-2.95)[99.78%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:mid];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.75

Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 tools/thermal/tmon/tmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index f803f2a2fb12..e441b165035f 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -55,7 +55,8 @@ void usage(void)
 	printf("  -d, --daemon          run as daemon, no TUI\n");
 	printf("  -g, --debug           debug message in syslog\n");
 	printf("  -h, --help            show this help message\n");
-	printf("  -l, --log             log data to /var/tmp/tmon.log\n");
+	printf("  -l, --log             log data to %s/%s\n",
+	       TMON_LOG_DIR, TMON_LOG_FILENAME);
 	printf("  -t, --time-interval   sampling time interval, > 1 sec.\n");
 	printf("  -T, --target-temp     initial target temperature\n");
 	printf("  -v, --version         show version\n");
@@ -271,7 +272,8 @@ int main(int argc, char **argv)
 			target_temp_user = temp;
 			break;
 		case 'l':
-			printf("Logging data to /var/tmp/tmon.log\n");
+			printf("Logging data to %s/%s\n",
+			       TMON_LOG_DIR, TMON_LOG_FILENAME);
 			logging = 1;
 			break;
 		case 'h':
-- 
2.49.0


