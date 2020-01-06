Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ADDF130EA8
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 09:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgAFIaW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 03:30:22 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36093 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgAFIaW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 03:30:22 -0500
Received: by mail-pf1-f196.google.com with SMTP id x184so26649007pfb.3;
        Mon, 06 Jan 2020 00:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0ZMM8rPl/5wZ+794bf91e79SwCRRg7n7qPgWsUoe+gM=;
        b=Sgcl4NhaAj1CK3LylgkLWA5PkEVN4KmwayIz86BKDL3HpnwmsE7ZdsZQLmGIr/LHaP
         MCf43shQ40RYRiqHrcjF4s4Sjv4V52jlagbE+7NQDqWVNxt8QrKIATtLXV3m1N692uer
         FAalMZnharEcHUaPckaOYC5IBrfAHSFEAKHGNGwzr6PfFP2/vtdegYYJnljUcjmrRU6B
         UljkB03EUB2YpypJOliMSDhlMxwj9RpC7XZD8ySD0zCu6Xlplsd4h9kfnxhmucBRKknS
         YBgpCCTpSEhde3cm3196FTjHgNcVcOtiBzARBJAzl+kO+VK61fFO40XR1fniJiVSFE6Y
         F7Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0ZMM8rPl/5wZ+794bf91e79SwCRRg7n7qPgWsUoe+gM=;
        b=KxCwns7YSJsXsf/7oyeGqeWFf6Bm3h0a3so/nwxI4Yahli7RHxJzuCb2vft15YDEWP
         zwzb+gmp0h+HCxty9d4nvZXuN3YfExSHfJI7m0THKOoBf9qpl/6f/38Y4O/iLZyYP98o
         0vR5FymZFnKLuq22vRMFHj89Y7ATGXrEsmDmC13nS/t2CpIUOgrnfULuerlvEubvmFl6
         jP8kxztdfUHG6jx1OkedEs/pyeg8dyBJI47EG+f43qtwk2619q2ekSMyCeXDq05gHYTh
         Vp2opVcta54uLLrShTvcuFi9wbDAvAsl5eWJCJVgtTPSfh3TnGU5MFbp7I4drmUQuKZA
         zPUw==
X-Gm-Message-State: APjAAAXIKrlxpUgVDffWj+LYDR2v+R8mL94wehzo+gVghQg8bgrUhTEu
        3xQx2zsb0DPW96GHPzqD3z4=
X-Google-Smtp-Source: APXvYqwMUd/x/Ld704TOMMgRs2SgTrv1gvTim77h9jeOE9N9fYpCUm8Cr3j9b5QihHwarQm2+/y+oQ==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr110243047pfn.245.1578299421170;
        Mon, 06 Jan 2020 00:30:21 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b193sm69181638pfb.57.2020.01.06.00.30.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Jan 2020 00:30:20 -0800 (PST)
Date:   Mon, 6 Jan 2020 16:30:18 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c: avoid use after free issue in
 xxx_cpufreq_reboot_notifier_evt()
Message-ID: <20200106083018.GA19697@cqw-OptiPlex-7050>
References: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
 <20200106054811.uduf2qdn5ecvbwrc@vireshk-i7>
 <20200106065249.GA16392@cqw-OptiPlex-7050>
 <20200106065502.bimpddvrvmfm2f5f@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106065502.bimpddvrvmfm2f5f@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 06, 2020 at 12:25:02PM +0530, Viresh Kumar wrote:
> On 06-01-20, 14:52, chenqiwu wrote:
> > On Mon, Jan 06, 2020 at 11:18:11AM +0530, Viresh Kumar wrote:
> > > On 28-12-19, 14:43, qiwuchen55@gmail.com wrote:
> > > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > > 
> > > > There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
> > > > the cpufreq policy of cpu0 has been released before using it. So we should
> > > > make a judgement to avoid it.
> > > 
> > > There is no UAF problem here, but that we do cpufreq_cpu_get() with a
> > > corresponding cpufreq_cpu_put().
> > > 
> > > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > > ---
> > > >  drivers/cpufreq/s3c2416-cpufreq.c | 11 ++++++++++-
> > > >  drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++++++-
> > > >  2 files changed, 19 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> > > > index 1069103..0f576ba 100644
> > > > --- a/drivers/cpufreq/s3c2416-cpufreq.c
> > > > +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> > > > @@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> > > >  {
> > > >  	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
> > > >  	int ret;
> > > > +	struct cpufreq_policy policy;
> > > >  
> > > >  	mutex_lock(&cpufreq_lock);
> > > >  
> > > > @@ -318,7 +319,15 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> > > >  	 */
> > > >  	if (s3c_freq->is_dvs) {
> > > >  		pr_debug("cpufreq: leave dvs on reboot\n");
> > > > -		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
> > > > +
> > > > +		memset(&policy, 0, sizeof(policy));
> > > > +		ret = cpufreq_get_policy(&policy, 0);
> > > > +		if (ret < 0) {
> > > > +			pr_debug("cpufreq: get no policy for cpu0\n");
> > > > +			return NOTIFY_BAD;
> > > > +		}
> > > > +
> > > 
> > > This doesn't make sense to me, why don't you do cpufreq_cpu_get() and
> > > put() instead ?
> > >
> > Hi viresh,
> > I can't explain which approach is better, but I think both approaches are
> > effective for the situation.
> 
> The second one is better as it doesn't make copy of the policy, but
> rather just increments the counter.
> 
> > By the way, there is a possibility that the cpu0 hotplug thread will call
> > cpufreq_policy_free() to free cpufreq policy if cpu0 hotplug failed.
> > I think there should be a judgement to avoid this UAF risk if necessary,
> > or we just do panic if cpu0's cpufreq policy is free.
> 
> I think there are enough locks in place to avoid such issues and they
> shouldn't happen.
>

Hhh..I don't agree this, since the cpufreq policy of cpu0 may have
been released before such UAF issue happenning.
By the way, why not get invaild cpufreq policy of another cpu but
only cpu0 here?

> > > > +		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
> > > >  		if (ret < 0)
> > > >  			return NOTIFY_BAD;
> > > >  	}
> > > > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > > > index 5d10030..d99b4b1 100644
> > > > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > > > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > > > @@ -555,8 +555,16 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
> > > >  						 unsigned long event, void *ptr)
> > > >  {
> > > >  	int ret;
> > > > +	struct cpufreq_policy *policy;
> > > >  
> > > > -	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
> > > > +	policy = cpufreq_cpu_get(0);
> > > > +	if (!policy) {
> > > > +		pr_debug("cpufreq: get no policy for cpu0\n");
> > > > +		return NOTIFY_BAD;
> > > > +	}
> > > > +
> > > > +	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> > > > +	cpufreq_cpu_put(policy);
> > > 
> > > Like what is done here.
> > > 
> > > Also add a blank line here.
> > > 
> > > >  	if (ret < 0)
> > > >  		return NOTIFY_BAD;
> > > >  
> > > > -- 
> > > > 1.9.1
> > > 
> > > -- 
> > > viresh
> > 
> > Thanks for your review!
> > Qiwu
> 
> -- 
> viresh

Thanks!
Qiwu
