Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7033DED8C
	for <lists+linux-pm@lfdr.de>; Mon, 21 Oct 2019 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727322AbfJUN3B (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 21 Oct 2019 09:29:01 -0400
Received: from [217.140.110.172] ([217.140.110.172]:52642 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbfJUN3B (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 21 Oct 2019 09:29:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A339C493;
        Mon, 21 Oct 2019 06:28:30 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id D65B63F718;
        Mon, 21 Oct 2019 06:28:29 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     viresh.kumar@linaro.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, rjw@rjwysocki.net
Subject: [PATCH] cpufreq: Move cancelling of policy update work just after removing notifiers
Date:   Mon, 21 Oct 2019 14:28:18 +0100
Message-Id: <20191021132818.23787-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 099967699ad9 ("cpufreq: Cancel policy update work scheduled before freeing")
added cancel_work_sync(policy->update) after the frequency QoS were
removed. We can cancel the work just after taking the last CPU in the
policy offline and unregistering the notifiers as policy->update cannot
be scheduled from anywhere at this point.

However, due to other bugs, doing so still triggered the race between
freeing of policy and scheduled policy update work. Now that all those
issues are resolved, we can move this cancelling of any scheduled policy
update work just after removing min/max notifiers.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/cpufreq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

Hi Rafael,

Based on Viresh's suggestion, I am posting a patch to move this
cancel_work_sync earlier though it's not a must have change.
I will leave it up to your preference.

Regards,
Sudeep

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 829a3764df1b..48a224a6b178 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1268,6 +1268,9 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	freq_qos_remove_notifier(&policy->constraints, FREQ_QOS_MIN,
 				 &policy->nb_min);
 
+	/* Cancel any pending policy->update work before freeing the policy. */
+	cancel_work_sync(&policy->update);
+
 	if (policy->max_freq_req) {
 		/*
 		 * CPUFREQ_CREATE_POLICY notification is sent only after
@@ -1279,8 +1282,6 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	}
 
 	freq_qos_remove_request(policy->min_freq_req);
-	/* Cancel any pending policy->update work before freeing the policy. */
-	cancel_work_sync(&policy->update);
 	kfree(policy->min_freq_req);
 
 	cpufreq_policy_put_kobj(policy);
-- 
2.17.1

