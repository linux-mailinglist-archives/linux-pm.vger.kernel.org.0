Return-Path: <linux-pm+bounces-36468-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB47BF1CC9
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 16:19:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B96A4F7A43
	for <lists+linux-pm@lfdr.de>; Mon, 20 Oct 2025 14:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50915328628;
	Mon, 20 Oct 2025 14:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ixUr9Y4S"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DE4184
	for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 14:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760969858; cv=none; b=r7xjORqBJXVZyM/uSFCCbDilbBPqGbsoI+fOPVS93BRpvUM7Q6pPm+5iu+0pKeLgad3Gakzj4XungeaKerPfKr45FfMoUM8LOdfR6IW5Xia6Va2C/2t6cxnPpdvir8AkbNa6nfjV7iiDrqxVAIAiStL3E1CNoZNwsdIaLIVeVGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760969858; c=relaxed/simple;
	bh=TCMur3W305UYpjzmNzxUmoJ7pqZkPL+65/d3pRVJ+8c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBXOvn4BB9v6gCwl0LQJtWU0so7oEf3375Fer7XwSFumYxqPYzWEDrQafFFOjdVuLMzPs9YRklEysijw1LQzBkBDwUttGTM+t8faEGlv5Q8LMgJWNkb9x6xiSYJC7w6ZiGznYisYH86SQhn6naJVWkAWfNd9e85N4k7H5Hij6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ixUr9Y4S; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-37777912136so42141531fa.0
        for <linux-pm@vger.kernel.org>; Mon, 20 Oct 2025 07:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1760969854; x=1761574654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGaC808GWK5LvOXihoY32Hd24hri1xoqdM6UgzacKUw=;
        b=ixUr9Y4Sh6v6YYTOQawMpC/lJfrwXd/gWXfFqlgPz2/9ItwKXVtTUCLjaDlAyezL4Q
         nJy0UhPcpre2dq00g4uOpiY84GSqiqXJhLYCFYvwzV4tajLpe1q4ZadayYNensp6YfgE
         khlwmOpt6VGgj+aL3uvRNlHgYb4paXpEZhTKz9Ea56f9475HWmNZEMXf/tb7hgj5aR+Y
         /QQtqj4q//K/Sa+KfmhHZJr4XfQqKftwIQuEuHJr+ltBAcs47Qko6bNK7mg9au2IyUdc
         vDM27JMIXtLzb2n0Nm0vMTbL58CtqVM8Y0Kmygpl8tplghWxDitWMDlJHGXYS+7yGG+z
         kRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760969854; x=1761574654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGaC808GWK5LvOXihoY32Hd24hri1xoqdM6UgzacKUw=;
        b=iN0mwMhzOMZVi89DALVPX2mV0mXNSIxt4EbbJezbJ460bq3vW8aJaVuYAjlQTh2p5o
         frzRIO9wCmaW3KBj6JhCjh3FvkRuh3ukFsaSgUsuC4+Pylmwo3UjeKtmuwBZdjc+vFsT
         P4t/Fi7m5CyczhIQmacwwCPB7g+61KprHG8USlXyr9+LhR1P6L/85WQc1n6Jak3bQs5S
         0jaCfOIq3VE53a/xSRKcW08aKXySPNjPmLyygdUEz01OKmbAKyyyjQfigYYNsLesW+xN
         u11nuJTnOKRgP5MVcVxEsoC2ZTurTC5egHy7M/F0a1z2TPogw+E1AkfXZaFWsyMIKCVW
         9L7g==
X-Forwarded-Encrypted: i=1; AJvYcCX4DYGXbqUFOxawtAQyHeu2QQNOfYrmCwoFPO7REENQDQFPlMWQpdFh1LW+Z4LFfYAc0ug0wnJ4MQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyMj46IgFIMva1pNp6TYyqxv37/TwYpVBf1GIe4g5Whp6P0Xnaj
	ik139KCFUZq3eeTn8a3zpNdl8I+nFCkvh+rQWKNndwou0geVKV7FDiA7ch0iEIVUBrA=
X-Gm-Gg: ASbGncsOpr+m3UKhnogDieuvpWYQ9W+VrC2LWSFoTymWtYdcYG/76GPt9l6FCs034JF
	uCwCZL1Em/LcNgatnHLE6ZJbw5C48ZxV5GXhlFOz8paesbYf12oLMlQm270p94cCK/e0apGe2pf
	uyc1GpMNJjkKpJkwCqMqgMFLr38eQ3nPtNFAa3vgQT85PqErtYFX6XqN/koRHeQoKVBQSkHwK6f
	ElC1PkgjiyYv4QB8qEmZI3K5CFXUruvukZyWDe3fxOB1VyUskULBGVO5lCt5gzj1TnbDhmtPmJ9
	+PZl1TqNCs8wrxWaA5OUme1xEGfB3ezIqCZKQOTuLy+tCCwdhnpaxRYGV9Nkj+smXlAgboAaaXa
	5YBRYpI6KmBfENienHu6aFWAVOk+LFXnss79qPNR137MdFETJ70blq3YDUM0ATZ+QGvrx/UvRwN
	qaGPbla+YjAsCzS7ozyT6V9Suq2cWmQDXfloWQHfrjlVbNGJDoB5+2WhbR98lc
X-Google-Smtp-Source: AGHT+IHq+N7kJam9BA4Q2VZUWH3bExEE+I696f8s201sUzMH8M2RHkReQkfdKWnv543fHUx9gbKhQg==
X-Received: by 2002:a05:651c:2343:20b0:377:c5b7:7bbd with SMTP id 38308e7fff4ca-377c5b77c4emr4089701fa.15.1760969853955;
        Mon, 20 Oct 2025 07:17:33 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-377a950a284sm20797191fa.36.2025.10.20.07.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 07:17:33 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v2 2/2] pmdomain: Extend the genpd governor for CPUs to account for IPIs
Date: Mon, 20 Oct 2025 16:17:12 +0200
Message-ID: <20251020141718.150919-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251020141718.150919-1-ulf.hansson@linaro.org>
References: <20251020141718.150919-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the genpd governor for CPUs, tries to select the most optimal
idlestate for a group of CPUs managed in a PM domain, it fails far too
often.

On a Dragonboard 410c, which is an arm64 based platform with 4 CPUs
in one cluster that is using PSCI OS-initiated mode, we can observe that we
often fail when trying to enter the selected idlestate. This is certainly a
suboptimal behaviour that leads to many unnecessary requests being sent to
the PSCI FW.

A simple dd operation that reads from the eMMC, to generate some IRQs and
I/O handling helps us to understand the problem, while also monitoring the
rejected counters in debugfs for the corresponding idlestates of the genpd
in question.

 Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             1451           437        91         149        0
S1             65194          558        149        172        0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.562698 seconds, 140.3MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2694           1073       265        892        1
S1             74567          829        561        790        0

 The dd completed in ~3.6 seconds and rejects increased with 586.

 Teo governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             4976           2096       392        1721       2
S1             160661         1893       1309       1904       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.543225 seconds, 141.1MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5192           2194       433        1830       2
S1             167677         2891       3184       4729       0

 The dd completed in ~3.6 seconds and rejects increased with 1916.

The main reason to the above problem is pending IPIs for one of the CPUs
that is affected by the idlestate that the genpd governor selected. This
leads to that the PSCI FW refuses to enter it. To improve the behaviour,
let's start to take into account pending IPIs for CPUs in the genpd
governor, hence we fallback to use the shallower per CPU idlestate.

 Re-testing with this change shows a significant improved behaviour.

 - Menu governor:
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             2556           878        19         368        1
S1             69974          596        10         152        0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.522010 seconds, 142.0MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             3360           1320       28         819        1
S1             70168          710        11         267        0

 The dd completed in ~3.5 seconds and rejects increased with 10.

 - Teo governor
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5145           1861       39         938        1
S1             188887         3117       51         1975       0
dd if=/dev/mmcblk0 of=/dev/null bs=1M count=500
524288000 bytes (500.0MB) copied, 3.653100 seconds, 136.9MB/s
cat /sys/kernel/debug/pm_genpd/power-domain-cluster/idle_states
State          Time Spent(ms) Usage      Rejected   Above      Below
S0             5260           1923       42         1002       1
S1             190849         4033       52         2892       0

 The dd completed in ~3.7 seconds and rejects increased with 4.

Note that, the rejected counters in genpd are also being accumulated in the
rejected counters that are managed by cpuidle, yet on a per CPU idlestates
basis. Comparing these counters before/after this change, through cpuidle's
sysfs interface shows the similar improvements.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Use the new name of the helper function.
	- Re-test and update the statistics in the commit message.

---
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..ed2ce9b6f8d1 100644
--- a/drivers/pmdomain/governor.c
+++ b/drivers/pmdomain/governor.c
@@ -404,15 +404,21 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 		if ((idle_duration_ns >= (genpd->states[i].residency_ns +
 		    genpd->states[i].power_off_latency_ns)) &&
 		    (global_constraint >= (genpd->states[i].power_on_latency_ns +
-		    genpd->states[i].power_off_latency_ns))) {
-			genpd->state_idx = i;
-			genpd->gd->last_enter = now;
-			genpd->gd->reflect_residency = true;
-			return true;
-		}
+		    genpd->states[i].power_off_latency_ns)))
+			break;
+
 	} while (--i >= 0);
 
-	return false;
+	if (i < 0)
+		return false;
+
+	if (cpus_may_have_pending_ipi(genpd->cpus))
+		return false;
+
+	genpd->state_idx = i;
+	genpd->gd->last_enter = now;
+	genpd->gd->reflect_residency = true;
+	return true;
 }
 
 struct dev_power_governor pm_domain_cpu_gov = {
-- 
2.43.0


