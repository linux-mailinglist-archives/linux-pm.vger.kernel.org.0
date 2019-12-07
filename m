Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94FB4115E31
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2019 20:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfLGTbd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 7 Dec 2019 14:31:33 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:43511 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726489AbfLGTbd (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 7 Dec 2019 14:31:33 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47Vfdk0r78zFc;
        Sat,  7 Dec 2019 20:28:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1575746938; bh=bz/RFAQz0L7Cvrw8unbCiXzOKkR3SU5Qf1fBd8CntZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QbVMjENKVavMC63zT+xjuEbOmdRz64uTBpSrnk0KKYJZSD/vGbkoK6zM3TG4h6vQM
         kX4hggbNTaWAFcTEgjJ2Gmzh4gu2Wvw+JOO2qv9lKqAMA/IqBnep2qad0fBwnAW0z2
         jhCnhLkcOJFvh1lonEWQ/IiNixZKQBI/IzyXrsADSnBSM6HdT1c9G6mVTbtXBSBz03
         ivUcG8DJBJlFq9IpPO3+sRl7uvdJEzhsN9fZExA6TccjDMzVEz3ythzvX8nDgZDIXo
         iNSbJuaYpe9D3HoP7A8uMXIoiCeifyXUKViurzcZQUF8kr8YLAl8BZPau0LSIQbBkI
         ku2jTq7Z9ftAA==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 7 Dec 2019 20:31:28 +0100
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 00/19] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20191207193128.GB19924@qmqm.qmqm.pl>
References: <20191203004116.11771-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191203004116.11771-1-digetx@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Dec 03, 2019 at 03:40:57AM +0300, Dmitry Osipenko wrote:
> Hello,
> 
> This series does the following:
> 
>   1. Unifies Tegra20/30/114 drivers into a single driver and moves it out
>      into common drivers/cpuidle/ directory.
> 
>   2. Enables CPU cluster power-down idling state on Tegra30.
> 
> In the end there is a quite nice clean up of the Tegra CPUIDLE drivers
> and of the Tegra's arch code in general. Please review, thanks!
> 
> Changelog:
> 
> v8: - Rebased on recent linux-next, now making use of
>       cpuidle_driver_state_disabled(). [...]

Dear Dmitry

This rebase was not complete, at least in patch 14 direct access to
.disabled field (now removed in Linus' master) are left. The fixups
needed are below (only compile-tested for now).

Best Regards,
Micha³ Miros³aw

diff --git a/drivers/cpuidle/cpuidle-tegra.c b/drivers/cpuidle/cpuidle-tegra.c
index 077ff15e32fb..2d325d3aab57 100644
--- a/drivers/cpuidle/cpuidle-tegra.c
+++ b/drivers/cpuidle/cpuidle-tegra.c
@@ -306,13 +306,12 @@ static struct cpuidle_driver tegra_idle_driver = {
  */
 void tegra_cpuidle_pcie_irqs_in_use(void)
 {
-	if (tegra_idle_driver.states[TEGRA_CC6].disabled ||
+	if ((tegra_idle_driver.states[TEGRA_CC6].flags & CPUIDLE_FLAG_UNUSABLE) &&
 	    tegra_get_chip_id() != TEGRA20)
 		return;
 
 	pr_info("disabling CC6 state, since PCIe IRQs are in use\n");
 	cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_CC6, true);
-	tegra_idle_driver.states[TEGRA_CC6].disabled = true;
 }
 
 static void tegra_cpuidle_setup_tegra114_c7_state(void)
@@ -328,7 +327,7 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 {
 	/* LP2 could be disabled in device-tree */
 	if (tegra_pmc_get_suspend_mode() < TEGRA_SUSPEND_LP2)
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+		cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_CC6, true);
 
 	/*
 	 * Required suspend-resume functionality, which is provided by the
@@ -337,9 +336,9 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 	 */
 	if (!IS_ENABLED(CONFIG_PM_SLEEP)) {
 		if (!tegra_cpuidle_using_firmware())
-			tegra_idle_driver.states[TEGRA_C7].disabled = true;
+			cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_C7, true);
 
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+		cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_CC6, true);
 	}
 
 	/*
@@ -349,7 +348,7 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 	switch (tegra_get_chip_id()) {
 	case TEGRA20:
 		/* Tegra20 isn't capable to power-off individual CPU cores */
-		tegra_idle_driver.states[TEGRA_C7].disabled = true;
+		cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_C7, true);
 		break;
 	case TEGRA30:
 		break;
@@ -358,7 +357,7 @@ static int tegra_cpuidle_probe(struct platform_device *pdev)
 		tegra_cpuidle_setup_tegra114_c7_state();
 
 		/* coupled CC6 (LP2) state isn't implemented yet */
-		tegra_idle_driver.states[TEGRA_CC6].disabled = true;
+		cpuidle_driver_state_disabled(&tegra_idle_driver, TEGRA_CC6, true);
 		break;
 	default:
 		return -EINVAL;
