Return-Path: <linux-pm+bounces-6767-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182F8AC905
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 11:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A251C20F49
	for <lists+linux-pm@lfdr.de>; Mon, 22 Apr 2024 09:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7313F56B68;
	Mon, 22 Apr 2024 09:36:33 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754165644F
	for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778593; cv=none; b=hKVC3jaTBxyuRFDWGCFo/7HbnSWjjzvg5eZ7FAlWSTsQCfN/J0Ga4pdnkR0vw7JHtjR/8a5H+re7wu+baydSkX0sHXxqtKpfS7jKzJb3IfJDqMeuDYQe1Yb/KLi93YSA4uYXVU3b/a0HTRDMnWUdhqBX+EbcOEi5PJz203r0jgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778593; c=relaxed/simple;
	bh=GThUoiewSA7Gvp5yOARC1MLVqh8Zge/hH8zFJn4TnJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XyndJYdpwG/bgFcVPb+yjWrZb07sA+ynvErs3pQYEfIaPkXqb7KN9tsGo4kF4NyqE4BJaG3munB7hWcnRF3nCapCcurV90Pf9uMFvmjeBSnIxh2BqC9aN2xUyPU9/afXcjtQPghybKEeBWXv3P3m028I3aijNkhuiaRCaRLEuaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2abae23d682so1064293a91.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Apr 2024 02:36:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778590; x=1714383390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFvcQzhgj4twnEaffpOgowyr6K5d6yO+m1qA3a5KZeg=;
        b=T0r15eF7nQTGfEwMNvKl457xvDvJdOKjytXEmFaIrMARmMkqBE0MHyqdGx/0w9VDD1
         /3vdzdXPDbh+i2TVHQb0z2vxrwSdiV89D6DTX1OFo4iTPlNwMu8d6lIOZlxx0g+Qmvye
         PB9V2qwt0WOp83NrZcULHBGheCGJaMaYmOCXOrbnRODzayrmR0R+R+NbaJUtTcPWFzSZ
         CWCYYXxtoRtR/aKHp39eC16pHn/VMcsUON1SEhd5z1+v3XMF1mGEdXG8fEXifYG1viKn
         ghF1oUHdsXyWDRbOWhE1qGUx7JLyiMs24dneSARbecE3Pz4pgbzUylI8ex/qvFF2Bsow
         +SIA==
X-Gm-Message-State: AOJu0YyOZjvbUUt/gpq5Anxu6spoIdJlxIfaYVpP38HVdJq5zLfd3miP
	oMxHzxSN03nxDcXGv2kUcKThLFSCZAYMK5U15DvjuA2lGTkBlweZh8z0EEZQ
X-Google-Smtp-Source: AGHT+IFE0cMn78nXhL9xk1xgdsrstmwRo6aiZFslwO1NYHwxNGjr3tqH3STjQZ7293D34nAKxl8IIg==
X-Received: by 2002:a17:90a:a085:b0:2ab:be54:85ed with SMTP id r5-20020a17090aa08500b002abbe5485edmr8892840pjp.0.1713778589650;
        Mon, 22 Apr 2024 02:36:29 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([111.48.58.12])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b002ae2579ffeesm925428pjb.19.2024.04.22.02.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:36:29 -0700 (PDT)
From: xiongxin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mario.limonciello@amd.com
Cc: linux-pm@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH] Revert "include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume"
Date: Mon, 22 Apr 2024 17:36:19 +0800
Message-Id: <20240422093619.118278-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit cdb8c100d8a4b4e31c829724e40b4fdf32977cce.

In the suspend process, pm_pr_dbg() is called before setting
pm_suspend_target_state. As a result, this part of the log cannot be
output.

pm_pr_dbg() also outputs debug logs for hibernate, but
pm_suspend_target_state is not set, resulting in hibernate debug logs
can only be output through dynamic debug, which is very inconvenient.

Signed-off-by: xiongxin <xiongxin@kylinos.cn>

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index da6ebca3ff77..415483b89b11 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -503,7 +503,6 @@ static inline void unlock_system_sleep(unsigned int flags) {}
 #ifdef CONFIG_PM_SLEEP_DEBUG
 extern bool pm_print_times_enabled;
 extern bool pm_debug_messages_on;
-extern bool pm_debug_messages_should_print(void);
 static inline int pm_dyn_debug_messages_on(void)
 {
 #ifdef CONFIG_DYNAMIC_DEBUG
@@ -517,14 +516,14 @@ static inline int pm_dyn_debug_messages_on(void)
 #endif
 #define __pm_pr_dbg(fmt, ...)					\
 	do {							\
-		if (pm_debug_messages_should_print())		\
+		if (pm_debug_messages_on)			\
 			printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 		else if (pm_dyn_debug_messages_on())		\
 			pr_debug(fmt, ##__VA_ARGS__);	\
 	} while (0)
 #define __pm_deferred_pr_dbg(fmt, ...)				\
 	do {							\
-		if (pm_debug_messages_should_print())		\
+		if (pm_debug_messages_on)			\
 			printk_deferred(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__);	\
 	} while (0)
 #else
@@ -542,8 +541,7 @@ static inline int pm_dyn_debug_messages_on(void)
 /**
  * pm_pr_dbg - print pm sleep debug messages
  *
- * If pm_debug_messages_on is enabled and the system is entering/leaving
- *      suspend, print message.
+ * If pm_debug_messages_on is enabled, print message.
  * If pm_debug_messages_on is disabled and CONFIG_DYNAMIC_DEBUG is enabled,
  *	print message only from instances explicitly enabled on dynamic debug's
  *	control.
diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..aa754241aaa6 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -611,12 +611,6 @@ power_attr_ro(pm_wakeup_irq);
 
 bool pm_debug_messages_on __read_mostly;
 
-bool pm_debug_messages_should_print(void)
-{
-	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
-}
-EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
-
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-- 
2.34.1


