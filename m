Return-Path: <linux-pm+bounces-30761-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E732B03790
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 09:09:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04133B8A26
	for <lists+linux-pm@lfdr.de>; Mon, 14 Jul 2025 07:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED397231A32;
	Mon, 14 Jul 2025 07:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wbpb+Fgm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACE622F762
	for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752476947; cv=none; b=qSeaQ/tb77QeA1CbJYShBBlRP9yt4O4Cl26sXmL5sO5pWq0cNdlYbsw33aSJEi56+QRzLaCOAZUwA7ABJA9/dpAcfqBLk8VEhyXL9V9sHtpz2nTi1IoXmbF8uHVHKes0pY1yejuXzIAe9M6wkscWJtGMffTKfQu4LRHtN/xqN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752476947; c=relaxed/simple;
	bh=rPSUYx/5VC6HrCnGvBFYSyrXuRZRyFGP8OwFdpfXQ88=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BkZT2cpR1AfT+bYnae/GtDtO9C2t2zE3dIViLWXb57jU9O3NDm3CnaDni7dYQKTps7P4jLUjeuI2G9CL7amZtPFSx5cHFbWW+lkIMfE8bYPI7EiASs6IDN7fCmy0SAjX+0vJg3t9zqXNNMKHrfSTpwCP1NBqh8Kbi3veTgIPCwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wbpb+Fgm; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae223591067so698811866b.3
        for <linux-pm@vger.kernel.org>; Mon, 14 Jul 2025 00:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752476944; x=1753081744; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SJUPNG/YCCutYXD8xzKdp1taJCF1uJWQ/rw5PwH8FUs=;
        b=Wbpb+FgmGpyMU3XoRGw3H3SCpGCxWsirKqYVe4Izv/yBZu55DyoEHHynySMoXO35LA
         caMRyRaxqNnndOhFrHVzh51t1E0bvcU/MUC3asVBug7hdKfX1mwgh0NWVA/Og8FakacG
         XEYO3zw2hyTpLU4pYYcpxqSLuA5ksQr6Rp1n2zAoOXG/7m4lY/HIjpma2YHWVkdBWu+d
         V3qQF3O7c5dXw8KfXjBUUB7hsoNYKWlNz9X6m5QobjnyFiCpmRuv78klYXO6hHVTGP0I
         A948VULgEccPldCxYVCq5Bu9YhDdmF0mykLz4pTjDxKnK13GXXgKA570wXQbe/+mb/82
         iEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752476944; x=1753081744;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SJUPNG/YCCutYXD8xzKdp1taJCF1uJWQ/rw5PwH8FUs=;
        b=OxlMyav1DQViTyIJ9niyhhU7VHmevqm3yjY8nmrvt+u4gcz0IQzS7UyoGMvGNcM7MV
         4EdfUmqsm5g+tUqfndJEuKHj1o3izEPCcXfZ5aesJw57TYwJgqa4vSzRcg8aan5EHIU5
         0Z3cjuCozJyq8be1zLl4gflrAfNWSJ/RyjRaQEKgJfTbl5lPSGqAcKfjwwK7zHvJdmNx
         g+I0ejlSYdUhC7Pxx4CidjAHvp3JN2OWBLuSBDXKfVnvRybWTtI+jgcvm0L0IGPQXiTg
         ifeOXYv6V/DmMIBTCJEZCElYBD0m2QIX8XKI2hn24eKt6ghvjHwyM83c8ezh47pEUE/W
         U0Fw==
X-Gm-Message-State: AOJu0YyS2VTycH9QgODTDy5ft+uEPDCFjszHC7ZYN8m6t8UW/FyeF8HG
	arbBSRdbeZ+vTLkfWt4NZZCPToF4QPCVqe1r+PX+vrYsHue1yCNegL1fiR8KTcL0OeQ=
X-Gm-Gg: ASbGncsrgAa+R/LuXpwocyraU0dp/AsU0Qok7+3BHL+MTJGraYIV3OC3+5ZYwbK91xo
	S0PvXY59lCNjTSw83lGdWVeknzMlmOSfNZx6W5gT4h3yWjreOCSwlLg3GkWzYB9E5pFJkQL8pB4
	pY3+jjm1PTvd8/wcsacfzS5fDWCnKnlqjX7DInFYNPfjw+MawsnHLky+xcaR80nJQ7P+UM6MgUP
	/dtSiUE4nIPuMpa2SaIHmq5T8jj+F0EHNsKPSMMWFvzDFxDVQO67X3O42cYbB7iv4/Cc8Wd7rPv
	NG7NcgurHaRl5nh9FkJYlM1jDdG3cDSlvyeHcDkSnRNU16ft8gH41cbFOceFHImSrqSf4Lh3Spn
	8J/S7PToqRnlXxk5eUG+O1YgkhvURqssU
X-Google-Smtp-Source: AGHT+IET/7RfXjto9C+sVjtiLIsOnH7n9hntCoUGq+Uy8AgUeJogWTjQLJDpvqeFUo+zNnA5GkpHeg==
X-Received: by 2002:a17:907:6d2a:b0:ae8:fd2d:44b8 with SMTP id a640c23a62f3a-ae8fd2d4636mr810859666b.29.1752476943736;
        Mon, 14 Jul 2025 00:09:03 -0700 (PDT)
Received: from [192.168.0.251] ([188.27.143.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e82635aasm758859166b.84.2025.07.14.00.09.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Jul 2025 00:09:03 -0700 (PDT)
Message-ID: <ae6d65f7-990a-4145-9865-63f23518405c@linaro.org>
Date: Mon, 14 Jul 2025 08:09:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] PM: sleep: Resume children after resuming the
 parent
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>, Ulf Hansson
 <ulf.hansson@linaro.org>, Johan Hovold <johan@kernel.org>,
 Jon Hunter <jonathanh@nvidia.com>, Saravana Kannan <saravanak@google.com>,
 William McVicker <willmcvicker@google.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
References: <10629535.nUPlyArG6x@rjwysocki.net>
 <CAJZ5v0hpPOHNYCSTM1bb+p-wyAZkpg+k-huf9f5df9_S8MfvEg@mail.gmail.com>
 <CAJZ5v0jFP2njw3ic47yyh_7u7evKQKQuqGp27Vj7X-FfDLH7uQ@mail.gmail.com>
 <4677865.LvFx2qVVIh@rjwysocki.net>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <4677865.LvFx2qVVIh@rjwysocki.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/12/25 8:54 AM, Rafael J. Wysocki wrote:
> On Friday, July 11, 2025 3:54:00 PM CEST Rafael J. Wysocki wrote:
>> On Fri, Jul 11, 2025 at 3:38 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Fri, Jul 11, 2025 at 3:08 PM Tudor Ambarus <tudor.ambarus@linaro.org> wrote:
>>>>
>>>>
>>>> Hi, Rafael,
>>>>
>>>> On 3/14/25 12:50 PM, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> According to [1], the handling of device suspend and resume, and
>>>>> particularly the latter, involves unnecessary overhead related to
>>>>> starting new async work items for devices that cannot make progress
>>>>> right away because they have to wait for other devices.
>>>>>
>>>>> To reduce this problem in the resume path, use the observation that
>>>>> starting the async resume of the children of a device after resuming
>>>>> the parent is likely to produce less scheduling and memory management
>>>>> noise than starting it upfront while at the same time it should not
>>>>> increase the resume duration substantially.
>>>>>
>>>>> Accordingly, modify the code to start the async resume of the device's
>>>>> children when the processing of the parent has been completed in each
>>>>> stage of device resume and only start async resume upfront for devices
>>>>> without parents.
>>>>>
>>>>> Also make it check if a given device can be resumed asynchronously
>>>>> before starting the synchronous resume of it in case it will have to
>>>>> wait for another that is already resuming asynchronously.
>>>>>
>>>>> In addition to making the async resume of devices more friendly to
>>>>> systems with relatively less computing resources, this change is also
>>>>> preliminary for analogous changes in the suspend path.
>>>>>
>>>>> On the systems where it has been tested, this change by itself does
>>>>> not affect the overall system resume duration in a measurable way.
>>>>>
>>>>> Link: https://lore.kernel.org/linux-pm/20241114220921.2529905-1-saravanak@google.com/ [1]
>>>>> Suggested-by: Saravana Kannan <saravanak@google.com>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> I'd like to let you know of a suspend crash that I'm dealing with
>>>> when using the OOT pixel6 drivers on top of v6.16-rc4.
>>>
>>> Well, thanks, but there's not much I can do about it.
>>>
>>> It is also better to start a new thread in such cases than to reply to
>>> a patch submission.
>>>
>>>> Similar to what Jon reported, everything gets back to normal if
>>>> I disable pm_async or if I revert the following patches:
>>>> 443046d1ad66 PM: sleep: Make suspend of devices more asynchronous
>>>> aa7a9275ab81 PM: sleep: Suspend async parents after suspending children
>>>> 0cbef962ce1f PM: sleep: Resume children after resuming the parent
>>>>
>>>> I also reverted their fixes when testing:
>>>> 8887abccf8aa PM: sleep: Add locking to dpm_async_resume_children()
>>>> d46c4c839c20 PM: sleep: Fix power.is_suspended cleanup for direct-complete devices
>>>> 079e8889ad13 PM: sleep: Fix list splicing in device suspend error paths
>>>>
>>>> It seems that the hang happens in dpm_suspend() at
>>>> async_synchronize_full() time after a driver fails to suspend.
>>>> The phone then naturally resets with an APC watchdog.
>>>>
>>>> [  519.142279][ T7917] lwis lwis-eeprom-m24c64x: Can't suspend because eeprom-m24c64x is in use!
>>>> [  519.143556][ T7917] lwis-i2c eeprom@2: PM: dpm_run_callback(): platform_pm_suspend returns -16
>>>> [  519.143872][ T7917] lwis-i2c eeprom@2: PM: platform_pm_suspend returned -16 after 1596 usecs
>>>> [  519.144197][ T7917] lwis-i2c eeprom@2: PM: failed to suspend: error -16
>>>> [  519.144448][ T7917] PM: tudor: dpm_suspend: after while loop, list_empty(&dpm_prepared_list)? 1
>>>> [  519.144779][ T7917] PM: tudor: dpm_suspend: before async_synchronize_full
>>>>
>>>> The extra prints are because of:
>>>> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
>>>> index d9d4fc58bc5a..3efe538c2ec2 100644
>>>> --- a/drivers/base/power/main.c
>>>> +++ b/drivers/base/power/main.c
>>>> @@ -1967,10 +1967,15 @@ int dpm_suspend(pm_message_t state)
>>>>                         break;
>>>>                 }
>>>>         }
>>>> +       pr_err("tudor: %s: after while loop, list_empty(&dpm_prepared_list)? %d\n",
>>>> +              __func__, list_empty(&dpm_prepared_list));
>>>>
>>>>         mutex_unlock(&dpm_list_mtx);
>>>>
>>>> +       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
>>>>         async_synchronize_full();
>>>> +       pr_err("tudor: %s: after async_synchronize_full();\n", __func__);
>>>> +
>>>>         if (!error)
>>>>                 error = async_error;
>>>>
>>>> The synchronous suspend works because its strict, one-by-one ordering
>>>> ensures that device dependencies are met and that no device is suspended
>>>> while another is still using it. The asynchronous suspend fails because
>>>> it creates a race condition where the lwis-eeprom-m24c64x is called for
>>>> suspension before the process using it has been suspended, leading to a
>>>> fatal "device busy" error. Should the failure of a device suspend be
>>>> fatal?
>>>
>>> It shouldn't in principle, but it depends on what exactly is involved and how.
>>>
>>> It looks like something is blocking on power.completion somewhere.
>>> I'll check the code, maybe a complete() is missing in an error path or
>>> similar.
>>
>> It doesn't look like anything is missing in the core, so the suspend
>> failure seems to be triggering a deadlock of some sort.
> 
> Well, I'm taking this back.
> 
> The following scenario definitely can happen:
> 
> 1. Device A is async and it depends on device B that is sync.
> 2. Async suspend is scheduled for A before the processing of B is started.
> 3. A is waiting for B.
> 4. In the meantime, an unrelated device fails to suspend and returns an error.
> 5. The processing of B doesn't start at all and its power.completion is not
>    updated.
> 6. A is still waiting for B when async_synchronize_full() is called.
> 7. Deadlock ensues.
> 
> If this is what happens in your case, the (untested) patch below should help
> (unless I messed it up, that is).

Thanks, Rafael.

I added few prints (see updated patch below) to figure out whether
complete_all(&dev->power.completion) is called in my case, and it seems
it's not, I still get the APC watchdog:

[  724.361425][ T8468] lwis-i2c eeprom@2: PM: calling platform_pm_suspend @ 8468, parent: platform
[  724.361751][ T8468] lwis lwis-eeprom-m24c64x: Can't suspend because eeprom-m24c64x is in use!
[  724.362098][ T8468] lwis-i2c eeprom@2: PM: dpm_run_callback(): platform_pm_suspend returns -16
[  724.362427][ T8468] lwis-i2c eeprom@2: PM: platform_pm_suspend returned -16 after 679 usecs
[  724.362750][ T8468] lwis-i2c eeprom@2: PM: failed to suspend: error -16
[  724.362999][ T8468] PM: tudor: dpm_async_suspend_complete_all: enter
[  724.363242][ T8468] PM: tudor: dpm_suspend: before async_synchronize_full



diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index d9d4fc58bc5a..0e186bc38a00 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -1281,6 +1281,27 @@ static void dpm_async_suspend_parent(struct device *dev, async_func_t func)
                dpm_async_with_cleanup(dev->parent, func);
 }
 
+static void dpm_async_suspend_complete_all(struct list_head *device_list)
+{
+       struct device *dev;
+
+
+       pr_err("tudor: %s: enter\n", __func__);
+       guard(mutex)(&async_wip_mtx);
+
+       list_for_each_entry_reverse(dev, device_list, power.entry) {
+               /*
+                * In case the device is being waited for and async processing
+                * has not started for it yet, let the waiters make progress.
+                */
+               pr_err("tudor: %s: in device list\n", __func__);
+               if (!dev->power.work_in_progress) {
+                       pr_err("tudor: %s: call complete_all\n", __func__);
+                       complete_all(&dev->power.completion);
+               }
+       }
+}
+
 /**
  * resume_event - Return a "resume" message for given "suspend" sleep state.
  * @sleep_state: PM message representing a sleep state.
@@ -1459,6 +1480,7 @@ static int dpm_noirq_suspend_devices(pm_message_t state)
                mutex_lock(&dpm_list_mtx);
 
                if (error || async_error) {
+                       dpm_async_suspend_complete_all(&dpm_late_early_list);
                        /*
                         * Move all devices to the target list to resume them
                         * properly.
@@ -1663,6 +1685,7 @@ int dpm_suspend_late(pm_message_t state)
                mutex_lock(&dpm_list_mtx);
 
                if (error || async_error) {
+                       dpm_async_suspend_complete_all(&dpm_late_early_list);
                        /*
                         * Move all devices to the target list to resume them
                         * properly.
@@ -1959,6 +1982,7 @@ int dpm_suspend(pm_message_t state)
                mutex_lock(&dpm_list_mtx);
 
                if (error || async_error) {
+                       dpm_async_suspend_complete_all(&dpm_late_early_list);
                        /*
                         * Move all devices to the target list to resume them
                         * properly.
@@ -1970,9 +1994,12 @@ int dpm_suspend(pm_message_t state)
 
        mutex_unlock(&dpm_list_mtx);
 
+       pr_err("tudor: %s: before async_synchronize_full\n", __func__);
        async_synchronize_full();
        if (!error)
                error = async_error;
+       pr_err("tudor: %s: after async_synchronize_full();\n", __func__);
+
 
        if (error)
                dpm_save_failed_step(SUSPEND_SUSPEND);

