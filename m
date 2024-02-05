Return-Path: <linux-pm+bounces-3359-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC621849256
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 03:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0C101C2161D
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 02:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A032917E9;
	Mon,  5 Feb 2024 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="0ljlF0hX"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2352C945A
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707099617; cv=none; b=jCFn3aMDFs++DkEr7V0FRhDApGK+F2o1fyxqoachdoJsOaiL6rLTwuNB8prI9BEd0y66Ha2bqyC86PLmsuz2R991LdEFSHwd1rSIANMpFClTV7eK43rL7ishISZSfpR0zyLaRZ3IGkmpoywnQU+Ee+aAQSbqbgZStnBMBGJme4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707099617; c=relaxed/simple;
	bh=+Gm5/FRVNIqSgfwLG6CPyYSiHApJbtMFJNODMFhgmEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dcb0YVzDlyHWgPdqpo3GI4RvAW6QbM8+Hzx3ungG/ux1eTFTb0KDDaWFxWKdwkNU9RBZ04LdfU9cZurylumvUmiHUaGbns0ZDacK8cWcKMIYRfHRtykCH7HrUEmv4Ny9xJvlpYPWSKQVTldobMTeI4NjE60HucadJniWRhkXyjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=0ljlF0hX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40fdc63f4feso1870825e9.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Feb 2024 18:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1707099613; x=1707704413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vI17x8NVIjMeQipAli/VEaOzE57qtHLbYyH8WdOAchg=;
        b=0ljlF0hXt6pnnUB8M/zichPZTgjgVjKobFLF7cxY1kcpxLKsec+XObdZeur07jlGQw
         Ml0nNJcS3yIHRLmhvgWLJ7/0jPOIyikvcFoM4a6YxuhfzA4yKnaX9t/5PKs5CInMY+20
         /sH9MsvbogBhqyCOs/dUvNFOKOt2jaMxVcUA8z3ggWCQ6h4UNCjdodaT9SqY+mQZpf7n
         8c58LguB+57grXaSZCR00WV7KUs8g6UeRbZyCOQwTRSz/vTrcSK317OY1ee/QYJ8vfs5
         h+9mN1BBndY7H+nDpeG/mcTaHIKOJQbXrZr0lgnSfalJZyHZYshXv9Vb4sxpmbJ+3WiM
         edcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707099613; x=1707704413;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI17x8NVIjMeQipAli/VEaOzE57qtHLbYyH8WdOAchg=;
        b=TWd69VxVztY7BadDumTe15HiZ8IXcunBrTlsGAE2cKRGIra8ZPU4OFX/TLRMpuBq3U
         PHUXULxtll6kVYBdGMYKBEa3qmiJXPbpbqxDuOABm7JnsVzM76Zd+/ztkbgzxkib8VNf
         pTEdL0SsiLU9nEFHXWk5mi1O/YN+TaoVh8LqMXI7F7gpw7nsOA9/RuoNUHOV7uURUFC4
         uW2xjQcvsjX3H41lxLkLKL/tqw6CjPljpg7PMAbZpnq8qSWifQYxof6wlsB9jfmR+LjT
         blSZC0hJTVg3rLIYmEIa3ReySZp5RsRgGcaD/VNPMLyBhqO813HF7TKqwd/N56WRoSSq
         3ogg==
X-Gm-Message-State: AOJu0YzSg2IjH8uoXhITKA1h1iC7il3dbjT0qYweU97upgJT4MaYI7Fb
	TWJA50c+73+1v24pYIMuz/rfVzjbJJqGT3ZyaBAVR8eUxXKryV5b9DhK6dHTNLJwjrHMhgI3L/M
	Y
X-Google-Smtp-Source: AGHT+IGCqtYb4qgZN1VkNtpPuU07LJ45oZV3LYEY28TcsQMJbW71zwTdd8rKaOpj9b4J6zfyHQdEOA==
X-Received: by 2002:a05:600c:511b:b0:40f:b5d2:1b16 with SMTP id o27-20020a05600c511b00b0040fb5d21b16mr3131031wms.25.1707099613407;
        Sun, 04 Feb 2024 18:20:13 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXsEiiGcu+HK5q33+UleB6113bUi1O0AeNouFF7kLCEmVI9poP+qcVQ4nLPu7j7SXaXMEth6FFhIDzKayNF3HeslyXQtRVYmkGkJt1/Kvlw5xyEj6e14/q0ZGDNid5PjdxkvlYHdgRdpoHPa0ms79YyOUR8TT89N1FftNGTmvATaiU+cdRhavvb4f5GoBOAHATEmP8faf4YEvhR+WIM2KLoJdAzPjapFLG14+mmY923vWYA+0cONcW/uSgeDVL5QLRxsjpBSNeNHN4wUb4Cs7shQIYsKc0=
Received: from airbuntu.. (host109-154-238-234.range109-154.btcentralplus.com. [109.154.238.234])
        by smtp.gmail.com with ESMTPSA id d10-20020a05600c4c0a00b0040efa7e0ef6sm3156075wmp.1.2024.02.04.18.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 18:20:13 -0800 (PST)
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
Subject: [PATCH] sched: cpufreq: Rename map_util_perf to apply_dvfs_headroom
Date: Mon,  5 Feb 2024 02:20:06 +0000
Message-Id: <20240205022006.2229877-1-qyousef@layalina.io>
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

Also move it to sched.h. This function relies on updating util signal
appropriately to give a headroom to grow. This is more of a scheduler
functionality than cpufreq. Move it to sched.h where all the other util
handling code belongs.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
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
index 95c3c097083e..abbd1ddb0359 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -179,7 +179,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
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


