Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221EF34BD24
	for <lists+linux-pm@lfdr.de>; Sun, 28 Mar 2021 18:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbhC1QHm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 28 Mar 2021 12:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhC1QHQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 28 Mar 2021 12:07:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86FC061762
        for <linux-pm@vger.kernel.org>; Sun, 28 Mar 2021 09:07:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a132-20020a1c668a0000b029010f141fe7c2so7319461wmc.0
        for <linux-pm@vger.kernel.org>; Sun, 28 Mar 2021 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gg1H/cycQVGjnxB5BUbRFDV5crvEsOoV1N9QyN86gMY=;
        b=taCQkPo8S23c++n4vqFLEkfJTN87PC2iLxCGhl+xi5OrUtglM1GvA6pVdiDX8NMxMJ
         PsiREcxmhjIQE0QQgXPjlOy/YLN0LZPj97TDVMr+k4erhXn6KeSVZrUC3piL25DrsTih
         RolM4/MqIZvhZX6uVACZ3XPpcO99G9Oz2bfdZ6opJvhpYNeERRWK/ibB/M8pbDNkATAA
         +lZBKDjqaC2FHAAwwebL0rAXDWwzycyRDJ7EmuSUNhU/U6miDPuKf24tkYNSJPurmRr9
         F+SGA4HgN7KJO193Eza46o4UhcJNM5X6hGfQzGDka28TB9qyxOjHaisVGlbsuuvgf7RS
         /EKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gg1H/cycQVGjnxB5BUbRFDV5crvEsOoV1N9QyN86gMY=;
        b=L6fIPzeTYUcCoMyLNahpmh3zOn8FcqVO4+whr3fmSwq5gAISuC+Sn39JuMqfOoP1f4
         vQ2X8ueIdgSKhctTFG/CSKDzdPL5lRDyvyZz0TP44Vxsd1AWdoVCGb2/kDgfB9xch+kj
         a187BV71YaGNwq/6h9Cf+HoNJl/PyT7vyxYN96+EIHOuHTA7pBo3wg3FEuA1rNmjX7fd
         +vqp90BnVWrDRWtQ8SRaXZTD9eKEOh5CI6VMlVgzrggAVSV5hd1aieRRDljrDEptHEmE
         tgQLQhJI4DB1NZxzXYDGf8U5XSa2xD8+2E0fQuglzFvqT8AvanH52JDwv5ysBJAfWIDw
         Mhog==
X-Gm-Message-State: AOAM530ibN6cvK6EkAVh38RELBXvLc6xXJvqEtUgq7DCMewOhkQk75cY
        cjNl/0qiRr1YU2tzeAOq71kI5A==
X-Google-Smtp-Source: ABdhPJwequDklrmlqZYb6yDLOIlqHW0cBuqfyat1xLSQIpbUmMKdLbkxfqeo6SlN9DxxGe1k/O70xA==
X-Received: by 2002:a1c:ddc6:: with SMTP id u189mr21794497wmg.171.1616947633940;
        Sun, 28 Mar 2021 09:07:13 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:1945:696f:a453:cac9? ([2a01:e34:ed2f:f020:1945:696f:a453:cac9])
        by smtp.googlemail.com with ESMTPSA id j9sm20505235wmi.24.2021.03.28.09.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 09:07:13 -0700 (PDT)
Subject: Re: [PATCH v4 2/5] powercap/drivers/dtpm: Create a registering system
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, lukasz.luba@arm.com
References: <20210312130411.29833-1-daniel.lezcano@linaro.org>
 <20210312130411.29833-2-daniel.lezcano@linaro.org>
 <YF8qIw4UBLnj9TCA@kroah.com>
 <433ec4ac-a7a9-ecf9-f1c1-f658d279a2df@linaro.org>
 <YGAnRx8SiZHFPpY6@kroah.com>
 <7df276d1-abea-622c-2c7e-2c5e412aa4a9@linaro.org>
 <YGBng8D+nPS4/LJO@kroah.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7ba5094b-7fac-72ff-0e52-6f60eb86f253@linaro.org>
Date:   Sun, 28 Mar 2021 18:07:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YGBng8D+nPS4/LJO@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 28/03/2021 13:24, Greg KH wrote:
> On Sun, Mar 28, 2021 at 01:11:30PM +0200, Daniel Lezcano wrote:
>>
>> Hi Greg,
>>
>> On 28/03/2021 08:50, Greg KH wrote:
>>
>> [ ... ]
>>
>>>>> And any reason why you are not using "real" struct devices in this
>>>>> subsystem?  You seem to be rolling your own infrastructure for no good
>>>>> reason.  I imagine you want sysfs support next, right?
>>>>
>>>> Actually, the framework is on top of powercap, so it has de facto the
>>>> sysfs support. On the other side, the dtpm backends are tied with the
>>>> device they manage.
>>>
>>> So why are they not a "real" device in the driver model?  It looks like
>>> you almost are wanting all of that functionality and are having to
>>> implement it "by hand" instead.
>>
>> I'm sorry I misunderstanding your point. dtpm is the backend for the
>> powercap subsystem which is the generic subsystem to do power limitation.
>>
>> We have:
>>
>> struct dtpm_cpu {
>> 	struct dtpm dtmp;
>> 	...
>> }
>>
>> struct dtpm {
>> 	struct powercap powecap;
>> };
>>
>> struct powercap {
>> 	struct device dev;
>> };
> 
> Oh nice.  So you can not use a kref here at all as you already have a
> reference counted device controling your structure.  You can not have 2
> references trying to control the same structure, that way lies madness
> and bugs :(
> 
> So why are you trying to add a kref here as the structure already has
> support for proper lifetimes?

Right, I'll revisit that part. Thanks for the review.

I've a branch which is pulled by Rafael [1]. These parts are already
merged in the dtpm/next branch but not yet in Rafael's tree.

I think a rebase is possible but I would like to avoid that. Would be a
patch on top of the dtpm/next acceptable given your flow with Android ?

  -- Daniel

[1]
https://git.kernel.org/pub/scm/linux/kernel/git/daniel.lezcano/linux.git/log/?h=dtpm/next

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
