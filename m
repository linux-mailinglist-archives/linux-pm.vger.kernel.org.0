Return-Path: <linux-pm+bounces-33875-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9E0B444A6
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 19:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8ACE1C244E3
	for <lists+linux-pm@lfdr.de>; Thu,  4 Sep 2025 17:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C9E23115B1;
	Thu,  4 Sep 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdglNrEo"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE4A30BF67
	for <linux-pm@vger.kernel.org>; Thu,  4 Sep 2025 17:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008042; cv=none; b=DbP/q2eel4FkVaPruqOGkHfeVgUPL9zUivs/IZ8+1BKwU6u4GoXf24vZQCf1Y1gHbpcjikRUmL1yxt3sgOll66fsdTSL7eqzSpdqT67cVHQnp4JbzWe5V+7Q+j6XGbOUn4K3swKmPP2Cq3b7HbueXWCXRgj/wPA1cvFa1kFi6F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008042; c=relaxed/simple;
	bh=WiS/zKldcH5CuecqA3QVM3DCJhglrilqx5Mr5kloZEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b3Ilgc2f5Eycnr/DTDATYgxJU4iC2ueWeArZC00S43l+ZCX/jnelt3wHrh8zTTNZkxUo7h+go7GwLpCDdCsJUZs1NOQMy+l5KK9Y49gFlhOBlTDHVmlZsiAgTM2wlqcBft966J/Q6ONWR1D/g98P3art0yRGG5M9KSiWsiKpeDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdglNrEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52065C4CEF0;
	Thu,  4 Sep 2025 17:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757008040;
	bh=WiS/zKldcH5CuecqA3QVM3DCJhglrilqx5Mr5kloZEM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RdglNrEohFJgswkg3KIs0v9aNFzgX2NBW4EMGi2iG6g+hfbvxjxGboACnKbHFmGtX
	 bMSRcU+MfbzQbzleDYYTDzuakXQk3Y+Rh7hnnW7OHMgqchXtQCY+urznWL4DjxG4j/
	 6Vo36KppWxHzEYSLlS40U3Z6jJMYCn7I7WNwAPAKEd5eht4J9ffRsSDPas4H7Eujpc
	 oL7/EATEhx+qkn28/ZBnG2ag45sB0rcgeqhPyvBg8hLUkmcSNH2ThyZgpCVPUlgt97
	 67HBioo+O8Mln6XYubaMOxNqGjbPcRCRQLfJbI1ckTY8rUu4SRL4a8zwhFSd8/TtnO
	 bYw/fWe/7aVGA==
Message-ID: <5f958462-5fc1-4837-b5e1-65c0ad8badcd@kernel.org>
Date: Thu, 4 Sep 2025 12:47:19 -0500
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] MECHREVO Yilong15Pro GM5HG7A: lid switch causing unwanted
 s2idle wakeups
To: aprilgrimoire <aprilgrimoire@proton.me>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <6ww4uu6Gl4F5n6VY5dl1ufASfKzs4DhMxAN8BuqUpCoqU3PQukVSVSBCl_lKIzkQ-S8kt1acPd58eyolhkWN32lMLFj4ViI0Tdu2jwhnYZ8=@proton.me>
 <06f0c531-2cb6-4a1a-a716-406b4f5f9676@kernel.org>
 <MawTZCnf5jVqp47YcxRrH21nl0rN8O78_my4TxiZ3tFoNxuP568eHxnEH5-VIMa6DtNbHdXytnpRgVyay-UydMK5tbYe4-TG8e2BYEky5hc=@proton.me>
 <7a3a3a35-27d3-4b46-b297-475deda04656@kernel.org>
 <lyy4riGTLOpvYTPUeUx6krjnYdeE8iYbWRrLOJLOChOKMcys00nhNWJ_JD8V8kkVQk87ktMK8w7BAEosOs3KGipyHlvkvQ0_j6cipUfxYtA=@proton.me>
 <0fb5a890-63f0-412b-8d88-79b40e2c564b@kernel.org>
 <El5fBf0AkhefzH0LWKyMF3vOCNsHYBCEwxtvXD-tJfLGAFCeJ5ZVbgZE6ibf-KfMxtlkTwr3g1-feqSgfcafGzVGjulc-8QggWHHoJlRDNY=@proton.me>
 <5369f2b5-dba1-4b25-a093-7aa79c578975@kernel.org>
 <wkUEC8nqZzIcVXalYzsLi_YheAs0Tw07ug-73PAqUwKmquJr89CPnQKwBImSQLcDABIk4tfWPLCPKa00vG1jH8NpiH5f4yXVATYakltJAQI=@proton.me>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <wkUEC8nqZzIcVXalYzsLi_YheAs0Tw07ug-73PAqUwKmquJr89CPnQKwBImSQLcDABIk4tfWPLCPKa00vG1jH8NpiH5f4yXVATYakltJAQI=@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/4/25 11:34 AM, aprilgrimoire wrote:
> 
> 
>   > The Linux kernel will break from the s2dile loop when a device asserts
>> to wake the system.
>>
>> If IRQ1 triggers when the keyboard isn't pressed that is absolutely a
>> firmware bug. We can work around it with a quirk entry for
>> pmc-quirks.c. The obvious trade off is that the keyboard can't be used
>> as a wake source either, but if you don't disable IRQ1 then another even
>> that normally wouldn't wake the system "will wake the system".
>>
>> For example if you plug in the power adapter the EC will assert the SCI
>> and will notify the APU to wake up from hardware sleep. Normally the
>> kernel will process the EC events and go back to sleep.
>>
>> But if IRQ1 is spuriously active during this time then it will wake the
>> system when you plug in the power adapter. So I think it's the lesser
>> evil to add that quirk. That being said we need to figure out what GPIO
>> 0 is tied to for your system. Because maybe the better solution is to
>> disable GPIO 0 and just "rely" upon the spurious IRQ1.
>>
>> With GPIO 0 enabled, can you check when it gets triggered besides the
>> lid event? Try these:
>>
>> * Suspend on battery / power adapter plug in
>> * Suspend on AC / power adapter plug out
>> * Press power button
>> * Click touchpad
>>
>> Ideally GPIO 0 is only used for the lid, but given the ASL notifies the
>> PWRB device I don't have high hopes.
> 
> Hi, Mario!
> 
> I tried these events, and I am highly affirmative (on the patched kernel, with GPIO 0 disabled, these events don't trigger wakeups) that:
> * Press power button and keyboard triggers GPIO 0
> * Plugging / Unplugging the PD100W adapter doesn't trigger GPIO 0
>    (The model also supports 240W round-pin unknown-protocol adapters, but I don't have one here.)
> * Clicking touchpad doesn't trigger GPIO 0

 From what you've said it sounds like GPIO0 is basically an EC output 
pin that is overloaded to cover power button, lid, and keyboard.  That's 
a bit unusual for keyboard.

> 
> I think it isn't feasible to rely on the spurious IRQ1, unless some efficient re-suspend mechanism is implemented. As mentioned in

Yeah I don't think you should rely upon IRQ1.

> 
> https://community.frame.work/t/tracking-framework-amd-ryzen-7040-series-lid-wakeup-behavior-feedback/39128/10?u=aprilgrimoire
> 

I wouldn't read too much into the Framework issue - this was purely a 
polarity issue in their firmware.  It was fixed in a combination of 
their EC and BIOS.

>> I have pulled scalding hot laptops with a nearly dead battery out of my bag because the laptop didn’t go to sleep correctly and stayed on when I closed the lid.
> 
> When put in bags, the lid could move slightly upon shaken, and I am worried that IRQ1 would trigger without me knowing.
> 
> Or am I misunderstanding your suggestion on how to use the spurious IRQ1?
> 
> Thanks!

Can you double-confirm that with IRQ1 disabled that you still get GPIO0 
for keyboard wakeup specifically?


