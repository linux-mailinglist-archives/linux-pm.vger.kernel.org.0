Return-Path: <linux-pm+bounces-11634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B359408F1
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 08:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2D25285085
	for <lists+linux-pm@lfdr.de>; Tue, 30 Jul 2024 06:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2EB190674;
	Tue, 30 Jul 2024 06:55:20 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C751C190679;
	Tue, 30 Jul 2024 06:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722322520; cv=none; b=tzWOfjTA7qmQPSzpZQ7rnrz8ULvkoaof+D5fTsgqZs2wEwryAg2Gdl7gd8PLNPEd7oX4YqVzDssNDzS4s0nvZ697XjpPvYlAZEHXjUUMlliGfwGivuxXVkiw+qPK72ii7HIIJkUpjuyMDHlK6THKG8VwSIBEJeWHNOhoxm2J7Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722322520; c=relaxed/simple;
	bh=PoHSTTNR1pOiYNNUBE7bjSLO9vqCQ+kY4ubAIS5usC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d648aLCqvB5YXGVDLmFV36tYhQ42et10lPqrphbxlImPpJqSZQdonGE5vCTBRg6sJpKQ62tuHga7NHKQLG1c/NlBIA4JSvPCjcyb4SUCdKyWKONuTP7AtacbOgB9K8Jb2+vRx2UKKBhAenX1yEX+A0RwzwxOiMMHDQuFtcs53UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-1fd9e6189d5so29650125ad.3;
        Mon, 29 Jul 2024 23:55:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722322518; x=1722927318;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5wItCNcIebvedYEvm9R9N3fFYU34EHG9QRxjv4o3IY=;
        b=NQkgY39wcEwKuoRrZog2y5JuFwqqbnpdU9FOrt/34tzMvD8lBakU9WyC7mudbo7J/Y
         +sGtKEvzxbByjzEGhsGjxnr45glEVaFbMy1e80lhOSou6VQWzq5cJLREuO2liKYfDa8r
         OZOlydH/OUYrgXzLet1y6bi2tFyhewbrsp9cUZzF4AXcQvDNKR7gNYdooGEMptEUxxcV
         C8c6Q2CA+hQEmrOxUrxpcfTcir9jFaZRHUVaVeWQXtoFmf8HC5frOWsDU8HeXHVDENvJ
         7uxEjCpCpC1hjaOabrpIi4FasrTIMnIuw2UoH/8b1HduTDUKlrIHGf9+dLm7jYs7eH8i
         AoBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmw7IBltkB+vmwni0zOreZzdIeKG1h6nfLW/eLzpP0nkpiJfd5E5jdXSdzL1i6Hw7bfxSysbogMJIvXIf0sqoJfhiO/78fD4Oa3WHc
X-Gm-Message-State: AOJu0YzauOPgiw9rthfYT+WwFIrjJv2bvUGAj9gR34G7WkeixusgCl3u
	Kxlo26Wia3D+Luuc71Hnz6kPdSsh3d1K74J1PEWu039j+pLPb/cf
X-Google-Smtp-Source: AGHT+IGbpeqVJZThdkiblEwt3ilFhbSlAjidRzQS+YIwiYxJn6p66YtqNHxmXa/ulBa9vv6UOU0nog==
X-Received: by 2002:a17:902:d506:b0:1fb:72b4:8775 with SMTP id d9443c01a7336-1ff0489f453mr88974555ad.40.1722322517939;
        Mon, 29 Jul 2024 23:55:17 -0700 (PDT)
Received: from localhost.localdomain ([111.48.58.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1aa18sm94392875ad.190.2024.07.29.23.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 23:55:17 -0700 (PDT)
From: Xueqin Luo <luoxueqin@kylinos.cn>
To: rafael@kernel.org,
	pavel@ucw.cz,
	len.brown@intel.com
Cc: linux-pm@vger.kernel.org,
	xiongxin@kylinos.cn,
	linux-kernel@vger.kernel.org,
	Xueqin Luo <luoxueqin@kylinos.cn>
Subject: [RESEND PATCH 2/2] PM: Use sysfs_emit() and sysfs_emit_at() in "show" functions
Date: Tue, 30 Jul 2024 14:54:54 +0800
Message-Id: <20240730065454.2096296-3-luoxueqin@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
References: <20240730065454.2096296-1-luoxueqin@kylinos.cn>
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


