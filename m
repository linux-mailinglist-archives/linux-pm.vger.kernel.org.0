Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179BF3AA423
	for <lists+linux-pm@lfdr.de>; Wed, 16 Jun 2021 21:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhFPTVJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 16 Jun 2021 15:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbhFPTVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jun 2021 15:21:08 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00511C061574
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:19:01 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id o39-20020a05600c5127b02901d23584fd9bso2012193wms.0
        for <linux-pm@vger.kernel.org>; Wed, 16 Jun 2021 12:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yjQYXquPSfp4MKH74/A3wiITHQsuloD60C8047bzcco=;
        b=hdrV2N4BWsFHvM8vnAmuajEAtGWPWDTU8Qf+Q8IswzH612u9iV+sn9Q4aJ+0gjrhgy
         ifCS7l0Jw/FoXdzvFCo/3rftJbRy8OAyk9zjJ+4ZbE5aI8IHCok5/TWSlDjhSqNn13B2
         wX2Ih0/3dN/1YK+lz84zTYY73ktW/C53ITF1SX9UB/cjgs/neQyv+ua2CotMsgAGcxiw
         0Nh/7m4s+lfT/bbDUJ8SrMJnJPgsFGysALidZ+DuSIQBG+ZIHKjs66qhqYpLYS7+WYEd
         MmqweEV7TNO57DpS99oby5ApZqHRPqXwSl76fXI7ZD3qHCFJa+P+u+IaVWB0xT4DG2ib
         Y3wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yjQYXquPSfp4MKH74/A3wiITHQsuloD60C8047bzcco=;
        b=Lv0GTkrx6rO/UjhmWlolgOwOOgowjM6XbW5Hx7kFc53bb44VgDN6Tt8TNzpyeHWS3H
         XNLgH+n4468fc8lwJmqmA2f4b9tl5ukrrtKajXzcCEaPQG7O8oacBwPgXmz5aVbhVub/
         JeSnvJuSB506iQEbnpI5WChyDF1bgjlskBMBr9Phc0z3GBAwBHZ3FsUQy+B1Mfdrc82L
         55WHKcPY4rGx+MVFMV0pem6dciPlIutjhFlubfepwuxYEva3FLZ+gC1Vaor4cIMMKazd
         owMi1X1x+eXAslXvPj1ltg1jiJeHxADcKa1aRiSNEPEc5N50eQqpnaBUyRqeuvRNEyUH
         FJkA==
X-Gm-Message-State: AOAM533Zh9E1r+9GdB9g7qu4irlkDb6K8wRPoAfqrl2pvWMFGFo51HoH
        2g/y8OeZLwiIeIKaN5mLizYY3g==
X-Google-Smtp-Source: ABdhPJxFgtVQdI5n9iwORw/50KziHniAznGliziCiHqWivbmq8GDfYByP0J94o0BJOOmjFfPk0GT/g==
X-Received: by 2002:a05:600c:204:: with SMTP id 4mr585639wmi.95.1623871140462;
        Wed, 16 Jun 2021 12:19:00 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:60a0:f51c:af6:2dab? ([2a01:e34:ed2f:f020:60a0:f51c:af6:2dab])
        by smtp.googlemail.com with ESMTPSA id p15sm2451112wmq.43.2021.06.16.12.18.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jun 2021 12:18:59 -0700 (PDT)
Subject: Re: [PATCH v1 2/5] soc/tegra: irq: Add stubs needed for compile
 testing
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org
References: <20210606222817.12388-1-digetx@gmail.com>
 <20210606222817.12388-3-digetx@gmail.com>
 <92b521c6-f3fd-4f2c-de4f-3363e0384f55@linaro.org>
 <cb9d8a40-a64f-e37f-1487-272b2c4ac9ea@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e1484aa5-392b-4ad5-4716-5937dd0e2be5@linaro.org>
Date:   Wed, 16 Jun 2021 21:18:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <cb9d8a40-a64f-e37f-1487-272b2c4ac9ea@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 16/06/2021 21:17, Dmitry Osipenko wrote:
> 16.06.2021 22:06, Daniel Lezcano пишет:
>> On 07/06/2021 00:28, Dmitry Osipenko wrote:
>>> Add stubs needed for compile-testing of tegra-cpuidle driver.
>>>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  include/soc/tegra/irq.h | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/soc/tegra/irq.h b/include/soc/tegra/irq.h
>>> index 8eb11a7109e4..94539551c8c1 100644
>>> --- a/include/soc/tegra/irq.h
>>> +++ b/include/soc/tegra/irq.h
>>> @@ -6,8 +6,15 @@
>>>  #ifndef __SOC_TEGRA_IRQ_H
>>>  #define __SOC_TEGRA_IRQ_H
>>>  
>>> -#if defined(CONFIG_ARM)
>>> +#include <linux/types.h>
>>> +
>>> +#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_TEGRA)
>>
>> Does not CONFIG_ARCH_TEGRA depends on CONFIG_ARM ?
>>
>>>  bool tegra_pending_sgi(void);
> 
> ARM and ARM64, only ARM32 variant builds tegra_pending_sgi().

Ah, I see, thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
