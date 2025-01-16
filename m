Return-Path: <linux-pm+bounces-20574-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CA1A13F7E
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 17:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2303A181F
	for <lists+linux-pm@lfdr.de>; Thu, 16 Jan 2025 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33171DE88D;
	Thu, 16 Jan 2025 16:29:30 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B558635B;
	Thu, 16 Jan 2025 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737044970; cv=none; b=lVbFMZjTsS6q8g7uhcZoXT/3RkVakQnweTJX+R56sMDl7HUMpL8jq6+KyF89MNHD3TCYoB96572BUCp4u/+1fJLYC2VkeUfcQhm8G4U6oebtS1gXO8KePdqF4SQoCTNQj4qOxGNlR+VQqYyyuD7CpSK4OP9wdBa7KVZGckuvCiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737044970; c=relaxed/simple;
	bh=CGIav0E83RUbfKK7U/4dppNEaAQ9rTIVebK8bo2gu/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDIAMSv+oW14qG5PDuorYJD2Ktz1NhY9YGoPjIDJBnk3FnROG61t/qaecc32qVX62Dbj47gDjrOQm0JlBVb5c+TcI88CCUg9qOer8NxP5Az/kdqg0RlegIhJWfVcC69Ddf26BX3eNCH7sQdP73n+fWsuiJ8dtY1/F/r7UgGSt3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951BD1007;
	Thu, 16 Jan 2025 08:29:56 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39DB03F673;
	Thu, 16 Jan 2025 08:29:27 -0800 (PST)
Date: Thu, 16 Jan 2025 16:29:24 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: arm-scmi@vger.kernel.org, linux-pm@vger.kernel.org,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request
 to set the current state
Message-ID: <Z4kz5MvjSCK6KTT0@bogus>
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
> I read up on the discussion and it looks like there is not really a
> simple solution here.
> 
> In principle if a boot-loader wants to do a handover and leave the
> power-domain powered-on for the kernel, the additional call to
> ->state_set() *could* bump the usagecount in the SCMI FW, forever
> leaving the power-domain on.
>

IIUC, the refcount in firmware differs from the one in the kernel. It is
refcount per agent i.e. it is really just a kind of boolean to indicate if
the agent is active user of the resource. So if the bootloader and the Linux
being the same agent request to be turned on without a request to turn off
doesn't mean the refcount is set to 2 and Linux needs to turn off twice.
This is just my opinion and understanding.

> I guess this problem only exists for power-domains being shared across
> scmi agents. Perhaps some kind of configuration flag can help us to
> determine what to do?
>

While I can't disagree, there is also a thought that OS shouldn't be aware
of that detail for equally valid reasons. I am not sure if we can get that
added in the spec.

> > ---
> >  drivers/pmdomain/arm/scmi_pm_domain.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > Hi Ulf,
> >
> > We need your feedback or suggestions for better solution on this matter.
> > Let us know if we can do something better with the genpd's help to resolve
> > this issue.
> 
> At initialization, genpd tries to get the correct state of the HW. If
> the power-domain is on, genpd believes that it will stay on until it
> requests it to be powered-off.
>

Agreed and it is right. I don't think that should change.

> That said, I know we have FW's that aren't capable of informing us
> about the power-domain's current state. For this, I (and Abel Vesa)
> have been exploring how to introduce an "unknown-default" power-state,
> which would mean that genpd would request on or off the first time
> there is a transition of the genpd's power-state. This is on my TODO
> list, perhaps that is something that can help here too?
>

Ah interesting. But I still can't get my head around how this fits with
in with the existing 2 extreme use cases. One where f/w leaves everything
on to speed up boot(which is fair requirement) and one where OS is expected
to turn on when it needs a resource(which is ideal but may impact boot time
loads of power domains needs to be turned on.

IIUC if we initialise it to unknown state, we will issue ON request when
we use the resource in the kernel and OFF when we are trying to power off
unused on. It may defer the request to the firmware and is move this hack
away from the genpd provider driver into core to deal with this "unknown"
state. Sounds not bad to me if it is feasible to implement.

--
Regards,
Sudeep

