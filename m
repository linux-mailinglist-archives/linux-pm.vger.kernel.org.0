Return-Path: <linux-pm+bounces-20336-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75114A0B8A9
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 14:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3648D3A96A3
	for <lists+linux-pm@lfdr.de>; Mon, 13 Jan 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96E522AE42;
	Mon, 13 Jan 2025 13:49:19 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B522A4F3;
	Mon, 13 Jan 2025 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736776159; cv=none; b=RGPcjjzpc7jORLPDY8ArUJlOSH9WUusxCKCxppdWBbwE8DG7IcujsPE3vNxHtW1d2cmTxW981YLZ9E2JgNs7jif7ehxRCJ6aS0Ddb2Wvvjo/THYrohHyHdbsq/VzOF2Ao1z/dA1Ls9dljsJVWPUq2SvmcxlYgA16e6BBtoxRHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736776159; c=relaxed/simple;
	bh=myuRouzYLHW5pKKkFI3W0E4x/ZFfRzNrQHwvAV/0YeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mEb+w2GhgUkmUgwOjSchMp1ztWW7HRWkD8gUZp3+9Fdy7kis875CmZJqmttPUTLntcaZQ4/YUo1sP5GYMKh9M9bkpDqP4NjtNht1rxPKWxZ/5tzhNzoDWpW146QjJEuoOfkxR8a6zuLy12IOmvrng5gE1ZXK1xaYHnCHWMNgqmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6BA612FC;
	Mon, 13 Jan 2025 05:49:44 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA8643F673;
	Mon, 13 Jan 2025 05:49:14 -0800 (PST)
Date: Mon, 13 Jan 2025 13:49:12 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize state as off
Message-ID: <Z4UZ2Au7KSFMibDW@bogus>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>

On Mon, Jan 13, 2025 at 11:37:23AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
> > state as off
> >
> > On Fri, Jan 10, 2025 at 02:13:46PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Per ARM SCMI Spec DEN0056E, page 16, "The platform may disable a
> > > resource if no agent has requested to use that resource."
> > >
> >
> > True, but ...
> >
> > > Linux Kernel should not rely on a state that it has not requested, so
> > > make state as off during initialization.
> > >
> >
> > IIUC, this was done to avoid any transitions if the bootloader like U-
> > Boot has turned on the resource and OS can just rely on that stay.
>
> But if it is not U-Boot turned it on?

Not sure if I understand what exactly you mean by that.

> Or U-Boot is in a separate agent?
>

No, it will be same as OS for the SCMI platform/agent as they use/share the
same transport. It is hard to distinguish between them.

> > Anyways if the resource is not used by any driver/device in the kernel,
> > won't it be turned off anyways ? What am I missing ?
>
> Because the power domain is ON, kernel will not issue SCMI
> to platform to request it ON when kernel needs this power domain
> on.
>

Yes, but the agent(via bootloader) has already requested the SCMI platform,
so it should be fine. No ?

> But in case when kernel is doing some jobs that needs the
> power domain ON, SCMI platform might power down the
> power domain because kernel agent not request that.
>

See my comment/question above.

--
Regards,
Sudeep

