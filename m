Return-Path: <linux-pm+bounces-20429-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80363A10FC7
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 19:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92C763AD994
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B2D1FCD00;
	Tue, 14 Jan 2025 18:16:59 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB82204590;
	Tue, 14 Jan 2025 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736878619; cv=none; b=bsojDcWkWCjKpl9o5CmkjeS5cBhHdzNRaZCnn1JnK5SAt3AHSnPPPyroC8ngR/+obme8wVSpVdvTNKsRLhhgU2yx0bMzm6RKm2MNHwg+cgdKYzlS2mmC3UtalOe80vEmrV/scTeicsb5Z43dj9guCpLEOuQjIcYN+egsFkXgbnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736878619; c=relaxed/simple;
	bh=IIYLZ3cFHqV82/6582I80ZBHQku8iozDmea5FW8JPJg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaTRTrQeADVMn0Pqnm7E58y9bFQ9ZOP+zs+kXaA9uBo2QZdYg1ZpQFgm4NKVE75o2Xh/xn/3UTRfW2js3QL9NwIVbEQa7Xbis1azPQfWXvtY707DUtTUzUpoGHlJdRGFVMcwPJvhkaGk/w++mYFCQa/Tczi/34JGJl3VYtrdA/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E376E19F0;
	Tue, 14 Jan 2025 10:17:23 -0800 (PST)
Received: from bogus (unknown [10.57.34.70])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2ED193F51B;
	Tue, 14 Jan 2025 10:16:54 -0800 (PST)
Date: Tue, 14 Jan 2025 18:16:29 +0000
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
Message-ID: <20250114180649.alehyqs657p2vyzl@bogus>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus>
 <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4aBkezSWOPCXcUh@bogus>
 <PA4PR04MB9485507CCC21354B5ED55C3792182@PA4PR04MB9485.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9485507CCC21354B5ED55C3792182@PA4PR04MB9485.eurprd04.prod.outlook.com>

On Tue, Jan 14, 2025 at 04:09:13PM +0000, Ranjani Vaidyanathan wrote:
> Hello Sudeep,
>
> Comments below.
>
> Regards,
> Ranjani Vaidyanathan
>
> -----Original Message-----
> From: Sudeep Holla [mailto:sudeep.holla@arm.com]
> Sent: Tuesday, January 14, 2025 9:24 AM
> To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>; Peng Fan (OSS) <peng.fan@oss.nxp.com>; cristian.marussi@arm.com; Sudeep Holla <sudeep.holla@arm.com>; ulf.hansson@linaro.org; arm-scmi@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
>
> Caution: This is an external email. Please take care when clicking links or opening attachments. When in doubt, report the message using the 'Report this email' button
>
>
> Hi Ranjani,
>
> On Mon, Jan 13, 2025 at 07:54:06PM +0000, Ranjani Vaidyanathan wrote:
> > Hello Sudeep,
> >
> > Will try to explain the situation we are facing.
> > 1. We have multiple agents running, Agent-A is booted up first before
> > Linux is booted and powers up a shared power domain PD-X.
> > 2. Linux boots and gets the power state of PD-X. And its already ON.
> > And then PD -X is initialized with a default ON state.
> > 3. When the driver that needs PD-X  is probed, Linux sees that the
> > power domain status is ON and never makes an SCMI call to power up the
> > PD-X for Linux Agent.
> > 4. Agent-A now is shutdown/suspends. Linux will crash because the
> > platform disables PD-X because it has no other requests for PD-X.
> >
>
> Thanks for the detailed explanation. I understand the issue now.
>
> I would like to discuss if the below alternative approach works for you.
> We can debate the pros and cons. I see with the approach in this patch
> proposed by Peng we would avoid querying and setting genpd all together
> during the genpd initialisation which is good. But if there are any genpd
> left on by the platform or bootloader(same agent), it will not get turned
> off when Linux tries to turn off the unused genpds(IIRC this could be the
> reason for the current state of code). While your platform may find sending
> those commands unnecessary, there was some usecase where SCMI platform kept
> all resources ON by default for faster boot and expects OSPM to turn off
> unused resources. So we need to support both the cases. I hope my below
> patch should suffice.
>
> [RV] Linux can still make the call to disable unused power domains, even if
> it never explicitly made a request to power it on. The platform will
> aggregate the request from all agents and will power off the resource if no
> other agent has enabled it. From Linux point of view it has disabled all
> unused power domains.

I need to dig into genpd to see if that is possible. IIUC, genpd tracks the
state and will call off only if it is turned on and is unused. If we
initialise to default off state, it may not issue the OFF call to the
firmware irrespective of the actual state(i.e. even if it left ON).

> Your patch below may also work, but feels like a workaround to artificially
> (for lack of a better word) enable a resource.

I tend to agree this might feel like workaround but I need to look and
refresh my genpd knowledge. Or we can check with Ulf.

> And also makes unnecessary SCMI calls (expensive) for every resource
> immaterial of it power state (maybe can be improved by a conditional check).

Yes we can make explicit call only for ON state.

--
Regards,
Sudeep

