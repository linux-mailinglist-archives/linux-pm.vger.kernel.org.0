Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B821C196B
	for <lists+linux-pm@lfdr.de>; Fri,  1 May 2020 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729759AbgEAPZN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 May 2020 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgEAPZM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 May 2020 11:25:12 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29593C061A0C
        for <linux-pm@vger.kernel.org>; Fri,  1 May 2020 08:25:11 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u16so47075wmc.5
        for <linux-pm@vger.kernel.org>; Fri, 01 May 2020 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=hstys9wIAfhbwE6wNgZrl/SKnLndXvXa9vEadgodDJI=;
        b=iftNOmp1HP6jSm4mfjo+yG2c0nkSVIB6M6v7kQ6KqSc344X/iK/EnpBme0cHIBbh2j
         0iijaWpO1fKIZQPScHB0YXCRtWnXOqL/QQSHrxG7v7lwmBS5UibmId4CQu3uMWX6pgih
         v51nj7J0SHj+ehCSAPuYxCctwCpBNnH9uQBQIkUj6HMtwkjGTHVmJ2EGPkaPaeizViz2
         tehQK0js4jmq8hhGTFJRT/EKXsgqyO/cDmos/IpfViIODdavRev3mjviysyyuyHlqJEg
         1heIGwSw3An9IZXbpxgP/Oejg7OOd5/aoE2k10p8XSwYooDy/6yes70zPf93MjbBj3Yp
         7OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=hstys9wIAfhbwE6wNgZrl/SKnLndXvXa9vEadgodDJI=;
        b=PooNBhf7454fqJhrKIjOm0GR/0SLT3Uznxjzk/XqXlVzU4JEL9jeKLj2CwVBRACxqg
         YWRsD3pGq7gWjL2z807agE/JAV7H9k/iikIGV4xAOg9eOAQX0rlmOiMfmX+t0IrluUQy
         Z8+mS74//zK0rrBMQyuGxRS+2txQAacH343rcq6Z4dvce0YUZ8BlaXzk6/dIgV5PKZ9H
         JkNFIqqTqAwP7cSyXiR0U3e2vxW7Y24G5m9ncc4RYpajPO/K+zCV4PMm3sNuvQEZxyK5
         yz6UQII4ed6BKLAuBY4FnYhHJyDAsibW5UnvyyNpWOAlRd3aFlMeuRw79PIJmNfz99ll
         qYNA==
X-Gm-Message-State: AGi0Pubqc/a8VboBuOll+z99/o9nUAaiHVme0S+3bWANtk1Yh7P5cL8u
        qqGD6xOjud4ZDf0DCeZI1gYzy1LRxUM=
X-Google-Smtp-Source: APiQypKB+afelrD5W/lk5NXntEc2FAz5VLdDOX1pyxl24lqntIlhuzGV6VwNUb1xprtAzhfWeJPCcw==
X-Received: by 2002:a1c:a9c3:: with SMTP id s186mr58230wme.89.1588346683858;
        Fri, 01 May 2020 08:24:43 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2::1])
        by smtp.gmail.com with ESMTPSA id c190sm20978wme.4.2020.05.01.08.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 08:24:42 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jUXWr-0006YP-1Q; Fri, 01 May 2020 17:24:41 +0200
Message-Id: <20200501152304.609906298@gmail.com>
User-Agent: quilt/0.65
Date:   Fri, 01 May 2020 17:14:54 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH v2 2/2] hibernate: split snapshot dev option
References: <20200501151452.621900831@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=hibernate-split-snapshot-dev-option
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

Make it possible to reduce the attack surface in case the snapshot
device is not to be used from userspace.

v2:
 - the option is enabled by default (it was disabled by default)
 - remove the premature "DEPRECATED" marking
 - drop the redefinition of mutual exclusion helpers (in v2 they are
   owned by hibernte.c) in case the option is deselected
 - add the help message to the config option

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>

---
 kernel/power/Kconfig  |   12 ++++++++++++
 kernel/power/Makefile |    3 ++-
 2 files changed, 14 insertions(+), 1 deletion(-)

Index: b/kernel/power/Kconfig
===================================================================
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -80,6 +80,18 @@ config HIBERNATION
 
 	  For more information take a look at <file:Documentation/power/swsusp.rst>.
 
+config HIBERNATION_SNAPSHOT_DEV
+	bool "Userspace snapshot device"
+	depends on HIBERNATION
+	default y
+	---help---
+	  Device used by the uswsusp tools.
+
+	  Say N if no snapshotting from userspace is needed, this also
+	  reduces the attack surface of the kernel.
+
+	  If in doubt, say Y.
+
 config PM_STD_PARTITION
 	string "Default resume partition"
 	depends on HIBERNATION
Index: b/kernel/power/Makefile
===================================================================
--- a/kernel/power/Makefile
+++ b/kernel/power/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_VT_CONSOLE_SLEEP)	+= consol
 obj-$(CONFIG_FREEZER)		+= process.o
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_PM_TEST_SUSPEND)	+= suspend_test.o
-obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o user.o
+obj-$(CONFIG_HIBERNATION)	+= hibernate.o snapshot.o swap.o
+obj-$(CONFIG_HIBERNATION_SNAPSHOT_DEV) += user.o
 obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
 obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 

