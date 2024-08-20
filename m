Return-Path: <linux-pm+bounces-12578-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FDA958C5D
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 18:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CEAB1F266F0
	for <lists+linux-pm@lfdr.de>; Tue, 20 Aug 2024 16:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B051C230E;
	Tue, 20 Aug 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b="OYm/b04C"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC861C3788
	for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171814; cv=none; b=poaj57N5JdF+LsdMWH6aW3vzQKdJwGVbqImjCxvDLAJPuvZ/6IA7f/SlLjreiJvo6g8aZaQFfC4qGbtl27QeNiALJyyDQh2CyKQWiL/OrjGA8ogPCO3BJcngAxHMBMd7PcpuqB4h1N89/47XXadxEWAC3x1LxaMrnMJvtVmDypk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171814; c=relaxed/simple;
	bh=9ZPSZBuNvWFZgZLOCmzGhftDorxtai3m2giRjex3pcY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=as0KfUvf0VjXdXLPLwrK1klUl4KRblJvlRBoUU+N32lcsz/fw5dHJ8f0/8FtdzoUB9+WbEROAgzQ8sdNKD2rTB+7Xku+WSigJ9YAvXP1nroiAKqKCcQlJYXmD/Aw7pNAK1veCDdPEicsaRIJfjz+DpxJCKv4AE+OXybH+BerwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io; spf=pass smtp.mailfrom=layalina.io; dkim=pass (2048-bit key) header.d=layalina-io.20230601.gappssmtp.com header.i=@layalina-io.20230601.gappssmtp.com header.b=OYm/b04C; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=layalina.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=layalina.io
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8643235f99so163172066b.3
        for <linux-pm@vger.kernel.org>; Tue, 20 Aug 2024 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20230601.gappssmtp.com; s=20230601; t=1724171811; x=1724776611; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9h5cxC5T/07ttsRJWHESo6Dab0VfuQh9Cth3dLGuihw=;
        b=OYm/b04CrUWrJrdjX1an4E8erpwS2OhGYQZkI6WK68VaOwmsESIYHq5xbTJGzlFKGX
         NsXyrOzuTP8zggrwTcWzP4ej1rOOneaPjb/nVsCdLwiJ/gi2jZv9ypuEtrmw99ELT455
         ljeDskts8uzbrDKuMxLP+7M0luwGiSt+VqA3Ei/4M1wuI5QACp7Xk6C/y/IkUo5Mztal
         aXSjKYLMtM+QJTuEZlTfM7uuQsJWTl4OUFEIPupjgcdSLHH3/srpjxVjNAxzWjYc0ZpY
         crJjifgsxSAZjBgFo0CWXUjNxbgQAKA4cLhF8NP2tPKhNEaoncfr7tk1WBbyZfgv9OWl
         0xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171811; x=1724776611;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9h5cxC5T/07ttsRJWHESo6Dab0VfuQh9Cth3dLGuihw=;
        b=WyssfxmKgF2Z//eI2u7NFJWHE8yCraoFKTEew9Nhz/xv26IJ5I0hMuYLcAUi6CYYG7
         DUU/NJFz7ULIent9pKdYBVOoHVyNu0sjYAnf6E+pTs1q4kjBB0NIi3oQSfGIsro3ahsp
         /xwBcAIRpSeuRbIxAp3+WeN3OG40TCqfzNqdpLB1cQ994tceAx7ZLrFrOx5ovxIfGtRO
         Ewqx7Mmabe6Iy9p3WRy8DiVJH8xm9Aga8YCPsr0XLaApszk2Eiyez3QjVNEhxXLqhJvJ
         C1Yux8uejOoBQdFpNEQ+NHOAAYpiFtzlBJ56Xj2PSdKk24mmETu0Bnv0rvOI5v/hV6ma
         Oumg==
X-Forwarded-Encrypted: i=1; AJvYcCUtAuOOv6N60uQJOG9TRep/ryzapgwvH11hMP/mQjoa7uh1qBzFdkgbvkeyq3LcPjX+wpZBrY6YWTpIkmD63EVQeg9ANu0p0gk=
X-Gm-Message-State: AOJu0YwkEjioWH3I+zTnCaIz+Ay5SZxS1lOnN+auO2GjJC0fpBO8jrRq
	v0wwf3imMWg8ud31AP6Rjauj0jVop2QO7z6Lwv+mV6USEW0akjstbRuHKRWEb2E=
X-Google-Smtp-Source: AGHT+IG0xeJvN3XiOQlKOh7QN7lETQdxPtqwJVb6er+yMgBCCOTRa61cwW2df57Oc6uhYemybizG5Q==
X-Received: by 2002:a17:907:97d2:b0:a77:cdaa:88a3 with SMTP id a640c23a62f3a-a86479e45efmr210115366b.27.1724171811016;
        Tue, 20 Aug 2024 09:36:51 -0700 (PDT)
Received: from airbuntu.. (host81-157-90-255.range81-157.btcentralplus.com. [81.157.90.255])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a83838cfb5esm780728766b.59.2024.08.20.09.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 09:36:50 -0700 (PDT)
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
Subject: [RFC PATCH 14/16] sched/schedutil: Ignore dvfs headroom when util is decaying
Date: Tue, 20 Aug 2024 17:35:10 +0100
Message-Id: <20240820163512.1096301-15-qyousef@layalina.io>
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

It means we're being idling or doing less work and are already running
at a higher value. No need to apply any dvfs headroom in this case.

Signed-off-by: Qais Yousef <qyousef@layalina.io>
---
 kernel/sched/cpufreq_schedutil.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 318b09bc4ab1..4a1a8b353d51 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -9,6 +9,7 @@
 #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
 
 DEFINE_PER_CPU_READ_MOSTLY(unsigned long, response_time_mult);
+DEFINE_PER_CPU(unsigned long, last_update_util);
 
 struct sugov_tunables {
 	struct gov_attr_set	attr_set;
@@ -262,15 +263,19 @@ static unsigned int get_next_freq(struct sugov_policy *sg_policy,
  * Also take into accounting how long tasks have been waiting in runnable but
  * !running state. If it is high, it means we need higher DVFS headroom to
  * reduce it.
- *
- * XXX: Should we provide headroom when the util is decaying?
  */
 static inline unsigned long sugov_apply_dvfs_headroom(unsigned long util,  int cpu)
 {
-	unsigned long update_headroom, waiting_headroom;
+	unsigned long update_headroom, waiting_headroom, prev_util;
 	struct rq *rq = cpu_rq(cpu);
 	u64 delay;
 
+	prev_util = per_cpu(last_update_util, cpu);
+	per_cpu(last_update_util, cpu) = util;
+
+	if (util < prev_util)
+		return util;
+
 	/*
 	 * What is the possible worst case scenario for updating util_avg, ctx
 	 * switch or TICK?
-- 
2.34.1


