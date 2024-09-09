Return-Path: <linux-pm+bounces-13877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6892971143
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 10:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A9B1F25C6E
	for <lists+linux-pm@lfdr.de>; Mon,  9 Sep 2024 08:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01011B0110;
	Mon,  9 Sep 2024 08:07:38 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158E1B1432
	for <linux-pm@vger.kernel.org>; Mon,  9 Sep 2024 08:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725869258; cv=none; b=O9i+xKeLuATOk68/qhlRN3Uhmetr4jHv+lzUzt5telf08PpsNhkjWRe7YvFjhOWCkxXeWzx/xYoRkXLRvLd7ntXnk2peSo6qq55SFSxSlT9RUQd670OFN6pw0yj+xz0BUSQ7VWoakZUxGfXWGedOY5cBp2Bs/3Ewxq/irRyZF7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725869258; c=relaxed/simple;
	bh=Vfl1ocurgCSFI1KNt1GwhqKcatav9LjQQckrGTh2TyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rq/e/5zUsTmfqIkvOwBhYyN3iKxBQ3vT3zOi+F0mAl6K7qru2DplE1YAA0JulLixQ44m1IKLPfk+DYghfQlX5zO9/jZnT2IYGnfDMEskyNbF10q4XL/MAYNo8N+O/lvD+A9z3/Fiib5FVjqc2VqONSzGZiEttpau4+FdEVcwqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2d892997913so2637468a91.3
        for <linux-pm@vger.kernel.org>; Mon, 09 Sep 2024 01:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725869255; x=1726474055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5HO8MI3NCN1WcuYQ6ANpTcpLsOAP4oXeZ/Q97FimnzE=;
        b=NNgfvlmoVmbBpjZtKlCiTcGGpBPfRRnXHoaS5IZHRf0fitCrQ8E1AOhbNw+Yti1d43
         SeMb4v0sNEuECZkKjVhWKK2y7soSXjEI8N8RPXPCyPGH8hOVafH3eVp7XZ28uwqWww97
         eG2cVqyuO/5jqKwJ3QSwoK/42cvfOfKBJi2JLOnu48G5MWA3OAVj+76KvtCpxGgNJDEx
         YLHE8Y3VGxytc6svh3X0MyS+JV/XlZw2MRxOH159NJPSrbqcDueeG2T8PGaGPMttUwmF
         S0RI6ILYmpqjpO92eNDb8Z4jdFW2LvP9OJ8eaBWV9QHLbmQKyXvphBplTKzCtysoKqFx
         guJA==
X-Gm-Message-State: AOJu0YzKdZBcUUwQvOA8bQCSik7XvTvIpdnHoueop60HKM1KXc5TNfTA
	RGe6tuKkg+L6yEug7WhkuriwC1p5uGX29gbikCIiDj+OF6vtYtfT
X-Google-Smtp-Source: AGHT+IGM9Bg69N+5waEL36awnDI9RwLKSOGScrp1SbhHypvHBUGhy3T/bgoGWqqWcr3sg+Mw0j7Ytw==
X-Received: by 2002:a17:90a:c90c:b0:2d3:d728:6ebb with SMTP id 98e67ed59e1d1-2dad4de1412mr12622802a91.5.1725869254744;
        Mon, 09 Sep 2024 01:07:34 -0700 (PDT)
Received: from localhost.localdomain ([111.48.69.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadc0317c0sm6023886a91.19.2024.09.09.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 01:07:34 -0700 (PDT)
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	mario.limonciello@amd.com,
	len.brown@intel.com,
	pavel@ucw.cz
Cc: linux-pm@vger.kernel.org,
	xiongxin <xiongxin@kylinos.cn>
Subject: [PATCH v2] PM: sleep: Optimize the pm_debug_messages_should_print() condition
Date: Mon,  9 Sep 2024 16:07:26 +0800
Message-Id: <20240909080726.16811-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: xiongxin <xiongxin@kylinos.cn>

pm_pr_dbg() is useful when debugging suspend and hibernate processes. In
commit cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg
messages at suspend/resume") using pm_suspend_target_state to limits the
output range of pm_pr_dbg(), causes the original pm_pr_dbg() output
range to change.

In the suspend process, pm_pr_dbg() is called before setting
pm_suspend_target_state. As a result, this part of the log cannot be
output.

pm_pr_dbg() also outputs debug logs for hibernate, but
pm_suspend_target_state is not set, resulting in hibernate debug logs
can only be output through dynamic debug, which is very inconvenient.

Expand the scope of the state variable in state_store() and add judgment
on it in pm_debug_messages_should_print() to extend the debugging output
of pm_pr_dbg() to suspend and hibernate processes.

Fixes: cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at suspend/resume").
Signed-off-by: xiongxin <xiongxin@kylinos.cn>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
---
 kernel/power/main.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index a9e0693aaf69..a376107efbb4 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -559,6 +559,8 @@ late_initcall(pm_debugfs_init);
 
 #endif /* CONFIG_PM_SLEEP */
 
+static suspend_state_t pm_state = PM_SUSPEND_ON;
+
 #ifdef CONFIG_PM_SLEEP_DEBUG
 /*
  * pm_print_times: print time taken by devices to suspend and resume.
@@ -613,7 +615,9 @@ bool pm_debug_messages_on __read_mostly;
 
 bool pm_debug_messages_should_print(void)
 {
-	return pm_debug_messages_on && pm_suspend_target_state != PM_SUSPEND_ON;
+	return pm_debug_messages_on &&
+	       (pm_suspend_target_state != PM_SUSPEND_ON ||
+		pm_state != PM_SUSPEND_ON);
 }
 EXPORT_SYMBOL_GPL(pm_debug_messages_should_print);
 
@@ -715,7 +719,6 @@ static suspend_state_t decode_state(const char *buf, size_t n)
 static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 			   const char *buf, size_t n)
 {
-	suspend_state_t state;
 	int error;
 
 	error = pm_autosleep_lock();
@@ -727,18 +730,20 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 		goto out;
 	}
 
-	state = decode_state(buf, n);
-	if (state < PM_SUSPEND_MAX) {
-		if (state == PM_SUSPEND_MEM)
-			state = mem_sleep_current;
+	pm_state = decode_state(buf, n);
+	if (pm_state < PM_SUSPEND_MAX) {
+		if (pm_state == PM_SUSPEND_MEM)
+			pm_state = mem_sleep_current;
 
-		error = pm_suspend(state);
-	} else if (state == PM_SUSPEND_MAX) {
+		error = pm_suspend(pm_state);
+	} else if (pm_state == PM_SUSPEND_MAX) {
 		error = hibernate();
 	} else {
 		error = -EINVAL;
 	}
 
+	pm_state = PM_SUSPEND_ON;
+
  out:
 	pm_autosleep_unlock();
 	return error ? error : n;
-- 
2.43.0


