Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474C425581C
	for <lists+linux-pm@lfdr.de>; Fri, 28 Aug 2020 11:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728992AbgH1J5h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 28 Aug 2020 05:57:37 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.53]:15036 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1J5e (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 28 Aug 2020 05:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1598608649;
        s=strato-dkim-0002; d=gerhold.net;
        h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YjfH7QyaKxTYIsFfzlcBW5COp7oPU6UK9fex8RvP2Uc=;
        b=JifL3p9VfENJUY6+0ZbNprSl5/tpmrnjLIUJl/plHyghMcffooxBN76wqxtRXCpUNz
        eMsg0neOXlFHy42PuZSxASjq172wsucE1cezWXJYlMRjpERj3ylqa7i9UhxysrtgjyoE
        dukQo4UDQQE31e1DRI4F9oXSRtExsh6ipFhJCbBRsqSps77DUAW9NgDOMX8vNFkiWAwU
        i2b422+joZL36ZqRw+M1CqbFh1oCtU38gJnGfPjGR7rknamtqBNKSShbtQ9diF8hJYf1
        oPqZxEHCjTrueKCKFemKMI+zwWB35pf8wxDFsaSs3x3RPwN+yV88KpFv+7Acza65PZ8N
        Rhdw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8j7IczHboo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id g0b6c1w7S9vSzAy
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Fri, 28 Aug 2020 11:57:28 +0200 (CEST)
Date:   Fri, 28 Aug 2020 11:57:17 +0200
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
Message-ID: <20200828095706.GA1865@gerhold.net>
References: <20200826093328.88268-1-stephan@gerhold.net>
 <20200827100104.yuf2nzb6qras7zcw@vireshk-i7>
 <20200827114422.GA1784@gerhold.net>
 <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828063511.y47ofywtu5qo57bq@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Fri, Aug 28, 2020 at 12:05:11PM +0530, Viresh Kumar wrote:
> On 27-08-20, 13:44, Stephan Gerhold wrote:
> > Hmm. Actually I was using this parameter for initial testing, and forced
> > on the power domains from the qcom-cpufreq-nvmem driver. For my v1 patch
> > I wanted to enable the power domains in dev_pm_opp_set_rate(), so there
> > using the virt_devs parameter was not possible.
> 
> Right, as we really do not want to enable it there and leave it for
> the real consumers to handle.
> 
> > On the other hand, creating the device links would be possible from the
> > platform driver by using the parameter.
> 
> Right.
> 
> > > And so I think again if this patch should be picked instead of letting
> > > the platform handle this ?
> > 
> > It seems like originally the motivation for the parameter was that
> > cpufreq consumers do *not* need to power on the power domains:
> > 
> > Commit 17a8f868ae3e ("opp: Return genpd virtual devices from dev_pm_opp_attach_genpd()"):
> >  "The cpufreq drivers don't need to do runtime PM operations on
> >   the virtual devices returned by dev_pm_domain_attach_by_name() and so
> >   the virtual devices weren't shared with the callers of
> >   dev_pm_opp_attach_genpd() earlier.
> > 
> >   But the IO device drivers would want to do that. This patch updates
> >   the prototype of dev_pm_opp_attach_genpd() to accept another argument
> >   to return the pointer to the array of genpd virtual devices."
> 
> Not just that I believe. There were also arguments that only the real
> consumer knows how to handle multiple power domains. For example for a
> USB or Camera module which can work in multiple modes, we may want to
> enable only one power domain in say slow mode and another power domain
> in fast mode. And so these kind of complex behavior/choices better be
> left for the end consumer and not try to handle this generically in
> the OPP core.
> 

I was thinking about something like that, but can you actually drop
your performance state vote for one of the power domains using
"required-opps"?

At the moment it does not seem possible. I tried adding a special OPP
using opp-level = <0> to reference that from required-opps, but the OPP
core does not allow this:

	vddcx: Not all nodes have performance state set (7: 6)
	vddcx: Failed to add OPP table for index 0: -2

So the "virt_devs" parameter would allow you to disable the power
domain, but not to drop your performance state vote (you could only vote
for the lowest OPP, not 0...)

This is why I said: "And if there is such a use case, chances are good
that this use case is so special that using the OPP API to set the
performance states would not work either."

It seems to me that there is more work needed to make such a use case
really work, but it's hard to speculate without a real example.

> > But the reason why I made this patch is that actually something *should*
> > enable the power domains even for the cpufreq case.
> 
> Ulf, what do you think about this ? IIRC from our previous discussions
> someone asked me not do so.
> 
> > If every user of dev_pm_opp_attach_genpd() ends up creating these device
> > links we might as well manage those directly from the OPP core.
> 
> Sure, I am all in for reducing code duplication, but ...
> 
> > I cannot think of any use case where you would not want to manage those
> > power domains using device links. And if there is such a use case,
> > chances are good that this use case is so special that using the OPP API
> > to set the performance states would not work either. In either case,
> > this seems like something that should be discussed once there is such a
> > use case.
> 
> The example I gave earlier shows a common case where we need to handle
> this at the end users which still want to use the OPP API.
> 
> > At the moment, there are only two users of dev_pm_opp_attach_genpd():
> > 
> >   - cpufreq (qcom-cpufreq-nvmem)
> >   - I/O (venus, recently added in linux-next [1])
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=9a538b83612c8b5848bf840c2ddcd86dda1c8c76
> > 
> > In fact, venus adds the device link exactly the same way as in my patch.
> > So we could move that to the OPP core, simplify the venus code and
> > remove the virt_devs parameter. That would be my suggestion.
> > 
> > I can submit a v3 with that if you agree (or we take this patch as-is
> > and remove the parameter separately - I just checked and creating a
> > device link twice does not seem to cause any problems...)
> 
> I normally tend to agree with the logic that lets only focus on what's
> upstream and not think of virtual cases which may never happen. But I
> was told that this is too common of a scenario and so it made sense to
> do it this way.
> 

Well, if we're talking about theoretical use cases it's even hard to
make assumptions for the CPUFreq use case.

Theoretically speaking you would assume that you can disable or at least
reduce the performance votes for a power domain used by a CPU if it is
turned off (hotplug / idle). In practice this is probably hard because
the CPU will need these resources until it's actually off, so if the CPU
enters the idle state itself we don't really have a chance to do that
from Linux.

On qcom this is handled by voting for resources controlled by a remote
processor (which knows when we go to idle), so having the power domains
always on is just what I need.
But who knows what you would need on other platforms...

Honestly, I don't know what would be best in this case. I suppose if in
doubt we should rather duplicate some code for now and de-duplicate later
when we (might) know more about other use cases.

FWIW, I think my original motivation to enable the power domains from
the OPP core was that I wanted to suggest making it possible for the OPP
core to manage power domains without involving the consumer driver.

For example, a device tree property like "required-power-domains":

	cpu-opp-table {
		compatible = "operating-points-v2";
		required-power-domains = "mx";

		opp-998400000 {
			opp-hz = /bits/ 64 <998400000>;
			required-opps = <&rpmpd_opp_super_turbo>;
		};
	};

Main motivation for this change is something I mentioned a while ago [1]:
Since the order and names of the power domains is currently hardcoded
in the consumer driver, the device tree does not give any hint
which power domain we are actually controlling with the "required-opps".

Plus, with the current approach it would be quite hard to add new power
domains to an OPP table, or even to change their order. Not sure if this
would really happen that often, though.

But with all the discussions about whether it's a good idea to let the
OPP core enable the power domains or not, I'm not sure if this is really
something that would work properly...

Well, I wanted to mention it :)

Thanks!
Stephan

[1]: https://lore.kernel.org/linux-arm-msm/20200526205403.GA7256@gerhold.net/
