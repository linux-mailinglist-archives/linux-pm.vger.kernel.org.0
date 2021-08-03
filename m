Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F13DE977
	for <lists+linux-pm@lfdr.de>; Tue,  3 Aug 2021 11:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234840AbhHCJII (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 3 Aug 2021 05:08:08 -0400
Received: from foss.arm.com ([217.140.110.172]:45080 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234814AbhHCJII (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Aug 2021 05:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 647DE11D4;
        Tue,  3 Aug 2021 02:07:57 -0700 (PDT)
Received: from e123648.arm.com (unknown [10.57.9.94])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D3DDB3F40C;
        Tue,  3 Aug 2021 02:07:53 -0700 (PDT)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, nicola.mazzucato@arm.com,
        lukasz.luba@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq: arm_scmi: Fix error path when allocation failed
Date:   Tue,  3 Aug 2021 10:07:44 +0100
Message-Id: <20210803090744.12143-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Stop the initialization when cpumask allocation failed and return an
error.

Fixes: 80a064dbd556 ("scmi-cpufreq: Get opp_shared_cpus from opp-v2 for EM")
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
changes:
v2:
- removed dev_warn() since it's not needed in this case
- adjusted the patch description

 drivers/cpufreq/scmi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index ec9a87ca2dbb..75f818d04b48 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -134,7 +134,7 @@ static int scmi_cpufreq_init(struct cpufreq_policy *policy)
 	}
 
 	if (!zalloc_cpumask_var(&opp_shared_cpus, GFP_KERNEL))
-		ret = -ENOMEM;
+		return -ENOMEM;
 
 	/* Obtain CPUs that share SCMI performance controls */
 	ret = scmi_get_sharing_cpus(cpu_dev, policy->cpus);
-- 
2.17.1

