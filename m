Return-Path: <linux-pm+bounces-26959-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C13AB191B
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D8013A4CF2
	for <lists+linux-pm@lfdr.de>; Fri,  9 May 2025 15:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99C8230BF9;
	Fri,  9 May 2025 15:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h/kbTYhv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a+LD4VtT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="h/kbTYhv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="a+LD4VtT"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29087230BC0
	for <linux-pm@vger.kernel.org>; Fri,  9 May 2025 15:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746805520; cv=none; b=BL3Lm4vV7iWk7ngupW+JcLDDuEIC/SgtPG72HhuAUqLZGzYYHUX6hVO9NSnEmDYh7d0kp3R7vIEXuMruhdk4zAUqpYsUIgOY42vrfdaCyxWa3mJRQnAo8W9mTPsflqzvYjB7dBsu+n84iMlqntbUS5+St+lC8+vdgBPMEbfHHs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746805520; c=relaxed/simple;
	bh=nWCm9mXvOaYOxBrXOcTo0OKjloCFgkNAkI80nYWx7Pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j54Jak1tRSA4dZPKQjo8pK2r0jS0Qx/F6zQS4xelEqfjlUJErCS/nZPo4CXKhptBCJ3pjL8BNWzUygO2lydtgVo4Vxt3PwDI7Z3Muy68yLGROK2+ZUvwcR4nw08oU2Y7R+pQiO6H+QEo1wHYgrv0cg7kYYmqUGP0Lqp/gvxlqEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h/kbTYhv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a+LD4VtT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=h/kbTYhv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=a+LD4VtT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 368D01F38A;
	Fri,  9 May 2025 15:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inyGEKlGnY/hETdv9Kc987kps+mkaKJrtc3EX5u9b1c=;
	b=h/kbTYhvquG322nHWc03PnBVDZMPYd2VchxOdJOr/VhVEX7pstg9iwTnbIwkNLtPsJHefY
	smNPCEWUHRITWX8x1clZ+SkOTB9lwlNd3fK+ZwwdWGijsh8/M8LPzAWmc2SCM1OOMVvFct
	BvFPOfO2QkR6DO2PZHzjlCt9wKbcVbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inyGEKlGnY/hETdv9Kc987kps+mkaKJrtc3EX5u9b1c=;
	b=a+LD4VtTcXoVUmUEnJ3DyH9u5lMoV8oWoo104FwCoC0cC9k1gYnk8APQnubgw1iyVIG9VU
	tzlS9+hHj12eEdCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="h/kbTYhv";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a+LD4VtT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746805515; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inyGEKlGnY/hETdv9Kc987kps+mkaKJrtc3EX5u9b1c=;
	b=h/kbTYhvquG322nHWc03PnBVDZMPYd2VchxOdJOr/VhVEX7pstg9iwTnbIwkNLtPsJHefY
	smNPCEWUHRITWX8x1clZ+SkOTB9lwlNd3fK+ZwwdWGijsh8/M8LPzAWmc2SCM1OOMVvFct
	BvFPOfO2QkR6DO2PZHzjlCt9wKbcVbo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746805515;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inyGEKlGnY/hETdv9Kc987kps+mkaKJrtc3EX5u9b1c=;
	b=a+LD4VtTcXoVUmUEnJ3DyH9u5lMoV8oWoo104FwCoC0cC9k1gYnk8APQnubgw1iyVIG9VU
	tzlS9+hHj12eEdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 012F7139D0;
	Fri,  9 May 2025 15:45:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YHHBOgojHmgrYwAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 09 May 2025 15:45:14 +0000
From: Thomas Renninger <trenn@suse.de>
To: linux-pm@vger.kernel.org
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	mmayer@broadcom.com,
	Wolfgang Frisch <wolfgang.frisch@suse.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/3] tools/thermal/tmon: Prevent symlink attack on log file
Date: Fri,  9 May 2025 17:44:33 +0200
Message-ID: <20250509154435.14670-2-trenn@suse.de>
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
X-Rspamd-Queue-Id: 368D01F38A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email,suse.de:mid,suse.de:dkim];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.01

From: Wolfgang Frisch <wolfgang.frisch@suse.com>

If fs.protected_symlinks=0, an unprivileged local user could create a
symbolic link at /var/log/tmon.log and, in turn, cause `tmon -l` to
truncate arbitrary files on the system when prepare_logging() is
executed.

Change prepare_logging() to use openat() and create the log file
securely.

Fixes: 951fda3d8c644597a1d5cdae14cab31567e754a1
Signed-off-by: Wolfgang Frisch <wolfgang.frisch@suse.com>
Reviewed-by: Thomas Renninger <trenn@suse.de>
---
 tools/thermal/tmon/tmon.c | 50 +++++++++++++++++++++++++++------------
 tools/thermal/tmon/tmon.h |  3 ++-
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216a27f4..e7392c0f6388 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -24,6 +24,8 @@
 #include <math.h>
 #include <stdarg.h>
 #include <syslog.h>
+#include <fcntl.h>
+#include <errno.h>
 
 #include "tmon.h"
 
@@ -132,35 +134,53 @@ static void prepare_logging(void)
 {
 	int i;
 	struct stat logstat;
+	int dir_fd = -1;
+	int log_fd = -1;
+	tmon_log = NULL;
 
 	if (!logging)
 		return;
-	/* open local data log file */
-	tmon_log = fopen(TMON_LOG_FILE, "w+");
-	if (!tmon_log) {
-		syslog(LOG_ERR, "failed to open log file %s\n", TMON_LOG_FILE);
+
+	/* get a file descriptor for the log directory */
+	dir_fd = open(TMON_LOG_DIR, O_RDONLY | O_DIRECTORY | O_CLOEXEC);
+	if (dir_fd < 0) {
+		syslog(LOG_ERR, "Failed to open log directory %s: %s\n",
+		       TMON_LOG_DIR, strerror(errno));
 		return;
 	}
 
-	if (lstat(TMON_LOG_FILE, &logstat) < 0) {
-		syslog(LOG_ERR, "Unable to stat log file %s\n", TMON_LOG_FILE);
-		fclose(tmon_log);
-		tmon_log = NULL;
+	/* open local data log file securely using openat() */
+	log_fd = openat(dir_fd, TMON_LOG_FILENAME,
+	                O_RDWR | O_CREAT | O_TRUNC | O_NOFOLLOW | O_CLOEXEC,
+	                0600);
+	close(dir_fd);
+
+	if (log_fd < 0) {
+		syslog(LOG_ERR, "Failed to open log file %s/%s: %s\n",
+		       TMON_LOG_DIR, TMON_LOG_FILENAME, strerror(errno));
 		return;
 	}
 
-	/* The log file must be a regular file owned by us */
-	if (S_ISLNK(logstat.st_mode)) {
-		syslog(LOG_ERR, "Log file is a symlink.  Will not log\n");
-		fclose(tmon_log);
-		tmon_log = NULL;
+	if (fstat(log_fd, &logstat) < 0) {
+		syslog(LOG_ERR, "Unable to stat log file %s/%s\n",
+		       TMON_LOG_DIR, TMON_LOG_FILENAME);
+		close(log_fd);
 		return;
 	}
 
+	/* The log file must be owned by us */
 	if (logstat.st_uid != getuid()) {
 		syslog(LOG_ERR, "We don't own the log file.  Not logging\n");
-		fclose(tmon_log);
-		tmon_log = NULL;
+		close(log_fd);
+		return;
+	}
+
+	/* All checks passed. Convert the file descriptor to a FILE stream. */
+	tmon_log = fdopen(log_fd, "w+");
+	if (!tmon_log) {
+		syslog(LOG_ERR, "Failed to fdopen log file descriptor for %s/%s: %s\n",
+		       TMON_LOG_DIR, TMON_LOG_FILENAME, strerror(errno));
+		close(log_fd);
 		return;
 	}
 
diff --git a/tools/thermal/tmon/tmon.h b/tools/thermal/tmon/tmon.h
index 44d16d778f04..5c35f8cd7cab 100644
--- a/tools/thermal/tmon/tmon.h
+++ b/tools/thermal/tmon/tmon.h
@@ -25,7 +25,8 @@
  */
 #define DATA_LEFT_ALIGN 10
 #define NR_LINES_TZDATA 1
-#define TMON_LOG_FILE "/var/tmp/tmon.log"
+#define TMON_LOG_DIR "/var/tmp"
+#define TMON_LOG_FILENAME "tmon.log"
 
 #include <sys/time.h>
 #include <pthread.h>
-- 
2.49.0


