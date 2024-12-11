Return-Path: <linux-pm+bounces-19012-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91D09ECBD4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 13:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87731283CA4
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 12:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4492210E7;
	Wed, 11 Dec 2024 12:18:47 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFA238E34;
	Wed, 11 Dec 2024 12:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733919527; cv=none; b=GXjFmpL+WukJx2/TQVRR7wAbBDXkwdSLQQ5KWL3+A74R1q6bkAa8M/l3mPlFfhUx8GRNdkp5AuM3KOVDESDYuAO7vDGyYOmmhgKvU/XdhwEOXiBqa9TGqumIFaaCve8kfeOYKniMgXb/A4rYKgRvG2nZrC5Wd9FmigtRjve9XiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733919527; c=relaxed/simple;
	bh=U+i36SVNLIMR9W86T6yomDQVJkq2kz14oeUDQwH3ynM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqGSlDyBJ6La/XtEb+50QFQRsdRI/MWp4TUen4PE9j2F8i1a8Cclt9WvP/X6XStXECkEFIOXLSUnP+1oqcvjCGmD83J0XZrbLnr6dEU7jcocnG7Lxot0WJG8XW6HYzg9UrAU4J7FeTIDm72Opcdy+3Ins8COVh7RGHMmCBH9Xm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 865371063;
	Wed, 11 Dec 2024 04:19:11 -0800 (PST)
Received: from bogus (unknown [10.57.92.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 523743F5A1;
	Wed, 11 Dec 2024 04:18:40 -0800 (PST)
Date: Wed, 11 Dec 2024 12:18:25 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Vivek yadav <linux.ninja23@gmail.com>, linux-newbie@vger.kernel.org,
	linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
	lpieralisi@kernel.org, krzk@kernel.org, christian.loehle@arm.com,
	quic_sibis@quicinc.com, cristian.marussi@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	vigneshr@ti.com, khilman@ti.com, sebin.francis@ti.com,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
Message-ID: <20241211121825.GA2054801@bogus>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
 <20241211055052.gbxnyqpui3t3zpw5@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241211055052.gbxnyqpui3t3zpw5@lcpd911>

On Wed, Dec 11, 2024 at 11:20:52AM +0530, Dhruva Gole wrote:
> Hi Vivek,
>
> On Oct 14, 2024 at 16:06:34 +0530, Vivek yadav wrote:
> > ---------- Forwarded message ---------
> > From: Vivek yadav <linux.ninja23@gmail.com>
> > Date: Fri, Oct 11, 2024 at 3:14 PM
> > Subject: ARM64: CPUIdle driver is not select any Idle state other then WFI
> > To: <linux-pm@vger.kernel.org>
>
> + Kevin, Vignesh and few colleagues at TI who have been working on this as
> well.
>
> >
> >
> > Hi @all,
> >
> > I am working on one custom SoC. Where I add one CPUIdle state for
> > ``arm,cortex-a55`` processor.
>
> Any further luck on this?
>
> I have also been working on something similar[1] but on an A53 core on
> TI-K3 AM62x processor.

Does upstream DTS have support for this platform to understand it better ?
Even reference to any complete DT file for the platform will help.

> >
> > idle-states {
> >       entry-method = "psci";
> >        cpu_ret_l: cpu-retention-l {
> >          compatible = "arm,idle-state";
> >          arm,psci-suspend-param = <0x00010001>;
> >          local-timer-stop;
> >          entry-latency-us = <55>;
> >           exit-latency-us = <140>;
> >           min-residency-us = <780>;
> >     };
> > };
> >
> > I am using ``Menu governor`` with the ``psci_idle driver`` in its original form.
> > After booting Linux I find out that the CPUIdle core is never going
> > inside the ``cpu-retention`` state.
> > To check time spent by CPU in any state. I am using the below command.
> >
> > ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``
>
> What I was seeing is in a multi core system (2 or more) all cores don't
> enter the idle-state simultaneously. There's something keeping atleast 1
> core always busy. However I could definitely see entry into TF-A from 1
> core at a time.

Does the platform have system timers ? What are the deeper idle states ?
If it is retention state with local timers on, I doubt if my suspicion of
CPU acting as broadcast timer in absence of a better/system timer.

> I then switched to a single core system to see if we were atall able to
> enter TF-A when only 1 core was available for linux, it turned out that
> with the "local-timer-stop" property that we have, this is never
> possible.
>

Yes my suspicion seems correct now but I can't confirm unless I understand
the platform completely.

> See this chunk in the kernel cpuidle driver:
> 	if (broadcast && tick_broadcast_enter()) {
>
> When I dug deeper into tick_broadcast_enter it always returns something
> non zero and hence in my case it was entering the if block and tried to
> find a deepest state. Then the deepest state would always return WFI and
> not the idle-state I had added.
>
> What we found out was on our kernel we end up using
>
> kernel/time/tick-broadcast-hrtimer.c
>
> This always seems to be keeping atleast 1 CPU busy and prevents idle.
> If we remove the local-timer-stop it was helping us, but we still need
> to dig into the full impact of what that entails and I am still
> interested in finding out how so many other users of similar idle-state
> implementation are able to do so without trouble.
>

Interesting. So if the platform is functional removing local-timer-stop,
I am bit confused. Either there is something else that is getting it out
from the idle state so, it should be fine and it could be just some
misconfiguration.

> Arm64 recommends to use arch_timer instead of external timers. Once we
> enter el3, timer interrupts to el1 is blocked and hence it's equivalent
> to local-timer-stop, so it does make sense to keep this property, but
> then how are others able to enter idle-states for all plugged CPUs at
> the same time?
>

Some systems have system timer that can take over as broadcast timer when
CPUs enter deeper idle states where the local timers are stopped.

--
Regards,
Sudeep

