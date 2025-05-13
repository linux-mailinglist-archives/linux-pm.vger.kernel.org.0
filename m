Return-Path: <linux-pm+bounces-27086-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0580AB5A80
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEFC23A8120
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F2C1DDC28;
	Tue, 13 May 2025 16:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="jVFlJO8i"
X-Original-To: linux-pm@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5B1A76DA
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747154741; cv=none; b=cg4pTtkAX0Q0mNjtpSbMF72+UNkvOE4HHNZfZXi6ZSppkAlee6ALpu/uiOY1ooRe5z6J+e1pUlJOr2imcFutJTumbVbjDvcTu8IMW6Ex1wZo+pvw9H7Sa+kFCUhN0BrNXj7XWfflUzjjFlSC0D9etZN6g/dvD5rKcpsO6NmXqDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747154741; c=relaxed/simple;
	bh=11ikuz21sbx1DS6gP9D/N/M3mRjDTmv8KRFDhd7RR2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8a3Noakbp1rxBndW/r2uXFHxCHas0yk0k3amYKxE94N/5RcYlZzzwyashqDNudRsBhiMFyYDJayybvDhi0UYukQc6wuE+O5sl49ZfIINqGhccZMXTpNbdd4w0KjXk2ppQYc7h90Y4eoSKXfc0Tq3JsEsbjbJegPXPgT/Xwfshg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=jVFlJO8i; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747154736;
	bh=lLOd7tQ76Z9Dv/K7XoIbBfnbDergJ6kT2rO4vhZGoUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVFlJO8io2lAonBrVmYYBJZ/H4PpE/iFiV6UFgXVbyfmd+FBCI/HIB6ws+s8TF8HV
	 74MIbTOpHGkvCoDb80toA0XIXjgHF/bDMY5lc75tk7nn8pl78+XtjRubjwqnOpE55V
	 HQ0bJITQSvHNPzD6OWyMgZ9uHWTtHJILajZbyOA4=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4Zxj5X4r20z6xg3;
	Tue, 13 May 2025 16:45:36 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zxj5X4Vgzz6xfm;
	Tue, 13 May 2025 16:45:36 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uEsl5-00000000GoK-3SAg;
	Tue, 13 May 2025 18:45:35 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH 2/3] cpupower: do not call systemctl at install time
Date: Tue, 13 May 2025 18:29:32 +0200
Message-ID: <20250513163937.61062-4-invernomuto@paranoici.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513163937.61062-2-invernomuto@paranoici.org>
References: <20250513163937.61062-2-invernomuto@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the installation procedure for the systemd service unit
'cpupower.service'. Do not call "systemctl daemon-reload" in the
Makefile, but explain when this command should be manually issued
in the README file.

Link: https://lore.kernel.org/linux-pm/20250509002206.bd2519ba52035d47c3c32aa6@paranoici.org/T/#mfbb938f9c0d5a21173acb92a061eb9205fd0abfe

Fixes: 9c70b779ad91 ("cpupower: add a systemd service to run cpupower")

Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
---
 tools/power/cpupower/Makefile |  2 --
 tools/power/cpupower/README   | 19 ++++++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 4ad931509eaa..7cec2c30f98a 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -312,7 +312,6 @@ install-tools: $(OUTPUT)cpupower
 	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
 	sed 's|___CDIR___|${confdir}|; s|___LDIR___|${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
 	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
-	if test -d /run/systemd/system; then systemctl daemon-reload; fi
 
 install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
@@ -360,7 +359,6 @@ uninstall:
 	- for HLANG in $(LANGUAGES); do \
 		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	  done;
-	- if test -d /run/systemd/system; then systemctl daemon-reload; fi
 
 help:
 	@echo  'Building targets:'
diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index e6ae7c1e0a0d..494104de1540 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -59,7 +59,7 @@ $ sudo make install
 -----------------------------------------------------------------------
 | man pages              | /usr/man                                   |
 -----------------------------------------------------------------------
-| systemd service        | /usr/lib                                   |
+| systemd service        | /usr/lib/systemd/system                    |
 -----------------------------------------------------------------------
 | systemd support script | /usr/libexec                               |
 -----------------------------------------------------------------------
@@ -113,7 +113,7 @@ The files will be installed to the following dirs:
 -----------------------------------------------------------------------
 | man pages              | ${DESTDIR}/usr/man                         |
 -----------------------------------------------------------------------
-| systemd service        | ${DESTDIR}/usr/lib                         |
+| systemd service        | ${DESTDIR}/usr/lib/systemd/system          |
 -----------------------------------------------------------------------
 | systemd support script | ${DESTDIR}/usr/libexec                     |
 -----------------------------------------------------------------------
@@ -185,11 +185,20 @@ systemd service
 ---------------
 
 A systemd service is also provided to run the cpupower utility at boot with
-settings read from a configuration file. In order to enable this systemd
-service, edit '${DESTDIR}/etc/default/cpupower' (uncommenting at least one of
-the options, depending on your preferences) and then issue the following
+settings read from a configuration file.
+
+If you want systemd to find the new service after the installation, the service
+unit must have been installed in one of the system unit search path directories
+(such as '/usr/lib/systemd/system/', which is the default location) and (unless
+you are willing to wait for the next reboot) you need to issue the following
 command:
 
+$ sudo systemctl daemon-reload
+
+If you want to enable this systemd service, edit
+'${DESTDIR}/etc/default/cpupower' (uncommenting at least one of the options,
+depending on your preferences) and then issue the following command:
+
 $ sudo systemctl enable --now cpupower.service
 
 
-- 
2.47.2


