Return-Path: <linux-pm+bounces-12857-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2866895E301
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 13:06:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113A71C20BCC
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3154D13A89A;
	Sun, 25 Aug 2024 11:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4+RZmaX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E732F3E;
	Sun, 25 Aug 2024 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724583994; cv=none; b=S+YyyDrD6gAhJVjJrEfP2RxDxfzH/DUnPf7zdFx+04Zvt9ljaTudPyM14xaQwlNzpV6X6+b07x8MQ713Q2upGyZLYA4ESk9OiWi2BoSz9iW5G9/3Vm/EbiCy02la72SPY88s1V4JKiZS6z8KG3wEAwyrHZvuUtBbHNRC7IspRgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724583994; c=relaxed/simple;
	bh=NxXP+9Tj7Ma7qbOuUBw5f+orxXhUo7vqtHJu+g87oX4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4giLDUZp8vyS0Zd28fun3iNGZggHIVV09PAjcMLXHfxgvb8VjB5hQz3JPn18eEUSfTiK9f8RrkhmpiVQw4XB+RioNyLKIFGAWqNA94UP5w606ZDse+U0dZ2F4HkrYqQOwU2Odu1ULI+ATXVBW2ZgN+NrfsFnhnB2ABrp1jcR9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4+RZmaX; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-714226888dfso2999075b3a.1;
        Sun, 25 Aug 2024 04:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724583992; x=1725188792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnIhzNWTBy2dvgbdWu1kUHfrHb98TIY9Kq9/3Jiigb0=;
        b=l4+RZmaXb6LG1LUxrkVWlD3hfnuOtPP9qzFMJ+4jI8Dk0vQGeEqsUNr/4l73We3roI
         +34dwf1q7tOng4CqWdCuWWwU6JJXHFMNZam5WyknnjNnQiCxAKXvObyhnaLn8BJZbSXM
         aGttN1cry9/hhKn+gd8B8aq0iaiv7aco77/UiMw9PxVxeCFJxqEjCsunuDTQZ46qKlpq
         KAq0Q+IG6SQNAriKMO75/Z6bFc8HcW/3o4gRcIZ/BH06cnwjjYohUyzDRJZBRFAAjD4V
         F6MP3yc0rDhIfuNftawndTY5Zw1PfNAZ9bvjKbrmpdgaJFgt6nxozffVQT17Mp6tocZz
         aSUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724583992; x=1725188792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnIhzNWTBy2dvgbdWu1kUHfrHb98TIY9Kq9/3Jiigb0=;
        b=G2+eI0bw+uyMqzDenaXA+iQbf4V2JQkhaF9c1Mc8zMOKkofN2iUa2mDJzqTTcKV2sG
         5udjXYcwhSiPg84dJ3hz5olAdq+dvsz7FMRbM+SX3wWI0D9RJWwrer4C/2qsqr+Mi+/H
         n0z4WaIRo1yMHIK09ghI0EwfUQQypYFaE8peVsgPT6fhXYE11OflNTjb6A/f90DdNtJa
         Ehj8JQOmTNzwhW1G4gkj/kfg4lhIiHH0MczSGyr/ctoBvhf/01v72QNKjFBGKY4Jf6mj
         chbQW2ot4G0oCKt6FIrcd/QhLK8I7VThcGYLrMBVNHqBm5+dsyowlJlPejthnV0T4W7X
         qFMg==
X-Forwarded-Encrypted: i=1; AJvYcCUEtaIVBqkGrddZiM6ItIlAFikpmiiS8CBZZ/O/BgwzDcK6UtxFV8nLtZtUFCNDcofVO1zxsZIiZ1PDWro=@vger.kernel.org, AJvYcCUM6hV+Kp3K2m6xgea7u0YepzUbqGj2FJ+5CsZqmZzyZKSYM/w19vVklFt/2F46uXOsWVLu635FDxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgss5zXNZxsADZfn8SaKHW29jqcC8mQuBH3xM+eO6oYmwBbfEY
	pB1dnNjUdxhK/LZ5rXeltGko71NsppYCvnjzqGs8XTr7J3M+Lorv
X-Google-Smtp-Source: AGHT+IG78cB3xRh69jsCqb3/wOLpy3CcO6Zg3iV0BTDnpDj/H8rutawMDNO+49k4ma/7dkt+wYvorg==
X-Received: by 2002:a05:6a20:439f:b0:1ca:cc16:1ebc with SMTP id adf61e73a8af0-1cc89d29a8amr8094741637.11.1724583991365;
        Sun, 25 Aug 2024 04:06:31 -0700 (PDT)
Received: from localhost.localdomain ([2409:40c1:2c:e57:3d3a:9292:2a7f:6dd4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9acdb54asm6012409a12.42.2024.08.25.04.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 04:06:30 -0700 (PDT)
From: Amit Vadhavana <av2082000@gmail.com>
To: todd.e.brandt@linux.intel.com,
	skhan@linuxfoundation.org,
	ricardo@marliere.net
Cc: av2082000@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] pm-graph: Update directory handling and installation process in Makefile
Date: Sun, 25 Aug 2024 16:36:20 +0530
Message-Id: <20240825110620.30109-1-av2082000@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Standardize directory variables to support more flexible installations.
- Add copyright and licensing information to the Makefile.
- Introduce ".PHONY" declarations to ensure that specific targets are always
  executed, regardless of the presence of files with matching names.
- Add a help target to provide usage instructions.

Signed-off-by: Amit Vadhavana <av2082000@gmail.com>
---
 tools/power/pm-graph/Makefile | 111 ++++++++++++++++++++++------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/tools/power/pm-graph/Makefile b/tools/power/pm-graph/Makefile
index b5310832c19c..aeddbaf2d4c4 100644
--- a/tools/power/pm-graph/Makefile
+++ b/tools/power/pm-graph/Makefile
@@ -1,51 +1,86 @@
 # SPDX-License-Identifier: GPL-2.0
-PREFIX		?= /usr
-DESTDIR		?=
+#
+# Copyright (c) 2013, Intel Corporation.
+#
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2, as published by the Free Software Foundation.
+#
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+#
+# Authors:
+#	 Todd Brandt <todd.e.brandt@linux.intel.com>
+
+# Prefix to the directories we're installing to
+DESTDIR ?=
+
+# Directory definitions. These are default and most probably
+# do not need to be changed. Please note that DESTDIR is
+# added in front of any of them
+
+BINDIR ?=	/usr/bin
+MANDIR ?=	/usr/share/man
+LIBDIR ?=	/usr/lib
+
+# Toolchain: what tools do we use, and what options do they need:
+INSTALL = /usr/bin/install
+INSTALL_DATA  = ${INSTALL} -m 644
 
 all:
 	@echo "Nothing to build"
 
 install : uninstall
-	install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph
-	install sleepgraph.py $(DESTDIR)$(PREFIX)/lib/pm-graph
-	install bootgraph.py $(DESTDIR)$(PREFIX)/lib/pm-graph
-	install -d  $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/cgskip.txt $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/freeze-callgraph.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/freeze.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/freeze-dev.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/standby-callgraph.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/standby.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/standby-dev.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/suspend-callgraph.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/suspend.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/suspend-dev.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-	install -m 644 config/suspend-x2-proc.cfg $(DESTDIR)$(PREFIX)/lib/pm-graph/config
-
-	install -d  $(DESTDIR)$(PREFIX)/bin
-	ln -s ../lib/pm-graph/bootgraph.py $(DESTDIR)$(PREFIX)/bin/bootgraph
-	ln -s ../lib/pm-graph/sleepgraph.py $(DESTDIR)$(PREFIX)/bin/sleepgraph
-
-	install -d  $(DESTDIR)$(PREFIX)/share/man/man8
-	install bootgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
-	install sleepgraph.8 $(DESTDIR)$(PREFIX)/share/man/man8
+	$(INSTALL) -d  $(DESTDIR)$(LIBDIR)/pm-graph
+	$(INSTALL) sleepgraph.py $(DESTDIR)$(LIBDIR)/pm-graph
+	$(INSTALL) bootgraph.py $(DESTDIR)$(LIBDIR)/pm-graph
+	$(INSTALL) -d  $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/cgskip.txt $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/freeze-callgraph.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/freeze.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/freeze-dev.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/standby-callgraph.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/standby.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/standby-dev.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/suspend-callgraph.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/suspend.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/suspend-dev.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+	$(INSTALL_DATA) config/suspend-x2-proc.cfg $(DESTDIR)$(LIBDIR)/pm-graph/config
+
+	$(INSTALL) -d  $(DESTDIR)$(BINDIR)
+	ln -s ../lib/pm-graph/bootgraph.py $(DESTDIR)$(BINDIR)/bootgraph
+	ln -s ../lib/pm-graph/sleepgraph.py $(DESTDIR)$(BINDIR)/sleepgraph
+
+	$(INSTALL) -d  $(DESTDIR)$(MANDIR)/man8
+	$(INSTALL) bootgraph.8 $(DESTDIR)$(MANDIR)/man8
+	$(INSTALL) sleepgraph.8 $(DESTDIR)$(MANDIR)/man8
 
 uninstall :
-	rm -f $(DESTDIR)$(PREFIX)/share/man/man8/bootgraph.8
-	rm -f $(DESTDIR)$(PREFIX)/share/man/man8/sleepgraph.8
+	rm -f $(DESTDIR)$(MANDIR)/man8/bootgraph.8
+	rm -f $(DESTDIR)$(MANDIR)/man8/sleepgraph.8
 
-	rm -f $(DESTDIR)$(PREFIX)/bin/bootgraph
-	rm -f $(DESTDIR)$(PREFIX)/bin/sleepgraph
+	rm -f $(DESTDIR)$(BINDIR)/bootgraph
+	rm -f $(DESTDIR)$(BINDIR)/sleepgraph
 
-	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/config/*
-	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/config ] ; then \
-		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/config; \
+	rm -f $(DESTDIR)$(LIBDIR)/pm-graph/config/*
+	if [ -d $(DESTDIR)$(LIBDIR)/pm-graph/config ] ; then \
+		rmdir $(DESTDIR)$(LIBDIR)/pm-graph/config; \
 	fi;
-	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__/*
-	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__ ] ; then \
-		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph/__pycache__; \
+	rm -f $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__/*
+	if [ -d $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__ ] ; then \
+		rmdir $(DESTDIR)$(LIBDIR)/pm-graph/__pycache__; \
 	fi;
-	rm -f $(DESTDIR)$(PREFIX)/lib/pm-graph/*
-	if [ -d $(DESTDIR)$(PREFIX)/lib/pm-graph ] ; then \
-		rmdir $(DESTDIR)$(PREFIX)/lib/pm-graph; \
+	rm -f $(DESTDIR)$(LIBDIR)/pm-graph/*
+	if [ -d $(DESTDIR)$(LIBDIR)/pm-graph ] ; then \
+		rmdir $(DESTDIR)$(LIBDIR)/pm-graph; \
 	fi;
+
+help:
+	@echo  'Building targets:'
+	@echo  '  all		  - Nothing to build'
+	@echo  '  install	  - Install the program and create necessary directories'
+	@echo  '  uninstall	  - Remove installed files and directories'
+
+.PHONY: all install uninstall help
-- 
2.25.1


