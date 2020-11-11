Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEBE2AEF20
	for <lists+linux-pm@lfdr.de>; Wed, 11 Nov 2020 12:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgKKLFR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 11 Nov 2020 06:05:17 -0500
Received: from foss.arm.com ([217.140.110.172]:47098 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgKKLFR (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 11 Nov 2020 06:05:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42892101E;
        Wed, 11 Nov 2020 03:05:16 -0800 (PST)
Received: from bogus (unknown [10.57.15.107])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D3A53F7BB;
        Wed, 11 Nov 2020 03:05:15 -0800 (PST)
Date:   Wed, 11 Nov 2020 11:05:13 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Cristian Marussi <cristian.marussi@arm.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] cpufreq: scmi: Fix OPP addition failure with a dummy
 clock provider
Message-ID: <20201111110513.but7tzvmkoxqmwlb@bogus>
References: <20201110111040.280231-1-sudeep.holla@arm.com>
 <20201110112414.abrqtf4v76sth54m@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201110112414.abrqtf4v76sth54m@vireshk-i7>
User-Agent: NeoMutt/20171215
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Nov 10, 2020 at 04:54:14PM +0530, Viresh Kumar wrote:
> On 10-11-20, 11:10, Sudeep Holla wrote:
> > Commit dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return
> > -EPROBE_DEFER") handles -EPROBE_DEFER for the clock/interconnects within
> > _allocate_opp_table() which is called from dev_pm_opp_add and it
> > now propagates the error back to the caller.
> > 
> > SCMI performance domain re-used clock bindings to keep it simple. However
> > with the above mentioned change, if clock property is present in a device
> > node, opps fails to get added with below errors until clk_get succeeds.
> > 
> >  cpu0: failed to add opp 450000000Hz
> >  cpu0: failed to add opps to the device
> >  ....(errors on cpu1-cpu4)
> >  cpu5: failed to add opp 450000000Hz
> >  cpu5: failed to add opps to the device
> > 
> > So, in order to fix the issue, we need to register dummy clock provider.
> > With the dummy clock provider, clk_get returns NULL(no errors!), then opp
> > core proceeds to add OPPs for the CPUs.
> > 
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Fixes: dd461cd9183f ("opp: Allow dev_pm_opp_get_opp_table() to return -EPROBE_DEFER")
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/scmi-cpufreq.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/cpufreq/scmi-cpufreq.c b/drivers/cpufreq/scmi-cpufreq.c
> > index e855e8612a67..78318508a6d6 100644
> > --- a/drivers/cpufreq/scmi-cpufreq.c
> > +++ b/drivers/cpufreq/scmi-cpufreq.c
> > @@ -8,6 +8,7 @@
> >  
> >  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> >  
> > +#include <linux/clk-provider.h>
> >  #include <linux/cpu.h>
> >  #include <linux/cpufreq.h>
> >  #include <linux/cpumask.h>
> > @@ -228,12 +229,17 @@ static struct cpufreq_driver scmi_cpufreq_driver = {
> >  static int scmi_cpufreq_probe(struct scmi_device *sdev)
> >  {
> >  	int ret;
> > +	struct device *dev = &sdev->dev;
> >  
> >  	handle = sdev->handle;
> >  
> >  	if (!handle || !handle->perf_ops)
> >  		return -ENODEV;
> >  
> > +	/* dummy clock provider as needed by OPP if clocks property is used */
> > +	if (of_find_property(dev->of_node, "#clock-cells", NULL))
> > +		devm_of_clk_add_hw_provider(dev, of_clk_hw_simple_get, NULL);
> > +
> >  	ret = cpufreq_register_driver(&scmi_cpufreq_driver);
> >  	if (ret) {
> >  		dev_err(&sdev->dev, "%s: registering cpufreq failed, err: %d\n",
> 
> For 5.10-rc.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 

Thanks Viresh, I assume Rafael will take this directly as fix for v5.10

-- 
Regards,
Sudeep
