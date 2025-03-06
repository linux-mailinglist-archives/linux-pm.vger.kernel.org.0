Return-Path: <linux-pm+bounces-23569-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73BB0A54F36
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 16:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E19189B5DB
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 15:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E44211294;
	Thu,  6 Mar 2025 15:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eeAVtu1l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="THB5Yyel";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eeAVtu1l";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="THB5Yyel"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6173E21128A
	for <linux-pm@vger.kernel.org>; Thu,  6 Mar 2025 15:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741274884; cv=none; b=G9bBNSf46AKE2ZKv6tqa9GxXLynvjHYbDxRWvWHqk3eVt5ivD97K6cF7wZ7OUeKPRafGGq+z0Dug/IT1aqrjRahyAucz8XrQay+yCqT32fWLCWk6KGWzZDU1Xqlxz2kbHcoWIhNUoCGOP+h605dGz2kHmJ2qzolVbJEu6QVsfTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741274884; c=relaxed/simple;
	bh=GSS95WbXNyEMmgU4D5QjOQDAS9WJ39CO9ivYNZDbGHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZxmqcXBXJU9fhWjxUk08DD92lFWjgXwl2qiBDLnb68mv8RNP+9d/Z4rM1waFqV3AWltN+TuaMbGja2dc2EvNWigOqcNVUoGP6M/Xu1psUs9EB//UNxhqTsuig670Da9rO/4LKUfanYc5UMFLQgTF5Ll8BP7KPzvgJL4COzAwyUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eeAVtu1l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=THB5Yyel; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eeAVtu1l; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=THB5Yyel; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5BBE91F449;
	Thu,  6 Mar 2025 15:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741274880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wIiCgXceTQ6O1UA94dECPeGqHELIUcwGQS/tYZoYNWc=;
	b=eeAVtu1lgFmJFoSflrJgJxziJJ/FXi2Z8vCAdMBEqmPwrQDSYR4cWKh/3h1/yuBztINz8i
	/L9dZuimN7E5Aiikkc/wxUrCIBMLk81QHRFBRipemqS94WNcfvnKwUuKUhe5b2p/pybvYq
	VuF8QRq+4OXySsRkjjdioUlCN7CrOTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741274880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wIiCgXceTQ6O1UA94dECPeGqHELIUcwGQS/tYZoYNWc=;
	b=THB5YyelCEDzTDvMeZ8SHJn7VihFLMHzsx9U5vIcZS7/s0WUAWgnfBX262MISKH7xBT4DB
	+i0XxzzguAjQ9CCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eeAVtu1l;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=THB5Yyel
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741274880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wIiCgXceTQ6O1UA94dECPeGqHELIUcwGQS/tYZoYNWc=;
	b=eeAVtu1lgFmJFoSflrJgJxziJJ/FXi2Z8vCAdMBEqmPwrQDSYR4cWKh/3h1/yuBztINz8i
	/L9dZuimN7E5Aiikkc/wxUrCIBMLk81QHRFBRipemqS94WNcfvnKwUuKUhe5b2p/pybvYq
	VuF8QRq+4OXySsRkjjdioUlCN7CrOTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741274880;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type;
	bh=wIiCgXceTQ6O1UA94dECPeGqHELIUcwGQS/tYZoYNWc=;
	b=THB5YyelCEDzTDvMeZ8SHJn7VihFLMHzsx9U5vIcZS7/s0WUAWgnfBX262MISKH7xBT4DB
	+i0XxzzguAjQ9CCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4467013A61;
	Thu,  6 Mar 2025 15:28:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7rBfDwC/yWcuFQAAD6G6ig
	(envelope-from <trenn@suse.de>); Thu, 06 Mar 2025 15:28:00 +0000
From: Thomas Renninger <trenn@suse.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Subject:
 [PATCH] cpupower: Make versioning scheme more obvious and fix version link
Date: Thu, 06 Mar 2025 16:27:59 +0100
Message-ID: <3513228.LZWGnKmheA@laptop.fritzbox>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7109838.9J7NaK4W3v";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Rspamd-Queue-Id: 5BBE91F449
X-Spam-Level: 
X-Spamd-Result: default: False [-6.61 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SIGNED_PGP(-2.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -6.61
X-Spam-Flag: NO

--nextPart7109838.9J7NaK4W3v
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Thomas Renninger <trenn@suse.de>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
Date: Thu, 06 Mar 2025 16:27:59 +0100
Message-ID: <3513228.LZWGnKmheA@laptop.fritzbox>
MIME-Version: 1.0

Hi Shuah,

I can darkly remember this was discussed already, but it seems
it's still broken.

Currently there is:
LIB_MAJ=                       0.0.1
LIB_MIN=                       1

Resulting in:
libcpupower.so.0.0.1
libcpupower.so -> libcpupower.so.0.0.1
libcpupower.so.1 -> libcpupower.so.0.0.1

The naming of the variables is confusing (MIN should be MAJ) and the result is wrong.

You get the desired result by:
-LIB_MAJ=                       0.0.1
+LIB_MAJ=                       1.0.1
LIB_MIN=                       1
libcpupower.so.1.0.1
libcpupower.so -> libcpupower.so.1.0.1
libcpupower.so.1 -> libcpupower.so.1.0.1

Correct, but still confusing.
Here my suggestion to fix this with a reasonable (re-)naming:

-----------------
diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 51a95239fe06..a7d7d335c1ee 100644
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
@@ -203,9 +206,9 @@ $(OUTPUT)lib/%.o: $(LIB_SRC) $(LIB_HEADERS)
 $(OUTPUT)libcpupower.so.$(LIB_MAJ): $(LIB_OBJS)
 	$(ECHO) "  LD      " $@
 	$(QUIET) $(CC) -shared $(CFLAGS) $(LDFLAGS) -o $@ \
-		-Wl,-soname,libcpupower.so.$(LIB_MIN) $(LIB_OBJS)
+		-Wl,-soname,libcpupower.so.$(LIB_VER) $(LIB_OBJS)
 	@ln -sf $(@F) $(OUTPUT)libcpupower.so
-	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_MIN)
+	@ln -sf $(@F) $(OUTPUT)libcpupower.so.$(LIB_VER)
 
 libcpupower: $(OUTPUT)libcpupower.so.$(LIB_MAJ)
 

--nextPart7109838.9J7NaK4W3v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEo0EXulPW3gW/5bAoTxjWwdl3vVUFAmfJvv8ACgkQTxjWwdl3
vVXFRAf+I/qkmY8RnSGPnj6uz5hHjlq8CzUtg7LW0sRaMtf3widKUw9h72Tsu0f7
eqgUd/vRv+qp1MbmnSqqRhouPmxHyJHUEEG6pU0QjYMNYkli7FN3xCYep1vFx+uR
yGHRNH13XK/WGynqCN3vgKc6VomCDG7cVwP1qJyrxftvbS0kAKhu8Lyj8MmhuzxY
OoQScWo+kz42BilF2cWGpbfLEH1mv2wfJfBWPDLVMXC0Ox2TBQI7aGw5KswkhIJf
i+dkKZL1lfHgk5h2dXm3rLMJXE9WuucUhBMXkI12PZamkt3CZUbWtk79PdS0hoh2
Sjwf/AAgpI6piJxCc6zUG54FnWh6oA==
=ZHYt
-----END PGP SIGNATURE-----

--nextPart7109838.9J7NaK4W3v--




