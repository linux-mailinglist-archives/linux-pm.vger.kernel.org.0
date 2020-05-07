Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7441C8362
	for <lists+linux-pm@lfdr.de>; Thu,  7 May 2020 09:24:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgEGHYp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 May 2020 03:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGHYo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 03:24:44 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC4EC061A10
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 00:24:44 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r26so5522194wmh.0
        for <linux-pm@vger.kernel.org>; Thu, 07 May 2020 00:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=hstys9wIAfhbwE6wNgZrl/SKnLndXvXa9vEadgodDJI=;
        b=vJRo3LGRbvechV6OSZpluoGx6KWUm+NOAX9HT55rEdbb1AwPe/MwGYd38Yb/0RkqfI
         UCWDz8NOnlr173gpeF7PNPb9HuEIPIa4sQV9IJA97thYlISVedwJQTK//F/RncWct2Ik
         BEw54nHElrJjq/soCa2COOpCrhdywesTzmmjhxtNvtz4AI/mYzjwYpszpetKoJH0TLIG
         xrO8LateSpaKr6pK5hLVleK7i7olgHnlM24/XtUy7Y0paaj56J5970dh9k74314dcakQ
         K2d/8atpYtqaNGdvIBkkMEqjBMvJObboaQipLnUEavTMK/IWOBVKHTBZbSv8pkJGPzm3
         YzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=hstys9wIAfhbwE6wNgZrl/SKnLndXvXa9vEadgodDJI=;
        b=K7pMxd16i+iIyz9ENoSlVM2AfyHmhF5trC1OOFKZxd7IjAEb6rxqMIlDCZZmEFT0Id
         T+nuBi489Tr2dnL2f6/ZSQOz90GWMbJeoFUAAu9APvDqmwwv3htKGZviLxX4yjdKfkwy
         vFkHpW65lDcJ/1uk0JYNQCOV5cUEh6QjNM+kdfBURgnzLHgRbNjw1yfSutHK/huty1Nd
         f2P89EffyJJTPK9lv+E1FO32KVc8XuDeSn2qNd48mSFbZbbXRWnWJ142TpP6ls1J8Wf5
         PvzE0TEH34ajn3Emvz91rtB84CYW3Ak+Lk+To0ubRdEYlLjJXY64JulHYzinRv+4nKun
         UFnw==
X-Gm-Message-State: AGi0PuboqRuYV2wwlWBBNg8cBLo5eco5cbVaOOR7FB8BEYt0VpjYR2LK
        flcwb1NYEdrSgtE+54lxP8FBMtCxjbY=
X-Google-Smtp-Source: APiQypJZAugMgptoQv00zFvd4Ynz+Qdt2ms86GhBFUzAZiXl9w4YAFQ2cZBW5lVo04J8NVmuSdoTpw==
X-Received: by 2002:a05:600c:414a:: with SMTP id h10mr2134219wmm.183.1588836282773;
        Thu, 07 May 2020 00:24:42 -0700 (PDT)
Received: from dumbo ([2a0b:f4c2::1])
        by smtp.gmail.com with ESMTPSA id p8sm2622039wma.45.2020.05.07.00.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 00:24:41 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jWatc-0003zy-5Q; Thu, 07 May 2020 09:24:40 +0200
Message-Id: <20200507072357.652675775@linux.com>
User-Agent: quilt/0.65
Date:   Thu, 07 May 2020 09:19:53 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 2/2] hibernate: split snapshot dev option
References: <20200507071951.635743820@linux.com>
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
 

