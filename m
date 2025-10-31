Return-Path: <linux-pm+bounces-37178-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85927C24AC1
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F631894A62
	for <lists+linux-pm@lfdr.de>; Fri, 31 Oct 2025 11:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0495B33DEFC;
	Fri, 31 Oct 2025 11:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3yCgYd0"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EE53446B2
	for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 11:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761908484; cv=none; b=LA653KpwW2xlp6DlRja9oAvcOqXG+TtiEIi+Ek9zivybCj1fyg3MsOEXoFo5PY2oWgvVMEwX2Z4Y5DOLMrzZyX4xGUo8jri6S8h48hWvXVbQs31YIhn41TmVupPnXlNwWGxYQyPxZh+7p7XcGRJSGcViKBQw4DOSb05qILYXaew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761908484; c=relaxed/simple;
	bh=3kWXHynU6RKaZXdZvP/SpRNrIqnE/hq3aZgMVd4hc+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oX6L08+5kS1mEX5WG1sRJYQSeWF0RPLlPQx1/vL8QxTsTewWXcx3CqZ5vJcNGvqMr4sUun2fVT7gyPBw1JUhLD/d/vA9JrmBYX2URp4O7FBoIvbEXoIiLEQNHcmX8nFfLcJxty2zfmpHvvwZNnmXN12mTXYFkMGu+tHKm7aj+wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3yCgYd0; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-57e8e67aa3eso4722077e87.1
        for <linux-pm@vger.kernel.org>; Fri, 31 Oct 2025 04:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761908480; x=1762513280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9aIatXLlfj49i3F2CejCYzrKCiTw8TnzOpfYBQFqbQ=;
        b=d3yCgYd0wz58saSE5FncSWeqndNe4gTjNQGMVXL2R+9LE0b7vNBRqiRLBfYpEI0khw
         Q178Be4RkAj9fCGEo0udMlFnez5P/ZwKCbtR5yyUM7C3c/UXt5fMd7MjtqXyiKi0Xv0f
         lUoFYqXEq3HWbygfegiSh/I/HMdqG0cT/ST4PiU72V2Y21KM/xOV5kP6372OlTRgMWBY
         ZfMGkPQGVvQ4GVrK4tYq2m+ZMdOJ7GBG+3gZmPFmEOkOgWPiLAhePHjNVF+Qsi6Tzwgm
         Pc6h65eKgBVVtnE8opsNh3i0WuiJAcV2K7Qi5k/yVAEBMyfCyVUobQxQIwg3CmN675H0
         IQMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761908480; x=1762513280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9aIatXLlfj49i3F2CejCYzrKCiTw8TnzOpfYBQFqbQ=;
        b=OBMXDefjL2iNNIR6hn9BlBbhqgr9lTuslybi9TzFr22/ftYjleRqjN4o7HbtWNXsTM
         yN5qAImK4DIzqcNQnwEeALj7w6eLcmBXad10ta8Mg7NVdhEa75+1oHF+cTMoNhhnNQjb
         yMrHPGcQ+AcEUxNxraazn/xnMO6SujtWzNMrChYH8iqlmtuuTk9zLgZ7d2J8tP3oOSCN
         +lbR2T+P1mwCMexYd1AkFrz5IxYdGz/HyadCaHeUxVc1WQxVLkvSKucuNp4NmSq9VOkn
         t3vxz4h8Sn76uvG6qPOCYdGaij8A+wZ2Gip+wjddHH2XlqS3JZIb9kmW0Ncf3vyxKrSu
         izGw==
X-Forwarded-Encrypted: i=1; AJvYcCVVF77S3g/AGb1dsfbr68lW2mAtBzquMAQ0vuWk94fVyJ+f4MlH1bgs76ASDfYrviguiWlgGg0iEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yys8/68Z4nCBgi0ta4faMxqHcCj1KzchNifmYJw6BNhODx+wNpE
	nTtq0T8G08HgKsnwLLnbmEQgEsvnLuXzblaWmg+p3wMJgSP8FEvx3BuFATmRiJjw2l4=
X-Gm-Gg: ASbGncujfewgTKpKnqxIRmQXYeGsFifqENZKSFuw7TV02RRADeVDifSWeuqutUYdr79
	4x05vf2RF2mYV8cT7zrwG++yS+uautBebMo8yuMRUstxOXPAhJhMF0Gcs822eVQzdhyFqlCkZET
	FC0EPKzPZom4LVoNWr0yFSRJLbDAuFwKCDgIYbSpCAvVz63Lwh9/z+6iQp8vzGVTYkrpSqkkrg9
	z1ronefd8fCeQbknO9mjPbCjcqzh9KTNsnmC2r2Nsu05QGqmlEMkdydvDLopiXiOP2GyAQinsJL
	EH5NpAw7pswH0uFoVnxUjWwGeycPODT/15uusGx2i2aRUzMNgNphaBk895MKUQX28Kcf1rrMdS2
	Y36CRBePiojaNw8FkW/Ukry9rP1hSQDjoAyIJxrdVSLCEIMpdSWpxUsYEGMaYNvGLGO4cY1oR21
	1E0xZj7JjHtuTdYdixJumXyurRvSYYpW2STb+/6EXcFxTv4mMmJeAj2DHHstny
X-Google-Smtp-Source: AGHT+IEvmMm+SHsTsxbA+wx4szbKJtnGkNvIOtF29kV79GhvswIxNRBqKo3y48TrcsBUClr8bRcn2g==
X-Received: by 2002:a05:6512:b92:b0:592:fc90:f771 with SMTP id 2adb3069b0e04-59416d06f68mr2302670e87.1.1761908477406;
        Fri, 31 Oct 2025 04:01:17 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5941f5bbaa9sm432721e87.77.2025.10.31.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:01:15 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Maulik Shah <quic_mkshah@quicinc.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Ben Horgan <ben.horgan@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v3 2/2] pmdomain: Extend the genpd governor for CPUs to account for IPIs
Date: Fri, 31 Oct 2025 12:00:58 +0100
Message-ID: <20251031110106.62394-3-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031110106.62394-1-ulf.hansson@linaro.org>
References: <20251031110106.62394-1-ulf.hansson@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the genpd governor for CPUs, tries to select the most optimal idle
state for a group of CPUs managed in a PM domain, it fails far too often.

On a Dragonboard 410c, which is an arm64 based platform with 4 CPUs in one
cluster that is using PSCI OS-initiated mode, we can observe that we often
fail when trying to enter the selected idle state. This is certainly a
suboptimal behaviour that leads to many unnecessary requests being sent to
the PSCI FW.

A simple dd operation that reads from the eMMC, to generate some IRQs and
I/O handling helps us to understand the problem, while also monitoring the
rejected counters in debugfs for the corresponding idle states of the genpd
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
that is affected by the idle state that the genpd governor selected. This
leads to that the PSCI FW refuses to enter it. To improve the behaviour,
let's start to take into account pending IPIs for CPUs in the genpd
governor, hence we fallback to use the shallower per CPU idle state.

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
rejected counters that are managed by cpuidle, yet on a per CPU idle states
basis. Comparing these counters before/after this change, through cpuidle's
sysfs interface shows the similar improvements.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v3:
	- Use the new name of the helper function.
	- Minor updates to the commit message.

Changes in v2:
	- Use the new name of the helper function.
	- Re-test and update the statistics in the commit message.

---
 drivers/pmdomain/governor.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/pmdomain/governor.c b/drivers/pmdomain/governor.c
index 39359811a930..a46470f2261a 100644
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
+	if (cpus_peek_for_pending_ipi(genpd->cpus))
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


