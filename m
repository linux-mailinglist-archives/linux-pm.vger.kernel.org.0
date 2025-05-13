Return-Path: <linux-pm+bounces-27088-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C593AB5A97
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 18:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3C43A6104
	for <lists+linux-pm@lfdr.de>; Tue, 13 May 2025 16:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0341E22FC;
	Tue, 13 May 2025 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="Bq0wx4my"
X-Original-To: linux-pm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [82.94.249.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D1B1DE3CB
	for <linux-pm@vger.kernel.org>; Tue, 13 May 2025 16:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.94.249.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747155328; cv=none; b=fKDdaIHTzEjVyjCfnQaXLNiiq40TpdZV+aa0Y/N6TZFPxh4v2L1XtWgQAXVSyV++Hjy1CVOTUAcpJNq9Yz2V/nPSyVAad6ucF2ih8RG95YzRxIha4hCuGrpJv0nSNIuwuxN6zdjbeZtpugtuH1iJwypPnf0nHbweA3QHBKE7rFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747155328; c=relaxed/simple;
	bh=idjcXr4AW3aS5sRNjH54SgoDueyDr5MtWOE5jKs+qeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ju0fJ6vT2fIO8sAFUv0LDIvJi+cK1slishTEykxUD60jgIKll59i9h/qNL6Y+rtoD0Ix08sREzhmtU4aEeTeVD4okTVNVSiieKkx8s7hfp5jINBIZmDROwf15/c/appOX85KFBQdI1+iI0tbvkm/QRCyoGjHU1Dxe0r9FuLQJVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=Bq0wx4my; arc=none smtp.client-ip=82.94.249.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1747154745;
	bh=eWztpAAb/Kqcm5/81RQihc6lDynmpXfknEZ8NEXt4rc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bq0wx4mynAhBqvAw29Qxow05SpdXGj1WwfQJa6TFySo0c18xN+UU6uz/zTZCpJbH9
	 CTXeK1tnOvr/0jrkqha7nZHwJ852j1q/7dhPomK9N4uvrZAfzn4St2V0xaZAYogmOe
	 M0OOkLBpdAZ9LNZ7Lj5yZ9Znh5HZcSl2vXfQmyjo=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4Zxj5j048DzGp8X;
	Tue, 13 May 2025 16:45:45 +0000 (UTC)
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zxj5h6x8NzGp8R;
	Tue, 13 May 2025 16:45:44 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1uEslE-00000000Goo-0CwT;
	Tue, 13 May 2025 18:45:44 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>,
	Thorsten Leemhuis <linux@leemhuis.info>,
	Justin Forbes <jforbes@redhat.com>
Subject: [PATCH 3/3] cpupower: do not install files to /etc/default/
Date: Tue, 13 May 2025 18:29:33 +0200
Message-ID: <20250513163937.61062-5-invernomuto@paranoici.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513163937.61062-2-invernomuto@paranoici.org>
References: <20250513163937.61062-2-invernomuto@paranoici.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Improve the installation procedure for the systemd service unit
'cpupower.service', to be more distro-agnostic. Do not install the
service unit configuration file to /etc/default/ (a directory that
is used by Debian and Debian-derivatives and only rarely by other
distros).

Also, clarify the role of the configuration file in its own comments.

Link: https://lore.kernel.org/linux-pm/20250509002206.bd2519ba52035d47c3c32aa6@paranoici.org/T/#ma8a3fa80acc4036af6c754e8ecabacc55b288ad1

Fixes: 9c70b779ad91 ("cpupower: add a systemd service to run cpupower")

Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
---
 tools/power/cpupower/Makefile                          |  6 +++---
 tools/power/cpupower/README                            |  6 +++---
 .../{cpupower.default => cpupower-service.conf}        | 10 +++++++---
 tools/power/cpupower/cpupower.service.in               |  4 ++--
 4 files changed, 15 insertions(+), 11 deletions(-)
 rename tools/power/cpupower/{cpupower.default => cpupower-service.conf} (67%)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 7cec2c30f98a..be8dfac14076 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -305,8 +305,8 @@ install-tools: $(OUTPUT)cpupower
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
 	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
-	$(INSTALL) -d $(DESTDIR)${confdir}default
-	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupower'
+	$(INSTALL) -d $(DESTDIR)${confdir}
+	$(INSTALL_DATA) cpupower-service.conf '$(DESTDIR)${confdir}'
 	$(INSTALL) -d $(DESTDIR)${libexecdir}
 	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
 	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
@@ -346,7 +346,7 @@ uninstall:
 	- rm -f $(DESTDIR)${includedir}/cpufreq.h
 	- rm -f $(DESTDIR)${includedir}/cpuidle.h
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
-	- rm -f $(DESTDIR)${confdir}default/cpupower
+	- rm -f $(DESTDIR)${confdir}cpupower-service.conf
 	- rm -f $(DESTDIR)${libexecdir}/cpupower
 	- rm -f $(DESTDIR)${libdir}/systemd/system/cpupower.service
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index 494104de1540..9de449469568 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -195,9 +195,9 @@ command:
 
 $ sudo systemctl daemon-reload
 
-If you want to enable this systemd service, edit
-'${DESTDIR}/etc/default/cpupower' (uncommenting at least one of the options,
-depending on your preferences) and then issue the following command:
+If you want to enable this systemd service, edit '/etc/cpupower-service.conf'
+(uncommenting at least one of the options, depending on your preferences)
+and then issue the following command:
 
 $ sudo systemctl enable --now cpupower.service
 
diff --git a/tools/power/cpupower/cpupower.default b/tools/power/cpupower/cpupower-service.conf
similarity index 67%
rename from tools/power/cpupower/cpupower.default
rename to tools/power/cpupower/cpupower-service.conf
index 376ca40fe5a6..02eabe8e3614 100644
--- a/tools/power/cpupower/cpupower.default
+++ b/tools/power/cpupower/cpupower-service.conf
@@ -2,7 +2,11 @@
 # Copyright (C) 2012, Sébastien Luttringer
 # Copyright (C) 2024-2025, Francesco Poli <invernomuto@paranoici.org>
 
-# Default file for linux-cpupower
+# Configuration file for cpupower.service systemd service unit
+#
+# Edit this file (uncommenting at least one of the options, depending on
+# your preferences) and then enable cpupower.service, if you want cpupower
+# to run at boot with these settings.
 
 # --- CPU clock frequency ---
 
@@ -15,14 +19,14 @@
 #MIN_FREQ="2.25GHz"
 #MAX_FREQ="3GHz"
 
-# Specific frequency to be set.
+# Set a specific frequency
 # Requires userspace governor to be available.
 # If this option is set, all the previous frequency options are ignored
 #FREQ=
 
 # --- CPU policy ---
 
-# Sets a register on supported Intel processore which allows software to convey
+# Set a register on supported Intel processore which allows software to convey
 # its policy for the relative importance of performance versus energy savings to
 # the processor. See man CPUPOWER-SET(1) for additional details
 #PERF_BIAS=
diff --git a/tools/power/cpupower/cpupower.service.in b/tools/power/cpupower/cpupower.service.in
index f91eaed03872..fbd5b8c14270 100644
--- a/tools/power/cpupower/cpupower.service.in
+++ b/tools/power/cpupower/cpupower.service.in
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (C) 2012-2020, Sébastien Luttringer
-# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
+# Copyright (C) 2024-2025, Francesco Poli <invernomuto@paranoici.org>
 
 [Unit]
 Description=Apply cpupower configuration
@@ -8,7 +8,7 @@ ConditionVirtualization=!container
 
 [Service]
 Type=oneshot
-EnvironmentFile=-___CDIR___default/cpupower
+EnvironmentFile=-___CDIR___cpupower-service.conf
 ExecStart=___LDIR___/cpupower
 RemainAfterExit=yes
 
-- 
2.47.2


