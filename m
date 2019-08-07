Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20D44841D1
	for <lists+linux-pm@lfdr.de>; Wed,  7 Aug 2019 03:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfHGBtO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 6 Aug 2019 21:49:14 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34649 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfHGBtM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 6 Aug 2019 21:49:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id n9so36338421pgc.1
        for <linux-pm@vger.kernel.org>; Tue, 06 Aug 2019 18:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+cWjblxys9jvBGMz2ReNMT3KEsqiKkgdMmx/Dji3ic=;
        b=fdQ67Q+l8+XTgeeOmljKyom4YChAQekZlf7EUda9GHBiM1386D/xLZaTkp9gBWzuH0
         9xR37ddgj++zfAzrz59YGiZ0wYZ1w94vuvyoeMjevmLOkJVbSTMJ1YSFAOs5B6cDRegF
         cEfD4I20l8tq5ObtpyVLotjkS0BOvko99mYuq1APtp5CMP/lOWQofHEz2dJuf7kiZeSq
         amJujqgCETcthrfVayh58ucS9Sc6YIP4jcvSuzd2zJWWImZXFTiTImblzdOTYCZmaSz3
         qpG98x7bZu26sd+pQ9RBHkZugmp5Jwgv8wGe8hnlLTH0le38gHE65TT6Fz/Ywyizkj4O
         5Ucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+cWjblxys9jvBGMz2ReNMT3KEsqiKkgdMmx/Dji3ic=;
        b=QLg5jvc3MfaTlmefoB4JQGaqbZA3Fr7y7ELxqMalxZ9POrmtAmHKdkAxFWUQ8Ru8c4
         7FcW2RfwIhC8aS6yUn+Tgdk/yHL259mWrAlK78lI9U1MRUM+35yPmVpWs8EJHjQ2ub1R
         9C3GmChkL2XRB2JWjR+Ei8l4N7QDit1fwdsfwtCCcI9bGMZDt9OB1Ov3kRSaoFoyU7sw
         7VJzpCh628LygCpgcXjJ8uCizjA/T2uUonkgEJKeJ0BW2dpJI1VBCZSqcOp9rUy4ocof
         7jUA11rjxEVTwfAUyX/dCnqIEiQ3ODc4cmulKmcZ12lbLIOCaGuMxiMV0FlpI9hyHzRk
         VVtA==
X-Gm-Message-State: APjAAAUzZVYYYPwjaHQMluA+RYgdrjYEoMKsMThGnCxmShtGSG03CY3O
        cwvLqWbTsL32HLttEjKDfhTSYg==
X-Google-Smtp-Source: APXvYqyFX5kVk2bko37zQEtGbGSQpigvLQVNy3LJvOjDq6bOjhECqmpwIxL12tcKy7NJdr7Qkq5qJA==
X-Received: by 2002:a17:90a:ac11:: with SMTP id o17mr6076289pjq.134.1565142551727;
        Tue, 06 Aug 2019 18:49:11 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id q1sm104159076pfg.84.2019.08.06.18.49.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 06 Aug 2019 18:49:11 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v8 2/3] PM / wakeup: Use wakeup_source_register() in wakelock.c
Date:   Tue,  6 Aug 2019 18:48:45 -0700
Message-Id: <20190807014846.143949-3-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190807014846.143949-1-trong@android.com>
References: <20190807014846.143949-1-trong@android.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

kernel/power/wakelock.c duplicates wakeup source creation and
registration code from drivers/base/power/wakeup.c.

Change struct wakelock's wakeup source to a pointer and use
wakeup_source_register() function to create and register said wakeup
source. Use wakeup_source_unregister() on cleanup path.

Signed-off-by: Tri Vo <trong@android.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 kernel/power/wakelock.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/kernel/power/wakelock.c b/kernel/power/wakelock.c
index 4210152e56f0..d1eb7fd98b64 100644
--- a/kernel/power/wakelock.c
+++ b/kernel/power/wakelock.c
@@ -27,7 +27,7 @@ static DEFINE_MUTEX(wakelocks_lock);
 struct wakelock {
 	char			*name;
 	struct rb_node		node;
-	struct wakeup_source	ws;
+	struct wakeup_source	*ws;
 #ifdef CONFIG_PM_WAKELOCKS_GC
 	struct list_head	lru;
 #endif
@@ -46,7 +46,7 @@ ssize_t pm_show_wakelocks(char *buf, bool show_active)
 
 	for (node = rb_first(&wakelocks_tree); node; node = rb_next(node)) {
 		wl = rb_entry(node, struct wakelock, node);
-		if (wl->ws.active == show_active)
+		if (wl->ws->active == show_active)
 			str += scnprintf(str, end - str, "%s ", wl->name);
 	}
 	if (str > buf)
@@ -112,16 +112,16 @@ static void __wakelocks_gc(struct work_struct *work)
 		u64 idle_time_ns;
 		bool active;
 
-		spin_lock_irq(&wl->ws.lock);
-		idle_time_ns = ktime_to_ns(ktime_sub(now, wl->ws.last_time));
-		active = wl->ws.active;
-		spin_unlock_irq(&wl->ws.lock);
+		spin_lock_irq(&wl->ws->lock);
+		idle_time_ns = ktime_to_ns(ktime_sub(now, wl->ws->last_time));
+		active = wl->ws->active;
+		spin_unlock_irq(&wl->ws->lock);
 
 		if (idle_time_ns < ((u64)WL_GC_TIME_SEC * NSEC_PER_SEC))
 			break;
 
 		if (!active) {
-			wakeup_source_remove(&wl->ws);
+			wakeup_source_unregister(wl->ws);
 			rb_erase(&wl->node, &wakelocks_tree);
 			list_del(&wl->lru);
 			kfree(wl->name);
@@ -187,9 +187,15 @@ static struct wakelock *wakelock_lookup_add(const char *name, size_t len,
 		kfree(wl);
 		return ERR_PTR(-ENOMEM);
 	}
-	wl->ws.name = wl->name;
-	wl->ws.last_time = ktime_get();
-	wakeup_source_add(&wl->ws);
+
+	wl->ws = wakeup_source_register(wl->name);
+	if (!wl->ws) {
+		kfree(wl->name);
+		kfree(wl);
+		return ERR_PTR(-ENOMEM);
+	}
+	wl->ws->last_time = ktime_get();
+
 	rb_link_node(&wl->node, parent, node);
 	rb_insert_color(&wl->node, &wakelocks_tree);
 	wakelocks_lru_add(wl);
@@ -233,9 +239,9 @@ int pm_wake_lock(const char *buf)
 		u64 timeout_ms = timeout_ns + NSEC_PER_MSEC - 1;
 
 		do_div(timeout_ms, NSEC_PER_MSEC);
-		__pm_wakeup_event(&wl->ws, timeout_ms);
+		__pm_wakeup_event(wl->ws, timeout_ms);
 	} else {
-		__pm_stay_awake(&wl->ws);
+		__pm_stay_awake(wl->ws);
 	}
 
 	wakelocks_lru_most_recent(wl);
@@ -271,7 +277,7 @@ int pm_wake_unlock(const char *buf)
 		ret = PTR_ERR(wl);
 		goto out;
 	}
-	__pm_relax(&wl->ws);
+	__pm_relax(wl->ws);
 
 	wakelocks_lru_most_recent(wl);
 	wakelocks_gc();
-- 
2.22.0.770.g0f2c4a37fd-goog

