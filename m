Return-Path: <linux-pm+bounces-16200-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C609A9EB7
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 11:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489CB1C24637
	for <lists+linux-pm@lfdr.de>; Tue, 22 Oct 2024 09:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBCE1991CC;
	Tue, 22 Oct 2024 09:39:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50AA912D75C
	for <linux-pm@vger.kernel.org>; Tue, 22 Oct 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589975; cv=none; b=MHH+gEk+xXNYqF9K7dmUnxvYaa6nYC3DW8DwQoJ4aTkhGRs2vFZF42wTdgj0OOM2gl7LStRn6rJzRZ5aRJbkRFDPhAwiMQzunPRGoYF0m5PqYF61+mXx/O98hfAZnGFyVxI2IoALgxxNT6+Oy7jMjKEt1aRH7RG1LyFsaC8rDMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589975; c=relaxed/simple;
	bh=IseqesWn/gvqNFAZFJfX3PrI/k0ugwcX++2sXoRQGcc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSYo9kzaZK/0Kq48tUV8X/qAJq+0+WC+M+dDxvEhRmDQluE3N53zR+RBoe5gfCqEIuyYRQzwsOI+cADTMyhYxMdr9J/kAd5K5m50e038sVzCRnrQJsQts6nz3xNi9H2vyhMW7y9e3wqV4tZPIe+tSOy43QsAZgcDX+Kc3ldaTmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F2CE497;
	Tue, 22 Oct 2024 02:40:02 -0700 (PDT)
Received: from [10.57.65.67] (unknown [10.57.65.67])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDFF73F73B;
	Tue, 22 Oct 2024 02:39:31 -0700 (PDT)
Message-ID: <962dfad6-e2f0-44e3-b567-e0b72e2a2a11@arm.com>
Date: Tue, 22 Oct 2024 10:40:42 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/4] thermal/netlink: Add the commands and the events
 for the thresholds
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, quic_manafm@quicinc.com, rafael@kernel.org
References: <20241014094309.1430126-1-daniel.lezcano@linaro.org>
 <20241014094309.1430126-2-daniel.lezcano@linaro.org>
 <46d25358-bf23-44ec-8350-711252560b89@arm.com>
 <c5df4aae-70af-451e-a1be-57089f5fd848@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <c5df4aae-70af-451e-a1be-57089f5fd848@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 10/22/24 08:09, Daniel Lezcano wrote:
> On 22/10/2024 00:02, Lukasz Luba wrote:
>>
>>
>> On 10/14/24 10:43, Daniel Lezcano wrote:
>>> The thresholds exist but there is no notification neither action code
>>> related to them yet.
>>>
>>> These changes implement the netlink for the notifications when the
>>> thresholds are crossed, added, deleted or flushed as well as the
>>> commands which allows to get the list of the thresholds, flush them,
>>> add and delete.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
> 
> [ ... ]
> 
>>> +static inline int thermal_notify_threshold_up(const struct 
>>> thermal_zone_device *tz)
>>> +{
>>> +    return 0;
>>> +}
>>
>> These 'return 0' look a bit odd. We usually use 'return -EINVAL' in
>> not defined. Although, since we don't check the output of those
>> functions  - we are OK. We just have to remember about these zeros,
>> one day when we would like to add the check of the return.
> 
> The return error really depends on the context of the call site. There 
> are other subsystems returning 0 when the service is not enabled (eg. 
> cpufreq.h, devfreq.h, device_cgroup.h, etc ...)
> 
> 

Fair enough. As I said, we would just keep them in mind if we one
day decide to add the checks of the returns.

I'm waiting for your next version with the new locking scheme that
Rafael asked and I will add my review tags.

Regards,
Lukasz

