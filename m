Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEDA1EBC5
	for <lists+linux-pm@lfdr.de>; Wed, 15 May 2019 12:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbfEOKHz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 15 May 2019 06:07:55 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:39938 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfEOKHz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 15 May 2019 06:07:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C589880D;
        Wed, 15 May 2019 03:07:54 -0700 (PDT)
Received: from queper01-lin (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 456573F703;
        Wed, 15 May 2019 03:07:52 -0700 (PDT)
Date:   Wed, 15 May 2019 11:07:50 +0100
From:   Quentin Perret <quentin.perret@arm.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org,
        viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net,
        will.deacon@arm.com, catalin.marinas@arm.com,
        dietmar.eggemann@arm.com, ionela.voinescu@arm.com,
        mka@chromium.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/3] PM / EM: Expose perf domain struct
Message-ID: <20190515100748.q3t4kt72h2akdpcs@queper01-lin>
References: <20190515082318.7993-1-quentin.perret@arm.com>
 <20190515082318.7993-3-quentin.perret@arm.com>
 <0ced18eb-e424-fe6b-b11e-165a3c108170@linaro.org>
 <20190515091658.sbpg6qiovhtblqyr@queper01-lin>
 <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <698400c0-e0a4-4a86-b9df-cdb9bd683c0f@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wednesday 15 May 2019 at 11:56:30 (+0200), Daniel Lezcano wrote:
> On 15/05/2019 11:17, Quentin Perret wrote:
> > Hi Daniel,
> > 
> > On Wednesday 15 May 2019 at 11:06:18 (+0200), Daniel Lezcano wrote:
> >> On 15/05/2019 10:23, Quentin Perret wrote:
> >>> In the current state, the perf_domain struct is fully defined only when
> >>> CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
> >>> with or without that option in the thermal framework, make sure to
> >>> actually define the struct regardless of the config option. That allows
> >>> to avoid using stubbed accessor functions all the time in code paths
> >>> that use the EM.
> >>>
> >>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> >>> Signed-off-by: Quentin Perret <quentin.perret@arm.com>
> >>
> >> This patch implies the cpu cooling device can be set without the energy
> >> model.
> >>
> >> Isn't it possible to make a strong dependency for the cpu cooling device
> >> on the energy model option, add the energy model as default on arm arch
> >> and drop this patch?
> > 
> > Right, that should work too.
> > 
> >> After all, the cpu cooling is using the em framework.
> > 
> > The reason I did it that way is simply to keep things flexible. If you
> > don't compile in THERMAL_GOV_POWER_ALLOCATOR, you will never use the EM
> > for CPU thermal. So I thought it would be good to not mandate compiling
> > in ENERGY_MODEL in this case -- that should save a bit of space.
> > 
> > But TBH I don't have a strong opinion on this one, so if everybody
> > agrees it's fine to just make CPU_THERMAL depend on ENERGY_MODEL, I'm
> > happy to drop this patch and fix patch 3/3. That would indeed simplify
> > things a bit.
> 
> Ok in this case it will be better to drop the 2/3 and add a small series
> doing for the cpu_cooling.c
> 
> #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
> 
> /* structure freq */
> 
> /* power2state */
> 
> /* state2power*/
> 
> /* getrequestedpower */
> 
> /* All functions needed for the above */
> 
> #endif
> 
> static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
>         .get_max_state          = cpufreq_get_max_state,
>         .get_cur_state          = cpufreq_get_cur_state,
>         .set_cur_state          = cpufreq_set_cur_state,
> #ifdef CONFIG_THERMAL_GOV_POWER_ALLOCATOR
>         .get_requested_power    = cpufreq_get_requested_power,
>         .state2power            = cpufreq_state2power,
>         .power2state            = cpufreq_power2state,
> #endif
> };
> 
> So you don't have to care about ENERGY_MODEL to be set as
> THERMAL_GOV_POWER_ALLOCATOR depends on it.
> 
> I think the result for cpu_cooling.c will be even more cleaner with the
> em change.

OK, that works for me. I'll give it a go in v5.

Thanks !
Quentin
