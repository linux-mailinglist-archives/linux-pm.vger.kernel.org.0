Return-Path: <linux-pm+bounces-12018-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C4694C76F
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2024 01:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEC911F22237
	for <lists+linux-pm@lfdr.de>; Thu,  8 Aug 2024 23:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17415F301;
	Thu,  8 Aug 2024 23:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="QLuaar3r"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA0B158D92
	for <linux-pm@vger.kernel.org>; Thu,  8 Aug 2024 23:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723160663; cv=none; b=S2OmUlHIZaJdl6FAT5nW9o/xKIWIQHXZZHVqaZ/nFxqUTbewEfRCGNxjH4Qan7RltfFW8nKZ7Th4S8+p0wYx+vZomGFwbIvxRIJgQ9MO/BhqKYVd7bLxGdVO/HNljb61p/yq98lGVtcPRPBs+3HB6PBhp8dcM4K/1DA6PZPQe5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723160663; c=relaxed/simple;
	bh=o/NeEUEEPbRHH+4cOkUfuiP/C6hPXj0NMTmrXdr/eys=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=db/JvZN1uPONP+6rMMF6IOoFJxAONR5tLSfQTVWHjtCXHjUYsLak0X+9MNSG6IlCuSpTnNemVN/ngDo6PG6BYQ210sZvM8PSUlFG1VcSYAuSnTYp8IHJIRjOu4R2EaeB9Y+NZzDJ8SoUQGgw588sJ2rktLjr3lDIhG9RB9xWeH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=QLuaar3r; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso10070025e9.1
        for <linux-pm@vger.kernel.org>; Thu, 08 Aug 2024 16:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1723160659; x=1723765459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wpIOIz+eJ2EDI15m0KcmC252UQEoCmNdQr22+6Ldus8=;
        b=QLuaar3rZ6cn30lmRVm4ZsQctLTiuwn98gsqwH9tE2fdJ5E6y1lXo5HphgW+4YPqzk
         6NpqQTlFnVV4SXHZ4W/37PDZpt3IusSkhnagExHbs+CU106KMiq25lq40ZuBSLLceWPt
         K2jxahP1LiED3ftAiuegtOFtR4AJJmZtjU23U+JYn2cTUGmM8X/7jRKdAe2CwdFIT0Pa
         kPjccgVqq5qdf69ATqL6gc6+PrCuNvUhArq23LXup+lnS6J2UqqXoYVUeHucXu91g95H
         5TBoVuBre87d0PLFVwr3TXjUqxI/ezNPDJIyRCpDNMJVl15HnegBkc30kzIwHQQ0ODtg
         7vnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723160659; x=1723765459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wpIOIz+eJ2EDI15m0KcmC252UQEoCmNdQr22+6Ldus8=;
        b=sDVitiFXt7jTkkZAH9VuRxLK6PJzIUNRdWwMowJ7CQC7qkhXCpJbCW+LhXNQjDSo6b
         PlEM0HIcck+ncTsogWJ0qa0BSQukxePOddIYKQlL8ukzSovn5kNzeC/rWcEj1ZS2fydo
         BFlmE1AMmC90BDqU5o3gQYOh0JnwwJHhyReiivevSRnJdyRcDbiOAQC5lSfPci+kyvRp
         Y6fpsJBTKGJmLmt+sGN94F3rc4EWkvpUOM/YIMolLfAvDYBmJl2OYFFWOwMcn7ekgyf3
         sBQyycVUNvhSP/IsY4ll2evn+q2xkWqBN7Gbik2fGLxIkHfo5K+gNjVyiNAJerT0qLNv
         3iXw==
X-Forwarded-Encrypted: i=1; AJvYcCXvukKgQpXfAes1ZFqaSpmFCIUeUowQ9c785ZG0F31kc+QHGpZj8k1qp8ZwvkQlF6tr2CLFmHKyZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7zVwmhiTkmBMxI9RlfSU21JGhw9Bm5KPjx+XpiZV59oU2cE3M
	9X5InXCvYZ/dgbhgCI++fphUpEpbfCKW61CZhm+1PO+SYE3jmbthhEZhaesQ0Ck=
X-Google-Smtp-Source: AGHT+IF5WGofAa3s9FWKI8I6nuBJ247zT4E/5cpCXyN76sgpTHR9BEpdZYWFSSOGbuONhaebr4+sFw==
X-Received: by 2002:a5d:6e48:0:b0:35f:1cc9:1d1d with SMTP id ffacd0b85a97d-36d27561030mr2592313f8f.38.1723160659259;
        Thu, 08 Aug 2024 16:44:19 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36d27193339sm3466071f8f.63.2024.08.08.16.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 16:44:18 -0700 (PDT)
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
Subject: [PATCH v3] sched: cpufreq: Rename map_util_perf to sugov_apply_dvfs_headroom
Date: Fri,  9 Aug 2024 00:44:15 +0100
Message-Id: <20240808234415.554937-1-qyousef@layalina.io>
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
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Qais Yousef <qyousef@layalina.io>
---

Changes in v3:

	1. Add Reviewed-by from Vincent

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


