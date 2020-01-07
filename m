Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBA21320B1
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 08:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGHuh (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 02:50:37 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33335 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgAGHuh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 02:50:37 -0500
Received: by mail-pg1-f194.google.com with SMTP id 6so28113972pgk.0;
        Mon, 06 Jan 2020 23:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qzzTC8ttKEfiApeWn3h6jKqgrPf6T465Tjv1Jd74c78=;
        b=rC6EmZ+GudEOVFN+abU1cBbz1PjUjHEpFvOkOklH1dX2nFXUMenumC72Evz9K65I8X
         zX79Mv2G3Fj3wlaQIcroMGfUyi4XaXZfApz08/vpq7zUbw6ItBEmiZKQITqDVYZxHGy7
         N4IVd+ouWx/Ou5pfNzm56bhDnvybF8/7plx77sMn+NLPRo0s2wRTVh97i+D2fz7jZGbx
         ba/v9c35l0es9M2MVwl8CxBsJ4ydUthfe1JNJaq3za/e86xIxjFyH8Rdw7z4rkhZXry7
         2X6hX5RGtsOowmniqaG52cnub9CqwNscphLGsJ+ZKQIKV7ZtC3dZ1Oz+onZ4bNLGQjTH
         bPbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qzzTC8ttKEfiApeWn3h6jKqgrPf6T465Tjv1Jd74c78=;
        b=WI++y+ZNpUdYGRE0u4aacjmjlaujwO5LNWtWp7v2xcxBdSvgt+0R4rDrN3YGsDHSbg
         aYg2lWRBQBSFurBDNFz+sD/4x9Hn6AkbJKHN3G4C1AVG3/22pJyJqsZLSrNWLFXtyYtu
         uGKT5MX7o4JudOXb9mVB72edVm2i06RyP3rYDh0k3U4tv0KKuozvWFLfjD2ZndeZGkAO
         SSSw8/PbmGm1TNDOqMhE4rAimHGFSpZX19ITABak6PT1GZILAhKubFphRhE+P59/ywD7
         kOk4qXoVnA1lFCOopdYzfxSV4yQp+CR3PwFanOMjwdZYn86IntO62d+Gcg5KFqOEFa7F
         yI9Q==
X-Gm-Message-State: APjAAAUrjoXWL4Dtt6WwsMJ/qVFahh90esGyQhelmMqXzbHm0K2M8Q3Z
        8FQuLfs7MWb1KYi8Ph41FmQ=
X-Google-Smtp-Source: APXvYqx/Lp0aOaCYq2Hq9Zs8XRmir80kumuPx1zejmVByeswt0T6vNQnU3BSh7MVR5Rf1gYYjXlqrw==
X-Received: by 2002:a63:3484:: with SMTP id b126mr112310953pga.17.1578383436541;
        Mon, 06 Jan 2020 23:50:36 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id v143sm73133535pfc.71.2020.01.06.23.50.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 06 Jan 2020 23:50:36 -0800 (PST)
Date:   Tue, 7 Jan 2020 15:50:33 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     kgene@kernel.org, krzk@kernel.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH v2] cpufreq: s3c: avoid use after free issue in
 xxx_cpufreq_reboot_notifier_evt()
Message-ID: <20200107075033.GA11054@cqw-OptiPlex-7050>
References: <1578303861-7217-1-git-send-email-qiwuchen55@gmail.com>
 <20200107053147.v5ooeeshknlqyc3l@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107053147.v5ooeeshknlqyc3l@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jan 07, 2020 at 11:01:47AM +0530, Viresh Kumar wrote:
> On 06-01-20, 17:44, qiwuchen55@gmail.com wrote:
> > From: chenqiwu <chenqiwu@xiaomi.com>
> > 
> > There is a potential UAF issue in xxx_cpufreq_reboot_notifier_evt() that
> > the cpufreq policy of cpu0 has been released before using it. So we should
> > make a judgement to avoid it.
> 
> Again, the subject and description are incorrect here. This isn't a user after
> free problem as we were already calling cpufreq_cpu_get(). The problem was that
> the balancing of refcount wasn't done properly.
> 
>

Yeah, I will rewrite the title and commit message, and resend this as
patch v3.

Thanks!

> > Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
> > ---
> > changes in v2:
> >  - use the combination of cpufreq_cpu_get() and cpufreq_cpu_put()
> >    instead of cpufreq_get_policy() in s3c2416-cpufreq.c
> > ---
> >  drivers/cpufreq/s3c2416-cpufreq.c | 12 +++++++++++-
> >  drivers/cpufreq/s5pv210-cpufreq.c | 11 ++++++++++-
> >  2 files changed, 21 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cpufreq/s3c2416-cpufreq.c b/drivers/cpufreq/s3c2416-cpufreq.c
> > index 1069103..f07c5d1 100644
> > --- a/drivers/cpufreq/s3c2416-cpufreq.c
> > +++ b/drivers/cpufreq/s3c2416-cpufreq.c
> > @@ -304,6 +304,7 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> >  {
> >  	struct s3c2416_data *s3c_freq = &s3c2416_cpufreq;
> >  	int ret;
> > +	struct cpufreq_policy *policy;
> >  
> >  	mutex_lock(&cpufreq_lock);
> >  
> > @@ -318,7 +319,16 @@ static int s3c2416_cpufreq_reboot_notifier_evt(struct notifier_block *this,
> >  	 */
> >  	if (s3c_freq->is_dvs) {
> >  		pr_debug("cpufreq: leave dvs on reboot\n");
> > -		ret = cpufreq_driver_target(cpufreq_cpu_get(0), FREQ_SLEEP, 0);
> > +
> > +		policy = cpufreq_cpu_get(0);
> > +		if (!policy) {
> > +			pr_debug("cpufreq: get no policy for cpu0\n");
> > +			return NOTIFY_BAD;
> > +		}
> > +
> > +		ret = cpufreq_driver_target(&policy, FREQ_SLEEP, 0);
> > +		cpufreq_cpu_put(policy);
> > +
> >  		if (ret < 0)
> >  			return NOTIFY_BAD;
> >  	}
> > diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> > index 5d10030..e84281e 100644
> > --- a/drivers/cpufreq/s5pv210-cpufreq.c
> > +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> > @@ -555,8 +555,17 @@ static int s5pv210_cpufreq_reboot_notifier_event(struct notifier_block *this,
> >  						 unsigned long event, void *ptr)
> >  {
> >  	int ret;
> > +	struct cpufreq_policy *policy;
> > +
> > +	policy = cpufreq_cpu_get(0);
> > +	if (!policy) {
> > +		pr_debug("cpufreq: get no policy for cpu0\n");
> > +		return NOTIFY_BAD;
> > +	}
> > +
> > +	ret = cpufreq_driver_target(policy, SLEEP_FREQ, 0);
> > +	cpufreq_cpu_put(policy);
> >  
> > -	ret = cpufreq_driver_target(cpufreq_cpu_get(0), SLEEP_FREQ, 0);
> >  	if (ret < 0)
> >  		return NOTIFY_BAD;
> >  
> > -- 
> > 1.9.1
> 
> -- 
> viresh

--
Qiwu
