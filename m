Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53F23B5AFE
	for <lists+linux-pm@lfdr.de>; Mon, 28 Jun 2021 11:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbhF1JNJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Jun 2021 05:13:09 -0400
Received: from foss.arm.com ([217.140.110.172]:54496 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232284AbhF1JNJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 28 Jun 2021 05:13:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AC2611FB;
        Mon, 28 Jun 2021 02:10:43 -0700 (PDT)
Received: from bogus (unknown [10.57.78.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DF5AE3F694;
        Mon, 28 Jun 2021 02:10:40 -0700 (PDT)
Date:   Mon, 28 Jun 2021 10:09:56 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Hector Yuan <hector.yuan@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com
Subject: Re: [PATCH v12 1/2] cpufreq: mediatek-hw: Add support for CPUFREQ HW
Message-ID: <20210628090956.uwkrozdqvawsm3xp@bogus>
References: <1622307153-3639-1-git-send-email-hector.yuan@mediatek.com>
 <1622307153-3639-2-git-send-email-hector.yuan@mediatek.com>
 <20210614104058.jdwb7godqzhf7rgd@vireshk-i7>
 <1624781848.1958.16.camel@mtkswgap22>
 <20210628072641.amqk5d3svwolvhic@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628072641.amqk5d3svwolvhic@vireshk-i7>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 28, 2021 at 12:56:41PM +0530, Viresh Kumar wrote:
> On 27-06-21, 16:17, Hector Yuan wrote:
> > On Mon, 2021-06-14 at 16:10 +0530, Viresh Kumar wrote:
> > > On 30-05-21, 00:52, Hector Yuan wrote:
> > > > +static int mtk_get_related_cpus(int index, struct cpufreq_mtk *c)
> > > > +{
> > > > +	struct device_node *cpu_np;
> > > > +	struct of_phandle_args args;
> > > > +	int cpu, ret;
> > > > +
> > > > +	for_each_possible_cpu(cpu) {
> > > > +		cpu_np = of_cpu_device_node_get(cpu);
> > > > +		if (!cpu_np)
> > > > +			continue;
> > > > +
> > > > +		ret = of_parse_phandle_with_args(cpu_np, "performance-domains",
> > > > +						 "#performance-domain-cells", 0,
> > > > +						 &args);
> > > > +		of_node_put(cpu_np);
> > > > +		if (ret < 0)
> > > > +			continue;
> > > > +
> > > > +		if (index == args.args[0]) {
> > > > +			cpumask_set_cpu(cpu, &c->related_cpus);
> > > > +			mtk_freq_domain_map[cpu] = c;
> > > > +		}
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > >
> > > I really hope this can be moved to a common place as more than one
> > > drier should be required to parse this thing.
> > >
> >
> > Yes, this can be a common part for all performance domain users. But may
> > I know whats your suggestion? Put this API in another file or? Thanks
>
> Rob, Sudeep: You guys have a suggestion on where can we keep a routine for this
> ?

Probably in driver/cpufreq or some related headers if it needs to access
related_cpus and is more cpufreq related in that way ?

Orthogonal to that, I prefer to make the generic function take list_name
and cells_name as generic. I see we can reuse that qcom-cpufreq-hw.c
with "qcom,freq-domain" and "#freq-domain-cells".

--
Regards,
Sudeep
