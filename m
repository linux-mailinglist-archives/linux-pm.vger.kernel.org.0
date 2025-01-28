Return-Path: <linux-pm+bounces-21008-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F495A20934
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 12:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C128D16768A
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 11:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A500B19ABC3;
	Tue, 28 Jan 2025 11:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="whQX0YI5"
X-Original-To: linux-pm@vger.kernel.org
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F71C5789D;
	Tue, 28 Jan 2025 11:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062302; cv=none; b=GYqjDHNOPMAuC4seTgG7u/YspXFfDsk8Pq09pSQJxbk9r/PYLBQuGJFESHPqGWK8sFahvqv+j5MABrPEZfn58agTYx8GJw805EVCgofUJpUZ09Gqw1u6bmrqjT2YEo7yrH6q84U4BPmka7Qy8lAVg3aoBiDhdnSGvTPgbrYaX40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062302; c=relaxed/simple;
	bh=YKq+LdJvSYGSOCVDoPAW+0vfGM0pt1Em0Gi91Qu0d9c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9b4Bq2a/BF5hNv3fwQ0EuW6+AhQuChPQut3HeT1ZvZ+tEg1YkDsJDoAEy2KoHugK54anu2jkrXRNtHofEmgNw9O3n1rQlx5DWmtd5fj7XcnDTKXqf68skTaKzeQ4AXEsxBpsLrczNOxAZc7DIV7FY776uKN9MMpLKD+31mBoX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=whQX0YI5; arc=none smtp.client-ip=198.47.23.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50SB4bL81989976
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 28 Jan 2025 05:04:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738062277;
	bh=80z538fDpsOAJagStMvrMe9E0US1OlsIlPBUBIdnQtk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=whQX0YI51l7oi9B3oDwAXd6nxEPONzJ0ue0B0h7vjut8vVXSLknHAErd9j7hTKgTf
	 AKn+KSCLTDJo699691NO6FnkyN34lxycvnKtt3I7T5SgNwPJ2AsbPTZ0qre4iXskMB
	 az7qBiwqj2S6l9RQXsbvUWDqX3Cda9QOjmNC6j0w=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50SB4bf8091305;
	Tue, 28 Jan 2025 05:04:37 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Jan 2025 05:04:36 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Jan 2025 05:04:36 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50SB4Zrj009716;
	Tue, 28 Jan 2025 05:04:36 -0600
Date: Tue, 28 Jan 2025 16:34:35 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Vivek yadav <linux.ninja23@gmail.com>, <linux-newbie@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <daniel.lezcano@linaro.org>,
        <lpieralisi@kernel.org>, <krzk@kernel.org>, <christian.loehle@arm.com>,
        <quic_sibis@quicinc.com>, <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <khilman@ti.com>, <sebin.francis@ti.com>,
        <khilman@baylibre.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
Message-ID: <20250128110435.iclttnaav6mrjrvn@lcpd911>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
 <20241211055052.gbxnyqpui3t3zpw5@lcpd911>
 <20241211121825.GA2054801@bogus>
 <20241211143428.kaoovhiwar74dy6x@lcpd911>
 <Z1rbLdWW75KQw5cl@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Z1rbLdWW75KQw5cl@bogus>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Sudeep,

On Dec 12, 2024 at 12:46:37 +0000, Sudeep Holla wrote:
> On Wed, Dec 11, 2024 at 08:04:28PM +0530, Dhruva Gole wrote:
> > On Dec 11, 2024 at 12:18:25 +0000, Sudeep Holla wrote:
> > > On Wed, Dec 11, 2024 at 11:20:52AM +0530, Dhruva Gole wrote:
> > [...]
> > > > >
> > > > >
> > > > > Hi @all,
> > > > >
> > > > > I am working on one custom SoC. Where I add one CPUIdle state for
> > > > > ``arm,cortex-a55`` processor.
> > > >
> > > > Any further luck on this?
> > > >
> > > > I have also been working on something similar[1] but on an A53 core on
> > > > TI-K3 AM62x processor.
> > > 
> > > Does upstream DTS have support for this platform to understand it better ?
> > > Even reference to any complete DT file for the platform will help.
> > 
> > Yes, you can ref to the AM625 (CPU layout) DT here:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am625.dtsi
> > 
> > The board/starter kit DT is:
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/arch/arm64/boot/dts/ti/k3-am625-sk.dts
> > 
> > The patches for idle state are not upstream, and only exist in this
> > patch of mine here:
> > https://github.com/DhruvaG2000/v-linux/commit/0fd088d624276a2e72b8dc6660d261ab6d194f4b
> >
> 
> "arm,psci-suspend-param" indicate that this idle state doesn't loose the
> cpu context which means timer doesn't stop. So adding "local-timer-stop"
> sound completely wrong to me.
> 

OK Understood.
Removing that does indeed help, and works in the case where our local
timers are not touched. System is indeed entering WFI on all 4 cores at
the same time, confirmed this via some logic I implemented in TF-A.

> > [...]
> > > > See this chunk in the kernel cpuidle driver:
> > > > 	if (broadcast && tick_broadcast_enter()) {
> > > >
> > > > When I dug deeper into tick_broadcast_enter it always returns something
> > > > non zero and hence in my case it was entering the if block and tried to
> > > > find a deepest state. Then the deepest state would always return WFI and
> > > > not the idle-state I had added.
> > > >
> 
> It depends. If this is the last CPU and since you have marked the state with
> "local-timer-stop" and the system doesn't have any other timers to use as
> source of broadcast, it prevents one of the CPU entering that state. So you
> could be matching all the above conditions on your platform and hence you
> are observing the above.

Yes, this is most likely the reason.

> 
> > > > What we found out was on our kernel we end up using
> > > >
> > > > kernel/time/tick-broadcast-hrtimer.c
> > > >
> > > > This always seems to be keeping atleast 1 CPU busy and prevents idle.
> > > > If we remove the local-timer-stop it was helping us, but we still need
> > > > to dig into the full impact of what that entails and I am still
> > > > interested in finding out how so many other users of similar idle-state
> > > > implementation are able to do so without trouble.
> > > >
> > >
> 
> As mentioned about adding "local-timer-stop" for a retention state seems
> pure wrong in my opinion as it contradicts to the fact that context is
> retained.
> 
> > > Interesting. So if the platform is functional removing local-timer-stop,
> > > I am bit confused. Either there is something else that is getting it out
> >
> > Yes it was interesting to us too, as to how the RCU didn't kick in and
> > system continued to function as though nothing was wrong.
> >
> 
> It worked as if it was a state with context lost. So there might be some
> impact on the latency though it as the kernel assumed context lost and
> re-entered/resumed through resume entry point rather than where it called
> cpu_suspend() similar to wfi(). I mean only on the CPUs it was able to
> enter this state as one of the CPU will never enter this if there are no
> system timers to act as broadcast timer.
> 
> Does you system not have Arch timers memory mapped interface enabled and
> interrupt wired to GIC(other than PPIs) ? Look at Juno R2 as example.

It has arch timers mem mapped and irq wired to GIC (I have talked more
on this at the last)
Your analysis seems right, if there is local-timer-stop case, then
our platform doesn't really provide an alternate timer today.

> 
> > > from the idle state so, it should be fine and it could be just some
> > 
> > It's probably UART keypresses or some userspace processes that get
> > scheduled that bring the CPUs back out of TF-A's cpu_standby.
> 
> I doubt the CPU resume from suspend is based on some userspace event.
> 
> > Is it possible that EL1 interrupts can bring EL3 out of WFI? Is yes then
> > it explains the behaviour. The arch timer could also be continuing to
> > tick and bringing the CPUs out of ATF WFI.
> >
> 
> Yes but that doesn't explain the behaviour. It could be just the timer
> event from the broadcast timer.
> 
> > > misconfiguration.
> > > 
> > > > Arm64 recommends to use arch_timer instead of external timers. Once we
> > > > enter el3, timer interrupts to el1 is blocked and hence it's equivalent
> > > > to local-timer-stop, so it does make sense to keep this property, but
> > > > then how are others able to enter idle-states for all plugged CPUs at
> > > > the same time?
> > > >
> > > 
> > > Some systems have system timer that can take over as broadcast timer when
> > > CPUs enter deeper idle states where the local timers are stopped.
> > 
> > In CPUIdle we're not really clock gating anything so the timer does keep
> > ticking. So in this particular case it might make sense to remove the
> > local-timer-stop property from the idle-state.
> >
> 
> Correct in your case it is retention state and hence local CPU timers
> keep ticking and you can safely drop that property. However if you add
> deeper idle states like CPU OFF with the power rail cut off, then you need
> some system timer to act as backup/broadcast timer so that all the CPUs
> can enter the state concurrently and wake up successfully.
> 
> > However we're looking into taking this further and putting interconnect
> > and few other PLLs in bypass which could cause arch timer for eg. to
> > tick slower.
> 
> I assume it will be present as another timer with the rate set appropriately.
> 
> > In this case would it still make sense to omit the property? 
> 
> No, you should mark it as stopped even if it is running at slower rate
> as I am not sure if the local CPU timer support can handle rate change.

OK, makes sense.

> 
> > We may even have some usecases planned where we may turn OFF
> > the CPU once it is in TF-A cpu_standby/ WFI. What would be the right
> > approach in such scenarios?
> >
> 
> As mentioned above, this will be separate state and all CPUs can use this
> if there is another system broadcast timer.
> 
> > Could you provide any examples where the local-timer-stop property is
> > being used and an alternative timer can be configured once we enter the
> > idle-state where CPU CTX maybe lost or clocks maybe bypass?
> > great if you could share some example implementation if you're aware.
> 
> As I mentioned, Juno R2 is an example. It was broken on R0 with some SoC
> errata(can't recall all the details as I looked at it almost a decade ago)

Sorry for the late response, Thanks for all the pointers!
I will go through juno R2 once and understand what's going on.

What I see maybe helping it is as you mentioned these timers being
routed to GIC. [1]

8<---------------------------------------------------------------------------
memtimer: timer@2a810000 {
	compatible = "arm,armv7-timer-mem";
	reg = <0x0 0x2a810000 0x0 0x10000>;
	clock-frequency = <50000000>;
	#address-cells = <1>;
	#size-cells = <1>;
	ranges = <0 0x0 0x2a820000 0x20000>;
	status = "disabled";
	frame@2a830000 {
		frame-number = <1>;
		interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
		reg = <0x10000 0x10000>;
	};
};
--------------------------------------------------------------------------->8

I will have to go back and see how I can use some of the timers on my
SoC that lie outside the A53s to register as clocks incase of
local-timer-stop scenario.
We already have few timers [2], I will check which one would be the
right one to use, and remove it from being used as a pwm timer and
rather be used for the A53 timer. This[3] is the driver for our platform.

[1]
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/arm/juno-base.dtsi#L10
[2]
https://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/ti/k3-am62-main.dtsi#L247
[3]
https://github.com/torvalds/linux/blob/master/drivers/clocksource/timer-ti-dm-systimer.c

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

