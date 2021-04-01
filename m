Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB6E350FB2
	for <lists+linux-pm@lfdr.de>; Thu,  1 Apr 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhDAHBz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 1 Apr 2021 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbhDAHBW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Apr 2021 03:01:22 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1AC061788
        for <linux-pm@vger.kernel.org>; Thu,  1 Apr 2021 00:01:11 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id j7so705045wrd.1
        for <linux-pm@vger.kernel.org>; Thu, 01 Apr 2021 00:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XxW6GzMrN0Or1bqQ0qn35Sh1DN+NPsw4YzuK1fkqU8M=;
        b=uSQ7twNO8Hh+u3wc9cVoL6ADPfa0uu3xna/Rh02Bf4Xywxvm6b4/6ZcIsCYmavIpaf
         TzINuLiCIvRmI2dChUtfxEBkfTgKEQKirov5pdFW/mfNvhdjBi+AnErb5VWiYXv01oyP
         lwejUKPKVkTDm4gqFXsRIegotWDpYx30b15wDd3J6FhX2RLnCic+5D7/6YepP5HChbvM
         S/y87wVx9GDxyiVnooPP+bu0oMV2YNrhSLEb6WF34JJ/zEAcVEXalpdDQ8zwpDNNEqyH
         7SzZdUmb3esYYDYZXdEO3Eay2osuh9v3KoiyR3oUmlD2EiLBFLXJ5UDs+2Ho5TxxZWtj
         0zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XxW6GzMrN0Or1bqQ0qn35Sh1DN+NPsw4YzuK1fkqU8M=;
        b=U/G9WKzlYy0Yxwt0J/iuR9FAFps8AtrGGhiSEJNHX2idnDTKaEqqNIou9ke19V4gmL
         OusDkZ0PXBEJd9/erNTWnPNpqoQ0Z0pysqfn2I/MuTPE2weBSarxxJbihYryNZ0KNZ30
         VNMz5XDrQJPYHGFsMk8XhjJg28gzkle8Zp3R6Fmow5wccEr0lNE8RMkXZDVyYItkjQnG
         Qgrav4ulOLJxD4s1S81JHDqinQImNuPEAgHYDP0B2jOIYt6ds1NJ30SNN6TnGzvKFsPO
         ZpAUGAdR2xiN/mZLHJ9laSEasHy1aOsXmSNDDiIObYv2SjdXqA4v+slC5t6q0fhWBYni
         Qo2A==
X-Gm-Message-State: AOAM5302aoWeNH31EY6g3xEPj5pqSB71kaM1Zpfzfx9Xpf1RmqUJiqy0
        dgiGWeHjUiNqH3hazgiraAbVsTlSqqjCzg==
X-Google-Smtp-Source: ABdhPJy4uwdCMh0heaa9ytrLR5P9/OzE4GjRaqDhpvlvNXJefDqYnWYoYL84Y4/RNP5KHUjSRPM/iA==
X-Received: by 2002:a05:6000:223:: with SMTP id l3mr7811596wrz.5.1617260470516;
        Thu, 01 Apr 2021 00:01:10 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1573:1dd5:899d:6362? ([2a01:e34:ed2f:f020:1573:1dd5:899d:6362])
        by smtp.googlemail.com with ESMTPSA id c8sm6894817wmb.34.2021.04.01.00.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 00:01:10 -0700 (PDT)
Subject: Re: [PATCH v5 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, rafael@kernel.org
References: <20210331110048.24956-1-daniel.lezcano@linaro.org>
 <20210331110048.24956-2-daniel.lezcano@linaro.org>
 <YGS6NraFr6+qvzda@kroah.com>
 <918bc42d-0bd7-753c-1132-fd19617349ed@linaro.org>
 <YGVh9onNL7hVu2mr@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <fb8d7551-b8b8-22fc-63ad-768adb14b3e1@linaro.org>
Date:   Thu, 1 Apr 2021 09:01:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGVh9onNL7hVu2mr@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 01/04/2021 08:02, Greg KH wrote:
> On Wed, Mar 31, 2021 at 10:46:48PM +0200, Daniel Lezcano wrote:
>>
>> Hi Greg,
>>
>> On 31/03/2021 20:06, Greg KH wrote:
>>> On Wed, Mar 31, 2021 at 01:00:45PM +0200, Daniel Lezcano wrote:
>>>> +struct dtpm *dtpm_lookup(const char *name);
>>>> +
>>>> +int dtpm_add(const char *name, struct dtpm *dtpm);
>>>> +
>>>> +void dtpm_del(const char *name);
>>>
>>> You can not add new kernel apis that have no user.  How do you know if
>>> they actually work or not?  We have no idea as we do not see anyone
>>> using them :(
>>>
>>> So no need to add things with no user, feel free to just drop this patch
>>> until you have one.
>>
>> I've sent a couple of patches [1] on top of the previous series. I'm
>> finishing to respin it against this new one.
>>
>>   -- Daniel
>>
>> [1] https://lkml.org/lkml/2021/3/12/1514
> 
> Please use lore.kernel.org, we do not control lkml and it has been down
> in the past and it's impossible to reply from.
> 
> Please always provide a user of a function in the patch series,
> otherwise you will end up with comments like mine above.

Ok, will do.

Thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
