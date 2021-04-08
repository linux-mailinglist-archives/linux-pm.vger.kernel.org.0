Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DEB358EE7
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 23:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbhDHVCD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 17:02:03 -0400
Received: from condef-02.nifty.com ([202.248.20.67]:36740 "EHLO
        condef-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232345AbhDHVCC (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Apr 2021 17:02:02 -0400
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-02.nifty.com with ESMTP id 138KxvMA004966;
        Fri, 9 Apr 2021 05:59:57 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 138Kx471002644;
        Fri, 9 Apr 2021 05:59:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 138Kx471002644
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1617915546;
        bh=piA+8z078kwb/KfPJ/8L0g75CBWXThZTe0VPYso6g/U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E65GbUOUKULlL/mKzA0AVQ65w88zN1o5uif53wxAmxGkhdZqItC49y4rWkJOjItNJ
         tLVX6tAyd6DCAdOQi4Q9iODqSvyhaZpq1G3MGyCAqWx9BS7IxNeVuPI52RwF/I1mKM
         +0V0UVCeASxlppgX6piANkaMLhn4EPqvs4OyKv+2eE8tUq2MLgR84FxMdKuVYsh+fS
         OocOwD5+NGyVq5Oz29d3cGRt56StEw9e0mB4RldDJE5kU0GuJmHDbWYmjsMzuVJPyR
         WcNIsANqTZ2NaqQ7xrAM3Z36qfPcbMNMYisubExgEllrLizap3fossetR+MCScZVMA
         MLPM5V2rgSV5g==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 2/2] pm: allow drivers to drop #ifdef and __maybe_unused from pm callbacks
Date:   Fri,  9 Apr 2021 05:58:58 +0900
Message-Id: <20210408205858.51751-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210408205858.51751-1-masahiroy@kernel.org>
References: <20210408205858.51751-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Drivers typically surround suspend and resume callbacks with #ifdef
CONFIG_PM(_SLEEP) or mark them as __maybe_unused in order to avoid
-Wunused-const-variable warnings.

With this commit, drivers will be able to remove #ifdef CONFIG_PM(_SLEEP)
and __maybe_unsed because unused functions are dropped by the compiler
instead of the preprocessor.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/pm.h | 67 +++++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 43 deletions(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 482313a8ccfc..ca764566692a 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -301,50 +301,37 @@ struct dev_pm_ops {
 	int (*runtime_idle)(struct device *dev);
 };
 
-#ifdef CONFIG_PM_SLEEP
+#define pm_ptr(_ptr)		PTR_IF(IS_ENABLED(CONFIG_PM), _ptr)
+#define pm_sleep_ptr(_ptr)	PTR_IF(IS_ENABLED(CONFIG_PM_SLEEP), _ptr)
+
 #define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend = suspend_fn, \
-	.resume = resume_fn, \
-	.freeze = suspend_fn, \
-	.thaw = resume_fn, \
-	.poweroff = suspend_fn, \
-	.restore = resume_fn,
-#else
-#define SET_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend  = pm_sleep_ptr(suspend_fn), \
+	.resume   = pm_sleep_ptr(resume_fn), \
+	.freeze   = pm_sleep_ptr(suspend_fn), \
+	.thaw     = pm_sleep_ptr(resume_fn), \
+	.poweroff = pm_sleep_ptr(suspend_fn), \
+	.restore  = pm_sleep_ptr(resume_fn),
 
-#ifdef CONFIG_PM_SLEEP
 #define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_late = suspend_fn, \
-	.resume_early = resume_fn, \
-	.freeze_late = suspend_fn, \
-	.thaw_early = resume_fn, \
-	.poweroff_late = suspend_fn, \
-	.restore_early = resume_fn,
-#else
-#define SET_LATE_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend_late  = pm_sleep_ptr(suspend_fn), \
+	.resume_early  = pm_sleep_ptr(resume_fn), \
+	.freeze_late   = pm_sleep_ptr(suspend_fn), \
+	.thaw_early    = pm_sleep_ptr(resume_fn), \
+	.poweroff_late = pm_sleep_ptr(suspend_fn), \
+	.restore_early = pm_sleep_ptr(resume_fn),
 
-#ifdef CONFIG_PM_SLEEP
 #define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn) \
-	.suspend_noirq = suspend_fn, \
-	.resume_noirq = resume_fn, \
-	.freeze_noirq = suspend_fn, \
-	.thaw_noirq = resume_fn, \
-	.poweroff_noirq = suspend_fn, \
-	.restore_noirq = resume_fn,
-#else
-#define SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(suspend_fn, resume_fn)
-#endif
+	.suspend_noirq  = pm_sleep_ptr(suspend_fn), \
+	.resume_noirq   = pm_sleep_ptr(resume_fn), \
+	.freeze_noirq   = pm_sleep_ptr(suspend_fn), \
+	.thaw_noirq     = pm_sleep_ptr(resume_fn), \
+	.poweroff_noirq = pm_sleep_ptr(suspend_fn), \
+	.restore_noirq  = pm_sleep_ptr(resume_fn),
 
-#ifdef CONFIG_PM
 #define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
-	.runtime_suspend = suspend_fn, \
-	.runtime_resume = resume_fn, \
-	.runtime_idle = idle_fn,
-#else
-#define SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn)
-#endif
+	.runtime_suspend = pm_ptr(suspend_fn), \
+	.runtime_resume  = pm_ptr(resume_fn), \
+	.runtime_idle    = pm_ptr(idle_fn),
 
 /*
  * Use this if you want to use the same suspend and resume callbacks for suspend
@@ -374,12 +361,6 @@ const struct dev_pm_ops __maybe_unused name = { \
 	SET_RUNTIME_PM_OPS(suspend_fn, resume_fn, idle_fn) \
 }
 
-#ifdef CONFIG_PM
-#define pm_ptr(_ptr) (_ptr)
-#else
-#define pm_ptr(_ptr) NULL
-#endif
-
 /*
  * PM_EVENT_ messages
  *
-- 
2.27.0

