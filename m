Return-Path: <linux-pm+bounces-8735-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C948FF3B6
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 19:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BB251F27E90
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1771990CE;
	Thu,  6 Jun 2024 17:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yXB3t5wM"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B21990B0
	for <linux-pm@vger.kernel.org>; Thu,  6 Jun 2024 17:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717694899; cv=none; b=DMOvwdLBGhItUWeB01yiWSPPS9HaXi7p5Z4oAWpvexsnrdk6GLFFC74zqK2bQwdoz6agkcNkXDb+TVovEDY0iTSPorwLwyqCuequ/tgxZAbUFA/PU0QyVeOaQujr/wTULV/QiwcB0z7pjXhwdtWSRoqWf20uZEXl8VCNlyvhaGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717694899; c=relaxed/simple;
	bh=VyaTOddNCzEFJ/NEh/9NuxV4q03NkvdncMSoKRh5+1c=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cY1Db9peM7+7dTnbw/aoCBkc8Arprm3jKyeL9MHTTzWttaA6f9R9/9xqwxJm/a8LX8hsLlUluk68rId+LqS8TUIegCXukd6NRYtXnnuYmC4c8I88mpVUVNGoxIVaacNcT6eRIbzsgNWaCsHATM4MTmf5htuvLXLqm86YbPQLuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yXB3t5wM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-df796aaa57dso1842828276.1
        for <linux-pm@vger.kernel.org>; Thu, 06 Jun 2024 10:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717694897; x=1718299697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HgRRo88YfpvYO7wSKqGlPrXzX3q2dRMuM6tAFdbCFr0=;
        b=yXB3t5wMDrrw9Run39TOpZ+h7Q9lnvAdfioCbhEPhYFAnzgBB/p8LAM6xEIwvn1iYs
         cES716Y24+eXYnCQKVPpcVAr6lfWv/DDNkD8VA38RbZ31MqgIZzpEJjN44YPpLLS7U1V
         A+POHMK/vfWvgXPHrdS5DblevpYFDQpHf0SmAz8reI6Rn/7Zmz1rDP2/Sdvdrwe2W79M
         krjzFD8WbymCUhkcnDCd+jF81aOKKvm21EynQXnw4jORFca19oupSsbs37UfAdM0ISih
         GxVJyg4vkuSZ62miKHMxjvD3tmWtyAgsTjhKpDHU+YqY5qI7rb7j6JKzqceOkO1INYgt
         fSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717694897; x=1718299697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgRRo88YfpvYO7wSKqGlPrXzX3q2dRMuM6tAFdbCFr0=;
        b=XWV/DeMNm7MutY134oFxy2k6+bmlCnFQHMdyDzuZmTNuzxAlK7l1L5HYAmj5kNO1am
         RbRBTObcWRjMDKUu3Yy3wSWetYTHZtGfxeDrEc5MK6Dexrzz5HgT095+gD+65wTUt47e
         u79QwH9NwfPoNZifqN1Ni8EDtfdVLzJ0LrXlfDW95LgIZdYCj2gWRR31AcUB/nKj0KWb
         c1BoX1003nL6PLcK5+Mf0Tvvc+iCaYOHFBxJeCLBazfRe3j0iFxOHk8/qlxI3CwqSFw3
         kCa/q0MQzVo2PP0xrJ80c0hA4BjK74WLDQvAZ7XrDVEP/GTs+08XnjbSRL5bnMYiLTut
         +ALQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZFAPE7gdimOhXsh9fkHyWZNQqeOftcp/8JmYbeAL4Pd7U1qRYqHeom+j6xMo3cdhwuJD2ubzMndrzftCV3dbHj/UiFmv6pB4=
X-Gm-Message-State: AOJu0YyHnat+VlvR6rFbpphRYY6alAj74A09W/m8GWHBYlVtTtNVlAcd
	pPl2h/VdS82sskZM7S5Q2rOwD9tGdtthReh/DBVq1/GELuYglhgD/I2nikVce5MqLaCj/+d4lSH
	fLk8tyWbkQiuZOAtZvjpauNJHskLbf0dHvQ==
X-Google-Smtp-Source: AGHT+IGmL/ci+QUeD78WXo0hxk1uBw/HJGmZ0Y2PniemChSJPTzIQcW9M9adT9vpi4Jwi6aRAmFxTkLHJQdDOs8cEtopoQ==
X-Received: from isaacmanjarres.irv.corp.google.com ([2620:15c:2d:3:662b:6cb2:952a:1074])
 (user=isaacmanjarres job=sendgmr) by 2002:a25:b28a:0:b0:df7:7a90:26c1 with
 SMTP id 3f1490d57ef6-dfaf667f667mr10303276.13.1717694896769; Thu, 06 Jun 2024
 10:28:16 -0700 (PDT)
Date: Thu,  6 Jun 2024 10:28:11 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
Message-ID: <20240606172813.2755930-1-isaacmanjarres@google.com>
Subject: [PATCH v5] fs: Improve eventpoll logging to stop indicting timerfd
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: tglx@linutronix.de, "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: saravanak@google.com, Manish Varma <varmam@google.com>, 
	Kelly Rossmoyer <krossmo@google.com>, "Isaac J . Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Manish Varma <varmam@google.com>

timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
it names them after the underlying file descriptor, and since all
timerfd file descriptors are named "[timerfd]" (which saves memory on
systems like desktops with potentially many timerfd instances), all
wakesources created as a result of using the eventpoll-on-timerfd idiom
are called... "[timerfd]".

However, it becomes impossible to tell which "[timerfd]" wakesource is
affliated with which process and hence troubleshooting is difficult.

This change addresses this problem by changing the way eventpoll
wakesources are named:

1) the top-level per-process eventpoll wakesource is now named
"epollN:P" (instead of just "eventpoll"), where N is a unique ID token,
and P is the PID of the creating process.
2) individual per-underlying-file descriptor eventpoll wakesources are
now named "epollitemN:P.F", where N is a unique ID token and P is PID
of the creating process and F is the name of the underlying file
descriptor.

Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Manish Varma <varmam@google.com>
Co-developed-by: Isaac J. Manjarres <isaacmanjarres@google.com>
Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 drivers/base/power/wakeup.c | 12 +++++++++---
 fs/eventpoll.c              | 11 +++++++++--
 include/linux/pm_wakeup.h   |  8 ++++----
 3 files changed, 22 insertions(+), 9 deletions(-)

 v1 -> v2:
 - Renamed instance count to wakesource_create_id to better describe
   its purpose.
 - Changed the wakeup source naming convention for wakeup sources
   created by eventpoll to avoid changing the timerfd names.
 - Used the PID of the process instead of the process name for the
   sake of uniqueness when creating wakeup sources.

v2 -> v3:
 - Changed wakeup_source_register() to take in a format string
   and arguments to avoid duplicating code to construct wakeup
   source names.
 - Moved the definition of wakesource_create_id so that it is
   always defined to fix an compilation error.

v3 -> v4:
 - Changed the naming convention for the top-level epoll wakeup
   sources to include an ID for uniqueness. This is needed in
   cases where a process is using two epoll fds.
 - Edited commit log to reflect new changes and add new tags.

v4 -> v5:
 - Added the format attribute to the wakeup_source_register()
   function to address a warning from the kernel test robot:
   https://lore.kernel.org/all/202406050504.UvdlPAQ0-lkp@intel.com/

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 752b417e8129..04a808607b62 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -209,13 +209,19 @@ EXPORT_SYMBOL_GPL(wakeup_source_remove);
 /**
  * wakeup_source_register - Create wakeup source and add it to the list.
  * @dev: Device this wakeup source is associated with (or NULL if virtual).
- * @name: Name of the wakeup source to register.
+ * @fmt: format string for the wakeup source name
  */
-struct wakeup_source *wakeup_source_register(struct device *dev,
-					     const char *name)
+__printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
+							    const char *fmt, ...)
 {
 	struct wakeup_source *ws;
 	int ret;
+	char name[128];
+	va_list args;
+
+	va_start(args, fmt);
+	vsnprintf(name, sizeof(name), fmt, args);
+	va_end(args);
 
 	ws = wakeup_source_create(name);
 	if (ws) {
diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index f53ca4f7fced..941df15208a4 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -338,6 +338,7 @@ static void __init epoll_sysctls_init(void)
 #define epoll_sysctls_init() do { } while (0)
 #endif /* CONFIG_SYSCTL */
 
+static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
 static const struct file_operations eventpoll_fops;
 
 static inline int is_file_epoll(struct file *f)
@@ -1545,15 +1546,21 @@ static int ep_create_wakeup_source(struct epitem *epi)
 {
 	struct name_snapshot n;
 	struct wakeup_source *ws;
+	pid_t task_pid;
+	int id;
+
+	task_pid = task_pid_nr(current);
 
 	if (!epi->ep->ws) {
-		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
+		id = atomic_inc_return(&wakesource_create_id);
+		epi->ep->ws = wakeup_source_register(NULL, "epoll:%d:%d", id, task_pid);
 		if (!epi->ep->ws)
 			return -ENOMEM;
 	}
 
+	id = atomic_inc_return(&wakesource_create_id);
 	take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
-	ws = wakeup_source_register(NULL, n.name.name);
+	ws = wakeup_source_register(NULL, "epollitem%d:%d.%s", id, task_pid, n.name.name);
 	release_dentry_name_snapshot(&n);
 
 	if (!ws)
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 76cd1f9f1365..1fb6dca981c2 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -99,8 +99,8 @@ extern struct wakeup_source *wakeup_source_create(const char *name);
 extern void wakeup_source_destroy(struct wakeup_source *ws);
 extern void wakeup_source_add(struct wakeup_source *ws);
 extern void wakeup_source_remove(struct wakeup_source *ws);
-extern struct wakeup_source *wakeup_source_register(struct device *dev,
-						    const char *name);
+extern __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
+								   const char *fmt, ...);
 extern void wakeup_source_unregister(struct wakeup_source *ws);
 extern int wakeup_sources_read_lock(void);
 extern void wakeup_sources_read_unlock(int idx);
@@ -140,8 +140,8 @@ static inline void wakeup_source_add(struct wakeup_source *ws) {}
 
 static inline void wakeup_source_remove(struct wakeup_source *ws) {}
 
-static inline struct wakeup_source *wakeup_source_register(struct device *dev,
-							   const char *name)
+static inline __printf(2, 3) struct wakeup_source *wakeup_source_register(struct device *dev,
+									  const char *fmt, ...)
 {
 	return NULL;
 }
-- 
2.45.2.505.gda0bf45e8d-goog


