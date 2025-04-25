Return-Path: <linux-pm+bounces-26227-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D894EA9CCB6
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 17:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78C05A0393
	for <lists+linux-pm@lfdr.de>; Fri, 25 Apr 2025 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4396927C84B;
	Fri, 25 Apr 2025 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="W/Df1jB+"
X-Original-To: linux-pm@vger.kernel.org
Received: from devianza.investici.org (devianza.investici.org [198.167.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C919428936E
	for <linux-pm@vger.kernel.org>; Fri, 25 Apr 2025 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.167.222.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745594266; cv=none; b=ljsfc7LvEQwHmCtCRf209ogWj/1Kgmaq2lT66E/DPqE/BjUTZ7l1CnqJWyyVjIw4yi5u1eW4CzYGHqLVr5rvesHri0vcCfiN5enO/fjAh/vYarU7uinyLuTkJCd7I4CipOOnY1WsWyXEwpe7khpk2znIH3zbSXaRRg9qn0n502o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745594266; c=relaxed/simple;
	bh=4UJbLs8wJ2jpwA8/n7MYDq7a6fnTp9XwPe/eAdPzD90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOoS59Je2TncHtNSsZluKptmqOmWL6+oTR39phlk6I1uHnghWZnpjJsaX5+lETsWNPSyUT/h9eZkaI6jOXwII4CSn3TtxO3jlOz7jf108b90kuDHdVB7Fe34Oo9OctFzni1k/S7Mx4InGLJ36bkqTRWWv4g65uz0VcY8HelyRa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=W/Df1jB+; arc=none smtp.client-ip=198.167.222.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1745593864;
	bh=vliWNp12i1GVnUx5gT7vZ3wTYMwe3RgbbYRjuQS7AHA=;
	h=From:To:Cc:Subject:Date:From;
	b=W/Df1jB+Hajda/4M/OoLPgT/c+u/86wyTbELJX3atkO8wY7AchyDICgd7lckuzUdW
	 mrCtpfaR/+fsJ2tF4j+qT5Q/socX0vRAN2rBB7zN/5hQX7WqUVLSonXFhiSMAWqDfl
	 JeHRLBh1cpHI+JSa9UbD/V8qQ5/mx2KucYZ9E+3g=
Received: from mx2.investici.org (unknown [127.0.0.1])
	by devianza.investici.org (Postfix) with ESMTP id 4Zkbrm4kQMz6vNp;
	Fri, 25 Apr 2025 15:11:04 +0000 (UTC)
Received: from [198.167.222.108] (mx2.investici.org [198.167.222.108]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4Zkbrm3zQpz6vNc;
	Fri, 25 Apr 2025 15:11:04 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1u8Khj-00000000Vph-0waI;
	Fri, 25 Apr 2025 17:11:03 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH v2] cpupower: add a systemd service to run cpupower
Date: Fri, 25 Apr 2025 17:07:31 +0200
Message-ID: <20250425151024.121630-1-invernomuto@paranoici.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

One of the most typical use cases of the 'cpupower' utility works as
follows: run 'cpupower' at boot with the desired command-line options
and then forget about it.

Add a systemd service (disabled by default) that automates this use
case (for environments where the initialization system is 'systemd'),
by running 'cpupower' at boot with the settings read from a default
configuration file.

The systemd service, the associated support script and the
corresponding default configuration file are derived from what is
provided by the Arch Linux package (under "GPL-2.0-or-later" terms),
modernized and enhanced in various ways (the script has also been
checked with 'shellcheck').

Link: https://gitlab.archlinux.org/archlinux/packaging/packages/linux-tools/-/tree/dd2e2a311e05413d0d87a0346ffce8c7e98d6d2b

Signed-off-by: Francesco Poli (wintermute) <invernomuto@paranoici.org>
---
 tools/power/cpupower/Makefile            | 15 +++++++++++++
 tools/power/cpupower/README              | 19 ++++++++++++++++
 tools/power/cpupower/cpupower.default    | 28 ++++++++++++++++++++++++
 tools/power/cpupower/cpupower.service.in | 16 ++++++++++++++
 tools/power/cpupower/cpupower.sh         | 26 ++++++++++++++++++++++
 5 files changed, 104 insertions(+)
 create mode 100644 tools/power/cpupower/cpupower.default
 create mode 100644 tools/power/cpupower/cpupower.service.in
 create mode 100644 tools/power/cpupower/cpupower.sh

Patch changelog:
 * Clarified documentation (what should be edited in the default file)
 * Enhanced the comments in the default file
 * Added 'systemctl daemon-reload' to make uninstall, as well
 * Rebased on the tip of the master branch

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 835123add0ed..9c2b5f71fee1 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -2,6 +2,7 @@
 # Makefile for cpupower
 #
 # Copyright (C) 2005,2006 Dominik Brodowski <linux@dominikbrodowski.net>
+# Copyright (C) 2025      Francesco Poli <invernomuto@paranoici.org>
 #
 # Based largely on the Makefile for udev by:
 #
@@ -71,6 +72,7 @@ bindir ?=	/usr/bin
 sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
 libdir ?=	/usr/lib
+libexecdir ?=	/usr/libexec
 includedir ?=	/usr/include
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
@@ -83,6 +85,7 @@ CP = cp -fpR
 INSTALL = /usr/bin/install -c
 INSTALL_PROGRAM = ${INSTALL}
 INSTALL_DATA  = ${INSTALL} -m 644
+SETPERM_DATA  = chmod 644
 #bash completion scripts get sourced and so they should be rw only.
 INSTALL_SCRIPT = ${INSTALL} -m 644
 
@@ -302,6 +305,14 @@ install-tools: $(OUTPUT)cpupower
 	$(INSTALL_PROGRAM) $(OUTPUT)cpupower $(DESTDIR)${bindir}
 	$(INSTALL) -d $(DESTDIR)${bash_completion_dir}
 	$(INSTALL_SCRIPT) cpupower-completion.sh '$(DESTDIR)${bash_completion_dir}/cpupower'
+	$(INSTALL) -d $(DESTDIR)${confdir}default
+	$(INSTALL_DATA) cpupower.default '$(DESTDIR)${confdir}default/cpupower'
+	$(INSTALL) -d $(DESTDIR)${libexecdir}
+	$(INSTALL_PROGRAM) cpupower.sh '$(DESTDIR)${libexecdir}/cpupower'
+	$(INSTALL) -d $(DESTDIR)${libdir}/systemd/system
+	sed 's|___CDIR___|$(DESTDIR)${confdir}|; s|___LDIR___|$(DESTDIR)${libexecdir}|' cpupower.service.in > '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
+	$(SETPERM_DATA) '$(DESTDIR)${libdir}/systemd/system/cpupower.service'
+	if test -d /run/systemd/system; then systemctl daemon-reload; fi
 
 install-man:
 	$(INSTALL_DATA) -D man/cpupower.1 $(DESTDIR)${mandir}/man1/cpupower.1
@@ -336,6 +347,9 @@ uninstall:
 	- rm -f $(DESTDIR)${includedir}/cpufreq.h
 	- rm -f $(DESTDIR)${includedir}/cpuidle.h
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
+	- rm -f $(DESTDIR)${confdir}default/cpupower
+	- rm -f $(DESTDIR)${libexecdir}/cpupower
+	- rm -f $(DESTDIR)${libdir}/systemd/system/cpupower.service
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1
@@ -346,6 +360,7 @@ uninstall:
 	- for HLANG in $(LANGUAGES); do \
 		rm -f $(DESTDIR)${localedir}/$$HLANG/LC_MESSAGES/cpupower.mo; \
 	  done;
+	- if test -d /run/systemd/system; then systemctl daemon-reload; fi
 
 help:
 	@echo  'Building targets:'
diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index 2678ed81d311..e6ae7c1e0a0d 100644
--- a/tools/power/cpupower/README
+++ b/tools/power/cpupower/README
@@ -59,6 +59,10 @@ $ sudo make install
 -----------------------------------------------------------------------
 | man pages              | /usr/man                                   |
 -----------------------------------------------------------------------
+| systemd service        | /usr/lib                                   |
+-----------------------------------------------------------------------
+| systemd support script | /usr/libexec                               |
+-----------------------------------------------------------------------
 
 To put it in other words it makes build results available system-wide,
 enabling any user to simply start using it without any additional steps
@@ -109,6 +113,10 @@ The files will be installed to the following dirs:
 -----------------------------------------------------------------------
 | man pages              | ${DESTDIR}/usr/man                         |
 -----------------------------------------------------------------------
+| systemd service        | ${DESTDIR}/usr/lib                         |
+-----------------------------------------------------------------------
+| systemd support script | ${DESTDIR}/usr/libexec                     |
+-----------------------------------------------------------------------
 
 If you look at the table for the default 'make' output dirs you will
 notice that the only difference with the non-default case is the
@@ -173,6 +181,17 @@ The issue is that binary cannot find the 'libcpupower' library. So, we
 shall point to the lib dir:
 sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
 
+systemd service
+---------------
+
+A systemd service is also provided to run the cpupower utility at boot with
+settings read from a configuration file. In order to enable this systemd
+service, edit '${DESTDIR}/etc/default/cpupower' (uncommenting at least one of
+the options, depending on your preferences) and then issue the following
+command:
+
+$ sudo systemctl enable --now cpupower.service
+
 
 THANKS
 ------
diff --git a/tools/power/cpupower/cpupower.default b/tools/power/cpupower/cpupower.default
new file mode 100644
index 000000000000..376ca40fe5a6
--- /dev/null
+++ b/tools/power/cpupower/cpupower.default
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2012, Sébastien Luttringer
+# Copyright (C) 2024-2025, Francesco Poli <invernomuto@paranoici.org>
+
+# Default file for linux-cpupower
+
+# --- CPU clock frequency ---
+
+# Define CPU governor
+# Valid governors: ondemand, performance, powersave, conservative, userspace
+#GOVERNOR='ondemand'
+
+# Limit frequency range
+# Valid suffixes: Hz, kHz (default), MHz, GHz, THz
+#MIN_FREQ="2.25GHz"
+#MAX_FREQ="3GHz"
+
+# Specific frequency to be set.
+# Requires userspace governor to be available.
+# If this option is set, all the previous frequency options are ignored
+#FREQ=
+
+# --- CPU policy ---
+
+# Sets a register on supported Intel processore which allows software to convey
+# its policy for the relative importance of performance versus energy savings to
+# the processor. See man CPUPOWER-SET(1) for additional details
+#PERF_BIAS=
diff --git a/tools/power/cpupower/cpupower.service.in b/tools/power/cpupower/cpupower.service.in
new file mode 100644
index 000000000000..f91eaed03872
--- /dev/null
+++ b/tools/power/cpupower/cpupower.service.in
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2012-2020, Sébastien Luttringer
+# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
+
+[Unit]
+Description=Apply cpupower configuration
+ConditionVirtualization=!container
+
+[Service]
+Type=oneshot
+EnvironmentFile=-___CDIR___default/cpupower
+ExecStart=___LDIR___/cpupower
+RemainAfterExit=yes
+
+[Install]
+WantedBy=multi-user.target
diff --git a/tools/power/cpupower/cpupower.sh b/tools/power/cpupower/cpupower.sh
new file mode 100644
index 000000000000..a37dd4cfdb2b
--- /dev/null
+++ b/tools/power/cpupower/cpupower.sh
@@ -0,0 +1,26 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2012, Sébastien Luttringer
+# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
+
+ESTATUS=0
+
+# apply CPU clock frequency options
+if test -n "$FREQ"
+then
+    cpupower frequency-set -f "$FREQ" > /dev/null || ESTATUS=1
+elif test -n "${GOVERNOR}${MIN_FREQ}${MAX_FREQ}"
+then
+    cpupower frequency-set \
+      ${GOVERNOR:+ -g "$GOVERNOR"} \
+      ${MIN_FREQ:+ -d "$MIN_FREQ"} ${MAX_FREQ:+ -u "$MAX_FREQ"} \
+      > /dev/null || ESTATUS=1
+fi
+
+# apply CPU policy options
+if test -n "$PERF_BIAS"
+then
+    cpupower set -b "$PERF_BIAS" > /dev/null || ESTATUS=1
+fi
+
+exit $ESTATUS

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.47.2


