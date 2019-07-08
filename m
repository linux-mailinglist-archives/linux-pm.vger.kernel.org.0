Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6B2B61B2D
	for <lists+linux-pm@lfdr.de>; Mon,  8 Jul 2019 09:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfGHHW2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Jul 2019 03:22:28 -0400
Received: from out1.zte.com.cn ([202.103.147.172]:55460 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfGHHW2 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 8 Jul 2019 03:22:28 -0400
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
        by Forcepoint Email with ESMTPS id 78FEA70C0DB74843A8DB;
        Mon,  8 Jul 2019 15:22:24 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse-fl1.zte.com.cn with ESMTP id x687LdCc099165;
        Mon, 8 Jul 2019 15:21:39 +0800 (GMT-8)
        (envelope-from wen.yang99@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019070815214328-2166275 ;
          Mon, 8 Jul 2019 15:21:43 +0800 
From:   Wen Yang <wen.yang99@zte.com.cn>
To:     linux-kernel@vger.kernel.org
Cc:     xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn,
        cheng.shengyu@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: [PATCH v2] cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()
Date:   Mon, 8 Jul 2019 15:19:53 +0800
Message-Id: <1562570393-8684-1-git-send-email-wen.yang99@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-07-08 15:21:43,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-07-08 15:21:40,
        Serialize complete at 2019-07-08 15:21:40
X-MAIL: mse-fl1.zte.com.cn x687LdCc099165
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
v2: clean up the code according to the advice of viresh.

 drivers/cpufreq/pasemi-cpufreq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
index 6b1e4ab..c6d464b 100644
--- a/drivers/cpufreq/pasemi-cpufreq.c
+++ b/drivers/cpufreq/pasemi-cpufreq.c
@@ -128,20 +128,18 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
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
 	if (!dn)
-		goto out;
+		return -ENODEV;
 	err = of_address_to_resource(dn, 0, &res);
 	of_node_put(dn);
 	if (err)
@@ -196,6 +194,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	policy->cur = pas_freqs[cur_astate].frequency;
 	ppc_proc_freq = policy->cur * 1000ul;
 
+	of_node_put(cpu);
 	return cpufreq_generic_init(policy, pas_freqs, get_gizmo_latency());
 
 out_unmap_sdcpwr:
@@ -204,6 +203,7 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
 out_unmap_sdcasr:
 	iounmap(sdcasr_mapbase);
 out:
+	of_node_put(cpu);
 	return err;
 }
 
-- 
2.9.5

