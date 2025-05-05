Return-Path: <linux-pm+bounces-26637-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A2AC6AA90B3
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 12:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD3B23B7C24
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 10:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA04F1F4261;
	Mon,  5 May 2025 10:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wrdSdj5N"
X-Original-To: linux-pm@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBE17C21E
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746440214; cv=none; b=Azkue5Wx/DD7F0e+pV1XIeLdtpKR9wn+BLlFi6V8WIVeltM8PHXO9Rl0vmVlH9UXDe8gvVlUQdO9RgHfy8LqK7O00I3YkW+Oou8/iB6/4C3dUFOOn6p1PRxkTMeo42vDUldCg3/GqVLfIiWhoJrExvU+wOnXLyfNnYVm0GofOh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746440214; c=relaxed/simple;
	bh=mevWuU4xNwiUirBkvdaNf+/+QiabGjfTbLpHvUrs9FQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HVbJ8VInx9tMzBM8LsGh0vogsNvjRN8pmXfX3va60Yf2aH0HKUC14GLLKhlfR2kf1u+SugGG45M6x4bvqKSZEbTfAvU7vOafClWxHXfg+2KYiQfKWTHt5s2+jTCJN6neC3T58gTyU4Mvuzf0rPGqi3Wr4JlzTjWUtAvcxINGdLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wrdSdj5N; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43d7374f-dc89-4137-bb7d-39b9b1a1dd63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746440200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k9oeIjP/XK15ndT9uH90YP5m53JwmFwFM7/2OTSeJIY=;
	b=wrdSdj5Nz0QcfudccPsOjQ8nWkhyqQ41MCdvQKMr4Mz0I7OyXzNlTsRiI/I8J3hZ4xY6CP
	QZH/AqHwyWs51D48n/jcJHd1cjPMISGkQfstkxbL/7+V5kp3KezE04O/DBHq3KjuO2WGex
	anxBLHoNZs8or2MqNWUwp8ywmgw4ngg=
Date: Mon, 5 May 2025 12:16:37 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] soundwire: intel_auxdevice: Fix system suspend/resume
 handling
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Vinod Koul <vkoul@kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, linux-sound@vger.kernel.org
References: <5891540.DvuYhMxLoT@rjwysocki.net>
 <30acf520-c137-4b49-8b69-08e35a7c5969@linux.dev>
 <CAJZ5v0iCsd8fdXRdicT7mqsRte39WC+SVjgfz2NHS9QpvSnDdw@mail.gmail.com>
 <CAJZ5v0iFPf=WT3CjNqtioUoiX9jc5nmZLJnAkQOhBTmGq_ioAw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
In-Reply-To: <CAJZ5v0iFPf=WT3CjNqtioUoiX9jc5nmZLJnAkQOhBTmGq_ioAw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/25/25 13:43, Rafael J. Wysocki wrote:
> On Fri, Apr 25, 2025 at 8:10 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Apr 25, 2025 at 7:14 PM Pierre-Louis Bossart
>> <pierre-louis.bossart@linux.dev> wrote:
>>>
>>> On 4/24/25 20:13, Rafael J. Wysocki wrote:
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> The code in intel_suspend() and intel_resume() needs to be properly
>>>> synchronized with runtime PM which is not the case currently, so fix
>>>> it.
>>>>
>>>> First of all, prevent runtime PM from triggering after intel_suspend()
>>>> has started because the changes made by it to the device might be
>>>> undone by a runtime resume of the device.  For this purpose, add a
>>>> pm_runtime_disable() call to intel_suspend().
>>>
>>> Allow me to push back on this, because we have to be very careful with a hidden state transition that needs to happen.
>>>
>>> If a controller was suspended by pm_runtime, it will enter the clock stop mode.
>>>
>>> If the system needs to suspend, the controller has to be forced to exit the clock stop mode and the bus has to restart before we can suspend it, and that's why we had those pm_runtime_resume().
>>>
>>> Disabling pm_runtime when entering system suspend would be problematic for Intel hardware, it's a known can of worms.
>>
>> No, it wouldn't AFAICS.

I was referring to the SoundWire controller. The states are different 
between pm_runtime suspend (clock is stopped but external wakes are 
supported) and system suspend (external wakes are not supported).

If the system suspend is entered while the device is already in 
pm_runtime suspend, then we have to perform a full resume before the 
system suspend.

I am not going to argue on how to perform this resume, just that it's 
required. The direction transition from pm_runtime suspend to system 
suspend is not supported.

>>> It's quite possible that some of the code in intel_suspend() is no longer required because the .prepare will resume the bus properly, but I wanted to make sure this state transition out of clock-stop is known and taken into consideration.
>>
>> This patch doesn't change the functionality in intel_suspend(), it
>> just prevents runtime resume running in parallel with it or after it
>> from messing up with the hardware.
>>
>> I don't see why it would be unsafe to do and please feel free to prove me wrong.
> 
> Or just tell me what I'm missing in the reasoning below.
> 
> This code:
> 
> -    if (pm_runtime_suspended(dev)) {
> -        dev_dbg(dev, "pm_runtime status was suspended, forcing active\n");
> -
> -        /* follow required sequence from runtime_pm.rst */
> -        pm_runtime_disable(dev);
> -        pm_runtime_set_active(dev);
> -        pm_runtime_mark_last_busy(dev);
> -        pm_runtime_enable(dev);
> -
> -        pm_runtime_resume(bus->dev);
> -
> -        link_flags = md_flags >> (bus->link_id * 8);
> -
> -        if (!(link_flags & SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE))
> -            pm_runtime_idle(dev);
> -    }
> 
> that is being removed by my patch (because it is invalid - more about
> that later) had never run before commit bca84a7b93fd ("PM: sleep: Use
> DPM_FLAG_SMART_SUSPEND conditionally") because setting
> DPM_FLAG_SMART_SUSPEND had caused the core to call
> pm_runtime_set_active() on the device in the noirq resume phase, so it
> had never been seen as runtime-suspended in intel_resume().  After
> commit bca84a7b93fd the core doesn't do that any more, so if the
> device has been runtime-suspended before intel_suspend() runs,
> intel_resume() will see that its status is RPM_SUSPENDED.  The code in
> question will run and it will crash and burn if
> SDW_INTEL_MASTER_DISABLE_PM_RUNTIME_IDLE is set in the link flags.
> 
> The reason why that code is invalid is because the
> pm_runtime_set_active() call in it causes the status to change to
> RPM_ACTIVE, but it doesn't actually change the state of the device
> (that is still physically suspended).  The subsequent
> pm_runtime_resume() sees that the status is RPM_ACTIVE and it doesn't
> do anything.  At this point, the device is still physically suspended,
> but its runtime PM status is RPM_ACTIVE, so if pm_runtime_idle() runs,
> it will trigger an attempt to suspend and that will break because the
> device is already suspended.
> 
> So this code had never run before and it demonstrably doesn't work, so
> I don't see why removing it could be incorrect.

I don't have enough knowledge to counter your arguments :-). I think we 
misread the documentation in runtime_pm.pst, this sort of sequence is 
mentioned but on system resume, and we applied it for system suspend as 
well.




