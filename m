Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FEC5F4555
	for <lists+linux-pm@lfdr.de>; Tue,  4 Oct 2022 16:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbiJDOVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 4 Oct 2022 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiJDOVY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 4 Oct 2022 10:21:24 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC924476CB
        for <linux-pm@vger.kernel.org>; Tue,  4 Oct 2022 07:21:15 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id n12so1973555wrp.10
        for <linux-pm@vger.kernel.org>; Tue, 04 Oct 2022 07:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBIFBYTL7bMXiKCqbN4v2KD/O06MsmUI5Kr5v5gQFes=;
        b=hfmhyOmo176w9X7w+jZ5ldnct3FC2G6CRaFpfD1eZTVDiNxg9OTEWDPb3SCZnSMAfq
         nrMDXTsKfbgaL67TN09f18QQI/ndXWz430x9nZcuetrlfTvgGLAHcW44mmPofZwyElJb
         IUtvPC3uJP381g9Qa6qDogdbD564rDou0fogsVgJ3/VakGFREZjv1XrH79mwxiNqjVYX
         ZNUmPn7VsIXRoqvvqc/+i/x/eANmFv/RBLfx2kbTEetUBOedO2szuY/a8tRc9WqsWdIu
         ooqxUGPTAxxEuS0OO3BYcTuk1sZBgoD6n2BPuhURaZULus1PQMScGBVe85qRy1gjwnlG
         JRow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EBIFBYTL7bMXiKCqbN4v2KD/O06MsmUI5Kr5v5gQFes=;
        b=ftJUqXAFri+r/mVSnzoQDnAT4QBm9ndBge7gHoa69zCHjPrJ+QFg3Be6i8pRpPItgH
         gFTNt+1ymC3uMuj5nyySYV8jqGcbS5oSJ1IrPsTMfdxHsbR1fKEulO96fQa8TUXFn1fe
         tGrxe132xlRGnrjRVrM4r7kn+1vaiwE17aj/+sLf+p/R34NuvyrupmLDWxLwIZn03Uer
         PQzATl3wggs4H/oDIl+mKmxvhKrdACv6eWXPc2tTbR+FZUMx2eqrcdtSgYz3LYLiliR6
         pS54rWTkZSK8bhg60zM5jK2vUn7xJf7EmDUcGpfUkfHw8714jKK5Dn4fWOe6iLxnlTsq
         Wd0g==
X-Gm-Message-State: ACrzQf0OPWqAQlqvRbCF3N5hjjYrtDI8+EAlmmXUjRPGwmQc1NOnJ13x
        8AE+8ryrLZDPD1AXt6pzPA4htg==
X-Google-Smtp-Source: AMsMyM6Bbl5ITWlROk+xrtXQIPJkhHBut7dQpx6fCi9oxlSDeXsuQ9bhFGeba1NDhk/78I4Fp44Ekw==
X-Received: by 2002:a05:6000:682:b0:22e:2d5f:ba9e with SMTP id bo2-20020a056000068200b0022e2d5fba9emr9735694wrb.226.1664893273994;
        Tue, 04 Oct 2022 07:21:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:c456:8337:99aa:2667? ([2a05:6e02:1041:c10:c456:8337:99aa:2667])
        by smtp.googlemail.com with ESMTPSA id v13-20020a05600c214d00b003b505d26776sm18956957wml.5.2022.10.04.07.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 07:21:13 -0700 (PDT)
Message-ID: <317e3cf1-2e20-d5ec-1bdc-f8537a8231d1@linaro.org>
Date:   Tue, 4 Oct 2022 16:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] thermal/core: Move the thermal zone lock out of the
 governors
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     rafael@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Lukasz Luba <lukasz.luba@arm.com>
References: <20220805153834.2510142-1-daniel.lezcano@linaro.org>
 <20220805153834.2510142-4-daniel.lezcano@linaro.org>
 <20221004141454.GA1746997@roeck-us.net>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20221004141454.GA1746997@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/10/2022 16:14, Guenter Roeck wrote:
> On Fri, Aug 05, 2022 at 05:38:33PM +0200, Daniel Lezcano wrote:
>> All the governors throttling ops are taking/releasing the lock at the
>> beginning and the end of the function.
>>
>> We can move the mutex to the throttling call site instead.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/gov_bang_bang.c       |  4 +---
>>   drivers/thermal/gov_fair_share.c      |  4 +---
>>   drivers/thermal/gov_power_allocator.c | 16 ++++++----------
>>   drivers/thermal/gov_step_wise.c       |  4 +---
>>   drivers/thermal/thermal_core.c        |  2 ++
> 
> This doesn't drop the lock from drivers/thermal/gov_user_space.c.
> Is that on purpose ?

No, it is an oversight. It was fixed after by Rafael

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
