Return-Path: <linux-pm+bounces-15152-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 007129904D8
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 15:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A71861F21523
	for <lists+linux-pm@lfdr.de>; Fri,  4 Oct 2024 13:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6212212EEB;
	Fri,  4 Oct 2024 13:52:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC8C156678;
	Fri,  4 Oct 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728049928; cv=none; b=O8X+2q3WLyjw/IBg9MVD3sjALotwA9TEvOTq4W3Qm08Os+W/C7NVDE3HR/ZZ25dKPgdnDkolyMXVOrpvLlaEDs4PTNJ7e57CvJky+t1QyUR+PFicUw7rflZyk7iOSWpmtInPXGCbjWnu+Yt9tYxL6Uo5qKtGF9ETM31GQUQeci0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728049928; c=relaxed/simple;
	bh=z9rJf3VSM5rW82ltr4/yb3bcP3enExc8iYKWhR+CLec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YLWNSgBemk3Uli9IFjzmzi4LWn9VGfOpplzEiKjidYcE56nPR92bo3SS0nSAlD4wZ/H8juAS/+w5792cJAvdnyg0zQJ9E7BetDR+t/CyD7FRJOZXTrA7I1m5oJkLjfZgLOycIWMvvb4bw8e5aSfLCMf38e5mzblRHq2R/P16SaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2F2FA339;
	Fri,  4 Oct 2024 06:52:35 -0700 (PDT)
Received: from [10.57.77.142] (unknown [10.57.77.142])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 394B73F58B;
	Fri,  4 Oct 2024 06:52:04 -0700 (PDT)
Message-ID: <a42ebcff-10f8-4888-a3d8-fd2705da41b3@arm.com>
Date: Fri, 4 Oct 2024 14:53:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] thermal: core: Reference count the zone in
 thermal_zone_get_by_id()
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
References: <12549318.O9o76ZdvQC@rjwysocki.net>
 <6112242.lOV4Wx5bFT@rjwysocki.net>
 <b2d949a2-2586-44ec-b0e7-0879fd3ac7cf@arm.com>
 <CAJZ5v0g494bUwLbFDF_WHwLSMbu1iTxiynNwDqKktv3-4049Sw@mail.gmail.com>
 <5222419a-2664-4bb5-b1d4-77a46677bb4d@arm.com>
 <CAJZ5v0jkbQG4A+saKDfCz6g2-A=rZ2y34k2v9jA9uhp9A17ZBw@mail.gmail.com>
 <CAJZ5v0iSb=RGiuXrBPq6V0ZObhPedznuv7CGgAyO1MMshCQrMg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iSb=RGiuXrBPq6V0ZObhPedznuv7CGgAyO1MMshCQrMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/4/24 14:48, Rafael J. Wysocki wrote:
> On Fri, Oct 4, 2024 at 3:43 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Oct 4, 2024 at 3:37 PM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>
>>>
>>>
>>> On 10/4/24 14:25, Rafael J. Wysocki wrote:
>>>> Hi Łukasz,
>>>>
>>>> On Fri, Oct 4, 2024 at 10:01 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>>>>
>>>>> Hi Rafael,
>>>>>
>>>>> On 10/3/24 13:25, Rafael J. Wysocki wrote:
>>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>>

[snip]

>>>>>>
>>>>>
>>>>> I wasn't aware of that helpers in cleanup.h.
>>>>>
>>>>> Could you help me to understand when this this
>>>>> 'if (_T) put_device((&_T->device)' will be called?
>>>>
>>>> When the pointer variable initialized via the CLASS() macro goes out
>>>> of scope (that is, before freeing the memory occupied by the pointer
>>>> itself).
>>>
>>>
>>> OK, so do we still need the old code in
>>> thermal_zone_device_unregister(), which calls
>>> put_device(&tz->device) ?
>>
>> Yes, we do.
>>
>>> Maybe that code can go away?
>>
>> That particular one drops the reference acquired by device_register()
>> and I don't see an alternative clean way to drop it.
> 
> The problem there is that local variable tz goes out of scope at the
> end of the function (at least formally) and put_device(&tz->device)
> needs to be called before the wait_for_completion(&tz->removal) which
> definitely needs tz to be still around.

OK, I see now. That makes sense. With that feel free to add:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

