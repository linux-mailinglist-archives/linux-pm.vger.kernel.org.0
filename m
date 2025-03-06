Return-Path: <linux-pm+bounces-23543-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07635A5460B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 10:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EA0E188EB67
	for <lists+linux-pm@lfdr.de>; Thu,  6 Mar 2025 09:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D13920969D;
	Thu,  6 Mar 2025 09:15:43 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C4B191F75;
	Thu,  6 Mar 2025 09:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252543; cv=none; b=rvEaJqSrIWCJozcPDvsMGGF/Gvkl73DW20nRpr8TMXXYoJeuW1FicbfTMrUtsg8vcOhOejvnLeCAxX3tw8gZNvazneWHN5zJ632UxI++MwPz+oFEmrpXxqGDUO4sEG8XpfrV5BxyKru1b5UgxblvCaZBb/nxd/3tcJs4JVxhY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252543; c=relaxed/simple;
	bh=umf0BAmCvOgtIj//vMPILux+M2bbR3DlP37WKh+JrHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I880d44RNDuQKWCnzqCJrxpzC588LkXC65fbWTBWyXt8nPOeA/nhCaK0WV+BfMQRN7oQRyn1DkHUM5x8vFdEbqiTAO/pAtWmnrzJcpHgqwuFTXTTdy3ZRCRVyRoN3FCijsQeoVoNdctOFZxm5sn5YdnwnFOQgySIbCpQC7kkY5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEB8FFEC;
	Thu,  6 Mar 2025 01:15:46 -0800 (PST)
Received: from [10.57.83.26] (unknown [10.57.83.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC0FF3F673;
	Thu,  6 Mar 2025 01:15:31 -0800 (PST)
Message-ID: <dfc0b0e1-51fa-47a2-8a8b-87bed173254c@arm.com>
Date: Thu, 6 Mar 2025 09:15:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] drivers/thermal/exymos: Use guard notation when
 acquiring mutex
To: Anand Moon <linux.amoon@gmail.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-samsung-soc@vger.kernel.org>,
 "open list:SAMSUNG THERMAL DRIVER" <linux-pm@vger.kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES"
 <linux-arm-kernel@lists.infradead.org>, Zhang Rui <rui.zhang@intel.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>
References: <20250216195850.5352-1-linux.amoon@gmail.com>
 <20250216195850.5352-5-linux.amoon@gmail.com>
 <f44efd1a-1f6e-456d-9395-de2a55ef2279@arm.com>
 <CANAwSgTpV_kGFEU-ND0N+OEtT6+j4ceq37xAoLyC7iHPWAuLjg@mail.gmail.com>
 <CANAwSgSWf_YxSi-pzWPaRoiJx7RLrWUz+HTWx5hf+E2x1ZGmoQ@mail.gmail.com>
 <7a1cac10-b065-4b4c-b048-10d6b4132f3d@arm.com>
 <CANAwSgQErDnKfaBOkpEwpJsoyUMhNTC2TJNW-eQYHgHu46poCA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CANAwSgQErDnKfaBOkpEwpJsoyUMhNTC2TJNW-eQYHgHu46poCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/5/25 15:59, Anand Moon wrote:
> Hi Lukasz,
> 
> On Wed, 5 Mar 2025 at 14:12, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 3/4/25 12:20, Anand Moon wrote:
>>> Hi Lukasz,
>>>
>>> On Sat, 1 Mar 2025 at 00:06, Anand Moon <linux.amoon@gmail.com> wrote:
>>>>
>>>> Hi Lukasz,
>>>>
>>>> On Fri, 28 Feb 2025 at 22:58, Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 2/16/25 19:58, Anand Moon wrote:
>>>>>> Using guard notation makes the code more compact and error handling
>>>>>> more robust by ensuring that mutexes are released in all code paths
>>>>>> when control leaves critical section.
>>>>>>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>> ---
>>>>>> v3: new patch
>>>>>> ---
>>>>>>     drivers/thermal/samsung/exynos_tmu.c | 21 +++++++--------------
>>>>>>     1 file changed, 7 insertions(+), 14 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
>>>>>> index fe090c1a93ab..a34ba3858d64 100644
>>>>>> --- a/drivers/thermal/samsung/exynos_tmu.c
>>>>>> +++ b/drivers/thermal/samsung/exynos_tmu.c
>>>>>> @@ -256,7 +256,7 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>>>>>         unsigned int status;
>>>>>>         int ret = 0;
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>         clk_enable(data->clk_sec);
>>>>>>
>>>>>> @@ -270,7 +270,6 @@ static int exynos_tmu_initialize(struct platform_device *pdev)
>>>>>>
>>>>>>         clk_disable(data->clk_sec);
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>
>>>>>>         return ret;
>>>>>>     }
>>>>>> @@ -292,13 +291,12 @@ static int exynos_thermal_zone_configure(struct platform_device *pdev)
>>>>>>                 return ret;
>>>>>>         }
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>
>>>>>>         data->tmu_set_crit_temp(data, temp / MCELSIUS);
>>>>>>
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>
>>>>>>         return 0;
>>>>>>     }
>>>>>> @@ -325,12 +323,11 @@ static void exynos_tmu_control(struct platform_device *pdev, bool on)
>>>>>>     {
>>>>>>         struct exynos_tmu_data *data = platform_get_drvdata(pdev);
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>         data->tmu_control(pdev, on);
>>>>>>         data->enabled = on;
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>     }
>>>>>>
>>>>>>     static void exynos_tmu_update_bit(struct exynos_tmu_data *data, int reg_off,
>>>>>> @@ -645,7 +642,7 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
>>>>>>                  */
>>>>>>                 return -EAGAIN;
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>
>>>>>>         value = data->tmu_read(data);
>>>>>> @@ -655,7 +652,6 @@ static int exynos_get_temp(struct thermal_zone_device *tz, int *temp)
>>>>>>                 *temp = code_to_temp(data, value) * MCELSIUS;
>>>>>>
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>
>>>>>>         return ret;
>>>>>>     }
>>>>>> @@ -720,11 +716,10 @@ static int exynos_tmu_set_emulation(struct thermal_zone_device *tz, int temp)
>>>>>>         if (temp && temp < MCELSIUS)
>>>>>>                 goto out;
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>         data->tmu_set_emulation(data, temp);
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>         return 0;
>>>>>>     out:
>>>>>>         return ret;
>>>>>> @@ -760,14 +755,13 @@ static irqreturn_t exynos_tmu_threaded_irq(int irq, void *id)
>>>>>>
>>>>>>         thermal_zone_device_update(data->tzd, THERMAL_EVENT_UNSPECIFIED);
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>
>>>>>>         /* TODO: take action based on particular interrupt */
>>>>>>         data->tmu_clear_irqs(data);
>>>>>>
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>
>>>>>>         return IRQ_HANDLED;
>>>>>>     }
>>>>>> @@ -987,7 +981,7 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
>>>>>>     {
>>>>>>         struct exynos_tmu_data *data = thermal_zone_device_priv(tz);
>>>>>>
>>>>>> -     mutex_lock(&data->lock);
>>>>>> +     guard(mutex)(&data->lock);
>>>>>>         clk_enable(data->clk);
>>>>>>
>>>>>>         if (low > INT_MIN)
>>>>>> @@ -1000,7 +994,6 @@ static int exynos_set_trips(struct thermal_zone_device *tz, int low, int high)
>>>>>>                 data->tmu_disable_high(data);
>>>>>>
>>>>>>         clk_disable(data->clk);
>>>>>> -     mutex_unlock(&data->lock);
>>>>>>
>>>>>>         return 0;
>>>>>>     }
>>>>
>>>> Thanks for your review comments.
>>>>>
>>>>> IMO you should be able to even use something like we have
>>>>> core framework:
>>>>>
>>>>> guard(thermal_zone)(tz);
>>>>>
>>>>> Your mutex name is simply 'lock' in the struct exynos_tmu_data
>>>>> so you should be able to leverage this by:
>>>>>
>>>>> guard(exynos_tmu_data)(data);
>>>>>
>>>
>>> If I introduce the guard it creates a compilation error
>>>
>>> amoon@anand-m920q:~/mainline/linux-exynos-6.y-devel$ vi
>>> drivers/thermal/samsung/exynos_tmu.c +306
>>> amoon@anand-m920q:~/mainline/linux-exynos-6.y-devel$ make -j$(nproc)
>>> ARCH=arm CROSS_COMPILE=arm-none-eabi- LOCALVERSION=-u3ml dtbs zImage
>>> modules
>>>     CALL    scripts/checksyscalls.sh
>>>     CHK     kernel/kheaders_data.tar.xz
>>>     CC      drivers/thermal/samsung/exynos_tmu.o
>>>     CC [M]  drivers/md/raid10.o
>>> In file included from ./include/linux/irqflags.h:17,
>>>                    from ./arch/arm/include/asm/bitops.h:28,
>>>                    from ./include/linux/bitops.h:68,
>>>                    from ./include/linux/kernel.h:23,
>>>                    from ./include/linux/clk.h:13,
>>>                    from drivers/thermal/samsung/exynos_tmu.c:14:
>>> drivers/thermal/samsung/exynos_tmu.c: In function 'exynos_tmu_update_bit':
>>> ./include/linux/cleanup.h:258:9: error: unknown type name
>>> 'class_exynos_tmu_data_t'
>>>     258 |         class_##_name##_t var
>>> __cleanup(class_##_name##_destructor) =   \
>>>         |         ^~~~~~
>>> ./include/linux/cleanup.h:309:9: note: in expansion of macro 'CLASS'
>>>     309 |         CLASS(_name, __UNIQUE_ID(guard))
>>>         |         ^~~~~
>>> drivers/thermal/samsung/exynos_tmu.c:338:9: note: in expansion of macro 'guard'
>>>     338 |         guard(exynos_tmu_data)(data);
>>>         |         ^~~~~
>>> drivers/thermal/samsung/exynos_tmu.c:338:9: error: cleanup argument
>>> not a function
>>
>> [snip]
>>
>> Right, you're missing the definition at the begging, like:
>>
>> DEFINE_GUARD(exynos_tmu_data, struct exynos_tmu_data *,
>> mutex_lock(&_T->lock),
>>                mutex_unlock(&_T->lock))
>>
>> below the struct exynos_tmu_data definition.
>>
>> Also, make sure you include the cleanup.h (it might not complain,
>> but it would be explicit and more clear)
> 
> Thanks for this tip.
> However, incorporating guard(exynos_tmu_data)(data); results
> in a recursive deadlock with the mutex during initialization, as this
> data structure is common to all the code configurations of Exynos TMU
> 

Fair enough, it would be just a cosmetic change, so do fight with it
too much.

Please continue in v4 with your former approach with the 'guard'.

