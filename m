Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C398D99E9
	for <lists+linux-pm@lfdr.de>; Wed, 16 Oct 2019 21:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436628AbfJPTVh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Oct 2019 15:21:37 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:3226 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403782AbfJPTVh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Oct 2019 15:21:37 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5da76dc50000>; Wed, 16 Oct 2019 12:21:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 16 Oct 2019 12:21:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 16 Oct 2019 12:21:36 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Oct
 2019 19:21:36 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 16 Oct 2019 19:21:35 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id 9AE2542807; Wed, 16 Oct 2019 22:21:33 +0300 (EEST)
Date:   Wed, 16 Oct 2019 22:21:33 +0300
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Daniel Lezcano" <daniel.lezcano@linaro.org>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/18] Consolidate and improve NVIDIA Tegra CPUIDLE
 driver(s)
Message-ID: <20191016192133.GB26038@pdeschrijver-desktop.Nvidia.com>
References: <20191015170015.1135-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191015170015.1135-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1571253701; bh=nroN3FHoFwV3XA6q1YkfsgkTextLKDHjNycGp27ezdc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=rAGYy4mB0DojFGY14D9t5hauU3YDyjKaDWJhazpYwapaylHOMWi9QJXublk3LJA2O
         mVVV+r0Nq5wtadsbN1yC5THHsPkRxV35P/1gPPkEIEPBOajMwjafab7MIb4yzvq7CK
         jzO2SzAWmwc5A+siqUD9bwWi5vFAyksQzsIQqveEFNBY8R3/g6+VYn2MbGHxR1sZ0l
         55Tp5fjEsm4JXY9dyaXXsVGONqefshME6VNEKE7aJtww7vBcV6hg3LbJA49bg+qf5f
         yHFE9vIT1X92IxipB6xxW8M1yZxMP93Ih8okg1l5odob8/z+SOI/qGlDLUXb8zJk98
         H4FzTWA6TrQwA==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Oct 15, 2019 at 07:59:57PM +0300, Dmitry Osipenko wrote:
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
> v6: - Addressed request from Thierry Reding to change the way patches are
>       organized by making changes in a more incremental manner.
> 
>     - tegra_sleep_cpu() now checks for the secondary CPUs to be offline
>       in the "Make outer_disable() open-coded" patch.
> 
> v5: - Rebased on a recent linux-next, fixed one minor conflict in Kconfig.
> 
>     - Improved commit's message of the "Support CPU cluster power-down state
>       on Tegra30" patch.
> 
>     - The "Support CPU cluster power-down state on Tegra30" patch is also
>       got split and now there is additional "Make outer_disable() open-coded"
>       patch.
> 
>     - Made minor cosmetic changes to the "Introduce unified driver for
>       NVIDIA Tegra SoCs" patch by improving error message and renaming
>       one variable.
> 
> v4: - Fixed compilation with !CONFIG_CACHE_L2X0 (and tested that it still
>       works).
> 
>     - Replaced ktime_compare() with ktime_before() in the new driver,
>       for consistency.
> 
> v3: - Addressed review comments that were made by Jon Hunter to v2 by
>       splitting patches into smaller (and simpler) chunks, better
>       documenting changes in the commit messages and using proper error
>       codes in the code.
> 
>       Warnings are replaced with a useful error messages in the code of
>       "Introduce unified driver for NVIDIA Tegra SoCs" patch.
> 
>       Secondary CPUs parking timeout increased to 100ms because I found
>       that it actually may happen to take more than 1ms if CPU is running
>       on a *very* low frequency.
> 
>       Added diagnostic messages that are reporting Flow Controller state
>       when CPU parking fails.
> 
>       Further polished cpuidle driver's code.
> 
>       The coupled state entering is now aborted if there is a pending SGI
>       (Software Generated Interrupt) because it will be lost after GIC's
>       power-cycling. Like it was done by the old Tegra20 CPUIDLE driver.
> 
> v2: - Added patches to enable the new cpuidle driver in the defconfigs:
> 
>         ARM: multi_v7_defconfig: Enable Tegra cpuidle driver
>         ARM: tegra: Enable Tegra cpuidle driver in tegra_defconfig
> 
>     - Dropped patches that removed CPUIDLE_FLAG_TIMER_STOP from the idling
>       states because that flag actually doesn't have any negative effects,
>       but still is correct for the case of a local CPU timer on older Tegra
>       SoCs:
> 
>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from Tegra114/124 idle-state
>         cpuidle: tegra: Remove CPUIDLE_FLAG_TIMER_STOP from all states
> 
>     - The "Add unified driver for NVIDIA Tegra SoCs" patch got more polish.
>       Tegra30 and Terga114 states are now squashed into a single common C7
>       state (following Parker TRM terminology, see 17.2.2.2 Power Management
>       States), more comments added, etc minor changes.

It would be useful to switch the power state terminology to the one used
for later chips:

LP0 becomes SC7
LP1 becomes C1
LP2 becomes CC7

Meaning of these states is as follows

C is a core state:

C1 clock gating
C2 not defined
C3 not defined
C4 not defined
C5 not defined
C6 not defined for ARM cores
C7 power-gating

CC is a CPU cluster C state:

CC1 cluster clock gated
CC2 not defined
CC3 fmax@Vmin: not used prior to Tegra186
CC4: cluster retention: no longer supported
CC5: not defined
CC6: cluster power gating
CC7: cluster rail gating

SC is a System C state:

SC1: not defined
SC2: not defined
SC3: not defined
SC4: not defined
SC5: not defined
SC6: not defined
SC7: VDD_SOC off

Cheers,

Peter.
