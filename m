Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECCE1FCA0D
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jun 2020 11:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgFQJoT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Jun 2020 05:44:19 -0400
Received: from foss.arm.com ([217.140.110.172]:54466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgFQJoS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Jun 2020 05:44:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 37DD031B;
        Wed, 17 Jun 2020 02:44:18 -0700 (PDT)
Received: from ubuntu.arm.com (unknown [10.57.54.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD12C3F6CF;
        Wed, 17 Jun 2020 02:44:15 -0700 (PDT)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        rjw@rjwysocki.net, viresh.kumar@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc:     lukasz.luba@arm.com
Subject: [PATCH 2/2] cpufreq: arm_scmi: Set fast_switch_possible conditionally
Date:   Wed, 17 Jun 2020 10:43:32 +0100
Message-Id: <20200617094332.8391-2-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200617094332.8391-1-nicola.mazzucato@arm.com>
References: <20200617094332.8391-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Currently the fast_switch_possible flag is set unconditionally
to true. Based on this, schedutil does not create a
thread for frequency switching and would always use the
fast switch path.
However, if the platform does not support frequency
fast switch, this may cause the governor to attempt an
operation that is not supported by the platform.

Fix this by correctly retrieve the fast_switch capability
from the driver which knows if the platform can support
this feature.

Suggested-by: Lukasz Luba <lukasz.luba@arm.com>
Signed-off-by: Nicola Mazzucato <nicola.mazzucato@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 61623e2ff149..1cf688fcb56b 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -198,7 +198,8 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 
 	policy->cpuinfo.transition_latency = latency;
 
-	policy->fast_switch_possible = true;
+	policy->fast_switch_possible =
+		handle->perf_ops->fast_switch_possible(handle, cpu_dev);
 
 	em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
 
-- 
2.27.0

