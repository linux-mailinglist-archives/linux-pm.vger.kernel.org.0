Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B93A2AD478
	for <lists+linux-pm@lfdr.de>; Tue, 10 Nov 2020 12:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgKJLKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 10 Nov 2020 06:10:49 -0500
Received: from foss.arm.com ([217.140.110.172]:54036 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726152AbgKJLKt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 10 Nov 2020 06:10:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE3D12FC;
        Tue, 10 Nov 2020 03:10:48 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56A0C3F6CF;
        Tue, 10 Nov 2020 03:10:47 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: scmi: Fix OPP addition failure with a dummy clock provider
Date:   Tue, 10 Nov 2020 11:10:40 +0000
Message-Id: <20201110111040.280231-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
-EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
_allocate_opp_table() which is called from dev_pm_opp_add and it
now propagates the error back to the caller.

SCMI performance domain re-used clock bindings to keep it simple. However
with the above mentioned change, if clock property is present in a device
node, opps fails to get added with below errors until clk_get succeeds.

 cpu0: failed to add opp 450000000Hz
 cpu0: failed to add opps to the device
 ....(errors on cpu1-cpu4)
 cpu5: failed to add opp 450000000Hz
 cpu5: failed to add opps to the device

So, in order to fix the issue, we need to register dummy clock provider.
With the dummy clock provider, clk_get returns NULL(no errors!), then opp
core proceeds to add OPPs for the CPUs.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index e855e8612a67..78318508a6d6 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -8,6 +8,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/clk-provider.h>
 #include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask.h>
@@ -228,12 +229,17 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
 static int scmi_cpufreq_probe(struct scmi_device *sdev)
 {
 	int ret;
+	struct device *dev = &sdev->dev;
 
 	handle = sdev->handle;
 
 	if (!handle || !handle->perf_ops)
 		return -ENODEV;
 
+	/* dummy clock provider as needed by OPP if clocks property is used */
+	if (of_find_property(dev->of_node, "#clock-cells", NULL))
+		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+
 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
 	if (ret) {
 		dev_err(&sdev->dev, "%s: registering cpufreq failed, err: %d\n",
-- 
2.25.1

