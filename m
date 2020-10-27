Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 865F729A6E0
	for <lists+linux-pm@lfdr.de>; Tue, 27 Oct 2020 09:48:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406256AbgJ0Irm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 27 Oct 2020 04:47:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41736 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509288AbgJ0Irk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2020 04:47:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id s9so890451wro.8
        for <linux-pm@vger.kernel.org>; Tue, 27 Oct 2020 01:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BwW+REPlxIwDJltL1navo4FmuG7WENsYC7PlrzbSxJs=;
        b=eG8/V8c4DVEAApf+O6xuEHJuWqrBl7sD1H6CeCVvGqST338OffYoR9+YT8k67V833I
         v/mhib1IagL7stWz8z8tRZqh1xmoM9t9ZI+dtWJVg6YFNwOilaqzUHszv0ExQq+gKLj+
         9N8VIA90R9egKfcC852pvEP9ufftvZEJbbCWN6rygVpjiqPEFB9GNXm5TZI/zXG4SFFS
         4bnQy71Gm/XjvOGoFKumvWIaDA67gU6QZETAjHlxnSmPgvFsgwKBOZlRnRxmmKIEh/AW
         lYcyxpKeQq67bQtQynNWWuqDbDug2weONj2sZfwdl/D9b9UJ1i5q6guurrnIBPhxvL+b
         +ZhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BwW+REPlxIwDJltL1navo4FmuG7WENsYC7PlrzbSxJs=;
        b=VSWjT4emxnTC9X6o3XK52p2yGN2dKsaB+TSVtrZeDm0FUIu1/FgHQBLH9w10iVVdAX
         GQJQCevlk4gTLXuT/VRgurOHDd5qqg7xZ/0UJbSeHctuqlauR/zpkPfEHVvrga6XwhUO
         2nfTqrA05dBhmNvnjZ4WLI7h5cELqNrPAtGpguRkp1v8H12h90gbHIzKEuI5+4wiD/5l
         k4vAdsJAvygaD/8Pz3sAjF9MZJVT81iMIPB2zuFry5zXvkkiu2OsmAtO9yhIGBZWq1rx
         JDSqGHEPhRcz2DZQKWxOQu23SqW1oWMGeerueJc+/U0Re6Cp3wvwLPzxhfk5Fe8w1ZxG
         pTHA==
X-Gm-Message-State: AOAM53206V03rAKsUQlTSWBtHzhy4e+XYubJrefwgLIA9mvRh8SVboN/
        iDfzhpppkpvJMFkz+0NOai4/GA==
X-Google-Smtp-Source: ABdhPJwSIGoGMoYqh7BO/6yTHOnstNyNB842j06yL1OCf7s5uOAGBDuuLE5nNs6cULv8A6+iw+NiNA==
X-Received: by 2002:adf:f3d2:: with SMTP id g18mr1440994wrp.367.1603788456978;
        Tue, 27 Oct 2020 01:47:36 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451? ([2a01:e34:ed2f:f020:6cbc:1a3:aabd:d451])
        by smtp.googlemail.com with ESMTPSA id m4sm1187778wrr.47.2020.10.27.01.47.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 01:47:36 -0700 (PDT)
Subject: Re: [Resend][PATCH] drivers/thermal: optimize the for circle to run a
 bit fast
To:     Bernard <bernard@vivo.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Amit Kucheria <amitk@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <ALoAaQDvDY5SjUaRtOCYw4ro.3.1603761577319.Hmail.bernard@vivo.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <bb585318-cdf8-e220-30bb-427239da0a5a@linaro.org>
Date:   Tue, 27 Oct 2020 09:47:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ALoAaQDvDY5SjUaRtOCYw4ro.3.1603761577319.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 27/10/2020 02:19, Bernard wrote:
> 
> From: Daniel Lezcano <daniel.lezcano@linaro.org>
> Date: 2020-10-27 02:35:18
> To:  Bernard <bernard@vivo.com>,Zhang Rui <rui.zhang@intel.com>,Amit Kucheria <amitk@kernel.org>,linux-pm@vger.kernel.org,linux-kernel@vger.kernel.org
> Cc:  opensource.kernel@vivo.com
> Subject: Re: [Resend][PATCH] drivers/thermal: optimize the for circle to run a bit fast>On 26/10/2020 02:49, Bernard wrote:
>>> Function thermal_zone_device_register, in the for circle, if the
>>> first if branch set the count bit in tz->trips_disabled, there is
>>> no need to set in the other if branch again.
>>> This change is to make the code run a bit fast and readable.
>>>
>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>>> ---
>>>  drivers/thermal/thermal_core.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
>>> index c6d74bc1c90b..03577794eea3 100644
>>> --- a/drivers/thermal/thermal_core.c
>>> +++ b/drivers/thermal/thermal_core.c
>>> @@ -1446,10 +1446,14 @@ thermal_zone_device_register(const char *type, int trips, int mask,
>>>  		goto release_device;
>>>  
>>>  	for (count = 0; count < trips; count++) {
>>> -		if (tz->ops->get_trip_type(tz, count, &trip_type))
>>> +		if (tz->ops->get_trip_type(tz, count, &trip_type)) {
>>>  			set_bit(count, &tz->trips_disabled);
>>> -		if (tz->ops->get_trip_temp(tz, count, &trip_temp))
>>> +			continue;
>>> +		}
>>> +		if (tz->ops->get_trip_temp(tz, count, &trip_temp)) {
>>>  			set_bit(count, &tz->trips_disabled);
>>> +			continue;
>>> +		}
>>>  		/* Check for bogus trip points */
>>>  		if (trip_temp == 0)
>>>  			set_bit(count, &tz->trips_disabled);
>>
>>
>> What about ?
>> 	if (tz->ops->get_trip_type(tz, count, &trip_type) ||
>> 		tz->ops->get_trip_temp(tz, count, &trip_temp) ||
>> 		!trip_temp)
>> 		set_bit(count, &tz->trips_disabled);
>>
> 
> Hi
> 
>   Sure, I will resubmit this patch, thanks!

Please, take the opportunity to fix the author name to be the same as
the signed-off-by.

Thanks

  -- Daniel



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
