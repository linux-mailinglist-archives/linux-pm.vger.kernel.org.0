Return-Path: <linux-pm+bounces-23491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B83A50343
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 16:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1489E164054
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 15:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8356124FC03;
	Wed,  5 Mar 2025 15:14:42 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B87924FBE8;
	Wed,  5 Mar 2025 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741187682; cv=none; b=j9YrqM79POuZD21ppyUpcnrsndp599Ini6ePX4mTr4BGBf67kl1ZPwIV03dM6/3sAWvpYVkKSCJgEbAcwdjm4cEZ28GJ+T9Tw+hPzCL4TZidsYHxwJlZI7PfoeaTkp1AkcL1zTFjNYA+fk+L3hQ0gCzOnCMXXzNTBz2uJJM9xIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741187682; c=relaxed/simple;
	bh=elgOmlowbnIPeZCBlF4QGmmo5m2Shp/74rd5tbSJygI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U5hH2R+M5zsDkLn4JSoHVOdrDi5BeyEjucWDnqIN/456yuTIAad8QLvsdLn/XjjK7et4igBr7cX3NQspqZBHLfHFMlBHfVS0Ncc3unlvQshzBTwQpuGmPtVI0drqAatFo5FajNEL8yHTFMU7ieH2cUvIP2QTzp6UUQ+xWM9ZOtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52441FEC;
	Wed,  5 Mar 2025 07:14:47 -0800 (PST)
Received: from [10.57.64.200] (unknown [10.57.64.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2CA603F673;
	Wed,  5 Mar 2025 07:14:32 -0800 (PST)
Message-ID: <4743eefe-b75d-4cca-b13a-8f4aafa34b49@arm.com>
Date: Wed, 5 Mar 2025 15:14:30 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: energy_model: Rework the depends on for
 CONFIG_ENERGY_MODEL
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
 linux-pm@vger.kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, jeson.gao@unisoc.com, di.shen@unisoc.com, pavel@ucw.cz
References: <20241219091109.10050-1-xuewen.yan@unisoc.com>
 <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
 <CAB8ipk-qYR4LncOi2ue6Rbdc6CqX67_OydcOp14Yj=afYZPe=Q@mail.gmail.com>
 <7bc89310-c0db-4940-8cd7-86566ecb5c65@arm.com>
 <CAJZ5v0j3+TFB22FKcGMdy6bfvczAcp+egWv5WjY9dWmHKh8fpA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0j3+TFB22FKcGMdy6bfvczAcp+egWv5WjY9dWmHKh8fpA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/5/25 14:57, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Mar 5, 2025 at 10:51 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Rafael,
>>
>> On 2/13/25 02:18, Xuewen Yan wrote:
>>> Hi Rafael,
>>>
>>> I noticed that this patch has not been merged yet. Do you have any comments?
>>>
>>> BR
>>>
>>> On Thu, Dec 19, 2024 at 5:17 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>
>>>>
>>>>
>>>> On 12/19/24 09:11, Xuewen Yan wrote:
>>>>> From: Jeson Gao <jeson.gao@unisoc.com>
>>>>>
>>>>> Now not only CPUs can use energy efficiency models, but GPUs
>>>>> can also use. On the other hand, even with only one CPU, we can also
>>>>> use energy_model to align control in thermal.
>>>>> So remove the dependence of SMP, and add the DEVFREQ.
>>>>
>>>> That's true, there are 1-CPU platforms supported. Also, GPU can have
>>>> the EM alone.
>>>>
>>>>>
>>>>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
>>>>> ---
>>>>>     kernel/power/Kconfig | 3 +--
>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>>>>> index afce8130d8b9..c532aee09e12 100644
>>>>> --- a/kernel/power/Kconfig
>>>>> +++ b/kernel/power/Kconfig
>>>>> @@ -361,8 +361,7 @@ config CPU_PM
>>>>>
>>>>>     config ENERGY_MODEL
>>>>>         bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
>>>>> -     depends on SMP
>>>>> -     depends on CPU_FREQ
>>>>> +     depends on CPU_FREQ || PM_DEVFREQ
>>>>>         help
>>>>>           Several subsystems (thermal and/or the task scheduler for example)
>>>>>           can leverage information about the energy consumed by devices to
>>>>
>>>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>
>>
>> Gentle ping. You probably have missed that change for the v6.15 queue
> 
> Indeed, I have missed this one.
> 
> Now applied as 6.15 material, thanks!

Thanks Rafael!

