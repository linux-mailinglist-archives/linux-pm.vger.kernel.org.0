Return-Path: <linux-pm+bounces-2183-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD8BB82D1DC
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jan 2024 19:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59F59281D11
	for <lists+linux-pm@lfdr.de>; Sun, 14 Jan 2024 18:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC03107B6;
	Sun, 14 Jan 2024 18:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lnv21vPt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8145243
	for <linux-pm@vger.kernel.org>; Sun, 14 Jan 2024 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e6f652eb8so11636875e9.1
        for <linux-pm@vger.kernel.org>; Sun, 14 Jan 2024 10:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705257369; x=1705862169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EyQLKONUGoejFiGiJOkwSEqFD8Z/p6ggsj4XU4Zx2kc=;
        b=Lnv21vPtxcl2v3OwPv5RW2rLbhoXlIWEDax3YxC1Ish2R+w4/HUtiZuBuEjom083pk
         qVBinCiWMPCUf38+mv5mNFWha3bmzaQj30L3umQRYhGH07Ukcso+LPRZCHofk63xs1PO
         mbS6BnD/yKbd6cCQHBbn3HZdqdzKyZF9LOH5cJV0vp5wJaWfYfKK9Rwy6Pawt55glU2Z
         WZfALOvs7Nz91Ncb/ETVOYXT6f8KK7a0AARCYUhwDcGRSHxcVad7tXeUdwd6DUdQpOpc
         FZ8/0sk4fTSIMCR1wV21Hooqeeugw9WkLSgOStntEYmShDxPjshoIJWxcdHc6fLTki0g
         9z1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705257369; x=1705862169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EyQLKONUGoejFiGiJOkwSEqFD8Z/p6ggsj4XU4Zx2kc=;
        b=jVDaW4DKEuMvBbYSDmY6eKb43tIhk6+1gL9ahE1miWt+Pa46OhLZGC5XuYn/sa9PxP
         KF5WbpFgALIcTjNSZxagIVXRwAwys73PviPktWxywhCEA8hhbdzGame2ZnnJlvpxIb00
         vFgT8vG+vMtpn0EBK71gNEGJR1aq5cVHjbmJUFm5bKRGkoU5pZ4pOyvGPL8sZSbSm3d6
         LJl8/wwSDZtTiEn6Mw4bBF2S1qNL92i+T0z9VSARN9nOPOp1UkkEc2GgqnswagtQGydc
         kEd8pr50hi6QiHGc1zsAbA5CvZB9kLBEnCRa7aaEnfbNtIcT4LDema0+vP9oLpKRpN7Q
         8m0A==
X-Gm-Message-State: AOJu0Yy54AwxW2jYfR/2nUf57YBFOI2yOkU2P0CuWp0QOfGrvHYuHNCk
	CldcrvOEi5+Q19I7oBGr/vX1qYjDvfxTyQ==
X-Google-Smtp-Source: AGHT+IFHMo2/EOYuRqEDUreqaqYe3tObOpvUcxwSTLetUDgAAG7ck8tTjPLZfGoh1+h1MIXKQM7/0g==
X-Received: by 2002:a7b:c458:0:b0:40e:697a:701b with SMTP id l24-20020a7bc458000000b0040e697a701bmr1478351wmi.247.1705257369052;
        Sun, 14 Jan 2024 10:36:09 -0800 (PST)
Received: from vingu-book.. ([2a01:e0a:f:6020:6389:1f58:77fa:5f22])
        by smtp.gmail.com with ESMTPSA id t6-20020a05600c198600b0040e48abec33sm17152808wmq.45.2024.01.14.10.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 10:36:03 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	bristot@redhat.com,
	vschneid@redhat.com,
	wkarny@gmail.com,
	torvalds@linux-foundation.org,
	qyousef@layalina.io,
	tglx@linutronix.de,
	rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched/fair: Fix frequency selection for non invariant case
Date: Sun, 14 Jan 2024 19:36:00 +0100
Message-Id: <20240114183600.135316-1-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When frequency invariance is not enabled, get_capacity_ref_freq(policy)
returns the current frequency and the performance margin applied by
map_util_perf(), enabled the utilization to go above the maximum compute
capacity and to select a higher frequency than the current one.

The performance margin is now applied earlier in the path to take into
account some utilization clampings and we can't get an utilization higher
than the maximum compute capacity.

We must use a frequency above the current frequency to get a chance to
select a higher OPP when the current one becomes fully used. Apply
the same margin and returns a frequency 25% higher than the current one in
order to switch to the next OPP before we fully use the cpu at the current
one.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Closes: https://lore.kernel.org/lkml/CAHk-=wgWcYX2oXKtgvNN2LLDXP7kXkbo-xTfumEjmPbjSer2RQ@mail.gmail.com/
Reported-by: Wyes Karny <wkarny@gmail.com>
Closes: https://lore.kernel.org/lkml/20240114091240.xzdvqk75ifgfj5yx@wyes-pc/
Fixes: 9c0b4bb7f630 ("sched/cpufreq: Rework schedutil governor performance estimation")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: Wyes Karny <wkarny@gmail.com>
---
 kernel/sched/cpufreq_schedutil.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 95c3c097083e..d12e95d30e2e 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -133,7 +133,11 @@ unsigned long get_capacity_ref_freq(struct cpufreq_policy *policy)
 	if (arch_scale_freq_invariant())
 		return policy->cpuinfo.max_freq;
 
-	return policy->cur;
+	/*
+	 * Apply a 25% margin so that we select a higher frequency than
+	 * the current one before the CPU is full busy
+	 */
+	return policy->cur + (policy->cur >> 2);
 }
 
 /**
-- 
2.34.1


