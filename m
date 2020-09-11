Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC13F265BB4
	for <lists+linux-pm@lfdr.de>; Fri, 11 Sep 2020 10:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725778AbgIKIfM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 11 Sep 2020 04:35:12 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:27191 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgIKIfI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 11 Sep 2020 04:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599813302;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=7sx4/EPNUP09DwZc2KWs5gmrSO/3qsHOgl5SFdZtzfk=;
        b=JJR/R2cK3UENYguz9SU5aSJP754bpZrYivWGarMPO6HshroE/IcehOPwg2yw7w4DTS
        zd4E0j2FkGCcjJIYxiwfOAg0ddEQhOq9yxbFVWj5deFAAi1HrMhxNkYdlFh517r7hEOD
        EsSLo0Kw9hsF6JKiz520RNfurX5w3R2Kki19taCQfE3l9jKjpViwL5g9WzU2q3xAi3ui
        Zt20cBYzDPEfConBD5ULwkT7K4puSrLpnyCYAaxkeE5TbfjYxmuJGIlR6xoR8eMo7rDO
        g71fKq49geCo24nqJ2Hw2yZSPS9OGGczcAEaKSts2jMzuOfBhiiiomS/TrN4FPmkAId/
        sg5Q==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEIdhPgVC7iy9yGr7ESbX"
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w8B8Z0Lek
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 11 Sep 2020 10:35:00 +0200 (CEST)
Date:   Fri, 11 Sep 2020 10:34:55 +0200
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
Message-ID: <20200911083455.GA1591@gerhold.net>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
 <20200827114422.GA1784@gerhold.net>
 <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
 <20200828095706.GA1865@gerhold.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828095706.GA1865@gerhold.net>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On Fri, Aug 28, 2020 at 11:57:28AM +0200, Stephan Gerhold wrote:
> On Fri, Aug 28, 2020 at 12:05:11PM +0530, Viresh Kumar wrote:
> > On 27-08-20, 13:44, Stephan Gerhold wrote:
> > > Hmm. Actually I was using this parameter for initial testing, and forced
> > > on the power domains from the qcom-cpufreq-nvmem driver. For my v1 patch
> > > I wanted to enable the power domains in dev_pm_opp_set_rate(), so there
> > > using the virt_devs parameter was not possible.
> > 
> > Right, as we really do not want to enable it there and leave it for
> > the real consumers to handle.
> > 
> > > On the other hand, creating the device links would be possible from the
> > > platform driver by using the parameter.
> > 
> > Right.
> > 
> > > > And so I think again if this patch should be picked instead of letting
> > > > the platform handle this ?
> > > 
> > > It seems like originally the motivation for the parameter was that
> > > cpufreq consumers do *not* need to power on the power domains:
> > > 
> > > Commit 17a8f868ae3e ("opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()"):
> > >  "The cpufreq drivers don't need to do runtime PM operations on
> > >   the virtual devices returned by dev_pm_domain_attach_by_name() and so
> > >   the virtual devices weren't shared with the callers of
> > >   dev_pm_opp_attach_genpd() earlier.
> > > 
> > >   But the IO device drivers would want to do that. This patch updates
> > >   the prototype of dev_pm_opp_attach_genpd() to accept another argument
> > >   to return the pointer to the array of genpd virtual devices."
> > 
> > Not just that I believe. There were also arguments that only the real
> > consumer knows how to handle multiple power domains. For example for a
> > USB or Camera module which can work in multiple modes, we may want to
> > enable only one power domain in say slow mode and another power domain
> > in fast mode. And so these kind of complex behavior/choices better be
> > left for the end consumer and not try to handle this generically in
> > the OPP core.
> > 
> [...]
> 
> It seems to me that there is more work needed to make such a use case
> really work, but it's hard to speculate without a real example.
> 

So it seems like we have a real example now. :)

As mentioned in my other mail [1] it turns out I actually have such a
use case. I briefly explained it in [2], basically the clock that
provides higher CPU frequencies has some voltage requirements that
should be voted for using a power domain.

The clock that provides the lower CPU frequencies has no such
requirement, so I need to scale (and power on) a power domain only for
some of the OPPs.

[1]: https://lore.kernel.org/linux-pm/20200831154938.GA33622@gerhold.net/
[2]: https://lore.kernel.org/linux-arm-msm/20200910162610.GA7008@gerhold.net/

So I think it would be good to discuss this use case first before we
decide on this patch (how to enable power domains managed by the OPP
core). I think there are two problems that need to be solved:

1. How can we drop our performance state votes for some of the OPPs?
   I explained that problem earlier already:

> 
> I was thinking about something like that, but can you actually drop
> your performance state vote for one of the power domains using
> "required-opps"?
> 
> At the moment it does not seem possible. I tried adding a special OPP
> using opp-level = <0> to reference that from required-opps, but the OPP
> core does not allow this:
> 
> 	vddcx: Not all nodes have performance state set (7: 6)
> 	vddcx: Failed to add OPP table for index 0: -2
> 
> So the "virt_devs" parameter would allow you to disable the power
> domain, but not to drop your performance state vote (you could only vote
> for the lowest OPP, not 0...)

Not sure if it makes sense but I think somehow allowing the additional
opp-level = <0> would be a simple solution. For example:

	rpmpd: power-controller {
		rpmpd_opp_table: opp-table {
			compatible = "operating-points-v2";

            /*
             * This one can be referenced to drop the performance state
             * vote within required-opps.
             */
            rpmpd_opp_none: opp0 {
                opp-level = <0>;
            };

			rpmpd_opp_retention: opp1 {
				opp-level = <1>;
			};

            /* ... */
        };
    };                

	cpu_opp_table: cpu-opp-table {
		compatible = "operating-points-v2";
		opp-shared;

        /* Power domain is only needed for frequencies >= 998 MHz */
		opp-200000000 {
			opp-hz = /bits/ 64 <200000000>;
			required-opps = <&rpmpd_opp_none>; /* = drop perf state */
		};
		opp-998400000 {
			opp-hz = /bits/ 64 <998400000>;
			required-opps = <&rpmpd_opp_svs_soc>;
		};
		opp-1209600000 {
			opp-hz = /bits/ 64 <1209600000>;
			required-opps = <&rpmpd_opp_nominal>;
		};
	};	

2. Where/when to enable the power domains: I need to enable the power
   domain whenever I have a vote for a performance state. In the example
   above the power domain should get enabled for >= 998 MHz and disabled
   otherwise.

   At least for the CPUFreq case the "virt_devs" parameter does not
   really help in this case...
   dev_pm_opp_set_rate() is called within cpufreq-dt which is supposed
   to be generic. So I can't enable the power domains myself from there.
   Even if I made a custom cpufreq driver that has control over the
   dev_pm_opp_set_rate() call - I don't really know exactly in the
   driver for which frequencies a power domain is needed.

   On the other hand, the OPP core does have that information.
   This brings me back to my PATCH v1 (where I used runtime PM functions
   instead of device links). If I modify it to enable the power domain
   whenever we have a performance state vote > 0 when setting an OPP,
   it would do exactly what I need...

   I don't think it makes sense to do performance state votes without
   enabling a power domain, so this approach sounds good to me...

What do you think?

Thanks!
Stephan
