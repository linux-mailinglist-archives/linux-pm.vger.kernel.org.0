Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 920C9644E7
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 12:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbfGJKHG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 06:07:06 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:44131 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfGJKHF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 06:07:05 -0400
Received: from 79.184.253.121.ipv4.supernova.orange.pl (79.184.253.121) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id fb1402abfa64d0e0; Wed, 10 Jul 2019 12:07:03 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Cc:     linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, cheng.shengyu@zte.com.cn,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] cpufreq/pasemi: fix an use-after-free in pas_cpufreq_cpu_init()
Date:   Wed, 10 Jul 2019 12:07:03 +0200
Message-ID: <2173177.H4fXhsoBLG@kreacher>
In-Reply-To: <20190709081205.a5sjsqo2el6zt24b@vireshk-i7>
References: <1562659447-39989-1-git-send-email-wen.yang99@zte.com.cn> <20190709081205.a5sjsqo2el6zt24b@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tuesday, July 9, 2019 10:12:05 AM CEST Viresh Kumar wrote:
> On 09-07-19, 16:04, Wen Yang wrote:
> > The cpu variable is still being used in the of_get_property() call
> > after the of_node_put() call, which may result in use-after-free.
> > 
> > Fixes: a9acc26b75f ("cpufreq/pasemi: fix possible object reference leak")
> > Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org

Patch applied.

> > ---
> > v5: put together the code to get, use, and release cpu device_node.
> > v4: restore the blank line.
> > v3: fix a leaked reference.
> > v2: clean up the code according to the advice of viresh.
> > 
> >  drivers/cpufreq/pasemi-cpufreq.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/pasemi-cpufreq.c b/drivers/cpufreq/pasemi-cpufreq.c
> > index 6b1e4ab..1f0beb7 100644
> > --- a/drivers/cpufreq/pasemi-cpufreq.c
> > +++ b/drivers/cpufreq/pasemi-cpufreq.c
> > @@ -131,10 +131,17 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	int err = -ENODEV;
> >  
> >  	cpu = of_get_cpu_node(policy->cpu, NULL);
> > -
> > -	of_node_put(cpu);
> >  	if (!cpu)
> >  		goto out;
> 
> I would have loved a blank line here :)

And I added the blank line.

> > +	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> > +	of_node_put(cpu);
> > +	if (!max_freqp) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> > +	/* we need the freq in kHz */
> > +	max_freq = *max_freqp / 1000;
> >  
> >  	dn = of_find_compatible_node(NULL, NULL, "1682m-sdc");
> >  	if (!dn)
> > @@ -171,16 +178,6 @@ static int pas_cpufreq_cpu_init(struct cpufreq_policy *policy)
> >  	}
> >  
> >  	pr_debug("init cpufreq on CPU %d\n", policy->cpu);
> > -
> > -	max_freqp = of_get_property(cpu, "clock-frequency", NULL);
> > -	if (!max_freqp) {
> > -		err = -EINVAL;
> > -		goto out_unmap_sdcpwr;
> > -	}
> > -
> > -	/* we need the freq in kHz */
> > -	max_freq = *max_freqp / 1000;
> > -
> >  	pr_debug("max clock-frequency is at %u kHz\n", max_freq);
> >  	pr_debug("initializing frequency table\n");
> 
> Though, enough versions have happened now.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> 

Thanks!



