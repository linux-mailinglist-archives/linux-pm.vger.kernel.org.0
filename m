Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30486325FD7
	for <lists+linux-pm@lfdr.de>; Fri, 26 Feb 2021 10:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhBZJRN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 26 Feb 2021 04:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhBZJPF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2021 04:15:05 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37C8C061756;
        Fri, 26 Feb 2021 01:14:24 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id q204so4807213pfq.10;
        Fri, 26 Feb 2021 01:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4HudJwsSNTrLZRkkYuja6CKbDzOsyudkGlfh5uEFK/w=;
        b=Jsf+u+mV2rHgtUjTLZHvllF8IvzUWw7SWPr0ueu6R2IeEMsc/b63HgOW+L6f5bucxe
         lgB2XENZ2+cmltsyFxcDiD+SEfKAzWNM1IamCXvb1/Mz547A3kbCmaO73wyJhVDo1YsH
         ULf1SK6HXy7wcCZnPDwQpwUy4+mSsxY8ulNcs9ZFK86RBIN6CAcCv+CQGCyOHTlAX0KW
         Dc5MYWAVfJ/+rRbmCQBEZfIrIelfubKaRFCatj+3IzgBBbb6MIEEnF72tZzugx78UovK
         Wp7bqUVUwz6MaFh1m9WveEFRTOG3jtpa5Epb4qXsRxuR4lqVo53coY1zNMjcdNkC0s3d
         ckAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4HudJwsSNTrLZRkkYuja6CKbDzOsyudkGlfh5uEFK/w=;
        b=AMJJPbyJ9/K527mX9YjqceRo1miqm/gkmqqsu/uOjlI8PWf9jnvrO8ga94kmppgDw5
         VErfQ9zUoYO04vq3362+sUZCIi1qJJUwzF8He8TEafuFTaqP3Eu2w/kB3gs3yi21YYaZ
         LaOQAgZtIEh6UBp1SBimI431nsVe2B3zfKG5SXw44kEqdaOwL2g/qi70yQ25FpoHrOkz
         vX6OvWOQjXqlDLQ/z63vkQ687zwsG/fBfQRGQhuPtLEHt1V8PI0ar4nVP04VlQzTBZ5H
         +Rxu86b3NiE4KpTZ0cOJHZtub7vqfwLC/TAElMJKURjNFYVg1WBooT26VxRvhKcbC0Xr
         D2Tg==
X-Gm-Message-State: AOAM532deVY+zb0ZqqDwiRtV2IyguZRhhbRE9E2AA95eLofk2xvf1dH8
        BwQXGiAuSyGSxYYj28tpFtu0jSeGq3ceAA==
X-Google-Smtp-Source: ABdhPJwE8r0YJpEHq7Vl6OOIIeL8NNUTro2dtr1y2mxew8SXK7jK3N+Fx5aHCC71jjjhEQVzS9kC/w==
X-Received: by 2002:a63:fa4d:: with SMTP id g13mr2075292pgk.201.1614330863705;
        Fri, 26 Feb 2021 01:14:23 -0800 (PST)
Received: from [172.30.1.19] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d189sm8886708pfd.42.2021.02.26.01.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Feb 2021 01:14:23 -0800 (PST)
Subject: Re: [PATCH v2 3/9] devfreq: Use HZ macros
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org,
        andriy.shevchenko@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        "open list:DEVICE FREQUENCY (DEVFREQ)" <linux-pm@vger.kernel.org>
References: <20210224144222.23762-1-daniel.lezcano@linaro.org>
 <20210224144222.23762-3-daniel.lezcano@linaro.org>
 <0db79cd7-f062-b31b-2a6c-ecf8dadaf572@gmail.com>
 <09954745-5b39-8718-ca79-3e92a85e5ace@linaro.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Message-ID: <112760b7-0594-2077-b632-ea5611481be6@gmail.com>
Date:   Fri, 26 Feb 2021 18:14:18 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <09954745-5b39-8718-ca79-3e92a85e5ace@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 21. 2. 26. 오후 5:51, Daniel Lezcano wrote:
> On 26/02/2021 07:08, Chanwoo Choi wrote:
>>
>>
>> On 21. 2. 24. 오후 11:42, Daniel Lezcano wrote:
>>> HZ unit conversion macros are available in units.h, use them and
>>> remove the duplicate definition.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Reviewed-by: Christian Eggers <ceggers@arri.de>
>>> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>
>>> ---
>>>    drivers/devfreq/devfreq.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
>>> index bf3047896e41..b6d63f02d293 100644
>>> --- a/drivers/devfreq/devfreq.c
>>> +++ b/drivers/devfreq/devfreq.c
>>> @@ -26,6 +26,7 @@
>>>    #include <linux/hrtimer.h>
>>>    #include <linux/of.h>
>>>    #include <linux/pm_qos.h>
>>> +#include <linux/units.h>
>>>    #include "governor.h"
>>>      #define CREATE_TRACE_POINTS
>>> @@ -33,7 +34,6 @@
>>>      #define IS_SUPPORTED_FLAG(f, name) ((f & DEVFREQ_GOV_FLAG_##name)
>>> ? true : false)
>>>    #define IS_SUPPORTED_ATTR(f, name) ((f & DEVFREQ_GOV_ATTR_##name) ?
>>> true : false)
>>> -#define HZ_PER_KHZ    1000
>>>      static struct class *devfreq_class;
>>>    static struct dentry *devfreq_debugfs;
>>>
>>
>> I changed the patch title with 'PM /' prefix as following
>> in order to keep the consistent patch style if there are no any special
>> objection.
>> - PM / devfreq: Use HZ macros
>>
>> Applied it.
> 
> It should not compile. This patch and others depend on 1/9.
> 
> It would make sense to merge all of them through linux-pm.

OK. I'm OK to apply it to linux-pm.

Thanks,
Chanwoo Choi
