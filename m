Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFF99257DEC
	for <lists+linux-pm@lfdr.de>; Mon, 31 Aug 2020 17:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgHaPtz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 Aug 2020 11:49:55 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:32951 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgHaPty (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 Aug 2020 11:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598888988;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=WnjBiD+YCLOi03utB1jGsKYrYVjk60pvHAwVXGX+bcs=;
        b=HEvtbZV+1c/AsWgYEq4KDfaf1iZIQ9pc/RbvKpRyj8dZ8vqGzTFn5D69C8zgu7Mxk+
        AUihFp2NlElWpytbmV/E2PlJ9RQI7isLg7VJWpI24pxmMmNlO0t3ym9wdKf4cmcPmHPx
        R8H9eQ2AcJz/N0bSCwgUyLiDebHKOQHS18EXFXjTmKyHrKNeMe2dPjnCHGJ+dSdX/qtf
        Mcfn1WuA0C5gJFrdd+kN9RhjIR7HYsNCeUGC53Tm69X8O0FrMP0X38llviKuLlzwmzMC
        /Nm9ulCbOyQECXoaBMBoM+N5UsCdiOzjVwPklcu2U7f6XPhXtJiiWv+NEZH1l1siHIhh
        JrKw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEIdhPgVC7iy9yGr7ESbX"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7VFnjEyb
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Mon, 31 Aug 2020 17:49:45 +0200 (CEST)
Date:   Mon, 31 Aug 2020 17:49:38 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Niklas Cassel <nks@flawful.org>
Subject: Re: [PATCH v2] opp: Power on (virtual) power domains managed by the
 OPP core
Message-ID: <20200831154938.GA33622@gerhold.net>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200831121457.2v6avendroclvrn5@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831121457.2v6avendroclvrn5@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Mon, Aug 31, 2020 at 05:44:57PM +0530, Viresh Kumar wrote:
> On 26-08-20, 11:33, Stephan Gerhold wrote:
> > dev_pm_opp_attach_genpd() allows attaching an arbitrary number of
> > power domains to an OPP table. In that case, the genpd core will
> > create a virtual device for each of the power domains.
> > 
> > At the moment, the OPP core only calls
> > dev_pm_genpd_set_performance_state() on these virtual devices.
> > It does not attempt to power on the power domains. Therefore
> > the required power domain might never get turned on.
> > 
> > So far, dev_pm_opp_attach_genpd() is only used in qcom-cpufreq-nvmem.c
> > to attach the CPR power domain to the CPU OPP table. The CPR driver
> > does not check if it was actually powered on so this did not cause
> > any problems. However, other drivers (e.g. rpmpd) might ignore the
> > performance state until the power domain is actually powered on.
> > 
> > Since these virtual devices are managed exclusively by the OPP core,
> > I would say that it should also be responsible to ensure they are
> > enabled.
> > 
> > This commit implements this similar to the non-virtual power domains;
> > we create device links for each of attached power domains so that they
> > are turned on whenever the consumer device is active.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> 
> Applied with some changes, hope that is fine:
> 

I appreciate it, thank you! But actually after our discussion regarding
the "manage multiple power domains which might not always need to be on"
use case I would like to explore that a bit further before we decide on
a final solution that complicates changes later.

The reason I mention this is that after our discussion I have been
(again) staring at the vendor implementation of CPU frequency scaling of
the platform I'm working on (qcom msm8916). Actually there seems to be yet
another power domain that is scaled only for some CPU frequencies within
the clock driver. (The vendor driver implies this is a requirement of
the PLL clock that is used for higher CPU frequencies, but not sure...)

I don't fully understand how to implement this in mainline yet. I have
started some research on these "voltage requirements" for clocks, and
based on previous discussions [1] and patches [2] it seems like I'm
*not* supposed to add this to the clock driver, but rather as another
required-opp to the CPU OPP table.

If that is the case, we would pretty much have a situation like you
described, a power domain that should only be scaled for some of the
OPPs (the higher CPU frequencies).

But first I need to do some more research, and probably discuss how to
handle that power domain separately first. I think it would be easier if
we postpone this patch till then. I don't think anyone else needs this
patch at the moment.

[1]: https://lore.kernel.org/linux-clk/9439bd29e3ccd5424a8e9b464c8c7bd9@codeaurora.org/
[2]: https://lore.kernel.org/linux-pm/20190320094918.20234-1-rnayak@codeaurora.org/

> Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> [ Viresh: Rearranged the code to remove extra loop and minor cleanup ]

FWIW, the reason I put this into an extra loop is that the
dev_pm_domain_attach_by_name() might return -EPROBE_DEFER (or some other
error) for some of the power domains. If you create the device links
before attaching all domains you might unnecessarily turn on+off some of
them.

Having it in a separate loop avoids that, because we only start powering
on the power domains when we know that all the power domains are
available.

Thanks!
Stephan

> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/opp/core.c | 37 ++++++++++++++++++++++++++++++++++++-
>  drivers/opp/opp.h  |  1 +
>  2 files changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> index e65174725a4d..b608b0253079 100644
> --- a/drivers/opp/core.c
> +++ b/drivers/opp/core.c
> @@ -17,6 +17,7 @@
>  #include <linux/device.h>
>  #include <linux/export.h>
>  #include <linux/pm_domain.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
>  
>  #include "opp.h"
> @@ -1967,10 +1968,15 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
>  		if (!opp_table->genpd_virt_devs[index])
>  			continue;
>  
> +		if (opp_table->genpd_virt_links[index])
> +			device_link_del(opp_table->genpd_virt_links[index]);
> +
>  		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
>  		opp_table->genpd_virt_devs[index] = NULL;
>  	}
>  
> +	kfree(opp_table->genpd_virt_links);
> +	opp_table->genpd_virt_links = NULL;
>  	kfree(opp_table->genpd_virt_devs);
>  	opp_table->genpd_virt_devs = NULL;
>  }
> @@ -2002,8 +2008,10 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>  {
>  	struct opp_table *opp_table;
>  	struct device *virt_dev;
> +	struct device_link *dev_link;
>  	int index = 0, ret = -EINVAL;
>  	const char **name = names;
> +	u32 flags;
>  
>  	opp_table = dev_pm_opp_get_opp_table(dev);
>  	if (IS_ERR(opp_table))
> @@ -2030,6 +2038,21 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>  	if (!opp_table->genpd_virt_devs)
>  		goto unlock;
>  
> +	opp_table->genpd_virt_links = kcalloc(opp_table->required_opp_count,
> +					      sizeof(*opp_table->genpd_virt_links),
> +					      GFP_KERNEL);
> +	if (!opp_table->genpd_virt_links) {
> +		kfree(opp_table->genpd_virt_devs);
> +		opp_table->genpd_virt_devs = NULL;
> +		goto unlock;
> +	}
> +
> +	/* Turn on power domain initially if consumer is active */
> +	pm_runtime_get_noresume(dev);
> +	flags = DL_FLAG_PM_RUNTIME | DL_FLAG_STATELESS;
> +	if (pm_runtime_active(dev))
> +		flags |= DL_FLAG_RPM_ACTIVE;
> +
>  	while (*name) {
>  		if (index >= opp_table->required_opp_count) {
>  			dev_err(dev, "Index can't be greater than required-opp-count - 1, %s (%d : %d)\n",
> @@ -2043,12 +2066,23 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>  			dev_err(dev, "Couldn't attach to pm_domain: %d\n", ret);
>  			goto err;
>  		}
> -
>  		opp_table->genpd_virt_devs[index] = virt_dev;
> +
> +		/* Create device links to manage runtime PM */
> +		dev_link = device_link_add(dev, opp_table->genpd_virt_devs[index],
> +					   flags);
> +		if (!dev_link) {
> +			dev_err(dev, "Failed to create device link\n");
> +			goto err;
> +		}
> +		opp_table->genpd_virt_links[index] = dev_link;
> +
>  		index++;
>  		name++;
>  	}
>  
> +	pm_runtime_put(dev);
> +
>  	if (virt_devs)
>  		*virt_devs = opp_table->genpd_virt_devs;
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
> @@ -2056,6 +2090,7 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
>  	return opp_table;
>  
>  err:
> +	pm_runtime_put(dev);
>  	_opp_detach_genpd(opp_table);
>  unlock:
>  	mutex_unlock(&opp_table->genpd_virt_dev_lock);
> diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
> index 78e876ec803e..be5526cdbdba 100644
> --- a/drivers/opp/opp.h
> +++ b/drivers/opp/opp.h
> @@ -186,6 +186,7 @@ struct opp_table {
>  
>  	struct mutex genpd_virt_dev_lock;
>  	struct device **genpd_virt_devs;
> +	struct device_link **genpd_virt_links;
>  	struct opp_table **required_opp_tables;
>  	unsigned int required_opp_count;
