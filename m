Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A94D8266252
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 17:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgIKPlD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 11:41:03 -0400
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.82]:26544 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgIKPiK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 11:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599838679;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=f6y/bT6EnhntnHIR9T0mnloocs8GUCAF0cvCMCuqaqw=;
        b=TkBtFKeZXwVmoqL8hTRa09ldIz+oBnR8o93riYLNwvKkjB86UWkwOFU6xvhB7xp1ky
        K9WWSLYBmv2K2/S1tjXwfDI8Lh34doLyUipY3RAqcLKnOlAY4891mo64Jyy8PP3qTWGs
        1GXcM/syxNGyrmowE8rxY5vkvZhOK9EJEZi6+SwKQFfAHaZvLt314CKDkUwPxkUOo6fo
        Qayb5YZkSeEFcrrKniwODAmFM1TyuQj0i2wwhgSMVd38+7V/xRSSy/TcXRz3EA0Vovhb
        uMRXaS3R1ZlI7xUSW1pB2M39jGkKNYkQtcwuYD2cvtFlfIbbR/7QS6t25HvdjjKF1ZyO
        Op9A==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEIdhPgVC7iy9yGr7ESbX"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w8BFbuNiG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Sep 2020 17:37:56 +0200 (CEST)
Date:   Fri, 11 Sep 2020 17:37:55 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200911153755.GB2352@gerhold.net>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
 <20200827114422.GA1784@gerhold.net>
 <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
 <20200828095706.GA1865@gerhold.net>
 <20200911083455.GA1591@gerhold.net>
 <20200911092538.jexqm6joww67d4yv@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200911092538.jexqm6joww67d4yv@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Sep 11, 2020 at 02:55:38PM +0530, Viresh Kumar wrote:
> > As mentioned in my other mail [1] it turns out I actually have such a
> > use case. I briefly explained it in [2], basically the clock that
> > provides higher CPU frequencies has some voltage requirements that
> > should be voted for using a power domain.
> > 
> > The clock that provides the lower CPU frequencies has no such
> > requirement, so I need to scale (and power on) a power domain only for
> > some of the OPPs.
> > 
> > [1]: https://lore.kernel.org/linux-pm/20200831154938.GA33622@gerhold.net/
> > [2]: https://lore.kernel.org/linux-arm-msm/20200910162610.GA7008@gerhold.net/
> > 
> > So I think it would be good to discuss this use case first before we
> > decide on this patch (how to enable power domains managed by the OPP
> > core). I think there are two problems that need to be solved:
> > 
> > 1. How can we drop our performance state votes for some of the OPPs?
> >    I explained that problem earlier already:
> > 
> > > 
> > > I was thinking about something like that, but can you actually drop
> > > your performance state vote for one of the power domains using
> > > "required-opps"?
> > > 
> > > At the moment it does not seem possible. I tried adding a special OPP
> > > using opp-level = <0> to reference that from required-opps, but the OPP
> > > core does not allow this:
> > > 
> > > 	vddcx: Not all nodes have performance state set (7: 6)
> > > 	vddcx: Failed to add OPP table for index 0: -2
> 
> This should fix it.
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index 214c1619b445..2483e765318a 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -2117,9 +2117,6 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
>         int dest_pstate = -EINVAL;
>         int i;
>  
> -       if (!pstate)
> -               return 0;
> -
>         /*
>          * Normally the src_table will have the "required_opps" property set to
>          * point to one of the OPPs in the dst_table, but in some cases the
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index e72753be7dc7..1a9cb96484bb 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -842,7 +842,7 @@ static struct dev_pm_opp *_opp_add_static_v2(struct opp_table *opp_table,
>  static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>  {
>         struct device_node *np;
> -       int ret, count = 0, pstate_count = 0;
> +       int ret, count = 0;
>         struct dev_pm_opp *opp;
>  
>         /* OPP table is already initialized for the device */
> @@ -876,20 +876,13 @@ static int _of_add_opp_table_v2(struct device *dev, struct opp_table *opp_table)
>                 goto remove_static_opp;
>         }
>  
> -       list_for_each_entry(opp, &opp_table->opp_list, node)
> -               pstate_count += !!opp->pstate;
> -
> -       /* Either all or none of the nodes shall have performance state set */
> -       if (pstate_count && pstate_count != count) {
> -               dev_err(dev, "Not all nodes have performance state set (%d: %d)\n",
> -                       count, pstate_count);
> -               ret = -ENOENT;
> -               goto remove_static_opp;
> +       list_for_each_entry(opp, &opp_table->opp_list, node) {
> +               if (opp->pstate) {
> +                       opp_table->genpd_performance_state = true;
> +                       break;
> +               }
>         }
>  
> -       if (pstate_count)
> -               opp_table->genpd_performance_state = true;
> -
>         return 0;
>  
>  remove_static_opp:
> 

Thanks, I will test this early next week!

> > 2. Where/when to enable the power domains: I need to enable the power
> >    domain whenever I have a vote for a performance state. In the example
> >    above the power domain should get enabled for >= 998 MHz and disabled
> >    otherwise.
> 

I will answer your questions for my use case, maybe Ulf or someone else
who knows more about power domains can chime in and say more about the
general case:

> - Why do you need to enable these power domains like this ?

At the moment power domains seem to have two independent states:
they can be powered on/off and they can have a performance state.
Both seem to be managed independently, e.g. a power domain can have a
non-zero performance state set but at the same time powered off.

The OPP core only calls dev_pm_genpd_set_performance_state(). No matter
if the power domain is powered on or not this will end up in the
set_performance_state() callback of the power domain driver.

And this is where behavior varies depending on the power domain driver.
Some drivers (e.g. qcom-cpr) will set the performance state even if
powered off, others (in my case: qcom rpmpd) will ignore the performance
state until their power_on() callback is called.

In general, I would expect that a power domain should be powered on
whenever there is at least one performance state vote > 0.
This does not seem to be the case at the moment, though.

> - What will happen if you don't enable them at all ?

If I add the power domains needed for CPUFreq to the CPU OPP table,
without further changes, nothing will power on the power domains.
There is no difference for qcom-cpr, but at least rpmpd will ignore all
the performance state votes.

> - What will happen if you enable them for ever ?
> 
> AFAIU, these are kind of virtual domains which are there just to vote in behalf
> of the OS. Only if the accumulated vote is greater than zero, the actual power
> domain will start consuming power. Otherwise it should be disabled.
> 
> Or is that wrong ?
> 

Right, at least in case of rpmpd the actual power domain is managed by
some "RPM" remote processor which accumulates votes from all the CPUs
running in the SoC.

I believe the power domains in my case are even always-on in the RPM,
but still the RPM interface seems to provide a way to vote for
enabling/disabling the power domains. Sadly it is barely documented,
so I'm not sure what happens if we keep the power domains permanently
powered on. Maybe it will block certain low power modes?

The current implementation in drivers/soc/qcom/rpmpd.c does suggest that
we should vote for "power off" when the power domains are no longer
needed by Linux.

(+CC Bjorn, Andy and linux-arm-msm, maybe they know more...)

Thanks!
Stephan
