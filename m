Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18133365C18
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 17:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbhDTPZG (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 11:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhDTPZG (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 11:25:06 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DABBC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 08:24:34 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n127so8621737wmb.5
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GFSKpzQJQZPhNu8hc1kWWJ/QfS/c4/ErGH6wh4S9JqQ=;
        b=c0uSuoro9RcMeNl9/7Sh1xd0t6JoGVZQPMZWB2Y7Kh1sTaYkJiijNfH584cPOdaryd
         zMTeMDdLgrQyiiaa2R4fYfD03bEN9FcYmtvIt2eIj+YJZvPa0syKLmnGcYectMJUkeTN
         rIorpbXSw6gFn2h2ww86hFmewVsB96Tac5LfH5g/bNYbb+zN8M4iVyQqu82U17RijPDe
         KhoKai9cMHQxR+zpiQ1TmX5/zhBcDyJTx5EDAWzHYV2/XWA9B67QqShb4bNduOsXpJXF
         jO3vSqrpNgnBryyyg9mFz024Za+BuzVQRnH3LjU0yVGou3+3SgoOwKsHQVaO/Kyz0NwK
         aE4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GFSKpzQJQZPhNu8hc1kWWJ/QfS/c4/ErGH6wh4S9JqQ=;
        b=ovZRYnvxMTPUyNQPrVLetq7wKg2G/JEQhepr2OWGbFtZifD4vOEcyRjkc++Kdyy7dU
         QTDEqyTSJQKl2jJIKhkHch8UC6psovCtLYGbXGHZhNIKlu6V5u07bSuDqpNOgT0pt2kw
         6OYlBdBG8lsTSXZD9EKeQh0ssESdnVBDPWnz7IAvw3p2AI8qmelkuNkaGoHuiLJdK+6P
         XWLJiibG3BcQZDMu21oTv0BpEQFrUn2BGE/vVuLfCYPLhRDduOplEqJkCa9bopNWekdb
         o3PsJ01XMyU+qgQujoixy9judmyQ9TPOxZbiwqRbq16O+Mk8UU+sUcuq6CrUeuKBsxJQ
         DhyQ==
X-Gm-Message-State: AOAM533jgT+4zz0+/5jSIIl28pS+vhzcNDC9h+fSSne9CckGkXNaawF/
        9eyCwLkpkwRB8q5w4a+lWVdcjg==
X-Google-Smtp-Source: ABdhPJwHRvUm6Zw5aHm17c2DLLyhHdn2PLZW1y0wMiOT4sTXYwG+4oNwlyCAePBefA8RJiX1DAbHiw==
X-Received: by 2002:a05:600c:4f96:: with SMTP id n22mr3560868wmq.117.1618932273101;
        Tue, 20 Apr 2021 08:24:33 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id o1sm29459651wrw.95.2021.04.20.08.24.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 08:24:32 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] thermal: power_allocator: update once cooling
 devices when temp is low
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
References: <20210419084536.25000-1-lukasz.luba@arm.com>
 <20210419084536.25000-3-lukasz.luba@arm.com>
 <c69e2ba0-b382-01a0-292f-019fffd365e0@linaro.org>
 <55943d6f-0f72-215d-1dd4-bf3996092df7@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <91411c9c-d78e-8ba6-1cd3-da6879bc5ceb@linaro.org>
Date:   Tue, 20 Apr 2021 17:24:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <55943d6f-0f72-215d-1dd4-bf3996092df7@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/04/2021 16:21, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 4/20/21 2:30 PM, Daniel Lezcano wrote:
>> On 19/04/2021 10:45, Lukasz Luba wrote:
> 
> [snip]
> 
>>> -        instance->cdev->updated = false;
>>> +        if (update)
>>> +            instance->cdev->updated = false;
>>> +
>>>           mutex_unlock(&instance->cdev->lock);
>>> -        (instance->cdev);
>>> +
>>> +        if (update)
>>> +            thermal_cdev_update(instance->cdev);
>>
>> This cdev update has something bad IMHO. It is protected by a mutex but
>> the 'updated' field is left unprotected before calling
>> thermal_cdev_update().
>>
>> It is not the fault of this code but how the cooling device are updated
>> and how it interacts with the thermal instances.
>>
>> IMO, part of the core code needs to revisited.
> 
> I agree, but please check my comments below.
> 
>>
>> This change tight a bit more the knot.
>>
>> Would it make sense to you if we create a function eg.
>> __thermal_cdev_update()
> 
> I'm not sure if I assume it right that the function would only have the:
> list_for_each_entry(instance, &cdev->thermal_instances, cdev_node)
> 
> loop from the thermal_cdev_update(). But if it has only this loop then
> it's too little.
> 
>>
>> And then we have:
>>
>> void thermal_cdev_update(struct thermal_cooling_device *cdev)
>> {
>>          mutex_lock(&cdev->lock);
>>          /* cooling device is updated*/
>>          if (cdev->updated) {
>>                  mutex_unlock(&cdev->lock);
>>                  return;
>>          }
>>
>>     __thermal_cdev_update(cdev);
>>
>>          thermal_cdev_set_cur_state(cdev, target);
> 
> Here we are actually setting the 'target' state via:
> cdev->ops->set_cur_state(cdev, target)
> 
> then we notify, then updating stats.
> 
>>
>>          cdev->updated = true;
>>          mutex_unlock(&cdev->lock);
>>          trace_cdev_update(cdev, target);
> 
> Also this trace is something that I'm using in my tests...

Yeah, I noticed right after sending the comments. All that should be
moved in the lockless function.

So this function becomes:

void thermal_cdev_update(struct thermal_cooling_device *cdev)
{
	mutex_lock(&cdev->lock);
	if (!cdev->updated) {
		__thermal_cdev_update(cdev);
		cdev->updated = true;
	}
	mutex_unlock(&cdev->lock);

	dev_dbg(&cdev->device, "set to state %lu\n", target);
}

We end up with the trace_cdev_update(cdev, target) inside the mutex
section but that should be fine.

>>          dev_dbg(&cdev->device, "set to state %lu\n", target);
>> }
>>
>> And in this file we do instead:
>>
>> -        instance->cdev->updated = false;
>> +        if (update)
>> +            __thermal_cdev_update(instance->cdev);
>>            mutex_unlock(&instance->cdev->lock);
>> -        thermal_cdev_update(instance->cdev);
> 
> Without the line above, we are not un-throttling the devices.

Is it still true with the amended function thermal_cdev_update() ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
