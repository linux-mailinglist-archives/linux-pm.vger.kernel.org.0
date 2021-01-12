Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969C02F2EE7
	for <lists+linux-pm@lfdr.de>; Tue, 12 Jan 2021 13:20:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732686AbhALMT4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 12 Jan 2021 07:19:56 -0500
Received: from foss.arm.com ([217.140.110.172]:45106 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732618AbhALMTz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 12 Jan 2021 07:19:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D06D31042;
        Tue, 12 Jan 2021 04:19:09 -0800 (PST)
Received: from localhost (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71ADC3F66E;
        Tue, 12 Jan 2021 04:19:09 -0800 (PST)
Date:   Tue, 12 Jan 2021 12:19:08 +0000
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: qcom-hw: add missing devm_release_mem_region()
 call
Message-ID: <20210112121859.GA25733@arm.com>
References: <20210112095236.20515-1-shawn.guo@linaro.org>
 <20210112101449.cmkjaegukxut3tym@vireshk-i7>
 <20210112111928.GB2479@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112111928.GB2479@dragon>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi guys,

On Tuesday 12 Jan 2021 at 19:19:29 (+0800), Shawn Guo wrote:
> On Tue, Jan 12, 2021 at 03:44:49PM +0530, Viresh Kumar wrote:
> > On 12-01-21, 17:52, Shawn Guo wrote:
> > > On SDM845/850, running the following commands to put all cores in
> > > freq-domain1 offline and then get one core back online, there will be
> > > a request region error seen from qcom-hw driver.
> > > 
> > > $ echo 0 > /sys/devices/system/cpu/cpu4/online
> > > $ echo 0 > /sys/devices/system/cpu/cpu5/online
> > > $ echo 0 > /sys/devices/system/cpu/cpu6/online
> > > $ echo 0 > /sys/devices/system/cpu/cpu7/online
> > > $ echo 1 > /sys/devices/system/cpu/cpu4/online
> > > 
> > > [ 3395.915416] CPU4: shutdown
> > > [ 3395.938185] psci: CPU4 killed (polled 0 ms)
> > > [ 3399.071424] CPU5: shutdown
> > > [ 3399.094316] psci: CPU5 killed (polled 0 ms)
> > > [ 3402.139358] CPU6: shutdown
> > > [ 3402.161705] psci: CPU6 killed (polled 0 ms)
> > > [ 3404.742939] CPU7: shutdown
> > > [ 3404.765592] psci: CPU7 killed (polled 0 ms)
> > > [ 3411.492274] Detected VIPT I-cache on CPU4
> > > [ 3411.492337] GICv3: CPU4: found redistributor 400 region 0:0x0000000017ae0000
> > > [ 3411.492448] CPU4: Booted secondary processor 0x0000000400 [0x516f802d]
> > > [ 3411.503654] qcom-cpufreq-hw 17d43000.cpufreq: can't request region for resource [mem 0x17d45800-0x17d46bff]
> > > 
> > > The cause is that the memory region requested in .init hook doesn't get
> > > released in .exit hook, and the subsequent call to .init will always fail
> > > on this error.  Let's break down the devm_platform_ioremap_resource()
> > > call a bit, so that we can have the resource pointer to release memory
> > > region from .exit hook.
> > > 
> > > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > > ---
> > >  drivers/cpufreq/qcom-cpufreq-hw.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > FWIW, Ionela also sent a fix though I like this one better for the
> > obvious reasons.
> > 
> > https://lore.kernel.org/lkml/20210108151406.23595-1-ionela.voinescu@arm.com/
> 
> Ha, thanks for the pointer.  So the original code was tricky and skipped
> the region request call intentionally.
> 

As long as the problem is fixed, I'm happy :).
For this patch:
Tested-by: Ionela Voinescu <ionela.voinescu@arm.com>

The patch probably deserves:
Fixes: f17b3e44320b ("cpufreq: qcom-hw: Use devm_platform_ioremap_resource() to simplify code")

Thanks,
Ionela.

> Shawn
