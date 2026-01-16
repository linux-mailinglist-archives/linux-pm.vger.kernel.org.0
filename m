Return-Path: <linux-pm+bounces-40963-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A555D2A1CE
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 03:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8956E300EE41
	for <lists+linux-pm@lfdr.de>; Fri, 16 Jan 2026 02:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7C8311C21;
	Fri, 16 Jan 2026 02:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="COvtd5de"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4847FBAC;
	Fri, 16 Jan 2026 02:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768530431; cv=none; b=qavu3f7gq1P4LBkyN3sMsbVEyPT02xgNmv5QdSYnIBQv05VKI69ujQvMGEJ6ovvhnloniHkZ0LLQx7ZS2VRV2OX18JxNvptBavmZSfKRHPu8djEcjqRDTa9pgO/iYfjOZt2vQO/R+IQO6hpb7tKnvE9joq9EYqNoTqzF7TDV+S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768530431; c=relaxed/simple;
	bh=HL1JYR8iT4KToi9Zi3fQzp19+KeMBlC8f7H/IJPGCEU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DNlX+xDbQxpvmPkarXgpO086U8d4cF7KS0Vp8kJOmFW+xV2gBHm3GyBfHVxTtsxGx9vLl0LMrglCBY0go+M7+k4SzMytdEQ8QFETouYcvtFHXAwXy2jKRT5Rcdfs2gacQhNsrvWkl4QXGv90Xr+UhKf54iJcuxnrRJcklLTzaFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=COvtd5de; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1768530409;
	bh=Adf1krTepVahhYXg6eWv32QiCOCC5DCd/xA8Df44gAg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=COvtd5devnvzlWB72+rQpMd3U6mO4RBQhMcHMSPaGoHUqcBLhXluzpzPlmkbZhEz0
	 87RR3wNS7pD0nWKmA9huAimPBIunekrvchmQC74waxtjQaUmSMSfu9IpxZo6Q2Fjhm
	 cBGvKFjCxlsXM0f8VRFF6doaPnTZNz41A6uEXm44=
X-QQ-mid: zesmtpip3t1768530404ta2ef6898
X-QQ-Originating-IP: gPb3OSHiwBf+v89M3yP7ae8slwOm8n4qbxXksca7fEI=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 16 Jan 2026 10:26:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15760255121268463657
EX-QQ-RecipientCnt: 6
From: tuhaowen <tuhaowen@uniontech.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tuhaowen@uniontech.com
Subject: [PATCH] PM: sleep: Fix race condition in suspend statistics updates
Date: Fri, 16 Jan 2026 10:26:38 +0800
Message-Id: <20260116022638.994778-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mo1nXFSF9E7vKRoQaPYc185GU2g1gOREjqovzYlBybSOZJU/4lmkqTcy
	cCthgybqS7o6GerGMk2dk3FOPxZrfha+9flAQjARrEzZ1wWD7jje3DiH1ApOsWiNzGq9Ub9
	J6vpVEemvbGD9AprH2PDmfqpZJYMOTShFfo0L0INlZaORWOkvLJG+4qZqKQPYSGO08ilgFm
	r6EP7VUwqJ35VCPzgyFO9uOIE9IORNAo4g4LQtq/pJsodg4VImuJsKKHPTcnQcrPS1mB9OC
	NrSF7X4DtpvFINkDekDRAu7taYNVNulkaUsJzt/VudgUuULQW0d6aAzu/km6kxUp+nwId/S
	aI9xDMapmB8OfzPzn1khK6T7Jsi9J4IFy+Gilm69LPXyj/g1TEeTjbuVsXY5pM3K/06BBJb
	ZvUIs5rI6qAvMJhiVfHwILoCgKDGrn2Ly4hwYcoA139dbzt0Yu0uvvAdy+FSTGlXsQN+/Cq
	gfWSrMXKqxaNjFx4uPMeD48SeAfu/pBWZJF66FwKZ75qA5U5OJipiYUA61yvBpH6vj9/3LX
	MHg1k4KCg2QVChCdKz73Y8pKh50qaBtHAJp8YxnFMb7Nd5MO/u3tFRS3ijaYV6kd5Z0L0vi
	hLNeoXBZE1KT7VqUDeEax6yXgnYc32JmGIneV4Dz6M/+cD4FQKnOSD4JmQvtNgKA+CLdVtA
	ZGcUdsz+bX4vW2Y43WYUyfeXIrc/0lp8UeDG61owiFSZyZi5JxroZvm3cZxjJbQe3c7SYgv
	mQR2Uvxj0q+rvUAOSYjUSli9BwgtbIpxXhIhKl1q9u0KUK/tqnZw3oL8rS2Ycnh+/HkN5nF
	a4dw6TTQSsHZfQbVF3gp2nbmKn5ibzeodcC0fqrPgX8QJSsrAiMkgUXXBg5K6NovkYjbKs5
	iNY6/OGVtzJMRcCUl4PsBOVcMbL+AAPNspbh9thF+TIIOvLOpu7HvusViIQqINQXCNsVoOk
	DwOOTm/D4Kejfuc38MNJCxViiIXUntDBy8WfJmetDKZrEgKkVI9gKNzkfIzsSbCjGzXcfik
	9SBznLHHFPOS5rNXNtDrHqHaPAsfBGgDe73lHbtA==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

The suspend_stats structure tracks suspend/resume failure information
and is protected by suspend_stats_lock. However, while
dpm_save_failed_dev() correctly uses this lock, dpm_save_failed_step()
and dpm_save_errno() modify the same structure without any locking
protection.

This can cause races between writers (suspend/resume code updating
stats) and readers (userspace reading from /sys/power/suspend_stats/
or debugfs), leading to:

- Lost updates to counters (success, fail, step_failures)
- Corrupted circular buffer indices (last_failed_step,
  last_failed_errno)
- Inconsistent data when reading statistics from sysfs/debugfs

Fix this by adding mutex_lock/unlock protection to both
dpm_save_failed_step() and dpm_save_errno(). These functions are
always called in process context, so mutex can be used safely.

Signed-off-by: tuhaowen <tuhaowen@uniontech.com>
---
 kernel/power/main.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index bb7dd73e18fc..d8b053d85dc0 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -503,16 +503,23 @@ void dpm_save_failed_dev(const char *name)
 
 void dpm_save_failed_step(enum suspend_stat_step step)
 {
+	mutex_lock(&suspend_stats_lock);
+
 	suspend_stats.step_failures[step-1]++;
 	suspend_stats.failed_steps[suspend_stats.last_failed_step] = step;
 	suspend_stats.last_failed_step++;
 	suspend_stats.last_failed_step %= REC_FAILED_NUM;
+
+	mutex_unlock(&suspend_stats_lock);
 }
 
 void dpm_save_errno(int err)
 {
+	mutex_lock(&suspend_stats_lock);
+
 	if (!err) {
 		suspend_stats.success++;
+		mutex_unlock(&suspend_stats_lock);
 		return;
 	}
 
@@ -521,6 +528,8 @@ void dpm_save_errno(int err)
 	suspend_stats.errno[suspend_stats.last_failed_errno] = err;
 	suspend_stats.last_failed_errno++;
 	suspend_stats.last_failed_errno %= REC_FAILED_NUM;
+
+	mutex_unlock(&suspend_stats_lock);
 }
 
 void pm_report_hw_sleep_time(u64 t)
-- 
2.20.1


