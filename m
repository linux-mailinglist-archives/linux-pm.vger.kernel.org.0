Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF339981A
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 04:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhFCCkk (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Jun 2021 22:40:40 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:34652 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhFCCkk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Jun 2021 22:40:40 -0400
Received: by mail-pj1-f54.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2587577pjx.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Jun 2021 19:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xbfOBa4V4NfcCRLvjCYR6j0+uuKti8SF2SJo2woyW5k=;
        b=ceDw3cpkamXUfVJ1HR6HD28oQSpaJbLTLqOnymfgzJlu+4IctogqB3VOppxeVEot8q
         lNi6Yf2RnJCsjJUN/wAalfOoObiZs4C4hYyjftsLmyEqBEQYVzboF2j/ysZJztDg1AtL
         GAV681ZM8z3q01aXojfylxQzLp2KI8R+qMdsOkVI0J1p8FqQ0M2+gDuQhF6c+lLVOZ1X
         3Okh3+q5sVG00D1BrTUtuT/2RKyKRxp7kvMNQ0Abh4F5V06hWnJMvgOAoMeZV1LDj94k
         QXc2oR0IuZ6JM2vozHFPGw6bT27yMfp+n+sVyL/dI0/An/QVTA6mncucRyw8UBxUgzjh
         b8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xbfOBa4V4NfcCRLvjCYR6j0+uuKti8SF2SJo2woyW5k=;
        b=e+sDzJ3IPzFR9yjY/PQE5WRTX0jzLHQ/FEc2ri3ONVVET4VWomxSeQWKMmnsVdo7iv
         sVJaDwZWjLMGBxJlnZNiRIlLI9mr/+LrH6HBg+pzr3Tc+KmX1ATIVVs5lnqYYTITuv4P
         hEWF70jLiWVoUmiMot82UePFKJd0hPhN8d+0s9CCjP7UWuijipYM50xVLSXOuTFPTuJv
         KXNNsF42KsbjnsuR5L4NUVOJbjAVq7sqT/X8KFWoJStiZKuRWKnbK9gy2DAHp+oGlkN5
         UJzOz1UcZge1HTN2dpX9Tcng4drp7YWCl11q5plF4cf96zY5Ap6cHABKOp8JcjasBYaM
         1cxg==
X-Gm-Message-State: AOAM5327sovYXLp5nsGgwOMlkapdVOYs7na4wcfs6ERpF696BneLioTQ
        4kkTKf3AbkVTX29RKawv1uCNVw==
X-Google-Smtp-Source: ABdhPJwNjVsy9G2E0nDNUrLhwAEvQ/PJG4VNWAnP8MGjn/84SwkXjIInnYsKhYwPONr1jI8ldsblQg==
X-Received: by 2002:a17:90b:3584:: with SMTP id mm4mr8704483pjb.171.1622687861987;
        Wed, 02 Jun 2021 19:37:41 -0700 (PDT)
Received: from localhost ([136.185.154.93])
        by smtp.gmail.com with ESMTPSA id r5sm633056pjd.2.2021.06.02.19.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 19:37:41 -0700 (PDT)
Date:   Thu, 3 Jun 2021 08:07:39 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] PM: domains: Drop/restore performance state votes
 for devices at runtime PM
Message-ID: <20210603023739.mds4eir4i6olaiwz@vireshk-i7>
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
 <20210602101215.78094-3-ulf.hansson@linaro.org>
 <20210603023441.bs47nwtmskrdz2el@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603023441.bs47nwtmskrdz2el@vireshk-i7>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-21, 08:04, Viresh Kumar wrote:
> On 02-06-21, 12:12, Ulf Hansson wrote:
> > A subsystem/driver that need to manage OPPs for its device, should
> > typically drop its vote for the OPP when the device becomes runtime
> > suspended. In this way, the corresponding aggregation of the performance
> > state votes that is managed in genpd for the attached PM domain, may find
> > that the aggregated vote can be decreased. Hence, it may allow genpd to set
> > the lower performance state for the PM domain, thus avoiding to waste
> > energy.
> > 
> > To accomplish this, typically a subsystem/driver would need to call
> > dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> > callback, to drop the vote for the OPP. Accordingly, it needs another call
> > to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> > ->runtime_resume() callback.
> > 
> > To avoid boilerplate code in subsystems/driver to deal with these things,
> > let's instead manage this internally in genpd.
> > 
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/base/power/domain.c | 21 +++++++++++++++++++--
> >  include/linux/pm_domain.h   |  1 +
> >  2 files changed, 20 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index a3b6e751f366..81b9d4652b90 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -397,6 +397,18 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
> >  	return ret;
> >  }
> >  
> > +static int genpd_drop_performance_state(struct device *dev)
> > +{
> > +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> > +	unsigned int prev_state;
> > +
> > +	prev_state = gpd_data->performance_state;
> > +	if (prev_state && !genpd_set_performance_state(dev, 0))
> 
> What about adding this prev_state check in
> genpd_set_performance_state() itself ? We already have one for the
> genpd in _genpd_set_performance_state(), why not one for the device ?
> 
> > +		return prev_state;
> > +
> > +	return 0;
> 
> Hmm, we will return 0 in case genpd_set_performance_state() fails,
> which will make us set the state to 0 again on resume. Maybe add a
> comment for this somewhere ?

No, we won't as you check for rpm_saved_pstate there, so the device
will stay disabled.

Again adding the check into genpd_set_performance_state() may help
reducing similar checks elsewhere.

> > +}
> > +
> >  /**
> >   * dev_pm_genpd_set_performance_state- Set performance state of device's power
> >   * domain.
> > @@ -839,7 +851,8 @@ static int genpd_runtime_suspend(struct device *dev)
> >  {
> >  	struct generic_pm_domain *genpd;
> >  	bool (*suspend_ok)(struct device *__dev);
> > -	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> > +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> > +	struct gpd_timing_data *td = &gpd_data->td;
> >  	bool runtime_pm = pm_runtime_enabled(dev);
> >  	ktime_t time_start;
> >  	s64 elapsed_ns;
> > @@ -896,6 +909,7 @@ static int genpd_runtime_suspend(struct device *dev)
> >  		return 0;
> >  
> >  	genpd_lock(genpd);
> > +	gpd_data->rpm_saved_pstate = genpd_drop_performance_state(dev);
> >  	genpd_power_off(genpd, true, 0);
> >  	genpd_unlock(genpd);
> >  
> > @@ -913,7 +927,8 @@ static int genpd_runtime_suspend(struct device *dev)
> >  static int genpd_runtime_resume(struct device *dev)
> >  {
> >  	struct generic_pm_domain *genpd;
> > -	struct gpd_timing_data *td = &dev_gpd_data(dev)->td;
> > +	struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> > +	struct gpd_timing_data *td = &gpd_data->td;
> >  	bool runtime_pm = pm_runtime_enabled(dev);
> >  	ktime_t time_start;
> >  	s64 elapsed_ns;
> > @@ -937,6 +952,8 @@ static int genpd_runtime_resume(struct device *dev)
> >  
> >  	genpd_lock(genpd);
> >  	ret = genpd_power_on(genpd, 0);
> > +	if (!ret && gpd_data->rpm_saved_pstate)
> > +		genpd_set_performance_state(dev, gpd_data->rpm_saved_pstate);
> >  	genpd_unlock(genpd);

-- 
viresh
