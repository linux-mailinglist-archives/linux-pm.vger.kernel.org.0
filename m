Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1813A6808
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jun 2021 15:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhFNNhh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 14 Jun 2021 09:37:37 -0400
Received: from foss.arm.com ([217.140.110.172]:36278 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233668AbhFNNhe (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 14 Jun 2021 09:37:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB1176D;
        Mon, 14 Jun 2021 06:35:31 -0700 (PDT)
Received: from e120877-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B43243F719;
        Mon, 14 Jun 2021 06:35:30 -0700 (PDT)
Date:   Mon, 14 Jun 2021 14:35:24 +0100
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     peterz@infradead.org, rjw@rjwysocki.net,
        vincent.guittot@linaro.org, qperret@google.com,
        linux-pm@vger.kernel.org, ionela.voinescu@arm.com,
        lukasz.luba@arm.com, dietmar.eggemann@arm.com
Subject: Re: [PATCH v3 3/6] cpufreq: Add an interface to mark inefficient
 frequencies
Message-ID: <20210614133522.GA34061@e120877-lin.cambridge.arm.com>
References: <1622804761-126737-1-git-send-email-vincent.donnefort@arm.com>
 <1622804761-126737-4-git-send-email-vincent.donnefort@arm.com>
 <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614072835.z2tjoaffcflry7pk@vireshk-i7>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jun 14, 2021 at 12:58:35PM +0530, Viresh Kumar wrote:
> On 04-06-21, 12:05, Vincent Donnefort wrote:
> >  int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
> >  {
> >  	int ret;
> > @@ -362,7 +409,13 @@ int cpufreq_table_validate_and_sort(struct cpufreq_policy *policy)
> >  	if (ret)
> >  		return ret;
> >  
> > -	return set_freq_table_sorted(policy);
> > +	ret = set_freq_table_sorted(policy);
> > +	if (ret)
> > +		return ret;
> > +
> > +	set_freq_table_efficiencies(policy);
> > +
> > +	return ret;
> >  }
> 
> Lets provide a single callback from the cpufreq core to do all
> settings related to efficient frequencies and call it from
> em_dev_register_perf_domain() ?

Sadly we cannot do it in em_dev_register_perf_domain(). This function is called
from the cpufreq driver init, when the table isn't available yet.

> 
> So we only do them for the cpufreq drivers that register themselves
> with EM.

Currently, only the EM would set those inefficient OPPs. But it also gives the
possibility for individual drivers to set them, even if they do not use the EM.

> 
> -- 
> viresh
