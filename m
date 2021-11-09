Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A098E44B399
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 20:57:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244047AbhKIUAl (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 15:00:41 -0500
Received: from foss.arm.com ([217.140.110.172]:37980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244023AbhKIUAi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 15:00:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C08C2B;
        Tue,  9 Nov 2021 11:57:52 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 25D4E3F7F5;
        Tue,  9 Nov 2021 11:57:47 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, steev@kali.org, lukasz.luba@arm.com,
        sudeep.holla@arm.com, will@kernel.org, catalin.marinas@arm.com,
        linux@armlinux.org.uk, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, amitk@kernel.org,
        daniel.lezcano@linaro.org, amit.kachhap@gmail.com,
        thara.gopinath@linaro.org, bjorn.andersson@linaro.org,
        agross@kernel.org
Subject: [PATCH v4 4/5] cpufreq: qcom-cpufreq-hw: Use new thermal pressure update function
Date:   Tue,  9 Nov 2021 19:57:13 +0000
Message-Id: <20211109195714.7750-5-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109195714.7750-1-lukasz.luba@arm.com>
References: <20211109195714.7750-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal pressure provides a new API, which allows to use CPU frequency
as an argument. That removes the need of local conversion to capacity.
Use this new API and remove old local conversion code.

The new arch_update_thermal_pressure() also accepts boost frequencies,
which solves issue in the driver code with wrong reduced capacity
calculation. The reduced capacity was calculated wrongly due to
'policy->cpuinfo.max_freq' used as a divider. The value present there was
actually the boost frequency. Thus, even a normal maximum frequency value
which corresponds to max CPU capacity (arch_scale_cpu_capacity(cpu_id))
is not able to remove the capping.

The second side effect which is solved is that the reduced frequency wasn't
properly translated into the right reduced capacity,
e.g.
boost frequency = 3000MHz (stored in policy->cpuinfo.max_freq)
max normal frequency = 2500MHz (which is 1024 capacity)
2nd highest frequency = 2000MHz (which translates to 819 capacity)

Then in a scenario when the 'throttled_freq' max allowed frequency was
2000MHz the driver translated it into 682 capacity:
capacity = 1024 * 2000 / 3000 = 682
Then set the pressure value bigger than actually applied by the HW:
max_capacity - capacity => 1024 - 682 = 342 (<- thermal pressure)
Which was causing higher throttling and misleading task scheduler
about available CPU capacity.
A proper calculation in such case should be:
capacity = 1024 * 2000 / 2500 = 819
1024 - 819 = 205 (<- thermal pressure)

This patch relies on the new arch_update_thermal_pressure() handling
correctly such use case (with boost frequencies).

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 0138b2ec406d..248135e5087e 100644
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
 
@@ -295,17 +295,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 
 	throttled_freq = freq_hz / HZ_PER_KHZ;
 
-	/* Update thermal pressure */
-
-	max_capacity = arch_scale_cpu_capacity(cpu);
-	capacity = mult_frac(max_capacity, throttled_freq, policy->cpuinfo.max_freq);
-
-	/* Don't pass boost capacity to scheduler */
-	if (capacity > max_capacity)
-		capacity = max_capacity;
-
-	arch_set_thermal_pressure(policy->related_cpus,
-				  max_capacity - capacity);
+	/* Update thermal pressure (the boost frequencies are accepted) */
+	arch_update_thermal_pressure(policy->related_cpus, throttled_freq);
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
-- 
2.17.1

