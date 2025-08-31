Return-Path: <linux-pm+bounces-33491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B7AB3D55A
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 23:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D461D7AA818
	for <lists+linux-pm@lfdr.de>; Sun, 31 Aug 2025 21:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E94247298;
	Sun, 31 Aug 2025 21:30:18 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBF674A04;
	Sun, 31 Aug 2025 21:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756675818; cv=none; b=mknPSVR1O265mDyCKcEttjfLU0et/pPWJ6P2ygehNYlGSVQ/GK0UfK32U2EQj/NC/xAxEburIeMtcmiZwi3VuVDevwFFEi/YAPMicvvj5c6C5g9kKWJRn3YbE2pOQMTQpLxFTfqf6rNTAM7XTjOoOh3mKbaeJ2mzZ36FOz5hutQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756675818; c=relaxed/simple;
	bh=oIxuXkfSseOKb2DSBy4MWIrocNC2sTkpyvkWCsKkAH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r1eXYS+x4qQOS1NEZscvSUX1Bzm6ZeANqB8euMsWiBK6GGTFYqEkIcso2gSm2pUpeltwwRzkE6BGJg0swVq8DwL/SBKpnlpHwXAZFHrV85CckETQS6dDhy5iuWAG9iqXsc0eqZCF5Eks80pWYcTswiHtqV8rfxEI4XeRG/th/WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F5FB1D13;
	Sun, 31 Aug 2025 14:30:00 -0700 (PDT)
Received: from [10.57.78.139] (unknown [10.57.78.139])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 886723F694;
	Sun, 31 Aug 2025 14:30:07 -0700 (PDT)
Message-ID: <ce8b4488-a165-4847-8f2b-e2ee65746e00@arm.com>
Date: Sun, 31 Aug 2025 22:30:05 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] cpuidle: governors: teo: Special-case nohz_full CPUs
To: "Rafael J. Wysocki" <rafael@kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>
References: <2804546.mvXUDI8C0e@rafael.j.wysocki>
 <5939372.DvuYhMxLoT@rafael.j.wysocki>
 <CAJZ5v0gniATfcckSwfJBmLf9O345Ersw-TUMVFWTSWxTN5K+0A@mail.gmail.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <CAJZ5v0gniATfcckSwfJBmLf9O345Ersw-TUMVFWTSWxTN5K+0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/29/25 20:37, Rafael J. Wysocki wrote:
> On Thu, Aug 28, 2025 at 10:16 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> This change follows an analogous modification of the menu governor [1].
>>
>> Namely, when the governor runs on a nohz_full CPU and there are no user
>> space timers in the workload on that CPU, it ends up selecting idle
>> states with target residency values above TICK_NSEC, or the deepest
>> enabled idle state in the absence of any of those, all the time due to
>> a tick_nohz_tick_stopped() check designed for running on CPUs where the
>> tick is not permanently disabled.  In that case, the fact that the tick
>> has been stopped means that the CPU was expected to be idle sufficiently
>> long previously, so it is not unreasonable to expect it to be idle
>> sufficiently long again, but this inference does not apply to nohz_full
>> CPUs.
>>
>> In some cases, latency in the workload grows undesirably as a result of
>> selecting overly deep idle states, and the workload may also consume
>> more energy than necessary if the CPU does not spend enough time in the
>> selected deep idle state.
>>
>> Address this by amending the tick_nohz_tick_stopped() check in question
>> with a tick_nohz_full_cpu() one to avoid effectively ignoring all
>> shallow idle states on nohz_full CPUs.  While doing so introduces a risk
>> of getting stuck in a shallow idle state for a long time, that only
>> affects energy efficiently, but the current behavior potentially hurts
>> both energy efficiency and performance that is arguably the priority for
>> nohz_full CPUs.
> 
> This change is likely to break the use case in which CPU isolation is
> used for power management reasons, to prevent CPUs from running any
> code and so to save energy.
> 
> In that case, going into the deepest state every time on nohz_full
> CPUs is a feature, so it can't be changed unconditionally.
> 
> For this reason, I'm not going to apply this patch and I'm going to
> drop the menu governor one below.
> 
> The only way to allow everyone to do what they want/need I can see
> would be to add a control knob for adjusting the behavior of cpuidle
> governors regarding the handling of nohz_full CPUs.

But then what's the advantage instead of just using
/sys/devices/system/cpu/cpuX/power/latency
for the nohz_full CPUs (if you don't want the current 'over-eagerly
selecting deepest state on nohz_full')?

