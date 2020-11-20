Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270A92BA726
	for <lists+linux-pm@lfdr.de>; Fri, 20 Nov 2020 11:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbgKTKM6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 20 Nov 2020 05:12:58 -0500
Received: from foss.arm.com ([217.140.110.172]:46554 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgKTKM6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 20 Nov 2020 05:12:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9D41042;
        Fri, 20 Nov 2020 02:12:57 -0800 (PST)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 066DF3F70D;
        Fri, 20 Nov 2020 02:12:56 -0800 (PST)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: scmi: Fix build for !CONFIG_COMMON_CLK
Date:   Fri, 20 Nov 2020 10:12:52 +0000
Message-Id: <20201120101252.1113298-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Commit 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a
dummy clock provider") registers a dummy clock provider using
devm_of_clk_add_hw_provider. These *_hw_provider functions are defined
only when CONFIG_COMMON_CLK=y. One possible fix is to add the Kconfig
dependency, but since we plan to move away from the clock dependency
for scmi cpufreq, it is preferrable to avoid that.

Let us just conditionally compile out the offending call to
devm_of_clk_add_hw_provider. It also uses the variable 'dev' outside
of the #ifdef block to avoid build warning.

Fixes: 8410e7f3b31e ("cpufreq: scmi: Fix OPP addition failure with a dummy clock provider")
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/scmi-cpufreq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

Hi Viresh,

Addtional change to replace &sdev->dev with dev is to avoid build warning:

drivers/cpufreq/scmi-cpufreq.c: In function ‘scmi_cpufreq_probe’:
drivers/cpufreq/scmi-cpufreq.c:232:17: warning: unused variable ‘dev’ [-Wunused-variable]

Alternatively I can create a block and pull the variable in, but it looked
odd given there is possible user outside the ifdef block which I clearly
missed in the original patch.

Regards,
Sudeep

diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
index 78318508a6d6..8286205c7165 100644
--- a/drivers/cpufreq/scmi-cpufreq.c
+++ b/drivers/cpufreq/scmi-cpufreq.c
@@ -236,13 +236,15 @@ static int scmi_cpufreq_probe(struct scmi_device *sdev)
 	if (!handle || !handle->perf_ops)
 		return -ENODEV;

+#ifdef CONFIG_COMMON_CLK
 	/* dummy clock provider as needed by OPP if clocks property is used */
 	if (of_find_property(dev->of_node, "#clock-cells", NULL))
 		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
+#endif

 	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
 	if (ret) {
-		dev_err(&sdev->dev, "%s: registering cpufreq failed, err: %d\n",
+		dev_err(dev, "%s: registering cpufreq failed, err: %d\n",
 			__func__, ret);
 	}

--
2.25.1

