Return-Path: <linux-pm+bounces-40736-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C7ED19183
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 14:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCEB1300FE0D
	for <lists+linux-pm@lfdr.de>; Tue, 13 Jan 2026 13:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE4338A9BF;
	Tue, 13 Jan 2026 13:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tMDJLA7+"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE27238F252
	for <linux-pm@vger.kernel.org>; Tue, 13 Jan 2026 13:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768310895; cv=none; b=d5gnP5djedekR4kx7ypxkmheljkKzKep03MPIVKLZPE0dgAEp0zBgDavmRk7g0MzlXvcK8sTft93kfdCU1YKDBXSxzHFwT3mWHKnm26NfLRco7C+arW6fYCUGLlzNDFDl2kVq+kHqALbPkA3vk9mHfhrOMrYJVez/V60nZshxv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768310895; c=relaxed/simple;
	bh=dgSjymh9lk5yPBBAyWitgYtOMmmnLkxKRBCsLcqk0o4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kF2hLowB29XF8yjHn/d0ysHuGezv7RKsz2iZcsJ2iWpZuXPWGe3c5Ks32pNTF7VrqwIrbVI/ed4wBFmHG5g72oTFWlX1SSADELuAVM2xsLUy5v9jZky+eyd9UPugPQ/uNxzVYE49O7hPUEiO6oITDc4mYlheo5rfX+qjqcmYV8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tMDJLA7+; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DFF52C1EC81;
	Tue, 13 Jan 2026 13:27:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 755C260701;
	Tue, 13 Jan 2026 13:28:12 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 317C6103C81A2;
	Tue, 13 Jan 2026 14:28:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768310892; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Kg0TANHqq4Rv/IeDeYGMtCHebEqbA5pAlisCPOs8KMk=;
	b=tMDJLA7+x3n/Vmh37vl5QjB/5UsK+hwP7FhP0MbbCqRJt28mo29BvRlktHp+cnaCyTI0Xp
	G1OcGNtm8OuLZLnXHwE+Fv6rAZr+FSvibB1x/tHg111vRrFd0gOi6EDvChSQgdLoMi9Ojp
	YKXk3v/1+BaEe9kIHzJFJlDtPrQhzm8uBSOgD0IM1LL8X3OrXTKkhcJhzs3WnDNYXg0LPf
	OEvmNu9VMkwoZjbxw1Z/Kd+uZIyz1U82U6YhJ2trNoOEjKs4SUxK8tQ1+QDEnfMYg0rz0Y
	mhSRiwabcAY/gYaDHk/Ca5IxCVVNPtHzamYDf0D1FGjAbcHZCGn6k6+H56zv5Q==
From: =?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
To: linux-pm@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	shuah@kernel.org,
	trenn@suse.com,
	jwyatt@redhat.com,
	jkacur@redhat.com,
	=?UTF-8?q?Jo=C3=A3o=20Marcos=20Costa?= <joaomarcos.costa@bootlin.com>
Subject: [PATCH 1/1] cpupower: make systemd unit installation optional
Date: Tue, 13 Jan 2026 14:27:53 +0100
Message-ID: <20260113132753.1730020-2-joaomarcos.costa@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260113132753.1730020-1-joaomarcos.costa@bootlin.com>
References: <20260113132753.1730020-1-joaomarcos.costa@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

cpupower currently installs a cpupower.service unit file into unitdir
unconditionally, regardless of whether systemd is used by the host.

Improve the installation procedure by making this systemd step optional:
a 'SYSTEMD' build parameter that defaults to 'true' and can be set to
'false' to disable the installation of systemd's unit file.

Since 'SYSTEMD' defaults to true, the current behavior is kept as the
default.

Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
---
 tools/power/cpupower/Makefile | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index a1df9196dc45..969716dfe8de 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -315,7 +315,17 @@ endif
 	$(INSTALL_DATA) lib/cpuidle.h $(DESTDIR)${includedir}/cpuidle.h
 	$(INSTALL_DATA) lib/powercap.h $(DESTDIR)${includedir}/powercap.h
 
-install-tools: $(OUTPUT)cpupower
+# SYSTEMD=false disables installation of the systemd unit file
+SYSTEMD ?=	true
+
+install-systemd:
+	$(INSTALL) -d $(DESTDIR)${unitdir}
+	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${unitdir}/cpupower.service'
+	$(SETPERM_DATA) '$(DESTDIR)${unitdir}/cpupower.service'
+
+INSTALL_SYSTEMD := $(if $(filter true,$(strip $(SYSTEMD))),install-systemd)
+
+install-tools: $(OUTPUT)cpupower $(INSTALL_SYSTEMD)
 	$(INSTALL) -d $(DESTDIR)${bindir}
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
@@ -324,9 +334,6 @@ install-tools: $(OUTPUT)cpupower
 	$(INSTALL_DATA) cpupower-service.conf '$(DESTDIR)${confdir}'
 	$(INSTALL) -d $(DESTDIR)${libexecdir}
 	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
-	$(INSTALL) -d $(DESTDIR)${unitdir}
-	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${unitdir}/cpupower.service'
-	$(SETPERM_DATA) '$(DESTDIR)${unitdir}/cpupower.service'
 
 install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
@@ -406,4 +413,4 @@ help:
 	@echo  '  uninstall	  - Remove previously installed files from the dir defined by "DESTDIR"'
 	@echo  '                    cmdline or Makefile config block option (default: "")'
 
-.PHONY: all utils libcpupower update-po create-gmo install-lib install-tools install-man install-gmo install uninstall clean help
+.PHONY: all utils libcpupower update-po create-gmo install-lib install-systemd install-tools install-man install-gmo install uninstall clean help
-- 
2.47.0


