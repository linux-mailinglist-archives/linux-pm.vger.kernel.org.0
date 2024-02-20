Return-Path: <linux-pm+bounces-4163-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1239E85C35A
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 19:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34BE51C214D9
	for <lists+linux-pm@lfdr.de>; Tue, 20 Feb 2024 18:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1FD77F33;
	Tue, 20 Feb 2024 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="uzZeHjVd"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56806D1A8
	for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708452510; cv=none; b=FNAkKp4iF9vWU9aydx7AUJqy6dZCWmpH9c3UAmBQ96t6ZK+gaCY+G6aY78Oj1f1aF6o38EfjGQXE16SJ9ky4H2/LPTSm69PcnpbX+5ECASRKHNvXyLnqH4P9QkwYP2YLRqtSaAWMWni7O6+kTd11XDToBE/kWxv4oan2nbg567Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708452510; c=relaxed/simple;
	bh=Ii6ohLTbl9rTv5KRVUQJpae0ArE5eca5skPA3gXkdno=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kkvAZNz61TGwMha6me/Ko2bg29WN0HCPB/RJTgjzIYJ6q2CA/UoMZ6/YZ/yUde1ri00h0ODnsZ9aPeYlmehDXuUq+TOG7lBkOKvG4yQp1iqEdNU1xbGewPX12q+kiEPos10EZdXbjOk9PqIgsoPlOiVDLDrL1KR/RoOSe5SqiKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=uzZeHjVd; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3f1bf03722so63006366b.1
        for <linux-pm@vger.kernel.org>; Tue, 20 Feb 2024 10:08:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1708452506; x=1709057306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQYn2Qo6PtaFVnQpAuclGekLK37G8lvuP7kYmeLo6SY=;
        b=uzZeHjVdmMe1YIss9g0Yjc07lTxdjRcGX1pwQqjCII5EbmdNiNB9D3aMId4ztpa3mE
         fth4CPcf0MWY8UIx30dkpOVNY8Je1u8AMS4I54+Imbzvs9gTkultFUqQYmvdrz3UJBQM
         79wT9PBmFw4ZBRT81s94yV3W2h4sHnynH0orIdd91lDckDYQqMebGE9qxmfvPWTMAb34
         GrJwlmLU93lxydWrc64QAGnrUnNuyDor3KrJo7HIYSxVQ8Rc/P21Yi9n06dISKTemLA2
         Z4Mza+3ACIt3IfRwHle/FtzWsNf6oK2TOAyNWRzB6a7d0JW4L0dI6XRTUK/Oeu8OE+5m
         a3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708452506; x=1709057306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQYn2Qo6PtaFVnQpAuclGekLK37G8lvuP7kYmeLo6SY=;
        b=JczMxwNatXyi9+Bs0RvRsW+szEUEkSLEsti6wYwzt+zRLycZJdOn7XjzBUHBrTDMYJ
         bVSV6pnR2A5rvXHfLJ6Uu7nR9+rqhy/nMLrnrlMvmTN/rn31qPiwuekMoW434KheWFsA
         Sr2MCSYLi2pAmiceyxw06v5kgV7M4oT0OEz27S89SrrNuNCuKiMdllfZb/LTrJXL4MSp
         MA8r7KgMZ140NbOaiEO0Bl3mY9Or9rNBTj1S8WuzAXE/3jDuoXvppHPyZuN72upVTorg
         wYAo/0N3khAkoPPe2JXo5ZI/lbtlpBD1MRuO1H34qjh/uqeBZuC9PogZ+bDmJ4c/yGri
         yHpg==
X-Forwarded-Encrypted: i=1; AJvYcCXED/1ZJ1FYAk/E8UQg1eh05uIhBCHk7ZYYktc0lQeg4Ch6jR3l3j7EH2iiZd37cQWGpkEOljYuCxMICULXYR4GgvywhYs3Nc8=
X-Gm-Message-State: AOJu0YxeQSFDsloSS1uniQ3h61ahiWu2opGXLu3k4vg9DCuz1pJtgeq9
	btL7B6MXvxXZ4aRin3oM0TXtZ/uBoJbdzWKwxf30EwLGDIriNJKCsyO9jYwj4wc=
X-Google-Smtp-Source: AGHT+IEEGYlDJUbgD5RmdTOL2p1zojXRXui9l0d9+6OqRLvHJ8tVrPR0lV+boQkXNXpSuTksDNuT1Q==
X-Received: by 2002:a17:906:d7b7:b0:a3f:2167:63d9 with SMTP id pk23-20020a170906d7b700b00a3f216763d9mr589037ejb.16.1708452505998;
        Tue, 20 Feb 2024 10:08:25 -0800 (PST)
Received: from airbuntu.. (host109-154-46-208.range109-154.btcentralplus.com. [109.154.46.208])
        by smtp.gmail.com with ESMTPSA id g14-20020a170906594e00b00a3edde33e7esm1274501ejr.99.2024.02.20.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:08:25 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2] sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
Date: Tue, 20 Feb 2024 18:08:20 +0000
Message-Id: <20240220180820.2597581-1-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We are providing headroom for the utilization to grow until the next
decision point to pick the next frequency. Give the function a better
name and give it some documentation. It is not really mapping anything.

Also move it to cpufreq_schedutil.c. This function relies on updating
util signal appropriately to give a headroom to grow. This is tied to
schedutil and scheduler and not something that can be shared with other
governors.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

Changes in v2:

	1. Add Acked-by from Viresh and Raphael (Thanks!)
	2. Move the function to cpufreq_schedutil.c instead of sched.h
	3. Name space the function with sugov_ to indicate it is special to
	   this governor only and not generic.

 include/linux/sched/cpufreq.h    |  5 -----
 kernel/sched/cpufreq_schedutil.c | 20 +++++++++++++++++++-
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched/cpufreq.h b/include/linux/sched/cpufreq.h
index bdd31ab93bc5..d01755d3142f 100644
--- a/include/linux/sched/cpufreq.h
+++ b/include/linux/sched/cpufreq.h
@@ -28,11 +28,6 @@ static inline unsigned long map_util_freq(unsigned long util,
 {
 	return freq * util / cap;
 }
-
-static inline unsigned long map_util_perf(unsigned long util)
-{
-	return util + (util >> 2);
-}
 #endif /* CONFIG_CPU_FREQ */
 
 #endif /* _LINUX_SCHED_CPUFREQ_H */
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index eece6244f9d2..575df3599813 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -178,12 +178,30 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
 	return cpufreq_driver_resolve_freq(policy, freq);
 }
 
+/*
+ * DVFS decision are made at discrete points. If CPU stays busy, the util will
+ * continue to grow, which means it could need to run at a higher frequency
+ * before the next decision point was reached. IOW, we can't follow the util as
+ * it grows immediately, but there's a delay before we issue a request to go to
+ * higher frequency. The headroom caters for this delay so the system continues
+ * to run at adequate performance point.
+ *
+ * This function provides enough headroom to provide adequate performance
+ * assuming the CPU continues to be busy.
+ *
+ * At the moment it is a constant multiplication with 1.25.
+ */
+static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util)
+{
+	return util + (util >> 2);
+}
+
 unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
+	actual = sugov_apply_dvfs_headroom(actual);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
-- 
2.34.1


