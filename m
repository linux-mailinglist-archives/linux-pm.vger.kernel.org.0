Return-Path: <linux-pm+bounces-20630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E8A151C6
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 15:26:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FCCB1662C8
	for <lists+linux-pm@lfdr.de>; Fri, 17 Jan 2025 14:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E070825;
	Fri, 17 Jan 2025 14:25:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F601E52D;
	Fri, 17 Jan 2025 14:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737123908; cv=none; b=H9pwYMlWPj5cfGyrlDmX8kHEpmagxzsnl/ehTVT45cBE9GuXBXVvArInDYfXY3M+CAGt4QxpEffiY5CPrYDPPt/7xSWYM0eIRR/P8aYGO898d5bEiopezxeV+/moHy+cKW4iLEfoYxSfyg8hxFGZosv4yulxjR9y5sbXj8fWQ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737123908; c=relaxed/simple;
	bh=xjg810+hFhKE5J+gKQCFtizAbYhfEI77GWCPdsguYw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AKZtaBLhMrcZ1OHcyJxMN9sZKNmUSRcRInMl/uS/D1OcF59IcYqSWBGoME9B2qY8b05oZMh2mGKtkO49iv0rdi9FF8wLdCX7aqIn8dBz8dyuXNCZt/uwXgRshNq8z3OUq1wEalqWmhZtpacFPYGfC5JlLLHK2RcPQkjSOSVGp4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864DC1476;
	Fri, 17 Jan 2025 06:25:31 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D085D3F673;
	Fri, 17 Jan 2025 06:25:01 -0800 (PST)
Date: Fri, 17 Jan 2025 14:24:59 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request
 to set the current state
Message-ID: <Z4poOyI5jjMgd-Qd@bogus>
References: <20250115113931.1181309-1-sudeep.holla@arm.com>
 <CAPDyKFrrdkBAPBw5JOv5HLnOj2L=6ZjE+O7h8N3MFC64ebcNEg@mail.gmail.com>
 <Z4kz5MvjSCK6KTT0@bogus>
 <CAPDyKFohsfyQXkZfyK1gX=_gWnu6J1RwpFe7S1O4nP9vT2AC8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFohsfyQXkZfyK1gX=_gWnu6J1RwpFe7S1O4nP9vT2AC8A@mail.gmail.com>

On Fri, Jan 17, 2025 at 12:17:39PM +0100, Ulf Hansson wrote:
> On Thu, 16 Jan 2025 at 17:29, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > On Thu, Jan 16, 2025 at 04:54:44PM +0100, Ulf Hansson wrote:
> > > On Wed, 15 Jan 2025 at 12:39, Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > >
> > > > On a system with multiple active SCMI agents, one agent(other than OSPM/
> > > > Linux or bootloader) would request to turn on a shared power domain
> > > > before the Linux boots/initialise the genpds. So when the Linux boots
> > > > and gets the power state as already ON, it just registers the genpd with
> > > > a default ON state.
> > > >
> > > > However, when the driver that needs this shared power domain is probed
> > > > genpd sees that the power domain status is ON and never makes any SCMI
> > > > call to power it up which is correct. But, since Linux didn't make an
> > > > explicit request to turn on the shared power domain, the SCMI platform
> > > > firmware will not know if the OSPM agent is actively using it.
> > > >
> > > > Suppose the other agent that requested the shared power domain to be
> > > > powered ON requests to power it OFF as it no longer needs it, the SCMI
> > > > platform firmware needs to turn it off if there are no active users of
> > > > it which in the above scenaro is the case.
> > > >
> > > > As a result of SCMI platform firmware turning off the resource, OSPM/
> > > > Linux will crash the moment as it expects the shared power domain to be
> > > > powered ON.
> > > >
> > > > Send an explicit request to set the current state when setting up the
> > > > genpd power domains so that OSPM registers its vote in the power domain
> > > > state with the SCMI platform firmware.
> > > >
> > > > The other option is to not read the state and set the genpds as default
> > > > OFF, but it can't handle the scenario on certain platforms where SCMI
> > > > platform keeps all the power domains turned ON by default for faster boot
> > > > (or any other such variations) and expect the OSPM to turn off the unused
> > > > domains if power saving is required.
> > > >
> > > > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > > > Link: https://lore.kernel.org/all/Z4aBkezSWOPCXcUh@bogus
> > > > Reported-by: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
> > > > Reported-by: Peng Fan <peng.fan@nxp.com>
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > >
> > > I read up on the discussion and it looks like there is not really a
> > > simple solution here.
> > >
> > > In principle if a boot-loader wants to do a handover and leave the
> > > power-domain powered-on for the kernel, the additional call to
> > > ->state_set() *could* bump the usagecount in the SCMI FW, forever
> > > leaving the power-domain on.
> > >
> >
> > IIUC, the refcount in firmware differs from the one in the kernel. It is
> > refcount per agent i.e. it is really just a kind of boolean to indicate if
> > the agent is active user of the resource. So if the bootloader and the Linux
> > being the same agent request to be turned on without a request to turn off
> > doesn't mean the refcount is set to 2 and Linux needs to turn off twice.
> > This is just my opinion and understanding.
> >
> > > I guess this problem only exists for power-domains being shared across
> > > scmi agents. Perhaps some kind of configuration flag can help us to
> > > determine what to do?
> > >
> >
> > While I can't disagree, there is also a thought that OS shouldn't be aware
> > of that detail for equally valid reasons. I am not sure if we can get that
> > added in the spec.
>
> Okay, it seems like $subject patch is the way forward at this moment.
>
> I have applied it for *next* to allow it to be a bit more tested
> before we decide if this is material for stable kernels too. That
> means we may have to send the patch to stable maintainers manually to
> get it applied.

Thanks. We should remember to drop this if we manage to get "unknown"
default/initial state supported in core genpd. I liked the proposal
you made, it is just that I feel we invariably end up sending the ON/OFF
request to the firmware anyways(can't think of any other way), it is just
deferred to a point where the domain is used and at late initcall when
unused genpds are powered off.

--
Regards,
Sudeep

