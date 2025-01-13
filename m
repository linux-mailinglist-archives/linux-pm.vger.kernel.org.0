Return-Path: <linux-pm+bounces-20357-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8ECA0BEC1
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 18:20:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF5E167D5E
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 17:20:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16575192B66;
	Mon, 13 Jan 2025 17:20:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7D14D8CE;
	Mon, 13 Jan 2025 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788846; cv=none; b=F8LNEGAZiZoh9r+ztQOJAjJjegIs+8UziUTHzyWJ4fEZJEkucz3VFl08gBk2ZpQJ667MEen1lXHGRiQo9xroZ6Sxt4QkrryvtpAPiVQ/91nP4FGieWOVmj4Eypq9KpPk6bycP0nXSegLZqCG4yi7TGSRdQ8ATYapgC/N6PFpmzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788846; c=relaxed/simple;
	bh=sI6JaOjakoEdGvRIdJ2kFY3O/ANYwTb0/8GsKasdb+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IALeS88gmjmkSGHB0m/CwhsJ2urbSj75kPw12ueQLmphBlmjl2yVxoYRYW/l9kyqHTDLBeR9Uv7ytPNzBN26KTw0xyeLqp684uwpM4QhW8wfddrx7/4n814N9VScVAhfmT/OMaNmkqTaldOSB0jEDmEfDe9eHdYb831YSU9hgoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 635391424;
	Mon, 13 Jan 2025 09:21:11 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 891B33F673;
	Mon, 13 Jan 2025 09:20:41 -0800 (PST)
Date: Mon, 13 Jan 2025 17:20:38 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Message-ID: <Z4VLZgAWR7ugDl7W@bogus>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>

On Mon, Jan 13, 2025 at 03:30:58PM +0000, Ranjani Vaidyanathan wrote:
> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Monday, January 13, 2025 7:49 AM
> To: Peng Fan <peng.fan@nxp.com>
> Cc: Peng Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com; Sudeep Holla <sudeep.holla@arm.com>; ulf.hansson@linaro.org; arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org; Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Subject: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
>
> On Mon, Jan 13, 2025 at 11:37:23AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state
> > > as off
> > >
> > > On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a
> > > > resource if no agent has requested to use that resource."
> > > >
> > >
> > > True, but ...
> > >
> > > > Linux Kernel should not rely on a state that it has not requested,
> > > > so make state as off during initialization.
> > > >
> > >
> > > IIUC, this was done to avoid any transitions if the bootloader like
> > > U- Boot has turned on the resource and OS can just rely on that stay.
> >
> > But if it is not U-Boot turned it on?
>
> Not sure if I understand what exactly you mean by that.
> [RV] Its possible that some other agent (M33/M7 running OS) in the system
> turned on the power domain. Resources in the same power domain can shared
> across agents.  That being said, uboot provides mechanism to clean up any
> power domains/clocks that it enabled. And our implementation of uboot does
> disable any power domain it powered up for downloading of images or anything
> else (display is a unique case if splash screen is enabled).
>

Right I was referring to the display as one of the example when I referred
to the case where bootloader turns on the resource.

> >
> > Because the power domain is ON, kernel will not issue SCMI to platform
> > to request it ON when kernel needs this power domain on.
> >
>
> Yes, but the agent(via bootloader) has already requested the SCMI platform,
> so it should be fine. No ?
> [RV] As mentioned above, it need not be the bootloader. And secondly how to
> handle this power domain during suspend/resume? It's possible that the agent
> that turned on the power domain initially will have different wakeup
> requirements. IMO Linux should completely be responsible for the power
> domains that the drivers need.
>

May be I am still missing something. The genpd framework does issue power
down of all the PD that are not used once we boot. Is that not sufficient.
We are just not changing the pd state when initialising the genpds.
Is that causing the issue ? I was under the impression that it shouldn't
matter if the driver manages the genpds they consume and all unused ones
get turned off eventually.

What exactly is the issue for which this patch is the solution ? I think
I might have not understood the issue properly here. Sorry if that is the
case.

--
Regards,
Sudeep

