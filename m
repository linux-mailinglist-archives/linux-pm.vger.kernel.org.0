Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F8635825E
	for <lists+linux-pm@lfdr.de>; Thu,  8 Apr 2021 13:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhDHLo1 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 8 Apr 2021 07:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231489AbhDHLo0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 8 Apr 2021 07:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C020D61157;
        Thu,  8 Apr 2021 11:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617882254;
        bh=kI6a5fpPOoHyR23MS8XsVVO3TkRdhqh+1vmUgjHNL+s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=cJfogXbBrmpypFTIWL/GTMDXJruMofutG8KsqXlf2sGiBDDPleo+jp4Vw7GJOHzLK
         pjT7w2I9TqORWTS3ig/6MILJ55+O6gE95SZU48eDqZRRRgfzfYGsNsxZAzY7yhYhDI
         LPqkokCjaj2wAuvxHPauMsCnYbUhbh+8Aa3S9/rNkhg3W+bodkx8bv1JO66ljhvtJH
         lpZfljjSdDo6agWhQiiLIak7lIkdeXH45TQ2apSmB0l3vl0BmO4yVtcEf/xST+Tg7E
         pngFkySZIpTaHlDGEGTK4mIYyUrgArpSCnWNfQMLqhHWtAzhZSJZ27fVILSfYURynl
         iqp0WWuqD/UIg==
Received: by pali.im (Postfix)
        id 10AD6EBC; Thu,  8 Apr 2021 13:44:13 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RESEND PATCH mvebu v3 10/10] cpufreq: armada-37xx: Fix module unloading
Date:   Thu,  8 Apr 2021 13:42:23 +0200
Message-Id: <20210408114223.8471-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408114223.8471-1-pali@kernel.org>
References: <20210408114223.8471-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This driver is missing module_exit hook. Add proper driver exit function
which unregisters the platform device and cleans up the data.

Signed-off-by: Pali Rohár <pali@kernel.org>
Tested-by: Tomasz Maciej Nowak <tmn505@gmail.com>
Tested-by: Anders Trier Olesen <anders.trier.olesen@gmail.com>
Tested-by: Philip Soares <philips@netisense.com>
---
 drivers/cpufreq/armada-37xx-cpufreq.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/cpufreq/armada-37xx-cpufreq.c b/drivers/cpufreq/armada-37xx-cpufreq.c
index 050abff18308..3fc98a3ffd91 100644
--- a/drivers/cpufreq/armada-37xx-cpufreq.c
+++ b/drivers/cpufreq/armada-37xx-cpufreq.c
@@ -86,6 +86,8 @@ static int avs_map[] = {
 };
 
 struct armada37xx_cpufreq_state {
+	struct platform_device *pdev;
+	struct device *cpu_dev;
 	struct regmap *regmap;
 	u32 nb_l0l1;
 	u32 nb_l2l3;
@@ -506,6 +508,9 @@ static int __init armada37xx_cpufreq_driver_init(void)
 	if (ret)
 		goto disable_dvfs;
 
+	armada37xx_cpufreq_state->cpu_dev = cpu_dev;
+	armada37xx_cpufreq_state->pdev = pdev;
+	platform_set_drvdata(pdev, dvfs);
 	return 0;
 
 disable_dvfs:
@@ -524,6 +529,26 @@ static int __init armada37xx_cpufreq_driver_init(void)
 /* late_initcall, to guarantee the driver is loaded after A37xx clock driver */
 late_initcall(armada37xx_cpufreq_driver_init);
 
+static void __exit armada37xx_cpufreq_driver_exit(void)
+{
+	struct platform_device *pdev = armada37xx_cpufreq_state->pdev;
+	struct armada_37xx_dvfs *dvfs = platform_get_drvdata(pdev);
+	unsigned long freq;
+	int load_lvl;
+
+	platform_device_unregister(pdev);
+
+	armada37xx_cpufreq_disable_dvfs(armada37xx_cpufreq_state->regmap);
+
+	for (load_lvl = ARMADA_37XX_DVFS_LOAD_0; load_lvl < LOAD_LEVEL_NR; load_lvl++) {
+		freq = dvfs->cpu_freq_max / dvfs->divider[load_lvl];
+		dev_pm_opp_remove(armada37xx_cpufreq_state->cpu_dev, freq);
+	}
+
+	kfree(armada37xx_cpufreq_state);
+}
+module_exit(armada37xx_cpufreq_driver_exit);
+
 static const struct of_device_id __maybe_unused armada37xx_cpufreq_of_match[] = {
 	{ .compatible = "marvell,armada-3700-nb-pm" },
 	{ },
-- 
2.20.1

