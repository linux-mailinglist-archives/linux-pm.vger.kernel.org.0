Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9F24FCA1
	for <lists+linux-pm@lfdr.de>; Mon, 24 Aug 2020 13:32:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgHXLcq (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 24 Aug 2020 07:32:46 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:13489 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgHXLal (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Aug 2020 07:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598268623;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=LNrpIGVjKdlFFg7JrV48iDL/9D5btHkuQx1faS/GNEU=;
        b=MdmzlP1FocVEqd05o+I0ToPylCOtIS6VLYqpWPGuqLgzYwMMxdDcPhkLJ/GMU/6XE0
        7h3x3SU7tC1fHdA6zLYLI8O+KmbNT++Dvl52SclXHSJoU7nhc4kgXaxZYOFTzpyxsyU2
        qM3FkngAxR3goZPpBIDzLkiSjBsgi2Xx9KjFGFDQTd+GuD+CYWwti3gcSGkWJO7uisQG
        aw3TIomsglInr/qMpKc4owMnymEmEC97tpa6O8QLegh4KG/WtYFUkaIxQgt/rwkXTO7I
        g5keka+Aqwi+Qw8zHT13OV7OxCSvoj4xx8ENlrkH2VVqqU6vqG1mUjBUgd2WuTsLRZvH
        tlBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/MbIo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7OBULWmA
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 24 Aug 2020 13:30:21 +0200 (CEST)
Date:   Mon, 24 Aug 2020 13:30:16 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [RFC PATCH 1/3] opp: Reduce code duplication in
 _set_required_opps()
Message-ID: <20200824113016.GA131681@gerhold.net>
References: <20200730080146.25185-1-stephan@gerhold.net>
 <20200730080146.25185-2-stephan@gerhold.net>
 <20200824111820.rcaingohxw3wozgd@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824111820.rcaingohxw3wozgd@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Aug 24, 2020 at 04:48:20PM +0530, Viresh Kumar wrote:
> On 30-07-20, 10:01, Stephan Gerhold wrote:
> > Move call to dev_pm_genpd_set_performance_state() to a separate
> > function so we can avoid duplicating the code for the single and
> > multiple genpd case.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  drivers/opp/core.c | 40 +++++++++++++++++++++-------------------
> >  1 file changed, 21 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 9d7fb45b1786..f7a476b55069 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -781,6 +781,21 @@ static int _set_opp_custom(const struct opp_table *opp_table,
> >  	return opp_table->set_opp(data);
> >  }
> >  
> > +static int _set_required_opp(struct device *dev, struct device *pd_dev,
> > +			     struct dev_pm_opp *opp, int i)
> > +{
> > +	unsigned int pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
> > +	int ret;
> > +
> > +	ret = dev_pm_genpd_set_performance_state(pd_dev, pstate);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
> > +			dev_name(pd_dev), pstate, ret);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> >  /* This is only called for PM domain for now */
> >  static int _set_required_opps(struct device *dev,
> >  			      struct opp_table *opp_table,
> > @@ -788,22 +803,15 @@ static int _set_required_opps(struct device *dev,
> >  {
> >  	struct opp_table **required_opp_tables = opp_table->required_opp_tables;
> >  	struct device **genpd_virt_devs = opp_table->genpd_virt_devs;
> > -	unsigned int pstate;
> > +	struct device *pd_dev;
> >  	int i, ret = 0;
> >  
> >  	if (!required_opp_tables)
> >  		return 0;
> >  
> >  	/* Single genpd case */
> > -	if (!genpd_virt_devs) {
> > -		pstate = likely(opp) ? opp->required_opps[0]->pstate : 0;
> > -		ret = dev_pm_genpd_set_performance_state(dev, pstate);
> > -		if (ret) {
> > -			dev_err(dev, "Failed to set performance state of %s: %d (%d)\n",
> > -				dev_name(dev), pstate, ret);
> > -		}
> > -		return ret;
> > -	}
> > +	if (!genpd_virt_devs)
> > +		return _set_required_opp(dev, dev, opp, 0);
> >  
> >  	/* Multiple genpd case */
> >  
> > @@ -814,17 +822,11 @@ static int _set_required_opps(struct device *dev,
> >  	mutex_lock(&opp_table->genpd_virt_dev_lock);
> >  
> >  	for (i = 0; i < opp_table->required_opp_count; i++) {
> > -		pstate = likely(opp) ? opp->required_opps[i]->pstate : 0;
> > -
> > -		if (!genpd_virt_devs[i])
> > -			continue;
> 
> Don't we need this check anymore ?
> 

You're right. Not sure why I removed it.

I suspect I had it in _set_required_opp() at some point, but I moved
code around several times until I was happy with the result.

We should just add it back.
Should I send a v2 with it fixed or would you like to handle it?

Thanks,
Stephan

> > +		pd_dev = genpd_virt_devs[i];
> >  
> > -		ret = dev_pm_genpd_set_performance_state(genpd_virt_devs[i], pstate);
> > -		if (ret) {
> > -			dev_err(dev, "Failed to set performance rate of %s: %d (%d)\n",
> > -				dev_name(genpd_virt_devs[i]), pstate, ret);
> > +		ret = _set_required_opp(dev, pd_dev, opp, i);
> > +		if (ret)
> >  			break;
> > -		}
> >  	}
> >  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
> >  
> > -- 
> > 2.27.0
