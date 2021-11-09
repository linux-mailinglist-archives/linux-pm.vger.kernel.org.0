Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1A44B392
	for <lists+linux-pm@lfdr.de>; Tue,  9 Nov 2021 20:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243974AbhKIUAa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 9 Nov 2021 15:00:30 -0500
Received: from foss.arm.com ([217.140.110.172]:37936 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243986AbhKIUA3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 9 Nov 2021 15:00:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 086062B;
        Tue,  9 Nov 2021 11:57:43 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.26.224])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B109C3F7F5;
        Tue,  9 Nov 2021 11:57:38 -0800 (PST)
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
Subject: [PATCH v4 2/5] thermal: cpufreq_cooling: Use new thermal pressure update function
Date:   Tue,  9 Nov 2021 19:57:11 +0000
Message-Id: <20211109195714.7750-3-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211109195714.7750-1-lukasz.luba@arm.com>
References: <20211109195714.7750-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Thermal pressure provides a new API, which allows to use CPU frequency
as an argument. That removes the need of local conversion to capacity.
Use this new function and remove old conversion code.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/cpufreq_cooling.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index 43b1ae8a7789..0bfb8eebd126 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -462,7 +462,6 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	struct cpufreq_cooling_device *cpufreq_cdev = cdev->devdata;
 	struct cpumask *cpus;
 	unsigned int frequency;
-	unsigned long max_capacity, capacity;
 	int ret;
 
 	/* Request state should be less than max_level */
@@ -479,10 +478,7 @@ static int cpufreq_set_cur_state(struct thermal_cooling_device *cdev,
 	if (ret >= 0) {
 		cpufreq_cdev->cpufreq_state = state;
 		cpus = cpufreq_cdev->policy->related_cpus;
-		max_capacity = arch_scale_cpu_capacity(cpumask_first(cpus));
-		capacity = frequency * max_capacity;
-		capacity /= cpufreq_cdev->policy->cpuinfo.max_freq;
-		arch_set_thermal_pressure(cpus, max_capacity - capacity);
+		arch_update_thermal_pressure(cpus, frequency);
 		ret = 0;
 	}
 
-- 
2.17.1

