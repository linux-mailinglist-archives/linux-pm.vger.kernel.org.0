Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4140A32939E
	for <lists+linux-pm@lfdr.de>; Mon,  1 Mar 2021 22:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240737AbhCAV3T (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 1 Mar 2021 16:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241578AbhCAV0f (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 1 Mar 2021 16:26:35 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094F3C0617A7
        for <linux-pm@vger.kernel.org>; Mon,  1 Mar 2021 13:23:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w7so505918wmb.5
        for <linux-pm@vger.kernel.org>; Mon, 01 Mar 2021 13:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c0ZvIjJHRTziXyViFMvrOdCl+6OVi36JkN8Az258FFk=;
        b=F25vV8ZwUlpswV28t5eTxSEqVwfPJQNQVhoJlps0ydBthIHOOzFTJorj0Ur44LRcZk
         HW16eoSIvgZ63I/rWT4Ff4UEEhg4wBOKXhP3zwKcytejl5hry5G3mgjouDundeg5D1qt
         bexwYHfW7XO58De9uz2Sw1Dn/ND6S89X0NkBTS95cWfGlWrVvzp1kSbl/CBXdA+vH+aN
         kymfJm5Hyb3FgLG9RNvPipPBW0IdoQaMuXu0TRf4vKeGfBo8Iy10fCTKOMSTtsoNDhh5
         /QVAt3IxSaJBA3K+pMYmQi6eA1vl+wjcckwi4GpOraNUw43Rtpw/jscOxtwl84T5PqO7
         VKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c0ZvIjJHRTziXyViFMvrOdCl+6OVi36JkN8Az258FFk=;
        b=M43gmZxkSl7ExvdSZwxAXdA9RC7duqSkxPRj/M+4xkf6YpvaGUqMvyjYd4gnAq5UPM
         K1vWAUWOh3onY53W2gDHdY55JSbz1N5CQnPh2sxpDNztkPAL+rqQ6DFINPVtuUv1BoMp
         /OuxHAarakJUJXSXjB1zf75XuzaX+mw3q7eAqmQPFwYAiUO4BIWwpnlwyW2YE1Qz5Tjh
         e6kN5z8zvOEinmO4s6OGLMeCNjxzx0z35yW9ZfwhP/WY2buBgHgPTtd6+x6dHOfEE+av
         2RdrdV0xhDZbtYMAcq662wR46TbjFkHrOyMWl7ehAkrSirfQyPbDtgFcrvuHy9soQioQ
         +FdA==
X-Gm-Message-State: AOAM532es5Q78bAj4z0yytYOdmILvWFKJUzb5H0HWM4nh2PRI4H4muvm
        pxMf8Kw2L6FlBw62Yxa8Vkxvvw==
X-Google-Smtp-Source: ABdhPJxAcm9ZSZ2+Ew0yaY/tvRsvhtlD1818WLOUABifS7YNzhs8YpZm9rt+mivCEk8YBlFDOXA87g==
X-Received: by 2002:a7b:cf16:: with SMTP id l22mr759803wmg.26.1614633787709;
        Mon, 01 Mar 2021 13:23:07 -0800 (PST)
Received: from localhost.localdomain (lns-bzn-59-82-252-144-192.adsl.proxad.net. [82.252.144.192])
        by smtp.gmail.com with ESMTPSA id o11sm6783866wrq.74.2021.03.01.13.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 13:23:07 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 5/5] powercap/drivers/dtpm: Scale the power with the load
Date:   Mon,  1 Mar 2021 22:21:49 +0100
Message-Id: <20210301212149.22877-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210301212149.22877-1-daniel.lezcano@linaro.org>
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the power consumption is based on the current OPP power
assuming the entire performance domain is fully loaded.

That gives very gross power estimation and we can do much better by
using the load to scale the power consumption.

Use the utilization to normalize and scale the power usage over the
max possible power.

Tested on a rock960 with 2 big CPUS, the power consumption estimation
conforms with the expected one.

Before this change:

~$ ~/dhrystone -t 1 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
2260000

After this change:

~$ ~/dhrystone -t 1 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
1130000

~$ ~/dhrystone -t 2 -l 10000&
~$ cat /sys/devices/virtual/powercap/dtpm/dtpm:0/dtpm:0:1/constraint_0_max_power_uw
2260000

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/powercap/dtpm_cpu.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/dtpm_cpu.c b/drivers/powercap/dtpm_cpu.c
index e728ebd6d0ca..8379b96468ef 100644
--- a/drivers/powercap/dtpm_cpu.c
+++ b/drivers/powercap/dtpm_cpu.c
@@ -68,27 +68,40 @@ static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
 	return power_limit;
 }
 
+static u64 scale_pd_power_uw(struct cpumask *cpus, u64 power)
+{
+	unsigned long max, util;
+	int cpu, load = 0;
+
+	for_each_cpu(cpu, cpus) {
+		max = arch_scale_cpu_capacity(cpu);
+		util = sched_cpu_util(cpu, max);
+		load += ((util * 100) / max);
+	}
+
+	return (power * load) / 100;
+}
+
 static u64 get_pd_power_uw(struct dtpm *dtpm)
 {
 	struct dtpm_cpu *dtpm_cpu = to_dtpm_cpu(dtpm);
 	struct em_perf_domain *pd;
 	struct cpumask cpus;
 	unsigned long freq;
-	int i, nr_cpus;
+	int i;
 
 	pd = em_cpu_get(dtpm_cpu->cpu);
 	freq = cpufreq_quick_get(dtpm_cpu->cpu);
 
 	cpumask_and(&cpus, cpu_online_mask, to_cpumask(pd->cpus));
-	nr_cpus = cpumask_weight(&cpus);
 
 	for (i = 0; i < pd->nr_perf_states; i++) {
 
 		if (pd->table[i].frequency < freq)
 			continue;
 
-		return pd->table[i].power *
-			MICROWATT_PER_MILLIWATT * nr_cpus;
+		return scale_pd_power_uw(&cpus, pd->table[i].power *
+					 MICROWATT_PER_MILLIWATT);
 	}
 
 	return 0;
-- 
2.17.1

