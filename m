Return-Path: <linux-pm+bounces-2552-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE6838C22
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 11:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B1961C227BE
	for <lists+linux-pm@lfdr.de>; Tue, 23 Jan 2024 10:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A485C61A;
	Tue, 23 Jan 2024 10:33:50 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962FC50A77
	for <linux-pm@vger.kernel.org>; Tue, 23 Jan 2024 10:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706006030; cv=none; b=tpR2pMFxE94CPeu0j55Unslq5qKS5Zih0t1oBLNX2vr2XMeiAUs5OF52Y1sf0gi9cS8tcCpBAk+1SeQempPD0eEW0MvfHbjG/cY/QiXzRr3thUQ+cnDJ8BAhd8X5fUd6FKNh5j55AhEkOq0fM+hgNNYm+RFm/RmwO85hkr8PgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706006030; c=relaxed/simple;
	bh=+VwbuQ5RMqO/5eyhvD9p+fu+hN6uLjI6W//d4Lnp4Cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mka97QzQoaIKksKjuoXABMHualLifc4kojTnnEq3RxQQnJB6wFQ2X9PlYiljzjT0mgt4TXY/U6cNkjXtXyb/0uIcR+/QewPn6Pj4PWyB9lJHcIyYV4ug9Zjpzr8lFE26Ur/4q31IOx+I8XYHpYcdHvCTLmYWpJJKeP46H9ykwko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77D8F1FB;
	Tue, 23 Jan 2024 02:34:33 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DB3D83F5A1;
	Tue, 23 Jan 2024 02:33:46 -0800 (PST)
Date: Tue, 23 Jan 2024 10:33:44 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ben Horgan <Ben.Horgan@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	nd <nd@arm.com>, Vishnu Banavath <Vishnu.Banavath@arm.com>,
	Florent Tomasin <Florent.Tomasin@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: Using scmi performance domains and scmi power domains together
Message-ID: <Za-WCHwfpf7dXJ1Z@bogus>
References: <VE1PR08MB476848A0895993EAC92AF77B91752@VE1PR08MB4768.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VE1PR08MB476848A0895993EAC92AF77B91752@VE1PR08MB4768.eurprd08.prod.outlook.com>

(+ Cristian)

On Mon, Jan 22, 2024 at 08:27:03PM +0000, Ben Horgan wrote:
> Hi,
>
> I've been looking at adding support in total compute, an arm reference
> platform, to control the gpu operating points and gpu power on/off via scmi.
> This was previously done for the juno platform but involved hacks. I would
> like to make sure this is cleaner going forward.
>
> For device driver simplicity it would be good if a device with a single
> power domain and a single performance domain could just use a single PM
> domain.

Do you have any other technical reason for this other than simplicity ?
We can't always have to so simple when managing to support wide variety
of platforms with standards like SCMI.

You need to justify why it is hard for the driver if there are 2 genpd
domains associated with a device(power and perf genpds).

> Using a single PM domain means this can be on the platform device
> and you don't need to create virtual devices. The drivers scmi_pm_domain and
> scmi_perf_domain both initialize a separate 'struct generic_pm_domain genpd'
> for each of the corresponding scmi domains. Possibly, there could be some
> way to bring these together under a single genpd domain. Possible options
> are:
> 
> A. Parent power domains with a helper driver that just uses an empty genpd
> domain as the child of both the genpd performance domain and the genpd power
> domain.
> B. Combine the scmi_pm_domain and scmi_perf_domain driver and create a
> 'struct generic_pm_domain genpd' for every pair of power domain and
> performance domain.

This is purely software implementation and expect no change in the firmware
(DT) representation of these domains and association with the device.

> C. Combine the scmi_pm_domain and scmi_perf_domain driver but only create
> the 'struct generic_pm_domain genpd' for the power domain combinations that
> are used.

Not possible unless the specification assures the power domain and the
performance domain IDs match.

> D. Keep things as they are and use separate PM domains for performance and
> power when using scmi.

+1, it was designed this way to ensure it addresses all the possible
implementations using SCMI.

>
> Examples of possible ways of expressing these options in the device tree,
> the scmi performance domain is 3 and the scmi power domain is 8.
>
> A.
>
> scmi_devpd: protocol@11 {
>         reg = <0x11>;
>         #power-domain-cells = <1>;
> };
>
> scmi_dvfs: protocol@13 {
>         reg = <0x13>;
>         #power-domain-cells = <1>;
> };
>
> perf_and_performance: perf_and_performance {
>         power-domain-names = "perf", "power";
>         power-domain = <&scmi_dvfs 3>, <&scmi_devpd 8>;
> };
>
> my_device : my_device  {
>         power-domain = <&perf_and_performance>
> };
>

NACK as I mentioned, we need to keep DT representation as minimal as
possible, adding nodes for this virtual domain is a no go IMO. Just
use the existing binding to create this virtual genpd at which point you
may realise handling 2 genpd in the driver may not be so hard 😄.

> B. Combine on every pair
>
> scmi_pm_perf: protocol@11_13 {
>         reg = <0x11>, <0x13>;
>         #power-domain-cells = <2>;
> };
>
> my_device : my_device {
>         power-domain = <&scmi_pm_perf 8 3>
> };
>

Again big fat NACK as above. No change in the binding to make it confusing.

> C. Combine on used pairs
>
> scmi_pm_perf: protocol@11_13 {
>         reg = <0x11>, <0x13>;
>         #power-domain-cells = <2>;
>        used-domains = <8, 3>, <9, 4>;
> };
>
> my_device : my_device {
>         power-domain = <&scmi_pm_perf 8 3>
> };
>

At this point I give up and will just say I would expect no change in the
DT bindings to achieve whatever you are terming as "simple" here. We are
not going to add any bindings to make it easy or simple for OS to implement
it's policy.

> It seems wasteful that the scmi_pm_domain sets up and makes scmi calls for
> all possibly usable domains at start up even those that aren't controllable
> by linux. E.g. cpus may use scmi power domain controlled via psci.
>


Not an OS issue. If the power domain is purely controlled by PSCI agent, why
is it even present to OS as SCMI power domain. We have examples where it
is correctly presented as PSCI power domain. So this issue doesn't exist,
fix the SCMI platform firmware. It needs to present per agent view correctly
and not present a global system view to all the agents.

Unless I hear strong technical reasons to this approach other than simplicity,
I am inclined towards opposing this proposal.

-- 
Regards,
Sudeep

