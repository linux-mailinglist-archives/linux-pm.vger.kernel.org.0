Return-Path: <linux-pm+bounces-27474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57311ABFEDE
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 23:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A55451B64CF9
	for <lists+linux-pm@lfdr.de>; Wed, 21 May 2025 21:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67AD2BCF7E;
	Wed, 21 May 2025 21:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="O+JN7rxS"
X-Original-To: linux-pm@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293EA1A5BAC
	for <linux-pm@vger.kernel.org>; Wed, 21 May 2025 21:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747862660; cv=none; b=EkYtYyE8yulyaYpFfroBXkpGKaMnvZtyYxaCMuO9gH2fmP5FNCBOgXm8oBovWTBWRaqZOU1/bh/RB0PpxC+6HRWXllTl3YaNGStud3OugEyjZ5ruhvfNG+xSzvg4VbStNRZKlQ87ARUxq8RbICp6dKu1X89dVzVnectdMoeJqfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747862660; c=relaxed/simple;
	bh=OHgA9xgdiCe7JlP9s02C14pVouo1UjLuOXqqvGF7eYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DtYjVt36/QDkfOkaZjUzv6FZesEUonnoXJHk5NhVe0XmjPJ+3dVCKrrC9k+FQZ2Ae2DJKB6SJ/62E77jIXU+aps5lAYewwY3nv2QjKVytWzpbzMbryHR+aLWrMau7oU+vqoE1SkOys9jTCPdCJs+hMzRPN0UPrdZbmNkHx8HVLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=O+JN7rxS; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747862250;
	bh=vLEw7WaNQ9TyUKGCrdww17iw6jYoTDFvSmJWvNTB4rY=;
	h=From:To:Cc:Subject:Date:From;
	b=O+JN7rxSIB/IvjURNgzw2WmOhx0y/JNIlqhsqJOQN0gWioDT3JBcBxljpEl/5l61t
	 RllBofpZNA+gr2Dxy7nSu4uIoRPG1+km8iQE0RqB1G6ZYR3SB4ojFLBn9rEJv6+CL1
	 QJcsPRUAk+lhvMyqvzWNf78r5QE+b6Q0xxoj5WVg=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4b2klZ1XJcz6y0v;
	Wed, 21 May 2025 21:17:30 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4b2klZ18c2z6xxL;
	Wed, 21 May 2025 21:17:30 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uHqoa-00000000HEZ-3YvZ;
	Wed, 21 May 2025 23:17:28 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH] cpupower: split unitdir from libdir in Makefile
Date: Wed, 21 May 2025 23:14:39 +0200
Message-ID: <20250521211656.65646-1-invernomuto@paranoici.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Improve the installation procedure for the systemd service unit
'cpupower.service', to be more flexible. Some distros install libraries
to /usr/lib64/, but systemd service units have to be installed to
/usr/lib/systemd/system: as a consequence, the installation procedure
should not assume that systemd service units can be installed to
${libdir}/systemd/system ...
Define a dedicated variable ("unitdir") in the Makefile.

Link: https://lore.kernel.org/linux-pm/260b6d79-ab61-43b7-a0eb-813e257bc028@leemhuis.info/T/#m0601940ab439d5cbd288819d2af190ce59e810e6

Fixes: 9c70b779ad91 ("cpupower: add a systemd service to run cpupower")

Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
---
 tools/power/cpupower/Makefile | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index be8dfac14076..c43db1c41205 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -73,6 +73,7 @@ sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
 libdir ?=	/usr/lib
 libexecdir ?=	/usr/libexec
+unitdir ?=	/usr/lib/systemd/system
 includedir ?=	/usr/include
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
@@ -309,9 +310,9 @@ install-tools: $(OUTPUT)cpupower
 	$(INSTALL_DATA) cpupower-service.conf '$(DESTDIR)${confdir}'
 	$(INSTALL) -d $(DESTDIR)${libexecdir}
 	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
-	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
-	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
-	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
+	$(INSTALL) -d $(DESTDIR)${unitdir}
+	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${unitdir}/cpupower.service'
+	$(SETPERM_DATA) '$(DESTDIR)${unitdir}/cpupower.service'
 
 install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
@@ -348,7 +349,7 @@ uninstall:
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
 	- rm -f $(DESTDIR)${confdir}cpupower-service.conf
 	- rm -f $(DESTDIR)${libexecdir}/cpupower
-	- rm -f $(DESTDIR)${libdir}/systemd/system/cpupower.service
+	- rm -f $(DESTDIR)${unitdir}/cpupower.service
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1

base-commit: e5174365c13246ed8fd2d40900edec37be6f7a34
-- 
2.47.2


