Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34EA161BF3
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 10:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbfGHIwC (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 04:52:02 -0400
Received: from mx7.zte.com.cn ([202.103.147.169]:36526 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728884AbfGHIwC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 04:52:02 -0400
Received: from mse-fl2.zte.com.cn (unknown [10.30.14.239])
        by Forcepoint Email with ESMTPS id D496EBE0043BE622BB03;
        Mon,  8 Jul 2019 16:51:58 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl2.zte.com.cn with ESMTP id x688oVnj044240;
        Mon, 8 Jul 2019 16:50:31 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070816503612-2168893 ;
          Mon, 8 Jul 2019 16:50:36 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: [PATCH v3] cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()
Date:   Mon, 8 Jul 2019 16:48:46 +0800
Message-Id: <1562575726-17438-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-08 16:50:36,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-08 16:50:33,
        Serialize complete at 2019-07-08 16:50:33
X-MAIL: mse-fl2.zte.com.cn x688oVnj044240
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
v3: fix a leaked reference.
v2: clean up the code according to the advice of viresh.

 drivers/cpufreq/pasemi-cpufreq.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 6b1e4ab..9dc5163 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -128,20 +128,20 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	int cur_astate, idx;
 	struct resource res;
 	struct device_node *cpu, *dn;
-	int err = -ENODEV;
+	int err;
 
 	cpu = of_get_cpu_node(policy->cpu, NULL);
-
-	of_node_put(cpu);
 	if (!cpu)
-		goto out;
+		return -ENODEV;
 
 	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
 	if (!dn)
 		dn = of_find_compatible_node(NULL, NULL,
 					     "pasemi,pwrficient-sdc");
-	if (!dn)
+	if (!dn) {
+		err = -ENODEV;
 		goto out;
+	}
 	err = of_address_to_resource(dn, 0, &res);
 	of_node_put(dn);
 	if (err)
@@ -196,6 +196,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = pas_freqs[cur_astate].frequency;
 	ppc_proc_freq = policy->cur * 1000ul;
 
+	of_node_put(cpu);
 	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
 
 out_unmap_sdcpwr:
@@ -204,6 +205,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 out_unmap_sdcasr:
 	iounmap(sdcasr_mapbase);
 out:
+	of_node_put(cpu);
 	return err;
 }
 
-- 
2.9.5

