Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5E399D8C
	for <lists+linux-pm@lfdr.de>; Thu,  3 Jun 2021 11:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbhFCJTi (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 3 Jun 2021 05:19:38 -0400
Received: from mail-ua1-f47.google.com ([209.85.222.47]:46628 "EHLO
        mail-ua1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhFCJTh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 3 Jun 2021 05:19:37 -0400
Received: by mail-ua1-f47.google.com with SMTP id p1so2916898uam.13
        for <linux-pm@vger.kernel.org>; Thu, 03 Jun 2021 02:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6dTsXISl94OKXQiNoraYlCr7F3D9osS4PfAtIlsvQCY=;
        b=TsJrCQh0Ty5laTUo2X79hNJZ7E/ERDw2mtPJmpB73+O7IyCJVQ8tEMPy/xQyRCu9yf
         htl4Ta8mkTiQz2/3owzr+0rv4jVSzoczfKA6OLmiFH2bZ+VHCsurzZ27VQdX11ItUg7g
         pHstUNccNXDSZYx5X53X6TO4QzWmRHEGkqsUQcn1m1kt4R6sforOTPV0NV0ZCupC4ria
         fJMd0G8eXvdzAEFuG9LME5glr212h6q41hguvhEaX5gw0DFkYmBeKraAdaj7TVPwR3Nd
         Q6t+lCZTwK4qoZCavTgTsdcU60zFYd88Zm/pwnyPJ30fwQOvshdP39wIK2shBXBwT74h
         q93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6dTsXISl94OKXQiNoraYlCr7F3D9osS4PfAtIlsvQCY=;
        b=sjsa/WN0UnCyH83hepq3oLrot1VxujHDzH6yi6Rl8pglWBtuWgpRdVZs0VH9+1SOlz
         PiONHHb9ea7dxkGHVNcDToV5JZW7a9y/Qdr8V/uDXTbGnPUfaqw+i8/bimhj8gdm3TjV
         vlaXygdwq/BTkNixacBtf8ulUbaSLxnZ7jl0TOgHcThUnzppVMUFhTCjIAAWMO89wa0q
         t0HP10qNhUDeRZ/rW8AU03t8JkE6wa+Re/TxF+bKJDNrOfgVsAkBLPBli3gu4iTQ8UMN
         O2XoNWETKCpUNCgoxqInC+Ry1CWcTyIb90IGEHIensacrzd1jluJHzODkL9UgixEkW9M
         /6CQ==
X-Gm-Message-State: AOAM530BxqEcwBF4KeWOEMtfRkdYX0VwF6NRPxeU39XQH6a5ZqrUi489
        2DEOxMzG0oM8gcp7kawszJvpSrt1dVToUIeUdfjc4Q==
X-Google-Smtp-Source: ABdhPJxbxQsf3fPK8vf6FZnE0rJEGeJ8dP0iA/UQlXh2UcoMHUxnpm06yFtz1QJsoMioNp/BeQ8Oi+tx3AYnB6b5lX8=
X-Received: by 2002:a05:6122:995:: with SMTP id g21mr20710892vkd.7.1622711813164;
 Thu, 03 Jun 2021 02:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210602101215.78094-1-ulf.hansson@linaro.org>
 <20210602101215.78094-3-ulf.hansson@linaro.org> <20210603023441.bs47nwtmskrdz2el@vireshk-i7>
 <20210603023739.mds4eir4i6olaiwz@vireshk-i7>
In-Reply-To: <20210603023739.mds4eir4i6olaiwz@vireshk-i7>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 3 Jun 2021 11:16:16 +0200
Message-ID: <CAPDyKFoodEvWCm17=+4NV3snHpSP4qbOzz4+PFyjc=UHvQysOQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] PM: domains: Drop/restore performance state votes for
 devices at runtime PM
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Roja Rani Yarubandi <rojay@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, 3 Jun 2021 at 04:37, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 03-06-21, 08:04, Viresh Kumar wrote:
> > On 02-06-21, 12:12, Ulf Hansson wrote:
> > > A subsystem/driver that need to manage OPPs for its device, should
> > > typically drop its vote for the OPP when the device becomes runtime
> > > suspended. In this way, the corresponding aggregation of the performance
> > > state votes that is managed in genpd for the attached PM domain, may find
> > > that the aggregated vote can be decreased. Hence, it may allow genpd to set
> > > the lower performance state for the PM domain, thus avoiding to waste
> > > energy.
> > >
> > > To accomplish this, typically a subsystem/driver would need to call
> > > dev_pm_opp_set_rate|opp() for its device from its ->runtime_suspend()
> > > callback, to drop the vote for the OPP. Accordingly, it needs another call
> > > to dev_pm_opp_set_rate|opp() to restore the vote for the OPP from its
> > > ->runtime_resume() callback.
> > >
> > > To avoid boilerplate code in subsystems/driver to deal with these things,
> > > let's instead manage this internally in genpd.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/base/power/domain.c | 21 +++++++++++++++++++--
> > >  include/linux/pm_domain.h   |  1 +
> > >  2 files changed, 20 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > > index a3b6e751f366..81b9d4652b90 100644
> > > --- a/drivers/base/power/domain.c
> > > +++ b/drivers/base/power/domain.c
> > > @@ -397,6 +397,18 @@ static int genpd_set_performance_state(struct device *dev, unsigned int state)
> > >     return ret;
> > >  }
> > >
> > > +static int genpd_drop_performance_state(struct device *dev)
> > > +{
> > > +   struct generic_pm_domain_data *gpd_data = dev_gpd_data(dev);
> > > +   unsigned int prev_state;
> > > +
> > > +   prev_state = gpd_data->performance_state;
> > > +   if (prev_state && !genpd_set_performance_state(dev, 0))
> >
> > What about adding this prev_state check in
> > genpd_set_performance_state() itself ? We already have one for the
> > genpd in _genpd_set_performance_state(), why not one for the device ?
> >
> > > +           return prev_state;
> > > +
> > > +   return 0;
> >
> > Hmm, we will return 0 in case genpd_set_performance_state() fails,
> > which will make us set the state to 0 again on resume. Maybe add a
> > comment for this somewhere ?
>
> No, we won't as you check for rpm_saved_pstate there, so the device
> will stay disabled.
>
> Again adding the check into genpd_set_performance_state() may help
> reducing similar checks elsewhere.

Yes, at closer look, I think it makes sense to me as well.

Although, as it means a change in behaviour, I decided to make it a
separate patch. Let me respin the series to fold it in.

[...]

Thanks for reviewing!

Kind regards
Uffe
