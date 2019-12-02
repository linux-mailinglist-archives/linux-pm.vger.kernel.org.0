Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8067610E959
	for <lists+linux-pm@lfdr.de>; Mon,  2 Dec 2019 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfLBLLV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 2 Dec 2019 06:11:21 -0500
Received: from foss.arm.com ([217.140.110.172]:52988 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfLBLLV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 2 Dec 2019 06:11:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9783A328;
        Mon,  2 Dec 2019 03:11:20 -0800 (PST)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A53E3F68E;
        Mon,  2 Dec 2019 03:11:19 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:11:14 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 2/2] cpufreq: vexpress-spc: Switch cpumask from topology
 core to OPP sharing
Message-ID: <20191202111055.GA16058@bogus>
References: <20191128101547.519-1-sudeep.holla@arm.com>
 <20191128101547.519-2-sudeep.holla@arm.com>
 <20191129114926.GA24793@bogus>
 <20191202020146.pzjq2gtgo7rzzorx@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191202020146.pzjq2gtgo7rzzorx@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Dec 02, 2019 at 07:31:46AM +0530, Viresh Kumar wrote:
> On 29-11-19, 11:49, Sudeep Holla wrote:
> > Hi Viresh, Rafael,
> >
> > On Thu, Nov 28, 2019 at 10:15:47AM +0000, Sudeep Holla wrote:
> > > Since commit ca74b316df96 ("arm: Use common cpu_topology structure and
> > > functions.") the core cpumask has to be modified during cpu hotplug
> > > operations. So using them to set up cpufreq policy cpumask may be
> > > incorrect as it may contain only cpus that are online at that instance.
> > >
> > > Instead, we can use the cpumask setup by OPP library that contains all
> > > the cpus sharing OPP table using dev_pm_opp_get_sharing_cpus.
> > >
> > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> >
> > This can go independently via PM tree and I can take 1/2 via SoC tree
> > (as the file is being moved). The problem will be fixed only after both
> > lands, but this alone won't break the build.
>
> Yes, but it will break cpufreq for sure as shared-cpus won't be set by anyone.
>

It's already broke on hotplug :) but yes works on boot at-least.

> > Or if you guys provide
> > Ack, I can take both together via ARM SoC team. Let me know.
>
> I was planning to take them through cpufreq tree, but that fine if you can do
> that.
>

Arnd moved and compressed few folders in arch/arm/mach-*, and vexpress
was merged into versatile. Not sure if it's planned for v5.5, so to be
cautious, I preferred to take it via ARM SoC.

> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, I will take them together via ARM SoC

--
Regards,
Sudeep
