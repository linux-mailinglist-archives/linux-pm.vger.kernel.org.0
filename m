Return-Path: <linux-pm+bounces-20421-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A02A10AA3
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 16:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 871E13A3F39
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jan 2025 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D6815623A;
	Tue, 14 Jan 2025 15:24:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A16191F77;
	Tue, 14 Jan 2025 15:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868248; cv=none; b=Lmyl59xqeqXMgz/nNXTLHgUxJqDvnuzo+ylSgDkFfhK3osTtiyA/KAJwWLskTcYKvSQJsRfSV4fl6AcboCAniG+rRnwGdalyfEau+dVapzmx3Xhdz0Nkfrtgkpj+P1cqh0wSd7hK+1erpgdrntUx60YK5ZGkBDEQbhZQ33oZl10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868248; c=relaxed/simple;
	bh=aLDVlPwWJBZUlGbpy/Y6/SHRqGslVBS4RHjL2SqcZGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EflDf7z4GqUIk8l+nKvKvppSCAT5QJMyqauqzKDnRs0PyxhGYf+nihrvAms2lzisZ7khA1pYHXf8/+BbL/zcAG102ZfIHqQxb2yJ+DECqtXDCiss1380tsjYervBl5782neApdwJiVxkA+Oy+QIQVgd3WZ4wjhpTByaKWnj8IKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A120611FB;
	Tue, 14 Jan 2025 07:24:33 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C4FE73F673;
	Tue, 14 Jan 2025 07:24:03 -0800 (PST)
Date: Tue, 14 Jan 2025 15:24:01 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
Cc: Peng Fan <peng.fan@nxp.com>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	"ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
	"arm-scmi@vger.kernel.org" <arm-scmi@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] pmdomain: arm: scmi_pm_domain: Initialize
 state as off
Message-ID: <Z4aBkezSWOPCXcUh@bogus>
References: <20250110061346.2440772-1-peng.fan@oss.nxp.com>
 <Z4TreQ5bA9qiMTgC@bogus>
 <PAXPR04MB8459F33BCC84CCA8F49F3B60881F2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <Z4UZ2Au7KSFMibDW@bogus>
 <PA4PR04MB94855052830C8F4874237BA6921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
 <Z4VLZgAWR7ugDl7W@bogus>
 <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB9485E9C126E48A088D7E399B921F2@PA4PR04MB9485.eurprd04.prod.outlook.com>

Hi Ranjani,

On Mon, Jan 13, 2025 at 07:54:06PM +0000, Ranjani Vaidyanathan wrote:
> Hello Sudeep,
>
> Will try to explain the situation we are facing.
> 1. We have multiple agents running, Agent-A is booted up first before Linux
> is booted and powers up a shared power domain PD-X.
> 2. Linux boots and gets the power state of PD-X. And its already ON. And
> then PD -X is initialized with a default ON state.
> 3. When the driver that needs PD-X  is probed, Linux sees that the power
> domain status is ON and never makes an SCMI call to power up the PD-X for
> Linux Agent.
> 4. Agent-A now is shutdown/suspends. Linux will crash because the platform
> disables PD-X because it has no other requests for PD-X.
>

Thanks for the detailed explanation. I understand the issue now.

I would like to discuss if the below alternative approach works for you.
We can debate the pros and cons. I see with the approach in this patch
proposed by Peng we would avoid querying and setting genpd all together
during the genpd initialisation which is good. But if there are any genpd
left on by the platform or bootloader(same agent), it will not get turned
off when Linux tries to turn off the unused genpds(IIRC this could be the
reason for the current state of code). While your platform may find sending
those commands unnecessary, there was some usecase where SCMI platform kept
all resources ON by default for faster boot and expects OSPM to turn off
unused resources. So we need to support both the cases. I hope my below
patch should suffice.

Regards,
Sudeep

---->8

From dc755fa02d351e71c727da1c396e2d346b496096 Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 14 Jan 2025 15:08:44 +0000
Subject: [PATCH] pmdomain: arm: scmi_pm_domain: Send an explicit request to
 set the current state

On a system with multiple active SCMI agents, one agent(other than OSPM/
Linux or bootloader) would request to turn on a shared power domain
before the Linux boots/initialise the genpds. So when the Linux boots
and gets the power state as already ON, it just registers the genpd with
a default ON state.

However, when the driver that needs this shared power domain is probed
genpd sees that the power domain status is ON and never makes any SCMI
call to power it up which is correct. But, since Linux didn't make an
explicit request to turn on the shared power domain, the SCMI platform
firmware will not know if the OSPM agent is actively using it.

Suppose the other agent that requested the shared power domain to be
powered ON requests to power it OFF as it no longer needs it, the SCMI
platform firmware needs to turn it off if there are no active users of
it which in the above scenaro is the case.

As a result of SCMI platform firmware turning off the resource, OSPM/
Linux will crash the moment as it expects the shared power domain to be
powered ON.

Send an explicit request to set the current state when setting up the
genpd power domains. The other option is to not read the state and set
the genpds as default OFF, but it can't handle the scenario on certain
platforms where SCMI platform keeps all the power domains turned ON by
default for faster boot and expect the OSPM to turn off the unused
domains if power saving is required.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/pmdomain/arm/scmi_pm_domain.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pmdomain/arm/scmi_pm_domain.c b/drivers/pmdomain/arm/scmi_pm_domain.c
index a7784a8bb5db..255c8c36a15c 100644
--- a/drivers/pmdomain/arm/scmi_pm_domain.c
+++ b/drivers/pmdomain/arm/scmi_pm_domain.c
@@ -96,6 +96,8 @@ static int scmi_pm_domain_probe(struct scmi_device *sdev)
 			continue;
 		}

+		power_ops->state_set(ph, i, state);
+
 		scmi_pd->domain = i;
 		scmi_pd->ph = ph;
 		scmi_pd->name = power_ops->name_get(ph, i);
--
2.34.1


