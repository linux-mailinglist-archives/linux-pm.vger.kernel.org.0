Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C324BBFF
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 14:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgHTMhd (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 08:37:33 -0400
Received: from foss.arm.com ([217.140.110.172]:38048 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729539AbgHTMhW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 08:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A69C30E;
        Thu, 20 Aug 2020 05:37:21 -0700 (PDT)
Received: from bogus (unknown [10.37.8.132])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E62643F66B;
        Thu, 20 Aug 2020 05:37:18 -0700 (PDT)
Date:   Thu, 20 Aug 2020 13:37:11 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sumit Gupta <sumitg@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, linux-pm@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, bbasu@nvidia.com,
        wangkefeng.wang@huawei.com, Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [Patch] cpufreq: replace cpu_logical_map with read_cpuid_mpir
Message-ID: <20200820123711.GA19989@bogus>
References: <1597174997-22505-1-git-send-email-sumitg@nvidia.com>
 <20200820053945.xlwtpkvbt4o23flk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820053945.xlwtpkvbt4o23flk@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 20, 2020 at 11:09:45AM +0530, Viresh Kumar wrote:
> On 12-08-20, 01:13, Sumit Gupta wrote:
> > Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
> > fixes the issue with building tegra194 cpufreq driver as module. But
> > the fix might cause problem while supporting physical cpu hotplug[1].
> > 
> > This patch fixes the original problem by avoiding use of cpu_logical_map().
> > Instead calling read_cpuid_mpidr() to get MPIDR on target cpu.
> > 
> > [1] https://lore.kernel.org/linux-arm-kernel/20200724131059.GB6521@bogus/
> > 
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> > ---
> >  drivers/cpufreq/tegra194-cpufreq.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> Applied. Thanks.

Just to confirm, is this going as a fix ? We want to drop exporting
cpu_logical_map in v5.9 so this needs to go as fix. I missed it earlier,
actually,

Fixes: df320f89359c ("cpufreq: Add Tegra194 cpufreq driver")
is appropriate here so that we can drop export symbol which was part of
Commit eaecca9e7710 ("arm64: Fix __cpu_logical_map undefined issue")
as a workaround to  fix the build.

-- 
Regards,
Sudeep
