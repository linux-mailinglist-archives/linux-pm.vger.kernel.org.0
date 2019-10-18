Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4396DC343
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 12:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfJRK6t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 06:58:49 -0400
Received: from [217.140.110.172] ([217.140.110.172]:34856 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1728576AbfJRK6t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 06:58:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1EB6AB6;
        Fri, 18 Oct 2019 03:58:25 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2E8C33F6C4;
        Fri, 18 Oct 2019 03:58:25 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpufreq: cancel any pending policy update work scheduled before freeing
Date:   Fri, 18 Oct 2019 11:58:15 +0100
Message-Id: <20191018105815.5714-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Schedules policy update work may end up racing with the freeing of the
policy and unregistering the driver.

One possible race is as below where the cpufreq_driver is unregistered
but the scheduled work gets executed at later stage when cpufreq_driver
is NULL(i.e. after freeing the policy and driver)

Unable to handle kernel NULL pointer dereference at virtual address 0000001c
pgd = (ptrval)
[0000001c] *pgd=80000080204003, *pmd=00000000
Internal error: Oops: 206 [#1] SMP THUMB2
Modules linked in:
CPU: 0 PID: 34 Comm: kworker/0:1 Not tainted 5.4.0-rc3-00006-g67f5a8081a4b #86
Hardware name: ARM-Versatile Express
Workqueue: events handle_update
PC is at cpufreq_set_policy+0x58/0x228
LR is at dev_pm_qos_read_value+0x77/0xac
Control: 70c5387d  Table: 80203000  DAC: fffffffd
Process kworker/0:1 (pid: 34, stack limit = 0x(ptrval))
	(cpufreq_set_policy) from (refresh_frequency_limits.part.24+0x37/0x48)
	(refresh_frequency_limits.part.24) from (handle_update+0x2f/0x38)
	(handle_update) from (process_one_work+0x16d/0x3cc)
	(process_one_work) from (worker_thread+0xff/0x414)
	(worker_thread) from (kthread+0xff/0x100)
	(kthread) from (ret_from_fork+0x11/0x28)

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

v1->v2:
	- Dropped check for work_pending as it can still be racy
	- Changed from flush_work to cancel_work_sync

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index e93cba29fbb2..8ad9c2859841 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1279,6 +1279,8 @@ static void cpufreq_policy_free(struct cpufreq_policy *policy)
 	}

 	dev_pm_qos_remove_request(policy->min_freq_req);
+	/* cancel any pending policy->update work before freeing the policy */
+	cancel_work_sync(&policy->update);
 	kfree(policy->min_freq_req);

 	cpufreq_policy_put_kobj(policy);
--
2.17.1

