Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2C91070B
	for <lists+linux-pm@lfdr.de>; Wed,  1 May 2019 12:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725788AbfEAKjs (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 1 May 2019 06:39:48 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48634 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfEAKjs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2019 06:39:48 -0400
Received: from 79.184.254.69.ipv4.supernova.orange.pl (79.184.254.69) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.213)
 id 2d3a9ff0c800f84d; Wed, 1 May 2019 12:39:46 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>, Yue Hu <zbestahu@gmail.com>
Cc:     rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org,
        huyue2@yulong.com
Subject: Re: [PATCH] cpufreq: Move ->get callback check outside of __cpufreq_get()
Date:   Wed, 01 May 2019 12:39:46 +0200
Message-ID: <9406722.JUlNrifzaB@kreacher>
In-Reply-To: <20190422081902.xeiu66gpspcjbrol@vireshk-i7>
References: <20190419062759.8524-1-zbestahu@gmail.com> <20190422081902.xeiu66gpspcjbrol@vireshk-i7>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, April 22, 2019 10:19:02 AM CEST Viresh Kumar wrote:
> On 19-04-19, 14:27, Yue Hu wrote:
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currenly, __cpufreq_get() called by show_cpuinfo_cur_freq() will check
> > ->get callback. That is needless since cpuinfo_cur_freq attribute will
> > not be created if ->get is not set. So let's drop it in __cpufreq_get().
> > Also keep this check in cpufreq_get().
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > ---
> >  drivers/cpufreq/cpufreq.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 047662b..c6187f1 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1548,7 +1548,7 @@ static unsigned int __cpufreq_get(struct cpufreq_policy *policy)
> >  {
> >  	unsigned int ret_freq = 0;
> >  
> > -	if (unlikely(policy_is_inactive(policy)) || !cpufreq_driver->get)
> > +	if (unlikely(policy_is_inactive(policy)))
> >  		return ret_freq;
> >  
> >  	ret_freq = cpufreq_driver->get(policy->cpu);
> > @@ -1586,7 +1586,8 @@ unsigned int cpufreq_get(unsigned int cpu)
> >  
> >  	if (policy) {
> >  		down_read(&policy->rwsem);
> > -		ret_freq = __cpufreq_get(policy);
> > +		if (cpufreq_driver->get)
> > +			ret_freq = __cpufreq_get(policy);
> >  		up_read(&policy->rwsem);
> >  
> >  		cpufreq_cpu_put(policy);
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Patch applied, thanks!



