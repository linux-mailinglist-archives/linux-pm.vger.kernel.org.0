Return-Path: <linux-pm+bounces-38689-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99789C88FB0
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 10:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 665743B7AC5
	for <lists+linux-pm@lfdr.de>; Wed, 26 Nov 2025 09:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD2A2E54BD;
	Wed, 26 Nov 2025 09:34:34 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C9B2E0417;
	Wed, 26 Nov 2025 09:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764149673; cv=none; b=JSLOZzzW8xk0z5K1nkzL853OFw1mieJDbj3e6YGLo0YpJEfxpJHOhMNEBXOC3FSasUPcfCrpBGgeRzJ41TQWDy2C04yXDmVKGxiEDpU9S6TD29x0o/C/f+v/rngpSbF/Kg2RtzgSDb360OmIv6yzWKthzDf+fICAuFQEdBrjGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764149673; c=relaxed/simple;
	bh=/1VQv9PSEYx+8v+/u6kGKftMTmVtNx/6cSGQ+Aon0mY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NG7+/HQE5QzfQrUqtiQLUn2nC9XZ9gybXF2KdFQraKSKcNQyll2JA+Z5VY6X4K6zPznVkcisgSRFqw4epW5Uv8kRfNYI8WY7cZ7eW/SKdHuqldbl+W7m2mxAqakhi3Dt6fmA7pGMfWlzNd7uvt3W1a4HAiFBZt7M6IvulQOf76Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8922C168F;
	Wed, 26 Nov 2025 01:34:23 -0800 (PST)
Received: from [10.57.40.225] (unknown [10.57.40.225])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B36123F6A8;
	Wed, 26 Nov 2025 01:34:28 -0800 (PST)
Message-ID: <7980c3b8-46fa-4c78-b000-60d678854620@arm.com>
Date: Wed, 26 Nov 2025 09:35:17 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: stable 6.6: commit "sched/cpufreq: Rework schedutil governor
 performance estimation' causes a regression
To: Yu-Che Cheng <giver@chromium.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Christian Loehle <christian.loehle@arm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Tomasz Figa <tfiga@chromium.org>, stable@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
References: <q2dp7jlblofwkmkufjdysgu2ggv6g4cvhkah3trr5wamxymngm@p2mn4r7vyo77>
 <86d759a5-9a96-49ff-9f75-8b56e2626d65@arm.com>
 <2ktr5znjidilpxm2ycixunqlmhu253xwov4tpnb2qablrsqmbv@ysacm5nbcjw7>
 <2be3bf24-a707-48df-b224-22b5ab290006@arm.com>
 <CAKchOA31NGBWMdeSjky7MwOjU=dYmHVLbE7uUQHUXSZOzUHUeA@mail.gmail.com>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <CAKchOA31NGBWMdeSjky7MwOjU=dYmHVLbE7uUQHUXSZOzUHUeA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Yu-Che,

On 11/25/25 13:01, Yu-Che Cheng wrote:
> Hi Lukasz,
> 

[snip]

>>
>> There are some differences, though:
>> 1. there are more deeps in the freq in time, so more often you would
>>      pay extra penalty for the ramp-up again
>> 2. some of the ramp-up phases are a bit longer ~100ms instead of ~80ms
>>      going from 2GHz to 3.6GHz
> 
> Agree. From the visualized frequency changes in the Perfetto traces,
> it's more obvious that the ramp-up from 2GHz to 3.6GHz becomes much
> slower and a bit unstable in v6.6.99, and it's also easier to go down
> to a low frequency after a short idle.
> 

[snip]

>>
>> I wonder if you had a fix patch for the util_est in your kernel...
>> That fix has been recently backported to 6.6 stable [1].
>>
>> You might want to try that patch as well, w/ or w/o this revert.
>> IMHO it might be worth to have it on top. It might help
>> the main Chrome task ('CrRendererMain') to stay longer on the biggest
>> cpu, since the util_est would be higher. You can read the discussion
>> that I had back then with PeterZ and VincentG [2].
> 
> No, the util_est fix isn't in our kernel yet.
> It looks like after cherry-picking the fix, without the revert, the
> Speedometer 2.0 score becomes even slightly higher than that on
> v6.6.88 (450 ~ 460 vs 435 ~ 440).
> On the other hand, with both the fix and the revert, the Speedometer
> score becomes about 475 ~ 480, which is almost the same as using the
> performance governor (i.e. pinning at the maximum frequency).

Sounds really good to get such score.

> It looks like more tasks that originally run on the little cores are
> migrated to the middle and big cores more often, which also makes CPU7
> more likely to stay at a higher frequency during some short idle in
> the main thread.

Yes, that's the desired behavior.

> 
> Also attach the Perfetto trace for both of them:
> 
> fix without revert:
> https://ui.perfetto.dev/#!/?s=ff4d10bd58982555eada61648786adf6f7187ac3
> fix with revert:
> https://ui.perfetto.dev/#!/?s=05da3cedfb3851ad694f523ef59d3cd1092d74ae

Thanks for the traces, there are idle periods there as well - cool.

I will link your email with the results for the history in that stable
patch backport.

Thanks for sharing those tests' scores. Community works :)

Regards,
Lukasz

