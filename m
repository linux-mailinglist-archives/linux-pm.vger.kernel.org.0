Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D6C1A6C99
	for <lists+linux-pm@lfdr.de>; Mon, 13 Apr 2020 21:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387959AbgDMTjV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 13 Apr 2020 15:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387957AbgDMTjU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Apr 2020 15:39:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00768C008748
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 12:39:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so11181181wmf.5
        for <linux-pm@vger.kernel.org>; Mon, 13 Apr 2020 12:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:resent-from:resent-date:resent-message-id:resent-to
         :message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=7a5CGkxxXkEHMF/zJ3nlqoMs1hpTiss1uxS7Ea00Uig=;
        b=Y5FoX96wXUrTrLdLzu2/ZQkpGWv6EIWDOdL3yFbx6x/d7xPF/uAfWP0nm0OInSV/hh
         ywMVmyThSGEL/8Zm0KfFFtNHcJaTTTSMqiP7fDLQGSnMe0U0fnMcGK31rL35qbhPcPC8
         xT1bMLe4OJMN+OJo7qkbLrFoL3lNLLOjHvAb3h4a+l0bdoFql5g6nIUZAn74jHBzoOG5
         92p3BGDNdS7gMkqtQDchGwAdMwtmmUWKkwWXXW/iCdA9Vs/WiM+6k26idQjDldYlYoK4
         8A4XMTE7NAEnhTGLcAuWvO9blWrwG4VaM+54zgKxhz0f8jh9neDUOkue4OljyihSPNp6
         p2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:resent-from:resent-date:resent-message-id
         :resent-to:message-id:user-agent:date:from:to:cc:subject:references
         :mime-version:content-disposition;
        bh=7a5CGkxxXkEHMF/zJ3nlqoMs1hpTiss1uxS7Ea00Uig=;
        b=hJDwQelDkacxAcnkEHuHTlQMF6SHv7i4WdW0XEf44K5F3j1NMKe1pb1byzbAWo7vLz
         ik6J53d0zn+SfFYINnFHtfAUeKbTsRT0K/++sZxIf+ddswPNHmj1tcSNeLs4lVqAtUjW
         mY7yCFy6nX5QN6/zBCoEtKYTY/z8wlPxu0ruucmlTcD4FuURDRKDo5CfUQzaW0Jn86E2
         ypVgOz9GmSa/1HX75dt0dQrDoa6R4kZogpib4U5IwPQXhu8IQXpTxNFgOdWn1TDXLCIB
         NeOdypjBm1fITvUIyWyRiYz1HypzVQGnhNcMWoIvodarQWanj+6laZRI+TIeH4JOnnEp
         nXDQ==
X-Gm-Message-State: AGi0PuYQRk+9NKpgWEyzfYLWdfxm+SVskeMexaO2oszlri4iNhayigH3
        tdBFBi+MXuNUYvVP1qUxQGg=
X-Google-Smtp-Source: APiQypL0NnBCKtcwOkgpDQvIsNfJdJW43vst2LPA7i1OplRExwx7E75yCpRZFPli6bAncpGxzldn7A==
X-Received: by 2002:a7b:c1c4:: with SMTP id a4mr17537274wmj.86.1586806758741;
        Mon, 13 Apr 2020 12:39:18 -0700 (PDT)
Received: from dumbo ([2a06:1700:1::7])
        by smtp.gmail.com with ESMTPSA id j13sm16751219wro.51.2020.04.13.12.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 12:39:16 -0700 (PDT)
Received: from cavok by dumbo with local (Exim 4.92)
        (envelope-from <cavok@dumbo>)
        id 1jO4vK-0005xy-Pl; Mon, 13 Apr 2020 21:39:14 +0200
Message-Id: <20200413193718.956985775@gmail.com>
User-Agent: quilt/0.65
Date:   Mon, 13 Apr 2020 21:08:45 +0200
From:   Domenico Andreoli <domenico.andreoli@linux.com>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Domenico Andreoli <domenico.andreoli@linux.com>
Subject: [PATCH 2/2] uswsusp: build only when configured
References: <20200413190843.044112674@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=split-user-space-hibernation-option
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Domenico Andreoli <domenico.andreoli@linux.com>

uswsusp is no longer the preferred way to suspend/hibernate and the
userspace tools have not received any update in years.

Make it possible to enable the uswsusp support only if needed, prepare
for future phase out.

Signed-off-by: Domenico Andreoli <domenico.andreoli@linux.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Linux PM <linux-pm@vger.kernel.org>

---
 kernel/power/Kconfig  |    5 +++++
 kernel/power/Makefile |    3 ++-
 kernel/power/power.h  |    5 +++++
 3 files changed, 12 insertions(+), 1 deletion(-)

Index: b/kernel/power/Kconfig
===================================================================
--- a/kernel/power/Kconfig
+++ b/kernel/power/Kconfig
@@ -80,6 +80,11 @@ config HIBERNATION
 
 	  For more information take a look at <file:Documentation/power/swsusp.rst>.
 
+config HIBERNATION_USER
+	bool "Userspace software suspend interface (DEPRECATED)"
+	depends on HIBERNATION
+	default n
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
+obj-$(CONFIG_HIBERNATION_USER)	+= user.o
 obj-$(CONFIG_PM_AUTOSLEEP)	+= autosleep.o
 obj-$(CONFIG_PM_WAKELOCKS)	+= wakelock.o
 
Index: b/kernel/power/power.h
===================================================================
--- a/kernel/power/power.h
+++ b/kernel/power/power.h
@@ -158,8 +158,13 @@ extern sector_t alloc_swapdev_block(int
 extern void free_all_swap_pages(int swap);
 extern int swsusp_swap_in_use(void);
 
+#ifdef CONFIG_HIBERNATION_USER
 bool swsusp_try_enter(void);
 void swsusp_leave(void);
+#else
+static inline bool swsusp_try_enter(void) { return 1; }
+static inline void swsusp_leave(void) {}
+#endif
 
 /*
  * Flags that can be passed from the hibernatig hernel to the "boot" kernel in

