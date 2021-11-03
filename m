Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6063444586
	for <lists+linux-pm@lfdr.de>; Wed,  3 Nov 2021 17:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhKCQNk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Nov 2021 12:13:40 -0400
Received: from foss.arm.com ([217.140.110.172]:33040 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232926AbhKCQN2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 3 Nov 2021 12:13:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D1762ED1;
        Wed,  3 Nov 2021 09:10:51 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.26.226])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 703DF3F7D7;
        Wed,  3 Nov 2021 09:10:47 -0700 (PDT)
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
Subject: [PATCH v3 3/5] cpufreq: qcom-cpufreq-hw: Update offline CPUs per-cpu thermal pressure
Date:   Wed,  3 Nov 2021 16:10:18 +0000
Message-Id: <20211103161020.26714-4-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211103161020.26714-1-lukasz.luba@arm.com>
References: <20211103161020.26714-1-lukasz.luba@arm.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The thermal pressure signal gives information to the scheduler about
reduced CPU capacity due to thermal. It is based on a value stored in
a per-cpu 'thermal_pressure' variable. The online CPUs will get the
new value there, while the offline won't. Unfortunately, when the CPU
is back online, the value read from per-cpu variable might be wrong
(stale data).  This might affect the scheduler decisions, since it
sees the CPU capacity differently than what is actually available.

Fix it by making sure that all online+offline CPUs would get the
proper value in their per-cpu variable when there is throttling
or throttling is removed.

Fixes: 275157b367f479 ("cpufreq: qcom-cpufreq-hw: Add dcvs interrupt support")
Reviewed-by: Thara Gopinath <thara.gopinath@linaro.org>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index a2be0df7e174..0138b2ec406d 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -304,7 +304,8 @@ static void qcom_lmh_dcvs_notify(struct qcom_cpufreq_data *data)
 	if (capacity > max_capacity)
 		capacity = max_capacity;
 
-	arch_set_thermal_pressure(policy->cpus, max_capacity - capacity);
+	arch_set_thermal_pressure(policy->related_cpus,
+				  max_capacity - capacity);
 
 	/*
 	 * In the unlikely case policy is unregistered do not enable
-- 
2.17.1

