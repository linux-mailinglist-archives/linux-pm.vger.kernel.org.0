Return-Path: <linux-pm+bounces-11730-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA2F942493
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 04:45:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9D21F246F8
	for <lists+linux-pm@lfdr.de>; Wed, 31 Jul 2024 02:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1666117BA2;
	Wed, 31 Jul 2024 02:45:40 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A9417996;
	Wed, 31 Jul 2024 02:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722393940; cv=none; b=AhTcir0xz5E0nidkm6K7u9Cgz4eNaSPjVDKv4Xk3KBIqWE34jWlhrtLNfOEKAP2rMO+/HEBy9YNexTav6iFDWiyq3PPETPLqeg0vbyO0KhxJOx9CkIru1ax8bUN3U5QqZKKamH1DMp6I6SvaBsNsP5tLycmcpiH7WT5E8O/mUQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722393940; c=relaxed/simple;
	bh=+i3meHpClEaBRITFzAQ6pTrFnF9yaWPxauWqOmpmVTg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=StIxaTW/bEcNiA0ObEWolK+RcYqe4dFEikwngsV6n4RIV0EnF53y5gHngsNsWXP3PbYmDRiP1icrFGtRufgnqsOLLE9CqJbmx+KpkqBlj4u5fh5jovg0ia5JCkp+T0BnkxN7Oaa5z12ZRx9V0ihmR4ROJyP3+rEZlU36b2xegZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-1fd69e44596so3994985ad.1;
        Tue, 30 Jul 2024 19:45:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722393937; x=1722998737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRAX5M+SJSWKajgewJDOoJ71JG2/+gPlVOnejowt+Bw=;
        b=p+rvXslyoH5X9OVyqw9Ddi2O7xJ7QCcitb2JgaALVMHjHDjAxg+T8obqhOYeNMvqhv
         mseQ9gwpFPiRmVJsd5xvrCETG1HHTNfUR68CnR4+5gfbXTmx53iuE3ryAbfhxW0IqOuf
         yV+mqJ8Ld3O6RjQJIwWPsALmjm3NpZ9shzBCY1I2C+5NsgHKrA+TDotiDv3IThD/Qfhb
         A3xkYZxGpRXwd4yf2cirJOIIX8ixGS846z3x6mwzli/ERfC18jxaOzOKkIxjzIAsXNV9
         VouU5L6elkK4j/73Stp8lOIPKPzi08Y3c80eSBEspaFLZZKy5u3e0gwsl0vngmiMfJJ3
         DrNw==
X-Forwarded-Encrypted: i=1; AJvYcCVz7YaiNVqaUnKUb8bzxQTyZmqZFkHW2Ccckdo6i5tP/YVbeoAYHBbxJc/EM/sLMbrywY9HTtFLYSeZFbcWnPSeNmLFfbA47FcGPPDG
X-Gm-Message-State: AOJu0YzXvgIPdVpcgfVJWUDarTh3TxP0yBYxHmxDN34OI2MUZdrQ1FvL
	2e339ee6zlji9soMgv+GyZEAD1KhOHL4ICnbvBGqI8ZMhtLbGqOm
X-Google-Smtp-Source: AGHT+IEPKbXXZPVoG7IaZziGgZ96U7Zywnu1p6SEUCDf5uOF65tH+HI8/A9Ljx9zNewpj9kwoSn1Eg==
X-Received: by 2002:a17:902:7589:b0:1fc:54c4:61a7 with SMTP id d9443c01a7336-1ff37c201e4mr52842835ad.23.1722393937140;
        Tue, 30 Jul 2024 19:45:37 -0700 (PDT)
Received: from kylin-ThinkBook-15-G2-ITL.. ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c86afasm109620575ad.42.2024.07.30.19.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 19:45:36 -0700 (PDT)
From: xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [PATCH v2 2/2] PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Wed, 31 Jul 2024 10:45:18 +0800
Message-Id: <20240731024518.126716-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731024518.126716-1-luoxueqin@kylinos.cn>
References: <20240731024518.126716-1-luoxueqin@kylinos.cn>
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
 kernel/power/main.c | 82 +++++++++++++++++++++++++--------------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..18948b694205 100644
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
@@ -149,17 +149,19 @@ static ssize_t mem_sleep_show(struct kobject *kobj, struct kobj_attribute *attr,
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
+	if (sz) {
+		sz--;
+		sz += sysfs_emit_at(buf, sz, "\n");
+	}
 
-	return (s - buf);
+	return sz;
 }
 
 static suspend_state_t decode_suspend_state(const char *buf, size_t n)
@@ -220,7 +222,7 @@ bool sync_on_suspend_enabled = !IS_ENABLED(CONFIG_SUSPEND_SKIP_SYNC);
 static ssize_t sync_on_suspend_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", sync_on_suspend_enabled);
+	return sysfs_emit(buf, "%d\n", sync_on_suspend_enabled);
 }
 
 static ssize_t sync_on_suspend_store(struct kobject *kobj,
@@ -257,22 +259,24 @@ static const char * const pm_tests[__TEST_AFTER_LAST] = {
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
-		/* convert the last space to a newline */
-		*(s-1) = '\n';
+	/* Convert the last space to a newline if needed. */
+	if (sz) {
+		sz--;
+		sz += sysfs_emit_at(buf, sz, "\n");
+	}
 
-	return (s - buf);
+	return sz;
 }
 
 static ssize_t pm_test_store(struct kobject *kobj, struct kobj_attribute *attr,
@@ -390,7 +394,7 @@ static const char * const suspend_step_names[] = {
 static ssize_t _name##_show(struct kobject *kobj,		\
 		struct kobj_attribute *attr, char *buf)		\
 {								\
-	return sprintf(buf, format_str, suspend_stats._name);	\
+	return sysfs_emit(buf, format_str, suspend_stats._name);\
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
 
@@ -404,7 +408,7 @@ suspend_attr(max_hw_sleep, "%llu\n");
 static ssize_t _name##_show(struct kobject *kobj,		\
 		struct kobj_attribute *attr, char *buf)		\
 {								\
-	return sprintf(buf, "%u\n",				\
+	return sysfs_emit(buf, "%u\n",				\
 		       suspend_stats.step_failures[step-1]);	\
 }								\
 static struct kobj_attribute _name = __ATTR_RO(_name)
@@ -428,7 +432,7 @@ static ssize_t last_failed_dev_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	last_failed_dev = suspend_stats.failed_devs[index];
 
-	return sprintf(buf, "%s\n", last_failed_dev);
+	return sysfs_emit(buf, "%s\n", last_failed_dev);
 }
 static struct kobj_attribute last_failed_dev = __ATTR_RO(last_failed_dev);
 
@@ -442,7 +446,7 @@ static ssize_t last_failed_errno_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	last_failed_errno = suspend_stats.errno[index];
 
-	return sprintf(buf, "%d\n", last_failed_errno);
+	return sysfs_emit(buf, "%d\n", last_failed_errno);
 }
 static struct kobj_attribute last_failed_errno = __ATTR_RO(last_failed_errno);
 
@@ -456,7 +460,7 @@ static ssize_t last_failed_step_show(struct kobject *kobj,
 	index %= REC_FAILED_NUM;
 	step = suspend_stats.failed_steps[index];
 
-	return sprintf(buf, "%s\n", suspend_step_names[step]);
+	return sysfs_emit(buf, "%s\n", suspend_step_names[step]);
 }
 static struct kobj_attribute last_failed_step = __ATTR_RO(last_failed_step);
 
@@ -571,7 +575,7 @@ bool pm_print_times_enabled;
 static ssize_t pm_print_times_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", pm_print_times_enabled);
+	return sysfs_emit(buf, "%d\n", pm_print_times_enabled);
 }
 
 static ssize_t pm_print_times_store(struct kobject *kobj,
@@ -604,7 +608,7 @@ static ssize_t pm_wakeup_irq_show(struct kobject *kobj,
 	if (!pm_wakeup_irq())
 		return -ENODATA;
 
-	return sprintf(buf, "%u\n", pm_wakeup_irq());
+	return sysfs_emit(buf, "%u\n", pm_wakeup_irq());
 }
 
 power_attr_ro(pm_wakeup_irq);
@@ -620,7 +624,7 @@ EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 static ssize_t pm_debug_messages_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", pm_debug_messages_on);
+	return sysfs_emit(buf, "%d\n", pm_debug_messages_on);
 }
 
 static ssize_t pm_debug_messages_store(struct kobject *kobj,
@@ -668,21 +672,25 @@ struct kobject *power_kobj;
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
-		/* convert the last space to a newline */
-		*(s-1) = '\n';
-	return (s - buf);
+		sz += sysfs_emit_at(buf, sz, "disk ");
+
+	/* Convert the last space to a newline if needed. */
+	if (sz) {
+		sz--;
+		sz += sysfs_emit_at(buf, sz, "\n");
+	}
+
+	return sz;
 }
 
 static suspend_state_t decode_state(const char *buf, size_t n)
@@ -782,7 +790,7 @@ static ssize_t wakeup_count_show(struct kobject *kobj,
 	unsigned int val;
 
 	return pm_get_wakeup_count(&val, true) ?
-		sprintf(buf, "%u\n", val) : -EINTR;
+		sysfs_emit(buf, "%u\n", val) : -EINTR;
 }
 
 static ssize_t wakeup_count_store(struct kobject *kobj,
@@ -824,17 +832,17 @@ static ssize_t autosleep_show(struct kobject *kobj,
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
 
@@ -903,7 +911,7 @@ int pm_trace_enabled;
 static ssize_t pm_trace_show(struct kobject *kobj, struct kobj_attribute *attr,
 			     char *buf)
 {
-	return sprintf(buf, "%d\n", pm_trace_enabled);
+	return sysfs_emit(buf, "%d\n", pm_trace_enabled);
 }
 
 static ssize_t
@@ -940,7 +948,7 @@ power_attr_ro(pm_trace_dev_match);
 static ssize_t pm_freeze_timeout_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%u\n", freeze_timeout_msecs);
+	return sysfs_emit(buf, "%u\n", freeze_timeout_msecs);
 }
 
 static ssize_t pm_freeze_timeout_store(struct kobject *kobj,
-- 
2.25.1


