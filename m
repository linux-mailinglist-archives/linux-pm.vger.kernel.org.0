Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D891D1A4626
	for <lists+linux-pm@lfdr.de>; Fri, 10 Apr 2020 14:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbgDJMKE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 10 Apr 2020 08:10:04 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46995 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgDJMKE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Apr 2020 08:10:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id f13so2057015wrm.13
        for <linux-pm@vger.kernel.org>; Fri, 10 Apr 2020 05:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fz+7DqbyND+YtObAVEhLZLoXc1g/mnriSwkAcLWIXW0=;
        b=U4GuO0FQ1Ub/kydtSoZiOJJqFQAtQj5YqosbYKEviZduw5Dul19xi0OVvsLQaTZJQO
         kvMsdj6d8XmbDNbiODOU2UhCKIlp9d5MPsL6ZCYIcph8jAJHMysebWwOk6h9xIZhN58m
         /lH3eU57UYvdvHJvwLKuOQV1Iwib/AbSHZvftssQ9TOWmOjJLPE/tV1Wjy3eSuSf84J7
         taLH/eI+nIUubaZQaX4uCteHcITTZtAyH2eFY93BDvV20/dNcyyK0J9lEBy5JWmNh4TE
         NzPN7WzjLihmCqB9r0TmEkPtLtgjYyUU1/IgQ3MLlPpJG8xgwCXliOkEPDZf2oevV+r8
         lZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fz+7DqbyND+YtObAVEhLZLoXc1g/mnriSwkAcLWIXW0=;
        b=LKjAEuCX1X5scIFW/NCMNyZ6yAW4x1cdfpXcKEh+NPzrObUOBMOWBiNsABP5vVfpSi
         uK3IrcnxevY58JAM+hKeht2VCuiIJJZIeVkLY9TFFCqHxjgTYCSswi3tvdD3GZ0sK0nj
         1yHZQgEFpwL/acScAgBXCP3GZ9OULTbRhcabXXjThUHN53FfLVVcZ6v0hLt0U2m75gfX
         uDRskI25Van3jQGpG/RTizX9sxF1dKYB2efjD+6sL9TdfWKv4BeTsYexllUj/QCtNGOk
         RgVrUWgvnOQ2DBPeywYiUkCseIaG6EG0DtKz096PKmW8pqWqs6CPtDXSnt2lR3dymEPJ
         sHHQ==
X-Gm-Message-State: AGi0PuZLxFcoYxIV2g+n1Svg/th9uKgDBB49zQlhRE3imyDq79FzAK1f
        mH7MsnbsjX5mApIc6b8ehcytPA==
X-Google-Smtp-Source: APiQypL4LU6ypL6MBxQZQvm90V0KUVBwYZgs+vDndG9pOIWnfx9J0M6TDsMeI6OJ0zQn2qZ59mUAww==
X-Received: by 2002:a5d:4306:: with SMTP id h6mr4170332wrq.234.1586520602163;
        Fri, 10 Apr 2020 05:10:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:5d41:5e24:690b:8d2a? ([2a01:e34:ed2f:f020:5d41:5e24:690b:8d2a])
        by smtp.googlemail.com with ESMTPSA id l12sm2540303wrt.73.2020.04.10.05.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 05:10:01 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
References: <20200408041917.2329-1-rui.zhang@intel.com>
 <20200408041917.2329-5-rui.zhang@intel.com>
 <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
 <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
Date:   Fri, 10 Apr 2020 14:10:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 10/04/2020 10:02, Zhang Rui wrote:
> On Thu, 2020-04-09 at 15:34 +0200, Daniel Lezcano wrote:
>> Hi Rui,
>>
>>
>> On 08/04/2020 06:19, Zhang Rui wrote:
>>> ACPI processor cooling device supports 1 cooling state before
>>> cpufreq
>>> driver probed, and 4 cooling states after cpufreq driver probed.
>>
>> What is this one state ?
> 
> One state means its original state and we can not set it to others.
> 
> ACPI processor cooling states are combined of p-state cooling states
> and a couple of optional t-state cooling states.
> 
> Say, if we have a processor device supports 7 throttling states, it
> actually supports 8 cooling states with cpufreq driver unprobed, and 11
> cooling states with cpufreq driver probed.
> 
>>
>>> Thus update the statistics table when the cpufeq driver is
>>> probed/unprobed.
>>
>> To be honest, the series seems to skirt a problem in the acpi
>> processor.
>>
>> If there is a new policy, then there is a new cooling device. Why not
>> unregister the old one and register the new one ?
>>
> Good point.
> IMO, the real problem is that do we support dynamic max_cooling_state
> or not in the thermal framework.
> Previously, I thought we don't have a hard rule of static
> max_cooling_state because we always invoke .get_max_state() callback
> when we need it. But after a second thought, actually we do have this
> limitation. For example, when binding cooling devices to thermal zones,
> the upper limit is set based on the return value of .get_max_state() at
> the binding time, and we never update the upper limit later.
> So this ACPI processor issue is not just about statistics table update
> issue, we actually lose some of its cooling states.
> 
> Thus, a new max_state means that all the previous setting of the
> cooling_device, i.e. all the thermal instances of the cooling device,
> needs to get updated.
> 
> And to fix this, it's better to
> a. unregister and re-register the cooling device as you suggested.
> or
> b. introduce an API that updates the cooling device entirely instead of
> statistics table only.
> 
> For either of the above solutions, we'd better to cleanup the code to 
> invoke .get_max_state() during registration/max_state_reset phase,
> once, and then always use cached value later.
> And plus, if we want to follow solution a), it's better to remove
> .get_max_state() callback and use an integer instead so that every
> driver knows this limitation.
> I'd vote for solution a) if there is no soc thermal driver that may
> return dynamic max_states.
> 
> Do I still miss something?

I agree for the a) solution too.

But regarding the get_max_state() callback being converted to a integer,
the driver int3406_thermal.c computes the upper and lower limits which
are updated on a INT3406_BRIGHTNESS_LIMITS_CHANGED notification and
get_max_state() does uppper - lower.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
