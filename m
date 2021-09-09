Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAE6405995
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 16:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241324AbhIIOsN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbhIIOru (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 9 Sep 2021 10:47:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689C4C0560C1
        for <linux-pm@vger.kernel.org>; Thu,  9 Sep 2021 07:38:42 -0700 (PDT)
Date:   Thu, 09 Sep 2021 14:38:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631198321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Biq+Q5tBUhmjGuj+qmM5i7ZBgsXMtJFhlxMlWMNYNHU=;
        b=AqgUzxb7ZWuECuoqybKb+0HSDDv84bFaz0BMpHWx/Eb/okq4Yh+Bef1m3it3Yr4HKmqFkj
        xMXTkrW7P61HH+JSYx/4L+taKDZxbjWrlBbLl1tUwcdcLnN/prRUTpg6ZBvw8fVpk3ffen
        IJRdOiJeCqQv5f4bI4puBN418bEjDKnuiFZ1Ckso7C6EHiaFVBTPdIP5Qp95w6t7pkYBj2
        q7GsFgek+5liYbpmGeXhedyunnJS1l67Xnak5pJW4hfISRieUDRmHqakW33BMt4yt75qdb
        cusAZgGT9YuYvGj7t1Z7T0VjUvRWISYx7tF1PEUkFpz6pcvrAm8sMuaPShGcLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631198321;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Biq+Q5tBUhmjGuj+qmM5i7ZBgsXMtJFhlxMlWMNYNHU=;
        b=jb37IrorLekpG/f8WhrPeVee4EaXcONag/YC6V6HmnYqgE/GVRY1q76LIO/N8Yct/doFQM
        XgH+EwTV+k1eMfBw==
From:   "thermal-bot for Rolf Eike Beer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To:     linux-pm@vger.kernel.org
Subject: [thermal: thermal/next] thermal/tools/tmon: Improve the Makefile
Cc:     Rolf Eike Beer <eb@emlix.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        rui.zhang@intel.com, amitk@kernel.org
In-Reply-To: <1951386.ZPQrlMDjM2@devpool47>
References: <1951386.ZPQrlMDjM2@devpool47>
MIME-Version: 1.0
Message-ID: <163119832031.25758.14075212047149296535.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The following commit has been merged into the thermal/next branch of thermal:

Commit-ID:     99d88c30055376b56316d3c431c9873e88208348
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git//99d88c30055376b56316d3c431c9873e88208348
Author:        Rolf Eike Beer <eb@emlix.com>
AuthorDate:    Fri, 30 Jul 2021 13:49:04 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 14 Aug 2021 15:30:11 +02:00

thermal/tools/tmon: Improve the Makefile

 - Remove empty macros assignments
 - Use directory creation parameter for the install tool
 - Use $OBJ instead of building the list of object for the 'clean' target

[dlezcano] : Changed title and description

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1951386.ZPQrlMDjM2@devpool47
---
 tools/thermal/tmon/Makefile | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/thermal/tmon/Makefile b/tools/thermal/tmon/Makefile
index 9db867d..3e65087 100644
--- a/tools/thermal/tmon/Makefile
+++ b/tools/thermal/tmon/Makefile
@@ -13,7 +13,6 @@ CC?= $(CROSS_COMPILE)gcc
 PKG_CONFIG?= pkg-config
 
 override CFLAGS+=-D VERSION=\"$(VERSION)\"
-LDFLAGS+=
 TARGET=tmon
 
 INSTALL_PROGRAM=install -m 755 -p
@@ -33,7 +32,6 @@ override CFLAGS += $(shell $(PKG_CONFIG) --cflags $(STATIC) panelw ncursesw 2> /
 		     $(PKG_CONFIG) --cflags $(STATIC) panel ncurses 2> /dev/null)
 
 OBJS = tmon.o tui.o sysfs.o pid.o
-OBJS +=
 
 tmon: $(OBJS) Makefile tmon.h
 	$(CC) $(CFLAGS) $(LDFLAGS) $(OBJS)  -o $(TARGET) $(TMON_LIBS)
@@ -42,15 +40,13 @@ valgrind: tmon
 	 sudo valgrind -v --track-origins=yes --tool=memcheck --leak-check=yes --show-reachable=yes --num-callers=20 --track-fds=yes ./$(TARGET)  1> /dev/null
 
 install:
-	- mkdir -p $(INSTALL_ROOT)/$(BINDIR)
-	- $(INSTALL_PROGRAM) "$(TARGET)" "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
+	- $(INSTALL_PROGRAM) -D "$(TARGET)" "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
 
 uninstall:
 	$(DEL_FILE) "$(INSTALL_ROOT)/$(BINDIR)/$(TARGET)"
 
 clean:
-	find . -name "*.o" | xargs $(DEL_FILE)
-	rm -f $(TARGET)
+	rm -f $(TARGET) $(OBJS)
 
 dist:
 	git tag v$(VERSION)
