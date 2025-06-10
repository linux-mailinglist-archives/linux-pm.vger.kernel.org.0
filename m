Return-Path: <linux-pm+bounces-28385-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9A2AD39F6
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 15:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03AE0189E1FF
	for <lists+linux-pm@lfdr.de>; Tue, 10 Jun 2025 13:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39EE23AB94;
	Tue, 10 Jun 2025 13:50:07 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CBA22D79B;
	Tue, 10 Jun 2025 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749563407; cv=none; b=s5dZdke+T6fpnYdpJkZjTAgpICY5MbtSgWTX7bWjbX2Axw1onVd7oXoSEdTCmS108ZqRNlvzb7MLfWP9exNyJv3lqH5gjfRIGSvZm83FPPjWDB3/NLLQhHr9h7yUeKnii/EMp0OGO0NCTUdf8U2gMUiVAkUzSt3SFlP4ONAXGaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749563407; c=relaxed/simple;
	bh=cFS1tOlMfe5z5p3FOgfnjKTkm2/a0u/NE69ljuZXwc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q42gAmTUKoLCu+ZqKUjDes3qhHiHSoRSyx8x6dmTTtcH6hDmdmHd3RYVby0OG6NozCA/wPVEFQu7hqR68bt/DJbrlng2le0MXti+5xkZpUYPR9GZDbzw0RAuSFXMJORoOx+raXXZl7O/GfeRf6lARc9RYObvEMswbsA2mZtPtVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38B5114BF;
	Tue, 10 Jun 2025 06:49:45 -0700 (PDT)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A27E13F59E;
	Tue, 10 Jun 2025 06:50:02 -0700 (PDT)
Date: Tue, 10 Jun 2025 14:49:59 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, <arm-scmi@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <vigneshr@ti.com>,
	<khilman@baylibre.com>
Subject: Re: [RFC PATCH] pmdomain: arm: scmi_pm_domain: Do lazy init as part
 of probe
Message-ID: <20250610-quixotic-successful-alligator-eeaa18@sudeepholla>
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
> > How do this work with runtime DT overlays ?
> 
> Thanks for bringing this up, I hadn't considered runtime DT overlays for
> this particular patch.
> Off the top of my mind, we can initialize all at probe, but only query state
> for referenced ones.
>

Good to know.

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

Good that we are aligned in terms of understanding the general depth of
the issue.

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

Understood, but where we consider this as micro optimisation or not is
another topic all together IMO.

> Even if we somehow optimise the firmware, to me it seems like kernel is
> wasting time querrying for something that it doesn't need at that moment.
> 

Well agreed, but for overlays this may not be trivial. More fundamental
questions below.

> Just replying here to your next reply on the thread:
> > And I missed another point. Someone will soon complain Linux no longer
> > turns off unused power domains. So I am inclined against this optimisation.
> > We need to consider all the above point before .
> 
> I agree on some points like the runtime overlay. However I am not sure
> why Linux should be the one to turn OFF power domains that it's
> _unaware_ of. "unused" would probably be a wrong assumption to make.

I have to disagree here. If the firmware is making the kernel aware of
N power domains, then just not using it in DT and labeling the kernel
is unaware of those PDs is simply and completely wrong. Why did the firmware
make this(Linux) agent aware of those PDs then ?

IMO, it is just *unused*.

> There maybe other entities that would be using power domains that
> are not in the device tree. (For eg. an RTOS running on the same system
> accessing a PD that is controlled by the SCP firmware but not mentioned in the
> device tree.)
> 

Well I assume those RTOS or entities are different agents in terms of
SCP/SCMI and they can have their own view of PDs

> While one may argue that's why firmware should be the one to keep ref
> counts to avoid resource conflicts, one could also argue that firmwares
> could be the one to turn off unused power domains.
> 

Yes firmware has the final say, but it can't track what resources Linux is
using and what needs to stay on or off especially if no request from OS
has come. There was an issue that if bootloaders turn on PD and Linux avoids
making explicitly request to the firmware as it finds it ON, then firmware
will leave it on even if Linux is not using it. So, yes it is Linux
responsibility to turn of any unused PDs. We are not going to debate on
that as there are platforms that are already relying on this feature.

> Why should the kernel touch something that it hasn't been told about
> explicitly in the DT? Isn't the whole point of DT to be the literal
> hardware descriptor for the kernel?

Well, I understand and kind of agree. But why does the firmware inform
Linux about PDs that are never used by the Linux and always used by
some other agent like RTOS. That is the main point here and nothing
related to DT. We rely or trust the information from the firmware to
be more dynamic compared to DT. So DT is second class citizen in this
context. It only provides info that firmware can't provide not the other
way around. That's the whole point of moving towards this firmware
interfaces that are more dynamic and runtime aware than the DT which are
static.

> So if something doesn't exist in the DT, kernel shouldn't have other
> places telling it does - in this context power domains.
> 

Firmware is discoverable, we only add information that are hard to discover
like domain IDs assigned to the device and so on in the DT. But information
from the firmware must be always more accurate than DT. So if the firmware
says there are 100 PDs for Linux agent but 50 of them are exclusively used
for some other agent, then something wrong with the firmware here.

-- 
Regards,
Sudeep

