Return-Path: <linux-pm+bounces-620-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50980135E
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 20:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8135A281D23
	for <lists+linux-pm@lfdr.de>; Fri,  1 Dec 2023 19:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C7F4D591;
	Fri,  1 Dec 2023 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W2sJfbwu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEACF7
	for <linux-pm@vger.kernel.org>; Fri,  1 Dec 2023 11:08:09 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-40b427507b7so18844825e9.2
        for <linux-pm@vger.kernel.org>; Fri, 01 Dec 2023 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701457688; x=1702062488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nj4VAuE8MTf4eQgVQLJ9SNGHYUT0fHZr0ARFuliSZA=;
        b=W2sJfbwuiPthV1DxqX1eJkQ8exxftHd7Lfmo1UtG0lBMGh4iiceupXUfRtE1C6MD7L
         pK21oYwlX3u2UFwQhy+JprxAsLND2qdWvSEHcvf49gP4MryC/dn1LduK4kUBjAeOnY2A
         Q3dlB3OtO9PwQyxBL+rM9yxkYSm7WWULAOcwFT9i8Pc/GTHanZ8CsYDZT1KroUPU8IzB
         B5QRTooYAGaJS6YuULZaH5b81/BBZ2fyhQOj7tGX/2FCWDGVOPCAVA5QxITRrnlz/UTx
         dYiUqLZ6+aPcq5ydDLMio9zGs3iqNv8wV7oCKIyGO3f0ua1idh+jTeQt6nu+SDNZTM7k
         IsDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457688; x=1702062488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nj4VAuE8MTf4eQgVQLJ9SNGHYUT0fHZr0ARFuliSZA=;
        b=XLvD+xrkuaioKgVNRKMk2QYMmWb2mpQX2qjHnEp/FbWRb5AZd//ZvcjX1PmMW9rpQM
         mpwBVcNtzTGLLoj7enAqG8BS707jPSF6CHqyRR4KHX3AgxeouXaUO9rmR5QinGz0umnz
         Q1ciTHXQt7bK5DIq8PfRVcceNky88p1PXyMh6q2znYHTDedCuQFhltlaWSwNTRlVnj/g
         iLpQg1ZyJL07q2c2+E7iPS247+uWa3RzTbyxTtviovE6FPBAxlbfUlczIPb81TgZYpCh
         LoFujlsRRH48OplRpMUKiBponwO2XfbjWUrxHsee4HfAFa5N98zipGb5NvZjuWERSNp6
         M+eQ==
X-Gm-Message-State: AOJu0YzV2ubZGlKXjXEUGBDJL/NF8TzPp5EXvyybmAoWSS80+35ZxFet
	pk0H8tM1PFthYJoW0Ku8uqA/9w==
X-Google-Smtp-Source: AGHT+IER3E+4kHeP9v2kxD++QEfpLXpfsQOkFGltsDIFa6JnH/ldZ0+NqP4uIJrjS+ogzNd0Dv/68Q==
X-Received: by 2002:a05:600c:19d2:b0:40b:5e21:cc30 with SMTP id u18-20020a05600c19d200b0040b5e21cc30mr564863wmq.91.1701457687904;
        Fri, 01 Dec 2023 11:08:07 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:e7a7:a382:dc2f:bb93])
        by smtp.gmail.com with ESMTPSA id dr6-20020a5d5f86000000b003316b38c625sm4911828wrb.99.2023.12.01.11.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 11:08:07 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: rjw@rjwysocki.net
Cc: caleb.connolly@linaro.org,
	lina.iyer@linaro.org,
	linux-pm@vger.kernel.org,
	mani@kernel.org,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com
Subject: [RFC PATCH 1/2] pm_qos: Rename freq to interval constraint
Date: Fri,  1 Dec 2023 20:07:56 +0100
Message-Id: <20231201190757.144741-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The frequency pm_qos relies on a couple of values, the min and max
frequencies. However more pm_qos will be added with the same logic of
a couple of min and max. Instead of writing new set of constraints as
well as type, etc... let's rename freq_* to a more generic name
interval_*

That way, new qos interval based can be added easily.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/base/power/qos.c          |  4 +--
 drivers/powercap/dtpm_cpu.c       |  2 +-
 drivers/thermal/cpufreq_cooling.c |  2 +-
 include/linux/cpufreq.h           |  6 ++--
 include/linux/pm_qos.h            | 55 ++++++++++++++++---------------
 kernel/power/qos.c                | 53 +++++++++++++++--------------
 6 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 8e93167f1783..561d2a0e106c 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -285,14 +285,14 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 		memset(req, 0, sizeof(*req));
 	}
 
-	c = &qos->freq.min_freq;
+	c = &qos->freq.min;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ,
 				 PM_QOS_MIN_FREQUENCY_DEFAULT_VALUE);
 		memset(req, 0, sizeof(*req));
 	}
 
-	c = &qos->freq.max_freq;
+	c = &qos->freq.max;
 	plist_for_each_entry_safe(req, tmp, &c->list, data.freq.pnode) {
 		apply_constraint(req, PM_QOS_REMOVE_REQ,
 				 PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index 2ff7717530bf..6587c94d0127 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -28,7 +28,7 @@
 
 struct dtpm_cpu {
 	struct dtpm dtpm;
-	struct freq_qos_request qos_req;
+	struct interval_qos_request qos_req;
 	int cpu;
 };
 
diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index e2cc7bd30862..72e9f0cde55c 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -77,7 +77,7 @@ struct cpufreq_cooling_device {
 #ifndef CONFIG_SMP
 	struct time_in_idle *idle_time;
 #endif
-	struct freq_qos_request qos_req;
+	struct interval_qos_request qos_req;
 };
 
 #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 71d186d6933a..7e2d66c37535 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -80,9 +80,9 @@ struct cpufreq_policy {
 	struct work_struct	update; /* if update_policy() needs to be
 					 * called, but you're in IRQ context */
 
-	struct freq_constraints	constraints;
-	struct freq_qos_request	*min_freq_req;
-	struct freq_qos_request	*max_freq_req;
+	struct interval_constraints	constraints;
+	struct interval_qos_request	*min_freq_req;
+	struct interval_qos_request	*max_freq_req;
 
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
index 4a69d4af3ff8..a662ac918e3e 100644
--- a/include/linux/pm_qos.h
+++ b/include/linux/pm_qos.h
@@ -77,25 +77,26 @@ struct pm_qos_flags {
 #define FREQ_QOS_MIN_DEFAULT_VALUE	0
 #define FREQ_QOS_MAX_DEFAULT_VALUE	S32_MAX
 
-enum freq_qos_req_type {
-	FREQ_QOS_MIN = 1,
+enum interval_qos_req_type {
+	INTERVAL_QOS_MIN = 1,
+	INTERVAL_QOS_MAX,
+	FREQ_QOS_MIN,
 	FREQ_QOS_MAX,
 };
 
-struct freq_constraints {
-	struct pm_qos_constraints min_freq;
-	struct blocking_notifier_head min_freq_notifiers;
-	struct pm_qos_constraints max_freq;
-	struct blocking_notifier_head max_freq_notifiers;
+struct interval_constraints {
+	struct pm_qos_constraints min;
+	struct blocking_notifier_head min_notifiers;
+	struct pm_qos_constraints max;
+	struct blocking_notifier_head max_notifiers;
 };
 
-struct freq_qos_request {
-	enum freq_qos_req_type type;
+struct interval_qos_request {
+	enum interval_qos_req_type type;
 	struct plist_node pnode;
-	struct freq_constraints *qos;
+	struct interval_constraints *qos;
 };
 
-
 enum dev_pm_qos_req_type {
 	DEV_PM_QOS_RESUME_LATENCY = 1,
 	DEV_PM_QOS_LATENCY_TOLERANCE,
@@ -109,7 +110,7 @@ struct dev_pm_qos_request {
 	union {
 		struct plist_node pnode;
 		struct pm_qos_flags_request flr;
-		struct freq_qos_request freq;
+		struct interval_qos_request freq;
 	} data;
 	struct device *dev;
 };
@@ -117,7 +118,7 @@ struct dev_pm_qos_request {
 struct dev_pm_qos {
 	struct pm_qos_constraints resume_latency;
 	struct pm_qos_constraints latency_tolerance;
-	struct freq_constraints freq;
+	struct interval_constraints freq;
 	struct pm_qos_flags flags;
 	struct dev_pm_qos_request *resume_latency_req;
 	struct dev_pm_qos_request *latency_tolerance_req;
@@ -291,29 +292,29 @@ static inline s32 dev_pm_qos_raw_resume_latency(struct device *dev)
 }
 #endif
 
-static inline int freq_qos_request_active(struct freq_qos_request *req)
+static inline int freq_qos_request_active(struct interval_qos_request *req)
 {
 	return !IS_ERR_OR_NULL(req->qos);
 }
 
-void freq_constraints_init(struct freq_constraints *qos);
+void freq_constraints_init(struct interval_constraints *qos);
 
-s32 freq_qos_read_value(struct freq_constraints *qos,
-			enum freq_qos_req_type type);
+s32 freq_qos_read_value(struct interval_constraints *qos,
+			enum interval_qos_req_type type);
 
-int freq_qos_add_request(struct freq_constraints *qos,
-			 struct freq_qos_request *req,
-			 enum freq_qos_req_type type, s32 value);
-int freq_qos_update_request(struct freq_qos_request *req, s32 new_value);
-int freq_qos_remove_request(struct freq_qos_request *req);
-int freq_qos_apply(struct freq_qos_request *req,
+int freq_qos_add_request(struct interval_constraints *qos,
+			 struct interval_qos_request *req,
+			 enum interval_qos_req_type type, s32 value);
+int freq_qos_update_request(struct interval_qos_request *req, s32 new_value);
+int freq_qos_remove_request(struct interval_qos_request *req);
+int freq_qos_apply(struct interval_qos_request *req,
 		   enum pm_qos_req_action action, s32 value);
 
-int freq_qos_add_notifier(struct freq_constraints *qos,
-			  enum freq_qos_req_type type,
+int freq_qos_add_notifier(struct interval_constraints *qos,
+			  enum interval_qos_req_type type,
 			  struct notifier_block *notifier);
-int freq_qos_remove_notifier(struct freq_constraints *qos,
-			     enum freq_qos_req_type type,
+int freq_qos_remove_notifier(struct interval_constraints *qos,
+			     enum interval_qos_req_type type,
 			     struct notifier_block *notifier);
 
 #endif
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4244b069442e..6ff6c494f84d 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -440,26 +440,26 @@ static inline bool freq_qos_value_invalid(s32 value)
  * freq_constraints_init - Initialize frequency QoS constraints.
  * @qos: Frequency QoS constraints to initialize.
  */
-void freq_constraints_init(struct freq_constraints *qos)
+void freq_constraints_init(struct interval_constraints *qos)
 {
 	struct pm_qos_constraints *c;
 
-	c = &qos->min_freq;
+	c = &qos->min;
 	plist_head_init(&c->list);
 	c->target_value = FREQ_QOS_MIN_DEFAULT_VALUE;
 	c->default_value = FREQ_QOS_MIN_DEFAULT_VALUE;
 	c->no_constraint_value = FREQ_QOS_MIN_DEFAULT_VALUE;
 	c->type = PM_QOS_MAX;
-	c->notifiers = &qos->min_freq_notifiers;
+	c->notifiers = &qos->min_notifiers;
 	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
 
-	c = &qos->max_freq;
+	c = &qos->max;
 	plist_head_init(&c->list);
 	c->target_value = FREQ_QOS_MAX_DEFAULT_VALUE;
 	c->default_value = FREQ_QOS_MAX_DEFAULT_VALUE;
 	c->no_constraint_value = FREQ_QOS_MAX_DEFAULT_VALUE;
 	c->type = PM_QOS_MIN;
-	c->notifiers = &qos->max_freq_notifiers;
+	c->notifiers = &qos->max_notifiers;
 	BLOCKING_INIT_NOTIFIER_HEAD(c->notifiers);
 }
 
@@ -468,8 +468,8 @@ void freq_constraints_init(struct freq_constraints *qos)
  * @qos: Constraints to evaluate.
  * @type: QoS request type.
  */
-s32 freq_qos_read_value(struct freq_constraints *qos,
-			enum freq_qos_req_type type)
+s32 freq_qos_read_value(struct interval_constraints *qos,
+			enum interval_qos_req_type type)
 {
 	s32 ret;
 
@@ -477,15 +477,14 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
 	case FREQ_QOS_MIN:
 		ret = IS_ERR_OR_NULL(qos) ?
 			FREQ_QOS_MIN_DEFAULT_VALUE :
-			pm_qos_read_value(&qos->min_freq);
+			pm_qos_read_value(&qos->min);
 		break;
 	case FREQ_QOS_MAX:
 		ret = IS_ERR_OR_NULL(qos) ?
 			FREQ_QOS_MAX_DEFAULT_VALUE :
-			pm_qos_read_value(&qos->max_freq);
+			pm_qos_read_value(&qos->max);
 		break;
 	default:
-		WARN_ON(1);
 		ret = 0;
 	}
 
@@ -500,18 +499,18 @@ s32 freq_qos_read_value(struct freq_constraints *qos,
  *
  * This is only meant to be called from inside pm_qos, not drivers.
  */
-int freq_qos_apply(struct freq_qos_request *req,
-			  enum pm_qos_req_action action, s32 value)
+int freq_qos_apply(struct interval_qos_request *req,
+		   enum pm_qos_req_action action, s32 value)
 {
 	int ret;
 
 	switch(req->type) {
 	case FREQ_QOS_MIN:
-		ret = pm_qos_update_target(&req->qos->min_freq, &req->pnode,
+		ret = pm_qos_update_target(&req->qos->min, &req->pnode,
 					   action, value);
 		break;
 	case FREQ_QOS_MAX:
-		ret = pm_qos_update_target(&req->qos->max_freq, &req->pnode,
+		ret = pm_qos_update_target(&req->qos->max, &req->pnode,
 					   action, value);
 		break;
 	default:
@@ -535,9 +534,9 @@ int freq_qos_apply(struct freq_qos_request *req,
  * Return 1 if the effective constraint value has changed, 0 if the effective
  * constraint value has not changed, or a negative error code on failures.
  */
-int freq_qos_add_request(struct freq_constraints *qos,
-			 struct freq_qos_request *req,
-			 enum freq_qos_req_type type, s32 value)
+int freq_qos_add_request(struct interval_constraints *qos,
+			 struct interval_qos_request *req,
+			 enum interval_qos_req_type type, s32 value)
 {
 	int ret;
 
@@ -571,7 +570,7 @@ EXPORT_SYMBOL_GPL(freq_qos_add_request);
  * Return 1 if the effective constraint value has changed, 0 if the effective
  * constraint value has not changed, or a negative error code on failures.
  */
-int freq_qos_update_request(struct freq_qos_request *req, s32 new_value)
+int freq_qos_update_request(struct interval_qos_request *req, s32 new_value)
 {
 	if (!req || freq_qos_value_invalid(new_value))
 		return -EINVAL;
@@ -597,7 +596,7 @@ EXPORT_SYMBOL_GPL(freq_qos_update_request);
  * Return 1 if the effective constraint value has changed, 0 if the effective
  * constraint value has not changed, or a negative error code on failures.
  */
-int freq_qos_remove_request(struct freq_qos_request *req)
+int freq_qos_remove_request(struct interval_qos_request *req)
 {
 	int ret;
 
@@ -622,8 +621,8 @@ EXPORT_SYMBOL_GPL(freq_qos_remove_request);
  * @type: Request type.
  * @notifier: Notifier block to add.
  */
-int freq_qos_add_notifier(struct freq_constraints *qos,
-			  enum freq_qos_req_type type,
+int freq_qos_add_notifier(struct interval_constraints *qos,
+			  enum interval_qos_req_type type,
 			  struct notifier_block *notifier)
 {
 	int ret;
@@ -633,11 +632,11 @@ int freq_qos_add_notifier(struct freq_constraints *qos,
 
 	switch (type) {
 	case FREQ_QOS_MIN:
-		ret = blocking_notifier_chain_register(qos->min_freq.notifiers,
+		ret = blocking_notifier_chain_register(qos->min.notifiers,
 						       notifier);
 		break;
 	case FREQ_QOS_MAX:
-		ret = blocking_notifier_chain_register(qos->max_freq.notifiers,
+		ret = blocking_notifier_chain_register(qos->max.notifiers,
 						       notifier);
 		break;
 	default:
@@ -655,8 +654,8 @@ EXPORT_SYMBOL_GPL(freq_qos_add_notifier);
  * @type: Request type.
  * @notifier: Notifier block to remove.
  */
-int freq_qos_remove_notifier(struct freq_constraints *qos,
-			     enum freq_qos_req_type type,
+int freq_qos_remove_notifier(struct interval_constraints *qos,
+			     enum interval_qos_req_type type,
 			     struct notifier_block *notifier)
 {
 	int ret;
@@ -666,11 +665,11 @@ int freq_qos_remove_notifier(struct freq_constraints *qos,
 
 	switch (type) {
 	case FREQ_QOS_MIN:
-		ret = blocking_notifier_chain_unregister(qos->min_freq.notifiers,
+		ret = blocking_notifier_chain_unregister(qos->min.notifiers,
 							 notifier);
 		break;
 	case FREQ_QOS_MAX:
-		ret = blocking_notifier_chain_unregister(qos->max_freq.notifiers,
+		ret = blocking_notifier_chain_unregister(qos->max.notifiers,
 							 notifier);
 		break;
 	default:
-- 
2.34.1


