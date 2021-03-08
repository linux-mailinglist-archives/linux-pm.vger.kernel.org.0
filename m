Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF4233194C
	for <lists+linux-pm@lfdr.de>; Mon,  8 Mar 2021 22:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbhCHVVB (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 8 Mar 2021 16:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhCHVUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 8 Mar 2021 16:20:45 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECD6C06175F
        for <linux-pm@vger.kernel.org>; Mon,  8 Mar 2021 13:20:45 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso4669246wmq.1
        for <linux-pm@vger.kernel.org>; Mon, 08 Mar 2021 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wu9oEK/xAOW3gNEBHL714OoOhpYk6t+OPca6LRUekWk=;
        b=l+N+aBZyBLQ84Xc2qonMKfPS7O2smDSRBs6+j/Tq2b3Ps9waqqMvbHOyDBtXY7n7n1
         h/7wW0CY7KT571n+Z4GG4Zyqv0isfcXDMwhXnbptQzeon+Ta6g1motpUHYUN3esxRyGt
         x6TMzBHcCdnqkAEGDvHJeikOnGZypc4Px8eOHjOW2iW5aYbdJbC3m+9JtZEPbDlkVv5A
         bNeqEg01ga04gIcbpSUfuH+h9xK9if5xYdqX8zwjb0JFOPKr2gfiUPCif1GMepnctB5C
         Aposko2oQsUOU5tEt6caJTYEAQ+CQ3y2nnJGP7L0BTwptJelxdjUrtOsJVlq5LO2fy/d
         3QXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wu9oEK/xAOW3gNEBHL714OoOhpYk6t+OPca6LRUekWk=;
        b=WVx+vhS8W/8WjCEtT1BKC2UgGK9z+yZRJ2b1+Kca84AyXCM15y/fWrWpofdzEWarkX
         NsZToyUBLDjTeO5plaGG9TtlUQwbJb4UIP+j3FDQiYXULRKXX/2iL5VqA10ZAWUVFi6h
         pe5JEuvRS1T/FvUXozaTAi+KKS+2qXSAqRxjRX9Z9kuP4I3t/NaapQGckIxJ7ZOMQdYS
         JIyWx4+QQ2lU9vfUEFIhAMJx4CHNGHXjwwCD4kK3XhZtQasRiXpfG9+WcQxk3+3yYkJ7
         Sfbu/DA2UHD5gFFmz757HqK4hMlZyK1cxHICvel2bZI/WwYX/CJanOW82ZelSQQdyJIN
         BtqQ==
X-Gm-Message-State: AOAM531AHWQVDSznF9eG/6HWzQB1Pb8C2CKokPpi2Jiv9WpRvkXI6nKL
        Kbz5zIJnHLmnT8RCaWANIU7ZKYfCasqcHQ==
X-Google-Smtp-Source: ABdhPJx4Cn7xkmyuZRQVCSGlOMwAkEiRCQzXKjWNe05h+eRzWC3kXIdu9sKh+xq62pqoDghjIdy2eA==
X-Received: by 2002:a7b:c2a9:: with SMTP id c9mr683024wmk.116.1615238444034;
        Mon, 08 Mar 2021 13:20:44 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:8499:4f69:106b:da0? ([2a01:e34:ed2f:f020:8499:4f69:106b:da0])
        by smtp.googlemail.com with ESMTPSA id k12sm15190906wrx.7.2021.03.08.13.20.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 13:20:43 -0800 (PST)
Subject: Re: [PATCH 1/5] powercap/drivers/dtpm: Encapsulate even more the code
To:     Lukasz Luba <lukasz.luba@arm.com>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210301212149.22877-1-daniel.lezcano@linaro.org>
 <f5a4be4d-b003-2751-7758-ef2c58e3fbbc@linaro.org>
 <2d5e7eff-ae9d-2c67-3f49-89cb006b4a1b@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <a6374a41-1e4b-e1f0-4c68-17dcae105f8b@linaro.org>
Date:   Mon, 8 Mar 2021 22:20:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <2d5e7eff-ae9d-2c67-3f49-89cb006b4a1b@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 08/03/2021 20:55, Lukasz Luba wrote:
> Hi Daniel,
> 
> On 3/8/21 7:31 PM, Daniel Lezcano wrote:
>>
>> On 01/03/2021 22:21, Daniel Lezcano wrote:
>>> In order to increase the self-encapsulation of the dtpm generic code,
>>> the following changes are adding a power update ops to the dtpm
>>> ops. That allows the generic code to call directly the dtpm backend
>>> function to update the power values.
>>>
>>> The power update function does compute the power characteristics when
>>> the function is invoked. In the case of the CPUs, the power
>>> consumption depends on the number of online CPUs. The online CPUs mask
>>> is not up to date at CPUHP_AP_ONLINE_DYN state in the tear down
>>> callback. That is the reason why the online / offline are at separate
>>> state. As there is already an existing state for DTPM, this one is
>>> only moved to the DEAD state, so there is no addition of new state
>>> with these changes.
>>>
>>> That simplifies the code for the next changes and results in a more
>>> self-encapsulated code.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Is there any comment on this series ?
> 
> If you can wait 1 day, I will review it tomorrow...

Sure, thanks

  -- Daniel


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
