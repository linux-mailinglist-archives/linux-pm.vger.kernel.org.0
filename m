Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3620E2548B7
	for <lists+linux-pm@lfdr.de>; Thu, 27 Aug 2020 17:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgH0PK6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Aug 2020 11:10:58 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:10938 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728874AbgH0LpU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Aug 2020 07:45:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598528669;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=woZpEfnFaBE4cm7/zjsWew74v/fudZ9kURmp1bF8wmQ=;
        b=eJry3dtLZnw52U2jiLBK5/IvrSSxCyi17Lzp5sXI5X76AAcW+oVzeOaRo0MGqRFT1l
        7JxIJMfVSoqipbMTd1sIKLNiMejQXQeAbjKKXHFjW+tBRu0GLWLzQbrDiU/iBCeSVtdN
        rdsAUCaJie7Pz5//Phs8o1dS+fDpnhXLCHDgAvH8PkKG1JyeA/rknodsRvElM/X8VFv3
        VewlDeQ8LOIWdnWf/B3dAmZdAt4+OoBo5Zcpyb7DW/tQcgGDhceF9WYe4EXsta/zxRv4
        zBGg2TpNGv3/8b5xuQ+rwbafG/AgQnMWuwefQLeEpD4kN8+6g3ovsOq4G/uV+HxztZbi
        h6nw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7Ic/Fboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7RBiRtNJ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 27 Aug 2020 13:44:27 +0200 (CEST)
Date:   Thu, 27 Aug 2020 13:44:22 +0200
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
Message-ID: <20200827114422.GA1784@gerhold.net>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Aug 27, 2020 at 03:31:04PM +0530, Viresh Kumar wrote:
> On 26-08-20, 11:33, Stephan Gerhold wrote:
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index 8b3c3986f589..7e53a7b94c59 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -17,6 +17,7 @@
> >  #include <linux/device.h>
> >  #include <linux/export.h>
> >  #include <linux/pm_domain.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/regulator/consumer.h>
> >  
> >  #include "opp.h"
> > @@ -1964,10 +1965,13 @@ static void _opp_detach_genpd(struct opp_table *opp_table)
> >  		if (!opp_table->genpd_virt_devs[index])
> >  			continue;
> >  
> > +		if (opp_table->genpd_virt_links && opp_table->genpd_virt_links[index])
> > +			device_link_del(opp_table->genpd_virt_links[index]);
> >  		dev_pm_domain_detach(opp_table->genpd_virt_devs[index], false);
> >  		opp_table->genpd_virt_devs[index] = NULL;
> >  	}
> >  
> > +	kfree(opp_table->genpd_virt_links);
> >  	kfree(opp_table->genpd_virt_devs);
> >  	opp_table->genpd_virt_devs = NULL;
> >  }
> > @@ -1999,8 +2003,10 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> >  {
> >  	struct opp_table *opp_table;
> >  	struct device *virt_dev;
> > -	int index = 0, ret = -EINVAL;
> > +	struct device_link *dev_link;
> > +	int index = 0, ret = -EINVAL, num_devs;
> >  	const char **name = names;
> > +	u32 flags;
> >  
> >  	opp_table = dev_pm_opp_get_opp_table(dev);
> >  	if (IS_ERR(opp_table))
> > @@ -2049,6 +2055,32 @@ struct opp_table *dev_pm_opp_attach_genpd(struct device *dev,
> 
> I was about to apply this patch when I noticed that this routine does
> return the array of virtual devices back to the caller, like the qcom
> cpufreq driver in this case. IIRC we did it this way as a generic
> solution for this in the OPP core wasn't preferable.
> 

Hmm. Actually I was using this parameter for initial testing, and forced
on the power domains from the qcom-cpufreq-nvmem driver. For my v1 patch
I wanted to enable the power domains in dev_pm_opp_set_rate(), so there
using the virt_devs parameter was not possible.

On the other hand, creating the device links would be possible from the
platform driver by using the parameter.

> And so I think again if this patch should be picked instead of letting
> the platform handle this ?
> 

It seems like originally the motivation for the parameter was that
cpufreq consumers do *not* need to power on the power domains:

Commit 17a8f868ae3e ("opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()"):
 "The cpufreq drivers don't need to do runtime PM operations on
  the virtual devices returned by dev_pm_domain_attach_by_name() and so
  the virtual devices weren't shared with the callers of
  dev_pm_opp_attach_genpd() earlier.

  But the IO device drivers would want to do that. This patch updates
  the prototype of dev_pm_opp_attach_genpd() to accept another argument
  to return the pointer to the array of genpd virtual devices."

But the reason why I made this patch is that actually something *should*
enable the power domains even for the cpufreq case.
If every user of dev_pm_opp_attach_genpd() ends up creating these device
links we might as well manage those directly from the OPP core.

I cannot think of any use case where you would not want to manage those
power domains using device links. And if there is such a use case,
chances are good that this use case is so special that using the OPP API
to set the performance states would not work either. In either case,
this seems like something that should be discussed once there is such a
use case.

At the moment, there are only two users of dev_pm_opp_attach_genpd():

  - cpufreq (qcom-cpufreq-nvmem)
  - I/O (venus, recently added in linux-next [1])

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9a538b83612c8b5848bf840c2ddcd86dda1c8c76

In fact, venus adds the device link exactly the same way as in my patch.
So we could move that to the OPP core, simplify the venus code and
remove the virt_devs parameter. That would be my suggestion.

I can submit a v3 with that if you agree (or we take this patch as-is
and remove the parameter separately - I just checked and creating a
device link twice does not seem to cause any problems...)

Thanks!
Stephan
