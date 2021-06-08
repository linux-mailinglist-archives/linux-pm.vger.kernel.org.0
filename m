Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F413A035C
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhFHTQK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 15:16:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237870AbhFHTNA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Jun 2021 15:13:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D8F561429;
        Tue,  8 Jun 2021 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623178181;
        bh=mkZddtvemX7SZ3/W2EA5INNUZ5bKZfSFMWe9TGtl/Dk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=nVUytxhH47ZnJYyZxWjW+udYyN+3snizcWsgK3RLppHC1NGMs/g/dQXpEAvxHTPHF
         Mnu4FUCpc8RQhOmdS6dM5d+fc5n8R4VZ2RaYzB3tq2X0ql3RKJNnRNWSHoZlvrLDd0
         cejNlj5+sdoTgqVM8IkdLkQNWVCbWFo7cxiR/oE5WsOpaj/03JN53DD0lVF9gn6PFJ
         wF2TDO5xy7+WsCPMyS/VEyFsSBaCazPvfuC9JQV+QGQyuvTW4DCf9gj7j8SJAb+mWp
         QyuQaNLfNXwTDjYFNhP8zUx92b6hlN7Pwyxrpi35I/YJKRqxF5JpvUu4JStI/s3fl5
         WFurUUblPTzUA==
Subject: Re: [PATCH] thermal: devfreq_cooling: Fix kernel-doc
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, amitk@kernel.org,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <1623145562-111662-1-git-send-email-yang.lee@linux.alibaba.com>
 <CAKwvOdmyXV09ZxcDqQ6x43f+Eze4h40W2AoKcCmUhGM2gUWsnQ@mail.gmail.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <6335deba-9e94-61e0-89a1-8905be0e35a1@kernel.org>
Date:   Tue, 8 Jun 2021 11:49:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAKwvOdmyXV09ZxcDqQ6x43f+Eze4h40W2AoKcCmUhGM2gUWsnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 6/8/2021 11:39 AM, Nick Desaulniers wrote:
> On Tue, Jun 8, 2021 at 2:46 AM Yang Li <yang.lee@linux.alibaba.com> wrote:
>>
>> Fix function name in devfreq_cooling.c kernel-doc comment
>> to remove a warning found by clang(make W=1 LLVM=1).
>>
>> drivers/thermal/devfreq_cooling.c:479: warning: expecting prototype for
>> devfreq_cooling_em_register_power(). Prototype was for
>> devfreq_cooling_em_register() instead.
>>
>> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> That compiler warning doesn't come from kernel-doc.  Your diff looks
> good (the comment was wrong), but the commit message is curious.

No, this is indeed kernel-doc complaining. Clang should not even be 
mentioned in the commit message:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/kernel-doc?h=v5.13-rc5#n1228

The warning could probably be improved to say "definition" instead of 
"prototype" in certain cases but *shrugs*.

This warning is similar to -Wmissing-prototypes from clang but refers to 
the fact that the comment claims it is documenting one function but it 
is really documenting another.

Cheers,
Nathan

> Usually that warning is from when the function prototype does not
> exist for a function with extern linkage.  It looks like that's always
> provided though in include/linux/devfreq_cooling.h.  Can you share a
> link to the original report?
> 
>> ---
>>   drivers/thermal/devfreq_cooling.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
>> index 3a788ac..5a86cff 100644
>> --- a/drivers/thermal/devfreq_cooling.c
>> +++ b/drivers/thermal/devfreq_cooling.c
>> @@ -458,7 +458,7 @@ struct thermal_cooling_device *devfreq_cooling_register(struct devfreq *df)
>>   EXPORT_SYMBOL_GPL(devfreq_cooling_register);
>>
>>   /**
>> - * devfreq_cooling_em_register_power() - Register devfreq cooling device with
>> + * devfreq_cooling_em_register() - Register devfreq cooling device with
>>    *             power information and automatically register Energy Model (EM)
>>    * @df:                Pointer to devfreq device.
>>    * @dfc_power: Pointer to devfreq_cooling_power.
>> --
>> 1.8.3.1
>>
> 
> 
