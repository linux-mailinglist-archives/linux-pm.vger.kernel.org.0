Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ACF0613AE09
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2020 16:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgANPxK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jan 2020 10:53:10 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15598 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgANPxK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jan 2020 10:53:10 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1de3d10000>; Tue, 14 Jan 2020 07:52:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 14 Jan 2020 07:53:09 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 14 Jan 2020 07:53:09 -0800
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 14 Jan
 2020 15:53:09 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id EACE642D4E; Tue, 14 Jan 2020 17:53:06 +0200 (EET)
Date:   Tue, 14 Jan 2020 17:53:06 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Peter Geis" <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Marcel Ziswiler" <marcel.ziswiler@toradex.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 00/12] NVIDIA Tegra20 CPUFreq driver major update
Message-ID: <20200114155306.GI28289@pdeschrijver-desktop.Nvidia.com>
References: <20191218202142.11717-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191218202142.11717-1-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579017169; bh=0SFkuHSJNQEdwduVKnvDRB9QOlYZ0liNb97A4TB33pc=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=RrlFg8CmwfKQXFxENsjwaShgE8D62gO5fYE0FysvL5mX+ACZBewp/hPk10HAmtqSI
         6yqAMupgvZvKjuZIxTKBeFdhC6KUzqjksyi84XoNmyrs8W3e0s0YPzP77kYO23SSSY
         /nY3h75vwdWhquByz7XC38jG2wECAw4yL8z7OrQvv3OEp7GnhLLAMtH4Lbqb+L2O57
         fT13JLGcq5myTPuKl7xoJudh2SeaUSWhsaKtyHDA4f7waTBAC2eyZd6a/cXZTwMsv/
         ZVFrhIGsViRp3nfPZvcRM4WqFQNuVl4fjJtCz03cWNl8OsQ65k/d5MuEe9khC0OQLO
         Qazs9P2hS3I2A==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Acked-By: Peter De Schrijver <pdeschrijver@nvidia.com>

On Wed, Dec 18, 2019 at 11:21:30PM +0300, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
> 
> 
> Hello,
> 
> This series moves intermediate-clk handling from tegra20-cpufreq into
> tegra-clk driver. This allows us to switch to generic cpufreq-dt driver
> which brings voltage scaling, per-hardware OPPs and Tegra30 support out
> of the box. All boards need to adopt CPU OPPs in their device-trees in
> order to get cpufreq support.
> 
> Changelog:
> 
> v6: - Dropped "cpufreq: dt-platdev: Blacklist NVIDIA Tegra20 and Tegra30 SoCs"
>       patch from the series since Viresh picked up that patch separately.
> 
>     - Added two new patches to this series:
> 
>         ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
>         ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
> 
>       Previously these patches were sent out separately from this series,
>       but it should be more consistent to include them into the series since
>       they directly relate to enabling of the cpufreq driver on Tegra30.
> 
> v5: - The "Use generic cpufreq-dt driver (Tegra30 supported now)" patch
>       is separated now into two patches by factoring out the blacklisting
>       of cpufreq-dt-platdev into a standalone patch. This is done in a
>       response to request from Jon Hunter to fix the warning splats during
>       boot that are coming from OPP core because OPPs are unavailable. The
>       OPPs will become available once tegra20-cpufreq driver will be updated
>       to support the cpufreq-dt.
> 
> v4: - Updated CCLK diagram in the "Add custom CCLK implementation" patch.
> 
>     - <linux/cpu.h> is now included in the "Use generic cpufreq-dt driver"
>       patch, for consistency.
> 
>     - Returned value of get_cpu_device() is now checked in the "Use generic
>       cpufreq-dt driver" patch, for consistency as well.
> 
> v3: - The "Add custom CCLK implementation" patch was updated in accordance
>       to the comments from Peter De Schrijver. We will not use the clock
>       skipper.
> 
>     - Re added OPPs for T30 Beaver board because Thierry has that board ;)
> 
>     - Added r-b for the "DT binding" patch from Rob Herring.
> 
> v2: - Kept modularity of the tegra20-cpufreq as was requested by Viresh Kumar
>       in a review comment to v1.
> 
>     - Added acks from Viresh Kumar.
> 
>     - Added tested-by from Nicolas Chauvet to the "trimslice" patch.
>       Nicolas told me on IRC that it works fine.
> 
>     - Fixed compilation of the "Add custom CCLK implementation" patch. The
>       error happened because v1 was based on top of yet unreviewed/unapplied
>       patch "clk: tegra: divider: Support enable-bit for Super clocks".
>       Thanks to Peter Geis for reporting the problem.
> 
>     - Replaced Tegra30 "beaver" board with "cardhu-a04" because turned out
>       that's what NVIDIA uses in the testing farm.
> 
> Dmitry Osipenko (12):
>   clk: tegra: Add custom CCLK implementation
>   clk: tegra: pll: Add pre/post rate-change hooks
>   clk: tegra: cclk: Add helpers for handling PLLX rate changes
>   clk: tegra20: Use custom CCLK implementation
>   clk: tegra30: Use custom CCLK implementation
>   ARM: tegra: Switch CPU to PLLP on resume from LP1 on Tegra30/114/124
>   ARM: tegra: Don't enable PLLX while resuming from LP1 on Tegra30
>   dt-bindings: cpufreq: Add binding for NVIDIA Tegra20/30
>   cpufreq: tegra20: Use generic cpufreq-dt driver (Tegra30 supported
>     now)
>   ARM: tegra: Create tegra20-cpufreq platform device on Tegra30
>   ARM: dts: tegra30: beaver: Set up voltage regulators for DVFS
>   ARM: dts: tegra30: beaver: Add CPU Operating Performance Points
> 
>  .../cpufreq/nvidia,tegra20-cpufreq.txt        |  56 +++++
>  arch/arm/boot/dts/tegra30-beaver.dts          |  40 +++-
>  arch/arm/mach-tegra/sleep-tegra30.S           |  18 +-
>  arch/arm/mach-tegra/tegra.c                   |   4 +
>  drivers/clk/tegra/Makefile                    |   1 +
>  drivers/clk/tegra/clk-pll.c                   |  12 +-
>  drivers/clk/tegra/clk-tegra-super-cclk.c      | 212 +++++++++++++++++
>  drivers/clk/tegra/clk-tegra20.c               |   7 +-
>  drivers/clk/tegra/clk-tegra30.c               |   6 +-
>  drivers/clk/tegra/clk.h                       |  19 +-
>  drivers/cpufreq/Kconfig.arm                   |   6 +-
>  drivers/cpufreq/tegra20-cpufreq.c             | 217 +++++-------------
>  12 files changed, 418 insertions(+), 180 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/nvidia,tegra20-cpufreq.txt
>  create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c
> 
> --
> 2.24.0
> 
