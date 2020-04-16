Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7241ABA95
	for <lists+linux-pm@lfdr.de>; Thu, 16 Apr 2020 09:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441041AbgDPH6S (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 16 Apr 2020 03:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2440999AbgDPH6N (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 16 Apr 2020 03:58:13 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3C8C061A0C
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2020 00:58:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id d27so3715618wra.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2020 00:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=e5bBUq5IKxt4W5U9kejTWC2B4YRUxv1TpPoTQBd4Ofk=;
        b=a3m35HFCG44Sofjf1kn9lVeJSiDFOAmWIZk+mfKDt3aiqoMjkdM/6vc3MOUAenmKDN
         RXUhasOM+97TVI5nncFJiheNddGcsAShOUrvTneaLWc17jo7Hna/oX1JmXt1fLBu+CGM
         vaoDtYhrBIP8reHPynBYLa/LeyoS7rbIcWjRWwYjucXgNBKD6UNVcGeNkDmLVWSucPBh
         c8vRpolY8jhIen0ms7N5TSg7FPOUr+3xiZl/4eaXzWkFNfgj6+kqMUU9WLDRxBEfCp1K
         O6IuHtvSZuJQT4Yq8+Y+lKTlfg/aX51Vhll4iQKZrUfK3T4jLp8z3JZJ/U3EfSRsYcef
         EpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e5bBUq5IKxt4W5U9kejTWC2B4YRUxv1TpPoTQBd4Ofk=;
        b=grYBm9uO+f+JRSGqdP9tR0xeLaQiY2XnsQFugXV9dGHNuFTqaWS6Mpk9KmKPfUxMgP
         ujg/4NKUxnWWaaFKaJr0Hem393JQzbM//S6EqaWUp78qQOZ47JXLAnGALlRKW8jx0ZZi
         kRsTvLQr/M0wkky7OFWF5048JkvF6ZP/OCqvdq90rdxYF3A3h/qJ18w9WcbnRJRJ2b3g
         mZY65VRYSyS7aW0F70xyf04hVcf/BLiLyBtMlp49t2JyKig7EOLxyn7HUYPZFyMhUb5J
         UHqPmdnOHHKcfUtJsnM2EVjJLNNI5dUHGhFkNgK/K3WBcVSQzXy+6OZxlKsQvS0CM3iM
         rOzg==
X-Gm-Message-State: AGi0Pua8ZkFMkyowMfkJWTaVYrA/agapEtMe9XfkTSEmrT+34LX7NUiU
        38Xl6kfS+klba+VFKiMoBgk2Zg==
X-Google-Smtp-Source: APiQypKjfZT0d86x64dleE3qvJ8aft8wJQeX/H9Nmz09eoOhCKXyqRGw0U6Usf7aPvQUykJeSNCzgg==
X-Received: by 2002:a5d:5651:: with SMTP id j17mr11023036wrw.406.1587023891863;
        Thu, 16 Apr 2020 00:58:11 -0700 (PDT)
Received: from [192.168.0.41] (lns-bzn-59-82-252-135-148.adsl.proxad.net. [82.252.135.148])
        by smtp.googlemail.com with ESMTPSA id o18sm98595wrp.23.2020.04.16.00.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 00:58:11 -0700 (PDT)
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
 <e264d4a2-b0d9-8adf-b44f-7501c4407029@linaro.org>
 <17727142fac13f641d7cd5c3713cfadef77aa75c.camel@intel.com>
 <1e65a2c3-fdeb-4f48-f477-a7ec67cffd4e@linaro.org>
 <eccb4e6a77ecd6ebaff9bd68b751ea20caa6a0a8.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <de51c277-22cd-6074-d651-084810656431@linaro.org>
Date:   Thu, 16 Apr 2020 09:58:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <eccb4e6a77ecd6ebaff9bd68b751ea20caa6a0a8.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/04/2020 06:46, Zhang Rui wrote:
> On Mon, 2020-04-13 at 20:06 +0200, Daniel Lezcano wrote:
>> On 13/04/2020 04:01, Zhang Rui wrote:
>>> On Sun, 2020-04-12 at 12:07 +0200, Daniel Lezcano wrote:
>>
>> [ ... ]
>>
>>> why we can not have a cdev->max_state field, and get it updated
>>> right
>>> after .get_max_state().
>>> and .get_max_state()  is only invoked
>>> a) during cooling device registration
>>> b) when cooling device update its max_state via the new API.
>>>
>>>>
>>>> In the function thermal_cooling_device_stats_update():
>>>>
>>>>   Is it possible to just compare the 'new_state' parameter with
>>>> stats->max_state and if it is greater increase the stats table
>>>> and
>>>> update max_state to the new_state ?
>>>>
>>>
>>> the problem is that thermal_cooling_device_stats_update() is
>>> invoked
>>> only if thermal zone are updated or the cur_state sysfs attribute
>>> is
>>> changed.
>>> There is no way for a cooling device driver to tell thermal
>>> framework
>>> that it has changed.
>>> Say, for the problem on hand, the statistics table will not be
>>> updated
>>> in time when cpufreq driver probed.
>>
>> Except I'm missing something, the statistics are only read from
>> userspace via sysfs.
> 
> I agree.
>>
>> userspace is not notified about a stat change. Is it really a problem
>> the table is not updated right at the probe time ?
> 
>>  Does it really matter
>> if the user sees the old table until an update happens on a new
>> higher
>> max state ?
>>
>> The table is always consistent whenever the userspace reads the
>> content.
> 
>>
>> A new entry will appear only if it is used, no?
>>
> Hmm, IMO, stats table is not the biggest problem here.
> The problem is that thermal framework is not aware of the max_state
> change, and the thermal instances are never updated according to the
> new max_state.
> So, we should invoke .get_max_state() in thermal_zone_device_update()
> and update the thermal instances accordingly.
> And then, what we need to do is just to do stats update right after
> .get_max_state() being invoked.
> 
> About how to update the stats table, I think adding new entries is not
> enough, because the meaning of each cooling state may change when
> max_state changes, thus I'd prefer a full reset/resizing of the table.

Ok, I understand. Are planning to use the existing API:

 thermal_zone_device_update(tz, THERMAL_TABLE_CHANGED);

?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
