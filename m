Return-Path: <linux-pm+bounces-20572-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F87BA13F78
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDCAC168337
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2329A22CA1F;
	Thu, 16 Jan 2025 16:27:44 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B69022CA0D;
	Thu, 16 Jan 2025 16:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044864; cv=none; b=IUwZyLtgnclcnxH5oiHMlfZekPmU1O+tUSMqQmM8YkTU2/4d7YC/nXmX8Vo4X6DDKCzIESoyKa5WcQkw4zf4wL8msruFUiH9dLL+Kar+1OxQ3lItVzl+K/G7yTYvVjpO90I0FjfLCrTMwc0FPjHsrUzqkn/YNIbeuHQw9JSyKiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044864; c=relaxed/simple;
	bh=o0erlLK1NLCr2aDLz7jk+zGn8qGKRBoCvoEtZ3J6G9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1bU08VQ0bwkELGLuQ7eChTYpAXCfZpfjml5VZt1EfeUbVLzwpBmu66QTZz5GVSe9khhGhEZD2fClkK2M1vP3GgSfRzB/SSEeOluEVPZTHSpFJhDTxBGwjyuo0snhFMQL2Z3EmEVxreVWAORwh37qYJhL24mei3ELiNhJ2+G05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90AC81007;
	Thu, 16 Jan 2025 08:28:08 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 285FB3F673;
	Thu, 16 Jan 2025 08:27:39 -0800 (PST)
Date: Thu, 16 Jan 2025 16:27:36 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, arm-scmi@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request
 to set the current state
Message-ID: <Z4kzeLB6p6e45bhk@pluto>
References: <20250115113931.1181309-1-sudeep.holla@arm.com>
 <CAPDyKFrrdkBAPBw5JOv5HLnOj2L=6ZjE+O7h8N3MFC64ebcNEg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrrdkBAPBw5JOv5HLnOj2L=6ZjE+O7h8N3MFC64ebcNEg@mail.gmail.com>

On Thu, Jan 16, 2025 at 04:54:44PM +0100, Ulf Hansson wrote:
> On Wed, 15 Jan 2025 at 12:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On a system with multiple active SCMI agents, one agent(other than OSPM/
> > Linux or bootloader) would request to turn on a shared power domain
> > before the Linux boots/initialise the genpds. So when the Linux boots
> > and gets the power state as already ON, it just registers the genpd with
> > a default ON state.
> >
> > However, when the driver that needs this shared power domain is probed
> > genpd sees that the power domain status is ON and never makes any SCMI
> > call to power it up which is correct. But, since Linux didn't make an
> > explicit request to turn on the shared power domain, the SCMI platform
> > firmware will not know if the OSPM agent is actively using it.
> >
> > Suppose the other agent that requested the shared power domain to be
> > powered ON requests to power it OFF as it no longer needs it, the SCMI
> > platform firmware needs to turn it off if there are no active users of
> > it which in the above scenaro is the case.
> >
> > As a result of SCMI platform firmware turning off the resource, OSPM/
> > Linux will crash the moment as it expects the shared power domain to be
> > powered ON.
> >
> > Send an explicit request to set the current state when setting up the
> > genpd power domains so that OSPM registers its vote in the power domain
> > state with the SCMI platform firmware.
> >
> > The other option is to not read the state and set the genpds as default
> > OFF, but it can't handle the scenario on certain platforms where SCMI
> > platform keeps all the power domains turned ON by default for faster boot
> > (or any other such variations) and expect the OSPM to turn off the unused
> > domains if power saving is required.
> >
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Link: https://lore.kernel.org/all/Z4aBkezSWOPCXcUh@bogus
> > Reported-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > Reported-by: Peng Fan <peng.fan@nxp.com>
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> 
HI Ulf,

> I read up on the discussion and it looks like there is not really a
> simple solution here.
> 
> In principle if a boot-loader wants to do a handover and leave the
> power-domain powered-on for the kernel, the additional call to
> ->state_set() *could* bump the usagecount in the SCMI FW, forever
> leaving the power-domain on.
> 

TWell, in theory, this should NOT be the case in the SCMI world since
the resource accounting is supposed to happen per-agent...so multiple
ONs from the same agent should be only accounted as ONE request from
agent_A, because the assumption is that multiple requests from the same
agent wouldl have already been filtered out from within the agent
frameowrks itself, like genPD of CLock...so the platform really takes
care tro harmonize access between shared resources from multiple
different agents.

Now, I fear also, though, that all of the above is IMPDEF and only a
reccomendation, even though the (few) systems I aware of follow this
per-agent-accounting approach.

Thanks,
Cristian

