Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC05F52D2CB
	for <lists+linux-pm@lfdr.de>; Thu, 19 May 2022 14:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238017AbiESMoX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 May 2022 08:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238010AbiESMoV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2022 08:44:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C727ABA999
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2022 05:44:18 -0700 (PDT)
Date:   Thu, 19 May 2022 12:44:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652964257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HedsWo133YpgFk8vP0dU7Ah92afDYTXt0q0+sqA8sAw=;
        b=tZuFSU2wikVPGGgNsRLCHLQp9TFfByJ/OKrQU/VfS1hlNezeNHXQtaHrOCHBpzp9KaStTE
        hilZoT33G3emiz3Ehl5bs/qYWALfYpxIrGyLUzi6mPqqMvphy2Da2f+jHMXyoESNTOCF7K
        hkgZswmsKmI/33otAym7aaCn54JLmvX2COYCD4p9ycF43O87ZCwZw5wky/KLWo4svFlTbK
        ZabA25VGXH+nEplHQVwgLGIKrnEEBijCe6lKbSn4yC14IU6htkm/0XpqA5Yv6rg5l+1qTc
        c7L/9uvwBFJL66+XR+3uhB56nGuf6wnRYWLHX+bWwAFjRD3Y0fPFTJorsmlGHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652964257;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HedsWo133YpgFk8vP0dU7Ah92afDYTXt0q0+sqA8sAw=;
        b=sgjx7UgtZP3ZIo4dv+RfmQelt+aBibitgV5DSOd/slLWqsOYFq10ydhd5jrfjy96ll5Uk9
        dj+XU3URS1KOYZDw==
From:   "thermal-bot for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] tools/thermal: Add util library
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <20220420160933.347088-3-daniel.lezcano@linaro.org>
References: <20220420160933.347088-3-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Message-ID: <165296425640.4207.6207139709414814267.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     3b7c5e8adf9ca64f8dd70279076de085ea6369d7
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//3b7c5e8adf9ca64f8dd70279076de085ea6369d7
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Wed, 20 Apr 2022 18:09:30 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 19 May 2022 12:11:51 +02:00

tools/thermal: Add util library

The next changes will provide a couple of tools using some common
functions provided by this library.

It provides basic wrappers for:

 - mainloop
 - logging
 - timestamp

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Tested-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Link: https://lore.kernel.org/r/20220420160933.347088-3-daniel.lezcano@linaro.org
---
 tools/thermal/lib/Build                        |   3 +-
 tools/thermal/lib/Makefile                     | 158 ++++++++++++++++-
 tools/thermal/lib/libthermal_tools.pc.template |  12 +-
 tools/thermal/lib/log.c                        |  77 ++++++++-
 tools/thermal/lib/log.h                        |  31 +++-
 tools/thermal/lib/mainloop.c                   | 120 ++++++++++++-
 tools/thermal/lib/mainloop.h                   |  15 ++-
 tools/thermal/lib/thermal-tools.h              |  10 +-
 tools/thermal/lib/uptimeofday.c                |  40 ++++-
 tools/thermal/lib/uptimeofday.h                |  12 +-
 10 files changed, 478 insertions(+)
 create mode 100644 tools/thermal/lib/Build
 create mode 100644 tools/thermal/lib/Makefile
 create mode 100644 tools/thermal/lib/libthermal_tools.pc.template
 create mode 100644 tools/thermal/lib/log.c
 create mode 100644 tools/thermal/lib/log.h
 create mode 100644 tools/thermal/lib/mainloop.c
 create mode 100644 tools/thermal/lib/mainloop.h
 create mode 100644 tools/thermal/lib/thermal-tools.h
 create mode 100644 tools/thermal/lib/uptimeofday.c
 create mode 100644 tools/thermal/lib/uptimeofday.h

diff --git a/tools/thermal/lib/Build b/tools/thermal/lib/Build
new file mode 100644
index 0000000..06f2276
--- /dev/null
+++ b/tools/thermal/lib/Build
@@ -0,0 +1,3 @@
+libthermal_tools-y += mainloop.o
+libthermal_tools-y += log.o
+libthermal_tools-y += uptimeofday.o
diff --git a/tools/thermal/lib/Makefile b/tools/thermal/lib/Makefile
new file mode 100644
index 0000000..82db451
--- /dev/null
+++ b/tools/thermal/lib/Makefile
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+# Most of this file is copied from tools/lib/perf/Makefile
+
+LIBTHERMAL_TOOLS_VERSION = 0
+LIBTHERMAL_TOOLS_PATCHLEVEL = 0
+LIBTHERMAL_TOOLS_EXTRAVERSION = 1
+
+MAKEFLAGS += --no-print-directory
+
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+# $(info Determined 'srctree' to be $(srctree))
+endif
+
+INSTALL = install
+
+# Use DESTDIR for installing into a different root directory.
+# This is useful for building a package. The program will be
+# installed in this directory as if it was the root directory.
+# Then the build tool can move it later.
+DESTDIR ?=
+DESTDIR_SQ = '$(subst ','\'',$(DESTDIR))'
+
+include $(srctree)/tools/scripts/Makefile.include
+include $(srctree)/tools/scripts/Makefile.arch
+
+ifeq ($(LP64), 1)
+  libdir_relative = lib64
+else
+  libdir_relative = lib
+endif
+
+prefix ?=
+libdir = $(prefix)/$(libdir_relative)
+
+# Shell quotes
+libdir_SQ = $(subst ','\'',$(libdir))
+libdir_relative_SQ = $(subst ','\'',$(libdir_relative))
+
+ifeq ("$(origin V)", "command line")
+  VERBOSE = $(V)
+endif
+ifndef VERBOSE
+  VERBOSE = 0
+endif
+
+ifeq ($(VERBOSE),1)
+  Q =
+else
+  Q = @
+endif
+
+# Set compile option CFLAGS
+ifdef EXTRA_CFLAGS
+  CFLAGS := $(EXTRA_CFLAGS)
+else
+  CFLAGS := -g -Wall
+endif
+
+INCLUDES = \
+-I/usr/include/libnl3 \
+-I$(srctree)/tools/lib/thermal/include \
+-I$(srctree)/tools/lib/ \
+-I$(srctree)/tools/include \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/ \
+-I$(srctree)/tools/arch/$(SRCARCH)/include/uapi \
+-I$(srctree)/tools/include/uapi
+
+# Append required CFLAGS
+override CFLAGS += $(EXTRA_WARNINGS)
+override CFLAGS += -Werror -Wall
+override CFLAGS += -fPIC
+override CFLAGS += $(INCLUDES)
+override CFGLAS += -Wl,-L.
+override CFGLAS += -Wl,-lthermal
+
+all:
+
+export srctree OUTPUT CC LD CFLAGS V
+export DESTDIR DESTDIR_SQ
+
+include $(srctree)/tools/build/Makefile.include
+
+PATCHLEVEL    = $(LIBTHERMAL_TOOLS_PATCHLEVEL)
+EXTRAVERSION  = $(LIBTHERMAL_TOOLS_EXTRAVERSION)
+VERSION       = $(LIBTHERMAL_TOOLS_VERSION).$(LIBTHERMAL_TOOLS_PATCHLEVEL).$(LIBTHERMAL_TOOLS_EXTRAVERSION)
+
+LIBTHERMAL_TOOLS_SO := $(OUTPUT)libthermal_tools.so.$(VERSION)
+LIBTHERMAL_TOOLS_A  := $(OUTPUT)libthermal_tools.a
+LIBTHERMAL_TOOLS_IN := $(OUTPUT)libthermal_tools-in.o
+LIBTHERMAL_TOOLS_PC := $(OUTPUT)libthermal_tools.pc
+
+LIBTHERMAL_TOOLS_ALL := $(LIBTHERMAL_TOOLS_A) $(OUTPUT)libthermal_tools.so*
+
+$(LIBTHERMAL_TOOLS_IN): FORCE
+	$(Q)$(MAKE) $(build)=libthermal_tools
+
+$(LIBTHERMAL_TOOLS_A): $(LIBTHERMAL_TOOLS_IN)
+	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIBTHERMAL_TOOLS_IN)
+
+$(LIBTHERMAL_TOOLS_SO): $(LIBTHERMAL_TOOLS_IN)
+	$(QUIET_LINK)$(CC) --shared -Wl,-soname,libthermal_tools.so $^ -o $@
+	@ln -sf $(@F) $(OUTPUT)libthermal_tools.so
+	@ln -sf $(@F) $(OUTPUT)libthermal_tools.so.$(LIBTHERMAL_TOOLS_VERSION)
+
+
+libs: $(LIBTHERMAL_TOOLS_A) $(LIBTHERMAL_TOOLS_SO) $(LIBTHERMAL_TOOLS_PC)
+
+all: fixdep
+	$(Q)$(MAKE) libs
+
+clean:
+	$(call QUIET_CLEAN, libthermal_tools) $(RM) $(LIBTHERMAL_TOOLS_A) \
+                *.o *~ *.a *.so *.so.$(VERSION) *.so.$(LIBTHERMAL_TOOLS_VERSION) .*.d .*.cmd LIBTHERMAL_TOOLS-CFLAGS $(LIBTHERMAL_TOOLS_PC)
+
+$(LIBTHERMAL_TOOLS_PC):
+	$(QUIET_GEN)sed -e "s|@PREFIX@|$(prefix)|" \
+		-e "s|@LIBDIR@|$(libdir_SQ)|" \
+		-e "s|@VERSION@|$(VERSION)|" \
+		< libthermal_tools.pc.template > $@
+
+define do_install_mkdir
+	if [ ! -d '$(DESTDIR_SQ)$1' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$1'; \
+	fi
+endef
+
+define do_install
+	if [ ! -d '$(DESTDIR_SQ)$2' ]; then             \
+		$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$2'; \
+	fi;                                             \
+	$(INSTALL) $1 $(if $3,-m $3,) '$(DESTDIR_SQ)$2'
+endef
+
+install_lib: libs
+	$(call QUIET_INSTALL, $(LIBTHERMAL_TOOLS_ALL)) \
+		$(call do_install_mkdir,$(libdir_SQ)); \
+		cp -fpR $(LIBTHERMAL_TOOLS_ALL) $(DESTDIR)$(libdir_SQ)
+
+install_headers:
+	$(call QUIET_INSTALL, headers) \
+		$(call do_install,include/thermal.h,$(prefix)/include/thermal,644); \
+
+install_pkgconfig: $(LIBTHERMAL_TOOLS_PC)
+	$(call QUIET_INSTALL, $(LIBTHERMAL_TOOLS_PC)) \
+		$(call do_install,$(LIBTHERMAL_TOOLS_PC),$(libdir_SQ)/pkgconfig,644)
+
+install_doc:
+	$(Q)$(MAKE) -C Documentation install-man install-html install-examples
+
+#install: install_lib install_headers install_pkgconfig install_doc
+install: install_lib install_headers install_pkgconfig
+
+FORCE:
+
+.PHONY: all install clean FORCE
diff --git a/tools/thermal/lib/libthermal_tools.pc.template b/tools/thermal/lib/libthermal_tools.pc.template
new file mode 100644
index 0000000..6f37697
--- /dev/null
+++ b/tools/thermal/lib/libthermal_tools.pc.template
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
+
+prefix=@PREFIX@
+libdir=@LIBDIR@
+includedir=${prefix}/include
+
+Name: libthermal
+Description: thermal library
+Requires: libnl-3.0 libnl-genl-3.0
+Version: @VERSION@
+Libs: -L${libdir} -lnl-genl-3 -lnl-3
+Cflags: -I${includedir} -I{include}/libnl3
diff --git a/tools/thermal/lib/log.c b/tools/thermal/lib/log.c
new file mode 100644
index 0000000..597d6e7
--- /dev/null
+++ b/tools/thermal/lib/log.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <syslog.h>
+#include "log.h"
+
+static const char *__ident = "unknown";
+static int __options;
+
+static const char * const loglvl[] = {
+	[LOG_DEBUG]	= "DEBUG",
+	[LOG_INFO]	= "INFO",
+	[LOG_NOTICE]	= "NOTICE",
+	[LOG_WARNING]	= "WARN",
+	[LOG_ERR]	= "ERROR",
+	[LOG_CRIT]	= "CRITICAL",
+	[LOG_ALERT]	= "ALERT",
+	[LOG_EMERG]	= "EMERG",
+};
+
+int log_str2level(const char *lvl)
+{
+	int i;
+
+	for (i = 0; i < sizeof(loglvl) / sizeof(loglvl[LOG_DEBUG]); i++)
+		if (!strcmp(lvl, loglvl[i]))
+			return i;
+
+	return LOG_DEBUG;
+}
+
+extern void logit(int level, const char *format, ...)
+{
+	va_list args;
+
+	va_start(args, format);
+
+	if (__options & TO_SYSLOG)
+		vsyslog(level, format, args);
+
+	if (__options & TO_STDERR)
+		vfprintf(stderr, format, args);
+
+	if (__options & TO_STDOUT)
+		vfprintf(stdout, format, args);
+
+	va_end(args);
+}
+
+int log_init(int level, const char *ident, int options)
+{
+	if (!options)
+		return -1;
+
+	if (level > LOG_DEBUG)
+		return -1;
+
+	if (!ident)
+		return -1;
+
+	__ident = ident;
+	__options = options;
+
+	if (options & TO_SYSLOG) {
+		openlog(__ident, options | LOG_NDELAY, LOG_USER);
+		setlogmask(LOG_UPTO(level));
+	}
+
+	return 0;
+}
+
+void log_exit(void)
+{
+	closelog();
+}
diff --git a/tools/thermal/lib/log.h b/tools/thermal/lib/log.h
new file mode 100644
index 0000000..be8ab51
--- /dev/null
+++ b/tools/thermal/lib/log.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS_LOG_H
+#define __THERMAL_TOOLS_LOG_H
+
+#include <syslog.h>
+
+#ifndef __maybe_unused
+#define __maybe_unused		__attribute__((__unused__))
+#endif
+
+#define TO_SYSLOG 0x1
+#define TO_STDOUT 0x2
+#define TO_STDERR 0x4
+
+extern void logit(int level, const char *format, ...);
+
+#define DEBUG(fmt, ...)		logit(LOG_DEBUG, "%s:%d: " fmt, __func__, __LINE__, ##__VA_ARGS__)
+#define INFO(fmt, ...)		logit(LOG_INFO, fmt, ##__VA_ARGS__)
+#define NOTICE(fmt, ...)	logit(LOG_NOTICE, fmt, ##__VA_ARGS__)
+#define WARN(fmt, ...)		logit(LOG_WARNING, fmt, ##__VA_ARGS__)
+#define ERROR(fmt, ...)		logit(LOG_ERR, fmt, ##__VA_ARGS__)
+#define CRITICAL(fmt, ...)	logit(LOG_CRIT, fmt, ##__VA_ARGS__)
+#define ALERT(fmt, ...)		logit(LOG_ALERT, fmt, ##__VA_ARGS__)
+#define EMERG(fmt, ...)		logit(LOG_EMERG, fmt, ##__VA_ARGS__)
+
+int log_init(int level, const char *ident, int options);
+int log_str2level(const char *lvl);
+void log_exit(void);
+
+#endif
diff --git a/tools/thermal/lib/mainloop.c b/tools/thermal/lib/mainloop.c
new file mode 100644
index 0000000..94cbbcb
--- /dev/null
+++ b/tools/thermal/lib/mainloop.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdlib.h>
+#include <errno.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/epoll.h>
+#include "mainloop.h"
+#include "log.h"
+
+static int epfd = -1;
+static unsigned short nrhandler;
+static sig_atomic_t exit_mainloop;
+
+struct mainloop_data {
+	mainloop_callback_t cb;
+	void *data;
+	int fd;
+};
+
+static struct mainloop_data **mds;
+
+#define MAX_EVENTS 10
+
+int mainloop(unsigned int timeout)
+{
+	int i, nfds;
+	struct epoll_event events[MAX_EVENTS];
+	struct mainloop_data *md;
+
+	if (epfd < 0)
+		return -1;
+
+	for (;;) {
+
+		nfds = epoll_wait(epfd, events, MAX_EVENTS, timeout);
+
+		if (exit_mainloop || !nfds)
+			return 0;
+
+		if (nfds < 0) {
+			if (errno == EINTR)
+				continue;
+			return -1;
+		}
+
+		for (i = 0; i < nfds; i++) {
+			md = events[i].data.ptr;
+
+			if (md->cb(md->fd, md->data) > 0)
+				return 0;
+		}
+	}
+}
+
+int mainloop_add(int fd, mainloop_callback_t cb, void *data)
+{
+	struct epoll_event ev = {
+		.events = EPOLLIN,
+	};
+
+	struct mainloop_data *md;
+
+	if (fd >= nrhandler) {
+		mds = realloc(mds, sizeof(*mds) * (fd + 1));
+		if (!mds)
+			return -1;
+		nrhandler = fd + 1;
+	}
+
+	md = malloc(sizeof(*md));
+	if (!md)
+		return -1;
+
+	md->data = data;
+	md->cb = cb;
+	md->fd = fd;
+
+	mds[fd] = md;
+	ev.data.ptr = md;
+
+	if (epoll_ctl(epfd, EPOLL_CTL_ADD, fd, &ev) < 0) {
+		free(md);
+		return -1;
+	}
+
+	return 0;
+}
+
+int mainloop_del(int fd)
+{
+	if (fd >= nrhandler)
+		return -1;
+
+	if (epoll_ctl(epfd, EPOLL_CTL_DEL, fd, NULL) < 0)
+		return -1;
+
+	free(mds[fd]);
+
+	return 0;
+}
+
+int mainloop_init(void)
+{
+	epfd = epoll_create(2);
+	if (epfd < 0)
+		return -1;
+
+	return 0;
+}
+
+void mainloop_exit(void)
+{
+	exit_mainloop = 1;
+}
+
+void mainloop_fini(void)
+{
+	close(epfd);
+}
diff --git a/tools/thermal/lib/mainloop.h b/tools/thermal/lib/mainloop.h
new file mode 100644
index 0000000..89b61e8
--- /dev/null
+++ b/tools/thermal/lib/mainloop.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS_MAINLOOP_H
+#define __THERMAL_TOOLS_MAINLOOP_H
+
+typedef int (*mainloop_callback_t)(int fd, void *data);
+
+extern int mainloop(unsigned int timeout);
+extern int mainloop_add(int fd, mainloop_callback_t cb, void *data);
+extern int mainloop_del(int fd);
+extern void mainloop_exit(void);
+extern int mainloop_init(void);
+extern void mainloop_fini(void);
+
+#endif
diff --git a/tools/thermal/lib/thermal-tools.h b/tools/thermal/lib/thermal-tools.h
new file mode 100644
index 0000000..f43939a
--- /dev/null
+++ b/tools/thermal/lib/thermal-tools.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS
+#define __THERMAL_TOOLS
+
+#include "log.h"
+#include "mainloop.h"
+#include "uptimeofday.h"
+
+#endif
diff --git a/tools/thermal/lib/uptimeofday.c b/tools/thermal/lib/uptimeofday.c
new file mode 100644
index 0000000..dacb029
--- /dev/null
+++ b/tools/thermal/lib/uptimeofday.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: LGPL-2.1+
+// Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org>
+#include <stdio.h>
+#include <sys/time.h>
+#include <linux/sysinfo.h>
+#include "thermal-tools.h"
+
+static unsigned long __offset;
+static struct timeval __tv;
+
+int uptimeofday_init(void)
+{
+	struct sysinfo info;
+
+	if (sysinfo(&info))
+		return -1;
+
+	gettimeofday(&__tv, NULL);
+
+	__offset = __tv.tv_sec - info.uptime;
+
+	return 0;
+}
+
+unsigned long getuptimeofday_ms(void)
+{
+	gettimeofday(&__tv, NULL);
+
+	return ((__tv.tv_sec - __offset) * 1000) + (__tv.tv_usec / 1000);
+}
+
+struct timespec msec_to_timespec(int msec)
+{
+	struct timespec tv = {
+		.tv_sec = (msec / 1000),
+		.tv_nsec = (msec % 1000) * 1000000,
+	};
+
+	return tv;
+}
diff --git a/tools/thermal/lib/uptimeofday.h b/tools/thermal/lib/uptimeofday.h
new file mode 100644
index 0000000..c0da5de
--- /dev/null
+++ b/tools/thermal/lib/uptimeofday.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: LGPL-2.1+ */
+/* Copyright (C) 2022, Linaro Ltd - Daniel Lezcano <daniel.lezcano@linaro.org> */
+#ifndef __THERMAL_TOOLS_UPTIMEOFDAY_H
+#define __THERMAL_TOOLS_UPTIMEOFDAY_H
+#include <sys/sysinfo.h>
+#include <sys/time.h>
+
+int uptimeofday_init(void);
+unsigned long getuptimeofday_ms(void);
+struct timespec msec_to_timespec(int msec);
+
+#endif
