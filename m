Return-Path: <linux-pm+bounces-20378-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F44DA0C193
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 20:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADE887A3F89
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 19:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391D21C5F0A;
	Mon, 13 Jan 2025 19:33:41 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F378B1C2324;
	Mon, 13 Jan 2025 19:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736796821; cv=none; b=IX2uPMp22gQ5fQp4oOddNJOzyROKSukr01qlHaRYiGI+B05D0ElroUWj+8htXugC9XsK41gNXdSI+zjWDJ2S/qr7h2FFebdKb86M+cBleXb0zfX8KJLq24Mnee2UWlWKcWKX15nhMRlsxJlHo0rusFa0iRp+cV61y4kwvtVztx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736796821; c=relaxed/simple;
	bh=owJXJaOnV91NwjFlSTQxgY4ft+kp91vZ2Fu0fyerv00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CWvNgIQXwG2GANLnoEgciOzFTmKTdE5GU9ASOIzlr1ZeZwU25Oz5+b0yJBTV7ZDAutTvpuEn1jh8rf9BdSHELAvZZHSK0DnRYMPFLqwdpqcHcPO9SRI8XC741/U7VfhBetzli8XvYLONx4pmXt/vidqRfbJ7ziepwqi9NkHHtFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 657B712FC;
	Mon, 13 Jan 2025 11:34:05 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E2473F66E;
	Mon, 13 Jan 2025 11:33:34 -0800 (PST)
Date: Mon, 13 Jan 2025 19:33:17 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
Message-ID: <Z4VqcQuY0VhXDg6g@pluto>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4UZ2Au7KSFMibDW@bogus>

On Mon, Jan 13, 2025 at 01:49:12PM +0000, Sudeep Holla wrote:
> On Mon, Jan 13, 2025 at 11:37:23AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
> > > state as off
> > >
> > > On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a
> > > > resource if no agent has requested to use that resource."
> > > >

Hi,

not really a short mail this one...

> > >
> > > True, but ...
> > >
> > > > Linux Kernel should not rely on a state that it has not requested, so
> > > > make state as off during initialization.
> > > >
> > >
> > > IIUC, this was done to avoid any transitions if the bootloader like U-
> > > Boot has turned on the resource and OS can just rely on that stay.
> >
> > But if it is not U-Boot turned it on?
> 
> Not sure if I understand what exactly you mean by that.
> 
> > Or U-Boot is in a separate agent?
> >
> 
> No, it will be same as OS for the SCMI platform/agent as they use/share the
> same transport. It is hard to distinguish between them.
> 

Exactly, if U-Boot is SCMI capable, its requests will have been accounted,
lets say, as Agent_X, but when the Kernel springs to life it will take over
the role and the SAME channel used by the defunct UBoot, so as to appear as
being effectively the same Agent_X to the platform...

...the tricky part is what happens when, instead, UBoot is NOT an SCMI agent
and it does leave some resources ON (say some regulator needed while setting up
the screen...) with the intent of NOT having those turned off by the Kernel ?
(BUT with such actions not tracked by the platform, not being an SCMI agent)

To make the matter worse, all of this sort of "resource-state-alignment-issue"
between bootloader, Kernel or other independent agents, greatly depends on how
the state-get operations were implemented.

IOW, since some resources could be shared between agents (clocks, PDs), a
set-state on such resources is supposed to be "harmonized" by the platform,
so that, say, res_X will be enabled physically only when the first agent
acquires it, and res_X will be finally disabled only when the last agent
relinquishes it...

....you certainly dont want that after agent_A have issued a set_ON(res_X),
another agent_B issuing a set_OFF(res_X) can cause that same shared res_X to
be effectively switched off while still used by agent_A...in such a case agent_B
should receive an OK but res_X should anyway effectively stay ON until also
agent_A has relinquished it too...

...now the question is...what state would you expect to read-back from a
get_state operation on such shared resources ? the real/physical one OR the
virtual/per_agent state ?

...IOW in the above example, after agent_B successfully issued a set_OFF(res_X),
on the shared res_X (which indeed did NOT really caused sharted res_X to be
turned OFF) what will agent_B should read back from a get_state(res_X):

	OFF (virtual-view) ? ... or ON (physical view) ?

This platform "states-view" behaviour was long debated and at the end
AFAICR it has been left by the spec as IMPDEF, so each platform can
decide what to return...physical vs virtual state...and that means that,
whatever we do, Kernel side we should cope with 4 possible scenarios

- Uboot NON-SCMI / physical GET_STATE platform-impl
- Uboot NON-SCMI / virtual GET_STATE platform-impl
- Uboot SCMI / physical GET_STATE platform-impl
- Uboot SCMI / virtual GET_STATE platform-impl

...and in all of these scenarios we should additionally consider what
happens when the kernel wants or want-not to keep a resource in the state,
that it has found it (as queried with a get_state (physical or virtual))

IOW, as an example, what if:

I have an UBOOT/NON_SCMI that leaves res_X OFF from its point-of-view at
the end of its life, BUT res_X is also claimed as ON by another SCMI agent_Z
at the same time, and the platform implements physical-real-views, so that
Kernel will see anyway res_X as ON....what should happen, in this context,
if the Kernel wants to keep res_X ON ?

OR what if:

I have an UBOOT/SCMI agent_X that leaves res_X ON from its point-of-view at
the end of its life, BUT res_X is also claimed as ON by another SCMI agent_Z
at the same time, and the platform implements virtual-per-agent-views,
so that Kernel will see res_X as ON....what will happen, in this
context, if the Kernel wants to turn res_X OFF ? AND what happens
instead if, in this scenario, we have additionally the currently proposed patch
applied (that forcibly would makke the Kernel think that res_X is OFF) ?

All of these scenario should be considered, and I have indeed an even
longer (:P) mail currently brewing on my side to try to layout all
possibilities...

...next days once it is more refined I will post it.... you've been warned ! :P

Thanks
Cristian

