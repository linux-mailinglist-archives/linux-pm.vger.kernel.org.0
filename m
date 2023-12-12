Return-Path: <linux-pm+bounces-976-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F2080EE39
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 15:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16690B20CDC
	for <lists+linux-pm@lfdr.de>; Tue, 12 Dec 2023 14:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337DE70971;
	Tue, 12 Dec 2023 14:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfjL41Q0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04D1CD
	for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 06:01:03 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id 006d021491bc7-59091e4a0f9so1612037eaf.1
        for <linux-pm@vger.kernel.org>; Tue, 12 Dec 2023 06:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702389663; x=1702994463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6m07btQHPWV2ctZksBMNHS2v6G8bOJynKLcHM3wDkKo=;
        b=NfjL41Q0byMQMLx34vRLUf6YwkjZhP5L4jiHwNDAIE7YgKuKNN9dSNU3rk1kbKmBWl
         oADgLw0EidgeckjvWMcS/oJHpjZro/4COi50qOUBhRWHsqHnRX8tWqlBVrSKgy5ljg85
         R+grO52Ly0IhdqvGouOmWJjNyB1H9+R8+uru9SsAWgOCt7PAWFckXLMTkQZ2SgT9qKx1
         Xf1DwgeaQFeTKzfe1BYw1m+4AsPnt0/jtSBUrca+gL9WbfUM2t43FWcZt5gL+XqnZiw4
         6g4yvvBL5FboVrqHN8/uqRnYAC0YsbnRW9gcF+sgMuC0NsqZi7VpbE+GPLbADzlQco1f
         sYpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702389663; x=1702994463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6m07btQHPWV2ctZksBMNHS2v6G8bOJynKLcHM3wDkKo=;
        b=ARcZhrjiaXVCvDH0cRIzMbBJi7QebWRjGHavUDvXlCJGL0UqCNyYrKjiOadrRo+ZFV
         DYk4PFJrE1lC13oZNTyV9WZOeLa8Tp/JGuLB+6XOpWJ68ROn/r/ljpNFD7rWbxRHcVuc
         f4YNV0h51qOQUGJFrd2dQX2Ch9agIVGgAX8o5rXlAbyIOQwSzyAzrf6WresJp5Vgg2vG
         3zZSt91MzlPR9i5QnXEi000rwUA+noTbeav7DJTBwPam10pxUIhAibGhfUrzG4NzrS2M
         lHy7JqUv/2TIkssQhOpnKalTC3Y2Rob/3JpZjMgx72m5wrNMiJaHfWgLxIcpoBoQEUyr
         wJRQ==
X-Gm-Message-State: AOJu0YwnAwX40VzP20FezCDOBfmahdflscXVFvtEVBvHQBzE+aYj27Ig
	aWGGlNmw8BsShhA1MmWzu8R+LkBoPXUoJw==
X-Google-Smtp-Source: AGHT+IGmmJryFQNnerXVd4/lAEuNHPq987BJ8TfTynzYgurFLYd1ILcZNBiLLsFcnOi0O3fcOiEx8g==
X-Received: by 2002:a05:6358:78e:b0:170:17eb:2fac with SMTP id n14-20020a056358078e00b0017017eb2facmr2021658rwj.37.1702389662687;
        Tue, 12 Dec 2023 06:01:02 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id pz12-20020ad4550c000000b0067a95ef3a8dsm4227778qvb.50.2023.12.12.06.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 06:00:59 -0800 (PST)
From: Kevin Hao <haokexin@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH] docs: power: Adjust freezing-of-tasks.rst due to the freezer logic changes
Date: Tue, 12 Dec 2023 22:00:43 +0800
Message-Id: <20231212140043.714303-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Peter has rewritten core freezer logic in commit f5d39b020809
("freezer,sched: Rewrite core freezer logic"), adjust the
freezing-of-tasks.rst according to this commit. The main changes
include:
- Drop the mention of PF_FROZEN and PF_FREEZER_SKIP
- Introduce TASK_FROZEN, TASK_FREEZABLE and __TASK_FREEZABLE_UNSAFE
- Replace system_freezing_cnt with freezer_active
- Use another example for the loop of a freezable kernel thread since
  the old codes are already gone

Signed-off-by: Kevin Hao <haokexin@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
---
 Documentation/power/freezing-of-tasks.rst | 83 +++++++++++++----------
 1 file changed, 47 insertions(+), 36 deletions(-)

diff --git a/Documentation/power/freezing-of-tasks.rst b/Documentation/power/freezing-of-tasks.rst
index 53b6a56c4635..8969ed244b20 100644
--- a/Documentation/power/freezing-of-tasks.rst
+++ b/Documentation/power/freezing-of-tasks.rst
@@ -14,27 +14,28 @@ architectures).
 II. How does it work?
 =====================
 
-There are three per-task flags used for that, PF_NOFREEZE, PF_FROZEN
-and PF_FREEZER_SKIP (the last one is auxiliary).  The tasks that have
-PF_NOFREEZE unset (all user space processes and some kernel threads) are
-regarded as 'freezable' and treated in a special way before the system enters a
-suspend state as well as before a hibernation image is created (in what follows
-we only consider hibernation, but the description also applies to suspend).
+There are one per-task flag (PF_NOFREEZE) and three per-task states
+(TASK_FROZEN, TASK_FREEZABLE and __TASK_FREEZABLE_UNSAFE) used for that.
+The tasks that have PF_NOFREEZE unset (all user space processes and some kernel
+threads) are regarded as 'freezable' and treated in a special way before the
+system enters a suspend state as well as before a hibernation image is created
+(in what follows we only consider hibernation, but the description also applies
+to suspend).
 
 Namely, as the first step of the hibernation procedure the function
 freeze_processes() (defined in kernel/power/process.c) is called.  A system-wide
-variable system_freezing_cnt (as opposed to a per-task flag) is used to indicate
-whether the system is to undergo a freezing operation. And freeze_processes()
-sets this variable.  After this, it executes try_to_freeze_tasks() that sends a
-fake signal to all user space processes, and wakes up all the kernel threads.
-All freezable tasks must react to that by calling try_to_freeze(), which
-results in a call to __refrigerator() (defined in kernel/freezer.c), which sets
-the task's PF_FROZEN flag, changes its state to TASK_UNINTERRUPTIBLE and makes
-it loop until PF_FROZEN is cleared for it. Then, we say that the task is
-'frozen' and therefore the set of functions handling this mechanism is referred
-to as 'the freezer' (these functions are defined in kernel/power/process.c,
-kernel/freezer.c & include/linux/freezer.h). User space processes are generally
-frozen before kernel threads.
+static key freezer_active (as opposed to a per-task flag or state) is used to
+indicate whether the system is to undergo a freezing operation. And
+freeze_processes() sets this variable.  After this, it executes
+try_to_freeze_tasks() that sends a fake signal to all user space processes, and
+wakes up all the kernel threads. All freezable tasks must react to that by
+calling try_to_freeze(), which results in a call to __refrigerator() (defined
+in kernel/freezer.c), which sets the task's state to TASK_FROZEN, and makes it
+loop until it is woken by an explicit TASK_FROZEN wakeup. Then, we say that the
+task is 'frozen' and therefore the set of functions handling this mechanism is
+referred to as 'the freezer' (these functions are defined in
+kernel/power/process.c, kernel/freezer.c & include/linux/freezer.h). User space
+processes are generally frozen before kernel threads.
 
 __refrigerator() must not be called directly.  Instead, use the
 try_to_freeze() function (defined in include/linux/freezer.h), that checks
@@ -43,31 +44,40 @@ if the task is to be frozen and makes the task enter __refrigerator().
 For user space processes try_to_freeze() is called automatically from the
 signal-handling code, but the freezable kernel threads need to call it
 explicitly in suitable places or use the wait_event_freezable() or
-wait_event_freezable_timeout() macros (defined in include/linux/freezer.h)
-that combine interruptible sleep with checking if the task is to be frozen and
-calling try_to_freeze().  The main loop of a freezable kernel thread may look
-like the following one::
+wait_event_freezable_timeout() macros (defined in include/linux/wait.h)
+that puts the task to sleep (TASK_INTERRUPTIBLE) or frozen (TASK_FROZEN) if the
+task is freezing. The main loop of a freezable kernel thread may look like the
+following one::
 
 	set_freezable();
-	do {
-		hub_events();
-		wait_event_freezable(khubd_wait,
-				!list_empty(&hub_event_list) ||
-				kthread_should_stop());
-	} while (!kthread_should_stop() || !list_empty(&hub_event_list));
 
-(from drivers/usb/core/hub.c::hub_thread()).
+	while (true) {
+		struct task_struct *tsk = NULL;
 
-If a freezable kernel thread fails to call try_to_freeze() after the freezer has
-initiated a freezing operation, the freezing of tasks will fail and the entire
-hibernation operation will be cancelled.  For this reason, freezable kernel
-threads must call try_to_freeze() somewhere or use one of the
+		wait_event_freezable(oom_reaper_wait, oom_reaper_list != NULL);
+		spin_lock_irq(&oom_reaper_lock);
+		if (oom_reaper_list != NULL) {
+			tsk = oom_reaper_list;
+			oom_reaper_list = tsk->oom_reaper_list;
+		}
+		spin_unlock_irq(&oom_reaper_lock);
+
+		if (tsk)
+			oom_reap_task(tsk);
+	}
+
+(from mm/oom_kill.c::oom_reaper()).
+
+If a freezable kernel thread fails to be put to frozen state after the freezer
+has initiated a freezing operation, the freezing of tasks will fail and the
+entire hibernation operation will be cancelled.  For this reason, freezable
+kernel threads must call try_to_freeze() somewhere or use one of the
 wait_event_freezable() and wait_event_freezable_timeout() macros.
 
 After the system memory state has been restored from a hibernation image and
 devices have been reinitialized, the function thaw_processes() is called in
-order to clear the PF_FROZEN flag for each frozen task.  Then, the tasks that
-have been frozen leave __refrigerator() and continue running.
+order to wake up each frozen task.  Then, the tasks that have been frozen leave
+__refrigerator() and continue running.
 
 
 Rationale behind the functions dealing with freezing and thawing of tasks
@@ -96,7 +106,8 @@ III. Which kernel threads are freezable?
 Kernel threads are not freezable by default.  However, a kernel thread may clear
 PF_NOFREEZE for itself by calling set_freezable() (the resetting of PF_NOFREEZE
 directly is not allowed).  From this point it is regarded as freezable
-and must call try_to_freeze() in a suitable place.
+and must call try_to_freeze() or variants of wait_event_freezable() in a
+suitable place.
 
 IV. Why do we do that?
 ======================
-- 
2.39.2


