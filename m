Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88A8324DB04
	for <lists+linux-pm@lfdr.de>; Fri, 21 Aug 2020 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgHUQce (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 Aug 2020 12:32:34 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:18647 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbgHUQcQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Aug 2020 12:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598027524;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=5oM6hmHrkxSTh2VeiPEAHTyoVLjwfurKxWYpMhitciA=;
        b=M/KVTksU1p3DnoGrWCOFV3S16GhMXigs6zNTYa6Ps/mQHpp7FoTQWk90YclJeUCZBk
        vaQ1Zx86QhUZ814akr4NwjdgA8WMmr9eqoP4j5lff+v0GMOfFNVyvtJCTz7UHEvVAMQP
        84c2RMMWhKEjSQo1nZOJtkm7V56+696yIE73JaH1YT2P1nmqxURvDepFmwc2QqlX1vZI
        dGMpTmxSCW0gfw56YedVk2WOsT9u0+cfw7Vejr2etSAcU0jNzi1Zop2stgtLj5PwEby8
        /xzScXcrR7NCfd4P/6HMrccilo8bnsZ+PMzTdGdPWfCf8hmdYIW4fstVZo8pkP+GAyM+
        ITWw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7LGW2KXw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 21 Aug 2020 18:32:02 +0200 (CEST)
Date:   Fri, 21 Aug 2020 18:31:52 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 2/3] opp: Set required OPPs in reverse order when
 scaling down
Message-ID: <20200821163152.GA3422@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-3-stephan@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730080146.25185-3-stephan@gerhold.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Thu, Jul 30, 2020 at 10:01:45AM +0200, Stephan Gerhold wrote:
> The OPP core already has well-defined semantics to ensure required
> OPPs/regulators are set before/after the frequency change, depending
> on if we scale up or down.
> 
> Similar requirements might exist for the order of required OPPs
> when multiple power domains need to be scaled for a frequency change.
> 
> For example, on Qualcomm platforms using CPR (Core Power Reduction),
> we need to scale the VDDMX and CPR power domain. When scaling up,
> MX should be scaled up before CPR. When scaling down, CPR should be
> scaled down before MX.
> 
> In general, if there are multiple "required-opps" in the device tree
> I would expect that the order is either irrelevant, or there is some
> dependency between the power domains. In that case, the power domains
> should be scaled down in reverse order.
> 
> This commit updates _set_required_opps() to set required OPPs in
> reverse order when scaling down.
> 
> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>

This patch does not apply anymore after the cleanup you pushed to
opp/linux-next. I would be happy to send a v2 with that fixed.

On my other OPP patch set you mentioned that you might apply these
directly with some of your own changes - would you also prefer to do it
yourself in this case or should I send a v2?

Still looking for your feedback on both patch sets by the way! :)

Thanks!
Stephan

> ---
> Related discussion: https://lore.kernel.org/linux-arm-msm/20200525194443.GA11851@flawful.org/
> 
> The advantage of this approach is that the CPR driver does not need
> to bother with the VDDMX power domain at all - the requirements
> can be fully described within the device tree, see e.g. [1].
> An alternative option would be to modify the CPR driver to make these votes.
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20200507104603.GA581328@gerhold.net/2-msm8916-vdd-mx.patch
> ---
>  drivers/opp/core.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index f7a476b55069..f93f551c911e 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -799,7 +799,7 @@ static int _set_required_opp(struct device *dev, struct device *pd_dev,
>  /* This is only called for PM domain for now */
>  static int _set_required_opps(struct device *dev,
>  			      struct opp_table *opp_table,
> -			      struct dev_pm_opp *opp)
> +			      struct dev_pm_opp *opp, bool up)
>  {
>  	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
>  	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
> @@ -821,12 +821,24 @@ static int _set_required_opps(struct device *dev,
>  	 */
>  	mutex_lock(&opp_table->genpd_virt_dev_lock);
>  
> -	for (i = 0; i < opp_table->required_opp_count; i++) {
> -		pd_dev = genpd_virt_devs[i];
> +	if (up) {
> +		/* Scaling up? Set required OPPs in normal order */
> +		for (i = 0; i < opp_table->required_opp_count; i++) {
> +			pd_dev = genpd_virt_devs[i];
>  
> -		ret = _set_required_opp(dev, pd_dev, opp, i);
> -		if (ret)
> -			break;
> +			ret = _set_required_opp(dev, pd_dev, opp, i);
> +			if (ret)
> +				break;
> +		}
> +	} else {
> +		/* Scaling down? Set required OPPs in reverse order */
> +		for (i = opp_table->required_opp_count - 1; i >= 0; i--) {
> +			pd_dev = genpd_virt_devs[i];
> +
> +			ret = _set_required_opp(dev, pd_dev, opp, i);
> +			if (ret)
> +				break;
> +		}
>  	}
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
>  
> @@ -914,7 +926,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  			opp_table->regulator_enabled = false;
>  		}
>  
> -		ret = _set_required_opps(dev, opp_table, NULL);
> +		ret = _set_required_opps(dev, opp_table, NULL, false);
>  		goto put_opp_table;
>  	}
>  
> @@ -973,7 +985,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  	/* Scaling up? Configure required OPPs before frequency */
>  	if (freq >= old_freq) {
> -		ret = _set_required_opps(dev, opp_table, opp);
> +		ret = _set_required_opps(dev, opp_table, opp, true);
>  		if (ret)
>  			goto put_opp;
>  	}
> @@ -993,7 +1005,7 @@ int dev_pm_opp_set_rate(struct device *dev, unsigned long target_freq)
>  
>  	/* Scaling down? Configure required OPPs after frequency */
>  	if (!ret && freq < old_freq) {
> -		ret = _set_required_opps(dev, opp_table, opp);
> +		ret = _set_required_opps(dev, opp_table, opp, false);
>  		if (ret)
>  			dev_err(dev, "Failed to set required opps: %d\n", ret);
>  	}
> -- 
> 2.27.0
> 
