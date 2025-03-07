Return-Path: <linux-pm+bounces-23612-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2819A5642A
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 10:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEB983A45FC
	for <lists+linux-pm@lfdr.de>; Fri,  7 Mar 2025 09:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242EA201278;
	Fri,  7 Mar 2025 09:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sMqxK4FG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7TQ640bc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sMqxK4FG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7TQ640bc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E0191461
	for <linux-pm@vger.kernel.org>; Fri,  7 Mar 2025 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741340620; cv=none; b=gX6BjO5f1CeU/BBzvI3BRtvvd8elK3z/RZf3CIrYujL2aFxwuhqfmtv7C4EEq5uxPdqhjEpTeZ+1PimgtoH5gRsjys4PATHBWvJdC2orrYIPMQvBnCMJEOKoER8m5fh1zxjwDXLmGAeaajHOxi+tVON76SMCX/Uc+07cE6omnds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741340620; c=relaxed/simple;
	bh=WTNdg9md+B8WQQM1mDlfviw9rLBu4szLsoFm5YhODfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WZL9rWSEzYMX7mE/rJlvmwHCVrPpOsck+YXmriG2fHIcf9SO6iw/JeuFpGlj5j/7qajKqgTiUx027hynwjT1aLy6SDpEiOlm0i0cghJcxtS1INgODumQdSDGDRQoZwZT6kIALXg1pmyYhL3XFmxTkSuz+lBxbzb+DQAVwyOmD44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sMqxK4FG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7TQ640bc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=sMqxK4FG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7TQ640bc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17FF2211A1;
	Fri,  7 Mar 2025 09:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741340616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0bEZCu0AcVK+oUMJVTm2Tzz7V0q5lgSYgSO2krkG9TM=;
	b=sMqxK4FGvBv/GCR9Cu8mkKZOb5LUGAhn/uBUfCm6DB40baDKW+a0DXq+qvmBCjNvJC07R3
	I3RRpq9O92V0Jf00dkfJ1uT1C7TmweIuIui+nbHSSx7uwDvAuiv4OQIxAQctAK38f3HicZ
	+AR9601AUOYFtMUgE8cL8CI7dtme1PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741340616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0bEZCu0AcVK+oUMJVTm2Tzz7V0q5lgSYgSO2krkG9TM=;
	b=7TQ640bc8rVYGpFk5mgGZWZf9vmvvMRCBqPGmDz/p3AaN9SIT4/Pcc3M8z8gr10e/5U6Fa
	vut+m/B1AgJhO/CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sMqxK4FG;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7TQ640bc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741340616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0bEZCu0AcVK+oUMJVTm2Tzz7V0q5lgSYgSO2krkG9TM=;
	b=sMqxK4FGvBv/GCR9Cu8mkKZOb5LUGAhn/uBUfCm6DB40baDKW+a0DXq+qvmBCjNvJC07R3
	I3RRpq9O92V0Jf00dkfJ1uT1C7TmweIuIui+nbHSSx7uwDvAuiv4OQIxAQctAK38f3HicZ
	+AR9601AUOYFtMUgE8cL8CI7dtme1PQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741340616;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=0bEZCu0AcVK+oUMJVTm2Tzz7V0q5lgSYgSO2krkG9TM=;
	b=7TQ640bc8rVYGpFk5mgGZWZf9vmvvMRCBqPGmDz/p3AaN9SIT4/Pcc3M8z8gr10e/5U6Fa
	vut+m/B1AgJhO/CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA60C13A22;
	Fri,  7 Mar 2025 09:43:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U7lNN8e/ymfGSwAAD6G6ig
	(envelope-from <trenn@suse.de>); Fri, 07 Mar 2025 09:43:35 +0000
From: Thomas Renninger <trenn@suse.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org,
	Thomas Renninger <trenn@suse.de>
Subject: [PATCH] cpupower: Make lib versioning scheme more obvious and fix version link
Date: Fri,  7 Mar 2025 10:43:34 +0100
Message-ID: <20250307094334.39587-1-trenn@suse.de>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 17FF2211A1
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

library versioning was broken:
libcpupower.so.0.0.1
libcpupower.so -> libcpupower.so.0.0.1
libcpupower.so.1 -> libcpupower.so.0.0.1

and is fixed by this patch to:
libcpupower.so.1.0.1
libcpupower.so -> libcpupower.so.1.0.1
libcpupower.so.1 -> libcpupower.so.1.0.1

Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 tools/power/cpupower/Makefile | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 51a95239fe06..835123add0ed 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -52,8 +52,11 @@ DESTDIR ?=
 # and _should_ modify the PACKAGE_BUGREPORT definition
 
 VERSION:=			$(shell ./utils/version-gen.sh)
-LIB_MAJ=			0.0.1
-LIB_MIN=			1
+LIB_FIX=			1
+LIB_MIN=			0
+LIB_MAJ=			1
+LIB_VER=			$(LIB_MAJ).$(LIB_MIN).$(LIB_FIX)
+
 
 PACKAGE =			cpupower
 PACKAGE_BUGREPORT =		linux-pm@vger.kernel.org
@@ -200,14 +203,14 @@ $(OUTPUT)lib/%.o: $(LIB_SRC) $(LIB_HEADERS)
 	$(ECHO) "  CC      " $@
 	$(QUIET) $(CC) $(CFLAGS) -fPIC -o $@ -c lib/$*.c
 
-$(OUTPUT)libcpupower.so.$(LIB_MAJ): $(LIB_OBJS)
+$(OUTPUT)libcpupower.so.$(LIB_VER): $(LIB_OBJS)
 	$(ECHO) "  LD      " $@
 	$(QUIET) $(CC) -shared $(CFLAGS) $(LDFLAGS) -o $@ \
-		-Wl,-soname,libcpupower.so.$(LIB_MIN) $(LIB_OBJS)
+		-Wl,-soname,libcpupower.so.$(LIB_MAJ) $(LIB_OBJS)
 	@ln -sf $(@F) $(OUTPUT)libcpupower.so
-	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_MIN)
+	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 
-libcpupower: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+libcpupower: $(OUTPUT)libcpupower.so.$(LIB_VER)
 
 # Let all .o files depend on its .c file and all headers
 # Might be worth to put this into utils/Makefile at some point of time
@@ -217,7 +220,7 @@ $(OUTPUT)%.o: %.c
 	$(ECHO) "  CC      " $@
 	$(QUIET) $(CC) $(CFLAGS) -I./lib -I ./utils -o $@ -c $*.c
 
-$(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+$(OUTPUT)cpupower: $(UTIL_OBJS) $(OUTPUT)libcpupower.so.$(LIB_VER)
 	$(ECHO) "  CC      " $@
 ifeq ($(strip $(STATIC)),true)
 	$(QUIET) $(CC) $(CFLAGS) $(LDFLAGS) $(UTIL_OBJS) -lrt -lpci -L$(OUTPUT) -o $@
@@ -262,7 +265,7 @@ update-po: $(OUTPUT)po/$(PACKAGE).pot
 	done;
 endif
 
-compile-bench: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
+compile-bench: $(OUTPUT)libcpupower.so.$(LIB_VER)
 	@V=$(V) confdir=$(confdir) $(MAKE) -C bench O=$(OUTPUT)
 
 # we compile into subdirectories. if the target directory is not the
-- 
2.48.1


