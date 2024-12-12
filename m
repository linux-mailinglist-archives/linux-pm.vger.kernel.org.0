Return-Path: <linux-pm+bounces-19129-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F229EE700
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 13:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC4218869FD
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2024 12:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43DA22135AD;
	Thu, 12 Dec 2024 12:46:46 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A88220A5C7;
	Thu, 12 Dec 2024 12:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734007606; cv=none; b=Zz3imCRki7sSDA5c7tfvS83SYuvwvVcVeWPZkov4l4BIXUbcVoDUYlQ/gRmUOMtSCWDt522e6gg1qF1weXUrmhNM9VYPRqV4c7Cl3AoiFiiyR7F9IsateLKW5WF/cY+PKkwd/5/mcPvmPAEW5aVn11eQC5D6Krh44WbU9vevAaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734007606; c=relaxed/simple;
	bh=X0e/kSh7hdWxarH+vo+YZPH7v7Frzp7GE24fnTpjC5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i17+WzCgFXgXnSQNDuML+iaUtWpNtFyWMaXWwGW4EGoLR+aiQXCFPQowdl4mRkqpWM0bloreKP1DigdMGaVizyljyQYjoVOp+ZfTL5vEUARqZHlwPlal4ZkpwT3uC7A3JNQy3Hrvz/aVpY0a4o2C90Y8V5/EJ0LbkIywOmTgJqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3920153B;
	Thu, 12 Dec 2024 04:47:10 -0800 (PST)
Received: from bogus (e133711.arm.com [10.1.196.55])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 66AD83F720;
	Thu, 12 Dec 2024 04:46:40 -0800 (PST)
Date: Thu, 12 Dec 2024 12:46:37 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Dhruva Gole <d-gole@ti.com>
Cc: Vivek yadav <linux.ninja23@gmail.com>, <linux-newbie@vger.kernel.org>,
	<linux-pm@vger.kernel.org>, <daniel.lezcano@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <lpieralisi@kernel.org>,
	<krzk@kernel.org>, <christian.loehle@arm.com>,
	<quic_sibis@quicinc.com>, <cristian.marussi@arm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <vigneshr@ti.com>, <khilman@ti.com>,
	<sebin.francis@ti.com>, <khilman@baylibre.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
Message-ID: <Z1rbLdWW75KQw5cl@bogus>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
 <20241211055052.gbxnyqpui3t3zpw5@lcpd911>
 <20241211121825.GA2054801@bogus>
 <20241211143428.kaoovhiwar74dy6x@lcpd911>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211143428.kaoovhiwar74dy6x@lcpd911>

On Wed, Dec 11, 2024 at 08:04:28PM +0530, Dhruva Gole wrote:
> On Dec 11, 2024 at 12:18:25 +0000, Sudeep Holla wrote:
> > On Wed, Dec 11, 2024 at 11:20:52AM +0530, Dhruva Gole wrote:
> [...]
> > > >
> > > >
> > > > Hi @all,
> > > >
> > > > I am working on one custom SoC. Where I add one CPUIdle state for
> > > > ``arm,cortex-a55`` processor.
> > >
> > > Any further luck on this?
> > >
> > > I have also been working on something similar[1] but on an A53 core on
> > > TI-K3 AM62x processor.
> > 
> > Does upstream DTS have support for this platform to understand it better ?
> > Even reference to any complete DT file for the platform will help.
> 
> Yes, you can ref to the AM625 (CPU layout) DT here:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am625.dtsi
> 
> The board/starter kit DT is:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> 
> The patches for idle state are not upstream, and only exist in this
> patch of mine here:
> https://github.com/DhruvaG2000/v-linux/commit/0fd088d624276a2e72b8dc6660d261ab6d194f4b
>

"arm,psci-suspend-param" indicate that this idle state doesn't loose the
cpu context which means timer doesn't stop. So adding "local-timer-stop"
sound completely wrong to me.

> [...]
> > > See this chunk in the kernel cpuidle driver:
> > > 	if (broadcast && tick_broadcast_enter()) {
> > >
> > > When I dug deeper into tick_broadcast_enter it always returns something
> > > non zero and hence in my case it was entering the if block and tried to
> > > find a deepest state. Then the deepest state would always return WFI and
> > > not the idle-state I had added.
> > >

It depends. If this is the last CPU and since you have marked the state with
"local-timer-stop" and the system doesn't have any other timers to use as
source of broadcast, it prevents one of the CPU entering that state. So you
could be matching all the above conditions on your platform and hence you
are observing the above.

> > > What we found out was on our kernel we end up using
> > >
> > > kernel/time/tick-broadcast-hrtimer.c
> > >
> > > This always seems to be keeping atleast 1 CPU busy and prevents idle.
> > > If we remove the local-timer-stop it was helping us, but we still need
> > > to dig into the full impact of what that entails and I am still
> > > interested in finding out how so many other users of similar idle-state
> > > implementation are able to do so without trouble.
> > >
> >

As mentioned about adding "local-timer-stop" for a retention state seems
pure wrong in my opinion as it contradicts to the fact that context is
retained.

> > Interesting. So if the platform is functional removing local-timer-stop,
> > I am bit confused. Either there is something else that is getting it out
>
> Yes it was interesting to us too, as to how the RCU didn't kick in and
> system continued to function as though nothing was wrong.
>

It worked as if it was a state with context lost. So there might be some
impact on the latency though it as the kernel assumed context lost and
re-entered/resumed through resume entry point rather than where it called
cpu_suspend() similar to wfi(). I mean only on the CPUs it was able to
enter this state as one of the CPU will never enter this if there are no
system timers to act as broadcast timer.

Does you system not have Arch timers memory mapped interface enabled and
interrupt wired to GIC(other than PPIs) ? Look at Juno R2 as example.

> > from the idle state so, it should be fine and it could be just some
> 
> It's probably UART keypresses or some userspace processes that get
> scheduled that bring the CPUs back out of TF-A's cpu_standby.

I doubt the CPU resume from suspend is based on some userspace event.

> Is it possible that EL1 interrupts can bring EL3 out of WFI? Is yes then
> it explains the behaviour. The arch timer could also be continuing to
> tick and bringing the CPUs out of ATF WFI.
>

Yes but that doesn't explain the behaviour. It could be just the timer
event from the broadcast timer.

> > misconfiguration.
> > 
> > > Arm64 recommends to use arch_timer instead of external timers. Once we
> > > enter el3, timer interrupts to el1 is blocked and hence it's equivalent
> > > to local-timer-stop, so it does make sense to keep this property, but
> > > then how are others able to enter idle-states for all plugged CPUs at
> > > the same time?
> > >
> > 
> > Some systems have system timer that can take over as broadcast timer when
> > CPUs enter deeper idle states where the local timers are stopped.
> 
> In CPUIdle we're not really clock gating anything so the timer does keep
> ticking. So in this particular case it might make sense to remove the
> local-timer-stop property from the idle-state.
>

Correct in your case it is retention state and hence local CPU timers
keep ticking and you can safely drop that property. However if you add
deeper idle states like CPU OFF with the power rail cut off, then you need
some system timer to act as backup/broadcast timer so that all the CPUs
can enter the state concurrently and wake up successfully.

> However we're looking into taking this further and putting interconnect
> and few other PLLs in bypass which could cause arch timer for eg. to
> tick slower.

I assume it will be present as another timer with the rate set appropriately.

> In this case would it still make sense to omit the property? 

No, you should mark it as stopped even if it is running at slower rate
as I am not sure if the local CPU timer support can handle rate change.

> We may even have some usecases planned where we may turn OFF
> the CPU once it is in TF-A cpu_standby/ WFI. What would be the right
> approach in such scenarios?
>

As mentioned above, this will be separate state and all CPUs can use this
if there is another system broadcast timer.

> Could you provide any examples where the local-timer-stop property is
> being used and an alternative timer can be configured once we enter the
> idle-state where CPU CTX maybe lost or clocks maybe bypass?
> great if you could share some example implementation if you're aware.

As I mentioned, Juno R2 is an example. It was broken on R0 with some SoC
errata(can't recall all the details as I looked at it almost a decade ago)

-- 
Regards,
Sudeep

