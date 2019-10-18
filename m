Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 635C2DBD61
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 07:59:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730039AbfJRF7x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 01:59:53 -0400
Received: from [217.140.110.172] ([217.140.110.172]:55446 "EHLO foss.arm.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfJRF7x (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 18 Oct 2019 01:59:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9BB4329;
        Thu, 17 Oct 2019 22:59:23 -0700 (PDT)
Received: from e107533-lin.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D4873F68E;
        Thu, 17 Oct 2019 23:02:08 -0700 (PDT)
Date:   Fri, 18 Oct 2019 06:59:15 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, nico@fluxnic.net
Subject: Re: [PATCH v2 5/5] cpufreq: vexpress-spc: fix some coding style
 issues
Message-ID: <20191018055915.GD31836@e107533-lin.cambridge.arm.com>
References: <20191017123508.26130-1-sudeep.holla@arm.com>
 <20191017123508.26130-6-sudeep.holla@arm.com>
 <20191018055517.dxyx4ara7hdmzw5j@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018055517.dxyx4ara7hdmzw5j@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Oct 18, 2019 at 11:25:17AM +0530, Viresh Kumar wrote:
> On 17-10-19, 13:35, Sudeep Holla wrote:
> > Fix the following checkpatch checks/warnings:
> > 
> > CHECK: Unnecessary parentheses around the code
> > CHECK: Alignment should match open parenthesis
> > CHECK: Prefer kernel type 'u32' over 'uint32_t'
> > WARNING: Missing a blank line after declarations
> > 
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >  drivers/cpufreq/vexpress-spc-cpufreq.c | 43 ++++++++++++--------------
> >  1 file changed, 20 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > index 81064430317f..8ecb2961be86 100644
> > --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> > +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > @@ -79,8 +79,8 @@ static unsigned int find_cluster_maxfreq(int cluster)
> >  	for_each_online_cpu(j) {
> >  		cpu_freq = per_cpu(cpu_last_req_freq, j);
> >  
> > -		if ((cluster == per_cpu(physical_cluster, j)) &&
> > -				(max_freq < cpu_freq))
> > +		if (cluster == per_cpu(physical_cluster, j) &&
> > +		    max_freq < cpu_freq)
> >  			max_freq = cpu_freq;
> >  	}
> >  
> > @@ -188,22 +188,19 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
> >  	freqs_new = freq_table[cur_cluster][index].frequency;
> >  
> >  	if (is_bL_switching_enabled()) {
> > -		if ((actual_cluster == A15_CLUSTER) &&
> > -				(freqs_new < clk_big_min)) {
> > +		if (actual_cluster == A15_CLUSTER && freqs_new < clk_big_min)
> >  			new_cluster = A7_CLUSTER;
> > -		} else if ((actual_cluster == A7_CLUSTER) &&
> > -				(freqs_new > clk_little_max)) {
> > +		else if (actual_cluster == A7_CLUSTER &&
> > +			 freqs_new > clk_little_max)
> >  			new_cluster = A15_CLUSTER;
> > -		}
> >  	}
> >  
> >  	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
> >  				      freqs_new);
> >  
> > -	if (!ret) {
> > +	if (!ret)
> 
> That's not the standard way in Linux I believe. We do use {} even when
> the body is single line but broken into two, like below.
>

OK, wasn't aware of that. I will update. Generally I ignore checkpatch
warnings, but the list was big and fixed a bunch of them :)

--
Regards,
Sudeep
