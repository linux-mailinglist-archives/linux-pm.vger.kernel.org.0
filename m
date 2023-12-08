Return-Path: <linux-pm+bounces-813-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B507B80971B
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 01:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41F6B1F212C1
	for <lists+linux-pm@lfdr.de>; Fri,  8 Dec 2023 00:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A86B627;
	Fri,  8 Dec 2023 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="kEcXB5ug"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0FB1716
	for <linux-pm@vger.kernel.org>; Thu,  7 Dec 2023 16:24:07 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40c1e3ea2f2so15518635e9.2
        for <linux-pm@vger.kernel.org>; Thu, 07 Dec 2023 16:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1701995045; x=1702599845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1MICklUThOT75YrGOtGs5vvoxKkTP4eSHGLbFICqC1g=;
        b=kEcXB5ugh4fioltkFcR/kJAvKoJMyioY+Nr+Uga78TYQg9k6s7JKXZZt8wjGA+2l/o
         2SRx2xqrFr+dSRxVTqKSFgYVLH9wnwNezmBXLp41Qtqym7A7Ik7OuVAq4zoPpQv/s3me
         e87F/mbpldoEhv/kqCeb3mPbgqT+Mlzj+5/kL3Qw6TQ6gxLD4vgpqehYHda9fvukve+d
         E2O0X6GDWYPfQi++hNwXb/LfiFsICSyKSTpu0yqBSeS8h0zefRTOOGmUeBe8lEMz8nPB
         thWMWg03F5sRlO6h4SVWzYA3502otvgIeMchZiTjNHDEfeVL3fpKnqjZEqMWuKj1XBAn
         wZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701995045; x=1702599845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1MICklUThOT75YrGOtGs5vvoxKkTP4eSHGLbFICqC1g=;
        b=bkHNSPZfQawKgR+P3jM1j+Fi81EyzohFx3oK7uUCl1YuC1X/au0XHxP5doyTf8gacA
         IevAMcK4FEDCinhQZcnJtUR2TWDQdAuiX9hcnhY6aTuTFf4L8+KOftwv+Rf/Jv/ETuOW
         qVmcgtd45uW5LwywWAEbl5ekuQFnlFNIboYvAcke3LAZVzaZIUoN7S/PN6xdqTa7/5Ac
         WIQZ2+ECcWEZWa0nczNdWCNSuBE2D8xDDGlb8ZvPiV1scy5rH+MpLf4nSf4eVc8vv0pI
         DiW8P0vUrnuhy2UMkxu0Sc6PZsxBJr3MVTh0C35BkVJPvL4I4RjStfOgUjOWHT5YQoXm
         EyNA==
X-Gm-Message-State: AOJu0YwTXfHaVQY/D7HyMY5sz/hw4M5RPfwLLV48/H88c4WPPM4WkF4F
	etkwRu8Ygqi+ehqjIT2xGn4x6g==
X-Google-Smtp-Source: AGHT+IF6n9vGF+wKVNWmclAiRMBztZoqnbj8D/4FxMtbCN6r+z66nQHUenjbCO2tFAE1xQOoGOdHMA==
X-Received: by 2002:a05:600c:3d0b:b0:40c:314c:803e with SMTP id bh11-20020a05600c3d0b00b0040c314c803emr435922wmb.106.1701995045591;
        Thu, 07 Dec 2023 16:24:05 -0800 (PST)
Received: from airbuntu.. (host109-153-232-45.range109-153.btcentralplus.com. [109.153.232.45])
        by smtp.gmail.com with ESMTPSA id u17-20020a05600c19d100b0040c1c269264sm3339653wmq.40.2023.12.07.16.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 16:24:05 -0800 (PST)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Lukasz Luba <lukasz.luba@arm.com>,
	Wei Wang <wvw@google.com>,
	Rick Yiu <rickyiu@google.com>,
	Chung-Kai Mei <chungkai@google.com>,
	Qais Yousef <qyousef@layalina.io>
Subject: [PATCH v2 2/8] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
Date: Fri,  8 Dec 2023 00:23:36 +0000
Message-Id: <20231208002342.367117-3-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231208002342.367117-1-qyousef@layalina.io>
References: <20231208002342.367117-1-qyousef@layalina.io>
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

Also move it to sched.h. This function relies on updating util signal
appropriately to give a headroom to grow. This is more of a scheduler
functionality than cpufreq. Move it to sched.h where all the other util
handling code belongs.

Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
---
 include/linux/sched/cpufreq.h    |  5 -----
 kernel/sched/cpufreq_schedutil.c |  2 +-
 kernel/sched/sched.h             | 17 +++++++++++++++++
 3 files changed, 18 insertions(+), 6 deletions(-)

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
index 4ee8ad70be99..79c3b96dc02c 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -157,7 +157,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max)
 {
 	/* Add dvfs headroom to actual utilization */
-	actual = map_util_perf(actual);
+	actual = apply_dvfs_headroom(actual);
 	/* Actually we don't need to target the max performance */
 	if (actual < max)
 		max = actual;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e58a54bda77d..0da3425200b1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3002,6 +3002,23 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long min,
 				 unsigned long max);
 
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
+static inline unsigned long apply_dvfs_headroom(unsigned long util)
+{
+	return util + (util >> 2);
+}
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1


