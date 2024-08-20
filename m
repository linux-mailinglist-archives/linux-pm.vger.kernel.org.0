Return-Path: <linux-pm+bounces-12567-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC43958C47
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D13661C21CB8
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D148F1BC9E7;
	Tue, 20 Aug 2024 16:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="I8RXwI2m"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68673195F17
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171723; cv=none; b=f9R3RNK8ynltr7Bv4gdM0mIKCjoKghFOEv3OdUtWK23zbm/3Wiaf/wHzeC6VV1imcr/ARNViN7N/JQRHftGOx7RD1OztVP7kq0tzRIo3Z7QpR9PQY2t6Hm3od2LQHptZWpxzs+HKPY8FI2Dup6EvYrmo4xWKx9nY9Aij+Xa3vkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171723; c=relaxed/simple;
	bh=FF4nQxBM0nS1lqakhr4Q+sUzCZDVAFySaog/xxInf3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ok+lExfqimQJetY1Y223sgogUU07DNUORaRnXZtBWCzT2GFgzSNKqJ20D8pZmqgzv8dbo3u2hyelgqD7NCxdyUeWNRFuZxjoxmD7nCcwy/Ly9Nne2Y3IZRifDWjddYakch2euBsqRPVDKZ0YUVTMZh0hZECHKXlsAU3PU7Dc01w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=I8RXwI2m; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso30807121fa.2
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171719; x=1724776519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/BSe4KOyJw2YEYF8rnu6mjIl7u9y+oNGIQ3Hg6lKPvk=;
        b=I8RXwI2menTRCf+yMfWW84ydKaVgC8EaI0+dk0M56EXo1MH5w5kGeC4s2aOpnqQWZQ
         VK9w+FqoOQlkqcCO7ngOn4KWGi7Dk9rcqopIwm3NbpFrHtPkSMIjFLhpvgtwR11sl0n3
         9uONdTjNa87gXkR4Z8g883SQgjTwYZorQuGWz/LvC9IWbmw2KUxkvsZzFZLpE3zmgh4d
         JQ20QBJlGdjA0uCPNyh5vaEAXt7DZzaeYNgAC81/il4bqs1+1d7qGzDuKrcaq7ySaRf1
         9JTFsbjojBZvIOii/Uzl36hdwPQfw+PHkl4iIcRTkr5UutahNW9NWZk6uFpXt7Dn7GVc
         gWPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171719; x=1724776519;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/BSe4KOyJw2YEYF8rnu6mjIl7u9y+oNGIQ3Hg6lKPvk=;
        b=D+sDfcp5ynZtOn4VhNCrXk6LJG0N+4Wd+G4kiJHqzllvJ6/8PfjiZWbDPgXvp2PCCy
         52zs3un9Tk7YF0Otw9bINlCQYeNEWfxM8AB7u6hgiganFgKN9wft0fGeB84q1cbkx75t
         eHaORjWR5aP+7oIwB7duKMTaXVrJRN7LA6qfe5Q5GJHppxHMcy68423sfo8J8zSw/Z3z
         vzW/hCmtDPwdq6fm3rIJROUnGHhZENGl+oWYTiWXBB909SSEkRUrL2Prm9Cps8frUptn
         d79kgoXj+5Vg+NOZUHVIabJ7P1fOS2ZJ/6+Nz9PQeGBwLUFaWZmGZ+K7wqrOmsH9O4CL
         2HcA==
X-Forwarded-Encrypted: i=1; AJvYcCWBwgqSp/yqeX3j5oNcFVkeZSRoYFYnh8ninN+YnHuQ7wHtohBklPVOYMglrBGGIXhDLdkJOcosMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdYlNdlebtnAhUJWjzljGEUh5qjcAzQPVRQhn9tVGL7UfURaVX
	mVoqNIgKmPWn0YYysSjAxBc/kG2KUDmHjWj639uuKSZaBy8dwelZS4r5cNCtonU=
X-Google-Smtp-Source: AGHT+IFsK5sSF4zn+iA0VCf5c4osiSUBkZLZkTq8PaWwmO8mR0g9hawJ9xoV1658/XBy+x9/4qSzfw==
X-Received: by 2002:a05:6512:3d28:b0:52c:8342:6699 with SMTP id 2adb3069b0e04-5331c6e4088mr12083886e87.55.1724171719232;
        Tue, 20 Aug 2024 09:35:19 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:35:18 -0700 (PDT)
From: Qais Yousef <qyousef@layalina.io>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	John Stultz <jstultz@google.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qais Yousef <qyousef@layalina.io>
Subject: [RFC PATCH 03/16] sched/pelt: Add a new function to approximate runtime to reach given util
Date: Tue, 20 Aug 2024 17:34:59 +0100
Message-Id: <20240820163512.1096301-4-qyousef@layalina.io>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240820163512.1096301-1-qyousef@layalina.io>
References: <20240820163512.1096301-1-qyousef@layalina.io>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is basically the ramp-up time from 0 to a given value. Will be used
later to implement new tunable to control response time  for schedutil.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/pelt.c  | 21 +++++++++++++++++++++
 kernel/sched/sched.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
index 2ce83e880bd5..06cb881ba582 100644
--- a/kernel/sched/pelt.c
+++ b/kernel/sched/pelt.c
@@ -487,3 +487,24 @@ unsigned long approximate_util_avg(unsigned long util, u64 delta)
 
 	return sa.util_avg;
 }
+
+/*
+ * Approximate the required amount of runtime in ms required to reach @util.
+ */
+u64 approximate_runtime(unsigned long util)
+{
+	struct sched_avg sa = {};
+	u64 delta = 1024; // period = 1024 = ~1ms
+	u64 runtime = 0;
+
+	if (unlikely(!util))
+		return runtime;
+
+	while (sa.util_avg < util) {
+		accumulate_sum(delta, &sa, 1, 0, 1);
+		___update_load_avg(&sa, 0);
+		runtime++;
+	}
+
+	return runtime;
+}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 294c6769e330..47f158b2cdc2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -3065,6 +3065,7 @@ unsigned long sugov_effective_cpu_perf(int cpu, unsigned long actual,
 				 unsigned long max);
 
 unsigned long approximate_util_avg(unsigned long util, u64 delta);
+u64 approximate_runtime(unsigned long util);
 
 /*
  * Verify the fitness of task @p to run on @cpu taking into account the
-- 
2.34.1


