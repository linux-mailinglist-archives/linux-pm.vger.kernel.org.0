Return-Path: <linux-pm+bounces-24969-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3597A8170E
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 22:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E0DB8A3BAA
	for <lists+linux-pm@lfdr.de>; Tue,  8 Apr 2025 20:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2023F41D;
	Tue,  8 Apr 2025 20:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b="Wv9wdJLG"
X-Original-To: linux-pm@vger.kernel.org
Received: from latitanza.investici.org (latitanza.investici.org [82.94.249.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F87D225779
	for <linux-pm@vger.kernel.org>; Tue,  8 Apr 2025 20:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.94.249.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744145014; cv=none; b=UmyLQqpMJS0wZfwKx9QN5sitk4haNN+OtR9xBaYC5afxsLl0JfmcXyrExyVpmxVWog0+S2iGCqNmxe1M5pWu43BqX8d9YkZotXCOTYWbcehuY3m4zVCAf2vM54+gP0a0B3HRny58zO+pEQI0WXO80RVEZWW9jS4vhjjwoC9I+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744145014; c=relaxed/simple;
	bh=hE9TlwTLm/No6r+i32j7nhRyV9vuDST0xpyUeZQL1Gc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KO4TS7Dhh0teGLrZ9c4NyLih/fEfVjWmfacj/P7/LLe9zQ7PSYQ8iamIpqI+OTNu9f/SwmLqS8hmbGFzLd6dH5pK0ffAAtOmMM2yMH+uqcKkX7FQDbbic+BCZx2g+lKGSsAZ9vGtivyje4+U/Z1i3oWopanaWcu9+Wx9HHseYx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org; spf=pass smtp.mailfrom=paranoici.org; dkim=pass (1024-bit key) header.d=paranoici.org header.i=@paranoici.org header.b=Wv9wdJLG; arc=none smtp.client-ip=82.94.249.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=paranoici.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paranoici.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=paranoici.org;
	s=stigmate; t=1744144663;
	bh=554QVMBMAfhg+1R2aXTl13i3kNiX36KlOnfhdLgRDCo=;
	h=From:To:Cc:Subject:Date:From;
	b=Wv9wdJLGGIr1iYTK4B0cCm+GrV6s+1Tx6fUFp2OBED4bhD39Nl+LxD0IoRtPxk0M0
	 WFFQHQuSaq2dzSdyq71S50vVSU4zAVFFa4ea7CgQqYBkMNXJdxURwJckSXAyqavSSz
	 HKZUyD8idwDbFoLOcyA15hG0VlOCFTdsPgddzcwY=
Received: from mx3.investici.org (unknown [127.0.0.1])
	by latitanza.investici.org (Postfix) with ESMTP id 4ZXHvW4xzJzGp6N;
	Tue,  8 Apr 2025 20:37:43 +0000 (UTC)
Received: from [82.94.249.234] (mx3.investici.org [82.94.249.234]) (Authenticated sender: invernomuto@paranoici.org) by localhost (Postfix) with ESMTPSA id 4ZXHvW4TCNzGp48;
	Tue,  8 Apr 2025 20:37:43 +0000 (UTC)
Received: from frx by crunch with local (Exim 4.98.2)
	(envelope-from <invernomuto@paranoici.org>)
	id 1u2FhW-000000009xG-1tob;
	Tue, 08 Apr 2025 22:37:42 +0200
From: "Francesco Poli (wintermute)" <invernomuto@paranoici.org>
To: linux-pm list <linux-pm@vger.kernel.org>
Cc: Francesco Poli <invernomuto@paranoici.org>,
	Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B. Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Subject: [PATCH] cpupower: add a systemd service to run cpupower
Date: Tue,  8 Apr 2025 22:32:46 +0200
Message-ID: <20250408203641.37195-1-invernomuto@paranoici.org>
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
 tools/power/cpupower/Makefile            | 14 ++++++++++++
 tools/power/cpupower/README              | 18 +++++++++++++++
 tools/power/cpupower/cpupower.default    | 28 ++++++++++++++++++++++++
 tools/power/cpupower/cpupower.service.in | 16 ++++++++++++++
 tools/power/cpupower/cpupower.sh         | 26 ++++++++++++++++++++++
 5 files changed, 102 insertions(+)
 create mode 100644 tools/power/cpupower/cpupower.default
 create mode 100644 tools/power/cpupower/cpupower.service.in
 create mode 100644 tools/power/cpupower/cpupower.sh

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 51a95239fe06..2bdfb2bfe88a 100644
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
@@ -68,6 +69,7 @@ bindir ?=	/usr/bin
 sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
 libdir ?=	/usr/lib
+libexecdir ?=	/usr/libexec
 includedir ?=	/usr/include
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
@@ -80,6 +82,7 @@ CP = cp -fpR
 INSTALL = /usr/bin/install -c
 INSTALL_PROGRAM = ${INSTALL}
 INSTALL_DATA  = ${INSTALL} -m 644
+SETPERM_DATA  = chmod 644
 #bash completion scripts get sourced and so they should be rw only.
 INSTALL_SCRIPT = ${INSTALL} -m 644
 
@@ -299,6 +302,14 @@ install-tools: $(OUTPUT)cpupower
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
@@ -333,6 +344,9 @@ uninstall:
 	- rm -f $(DESTDIR)${includedir}/cpufreq.h
 	- rm -f $(DESTDIR)${includedir}/cpuidle.h
 	- rm -f $(DESTDIR)${bindir}/utils/cpupower
+	- rm -f $(DESTDIR)${confdir}default/cpupower
+	- rm -f $(DESTDIR)${libexecdir}/cpupower
+	- rm -f $(DESTDIR)${libdir}/systemd/system/cpupower.service
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-set.1
 	- rm -f $(DESTDIR)${mandir}/man1/cpupower-frequency-info.1
diff --git a/tools/power/cpupower/README b/tools/power/cpupower/README
index 2678ed81d311..3c34ef67e0cf 100644
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
@@ -173,6 +181,16 @@ The issue is that binary cannot find the 'libcpupower' library. So, we
 shall point to the lib dir:
 sudo LD_LIBRARY_PATH=lib64/ ./bin/cpupower
 
+systemd service
+---------------
+
+A systemd service is also provided to run the cpupower utility at boot with
+settings read from a configuration file. In order to enable this systemd
+service, edit '${DESTDIR}/etc/default/cpupower' and then issue the following
+command:
+
+$ sudo systemctl enable --now cpupower.service
+
 
 THANKS
 ------
diff --git a/tools/power/cpupower/cpupower.default b/tools/power/cpupower/cpupower.default
new file mode 100644
index 000000000000..b2fd3c37e277
--- /dev/null
+++ b/tools/power/cpupower/cpupower.default
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (C) 2012, Sébastien Luttringer
+# Copyright (C) 2024, Francesco Poli <invernomuto@paranoici.org>
+
+# defaults file for linux-cpupower
+
+# --- CPU clock frequency ---
+
+# Define CPU governor
+# valid governors: ondemand, performance, powersave, conservative, userspace.
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
+# the  processor. See man (1) CPUPOWER-SET for additional details.
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

base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
-- 
2.47.2


