Return-Path: <linux-pm+bounces-11911-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4E194781A
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 11:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA19B25369
	for <lists+linux-pm@lfdr.de>; Mon,  5 Aug 2024 09:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1CE314B972;
	Mon,  5 Aug 2024 09:16:02 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815D43BB48
	for <linux-pm@vger.kernel.org>; Mon,  5 Aug 2024 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722849362; cv=none; b=EO6j1kuZ6k047MwBTAfxQ2AXcm4ClHLNcwvLGhPsvkBGwwmnJ8IbLxFooUB/8ERUwzr3KnwY2u2RXsm9E1odn9izgExxshOOFNe6cWzlv/p5MDM07YKHVeseKBfoVikv37XBOJkvSVDDDH66As8IpSKyCiGszAbNFYytbjxkELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722849362; c=relaxed/simple;
	bh=1RrGRw139Gb4AjHveO04DLfETtoQYOl3hn/kqUfux7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jNpdHd0B9FkIzlfkxHvucAR65D2/XIsZ7Kd1HDAsgF1I2D5jkhdOOiGQqxX0kh/whdw/tLANFPfhuSpOsOQtuA1vyzDasznTiY8QTiaPF2kCLr3nYyFJm9lp+n0z+TrYSGT7yT7l/Z1YKtOhRgg5bxqGNTw9Rzn2pfEmxqxEU/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70d22b6dab0so995589b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Aug 2024 02:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722849355; x=1723454155;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fn9K64LvYSiWuQaBAiJzeJjOU9ED8f/OvLxSlb/SvFs=;
        b=sr5Dbjrpa3GmRJyGWJREt+QFlUDT36R9TyQKSb5GAHgcZ8dSJNw6UMx07JYVa2CeB9
         6BTG++6bSUxUymdXWWCLuCCksU7B0zZGycAGKV5wuDeInt/Ty6LPkCgRswA9lMPMNZ/w
         2bu+zMHoM1igG7thLfh8hh9gnLuU4jHOKvmc0sq/5BZJqClMpgqlPRYpMBcxZk5bfg40
         uHpiin4dXZMgeXP09k21tCO1NdScRYF4jK1XXvibdBg8ejTX8w5ngiQsYy5VTBiFZ3iF
         ndLM+aKrc5NOO5IhEdIAUjwkaUOJLX0kHz6VTg9zNkPEd8RrdS+K1JiIYY4xckfzWfyI
         lang==
X-Gm-Message-State: AOJu0Yw4HBuBK5XpsCbUK88ZFhtX+M280N6vymD22lVaiRtXl0CpfdPC
	fkNZ80hVexERxIsq0YsjGR2VveWS5GREgr1VUS+v/gbuHplEQbPp
X-Google-Smtp-Source: AGHT+IF34Blo9h001igUUItt5XlIhMcRODRwKxUusLjOLKGLIX/IAZ1nNovEo14hX0FGjgLA6Ruxgw==
X-Received: by 2002:a05:6a21:6d86:b0:1c4:9321:defe with SMTP id adf61e73a8af0-1c69966a5femr9960470637.8.1722849354715;
        Mon, 05 Aug 2024 02:15:54 -0700 (PDT)
Received: from tgsp-ThinkPad-X280.. ([111.48.69.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecdfe2dsm5031633b3a.114.2024.08.05.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 02:15:54 -0700 (PDT)
From: Xiong Xin <xiongxin@kylinos.cn>
To: rafael@kernel.org,
	len.brown@intel.com,
	pavel@ucw.cz,
	mario.limonciello@amd.com
Cc: linux-pm@vger.kernel.org,
	Xiong Xin <xiongxin@kylinos.cn>
Subject: [PATCH v1] PM: sleep: Optimize the pm_debug_messages_should_print() condition
Date: Mon,  5 Aug 2024 17:15:09 +0800
Message-Id: <20240805091509.91362-1-xiongxin@kylinos.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_pr_dbg() is useful when debugging suspend and hibernate. commit
cdb8c100d8a4 ("include/linux/suspend.h: Only show pm_pr_dbg messages at
suspend/resume") using pm_suspend_target_state to limits the output
range of pm_pr_dbg(), causes the original pm_pr_dbg() output range to
change.

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
Signed-off-by: Xiong Xin <xiongxin@kylinos.cn>
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
2.34.1


