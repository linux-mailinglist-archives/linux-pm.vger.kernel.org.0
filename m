Return-Path: <linux-pm+bounces-34691-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8DB583E2
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 19:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232BF48873C
	for <lists+linux-pm@lfdr.de>; Mon, 15 Sep 2025 17:43:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D812C0281;
	Mon, 15 Sep 2025 17:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dk6wVnu6"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F359D2BE625
	for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 17:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757958165; cv=none; b=ReKzdVR5CxSepFizLrcEZFFSh5O9LLaRmFf4MSH5Yjus7mykjt8s4wlhxNlZVoVds1S+qb9FM813+QLnY3FqqpjyxMJdsXRk4t9N/yzam3zQN+5NGBqQFuSMshFnzdasKH+W3VvOz3iUF1ttCi3puY/2mN4fYgCO/s+InvWAPnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757958165; c=relaxed/simple;
	bh=iIuAx2JJmrgxbWM5e2basggpv/AeW5AUpcLAOdDXJhE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l4w28LZfhbPNGNBObz9aOk6Mgs5NrzaxT6p3Mp/LKjWc9t2UAKGh5cGa2wVYEdb21Izq7776U1T+DC5b02NB9QoPVNGajBxz6M2kLoNhC8lDCQTHzj/t5vWNhq78zr/VwP1KkXw18VoweqnyWmwQPrTewXH1HymLC7878iwZ8cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dk6wVnu6; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7723f0924a3so5569136b3a.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Sep 2025 10:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757958163; x=1758562963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6b0KuwU6j12efKQOY8dZE63PnJPo0f1sevexcHHq57w=;
        b=Dk6wVnu6rGNQYr55Okv0SEkrixUZaWTHPijZacZUGUEleVMlDjK6T4aPlUNMk+H42X
         cVTGaLBicVsv8nJZjzCPHvR+BD+mwwrlKwHGkrSARSBL11VFyZnadXenMq4Czj+JLqR0
         Tp2GESf+0T5/5KFeaD1LnkdxTT0HgwRmQVo2q/Sidwl+Klk7UNzANJsVvPn9t/EFZpO4
         HODly38SoN/q0CPKkFYZ3pYV5889xc/+5X4DgnrJWSZo/T0JF9VKgiiDB9IIlb/Cglb5
         NGurkKClNOJyDqsH9t8OOelcUM2C8EpwV9poBa08kR6e0/ZEwDxzPZA7VDml2tJw3bI8
         4E/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757958163; x=1758562963;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6b0KuwU6j12efKQOY8dZE63PnJPo0f1sevexcHHq57w=;
        b=PrRoAWKYowxwYsDLcbQMrOTMqWe7zK96iFScSCVtSkfZ45HepoPjn/AE63lANYydbz
         ux0GCp1B6+r+qBmo2GzRB+PhbEDjQIX7ZCpxKLyQk7V1hP6SSpDaW/StNZVIsqOdor06
         LpilOjvXHQKnzCJWyvYAAXQU60X/2lj0jh25QA3mAJf1Q/3gkf/88IFwKoAmYm4TW8k0
         3i5iX0lk6XxtrbtKfwmZb7TlZcaa1hSIhrn5ZXB0BTDmp2MCVRfdptwSk6CWi2TK0ipj
         7AX6qK7mF7iC581qzGgs2xhMVh6QL7cj3OKP6+lzpEnwFox9x+rdpnTTOXEx7id1piaC
         inuw==
X-Gm-Message-State: AOJu0YykIfWvenvVbWHi8Yc6NkiGELBVDPsqzx7xLwLXMjFg0LTTwUTm
	B6JTwFZSPM5AZM65ESncXYoBkzkTmaRlmMjHRM87FX0tt3u5nRQutqE+
X-Gm-Gg: ASbGncvoWuXjCST/PDSi/fOH5AIUKNpvHGpNhmm5ISNubujI3Fezwt0PlcYssNh8A5K
	ObSuN4E+7u13wlBfyiiai8anafe8KlcDsuUIaO2u8IW0Ok/Hk4HvTEUDIYkCPSrnvR1ou3IuXya
	8MdJCT42CyPNUMB4EQH+yL7DSzfJd3Nqs198Z5XkhdtIonEO54CuqvGthnFc1qjSWx55R9Drpjp
	bZ4pfQw/1/piNq+vIw8NpGgHmJPTyvYKNc8pqHXf9UaLsrkRQnHY6yDbXqQ8CeOBPn9aDtcneb9
	RSwHxHwK5dOsnZKSxV307P6JjNCeuIFyb0cPoBvWkabrLKPPb9FsnUhTZbe2v4RuDdhcOcCiqjt
	o0fzEuWumwuCOVa5O7s6MjKm6U4KyQ/MGDXeewXjerPTqygLyz/nVwG+nkIMaZK5K
X-Google-Smtp-Source: AGHT+IHnMte/JH/TgBJWIa1QjarJY3d03Taro3j2D/fUNVZVh+OdeayWomtOekuzROYqyQ8BssxBLA==
X-Received: by 2002:a05:6a21:3285:b0:24e:2cb:673d with SMTP id adf61e73a8af0-2602a8950ccmr18581817637.14.1757958163126;
        Mon, 15 Sep 2025 10:42:43 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:ecb8:4012:29bc:7830])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dfd00c7efsm8968248a91.25.2025.09.15.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:42:42 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: rafael@kernel.org,
	daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vivek Yadav <vivekyadav1207731111@gmail.com>,
	Joe Perches <joe@perches.com>
Subject: [PATCH v2] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
Date: Mon, 15 Sep 2025 10:41:41 -0700
Message-Id: <20250915174141.244346-1-vivekyadav1207731111@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vivek Yadav <vivekyadav1207731111@gmail.com>

The ->show() callbacks in sysfs should use sysfs_emit() or
sysfs_emit_at() when formatting values for user space. These helpers
are the recommended way to ensure correct buffer handling and
consistency across the kernel.

See Documentation/filesystems/sysfs.rst for details.

No functional change intended.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: vivek yadav <vivekyadav1207731111@gmail.com>
---
Changes in v2:
- Do not modify the variable 'i'; leave it unchanged.
---
 drivers/cpuidle/sysfs.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d6f5da61cb7d..61de64817604 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -27,14 +27,14 @@ static ssize_t show_available_governors(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >= (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
+		if (i >= (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
 			goto out;
 
-		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
+		i += sysfs_emit_at(buf, i, "%.*s ", CPUIDLE_NAME_LEN, tmp->name);
 	}
 
 out:
-	i+= sprintf(&buf[i], "\n");
+	i += sysfs_emit_at(buf, i, "\n");
 	mutex_unlock(&cpuidle_lock);
 	return i;
 }
@@ -49,9 +49,9 @@ static ssize_t show_current_driver(struct device *dev,
 	spin_lock(&cpuidle_driver_lock);
 	drv = cpuidle_get_driver();
 	if (drv)
-		ret = sprintf(buf, "%s\n", drv->name);
+		ret = sysfs_emit(buf, "%s\n", drv->name);
 	else
-		ret = sprintf(buf, "none\n");
+		ret = sysfs_emit(buf, "none\n");
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
@@ -65,9 +65,9 @@ static ssize_t show_current_governor(struct device *dev,
 
 	mutex_lock(&cpuidle_lock);
 	if (cpuidle_curr_governor)
-		ret = sprintf(buf, "%s\n", cpuidle_curr_governor->name);
+		ret = sysfs_emit(buf, "%s\n", cpuidle_curr_governor->name);
 	else
-		ret = sprintf(buf, "none\n");
+		ret = sysfs_emit(buf, "none\n");
 	mutex_unlock(&cpuidle_lock);
 
 	return ret;
@@ -230,7 +230,7 @@ static struct cpuidle_state_attr attr_##_name = __ATTR(_name, 0644, show, store)
 static ssize_t show_state_##_name(struct cpuidle_state *state, \
 			 struct cpuidle_state_usage *state_usage, char *buf) \
 { \
-	return sprintf(buf, "%u\n", state->_name);\
+	return sysfs_emit(buf, "%u\n", state->_name);\
 }
 
 #define define_show_state_ull_function(_name) \
@@ -238,7 +238,7 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  struct cpuidle_state_usage *state_usage, \
 				  char *buf)				\
 { \
-	return sprintf(buf, "%llu\n", state_usage->_name);\
+	return sysfs_emit(buf, "%llu\n", state_usage->_name);\
 }
 
 #define define_show_state_str_function(_name) \
@@ -247,8 +247,8 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  char *buf)				\
 { \
 	if (state->_name[0] == '\0')\
-		return sprintf(buf, "<null>\n");\
-	return sprintf(buf, "%s\n", state->_name);\
+		return sysfs_emit(buf, "<null>\n");\
+	return sysfs_emit(buf, "%s\n", state->_name);\
 }
 
 #define define_show_state_time_function(_name) \
@@ -256,7 +256,7 @@ static ssize_t show_state_##_name(struct cpuidle_state *state, \
 				  struct cpuidle_state_usage *state_usage, \
 				  char *buf) \
 { \
-	return sprintf(buf, "%llu\n", ktime_to_us(state->_name##_ns)); \
+	return sysfs_emit(buf, "%llu\n", ktime_to_us(state->_name##_ns)); \
 }
 
 define_show_state_time_function(exit_latency)
@@ -273,14 +273,14 @@ static ssize_t show_state_time(struct cpuidle_state *state,
 			       struct cpuidle_state_usage *state_usage,
 			       char *buf)
 {
-	return sprintf(buf, "%llu\n", ktime_to_us(state_usage->time_ns));
+	return sysfs_emit(buf, "%llu\n", ktime_to_us(state_usage->time_ns));
 }
 
 static ssize_t show_state_disable(struct cpuidle_state *state,
 				  struct cpuidle_state_usage *state_usage,
 				  char *buf)
 {
-	return sprintf(buf, "%llu\n",
+	return sysfs_emit(buf, "%llu\n",
 		       state_usage->disable & CPUIDLE_STATE_DISABLED_BY_USER);
 }
 
@@ -310,7 +310,7 @@ static ssize_t show_state_default_status(struct cpuidle_state *state,
 					  struct cpuidle_state_usage *state_usage,
 					  char *buf)
 {
-	return sprintf(buf, "%s\n",
+	return sysfs_emit(buf, "%s\n",
 		       state->flags & CPUIDLE_FLAG_OFF ? "disabled" : "enabled");
 }
 
@@ -358,7 +358,7 @@ static ssize_t show_state_s2idle_##_name(struct cpuidle_state *state, \
 					 struct cpuidle_state_usage *state_usage, \
 					 char *buf)				\
 { \
-	return sprintf(buf, "%llu\n", state_usage->s2idle_##_name);\
+	return sysfs_emit(buf, "%llu\n", state_usage->s2idle_##_name);\
 }
 
 define_show_state_s2idle_ull_function(usage);
@@ -550,7 +550,7 @@ static ssize_t show_driver_name(struct cpuidle_driver *drv, char *buf)
 	ssize_t ret;
 
 	spin_lock(&cpuidle_driver_lock);
-	ret = sprintf(buf, "%s\n", drv ? drv->name : "none");
+	ret = sysfs_emit(buf, "%s\n", drv ? drv->name : "none");
 	spin_unlock(&cpuidle_driver_lock);
 
 	return ret;
-- 
2.25.1


