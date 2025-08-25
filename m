Return-Path: <linux-pm+bounces-33048-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F5EB34ABA
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 20:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 281867A5B38
	for <lists+linux-pm@lfdr.de>; Mon, 25 Aug 2025 18:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1EB280CC9;
	Mon, 25 Aug 2025 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8Hl2h6M"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDE27F182;
	Mon, 25 Aug 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756148308; cv=none; b=jFhezLlPBxyX6ZwSUybDYeoq+mu5STNhqChklmPDLQtyumLqzUHTPFuYzfcOpmXg7HUB+tjfM2WMzkLxYeQC4omFUu2UhHw+5lcHPqQdk3VPJs01pLtc2S8uW5gNE0mwb4G4w4q3emWRTCxEstkWNQ/5jJHXRuq1L6RmEaucZOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756148308; c=relaxed/simple;
	bh=ozy420gduHI9/9y7xEFSelMyJU1dQXXR5ybH8KsKi+I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M8VDtCqCPXvXBIrI2dgJCQRbupXbs3WdUgDQ8CnaBcNbXtDQdBkHYm5MzKB69orHJkY6DOYyFS/uEojEBfJLi6BPpR+mDBZoeTdH5sDDabtGG1qEK3325XnzXhBZWBXvnH5RFUbyGm/k+Mwpki0FSrwoecYCY+PSFLBr8Aw/uls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8Hl2h6M; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77057c4d88bso1293511b3a.2;
        Mon, 25 Aug 2025 11:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756148306; x=1756753106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d4tvCEF/nhnjeqhg4jbzMCRXi5ArKtqgGLinWKOCj9M=;
        b=Q8Hl2h6MkerymErxC2IUhcKx59fSto8qyOormHtAI/VNrZ8VvlDd2TqFhrD7UmodJO
         QsB7amJ7E1SrYFjPr7Zz5d6ITO9EQ12lN9dan7xFkADFM8dGWgth3/TW8J20XT2bSv8p
         lZOgYlrTz4bPRHb0r8pzobkaRYnNCrl0Fnt6+bRdFC16cDl1kEtgBX6htfmD/kgVSONX
         mf9+mYTbT1g51WG2Ex5hM5cnX7LcxGvC2VeudBZT6Mtth5y0TRWxYK8Bu8bKDpu2oPaJ
         PTHvBhm5mJkIGqqOZjbew2qmWstDGceuwQ/yFeSDSqBctlERyUr+TAqHGbDejaIzRL1M
         5i2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756148306; x=1756753106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d4tvCEF/nhnjeqhg4jbzMCRXi5ArKtqgGLinWKOCj9M=;
        b=OOCa/SG1HJWbaSaqAnjTJGMRWW34Okf34SYZhyRq4+t4D1H6RUXusj0QbN7wp2sNR9
         u85/bnAHmk6qaOWnC/aA/tT1awOETSsshLX+UR9KMPnQe9tHGesoU2ZUZudL1PyyVk/D
         JldFfZA5J5AGNtED/ewbcK5vJBwVGl1QSEni9eA4njQhpOCYVb6XJhzGfbyfGSES/HMh
         jt/iwdxBdqxkw+YoJ7NCCfhmdgiMMFBcT8yGIIRWyL4yhYPUfgybBauvpEZkdFztpjQ5
         V6brMbHcqP0tZ0sfueqNYfeEVzpgrXFCg5LFezo/WR26It9Kj9YVcCwyLLedFRLdiNP6
         GjpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMTiFkN+bQ9XN8v1J0YdB/O/jeEfalkfvMWxt+vsqFf2ZoN90qrpm4Pll9EfARvlsgfvKEenlc7g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzoDBdgBymtglQtLDTWpgaKuQarFhbsiN8wziONOIzkhwJZjV83
	oVWYHsGM8Anp2AGZsMka/gXdNC9SuRLEGnFSHA2U57wJE5ba+z1hVSHD
X-Gm-Gg: ASbGnctLQqhpuJV8tF0rZ2vL4yqk29VPuJiTiuGfFWoAIWHOEJm3/Erw0sonhvl4GRj
	FRKnWBHHkclHORdxyOgwCdWqmSJpFinJ+QH8jCT9BIRqakxvJmXI+1yJvIb22Po2eXeR8Zx2K5D
	v9yVBYmBSQBgAYbVjc6K+eRjeeO743VvTkoZWdRtp1VpFUbnSq1KM3GeoZ+KfNLH9fUNaOcbc58
	+U6pNaE8jdapsB3XYnIjcRKAyZ8dboGk/LFFs92qjD30/R5jNjBGBzhXvANsRjGco6pJoE0h1jC
	cGsJqmx/rxFCG4sYYARFKbAEZgo+xMo8Buit/FQDC2aWcFZIaTtc7RTd11Ns90ykipzRBpUHuAV
	w11PWIZXFA+/5kqb65ervW/lAfjuFgVH+UEhnEBLfiuWPebrQFTG8H2c+7VXWX3k=
X-Google-Smtp-Source: AGHT+IGcmyZUYYYp4LEC5D/JRj59FsoMb91DsbIKKq50MJiUoKfM9zSFwtazLR80XxF1QRa+x2rO/Q==
X-Received: by 2002:a05:6a00:14d4:b0:769:1f94:85bd with SMTP id d2e1a72fcca58-7702fc4681emr13528084b3a.23.1756148306208;
        Mon, 25 Aug 2025 11:58:26 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:d003:7033:5094:89bb:b3a7:264a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-771e159b157sm3605019b3a.25.2025.08.25.11.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:58:25 -0700 (PDT)
From: vivekyadav1207731111@gmail.com
To: daniel.lezcano@linaro.org,
	rafael@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	joe@perches.com,
	Vivek Yadav <vivekyadav1207731111@gmail.com>
Subject: [PATCH] cpuidle: sysfs: Use sysfs_emit/sysfs_emit_at instead of sprintf/scnprintf
Date: Mon, 25 Aug 2025 11:58:07 -0700
Message-Id: <20250825185807.57668-1-vivekyadav1207731111@gmail.com>
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
Signed-off-by: Vivek Yadav <vivekyadav1207731111@gmail.com>
---
 drivers/cpuidle/sysfs.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
index d6f5da61cb7d..c7af09460b74 100644
--- a/drivers/cpuidle/sysfs.c
+++ b/drivers/cpuidle/sysfs.c
@@ -22,21 +22,21 @@ static ssize_t show_available_governors(struct device *dev,
 					struct device_attribute *attr,
 					char *buf)
 {
-	ssize_t i = 0;
+	ssize_t len = 0;
 	struct cpuidle_governor *tmp;
 
 	mutex_lock(&cpuidle_lock);
 	list_for_each_entry(tmp, &cpuidle_governors, governor_list) {
-		if (i >= (ssize_t) (PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
+		if (len >= (ssize_t)(PAGE_SIZE - (CPUIDLE_NAME_LEN + 2)))
 			goto out;
 
-		i += scnprintf(&buf[i], CPUIDLE_NAME_LEN + 1, "%s ", tmp->name);
+		len += sysfs_emit_at(buf, len, "%.*s ", CPUIDLE_NAME_LEN, tmp->name);
 	}
 
 out:
-	i+= sprintf(&buf[i], "\n");
+	len += sysfs_emit_at(buf, len, "\n");
 	mutex_unlock(&cpuidle_lock);
-	return i;
+	return len;
 }
 
 static ssize_t show_current_driver(struct device *dev,
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


