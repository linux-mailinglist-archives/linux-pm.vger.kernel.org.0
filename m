Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7067F6B534
	for <lists+linux-pm@lfdr.de>; Wed, 17 Jul 2019 05:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfGQD5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 16 Jul 2019 23:57:37 -0400
Received: from mxhk.zte.com.cn ([63.217.80.70]:48510 "EHLO mxhk.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbfGQD5h (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Jul 2019 23:57:37 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 5AE79B2E9F7A54F96F16;
        Wed, 17 Jul 2019 11:57:35 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x6H3vDmB027532;
        Wed, 17 Jul 2019 11:57:13 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019071711572903-2389314 ;
          Wed, 17 Jul 2019 11:57:29 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     rjw@rjwysocki.net
Cc:     viresh.kumar@linaro.org, linuxppc-dev@lists.ozlabs.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v7] cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()
Date:   Wed, 17 Jul 2019 11:55:04 +0800
Message-Id: <1563335704-25562-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-17 11:57:29,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-17 11:57:16,
        Serialize complete at 2019-07-17 11:57:16
X-MAIL: mse-fl1.zte.com.cn x6H3vDmB027532
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpu variable is still being used in the of_get_property() call
after the of_node_put() call, which may result in use-after-free.

Fixes: a9acc26b75f6 ("cpufreq/pasemi: fix possible object reference leak")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
v7: adapt to commit ("cpufreq: Make cpufreq_generic_init() return void")
v6: keep the blank line and fix warning: label 'out_unmap_sdcpwr' defined but not used.
v5: put together the code to get, use, and release cpu device_node.
v4: restore the blank line.
v3: fix a leaked reference.
v2: clean up the code according to the advice of viresh.

 drivers/cpufreq/pasemi-cpufreq.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 93f39a1..c66f566 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -131,10 +131,18 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	int err = -ENODEV;
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
+	if (!cpu)
+		goto out;
 
+	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
 	of_node_put(cpu);
-	if (!cpu)
+	if (!max_freqp) {
+		err = -EINVAL;
 		goto out;
+	}
+
+	/* we need the freq in kHz */
+	max_freq = *max_freqp / 1000;
 
 	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
 	if (!dn)
@@ -171,16 +179,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	}
 
 	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
-
-	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
-	if (!max_freqp) {
-		err = -EINVAL;
-		goto out_unmap_sdcpwr;
-	}
-
-	/* we need the freq in kHz */
-	max_freq = *max_freqp / 1000;
-
 	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
 	pr_debug("initializing frequency table\n");
 
@@ -199,9 +197,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
 	return 0;
 
-out_unmap_sdcpwr:
-	iounmap(sdcpwr_mapbase);
-
 out_unmap_sdcasr:
 	iounmap(sdcasr_mapbase);
 out:
-- 
2.9.5

