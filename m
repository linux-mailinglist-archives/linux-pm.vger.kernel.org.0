Return-Path: <linux-pm+bounces-1832-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 828988246BA
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 17:54:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 210101F214BD
	for <lists+linux-pm@lfdr.de>; Thu,  4 Jan 2024 16:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C929249E8;
	Thu,  4 Jan 2024 16:54:08 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D08D25549;
	Thu,  4 Jan 2024 16:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 64B78C15;
	Thu,  4 Jan 2024 08:54:52 -0800 (PST)
Received: from [10.57.88.128] (unknown [10.57.88.128])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BC3B3F64C;
	Thu,  4 Jan 2024 08:54:04 -0800 (PST)
Message-ID: <8ae21f77-994a-42d3-9851-dfda661cf018@arm.com>
Date: Thu, 4 Jan 2024 16:55:21 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 11/23] PM: EM: Add API for updating the runtime
 modifiable EM
Content-Language: en-US
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: rui.zhang@intel.com, amit.kucheria@verdurent.com,
 linux-kernel@vger.kernel.org, amit.kachhap@gmail.com,
 daniel.lezcano@linaro.org, viresh.kumar@linaro.org, len.brown@intel.com,
 pavel@ucw.cz, mhiramat@kernel.org, qyousef@layalina.io, wvw@google.com,
 linux-pm@vger.kernel.org, rafael@kernel.org
References: <20231129110853.94344-1-lukasz.luba@arm.com>
 <20231129110853.94344-12-lukasz.luba@arm.com>
 <2236f098-b889-4d70-b863-11a3f246889c@arm.com>
 <22c41b1a-333e-42b1-839f-a755d88313af@arm.com>
 <ad392cd4-b2d0-4671-bb9f-4bb62e2b12bf@arm.com>
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <ad392cd4-b2d0-4671-bb9f-4bb62e2b12bf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 1/4/24 15:45, Dietmar Eggemann wrote:
> On 20/12/2023 09:06, Lukasz Luba wrote:
>>
>>
>> On 12/12/23 18:50, Dietmar Eggemann wrote:
>>> On 29/11/2023 12:08, Lukasz Luba wrote:
> 
> [...]
> 
>>>> +int em_dev_update_perf_domain(struct device *dev,
>>>> +                  struct em_perf_table __rcu *new_table)
>>>> +{
>>>> +    struct em_perf_table __rcu *old_table;
>>>> +    struct em_perf_domain *pd;
>>>> +
>>>> +    /*
>>>> +     * The lock serializes update and unregister code paths. When the
>>>> +     * EM has been unregistered in the meantime, we should capture that
>>>> +     * when entering this critical section. It also makes sure that
>>>
>>> What do you want to capture here? You want to block in this moment,
>>> right? Don't understand the 2. sentence here.
>>>
>>> [...]
>>
>> There is general issue with module... they can reload. A driver which
>> registered EM can than later disappear. I had similar issues for the
>> devfreq cooling. It can happen at any time. In this scenario let's
>> consider scenario w/ 2 kernel drivers:
>> 1. Main driver which registered EM, e.g. GPU driver
>> 2. Thermal driver which updates that EM
>> When 1. starts unload process, it has to make sure that it will
>> not free the main EM 'pd', because the 2. might try to use e.g.
>> 'pd->nr_perf_states' while doing update at the moment.
>> Thus, this 'pd' has local mutex, to avoid issues of
>> module unload vs. EM update. The EM unregister will block on
>> that mutex and let the background update finish it's critical
>> section.
> 
> All true but wouldn't
> 
>      /* Serialize update/unregister or concurrent updates */
> 
> be sufficient as a comment here?
> 

Sounds good, I'll change that.

