Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B549940B575
	for <lists+linux-pm@lfdr.de>; Tue, 14 Sep 2021 18:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhINQ5t (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Sep 2021 12:57:49 -0400
Received: from foss.arm.com ([217.140.110.172]:47238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhINQ5s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Sep 2021 12:57:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FE3531B;
        Tue, 14 Sep 2021 09:56:31 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B04E43F59C;
        Tue, 14 Sep 2021 09:56:29 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, haokexin@gmail.com, juri.lelli@redhat.com,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, james.morse@arm.com
Subject: [PATCH] cpufreq: schedutil: Destroy mutex before kobject_put() frees the memory
Date:   Tue, 14 Sep 2021 16:56:23 +0000
Message-Id: <20210914165623.18972-1-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since commit e5c6b312ce3c ("cpufreq: schedutil: Use kobject release()
method to free sugov_tunables") kobject_put() has kfree()d the
attr_set before gov_attr_set_put() returns.

kobject_put() isn't the last user of attr_set in gov_attr_set_put(),
the subsequent mutex_destroy() triggers a use-after-free:
| BUG: KASAN: use-after-free in mutex_is_locked+0x20/0x60
| Read of size 8 at addr ffff000800ca4250 by task cpuhp/2/20
|
| CPU: 2 PID: 20 Comm: cpuhp/2 Not tainted 5.15.0-rc1 #12369
| Hardware name: ARM LTD ARM Juno Development Platform/ARM Juno Development
| Platform, BIOS EDK II Jul 30 2018
| Call trace:
|  dump_backtrace+0x0/0x380
|  show_stack+0x1c/0x30
|  dump_stack_lvl+0x8c/0xb8
|  print_address_description.constprop.0+0x74/0x2b8
|  kasan_report+0x1f4/0x210
|  kasan_check_range+0xfc/0x1a4
|  __kasan_check_read+0x38/0x60
|  mutex_is_locked+0x20/0x60
|  mutex_destroy+0x80/0x100
|  gov_attr_set_put+0xfc/0x150
|  sugov_exit+0x78/0x190
|  cpufreq_offline.isra.0+0x2c0/0x660
|  cpuhp_cpufreq_offline+0x14/0x24
|  cpuhp_invoke_callback+0x430/0x6d0
|  cpuhp_thread_fun+0x1b0/0x624
|  smpboot_thread_fn+0x5e0/0xa6c
|  kthread+0x3a0/0x450
|  ret_from_fork+0x10/0x20

Swap the order of the calls.

Fixes: e5c6b312ce3c ("cpufreq: schedutil: Use kobject release() method to free sugov_tunables")
Cc: 4.7+ <stable@vger.kernel.org> # 4.7+
CC: Kevin Hao <haokexin@gmail.com>
CC: Viresh Kumar <viresh.kumar@linaro.org>
CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/cpufreq/cpufreq_governor_attr_set.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor_attr_set.c b/drivers/cpufreq/cpufreq_governor_attr_set.c
index 66b05a326910..a6f365b9cc1a 100644
--- a/drivers/cpufreq/cpufreq_governor_attr_set.c
+++ b/drivers/cpufreq/cpufreq_governor_attr_set.c
@@ -74,8 +74,8 @@ unsigned int gov_attr_set_put(struct gov_attr_set *attr_set, struct list_head *l
 	if (count)
 		return count;
 
-	kobject_put(&attr_set->kobj);
 	mutex_destroy(&attr_set->update_lock);
+	kobject_put(&attr_set->kobj);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(gov_attr_set_put);
-- 
2.30.2

