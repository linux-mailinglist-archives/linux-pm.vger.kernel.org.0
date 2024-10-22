Return-Path: <linux-pm+bounces-16208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 051BE9A9FCA
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 12:19:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B0C282612
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 10:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F0018E02D;
	Tue, 22 Oct 2024 10:18:56 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF5212D1EA
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 10:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729592336; cv=none; b=k9jGzS7Xe8H5VXf+Cdr5Zqx28PWEkqj7uOrjjt3+Ql6mlvJx80oUdVI6eOcrKnQh6Gm/bj418Kz7rlGI4iKEECl1/3Dc0qmsXRl94hjfEUy0r7bxure1S5toWI5CgBDhqJ6Qx9JNGrwIbmDqm13E8p6qV3vPcq/V3XJcNq8XEf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729592336; c=relaxed/simple;
	bh=IjLaoXsQbGYYw2pv+kxbuZjmdh5oufmye7ZnH/7iXx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K58grmNbYVM5NUULGNXdJvNRmOpnjLFgMW+nlBoqAzYMNXseDgdp6mYPbqgNZWwlTx58oxYFa5C++92jOsGMEd3taB/rW5MPVkgz4p4jPO1hDcyqIvQZvnRVQYBe9YtF6ZMfz8/18/DWrU24PSh1/miKYGaDWCehp+xzrA9OmX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 613E9497;
	Tue, 22 Oct 2024 03:19:23 -0700 (PDT)
Received: from [10.57.65.67] (unknown [10.57.65.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAFF43F71E;
	Tue, 22 Oct 2024 03:18:52 -0700 (PDT)
Message-ID: <8bda9e15-cba9-48ce-a46d-71d8ac921d0c@arm.com>
Date: Tue, 22 Oct 2024 11:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org,
 quic_manafm@quicinc.com
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org>
 <46d25358-bf23-44ec-8350-711252560b89@arm.com>
 <c5df4aae-70af-451e-a1be-57089f5fd848@linaro.org>
 <962dfad6-e2f0-44e3-b567-e0b72e2a2a11@arm.com>
 <CAJZ5v0iaYys8H_AcM_5SHHy0LxzZkok4sx=jji1wOGjZ+30rzg@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAJZ5v0iaYys8H_AcM_5SHHy0LxzZkok4sx=jji1wOGjZ+30rzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/22/24 11:01, Rafael J. Wysocki wrote:
> Hi Lukasz,
> 
> On Tue, Oct 22, 2024 at 11:39 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>>
>> Hi Daniel,
>>
>> On 10/22/24 08:09, Daniel Lezcano wrote:
>>> On 22/10/2024 00:02, Lukasz Luba wrote:
>>>>
>>>>
>>>> On 10/14/24 10:43, Daniel Lezcano wrote:
>>>>> The thresholds exist but there is no notification neither action code
>>>>> related to them yet.
>>>>>
>>>>> These changes implement the netlink for the notifications when the
>>>>> thresholds are crossed, added, deleted or flushed as well as the
>>>>> commands which allows to get the list of the thresholds, flush them,
>>>>> add and delete.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> ---
>>>
>>> [ ... ]
>>>
>>>>> +static inline int thermal_notify_threshold_up(const struct
>>>>> thermal_zone_device *tz)
>>>>> +{
>>>>> +    return 0;
>>>>> +}
>>>>
>>>> These 'return 0' look a bit odd. We usually use 'return -EINVAL' in
>>>> not defined. Although, since we don't check the output of those
>>>> functions  - we are OK. We just have to remember about these zeros,
>>>> one day when we would like to add the check of the return.
>>>
>>> The return error really depends on the context of the call site. There
>>> are other subsystems returning 0 when the service is not enabled (eg.
>>> cpufreq.h, devfreq.h, device_cgroup.h, etc ...)
>>>
>>>
>>
>> Fair enough. As I said, we would just keep them in mind if we one
>> day decide to add the checks of the returns.
>>
>> I'm waiting for your next version with the new locking scheme that
>> Rafael asked and I will add my review tags.
> 
> My plan was to take this patch and replace the open-coded locking with
> guards when applying it (that would be a mechanical change AFAICS).
> 
> I guess it's OK to add a R-by from you in that case?

Yes, please add. I know what you are going to add there, so:

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

