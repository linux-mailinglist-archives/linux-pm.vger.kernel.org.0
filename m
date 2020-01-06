Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29D130DBD
	for <lists+linux-pm@lfdr.de>; Mon,  6 Jan 2020 07:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgAFGzH (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 6 Jan 2020 01:55:07 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35832 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgAFGzH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Jan 2020 01:55:07 -0500
Received: by mail-pf1-f196.google.com with SMTP id i23so21105240pfo.2
        for <linux-pm@vger.kernel.org>; Sun, 05 Jan 2020 22:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kMjWw4ObQXa5tU7/4BC/Kf0fTl6f93HTAnRhQj6fbYQ=;
        b=rbiZz4bfFgf1jTPa3LFYJTALJqVunQJkyqIBz6qTTRJ6IXYmBRVMVnbtv89C27cCMK
         GbnyT86UTVdO5nGt2TPC3Yd7V5jLEErJRNJKZa9DG/UBSMW3BqhhyY78sxr0Mogby9cO
         EMZ2mEw5bnYmr8GbTYEPl5KDiQOfgOBdoLrsZOrDrM4rIpIRlxcDX1uLdxRCId7WIQle
         UGdj1rzTvzVdEwVSNUy8QcUmnfLjoBUZ0q5fo4bfYF/JhyVJR8Qi37DnKQCifiytQ7gI
         L7L1jnfWUoEIkd1cmkhZM1QLeVS7IWAcn218pivk4ZSk4LyFAefJe1aMUFfiGWRtlXOr
         1ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kMjWw4ObQXa5tU7/4BC/Kf0fTl6f93HTAnRhQj6fbYQ=;
        b=TNeOibm3/Cxe9QkUAxb6v2Lsjqr8b6bLlhFd+raHgiX+uGyXO808GqLkKOM/lJLUVS
         MPTnYSfutwe7KecUtgdok9az/0QZ00GfWBEYxMyOmIWCIaEAv/NE9XQYDvX1nGHMhxdn
         k2LPyxfGK24KwRlqOMityXsykWtNymbL8p5DZsK+sliH+yq9UGx0hLiiNclsRK0EmBwC
         gJA6cG/qhgjBrUOWmm6gILwhuYe905l1WRGoYw63Dbu7lil/HnhzAiAuAuDtIp/rndlq
         9dsdMCHCvOxNFHRBeVLu+oUCDwktsg3QsUNUPKDbZCTdOgSaOm/NLmXnx62BcA5Ga3PX
         i/TA==
X-Gm-Message-State: APjAAAWeKJ0pKytdh2YkfL5E8+pWEY4reYD6wPGjkCiQtKjZP7yeXDGj
        ujqkrc5g/VX0pQ86AmF3HqdOYw==
X-Google-Smtp-Source: APXvYqzDrb4T5b5fxDDS/CxIRlUlD59ItmCXmCwsdQJKzsrikz4XhCQmY7mMb4+ZrEIymAreV3RhQA==
X-Received: by 2002:a65:56c9:: with SMTP id w9mr105330256pgs.296.1578293705329;
        Sun, 05 Jan 2020 22:55:05 -0800 (PST)
Received: from localhost ([122.172.26.121])
        by smtp.gmail.com with ESMTPSA id l8sm22852583pjy.24.2020.01.05.22.55.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Jan 2020 22:55:04 -0800 (PST)
Date:   Mon, 6 Jan 2020 12:25:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     chenqiwu <qiwuchen55@gmail.com>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpufreq: s3c: avoid use after free issue in
 xxx_cpufreq_reboot_notifier_evt()
Message-ID: <20200106065502.bimpddvrvmfm2f5f@vireshk-i7>
References: <1577515439-14477-1-git-send-email-qiwuchen55@gmail.com>
 <20200106054811.uduf2qdn5ecvbwrc@vireshk-i7>
 <20200106065249.GA16392@cqw-OptiPlex-7050>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106065249.GA16392@cqw-OptiPlex-7050>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 06-01-20, 14:52, chenqiwu wrote:
> On Mon, Jan 06, 2020 at 11:18:11AM +0530, Viresh Kumar wrote:
> > On 28-12-19, 14:43, qiwuchen55@gmail.com wrote:
> > > From: chenqiwu <chenqiwu@xiaomi.com>
> > > 
> > > There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
> > > the cpufreq policy of cpu0 has been released before using it. So we should
> > > make a judgement to avoid it.
> > 
> > There is no UAF problem here, but that we do cpufreq_cpu_get() with a
> > corresponding cpufreq_cpu_put().
> > 
> > > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > > ---
> > >  drivers/cpufreq/s3c2416-cpufreq.c | 11 ++++++++++-
> > >  drivers/cpufreq/s5pv210-cpufreq.c | 10 +++++++++-
> > >  2 files changed, 19 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> > > index 1069103..0f576ba 100644
> > > --- a/drivers/cpufreq/s3c2416-cpufreq.c
> > > +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> > > @@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> > >  {
> > >  	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
> > >  	int ret;
> > > +	struct cpufreq_policy policy;
> > >  
> > >  	mutex_lock(&cpufreq_lock);
> > >  
> > > @@ -318,7 +319,15 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> > >  	 */
> > >  	if (s3c_freq->is_dvs) {
> > >  		pr_debug("cpufreq: leave dvs on reboot\n");
> > > -		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
> > > +
> > > +		memset(&policy, 0, sizeof(policy));
> > > +		ret = cpufreq_get_policy(&policy, 0);
> > > +		if (ret < 0) {
> > > +			pr_debug("cpufreq: get no policy for cpu0\n");
> > > +			return NOTIFY_BAD;
> > > +		}
> > > +
> > 
> > This doesn't make sense to me, why don't you do cpufreq_cpu_get() and
> > put() instead ?
> >
> Hi viresh,
> I can't explain which approach is better, but I think both approaches are
> effective for the situation.

The second one is better as it doesn't make copy of the policy, but
rather just increments the counter.

> By the way, there is a possibility that the cpu0 hotplug thread will call
> cpufreq_policy_free() to free cpufreq policy if cpu0 hotplug failed.
> I think there should be a judgement to avoid this UAF risk if necessary,
> or we just do panic if cpu0's cpufreq policy is free.

I think there are enough locks in place to avoid such issues and they
shouldn't happen.

> > > +		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
> > >  		if (ret < 0)
> > >  			return NOTIFY_BAD;
> > >  	}
> > > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > > index 5d10030..d99b4b1 100644
> > > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > > @@ -555,8 +555,16 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
> > >  						 unsigned long event, void *ptr)
> > >  {
> > >  	int ret;
> > > +	struct cpufreq_policy *policy;
> > >  
> > > -	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
> > > +	policy = cpufreq_cpu_get(0);
> > > +	if (!policy) {
> > > +		pr_debug("cpufreq: get no policy for cpu0\n");
> > > +		return NOTIFY_BAD;
> > > +	}
> > > +
> > > +	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> > > +	cpufreq_cpu_put(policy);
> > 
> > Like what is done here.
> > 
> > Also add a blank line here.
> > 
> > >  	if (ret < 0)
> > >  		return NOTIFY_BAD;
> > >  
> > > -- 
> > > 1.9.1
> > 
> > -- 
> > viresh
> 
> Thanks for your review!
> Qiwu

-- 
viresh
