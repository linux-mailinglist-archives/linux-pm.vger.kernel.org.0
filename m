Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEAAD114FCD
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2019 12:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbfLFLdw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 6 Dec 2019 06:33:52 -0500
Received: from comms.puri.sm ([159.203.221.185]:46516 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726088AbfLFLdw (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 6 Dec 2019 06:33:52 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 360A0DFE25;
        Fri,  6 Dec 2019 03:33:51 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8GWJpsWM_QVg; Fri,  6 Dec 2019 03:33:50 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     daniel.lezcano@linaro.org, edubezval@gmail.com, rui.zhang@intel.com
Cc:     rjw@rjwysocki.net, linux-pm@vger.kernel.org,
        viresh.kumar@linaro.org, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: Re: [PATCH V4 4/4] thermal/drivers/cpu_cooling: Rename to cpufreq_cooling
Date:   Fri,  6 Dec 2019 12:33:15 +0100
Message-Id: <20191206113315.18954-1-martin.kepplinger@puri.sm>
In-Reply-To: <20191204153930.9128-4-daniel.lezcano@linaro.org>
References: <20191204153930.9128-4-daniel.lezcano@linaro.org>
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

I tested this on the librem5-devkit and see the
cooling devices in sysfs. I configure ARM_PSCI_CPUIDLE, not ARM_CPUIDLE and
add the patch below in register the cooling device there. "psci_idle"
is listed as the cpuidle_driver.

That's what I'm running, in case you want to see it all:
https://source.puri.sm/martin.kepplinger/linux-next/commits/next-20191205/librem5_cpuidle_mainline_atf

so I add a trip temperature description like this:
https://source.puri.sm/martin.kepplinger/linux-next/commit/361f49f93ae2c477fd012790831cabd0ed976660

When I let the SoC heat up, cpuidle cooling won't kick it. In sysfs:

catting the relevant files in /sys/class/thermal after heating up,
if that makes sense:

87000
85000
85000
thermal-cpufreq-0
1
thermal-idle-0
0
thermal-idle-1                                                                  
0                                                                               
thermal-idle-2
0
thermal-idle-3
0

with ARM_CPUIDLE instead of ARM_PSCI_CPUIDLE (and registering the cooling dev
during cpuidle-arm.c init) I won't have a cpuidle driver and thus no cpu-sleep
state at all.

Can you see where the problem here lies?

thanks!

                                    martin

---
 drivers/cpuidle/cpuidle-psci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index f3c1a2396f98..de6e7f444a66 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) "CPUidle PSCI: " fmt
 
+#include <linux/cpu_cooling.h>
 #include <linux/cpuidle.h>
 #include <linux/cpumask.h>
 #include <linux/cpu_pm.h>
@@ -195,6 +196,8 @@ static int __init psci_idle_init_cpu(int cpu)
 	if (ret)
 		goto out_kfree_drv;
 
+	cpuidle_cooling_register(drv);
+
 	return 0;
 
 out_kfree_drv:
-- 
2.20.1

