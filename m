Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C7C1A5DF9
	for <lists+linux-pm@lfdr.de>; Sun, 12 Apr 2020 12:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgDLKHu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 12 Apr 2020 06:07:50 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33830 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgDLKHu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 12 Apr 2020 06:07:50 -0400
Received: by mail-wm1-f66.google.com with SMTP id c195so8068421wme.1
        for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2020 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tcnA3gJ+12BtB7UDZloHYSBLEs8V+FrXuEWxclGnsNs=;
        b=Ao1achyjLYZkPfFDXUdRtpeBbCXIDv5RDPEQuEp/yfjjpCQJleJG0sTZjiHUVS/yEQ
         y9M+g2gb6VNL0PMApdpeAwDQjsnGLwraZnxRa98NQd032+1mWu5uovGqlnuKyV2L9OvB
         iSgBbyB2E8oKR24pl14EbPRQ281W4uBf3KVceZL2AKavTGLtIwqXjJmbE/8J/G9lDDY+
         mipVSlnmHKvv2oPeShnFUOdLQT1+/gOA2kKOkvYgnmbFkenybEgsCtQOv7blX1ws60+W
         oSYM55MbbAIXOKaw1OgaAxNO5X364FQx0HmHSt/mKCgnfOrMAaqiN+elJxIr4Wd2EPa0
         uHFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tcnA3gJ+12BtB7UDZloHYSBLEs8V+FrXuEWxclGnsNs=;
        b=kOzMo5HN+7SKLirKHhoKzccQQJGfmX6WhxuFTnu2f9GQjnGCWqw3Sg+Z3RTApxWAT8
         Vd+YuSdlJvxN+h1ipGn780IUC3TzD+1V3extdUWG1ins8pCpiOB79JRMZEsLWceTwOTC
         ESPKYeB/WxtHbvPjcE5Vg6//rHynTOG6ZnMnvrd8Le8DK8O8vioEN7Vnpeoq7cb7kAAJ
         cjMaFjC/txA1S3nHJxzMCoV2eSM85mFNY+a8K4vR21E5eMF+eeOvNvIt9Z7EElCSLyme
         mCyyH5em/jL9NQBbW3OMKg1ON41rAuAQTpThjmvTDQ+cXE9Pw9nE2xCgJkWBZYPmUGXb
         I4vA==
X-Gm-Message-State: AGi0PuY0KovKELfwWLDu+ZIEv6AVsxcsmYDPsIZ2k+n9TH+dy/xYDP7a
        LkI3D9iFQCgcou0A/2jOfGfW0Q==
X-Google-Smtp-Source: APiQypL2akXZi37Mbs8kmcKnZQqCK+ubHvZnUv+vwkceVY+/300eXQJ42MN1tI1E6XgzQo/t+m4d7w==
X-Received: by 2002:a7b:c5cd:: with SMTP id n13mr13124978wmk.125.1586686069694;
        Sun, 12 Apr 2020 03:07:49 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id n18sm9599619wmk.6.2020.04.12.03.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 03:07:48 -0700 (PDT)
Subject: Re: [RFC PATCH 5/5] ACPI: processor: do update when maximum cooling
 state changed
To:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Cc:     tiwai@suse.de, viresh.kumar@linaro.org
References: <20200408041917.2329-1-rui.zhang@intel.com>
 <20200408041917.2329-5-rui.zhang@intel.com>
 <5cd80df7-775e-96bd-cec5-b14965de2a67@linaro.org>
 <2bef9553fcf7ccd7c9811ad1d572af2e5a811917.camel@intel.com>
 <a15dee60-8d20-0f56-0037-276830c613cd@linaro.org>
 <fee68438572796c71089571e0ff0add6cbbd3e0c.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e264d4a2-b0d9-8adf-b44f-7501c4407029@linaro.org>
Date:   Sun, 12 Apr 2020 12:07:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <fee68438572796c71089571e0ff0add6cbbd3e0c.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org






Hi Rui,

On 12/04/2020 08:13, Zhang Rui wrote:
> On Fri, 2020-04-10 at 14:10 +0200, Daniel Lezcano wrote:

[ ... ]

>>> And to fix this, it's better to
>>> a. unregister and re-register the cooling device as you suggested.
>>> or
>>> b. introduce an API that updates the cooling device entirely
>>> instead of
>>> statistics table only.
>>>
>>> For either of the above solutions, we'd better to cleanup the code
>>> to 
>>> invoke .get_max_state() during registration/max_state_reset phase,
>>> once, and then always use cached value later.
>>> And plus, if we want to follow solution a), it's better to remove
>>> .get_max_state() callback and use an integer instead so that every
>>> driver knows this limitation.
>>> I'd vote for solution a) if there is no soc thermal driver that may
>>> return dynamic max_states.
>>>
>>> Do I still miss something?
>>
>> I agree for the a) solution too.
>>
>> But regarding the get_max_state() callback being converted to a
>> integer,
>> the driver int3406_thermal.c computes the upper and lower limits
>> which
>> are updated on a INT3406_BRIGHTNESS_LIMITS_CHANGED notification and
>> get_max_state() does uppper - lower.
> 
> Right, this is another case shows that it's better to support dynamic
> max_state.
> IMO, this is not difficult to do. We just need to introduce a new API,
> which reuses the current cdev device, and reset its every thermal
> instance, and update all the thermal zones the cdev is involved.
> what do you think?

I like how the thermal framework is designed but I think there are too
many API for the thermal framework and it deserves a simplification
rather than adding more of them.

There is no place where the get_max_state is cached except in the stats
structure.

In the function thermal_cooling_device_stats_update():

  Is it possible to just compare the 'new_state' parameter with
stats->max_state and if it is greater increase the stats table and
update max_state to the new_state ?



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
