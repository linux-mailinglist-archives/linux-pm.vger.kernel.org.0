Return-Path: <linux-pm+bounces-21010-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E97A2095D
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 12:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450B93A5CEA
	for <lists+linux-pm@lfdr.de>; Tue, 28 Jan 2025 11:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5B619F40A;
	Tue, 28 Jan 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CjLUuY5g"
X-Original-To: linux-pm@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7930819F103;
	Tue, 28 Jan 2025 11:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062865; cv=none; b=suynWelZOxQKdF9qzY4IHeRZm1yt/VZJ/0hwYYScBQEeKmJVlbD7Vvv1s2u5ni22ZwdHvP7nNApsLi4CQu8r402KK+i8D48UHfzaiXlzPAdmYzLhFekvdFnSrGIDXKSmSHVaXZnduFkYW6WTD/zkZPNZ53lPLh8PEnXS/xjcu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062865; c=relaxed/simple;
	bh=Jcf1R/yTJoD8mRNd+L+foDCFOMRh6wZdrsACFFxZBLo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D+QA1KMjMumixcuJ63Z5tLGBGB0/4eF40lJa/M36UoEcj16W/3TDP6UcN5YWy76qMxgU4lW59Uf9shL5SOwnGiYOWTNixhaJjkzZ3qeXvOF+3Tz9hr7nXIgtEQooQKp5evOxB8RNxNrdCa4x8Qy19Tt43hrsEnS3LQML/glnuno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=CjLUuY5g; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 50SBE8xm1951268
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jan 2025 05:14:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1738062849;
	bh=PaB9zjJJf1lkvcUrXACl1LaqEcDbvmCXCZVlOwFJpjk=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=CjLUuY5gVLXfuB/N5oPB5Hy6DKS1ul4QdAh56ZC4if4GiuWN2kTZtfxJkUh7BjCfE
	 Ge8wr+E1MxbqobYs2RuwWQ0dtiSKcftyaFKPnP5/oLRaLIGFPXRG19p+775xapS0ZB
	 WjU9/WaPw5HxrBcRGQOGvo/lg4XamXfiz/RbsUgs=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 50SBE8H0002142
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 28 Jan 2025 05:14:08 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 28
 Jan 2025 05:14:08 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 28 Jan 2025 05:14:08 -0600
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 50SBE7JV125661;
	Tue, 28 Jan 2025 05:14:08 -0600
Date: Tue, 28 Jan 2025 16:44:07 +0530
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
Message-ID: <20250128111407.6hbefatwhuomstzo@lcpd911>
References: <CAO6a-9_aPLCx2CqecQBGbK78_=+-tT44RepPkrBjpkWSvjj4Tg@mail.gmail.com>
 <CAO6a-98cdSvyd7jgAyGNmsC2nxmRSyr3GppxvZU9yHU1xqwz3g@mail.gmail.com>
 <20241211055052.gbxnyqpui3t3zpw5@lcpd911>
 <20241211121825.GA2054801@bogus>
 <20241211143428.kaoovhiwar74dy6x@lcpd911>
 <Z1rbLdWW75KQw5cl@bogus>
 <CAO6a-98XFxbCnOMp5ARwPssjYomyNKWjT=WTk=z2+ZKyOAQ0jQ@mail.gmail.com>
 <20250128094720.sgk7gyr5oawzxbez@bogus>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250128094720.sgk7gyr5oawzxbez@bogus>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Hi Sudeep and Vivek,

On Jan 28, 2025 at 09:47:20 +0000, Sudeep Holla wrote:
> On Mon, Jan 27, 2025 at 10:47:28PM +0530, Vivek yadav wrote:
> > Hi @Dhruva Gole,
> > 
> > Q.1. Does your CA-53 properly go into CPUIdle state and come out of
> > sleep state ?
> 
> Yes, well tested on other SoCs. Seems like system integration issue.

Yes, with the local-timer-stop property removed, all A53 cores do enter
idle in TF-A at the same time.

> > As of now I made some changes in the DT node. After making changes in
> > latency (which is mentioned below).
> > 
> >  idle-states {
> >        entry-method = "psci";
> >         cpu_ret_l: cpu-retention-l {
> >           compatible = "arm,idle-state";
> >           arm,psci-suspend-param = <0x00000000>;
> >           local-timer-stop;
> >           entry-latency-us = <300000>; # 300ms
> >            exit-latency-us = <300000>; # 300ms
> >            min-residency-us = <1000000>; # 1 sec
> >      };
> >  };
> >
> 
> Does these align with expectation of PSCI implementation in the firmware ?

Just to add here, value of that parameter has some encoded
meaning and is given in the PSCI standard:
Table 7 power_state parameter bit fields in Original format
https://developer.arm.com/documentation/den0022/fb/?lang=en

> 
> 
> > I can see that  CA-55 went into a sleep state (state1) using command
> > ``cat /sys/devices/system/cpu/cpu*/cpuidle/state*/time``.
> > As you mention earlier in a multicore system (2 or more) at least one
> > core keeps working and does not go into sleep state. It should happen
> > as per theory and other developers' case.
> > 
> > In my case, after some time, both CPUs (CPU0 and CPU1) go into sleep
> > state (state1). Hence the system console hangs.
> > 
> > My expectations are,
> > If I type anything on keyboard. UART interrupt should take out CPUs
> > from sleep state and execute commands. OR some periodic timer should
> > take the CPU out of sleep. Which is not happening as of now.
> > As you said  we can safely remove`` local-timer-stop``. It means local
> > timers are working for the CPUs and triggering interrupts ?
> > 
> 
> Please go the thread and understand when and why you need local-timer-stop and
> how it is related to the arm,psci-suspend-param value(especially the state
> context loss bit)

Yes this is the important bit, if you know that on your platform the
A53s are just not going to power off or stop timers upon entering idle
then you must remove the local-timer-stop property from your DT
cpu_ret_l.
However, if you do have a scenario where the timer would be getting
stopped or modified in idle scenario, then linux needs to be able to use
another timer that is routed to the GIC and is unaffected while the
system is in idle.

This is what my understanding is so far, I am yet to do experiments with
local-timer-stop + different timer in the case of idle.

> 
> I have not got response to my questions. You can just play with DT and get
> things working here if the firmware expectation, hardware functionality
> and DT properties don't align.

I have responded to the thread now, sorry for not getting back earlier!

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

