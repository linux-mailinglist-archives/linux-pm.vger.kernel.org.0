Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B237FDC9C4
	for <lists+linux-pm@lfdr.de>; Fri, 18 Oct 2019 17:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405023AbfJRPvr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 18 Oct 2019 11:51:47 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59693 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389072AbfJRPvq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 18 Oct 2019 11:51:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 066D59AE61;
        Fri, 18 Oct 2019 11:51:42 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=SVptdQAfzrpdqaplm7DrQ1F74hE=; b=MgdHg/
        sAhMWyrnCJ8qmhPjmlwSTs0wPatNyIi4eCqUdzNdsMTUBtjg8IYEk8jVNKvGCApU
        Ha3+te3OKjBy1PL42BFW7ewMgpRVaG30RzBRba4O990XwlFLRcRzORyc1nZxvyk2
        fWB8RxvODkhGa3pDZTm5Itq3G4Lx847JfbBb8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F1D979AE60;
        Fri, 18 Oct 2019 11:51:41 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=Gr5XnOBIp4yLgJQ+v2m19BlmLPGN4f/f+xphdBLskqQ=; b=YnEBUk0HVY7DEWUFjLhJ+O4U9CXvOoHtqykFbxQONMjfo+ZzIFeCxpEfI8PfeTU5ugFYd2RKPNpE9FabYcAbfG6d7/oNAoIvyrM9ygQkTq45hlOOHRZJIk7BjiR4sFZgsJaDE+HK9wXqwb6Ci4CI1nZO/Bfiz4iaefDm6e459Ec=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E07DD9AE5E;
        Fri, 18 Oct 2019 11:51:38 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 0BCAD2DA017D;
        Fri, 18 Oct 2019 11:51:37 -0400 (EDT)
Date:   Fri, 18 Oct 2019 11:51:36 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Sudeep Holla <sudeep.holla@arm.com>
cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] cpufreq: vexpress-spc: fix some coding style
 issues
In-Reply-To: <20191018055915.GD31836@e107533-lin.cambridge.arm.com>
Message-ID: <nycvar.YSQ.7.76.1910181150390.1546@knanqh.ubzr>
References: <20191017123508.26130-1-sudeep.holla@arm.com> <20191017123508.26130-6-sudeep.holla@arm.com> <20191018055517.dxyx4ara7hdmzw5j@vireshk-i7> <20191018055915.GD31836@e107533-lin.cambridge.arm.com>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 2BEA692A-F1BF-11E9-A463-8D86F504CC47-78420484!pb-smtp21.pobox.com
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, 18 Oct 2019, Sudeep Holla wrote:

> On Fri, Oct 18, 2019 at 11:25:17AM +0530, Viresh Kumar wrote:
> > On 17-10-19, 13:35, Sudeep Holla wrote:
> > > Fix the following checkpatch checks/warnings:
> > > 
> > > CHECK: Unnecessary parentheses around the code
> > > CHECK: Alignment should match open parenthesis
> > > CHECK: Prefer kernel type 'u32' over 'uint32_t'
> > > WARNING: Missing a blank line after declarations
> > > 
> > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > > ---
> > >  drivers/cpufreq/vexpress-spc-cpufreq.c | 43 ++++++++++++--------------
> > >  1 file changed, 20 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > > index 81064430317f..8ecb2961be86 100644
> > > --- a/drivers/cpufreq/vexpress-spc-cpufreq.c
> > > +++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
> > > @@ -79,8 +79,8 @@ static unsigned int find_cluster_maxfreq(int cluster)
> > >  	for_each_online_cpu(j) {
> > >  		cpu_freq = per_cpu(cpu_last_req_freq, j);
> > >  
> > > -		if ((cluster == per_cpu(physical_cluster, j)) &&
> > > -				(max_freq < cpu_freq))
> > > +		if (cluster == per_cpu(physical_cluster, j) &&
> > > +		    max_freq < cpu_freq)
> > >  			max_freq = cpu_freq;
> > >  	}
> > >  
> > > @@ -188,22 +188,19 @@ static int ve_spc_cpufreq_set_target(struct cpufreq_policy *policy,
> > >  	freqs_new = freq_table[cur_cluster][index].frequency;
> > >  
> > >  	if (is_bL_switching_enabled()) {
> > > -		if ((actual_cluster == A15_CLUSTER) &&
> > > -				(freqs_new < clk_big_min)) {
> > > +		if (actual_cluster == A15_CLUSTER && freqs_new < clk_big_min)
> > >  			new_cluster = A7_CLUSTER;
> > > -		} else if ((actual_cluster == A7_CLUSTER) &&
> > > -				(freqs_new > clk_little_max)) {
> > > +		else if (actual_cluster == A7_CLUSTER &&
> > > +			 freqs_new > clk_little_max)
> > >  			new_cluster = A15_CLUSTER;
> > > -		}
> > >  	}
> > >  
> > >  	ret = ve_spc_cpufreq_set_rate(cpu, actual_cluster, new_cluster,
> > >  				      freqs_new);
> > >  
> > > -	if (!ret) {
> > > +	if (!ret)
> > 
> > That's not the standard way in Linux I believe. We do use {} even when
> > the body is single line but broken into two, like below.
> >
> 
> OK, wasn't aware of that. I will update. Generally I ignore checkpatch
> warnings, but the list was big and fixed a bunch of them :)

In cases like this one, the best is to go with whatever makes checkpatch 
happy.


Nicolas
