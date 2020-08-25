Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A198251714
	for <lists+linux-pm@lfdr.de>; Tue, 25 Aug 2020 13:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgHYLH7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 25 Aug 2020 07:07:59 -0400
Received: from foss.arm.com ([217.140.110.172]:56292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726149AbgHYLH6 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 25 Aug 2020 07:07:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C544E30E;
        Tue, 25 Aug 2020 04:07:57 -0700 (PDT)
Received: from localhost (unknown [10.1.199.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6672D3F66B;
        Tue, 25 Aug 2020 04:07:57 -0700 (PDT)
Date:   Tue, 25 Aug 2020 12:07:56 +0100
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] cpufreq: report whether cpufreq supports
 Frequency Invariance (FI)
Message-ID: <20200825110747.GA12506@arm.com>
References: <20200824210252.27486-1-ionela.voinescu@arm.com>
 <20200824210252.27486-4-ionela.voinescu@arm.com>
 <20200825062709.dlzztu547idco7zw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825062709.dlzztu547idco7zw@vireshk-i7>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Tuesday 25 Aug 2020 at 11:57:09 (+0530), Viresh Kumar wrote:
[..]
> > +static inline
> > +void enable_cpufreq_freq_invariance(struct cpufreq_driver *driver)
> > +{
> > +	if (!driver->setpolicy) {
> > +		static_branch_enable_cpuslocked(&cpufreq_freq_invariance);
> > +		pr_debug("supports frequency invariance");
> > +	}
> > +}
> > +
> 
> I would rather open-code this int the cpufreq_register_driver() routine as
> that's what is done in cpufreq_unregister_driver() as well.
> 
> > +bool cpufreq_supports_freq_invariance(void)
> > +{
> > +	return static_branch_likely(&cpufreq_freq_invariance);
> > +}
> > +
> 
> And would keep the definition of the static key with this routine at a single
> place.

Makes sense and will do!

Thank you for the quick review,
Ionela.
