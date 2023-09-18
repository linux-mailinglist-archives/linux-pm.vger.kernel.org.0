Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C931B7A4875
	for <lists+linux-pm@lfdr.de>; Mon, 18 Sep 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240086AbjIRLcN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 18 Sep 2023 07:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241728AbjIRLbu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 18 Sep 2023 07:31:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EA491B0;
        Mon, 18 Sep 2023 04:30:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24050C15;
        Mon, 18 Sep 2023 04:31:13 -0700 (PDT)
Received: from cam-smtp0.cambridge.arm.com (e126645.nice.arm.com [10.34.100.121])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 942F13F67D;
        Mon, 18 Sep 2023 04:30:34 -0700 (PDT)
From:   Pierre Gondois <pierre.gondois@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, vschneid@redhat.com,
        Pierre Gondois <pierre.gondois@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Rebuild sched-domains when removing cpufreq driver
Date:   Mon, 18 Sep 2023 13:29:36 +0200
Message-Id: <20230918112937.493352-2-pierre.gondois@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230918112937.493352-1-pierre.gondois@arm.com>
References: <20230918112937.493352-1-pierre.gondois@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Energy Aware Scheduler (EAS) relies on the schedutil governor.
When moving to/from the schedutil governor, sched domains must be
rebuilt to allow re-evaluating the enablement conditions of EAS.
This is done through sched_cpufreq_governor_change().

Having a cpufreq governor assumes having a cpufreq driver running.
Inserting/removing a cpufreq driver should trigger a re-evaluation
of EAS enablement conditions, avoiding to see EAS enabled when
removing a running cpufreq driver.

Add a sched_cpufreq_governor_change() call in cpufreq driver removal
path.

Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 60ed89000e82..0a4979c34fd1 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1673,6 +1673,8 @@ static void __cpufreq_offline(unsigned int cpu, struct cpufreq_policy *policy)
 		cpufreq_driver->exit(policy);
 		policy->freq_table = NULL;
 	}
+
+	sched_cpufreq_governor_change(policy, policy->governor);
 }
 
 static int cpufreq_offline(unsigned int cpu)
-- 
2.25.1

