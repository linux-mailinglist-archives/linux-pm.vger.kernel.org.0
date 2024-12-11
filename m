Return-Path: <linux-pm+bounces-18984-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25449EC475
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 06:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A041166703
	for <lists+linux-pm@lfdr.de>; Wed, 11 Dec 2024 05:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90741C07CF;
	Wed, 11 Dec 2024 05:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MiX1K6rA"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760A586331;
	Wed, 11 Dec 2024 05:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733896275; cv=none; b=lq15MH9u4U8elZZ7d40pHNXRv6IHPr/e/WgPAcj2FbK3uMU+p2AepBdPgRkuvYDYfVSCLMFqX1ps9OcUMEt6ReBOiM4JMYf+MAqSSIrFK4b+e25PUEdCA/NIOmH1pdFlU/A4nLYWNKhnRXN/OheeAIkmGlBGJsH2ONOF0c8AIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733896275; c=relaxed/simple;
	bh=ER+WHciIHxIvXcURIVwfoibHDHpRI8TU75YZ2VVMrmo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZQKHWkJywkilTV+hC14+BC/aYr8UO9lNhn++ldgsqHAJTlNeBbPPXiVORm3g2CwHM9hVi39XA87cpJYEK80SDgP7BQwPiaGTOlbDOBzT6vaQv7FKdObZDV/fnv0xqjAITkwxT7OOlvNhlrVOjsbp9/DCawVn2pnsenRb9oLvlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=MiX1K6rA; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BB5orHM2575121
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Dec 2024 23:50:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1733896254;
	bh=elDffjx4OH6SRJ4sYrMr/jtN2gDKhRQX2JMdW7ThPak=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=MiX1K6rANJ762nagAgnOCCends7HgNQkNptdpkG7a3hwItvApyoEsDjp+dr89XRnt
	 FVREdbLDKIxd5coDOkbMcyLhRD7P7KlAlXrTs1QDKunL1oue5yQepiCBZeoqRpEbuK
	 kbmvJB5pEaErrB7Kv3ayv/AxKv2VreL/sTRpOQiw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4BB5orpZ103007
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 10 Dec 2024 23:50:53 -0600
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 10
 Dec 2024 23:50:53 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 10 Dec 2024 23:50:53 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BB5oqsI039946;
	Tue, 10 Dec 2024 23:50:53 -0600
Date: Wed, 11 Dec 2024 11:20:52 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Vivek yadav <linux.ninja23@gmail.com>
CC: <linux-newbie@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <daniel.lezcano@linaro.org>, <lpieralisi@kernel.org>,
        <krzk@kernel.org>, <christian.loehle@arm.com>, <sudeep.holla@arm.com>,
        <quic_sibis@quicinc.com>, <cristian.marussi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <vigneshr@ti.com>, <khilman@ti.com>, <sebin.francis@ti.com>,
        <d-gole@ti.com>
Subject: Re: Fwd: ARM64: CPUIdle driver is not select any Idle state other
 then WFI
Message-ID: <20241211055052.gbxnyqpui3t3zpw5@lcpd911>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Vivek,

On Oct 14, 2024 at 16:06:34 +0530, Vivek yadav wrote:
> ---------- Forwarded message ---------
> From: Vivek yadav <linux.ninja23@gmail.com>
> Date: Fri, Oct 11, 2024 at 3:14 PM
> Subject: ARM64: CPUIdle driver is not select any Idle state other then WFI
> To: <linux-pm@vger.kernel.org>

+ Kevin, Vignesh and few colleagues at TI who have been working on this as
well.

> 
> 
> Hi @all,
> 
> I am working on one custom SoC. Where I add one CPUIdle state for
> ``arm,cortex-a55`` processor.

Any further luck on this?

I have also been working on something similar[1] but on an A53 core on
TI-K3 AM62x processor.

> 
> idle-states {
>       entry-method = "psci";
>        cpu_ret_l: cpu-retention-l {
>          compatible = "arm,idle-state";
>          arm,psci-suspend-param = <0x00010001>;
>          local-timer-stop;
>          entry-latency-us = <55>;
>           exit-latency-us = <140>;
>           min-residency-us = <780>;
>     };
> };
> 
> I am using ``Menu governor`` with the ``psci_idle driver`` in its original form.
> After booting Linux I find out that the CPUIdle core is never going
> inside the ``cpu-retention`` state.
> To check time spent by CPU in any state. I am using the below command.
> 
> ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``

What I was seeing is in a multi core system (2 or more) all cores don't
enter the idle-state simultaneously. There's something keeping atleast 1
core always busy. However I could definitely see entry into TF-A from 1
core at a time.
I then switched to a single core system to see if we were atall able to
enter TF-A when only 1 core was available for linux, it turned out that
with the "local-timer-stop" property that we have, this is never
possible.

See this chunk in the kernel cpuidle driver:
	if (broadcast && tick_broadcast_enter()) {

When I dug deeper into tick_broadcast_enter it always returns something
non zero and hence in my case it was entering the if block and tried to
find a deepest state. Then the deepest state would always return WFI and
not the idle-state I had added.

What we found out was on our kernel we end up using 

kernel/time/tick-broadcast-hrtimer.c 

This always seems to be keeping atleast 1 CPU busy and prevents idle.
If we remove the local-timer-stop it was helping us, but we still need
to dig into the full impact of what that entails and I am still
interested in finding out how so many other users of similar idle-state
implementation are able to do so without trouble.

Arm64 recommends to use arch_timer instead of external timers. Once we
enter el3, timer interrupts to el1 is blocked and hence it's equivalent
to local-timer-stop, so it does make sense to keep this property, but
then how are others able to enter idle-states for all plugged CPUs at
the same time?

> 
> OUTPUT:
> 0 ===>CPU0 state0 (WFI)
> 0 ===>CPU0 state1 (cpu-retention)
> 
> increasing some time value ===>CPU1 state0 (WFI)
> 0 ===>CPU1 state1 (cpu-retention)
> 
> increasing some time value
> 0
> 
> increasing some time value
> 0
> 
> What am I doing wrong? Why does ``cpu-retention`` state time not increase?
> Any pointer will be helpful.

I had asked a similar qn. on IRC [2], but didn't get much response. I
am still interested in finding out what the right thing to do here is.

[1] https://github.com/DhruvaG2000/v-linux/commit/0fd088d624276a2e72b8dc6660d261ab6d194f4b#diff-34369928f669d14776f8f5bdbe3fc3d75306196a2ac28b1a4d7e17402b9c3995R160
[2] https://libera.irclog.whitequark.org/armlinux/2024-08-23 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

