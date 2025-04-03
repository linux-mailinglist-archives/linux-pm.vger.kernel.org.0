Return-Path: <linux-pm+bounces-24752-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF3BA7A0A5
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 12:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D05A3189336E
	for <lists+linux-pm@lfdr.de>; Thu,  3 Apr 2025 10:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDBB24886C;
	Thu,  3 Apr 2025 10:06:37 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5B63C0B;
	Thu,  3 Apr 2025 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743674797; cv=none; b=bhdeB9Q1/koGJ8UY58Om++CT75mBwmHoTLwSYPrLHiXU36UoWIpMu/PRYUe4/KxdJlUe+mZjAme9FCw8zVdEO4kTQpWgxCzohzO+71J0z1DFYuJR4PBwOXT1oBSAPdfBrd5ZHNZYwUQnZhfQeiry+NHtc4Sfbw7jaEn1r6RYCbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743674797; c=relaxed/simple;
	bh=s4UPxeK2Fb8vfGa+UmwD/5TdD8aVSC9gSgMlwtWqKL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=admmPg264wrOaYKO7oY65I3s9Mu/tG8Teunyfjf0NNI9BPaTAq/BGZy2/8AFEIVAYrhquJ+s4vmIVAz5nsN/cUrZYRtnIAazpCEVHrlSual3Cj6XLNIe4ik/awmaqZGB9nrBYxO6SvGpjNmZNCixurZfCY8KU5Dil+h6RcaHdYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 602D4106F;
	Thu,  3 Apr 2025 03:06:37 -0700 (PDT)
Received: from [10.57.40.234] (unknown [10.57.40.234])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74CFC3F59E;
	Thu,  3 Apr 2025 03:06:33 -0700 (PDT)
Message-ID: <864cf1e3-25c2-42d0-845e-1bb1cfce3802@arm.com>
Date: Thu, 3 Apr 2025 11:06:31 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: menu: Optimize bucket assignment when
 next_timer_ns equals KTIME_MAX
To: Zhongqiu Han <quic_zhonhan@quicinc.com>, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250403092852.1072015-1-quic_zhonhan@quicinc.com>
 <0d420c47-f336-41c0-83df-066131338b49@arm.com>
 <1988a6b2-4e25-42b9-8197-5599760c6755@quicinc.com>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <1988a6b2-4e25-42b9-8197-5599760c6755@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/3/25 11:01, Zhongqiu Han wrote:
> On 4/3/2025 5:34 PM, Christian Loehle wrote:
>> On 4/3/25 10:28, Zhongqiu Han wrote:
>>> Directly assign the last bucket value instead of calling which_bucket()
>>> when next_timer_ns equals KTIME_MAX, the largest possible value that
>>> always falls into the last bucket. This avoids unnecessary calculations
>>> and enhances performance.
>>>
>>> Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
>>
>> Reviewed-by: Christian Loehle <christian.loehle@arm.com>
>>
>>> ---
>>>   drivers/cpuidle/governors/menu.c | 7 ++++++-
>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
>>> index 39aa0aea61c6..8fc7fbed0052 100644
>>> --- a/drivers/cpuidle/governors/menu.c
>>> +++ b/drivers/cpuidle/governors/menu.c
>>> @@ -255,7 +255,12 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
>>>            */
>>>           data->next_timer_ns = KTIME_MAX;
>>>           delta_tick = TICK_NSEC / 2;
>>> -        data->bucket = which_bucket(KTIME_MAX);
>>> +        /*
>>> +         * Assign the last bucket value directly instead of calling
>>> +         * which_bucket(), since KTIME_MAX is the largest possible
>>> +         * value that always falls into the last bucket.
>>> +         */
>>
>> comment almost seems overkill.
>>
>>> +        data->bucket = BUCKETS - 1;
>>>       }
>>>         if (unlikely(drv->state_count <= 1 || latency_req == 0) ||
>>
> Thanks Christian for the review~
> 
> Actually I just want to add a comment to indicate that which_bucket()
> was once called here, in case which_bucket() changes in the future,
> and however, we stayed with the original approach, leading to the
> inconsistency.
> 
> Could you please review the comment below and let me know if it's okay
> or if I should not add any log? Thanks a lot~
> 
> /* KTIME_MAX falls into the last bucket, skip which_bucket(). */
> 
> 
> 
> I will collect review comments before arise patch V2.

Honestly I'd be fine without a comment, it's pretty obvious that
everything containing "bucket =" needs to be changed if the bucket
logic ever changes.

