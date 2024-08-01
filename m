Return-Path: <linux-pm+bounces-11800-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 878EE9446A7
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 10:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8AE2B217C0
	for <lists+linux-pm@lfdr.de>; Thu,  1 Aug 2024 08:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30916D4DF;
	Thu,  1 Aug 2024 08:32:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4621396;
	Thu,  1 Aug 2024 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501140; cv=none; b=RLKKOu89JbON1WYatYBdlsKv1LHYmYwDrpHj8YWaYEavOqDe6MFPX36OfFzYGJwwLfgT0QEtePwM9jkgKvGBQbQtvm0647p/CMknBfIC8TWhW9BU4xM+ADwYKsWcSvL3hfPUfMeMnbUYt9KvRTWNSKqX/+xEMke6cNFJ2lKYusE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501140; c=relaxed/simple;
	bh=2PJMnmiY0foq0p7zL2SpmDLMW72Ys7eTZYZxEyHF8Eg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DZfOfV/kBZFJM89SaYzCp/k+xGxyeJehV/6HQar7H3grER2wUYZpuVatcoub2p5TTYtDsu7AfYJg1dTDec4kf1BJY7SyLKPqeozCtzUEZPIXIwCyAhOQ0kj9Nua/K9pSPFSoJCSY1XN2zGYOL7Egsex/DB/wsXlYhnvoC49A9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1fc4fcbb131so59046695ad.3;
        Thu, 01 Aug 2024 01:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501138; x=1723105938;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XCq1orT8o9b0MZo32P366JKaOeFvtNO9/K9vJiTqSy8=;
        b=U6W3W/sIKjHs2HPQ+dsPJfWFMuM8SGR1+c/kLu2E/Rwjf9Z+h0PWUflZ/C9/sCdFIg
         ta9F286qu7oOC7yimckYxYNQnJy/0Jcg70ug3s3WPLw9AAITBlDqd90lSOGzeUtZ4E8+
         gzdzouRIWlZb/zAAsFvKGXLNIOG7XNcdmboXYrjZ8L4HAymKw7zhrFPiiBbPbLMTWsfp
         f8wyLnDMVMP4ZvrWavT1J3BV2nHpEDsxl/zSnGegPbRnX3CgnDukzUxJ0byNTZUKP61C
         E4onm8Pnr5TwRjuC3tzv95dvA9b8ZjAyQeOcX+HcafDCf+Y6+7rszdkoC95gdFNCR9Mz
         KzHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjhyrIPhZ6KpWtSTYRq8gFkjTWf6TCYWJudBqo0vkc+7BgOoxWl+qoBH7N1v4l/PUptwCs5ouhF6CT8mw+1/ifCkpZJlQp5wO7l/gC
X-Gm-Message-State: AOJu0YwDyvbAXeJjv4ixsHgTRCBFW1dMJTCtCuMK9Ua9xTJFvV0YG7nB
	n8G3DkGYJ2WI64dt3U0JYinkBGwND6tV46kgx2EzyxJLBrNlsFgDZv7t74rAGgw=
X-Google-Smtp-Source: AGHT+IHMK9O1lRU2nMPY/V5XcDos4bau2+dJ2hzHxnOLeIuBJVeCTE6Of4+zudXAGqkfoGwANBfplA==
X-Received: by 2002:a17:903:2304:b0:1fd:93d2:fb76 with SMTP id d9443c01a7336-1ff4cea5725mr22495915ad.31.1722501137825;
        Thu, 01 Aug 2024 01:32:17 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fb0fsm133288365ad.7.2024.08.01.01.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:32:17 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v3 2/2] PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Thu,  1 Aug 2024 16:31:56 +0800
Message-Id: <20240801083156.2513508-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
References: <20240801083156.2513508-1-luoxueqin@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Documentation/filesystems/sysfs.rst suggested,
show() should only use sysfs_emit() or sysfs_emit_at() when formatting
the value to be returned to user space.

No functional change intended.

Signed-off-by: Xueqin Luo <luoxueqin@kylinos.cn>
---
 kernel/power/main.c | 76 +++++++++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 37 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..6254814d4817 100644
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
@@ -139,7 +139,7 @@ power_attr(pm_async);
 static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			      char *buf)
 {
-	char *s = buf;
+	ssize_t count = 0;
 	suspend_state_t i;
 
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++) {
@@ -149,17 +149,17 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
 			const char *label = mem_sleep_states[i];
 
 			if (mem_sleep_current == i)
-				s += sprintf(s, "[%s] ", label);
+				count += sysfs_emit_at(buf, count, "[%s] ", label);
 			else
-				s += sprintf(s, "%s ", label);
+				count += sysfs_emit_at(buf, count, "%s ", label);
 		}
 	}
 
 	/* Convert the last space to a newline if needed. */
-	if (s != buf)
-		*(s-1) = '\n';
+	if (count > 0)
+		buf[count - 1] = '\n';
 
-	return (s - buf);
+	return count;
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
+	ssize_t count = 0;
 	int level;
 
 	for (level = TEST_FIRST; level <= TEST_MAX; level++)
 		if (pm_tests[level]) {
 			if (level == pm_test_level)
-				s += sprintf(s, "[%s] ", pm_tests[level]);
+				count += sysfs_emit_at(buf, count, "[%s] ", pm_tests[level]);
 			else
-				s += sprintf(s, "%s ", pm_tests[level]);
+				count += sysfs_emit_at(buf, count, "%s ", pm_tests[level]);
 		}
 
-	if (s != buf)
-		/* convert the last space to a newline */
-		*(s-1) = '\n';
+	/* Convert the last space to a newline if needed. */
+	if (count > 0)
+		buf[count - 1] = '\n';
 
-	return (s - buf);
+	return count;
 }
 
 static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -390,7 +390,7 @@ static const char * const suspend_step_names[] = {
 static ssize_t _name##_show(struct kobject *kobj,		\
 		struct kobj_attribute *attr, char *buf)		\
 {								\
-	return sprintf(buf, format_str, suspend_stats._name);	\
+	return sysfs_emit(buf, format_str, suspend_stats._name);\
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
@@ -668,21 +668,23 @@ struct kobject *power_kobj;
 static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 			  char *buf)
 {
-	char *s = buf;
+	ssize_t count = 0;
 #ifdef CONFIG_SUSPEND
 	suspend_state_t i;
 
 	for (i = PM_SUSPEND_MIN; i < PM_SUSPEND_MAX; i++)
 		if (pm_states[i])
-			s += sprintf(s,"%s ", pm_states[i]);
+			count += sysfs_emit_at(buf, count, "%s ", pm_states[i]);
 
 #endif
 	if (hibernation_available())
-		s += sprintf(s, "disk ");
-	if (s != buf)
-		/* convert the last space to a newline */
-		*(s-1) = '\n';
-	return (s - buf);
+		count += sysfs_emit_at(buf, count, "disk ");
+
+	/* Convert the last space to a newline if needed. */
+	if (count > 0)
+		buf[count - 1] = '\n';
+
+	return count;
 }
 
 static suspend_state_t decode_state(const char *buf, size_t n)
@@ -782,7 +784,7 @@ static ssize_t wakeup_count_show(struct kobject *kobj,
 	unsigned int val;
 
 	return pm_get_wakeup_count(&val, true) ?
-		sprintf(buf, "%u\n", val) : -EINTR;
+		sysfs_emit(buf, "%u\n", val) : -EINTR;
 }
 
 static ssize_t wakeup_count_store(struct kobject *kobj,
@@ -824,17 +826,17 @@ static ssize_t autosleep_show(struct kobject *kobj,
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
 
@@ -903,7 +905,7 @@ int pm_trace_enabled;
 static ssize_t pm_trace_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", pm_trace_enabled);
+	return sysfs_emit(buf, "%d\n", pm_trace_enabled);
 }
 
 static ssize_t
@@ -940,7 +942,7 @@ power_attr_ro(pm_trace_dev_match);
 static ssize_t pm_freeze_timeout_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", freeze_timeout_msecs);
+	return sysfs_emit(buf, "%u\n", freeze_timeout_msecs);
 }
 
 static ssize_t pm_freeze_timeout_store(struct kobject *kobj,
-- 
2.25.1


