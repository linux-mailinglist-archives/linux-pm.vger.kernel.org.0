Return-Path: <linux-pm+bounces-11293-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31239938B6C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 10:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB499280D1C
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD99C1662EF;
	Mon, 22 Jul 2024 08:42:01 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8494125BA;
	Mon, 22 Jul 2024 08:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721637721; cv=none; b=DDzEmLBaTDXaQ9gKY9xxsuDJz9QAxhCiWq+Vt6XC26HyP8m/pM2zpachS/41Nf1eEUjRuYfiJ5PWL8KNmQTX2bISOZ9vRNpjXWcNKy9Rfo6eXibcC/kFCHRQ0ChbnVT8LwGM4IHRrOz58elVe8pYseLmRMTGhVa1v1/EXId6LtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721637721; c=relaxed/simple;
	bh=wBwPjBG9cKdqscz5iOVkGv1EzfSWW4wF4tkTCqR6zZo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ePBwIL7ltaFf4vin8yMvIiWHwwhb5MHY7jbnyOQrc8KaSPWz9b8THEUgsQXJFPITImEGVpd55n8C4wCUiDCs4Q9bbrXYGBz+r676h9czBU/wt0Mm2ZVPW+Loy70IHSb84hXXMQQ4t8FfgpKKGUOxW+Seqj3p1KeUCT64nX4F6FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7a23fbb372dso335027a12.0;
        Mon, 22 Jul 2024 01:41:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721637718; x=1722242518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L956lMrl4yDRPtEd1LkclZKsLxY8hqv+cr9i++beO1Q=;
        b=YnC9sP+ReCYJCElCGcM8HSZZ8fB277B3tXDBnOGI8HKreEQgygtU2ZTbZKDKNc0hqq
         CeVtgi/eSBoZNgWv4d+Vagpq5SrjWYwxCw+h7w09Kacps//Xz30bbdyNznTmots70MWP
         nkJJqBVGiztTrqDdwAzpe7l6BtAanFTR3HK69eLDSa376xPl/6LsVW9V2xDqQgpGViSY
         O4tYXdN17as9hory7ISeSDLG0T72A1JxJE0HcuiFHqCn/s+aAIXg6B1wH6l4fFHNwuRF
         w49zQs1ORkRVrMaTnZfJ4HyK03DDv3mlH9yVjD2nrlUHd+h+Pp5lC7qD8/2LSxAz6632
         eqGg==
X-Forwarded-Encrypted: i=1; AJvYcCV44SKzYvXHYmvluu9tUdab9ratBaAeoJK04gcnX+aJGz9xXLM3HAAUfsqFQ6aY5rujlB03M9yua5YLumJYRQTwew/UAbNXRidt9QUu
X-Gm-Message-State: AOJu0Yz2vIKrEgygm1Y799VCFZny+dQE0DUlsBtiye0xI3cStnv528lL
	kDKbahNo5tak9Juobdc4/F/pCli1LSXBBZ0a/uOZZ8uhGT4SnROu
X-Google-Smtp-Source: AGHT+IHpVHVN7+8bsC50j7nungl82vM1cXvaBiuR7JYevZkQkUnJVn8RK38oyqu2tb+CddZgrx+qBw==
X-Received: by 2002:a05:6a21:3a4b:b0:1bd:27be:5dca with SMTP id adf61e73a8af0-1c4285798b6mr3972484637.29.1721637717858;
        Mon, 22 Jul 2024 01:41:57 -0700 (PDT)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f2ab34dsm49237385ad.110.2024.07.22.01.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 01:41:57 -0700 (PDT)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH -next] PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Mon, 22 Jul 2024 16:41:49 +0800
Message-Id: <20240722084149.13076-1-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xueqin Luo <luoxueqin@kylinos.cn>

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/main.c | 70 ++++++++++++++++++++++-----------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..4ea4e2fa4da7 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -115,7 +115,7 @@ int pm_async_enabled = 1;
 static ssize_t pm_async_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", pm_async_enabled);
+	return sysfs_emit(buf, "%d\n", pm_async_enabled);
 }
 
 static ssize_t pm_async_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -139,8 +139,8 @@ power_attr(pm_async);
 static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			      char *buf)
 {
-	char *s = buf;
 	suspend_state_t i;
+	ssize_t sz = 0;
 
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
 		if (i >= PM_SUSPEND_MEM && cxl_mem_active())
@@ -149,17 +149,17 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *label = mem_sleep_states[i];
 
 			if (mem_sleep_current == i)
-				s += sprintf(s, "[%s] ", label);
+				sz += sysfs_emit_at(buf, sz, "[%s] ", label);
 			else
-				s += sprintf(s, "%s ", label);
+				sz += sysfs_emit_at(buf, sz, "%s ", label);
 		}
 	}
 
 	/* Convert the last space to a newline if needed. */
-	if (s != buf)
-		*(s-1) = '\n';
+	if (sz)
+		sz += sysfs_emit_at(buf, sz, "\n");
 
-	return (s - buf);
+	return sz;
 }
 
 static suspend_state_t decode_suspend_state(const char *buf, size_t n)
@@ -220,7 +220,7 @@ bool sync_on_suspend_enabled = !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
 static ssize_t sync_on_suspend_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", sync_on_suspend_enabled);
+	return sysfs_emit(buf, "%d\n", sync_on_suspend_enabled);
 }
 
 static ssize_t sync_on_suspend_store(struct kobject *kobj,
@@ -257,22 +257,22 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
 static ssize_t pm_test_show(struct kobject *kobj, struct kobj_attribute *attr,
 				char *buf)
 {
-	char *s = buf;
 	int level;
+	size_t sz = 0;
 
 	for (level = TEST_FIRST; level <= TEST_MAX; level++)
 		if (pm_tests[level]) {
 			if (level == pm_test_level)
-				s += sprintf(s, "[%s] ", pm_tests[level]);
+				sz += sysfs_emit_at(buf, sz, "[%s] ", pm_tests[level]);
 			else
-				s += sprintf(s, "%s ", pm_tests[level]);
+				sz += sysfs_emit_at(buf, sz, "%s ", pm_tests[level]);
 		}
 
-	if (s != buf)
+	if (sz)
 		/* convert the last space to a newline */
-		*(s-1) = '\n';
+		sz += sysfs_emit_at(buf, sz, "\n");
 
-	return (s - buf);
+	return sz;
 }
 
 static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -390,7 +390,7 @@ static const char * const suspend_step_names[] = {
 static ssize_t _name##_show(struct kobject *kobj,		\
 		struct kobj_attribute *attr, char *buf)		\
 {								\
-	return sprintf(buf, format_str, suspend_stats._name);	\
+	return sysfs_emit(buf, format_str, suspend_stats._name);	\
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
 
@@ -404,7 +404,7 @@ suspend_attr(max_hw_sleep, "%llu\n");
 static ssize_t _name##_show(struct kobject *kobj,		\
 		struct kobj_attribute *attr, char *buf)		\
 {								\
-	return sprintf(buf, "%u\n",				\
+	return sysfs_emit(buf, "%u\n",				\
 		       suspend_stats.step_failures[step-1]);	\
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
@@ -428,7 +428,7 @@ static ssize_t last_failed_dev_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	last_failed_dev = suspend_stats.failed_devs[index];
 
-	return sprintf(buf, "%s\n", last_failed_dev);
+	return sysfs_emit(buf, "%s\n", last_failed_dev);
 }
 static struct kobj_attribute last_failed_dev = __ATTR_RO(last_failed_dev);
 
@@ -442,7 +442,7 @@ static ssize_t last_failed_errno_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	last_failed_errno = suspend_stats.errno[index];
 
-	return sprintf(buf, "%d\n", last_failed_errno);
+	return sysfs_emit(buf, "%d\n", last_failed_errno);
 }
 static struct kobj_attribute last_failed_errno = __ATTR_RO(last_failed_errno);
 
@@ -456,7 +456,7 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	step = suspend_stats.failed_steps[index];
 
-	return sprintf(buf, "%s\n", suspend_step_names[step]);
+	return sysfs_emit(buf, "%s\n", suspend_step_names[step]);
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
@@ -571,7 +571,7 @@ bool pm_print_times_enabled;
 static ssize_t pm_print_times_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", pm_print_times_enabled);
+	return sysfs_emit(buf, "%d\n", pm_print_times_enabled);
 }
 
 static ssize_t pm_print_times_store(struct kobject *kobj,
@@ -604,7 +604,7 @@ static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
 	if (!pm_wakeup_irq())
 		return -ENODATA;
 
-	return sprintf(buf, "%u\n", pm_wakeup_irq());
+	return sysfs_emit(buf, "%u\n", pm_wakeup_irq());
 }
 
 power_attr_ro(pm_wakeup_irq);
@@ -620,7 +620,7 @@ EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", pm_debug_messages_on);
+	return sysfs_emit(buf, "%d\n", pm_debug_messages_on);
 }
 
 static ssize_t pm_debug_messages_store(struct kobject *kobj,
@@ -668,21 +668,21 @@ struct kobject *power_kobj;
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 			  char *buf)
 {
-	char *s = buf;
+	ssize_t sz = 0;
 #ifdef CONFIG_SUSPEND
 	suspend_state_t i;
 
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
 		if (pm_states[i])
-			s += sprintf(s,"%s ", pm_states[i]);
+			sz += sysfs_emit_at(buf, sz, "%s ", pm_states[i]);
 
 #endif
 	if (hibernation_available())
-		s += sprintf(s, "disk ");
-	if (s != buf)
+		sz += sysfs_emit_at(buf, sz, "disk ");
+	if (sz)
 		/* convert the last space to a newline */
-		*(s-1) = '\n';
-	return (s - buf);
+		sz += sysfs_emit_at(buf, sz, "\n");
+	return sz;
 }
 
 static suspend_state_t decode_state(const char *buf, size_t n)
@@ -782,7 +782,7 @@ static ssize_t wakeup_count_show(struct kobject *kobj,
 	unsigned int val;
 
 	return pm_get_wakeup_count(&val, true) ?
-		sprintf(buf, "%u\n", val) : -EINTR;
+		sysfs_emit(buf, "%u\n", val) : -EINTR;
 }
 
 static ssize_t wakeup_count_store(struct kobject *kobj,
@@ -824,17 +824,17 @@ static ssize_t autosleep_show(struct kobject *kobj,
 	suspend_state_t state = pm_autosleep_state();
 
 	if (state == PM_SUSPEND_ON)
-		return sprintf(buf, "off\n");
+		return sysfs_emit(buf, "off\n");
 
 #ifdef CONFIG_SUSPEND
 	if (state < PM_SUSPEND_MAX)
-		return sprintf(buf, "%s\n", pm_states[state] ?
+		return sysfs_emit(buf, "%s\n", pm_states[state] ?
 					pm_states[state] : "error");
 #endif
 #ifdef CONFIG_HIBERNATION
-	return sprintf(buf, "disk\n");
+	return sysfs_emit(buf, "disk\n");
 #else
-	return sprintf(buf, "error");
+	return sysfs_emit(buf, "error\n");
 #endif
 }
 
@@ -903,7 +903,7 @@ int pm_trace_enabled;
 static ssize_t pm_trace_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", pm_trace_enabled);
+	return sysfs_emit(buf, "%d\n", pm_trace_enabled);
 }
 
 static ssize_t
@@ -940,7 +940,7 @@ power_attr_ro(pm_trace_dev_match);
 static ssize_t pm_freeze_timeout_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", freeze_timeout_msecs);
+	return sysfs_emit(buf, "%u\n", freeze_timeout_msecs);
 }
 
 static ssize_t pm_freeze_timeout_store(struct kobject *kobj,
-- 
2.25.1


