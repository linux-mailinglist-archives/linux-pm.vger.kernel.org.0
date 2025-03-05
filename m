Return-Path: <linux-pm+bounces-23474-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF0DA4FA9C
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 10:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2C03A7A83
	for <lists+linux-pm@lfdr.de>; Wed,  5 Mar 2025 09:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6162E204F7C;
	Wed,  5 Mar 2025 09:51:00 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E962AF19;
	Wed,  5 Mar 2025 09:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741168260; cv=none; b=o6L1QqZDDmT20hxTbpHDdwNkfSb2ZA1FmSNQ6ctjl/pEa6FwqsP9n8dxd+Kdtw4wVsYJMSTaMtrRSRoPTS0IPv+sSqUkIbQrcc7yA8RUAsWaVUWiA5mcBHkmoP5Rfy4FUFK7Ji2ky9CmMCU6xT9rtH8/7D4oZG/gJcr6NQQt4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741168260; c=relaxed/simple;
	bh=im8uaNIgauqwSKJ+QLQ9McFB8wSVj2MzOCQuUY4Y3gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cHeqtbzrxruI5exmr5hZiF6/Eb0MnBBlmEm/DVDqzBZiPu8YpMT1w53OTfHkJfpzy1cevhGwC9gR+uTl8dkwBMq3QYtyF5Fwg8XgFyBM9YzhQmUZ+LWewfBkkrx1Ge4SUjzJkIEmqFThvti3Jhq2M5JMTYE/VGP2guJxoW/15xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 332A5FEC;
	Wed,  5 Mar 2025 01:51:11 -0800 (PST)
Received: from [10.57.64.200] (unknown [10.57.64.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E87E63F673;
	Wed,  5 Mar 2025 01:50:55 -0800 (PST)
Message-ID: <7bc89310-c0db-4940-8cd7-86566ecb5c65@arm.com>
Date: Wed, 5 Mar 2025 09:50:53 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: energy_model: Rework the depends on for
 CONFIG_ENERGY_MODEL
To: rafael@kernel.org
Cc: Xuewen Yan <xuewen.yan94@gmail.com>, Xuewen Yan <xuewen.yan@unisoc.com>,
 linux-pm@vger.kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, jeson.gao@unisoc.com, di.shen@unisoc.com, pavel@ucw.cz
References: <20241219091109.10050-1-xuewen.yan@unisoc.com>
 <a43ebb14-be7f-4f8a-8892-cdb63eec4043@arm.com>
 <CAB8ipk-qYR4LncOi2ue6Rbdc6CqX67_OydcOp14Yj=afYZPe=Q@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAB8ipk-qYR4LncOi2ue6Rbdc6CqX67_OydcOp14Yj=afYZPe=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafael,

On 2/13/25 02:18, Xuewen Yan wrote:
> Hi Rafael,
> 
> I noticed that this patch has not been merged yet. Do you have any comments?
> 
> BR
> 
> On Thu, Dec 19, 2024 at 5:17 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>>
>>
>> On 12/19/24 09:11, Xuewen Yan wrote:
>>> From: Jeson Gao <jeson.gao@unisoc.com>
>>>
>>> Now not only CPUs can use energy efficiency models, but GPUs
>>> can also use. On the other hand, even with only one CPU, we can also
>>> use energy_model to align control in thermal.
>>> So remove the dependence of SMP, and add the DEVFREQ.
>>
>> That's true, there are 1-CPU platforms supported. Also, GPU can have
>> the EM alone.
>>
>>>
>>> Signed-off-by: Jeson Gao <jeson.gao@unisoc.com>
>>> ---
>>>    kernel/power/Kconfig | 3 +--
>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
>>> index afce8130d8b9..c532aee09e12 100644
>>> --- a/kernel/power/Kconfig
>>> +++ b/kernel/power/Kconfig
>>> @@ -361,8 +361,7 @@ config CPU_PM
>>>
>>>    config ENERGY_MODEL
>>>        bool "Energy Model for devices with DVFS (CPUs, GPUs, etc)"
>>> -     depends on SMP
>>> -     depends on CPU_FREQ
>>> +     depends on CPU_FREQ || PM_DEVFREQ
>>>        help
>>>          Several subsystems (thermal and/or the task scheduler for example)
>>>          can leverage information about the energy consumed by devices to
>>
>> Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Gentle ping. You probably have missed that change for the v6.15 queue

Regards,
Lukasz

