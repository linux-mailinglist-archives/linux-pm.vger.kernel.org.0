Return-Path: <linux-pm+bounces-17583-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0CA89C9506
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 23:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FEC61F214AC
	for <lists+linux-pm@lfdr.de>; Thu, 14 Nov 2024 22:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC19B1B0F02;
	Thu, 14 Nov 2024 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MUtV37RL"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8601B2194
	for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622183; cv=none; b=FEf8cin6nbD5Eb4HW3yhM5hiQjTeP6YyP9X8HnrjA4vOzwvJda7NmPEjphcdI/grQ9jTr8zoJz1ws2czZVQRE+HPN5/+bn5bNmsU+T2MMPR99COChjQ+yBwYQkWjfmFrMinfvQJqmctWGtEa4TKspM0ZNQUKauTe/3A884TBOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622183; c=relaxed/simple;
	bh=yWIxtwftansYT2XGRoXOSgWp9Y+jUrFX9t88GwIz62w=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=Fc76gfDa8Nya17uIeIuZwMwJD11apBdYjFKt2FJdyK70DUMPN6qxFZO0BOHvlqJhbt18rMzv/4Vk224ERVxNUVssGygbKocZOiZyDZlMojLTx9f+MN4tVdoSAIFPZOQFJkbpVhAvLQUipctQ4iA5P7pSmeuhiGmBaNuvYatyADk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MUtV37RL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6ee47f9f207so16492127b3.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Nov 2024 14:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731622181; x=1732226981; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oCE+wTj2NSDSuKVEvxg1xnDYLLwUUBXTSuE+NoiWWkY=;
        b=MUtV37RLBbu7x65rBG8kr/jhSMGvrxJ+LOr1Ft5zwl9zBLmG8JSD5GzNfMj/6Ho4B0
         Fy8EUM5QWLpiDmoyHjQD4Uw0PN53fEaANLvNjiVlijTZZRxYQpxuiqEWUxiEiCWTvenu
         jeWdo5qG4L0qjzIzZ8z4huMic+59aNWVXMSTGjFYkRmHY15aejSgWjipegES2oE+BuEw
         CVlxQnISTzu/lQMaZJPORyrIdYVVwDF+hRI43sRb4bgvVhhIb9X5Dm7SGeW0ahjc+N3z
         ZotYMkDDkZivgPEv8qskny8d9G5nqVUb9hFVLbG5lQWDvW6IN2OU/6phNoSwpLlMQizq
         ERig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731622181; x=1732226981;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oCE+wTj2NSDSuKVEvxg1xnDYLLwUUBXTSuE+NoiWWkY=;
        b=VThRtRU5cK9pxiwYTHdy5z4ypYIok0rfwG4qwaljfvEy56v7+x5h+Aer+t1QIsplpq
         WHL34N40IFuYnmQ7Ot9AFoecUVXfjqNOtOFAeFU0Zg84K0T3grHawdH7qZFyYNyZ6BPf
         +9vOlUeDBUIc52tQuvnsTDo0tYgBbneKSlTnN+CUfpzW6ZP14xQSrEGesEg43iPzaKtS
         8YRij5OUNWleLlNNx0Kn/9Sa3NceacpqTH4+WTUSWxJ2iZc4M3zAlEdpZCh4zJkYoeCM
         ZL7fCGuT9OAW/X1xlJswFBV2dSaj9OIfUW64ZNItbG8sAGQESjskhx099igTtZrPGCth
         diDg==
X-Forwarded-Encrypted: i=1; AJvYcCWc/DaDbfYGas4P8KX7tuj9lD9ElsD640FfhJAJsPhZAUVR0DMFO90oiihLULdY53K5GzvgsfaioQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz56WCuUigSoUcmm56Dan7SnE/q8PkUff7TTw2hnjw6kOsoZmrK
	sX32E2PCeFu6aaKogvubkFQ5HI49xypBiJPCU+MPNq3kSB6c4EFaHICgb8JE3WfTUJJmI7i2NHP
	IbqeKvZQRyEfaEA==
X-Google-Smtp-Source: AGHT+IGjEOUS7wMr4ogKkM7WbTZGcbWzZb2t3AGnu1yHNIrxDvljJSXUdc9GZvFgcfoE8/FWaYEEVqH22qJDxjg=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:3e23:8355:c37:686e])
 (user=saravanak job=sendgmr) by 2002:a05:690c:a17:b0:6ea:3c62:17c1 with SMTP
 id 00721157ae682-6ee55a553e0mr18637b3.1.1731622181452; Thu, 14 Nov 2024
 14:09:41 -0800 (PST)
Date: Thu, 14 Nov 2024 14:09:17 -0800
In-Reply-To: <20241114220921.2529905-1-saravanak@google.com>
Message-Id: <20241114220921.2529905-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241114220921.2529905-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Subject: [PATCH v1 3/5] PM: sleep: Add helper functions to loop through
 superior/subordinate devs
From: Saravana Kannan <saravanak@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: Saravana Kannan <saravanak@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Marek Vasut <marex@denx.de>, Bird@google.com, Tim <Tim.Bird@sony.com>, 
	kernel-team@android.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We have a lot of code that does or will loop through superior/subordinate
devices and take action on them. Refactor the code to pull out the common
"loop through" functionality into helper functions to avoid repeating the
logic.

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/power/main.c | 70 ++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 30 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 9b9b6088e56a..aa1470ef6ac0 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -247,15 +247,22 @@ static int dpm_wait_fn(struct device *dev, void *async_ptr)
 	return 0;
 }
 
-static void dpm_wait_for_children(struct device *dev, bool async)
-{
-       device_for_each_child(dev, &async, dpm_wait_fn);
-}
-
-static void dpm_wait_for_suppliers(struct device *dev, bool async)
+static int dpm_for_each_superior(struct device *dev, void *data,
+				 int (*fn)(struct device *dev, void *data))
 {
+	struct device *parent;
+	int ret = 0, idx;
 	struct device_link *link;
-	int idx;
+
+	if (!dev)
+		return 0;
+
+	parent = get_device(dev->parent);
+	if (parent)
+		ret = fn(parent, data);
+	put_device(parent);
+	if (ret)
+		return ret;
 
 	idx = device_links_read_lock();
 
@@ -267,29 +274,20 @@ static void dpm_wait_for_suppliers(struct device *dev, bool async)
 	 * walking.
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.suppliers, c_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
-			dpm_wait(link->supplier, async);
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT) {
+			ret = fn(link->supplier, data);
+			if (ret)
+				break;
+		}
 
 	device_links_read_unlock(idx);
+
+	return ret;
 }
 
 static bool dpm_wait_for_superior(struct device *dev, bool async)
 {
-	struct device *parent;
-
-	/*
-	 * If the device is resumed asynchronously and the parent's callback
-	 * deletes both the device and the parent itself, the parent object may
-	 * be freed while this function is running, so avoid that by reference
-	 * counting the parent once more unless the device has been deleted
-	 * already (in which case return right away).
-	 */
-	parent = get_device(dev->parent);
-	if (device_pm_initialized(dev))
-		dpm_wait(parent, async);
-	put_device(parent);
-
-	dpm_wait_for_suppliers(dev, async);
+	dpm_for_each_superior(dev, &async, dpm_wait_fn);
 
 	/*
 	 * If the parent's callback has deleted the device, attempting to resume
@@ -298,10 +296,18 @@ static bool dpm_wait_for_superior(struct device *dev, bool async)
 	return device_pm_initialized(dev);
 }
 
-static void dpm_wait_for_consumers(struct device *dev, bool async)
+static int dpm_for_each_subordinate(struct device *dev, void *data,
+				    int (*fn)(struct device *dev, void *data))
 {
+	int ret, idx;
 	struct device_link *link;
-	int idx;
+
+	if (!dev)
+		return 0;
+
+	ret = device_for_each_child(dev, data, fn);
+	if (ret)
+		return ret;
 
 	idx = device_links_read_lock();
 
@@ -315,16 +321,20 @@ static void dpm_wait_for_consumers(struct device *dev, bool async)
 	 * unregistration).
 	 */
 	list_for_each_entry_rcu_locked(link, &dev->links.consumers, s_node)
-		if (READ_ONCE(link->status) != DL_STATE_DORMANT)
-			dpm_wait(link->consumer, async);
+		if (READ_ONCE(link->status) != DL_STATE_DORMANT) {
+			ret = fn(link->consumer, data);
+			if (ret)
+				break;
+		}
 
 	device_links_read_unlock(idx);
+
+	return ret;
 }
 
 static void dpm_wait_for_subordinate(struct device *dev, bool async)
 {
-	dpm_wait_for_children(dev, async);
-	dpm_wait_for_consumers(dev, async);
+	dpm_for_each_subordinate(dev, &async, dpm_wait_fn);
 }
 
 /**
-- 
2.47.0.338.g60cca15819-goog


