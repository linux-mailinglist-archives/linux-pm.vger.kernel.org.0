Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2A622002B
	for <lists+linux-pm@lfdr.de>; Tue, 14 Jul 2020 23:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGNVjc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 14 Jul 2020 17:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbgGNVjb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 14 Jul 2020 17:39:31 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5E7C061755
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:39:31 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id p7so8230624qvl.4
        for <linux-pm@vger.kernel.org>; Tue, 14 Jul 2020 14:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ivtV/tA+b1A/Jafm7GfFZzd+iRi0WOOxKuOfikxY7+k=;
        b=WjEYpxVM3mq/vbkRqdXSLdC7YbDXYAN/KzVub+tuD6Pj/BjXgN6ubrURsurRWz5Zju
         XVL/1DkXIqEXvbjBtcHthBS/cpgE68ii8m0B8NWdlp+0ZsEERD+qlrbrswcvQL9nhoIo
         pCyLIufdlyvYT5fREkPjqmbjxcHYRExuBahHXDsu+u5fsocUIz2jZtMM7zgDTCDJwsfA
         /1fopVeOCIW7EaL0irp4bqfk5vXgkSZWjqjB2wZB/J7Xl0goI+lxCGzOO6THyQk5vTAL
         aZDdX27Ci77hxUKb2q5WbtCT6O3L+8RDEwzsI97kA0s9VZqAsrwcs845rOZpQMrZDIzv
         tYXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ivtV/tA+b1A/Jafm7GfFZzd+iRi0WOOxKuOfikxY7+k=;
        b=V3i92sehjJbuKJf1eskTLPsfH0CRyb54u6s4SidHxfZmEsSGsav7p3jpZ3CZ+eFqKC
         JGZhOK4jo9hKWGKvc/xsPr9n/BhggS6L64g5Lrn+s8ylAxtirwmPGE+E6qT+evX/nrjF
         Jwu5W5EV6Ej3t2002LMHXVdTeiI5udVGYiIVl58sEQ0iIW23rzZ+mrGpDT+w6kGNNmEV
         HlE2ygdlPOoE7c3LEvWo9w4OavgY4J96s0sFoIC1mzXpodch8/jSrZo/+zMo+padb5Sb
         ZhqDH4CqZm6X6X0xf61eqvjWlzzU0P4YqAUPwGLEXwIDCRaJQxsAaV5Tut2QjOyX8cbl
         l+YQ==
X-Gm-Message-State: AOAM5303XND2bXu0MQhPM9QP9A/QjMuLuXpggfuxnId8NFRqsjFa56Wl
        Mz8T4zmZ83SVXAT9acc1KLUyOg==
X-Google-Smtp-Source: ABdhPJwe07rWmBLjDl+TNx93m7uxFpH0gw52e9HYRNc/1T0+JhOUVFNF4wo6TGY89wzmBv3Wnssccw==
X-Received: by 2002:ad4:42a7:: with SMTP id e7mr6694798qvr.212.1594762770573;
        Tue, 14 Jul 2020 14:39:30 -0700 (PDT)
Received: from [192.168.1.92] (pool-71-255-246-27.washdc.fios.verizon.net. [71.255.246.27])
        by smtp.gmail.com with ESMTPSA id r185sm740qkb.39.2020.07.14.14.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 14:39:30 -0700 (PDT)
Subject: Re: [RFC PATCH 0/4] thermal: Introduce support for monitoring falling
 temperature
To:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200710135154.181454-1-thara.gopinath@linaro.org>
 <7437ee89-e76d-0c82-9860-5c6076ad8a30@linaro.org>
 <b25d54d35cec777f0dcc5b2bcacce27321d9bd45.camel@intel.com>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <5861acec-c49a-47cc-d7c6-ccef11dc1d58@linaro.org>
Date:   Tue, 14 Jul 2020 17:39:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <b25d54d35cec777f0dcc5b2bcacce27321d9bd45.camel@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 7/14/20 9:49 AM, Zhang Rui wrote:
> On Mon, 2020-07-13 at 17:03 +0200, Daniel Lezcano wrote:
>> On 10/07/2020 15:51, Thara Gopinath wrote:
>>> Thermal framework today supports monitoring for rising temperatures
>>> and
>>> subsequently initiating cooling action in case of a thermal trip
>>> point
>>> being crossed. There are scenarios where a SoC need some warming
>>> action to
>>> be activated if the temperature falls below a cetain permissible
>>> limit.
>>> Since warming action can be considered mirror opposite of cooling
>>> action,
>>> most of the thermal framework can be re-used to achieve this.
>>>
>>> This patch series is yet another attempt to add support for
>>> monitoring
>>> falling temperature in thermal framework. Unlike the first
>>> attempt[1]
>>> (where a new property was added to thermal trip point binding to
>>> indicate
>>> direction of temperature monitoring), this series introduces a new
>>> trip
>>> point type (THERMAL_TRIP_COLD) to indicate a trip point at which
>>> falling
>>> temperature monitoring must be triggered. This patch series uses
>>> Daniel
>>> Lezcano's recently added thermal genetlink interface[2] to notify
>>> userspace
>>> of falling temperature and rising temperature at the cold trip
>>> point. This
>>> will enable a user space engine to trigger the relevant mitigation
>>> for
>>> falling temperature. At present, no support is added to any of the
>>> thermal
>>> governors to monitor and mitigate falling temperature at the cold
>>> trip
>>> point;rather all governors return doing nothing if triggered for a
>>> cold
>>> trip point. As future extension, monitoring of falling temperature
>>> can be
>>> added to the relevant thermal governor.
>>
>> I agree we need a cold trip point in order to introduce the
>> functioning
>> temperature range in the thermal framework.
>>
>> Rui, what is your opinion ?
> 
> I agree with the concept of "cold" trip point.
> In this patch set, the cold trip point is defined with only netlink
> event support. But there are still quite a lot of things unclear,
> especially what we should do in thermal framework?
Hi Rui,

Thanks for the comments.

You are right that cold trip points are dealt with only by netlink 
events in this patch series. Eventually IMHO, governors should handle 
them with a logic opposite to what is being currently done for non-cold 
trip points.

> 
> For example, to support this, we can
> either
> introduce both "cold" trip points and "warming devices", and introduce
> new logic in thermal framework and governors to handle them,
> Or
> introduce "cold" trip point and "warming" device, but only
> semantically, and treat them just like normal trip points and cooling
> devices. And strictly define cooling state 0 as the state that
> generates most heat, and define max cooling state as the state that
> generates least heat. Then, say, we have a trip point at -10C, the
> "warming" device is set to cooling state 0 when the temperature is
> lower than -10C, and in most cases, this thermal zone is always in a
> "overheating" state (temperature higher than -10C), and the "warming"
> device for this thermal zone is "throttled" to generate as least heat
> as possible. And this is pretty much what the current code has always
> been doing, right?


IMHO, thermal framework should move to a direction where the term 
"mitigation" is used rather than cooling or warming. In this case 
"cooling dev" and "warming dev" should will become 
"temp-mitigating-dev". So going by this, I think what you mention as 
option 1 is more suitable where new logic is introduced into the 
framework and governors to handle the trip points marked as "cold".

Also in the current set of requirements, we have a few power domain 
rails and other resources that are used exclusively in the thermal 
framework for warming alone as in they are not used ever for cooling 
down a zone. But then one of the requirements we have discussed is for 
cpufreq and gpu scaling to be behave as warming devices where the 
minimum operating point/ voltage of the relevant cpu/gpu is restricted.
So in this case, Daniel had this suggestion of introducing negative 
states for presently what is defined as cooling devices. So cooling dev 
/ temp-mitigation-dev states can range from say -3 to 5 with 0 as the 
good state where no mitigation is happening. This is an interesting idea 
though I have not proto-typed it yet.

> 
> I can not say which one is better for now as I don't have the
> background of this requirement. It's nice that Thara sent this RFC
> series for discussion, but from upstream point of view, I'd prefer to
> see a full stack solution, before taking any code.

We had done a session at ELC on this requirement. Here is the link to 
the presentation. Hopefully it gives you some back ground on this.

https://elinux.org/images/f/f7/ELC-2020-Thara-Ram-Linux-Kernel-Thermal-Warming.pdf

I have sent across some patches for introducing a generic power domain 
warming device which is under review by Daniel.

So how do you want to proceed on this? Can you elaborate a bit more on 
what you mean by a full stack solution.

> 
> thanks,
> Rui
> 

-- 
Warm Regards
Thara
