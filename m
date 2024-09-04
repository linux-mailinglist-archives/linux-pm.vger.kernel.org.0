Return-Path: <linux-pm+bounces-13545-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 680F696B560
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 10:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B70AAB2986C
	for <lists+linux-pm@lfdr.de>; Wed,  4 Sep 2024 08:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246C71CC149;
	Wed,  4 Sep 2024 08:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkqQF1o9"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE3D1CC171
	for <linux-pm@vger.kernel.org>; Wed,  4 Sep 2024 08:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439433; cv=none; b=REksET618yX1lnS+7mHXMryaoFmHZsdWDzc8aEyg+lq/KYpPuooClkCc8fFy4H5bUF2kdqyUn0GbWKUEX5FtwXqBsFu+oGjiOPDqajU9pxDz7qgSSN3BqUdUJnlUtq0+KcZhCE1wqliwoLozH8K464+BKKXqU2AVOIoY7AYyMfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439433; c=relaxed/simple;
	bh=Gk3zLyrzQzvakl8QBEpXbvzaoGbO4UNKKLGOcfDIrfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r3p5vsEaJLkhq3qlz5RYjXWhPfIdp15UoDWw5zqbaxzG4k94bV6vVIew4sQ5R9cnj6egeW1ERG4WWEOL4hlF833C5yAaUDxMJ8GiWBZAlLbgaQEGQXVakUx7JEbqde/aYBZzXHFG7nf0lOUVCQTvUWlKDPAq20OmWJyJYn41lJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CkqQF1o9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-374c0a8c7a9so2597714f8f.0
        for <linux-pm@vger.kernel.org>; Wed, 04 Sep 2024 01:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725439429; x=1726044229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z68EkT3qo5WSbFgfRBY6eD2GO9qOZvpcIyhCpO6NlAc=;
        b=CkqQF1o97VV77INDaYQyLiHBZFEbY4VhLukJBDFrEG8PUSk+NB65Qzg/+1dieY8eCV
         OEc/LglIBzHFzR9/KFfJB/dvvlwjyiEIUioK99XbMLnRFfvOaSCCtAY2QkTb0c5Iy1eI
         It253JSLPldwrdKUA15wDyRv+WF8aD3NtFI8SM06Xy7Mgb/sAeAwaxVUfw/orHl0/cqb
         wmSw2JwGCZgadNXFyDKh0BYvZH8NseODmUd0Ms/wRlxAsFkyCkBrM+Lh0lD3nk5T1+GF
         W53mPcP66Q08K2fpRDIwaytb760PM7fhhWY0KwAuk6JK7aHtmD6lEbJ/rruKMjYPwS9y
         KFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725439429; x=1726044229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z68EkT3qo5WSbFgfRBY6eD2GO9qOZvpcIyhCpO6NlAc=;
        b=d2eYhmcYzqn0/ZMS8wtM6shTA0eI1IWBasp5+HDq1BcBO0Fb9xr3kVL/amz+UueZiH
         188bMHfCI3UFdUS+aXqCATFebuqxqnzjlVrZkS0Ul1HBsB9+LMATv/23KsDMBHSraQDR
         L9ftkYSIJeIR3udxXx05Kk7GAlJX4Kh3VczsTn5g9OuHlfLbptbs1NJ4Ljhn0cLa05kf
         if2jDpJGh/IoQ1ETtv6BxVtHGLiubPUvbjN2QXFTNL0/7vZjOp5Oifoormy5gwN8ATBx
         py00MZFjKZK9jl38QQ+chCQj5timmlstW8wxVkV2KvOLtdQsKH8ow56yqGQD1fBZ4Xk9
         Vt/A==
X-Gm-Message-State: AOJu0YxgrqCZ10SA8xLUo6mDz7ydz8t16o3bFmotkVlCMaO2oI4DZVch
	+mw4vllz7PVmqHyrqFlBsuvM1qCLfPp4Eq5vJp+XtF45q1Bi5EEgulbvRqAv48A=
X-Google-Smtp-Source: AGHT+IFHW5qdyWQIbwZstVZ993wH4i6R9us0S65YSSc5Xbp7Cd+ATWrK/aKidLuw97LyB/lp3ICN4g==
X-Received: by 2002:a05:6000:2c8:b0:374:ccb0:66c7 with SMTP id ffacd0b85a97d-374ecc8f350mr5332013f8f.16.1725439429185;
        Wed, 04 Sep 2024 01:43:49 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-374c610d437sm9375073f8f.97.2024.09.04.01.43.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 01:43:48 -0700 (PDT)
Message-ID: <3459b7a6-d82b-4c2b-aed6-a97ad67f89db@linaro.org>
Date: Wed, 4 Sep 2024 10:43:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/7] thermal/core: Add thresholds support
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, lukasz.luba@arm.com, quic_manafm@quicinc.com
References: <20240816081241.1925221-1-daniel.lezcano@linaro.org>
 <20240816081241.1925221-3-daniel.lezcano@linaro.org>
 <CAJZ5v0iY4jgnMEJeS97JYWa+DSwLk=feTDJCdKmJmF6UzWaYHw@mail.gmail.com>
 <CAJZ5v0h=DgBSiFbdmnzSFjEJd6sdBffCODspxmM-G92FN2HGiA@mail.gmail.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0h=DgBSiFbdmnzSFjEJd6sdBffCODspxmM-G92FN2HGiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/08/2024 13:30, Rafael J. Wysocki wrote:
> On Wed, Aug 21, 2024 at 10:05 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>
>> On Fri, Aug 16, 2024 at 10:12 AM Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
> 
> [cut]
> 
>>> --- /dev/null
>>> +++ b/drivers/thermal/thermal_thresholds.c
>>> @@ -0,0 +1,241 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright 2024 Linaro Limited
>>> + *
>>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> + *
>>> + * Thermal thresholds
>>> + */
>>> +#include <linux/list.h>
>>> +#include <linux/list_sort.h>
>>> +#include <linux/slab.h>
>>> +
>>> +#include "thermal_core.h"
>>
>> +#include "thermal_thresholds.h"
>>
>>> +
>>> +struct thresholds {
>>> +       struct list_head list;
>>> +};
>>
>> This duplicates the definition in the header file.
>>
>> Besides, why is the wrapper struct needed?
> 
> On second thought, it can hold a pointer to the first threshold that
> was strictly above the zone temperature when
> thermal_thresholds_handle() ran last time, so something like:
> 
> struct thresholds {
>        struct list_head list;
>        struct user_threhold *first_above;
> };
> 
> and first_above == NULL would mean that the zone temperature was above
> all of the threshold or at the highest one.
> 
> Then thermal_thresholds_handle() could do something like:
> 
> tr = tz->user_thresholds.first_above;
> 
> if (tr && tz->temperature >= tr->temperature) {
>      do {
>          if (tr->direction & THERMAL_THRESHOLD_WAY_UP)
>              notify = true;
> 
>          if (tr->list_node.next != &tz->user_thresholds.list) {
>              tr = list_next_entry(tr, list_node);
>          else
>              tr = NULL;
>      } while (tr && tz->temperature >= tr->temperature);
> } else {
>      if (!tr)
>          tr = list_last_entry(&tz->user_thresholds.list,
>                       struct user_threshold, list_node);
> 
>      while (tz->temperature < tr->temperature)
>          if (tr->direction & THERMAL_THRESHOLD_WAY_DOWN)
>              notify = true;
> 
>          if (tr->list_node.prev != &tz->user_thresholds.list) {
>              tr = list_prev_entry(tr, list_node);
>          else
>              break;
>      }
>      if (tz->temperature >= tr->temperature)
>          tr = NULL;
> }
> tz->user_thresholds.first_above = tr;
> 
> which is a bit simpler than the code in the current patch.

TBH, it is probably a matter of taste but I don't see how it is simpler, 
especially if someone wants to to understand or add something in the 
code. I would prefer to keep the initial routine which was already tested.

[ ... ]

> 
> Also, I'm not sure why "high" and "low" are needed at all.
> 
> The current and last zone temperature could be included in the
> notification just fine and user space should be able to figure out
> which thresholds are affected.

I'm not sure to get the question. high and low are needed because the 
thermal core will call set_trips(). The trips and the thresholds are 
combined to find out the high and low temperature to program the driver 
to trigger an interrupt.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

