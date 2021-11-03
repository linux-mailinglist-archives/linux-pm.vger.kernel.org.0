Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5958E444585
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232812AbhKCQNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 12:13:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhKCQNd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 12:13:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB25ED1;
        Wed,  3 Nov 2021 09:10:56 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.26.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 46B483F7D7;
        Wed,  3 Nov 2021 09:10:52 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: [PATCH v3 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
Date:   Wed,  3 Nov 2021 16:10:19 +0000
Message-Id: <20211103161020.26714-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103161020.26714-1-lukasz.luba@arm.com>
References: <20211103161020.26714-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal pressure provides a new API, which allows to use CPU frequency
as an argument. That removes the need of local conversion to capacity.
Use this new API and remove old local conversion code.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0138b2ec406d..425f351450ad 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -275,10 +275,10 @@ static unsigned int qcom_lmh_get_throttle_freq(struct qcom_cpufreq_data *data)
 
 static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 {
-	unsigned long max_capacity, capacity, freq_hz, throttled_freq;
 	struct cpufreq_policy *policy = data->policy;
 	int cpu = cpumask_first(policy->cpus);
 	struct device *dev = get_cpu_device(cpu);
+	unsigned long freq_hz, throttled_freq;
 	struct dev_pm_opp *opp;
 	unsigned int freq;
 
@@ -295,17 +295,12 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
-	/* Update thermal pressure */
-
-	max_capacity = arch_scale_cpu_capacity(cpu);
-	capacity = mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq);
-
 	/* Don't pass boost capacity to scheduler */
-	if (capacity > max_capacity)
-		capacity = max_capacity;
+	if (throttled_freq > policy->cpuinfo.max_freq)
+		throttled_freq = policy->cpuinfo.max_freq;
 
-	arch_set_thermal_pressure(policy->related_cpus,
-				  max_capacity - capacity);
+	/* Update thermal pressure */
+	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
-- 
2.17.1

