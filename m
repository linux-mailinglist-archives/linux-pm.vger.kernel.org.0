Return-Path: <linux-pm+bounces-21005-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA4DA207AB
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 10:48:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01E73A505D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 09:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC952199FA2;
	Tue, 28 Jan 2025 09:48:04 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC3178C91;
	Tue, 28 Jan 2025 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738057684; cv=none; b=OvvZTB2wWu555mC7XXwY9Ra2KFf/k74SH2/7i+adK7lgfH0vfk6SYcHgkkLPSmbm10c3uD1v2LnQfkBHkL38RMlP28Epn7CuETX5mcwWX8hhYHS1vajxO/VQoUT8YBacfNVXrYbKhC1EIr1cWErNPbhwg3+1k4Y/rr+6epxYHXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738057684; c=relaxed/simple;
	bh=pgqurVE7n+dBRRbVSZNDxSOU10isFS7/1Vt4wKLRUmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7heOGK2aSTZizovVZfv8lrWFGW9obpN8Nt+dK+Mkmf45xiCk3RMyik+9K4J68m1WuPxoPx9WhQT1EAMt0T+5LCKBPtFXB2uqr8HDae3YSsoZm7CogT4rkpThigLL6p9ha91lcCPB2oqkB90gSkRvjkKo3Vkd6/npnDBO4C/PDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7E680497;
	Tue, 28 Jan 2025 01:48:22 -0800 (PST)
Received: from bogus (unknown [10.57.35.254])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACBDE3F528;
	Tue, 28 Jan 2025 01:47:52 -0800 (PST)
Date: Tue, 28 Jan 2025 09:47:20 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Vivek yadav <linux.ninja23@gmail.com>
Cc: Dhruva Gole <d-gole@ti.com>, linux-newbie@vger.kernel.org,
	linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
	lpieralisi@kernel.org, krzk@kernel.org, christian.loehle@arm.com,
	quic_sibis@quicinc.com, cristian.marussi@arm.com,
	Sudeep Holla <sudeep.holla@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	vigneshr@ti.com, khilman@ti.com, sebin.francis@ti.com,
	khilman@baylibre.com
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
Message-ID: <20250128094720.sgk7gyr5oawzxbez@bogus>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
 <20241211055052.gbxnyqpui3t3zpw5@lcpd911>
 <20241211121825.GA2054801@bogus>
 <20241211143428.kaoovhiwar74dy6x@lcpd911>
 <Z1rbLdWW75KQw5cl@bogus>
 <CAO6a-98XFxbCnOMp5ARwPssjYomyNKWjT=WTk=z2+ZKyOAQ0jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO6a-98XFxbCnOMp5ARwPssjYomyNKWjT=WTk=z2+ZKyOAQ0jQ@mail.gmail.com>

On Mon, Jan 27, 2025 at 10:47:28PM +0530, Vivek yadav wrote:
> Hi @Dhruva Gole,
> 
> Q.1. Does your CA-53 properly go into CPUIdle state and come out of
> sleep state ?

Yes, well tested on other SoCs. Seems like system integration issue.
> As of now I made some changes in the DT node. After making changes in
> latency (which is mentioned below).
> 
>  idle-states {
>        entry-method = "psci";
>         cpu_ret_l: cpu-retention-l {
>           compatible = "arm,idle-state";
>           arm,psci-suspend-param = <0x00000000>;
>           local-timer-stop;
>           entry-latency-us = <300000>; # 300ms
>            exit-latency-us = <300000>; # 300ms
>            min-residency-us = <1000000>; # 1 sec
>      };
>  };
>

Does these align with expectation of PSCI implementation in the firmware ?


> I can see that  CA-55 went into a sleep state (state1) using command
> ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``.
> As you mention earlier in a multicore system (2 or more) at least one
> core keeps working and does not go into sleep state. It should happen
> as per theory and other developers' case.
> 
> In my case, after some time, both CPUs (CPU0 and CPU1) go into sleep
> state (state1). Hence the system console hangs.
> 
> My expectations are,
> If I type anything on keyboard. UART interrupt should take out CPUs
> from sleep state and execute commands. OR some periodic timer should
> take the CPU out of sleep. Which is not happening as of now.
> As you said  we can safely remove`` local-timer-stop``. It means local
> timers are working for the CPUs and triggering interrupts ?
> 

Please go the thread and understand when and why you need local-timer-stop and
how it is related to the arm,psci-suspend-param value(especially the state
context loss bit)

I have not got response to my questions. You can just play with DT and get
things working here if the firmware expectation, hardware functionality
and DT properties don't align.

-- 
Regards,
Sudeep

