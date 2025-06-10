Return-Path: <linux-pm+bounces-28383-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23391AD39A3
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 128E0188721A
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEA225B312;
	Tue, 10 Jun 2025 13:42:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDF53198E75;
	Tue, 10 Jun 2025 13:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749562966; cv=none; b=e66Ii/SMHrs30d3zGdxLppiKQnGj11TOkIkAyJOEzol9ZhXOa1WNVINXB4C4SbYGkBxYUtGt5pq5Pns+gdpC5PRs7hTlyYuB7BNmvyvEL8IG4NPn/c5M+LNvoU7VPJVqFw324h8IjWm5xSpnqrZm1YMX6BzQe2kWpDiXR8cTMW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749562966; c=relaxed/simple;
	bh=uqkMppCdjUDEemFxHWjQHwuVSVKoC4JVUeGIHIrkidI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6+F2G3qFxJRhhhep2mwIzpxjZqkwYN/sUe+0Ue6/h5U9nq/GSweEN4hbbZ/Urqx5DF7EkPJG1DBj2Dx5FgkTIITWIhmELs8qghN5RypWLMf6schGbVWWj55xe+YMnjiaOtsN63SX4uvww5SLC7WtKfvTxEQ6ooSEBbv/NgkUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8ED6E14BF;
	Tue, 10 Jun 2025 06:42:23 -0700 (PDT)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A5843F59E;
	Tue, 10 Jun 2025 06:42:41 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:42:29 +0100
From: Cristian Marussi <cristian.marussi@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, vigneshr@ti.com, khilman@baylibre.com
Subject: Re: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part
 of probe
Message-ID: <aEg2RcGGGBNL3cB0@pluto>
References: <20250530103527.2244951-1-d-gole@ti.com>
 <20250530-honest-chital-of-growth-db31e1@sudeepholla>
 <20250610114314.dpfedrbok2pmfgxu@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610114314.dpfedrbok2pmfgxu@lcpd911>

On Tue, Jun 10, 2025 at 05:13:14PM +0530, Dhruva Gole wrote:
> Hi,
> 
> On May 30, 2025 at 17:31:08 +0100, Sudeep Holla wrote:
> > On Fri, May 30, 2025 at 04:05:27PM +0530, Dhruva Gole wrote:
> > > Optimize the SCMI power domain driver to only initialize domains that are
> > > actually referenced in the device tree. Previously, the driver would
> > > initialize all possible domains up to the maximum ID, which could lead to
> > > unnecessary firmware calls and longer probe times.
> > > 
> > > Key changes:
> > > - Scan device tree to identify which power domains are actually referenced
> > 

Hi,

forgot this thread...

> 
> -- 
> Best regards,
> Dhruva Gole
> Texas Instruments Incorporated
> > How do this work with runtime DT overlays ?
> 
> Thanks for bringing this up, I hadn't considered runtime DT overlays for
> this particular patch.
> Off the top of my mind, we can initialize all at probe, but only query state
> for referenced ones.

Indeed, DT overlays is a good point, I missed that issue...

> 
> > 
> > > - Use bitmap to track needed domains instead of initializing all
> > > - Only perform state queries and initialization for referenced domains
> > > - Maintain proper array sizing for power domain framework compatibility
> > > - Keep full provider structure to support late binding
> > > 
> > > This optimization reduces probe time and unnecessary firmware interactions
> > > by only initializing power domains that are actually used in the system.
> > 
> > Why is this very specific to power domains only ? This must apply for other
> > domains like perf or clock or reset ?
> 
> Yes, it should. Starting out with just power domains for now though. I
> haven't looked at other places like perf and clock yet.
> 
> > 
> > > For example, in a system with 100 possible domains but only 3 referenced
> > > in the device tree, we now only initialize those 3 domains instead of
> > > all 100.
> > > 
> > 
> > Well, how much of these PD will get used in the final products ? I can
> > understand the need to use just 3 in devel platforms. Just trying to see
> > how realistic is the scenario ? Is there any other optimisation possible
> > from the firmware ? Does getting the state of a PD takes so much time
> > on the platform in question ?
> 
> Well, it's not only about how much time it takes on any particular platform
> to query the state of a PD. Even if say it takes 10us to query it, it will
> add a whole 1ms to the probe time. This mean 1ms more of boot time, and
> perhaps boot time experts can chime in here but every optimisation
> possible matters!
> ARM systems are usually very strict on boot time requirements.
> 
> Even if we somehow optimise the firmware, to me it seems like kernel is
> wasting time querrying for something that it doesn't need at that moment.
> 

I can agree on this, and it would be interesting to optimize the usual SCMI
'query storm' at probe time across all protocols (liek Sudeep suggested),
BUT first of all I would ask, if Linux refers just 3 resources why the
firmware, when queried, returns the full set of N resources....one of the
selling point of the SCMI protocol (especially in virtualized envs) should
be that the server can expose a per-agent view so that each agent on the
same system will see just the stuff that it needs, or in some case have
limited access to some resources.

So my point is, why are you (linux agent) even able to see such resources
when querying the server, if those resources are NOT meant to be accessed at
all by that agent in any capacity, not even read-oly ?

I could understand that a small ratio of exposed/used resources for the
sake of easy of configuration BUT it would seem unreasonable to, say,
expose 100 or 100 of resources to agent A if such agent only use
3/4...consider that in turn, exposing all of such unused resources, will
impact query time and query traffic (beside later also being needlessly
registered with the core without your patch)

> Just replying here to your next reply on the thread:
> > And I missed another point. Someone will soon complain Linux no longer
> > turns off unused power domains. So I am inclined against this optimisation.
> > We need to consider all the above point before .
> 
> I agree on some points like the runtime overlay. However I am not sure
> why Linux should be the one to turn OFF power domains that it's
> _unaware_ of. "unused" would probably be a wrong assumption to make.
> There maybe other entities that would be using power domains that
> are not in the device tree. (For eg. an RTOS running on the same system
> accessing a PD that is controlled by the SCP firmware but not mentioned in the
> device tree.)
> 
> While one may argue that's why firmware should be the one to keep ref
> counts to avoid resource conflicts, one could also argue that firmwares
> could be the one to turn off unused power domains.
> 
> Why should the kernel touch something that it hasn't been told about
> explicitly in the DT? Isn't the whole point of DT to be the literal
> hardware descriptor for the kernel? So if something doesn't exist in the
> DT, kernel shouldn't have other places telling it does - in this context
> power domains.

As per my understanding, in a subsystem like clocks, the Kernel will turn
off any unused (from his pov) resource that is found to be on at the end of
the probe phase of the subsystem itself...in other words kernel will do try
to turn off any resource that it has no use for it (so that it has not 
found in the DT)...so currently if we register 100 resources (all that we
found) and only 3 are used (referred) it will issue an OFF for all the
remaining unused 97...

..and you are right, there will be other non-Linux agents on the system
issuing their requests on that same resources if they are shared, and the
server will have to refcount such requests to act properly when handling
shared resources, so if res_X is not used by the Kernel and we just dont
register it with the Kernel subsystem (like in your patch), it wont be
turned off as unused anymore AND that would be FINE, since, this agent
has NO use for them and never issued any ON-request before...

...BUT.... :P

...the issue would be when you have a system where you have something like
an SCMI capable bootloader that will have turned ON some of these shared
resources during its boot-phase AND then left those resources ON, as a
courtesy :P, so that the 'incoming' booting Kernel can found them ON (I
think usually is what happens with resources related to displays if you
dont want to disrupt the boot..)

...in such a scenario the booting Kernel takes-over, in the eyes of the
server, the same agent role as the bootloader which is substituting, since
it highjacks and uses the same SCMI channel as the disappearfing bootloader..

...so the server will see that resources as refcounted+1 (left by the ghost of
the bootloader :D)...so for power optimnization the Kernel will issue an OFF
on all unused resources and that will cause a refcount-1 server side and
the final physical OFF when all the other possible users of that shared resource
will have released it...

...if you just dont register such resource becasue it is NOT referred in
the DT, surely the Kernel wont try to turn it off as unused and so you
will break this case....

..same if the bootloader is NON-SCMI compliant and just leave a resource ON...

..all of this complicated by the never ending question around which
resource state should be returned on query: physical vs virtual
(currently is IMPDEF)

So I think your optimization is nice in general (even better for all
protocols) BUT we should address all these corner cases somehow...

... or proof all of my hallucination above non-existent/non-accurate :P,
which is posibility since we discuss all of this more than 1 year ago...

Thanks,
Cristian

