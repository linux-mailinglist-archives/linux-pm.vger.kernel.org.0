Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69B0C2D3EFE
	for <lists+linux-pm@lfdr.de>; Wed,  9 Dec 2020 10:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbgLIJmP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 9 Dec 2020 04:42:15 -0500
Received: from foss.arm.com ([217.140.110.172]:60134 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbgLIJmP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 9 Dec 2020 04:42:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C3F21FB;
        Wed,  9 Dec 2020 01:41:29 -0800 (PST)
Received: from bogus (unknown [10.57.54.168])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B1E13F718;
        Wed,  9 Dec 2020 01:41:26 -0800 (PST)
Date:   Wed, 9 Dec 2020 09:41:21 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Nicola Mazzucato <nicola.mazzucato@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        rjw@rjwysocki.net, vireshk@kernel.org, robh+dt@kernel.org,
        sboyd@kernel.org, nm@ti.com, daniel.lezcano@linaro.org,
        morten.rasmussen@arm.com, chris.redpath@arm.com
Subject: Re: [PATCH v4 3/4] scmi-cpufreq: get opp_shared_cpus from opp-v2 for
 EM
Message-ID: <20201209094121.b6jloegdzpmcphqz@bogus>
References: <20201202172356.10508-1-nicola.mazzucato@arm.com>
 <20201202172356.10508-4-nicola.mazzucato@arm.com>
 <20201208055053.kggxw26kxtnpneua@vireshk-i7>
 <0e4d3134-f9b2-31fa-b454-fb30265a80b5@arm.com>
 <20201208072611.ptsqupv4y2wybs6p@vireshk-i7>
 <20201208112008.niesjrunxq2jz3kt@bogus>
 <20201209054502.ajomw6glcxx5hue2@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209054502.ajomw6glcxx5hue2@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Dec 09, 2020 at 11:15:02AM +0530, Viresh Kumar wrote:
> On 08-12-20, 11:20, Sudeep Holla wrote:
> > It is because of per-CPU vs per domain drama here. Imagine a system with
> > 4 CPUs which the firmware puts in individual domains while they all are
> > in the same perf domain and hence OPP is marked shared in DT.
> >
> > Since this probe gets called for all the cpus, we need to skip adding
> > OPPs for the last 3(add only for 1st one and mark others as shared).
>
> Okay and this wasn't happening before this series because the firmware
> was only returning the current CPU from scmi_get_sharing_cpus() ?
>
> Is this driver also used for the cases where we have multiple CPUs in
> a policy ? Otherwise we won't be required to call
> dev_pm_opp_set_sharing_cpus().
>
> So I assume that we want to support both the cases here ?
>

Yes indeed, completely depends on what granularity firmware provides the
performance control. It could be individual CPUs, could be pair of CPUs
(or all the threads in the core) or subset of CPUs in the performance
domain. The subset could be full set.

> > If we attempt to add OPPs on second cpu probe, it *will* shout as duplicate
> > OPP as we would have already marked it as shared table with the first cpu.
> > Am I missing anything ? I suggested this as Nicola saw OPP duplicate
> > warnings when he was hacking up this patch.
>
> The common stuff (for all the CPUs) is better moved to probe() in this
> case, instead of the ->init() callback. Otherwise it will always be
> messy. You can initialize the OPP and cpufreq tables in probe()
> itself, save the pointer somewhere and then just use it here in
> ->init().
>
> Also do EM registration from there.
>

Makes sense.

--
Regards,
Sudeep
