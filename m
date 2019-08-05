Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB49A8245D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2019 19:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbfHER7p (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 5 Aug 2019 13:59:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37156 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730036AbfHER7o (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 5 Aug 2019 13:59:44 -0400
Received: by mail-pg1-f195.google.com with SMTP id d1so7309836pgp.4
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2019 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ou5mCElOB4urfT5gwIsyCFAyBUIFq+/ixcrewBEfyI=;
        b=WyEv20ud3mTQTMZYo4VPlCt2OhWL/evbwmkiX6gaKW4IVE35VZzrMhAuKVz/SA0dBd
         vTti6oh9tVzZoTbXREOv0gz5UkxqKz0MmQeP9ROOABm4LMdNjW9JRWqT8zrRizV41old
         3YYzxBnJPras1wDtkc8oF9lTRxkkE9fPiSswT9hG1i5rLI2eXj1hN+kSPUeTj5daSbx5
         1TIxV0gO/XkDROsbbrL34U9lmpMRt78E1TP/ij2X/AGfGvtSSbmb/srEa6v6dVTfxgEi
         UUCVWZzxq5eYQSJ8Pzs1czIILkycqWXYN7pFrAN4zYKHjhO7ZtDxMXkma1dszH253gUi
         dIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ou5mCElOB4urfT5gwIsyCFAyBUIFq+/ixcrewBEfyI=;
        b=N/dVmmPOcYS/AZlsWGFSYgZvNY7eKqFsHHVpi16iRYBT+QGKhqiIWHu51smJrQ/196
         +N1KttyTAA2TqaHOivLkyKBUt90jAvpTBBGjulP78IlVd/OfAx6GWv5S8cdfLBwombL+
         BW2yXV7uCUsRmMXX3L8xVav5RgLsbD9z7QAALd5r12B/wZzQVBE29V/Cw6EH8Mz7Db2i
         ez5MpWKKc1AAZX98TDiWi67MCjdr5V1iL73p3gjaZUYufQ9NLMbZ1BhU6NHpvqkhCh6z
         W5LOjDyPUR+1CTiTZbfvQ+z+ihlSCG5q5ObeDfcE/rG+fP7jJt7gyXjneDKIBKxSDCUg
         nhxg==
X-Gm-Message-State: APjAAAUeUrQXmeAlMygF2MTf0zAXzpmKylH4cbp0DWxv1xCOYCBmNb5h
        OblPDkP75HovRRwgg/LM0V8=
X-Google-Smtp-Source: APXvYqwt4F6G3awZ8GzpZxFuhH7YAyo70XcQEsJIlj+LV8NFq5U5n027TZIDTTXi0lhtNY7eCb038w==
X-Received: by 2002:a63:2157:: with SMTP id s23mr21071800pgm.167.1565027984105;
        Mon, 05 Aug 2019 10:59:44 -0700 (PDT)
Received: from trong0.mtv.corp.google.com ([2620:15c:211:0:469:982a:29da:f29b])
        by smtp.gmail.com with ESMTPSA id f19sm124403670pfk.180.2019.08.05.10.59.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 05 Aug 2019 10:59:43 -0700 (PDT)
From:   Tri Vo <trong@android.com>
To:     rjw@rjwysocki.net, gregkh@linuxfoundation.org,
        viresh.kumar@linaro.org
Cc:     rafael@kernel.org, hridya@google.com, sspatil@google.com,
        kaleshsingh@google.com, ravisadineni@chromium.org,
        swboyd@chromium.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, kernel-team@android.com,
        Tri Vo <trong@android.com>
Subject: [PATCH v7 2/3] PM / wakeup: Use wakeup_source_register() in wakelock.c
Date:   Mon,  5 Aug 2019 10:58:47 -0700
Message-Id: <20190805175848.163558-3-trong@android.com>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805175848.163558-1-trong@android.com>
References: <20190805175848.163558-1-trong@android.com>
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

