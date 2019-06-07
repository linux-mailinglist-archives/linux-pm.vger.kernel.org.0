Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05933391C5
	for <lists+linux-pm@lfdr.de>; Fri,  7 Jun 2019 18:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbfFGQUp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 7 Jun 2019 12:20:45 -0400
Received: from 19.mo4.mail-out.ovh.net ([87.98.179.66]:37586 "EHLO
        19.mo4.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbfFGQUo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Jun 2019 12:20:44 -0400
X-Greylist: delayed 2393 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jun 2019 12:20:43 EDT
Received: from player755.ha.ovh.net (unknown [10.109.146.5])
        by mo4.mail-out.ovh.net (Postfix) with ESMTP id EB81A1F6393
        for <linux-pm@vger.kernel.org>; Fri,  7 Jun 2019 17:03:03 +0200 (CEST)
Received: from armadeus.com (lfbn-1-7591-179.w90-126.abo.wanadoo.fr [90.126.248.179])
        (Authenticated sender: sebastien.szymanski@armadeus.com)
        by player755.ha.ovh.net (Postfix) with ESMTPSA id 6C3396B5D8F9;
        Fri,  7 Jun 2019 15:03:00 +0000 (UTC)
From:   =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
To:     linux-pm@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Thomas Renninger <trenn@suse.com>
Cc:     =?UTF-8?q?S=C3=A9bastien=20Szymanski?= 
        <sebastien.szymanski@armadeus.com>
Subject: [PATCH 1/1] tools/power/cpupower: fix 64bit detection when cross-compiling
Date:   Fri,  7 Jun 2019 17:02:55 +0200
Message-Id: <20190607150255.2536-1-sebastien.szymanski@armadeus.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8982147983291798707
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudegiedgkeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When cross-compiling cpupower, 64bit detection is done with the host
compiler instead of the cross-compiler and libcpupower.so.0 ends up in
/usr/lib64 instead of /usr/lib for 32bit target.  Fix this by moving
64bit detection after CC is defined.

Signed-off-by: Sébastien Szymanski <sebastien.szymanski@armadeus.com>
---
 tools/power/cpupower/Makefile | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/power/cpupower/Makefile b/tools/power/cpupower/Makefile
index 9063fca480b3..c8622497ef23 100644
--- a/tools/power/cpupower/Makefile
+++ b/tools/power/cpupower/Makefile
@@ -18,7 +18,6 @@ OUTDIR := $(shell cd $(OUTPUT) && pwd)
 $(if $(OUTDIR),, $(error output directory "$(OUTPUT)" does not exist))
 endif
 
-include ../../scripts/Makefile.arch
 
 # --- CONFIGURATION BEGIN ---
 
@@ -69,11 +68,6 @@ bindir ?=	/usr/bin
 sbindir ?=	/usr/sbin
 mandir ?=	/usr/man
 includedir ?=	/usr/include
-ifeq ($(IS_64_BIT), 1)
-libdir ?=	/usr/lib64
-else
-libdir ?=	/usr/lib
-endif
 localedir ?=	/usr/share/locale
 docdir ?=       /usr/share/doc/packages/cpupower
 confdir ?=      /etc/
@@ -100,6 +94,14 @@ RANLIB = $(CROSS)ranlib
 HOSTCC = gcc
 MKDIR = mkdir
 
+# 64bit library detection
+include ../../scripts/Makefile.arch
+
+ifeq ($(IS_64_BIT), 1)
+libdir ?=	/usr/lib64
+else
+libdir ?=	/usr/lib
+endif
 
 # Now we set up the build system
 #
-- 
2.19.2

