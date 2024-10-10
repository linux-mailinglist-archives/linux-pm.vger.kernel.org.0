Return-Path: <linux-pm+bounces-15444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7639983B8
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46841F24DE3
	for <lists+linux-pm@lfdr.de>; Thu, 10 Oct 2024 10:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33291BD003;
	Thu, 10 Oct 2024 10:33:14 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234BC1BD039
	for <linux-pm@vger.kernel.org>; Thu, 10 Oct 2024 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728556394; cv=none; b=NvbVCnswhIo2Igmcn0dyDuZweizx31W8Y0soAJghVCPuFGleX+PTkNlH16ir24C5tifkK461eLVq+4lt7RyT/HhPDz16Z3B2L6w+GcFf14nsMB/Y4n5VMzYtkAhnT/wlef8X/ha4r8te2c6EFw7Y6+5baVae1gRXJHDYqUAZclI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728556394; c=relaxed/simple;
	bh=sR3HT2oHfInN1HpYMsvENmALxm0EdDunYLtD1/CfFKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WR1CIXKbDUW1bH7qC7Sd+1yK2uGYnHTCyMhIxzD6w8C3xHYgWhSq39z1Msbg8tVlgvgHGSeFylqP4numdr30QgAW9watsr1EaP7ouBb2u75yO/E3soFTka9wlVpTIBFSyYEEmkJxVE+LlPUMk0PTd2/QBrA50McNt1lxgbW8xVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6DCC497;
	Thu, 10 Oct 2024 03:33:41 -0700 (PDT)
Received: from [192.168.0.16] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ABC93F58B;
	Thu, 10 Oct 2024 03:33:10 -0700 (PDT)
Message-ID: <7e22ed71-4e61-4250-a81d-eda4f4647b8b@arm.com>
Date: Thu, 10 Oct 2024 11:33:09 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: arm64 s2idle vs. workqueues
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
 Saravana Kannan <saravanak@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd
 <sboyd@kernel.org>, linux-pm@vger.kernel.org
References: <7ho73shkrw.fsf@baylibre.com>
 <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0hTYkR64x_h5_Qn_J6k=seSZ=eKqdNKEC+UzkQMe1wC1A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/10/24 11:23, Rafael J. Wysocki wrote:
> Hi Kevin,
> 
> On Thu, Oct 10, 2024 at 2:19 AM Kevin Hilman <khilman@baylibre.com> wrote:
>>
>> Hello,
>>
>> Looking for some pointers/tips on debugging s2idle, and in particular
>> why it is not staying in an idle state as long as expected.
>>
>> I'm attempting to use s2idle on a 4-core, single cluster ARM64 SoC (TI
>> AM62x), which doesn't (yet) have any DT defined idle-states, so is just
>> doing a WFI when idle.
>>
>> I'm doing an 8-second s2idle with RTC wakeup by using:
>>
>>   rtcwake -m freeze -s8
>>
>> and what I see is that 3 of the CPUs stay in their idle state for the
>> full 8 seconds, but one of them keeps waking due to the A53
>> arm_arch_timer firing, and processing misc. workqueue related activity
>> (example work listed below[1].)
>>
>> I realize that these workqueues are not WQ_FREEZABLE, so I don't expect
>> the freezer part of suspend to stop/freeze them.  However, I am a bit
>> surprised to see this non-frozen workqueue activity happening often
>> enough (few times per second) to prevent all 4 CPUs from being idle for
>> long periods at the same time, thus preventing a deeper cluster-idle
>> state.
>>
>> Is there something else I'm missing that is needed to keep these
>> workqueues quiet for longer?  I had assumed that most of this workqueue
>> work would be deferred, and shouldn't need to wakeup a CPU just to run.
>>
>> In case it's helpful I have published a trace.dat from trace-cmd which
>> captures power, sched, irq, timer and workqueue events.  With
>> kernelshark, it's pretty obvious to visualize what's happening: CPU0,1,3
>> are all nicely idle for 8 sec while CPU2 is waking due to the timer and
>> workqueue activity.
>>
>> Any pointers to how to improve this situation, or what else needs to be
>> tweaked here would be greatly appreciated,
> 
> It looks like tick_freeze() is not called, which only happens in
> enter_s2idle_proper() that is called from cpuidle_enter_s2idle() if
> there are any idle states with an .enter_s2idle() callback.
> 
> So does the cpuidle driver for this platform provide .enter_s2idle()
> callbacks for any of its idle states?

AFAICT there shouldn't be a cpuidle driver that initialized and WFI is
entered through arch code. The trace.dat indicates that, too.

@Kevin
I assume you can add a state in the DT, disable it and everything works
as expected?


