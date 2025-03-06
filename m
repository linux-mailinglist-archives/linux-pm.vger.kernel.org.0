Return-Path: <linux-pm+bounces-23563-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D1EA54B12
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 13:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966AA3AA306
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30820B80E;
	Thu,  6 Mar 2025 12:42:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D0920B807;
	Thu,  6 Mar 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741264967; cv=none; b=K0bfWFJhgRTQVq/o6TIUiW0ylBMsB1DzQcEonXjJx0AaaBq0NPjEc8iQBR8gH4kUz1N6lj0Lq0IVHxqp/V5xs/pc1exrso3H4NXlXKBF686gofalELspuH7gvh6XchRK2ZpB2m0C08SsK+P9E3ErtX5xfXiTPVmr0FceCj7d/1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741264967; c=relaxed/simple;
	bh=LaMtgQvYTUM2jrJATyinTgdG/0gAEnXubFyZfap9nXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=saZtymo00T0QizqK8qsC4n2wXQvArVjHf28QukQJtjPgtK5ZAP2UZqeuCQiMNValLR+8H5rj6ZSUr8TSY9WqNXBuRAA1+JLY+tkSQMkGpd1UtDnWRA9yJ1g2liKnIYnm2HuQFCy5RdvxVeBnb3/Dp7wy6vquJRXotGP9G2WHjJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A266E1007;
	Thu,  6 Mar 2025 04:42:57 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 58BBA3F673;
	Thu,  6 Mar 2025 04:42:42 -0800 (PST)
Date: Thu, 6 Mar 2025 12:42:39 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Jacky Bai <ping.bai@nxp.com>, lpieralisi@kernel.org, rafael@kernel.org,
	daniel.lezcano@linaro.org, james.morse@arm.com, d-gole@ti.com,
	linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	khilman@baylibre.com, quic_tingweiz@quicinc.com,
	quic_yuanjiey@quicinc.com
Subject: Re: [PATCH v3] cpuidle: psci: Init cpuidle only for present CPUs
Message-ID: <Z8mYP7AGBPeDTvXn@bogus>
References: <20250306061805.2318154-1-ping.bai@nxp.com>
 <CAPDyKForY4VNZtqietDPt2FQM3p4OsaoE_oJb0PPLUAh98WsHQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKForY4VNZtqietDPt2FQM3p4OsaoE_oJb0PPLUAh98WsHQ@mail.gmail.com>

On Thu, Mar 06, 2025 at 11:53:14AM +0100, Ulf Hansson wrote:
> On Thu, 6 Mar 2025 at 07:17, Jacky Bai <ping.bai@nxp.com> wrote:
> >
> > for_each_possible_cpu() is currently used to initialize cpuidle
> > in the PSCI cpuidle driver.
> >
> > However, in cpu_dev_register_generic(), for_each_present_cpu()
> > is used to register CPU devices which means the CPU devices are
> > only registered for present CPUs and not all possible CPUs.
> >
> > With nosmp or maxcpus=0, only the boot CPU is present, leading
> > to the failure:
> >
> >   |  Failed to register cpuidle device for cpu1
> >
> > Change for_each_possible_cpu() to for_each_present_cpu() in the
> > PSCI cpuidle driver to ensure it only registers cpuidle devices
> > for CPUs that are actually present.
> >
> > Fixes: b0c69e1214bc ("drivers: base: Use present CPUs in GENERIC_CPU_DEVICES")
> > Reviewed-by: Dhruva Gole <d-gole@ti.com>
> > Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
> > Tested-by: Yuanjie Yang <quic_yuanjiey@quicinc.com>
> > Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> 
> Is this problem specific to cpuidle-psci?
> 
> Others are using for_each_possible_cpu() when registering their cpuidle drivers.
> 

Good point. I assumed as this was very old patch, only this is left without
conversion to using present_cpumask. Looks like there are many other drivers
that need similar change. May be PSCI is most commonly used ones these days
and hardly anyone tests with nosmp or maxcpus=1 on those platforms.

But yes, all the users of for_each_possible_cpu() need to move to
for_each_present_cpu() if they are relying on CPU device being registered.

-- 
Regards,
Sudeep

