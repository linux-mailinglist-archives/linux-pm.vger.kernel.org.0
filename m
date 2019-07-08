Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53A5161A94
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 08:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbfGHGVV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 02:21:21 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:33566 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727218AbfGHGVV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 02:21:21 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id 1553A895BBB8E99657FC;
        Mon,  8 Jul 2019 14:21:16 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x686Klnf049223;
        Mon, 8 Jul 2019 14:20:47 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070814205103-2164426 ;
          Mon, 8 Jul 2019 14:20:51 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()
Date:   Mon, 8 Jul 2019 14:19:02 +0800
Message-Id: <1562566745-7447-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-08 14:20:51,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-08 14:20:48,
        Serialize complete at 2019-07-08 14:20:48
X-MAIL: mse-fl2.zte.com.cn x686Klnf049223
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The cpu variable is still being used in the of_get_property() call
after the of_node_put() call, which may result in use-after-free.

Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/cpufreq/pasemi-cpufreq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 6b1e4ab..d2dd47b 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -132,7 +132,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
 
-	of_node_put(cpu);
 	if (!cpu)
 		goto out;
 
@@ -141,15 +140,15 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		dn = of_find_compatible_node(NULL, NULL,
 					     "pasemi,pwrficient-sdc");
 	if (!dn)
-		goto out;
+		goto out_put_cpu_node;
 	err = of_address_to_resource(dn, 0, &res);
 	of_node_put(dn);
 	if (err)
-		goto out;
+		goto out_put_cpu_node;
 	sdcasr_mapbase = ioremap(res.start + SDCASR_OFFSET, 0x2000);
 	if (!sdcasr_mapbase) {
 		err = -EINVAL;
-		goto out;
+		goto out_put_cpu_node;
 	}
 
 	dn = of_find_compatible_node(NULL, NULL, "1682m-gizmo");
@@ -177,6 +176,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 		err = -EINVAL;
 		goto out_unmap_sdcpwr;
 	}
+	of_node_put(cpu);
 
 	/* we need the freq in kHz */
 	max_freq = *max_freqp / 1000;
@@ -203,6 +203,8 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 
 out_unmap_sdcasr:
 	iounmap(sdcasr_mapbase);
+out_put_cpu_node:
+	of_node_put(cpu);
 out:
 	return err;
 }
-- 
2.9.5

