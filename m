Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEA23FCA5D
	for <lists+linux-pm@lfdr.de>; Tue, 31 Aug 2021 16:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238333AbhHaOx2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 31 Aug 2021 10:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbhHaOxY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 31 Aug 2021 10:53:24 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D9BC061575
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 07:52:29 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id b4so9109233qtx.0
        for <linux-pm@vger.kernel.org>; Tue, 31 Aug 2021 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=16AnZsBkJuexPiViN7nj+Gw8aypGSfWNEZGs1nXo6RI=;
        b=L5BD4pYz0fEMo67TuWH1MBOTFdnKdme6R6s8/ggWGEev72wBIfzIg4IkPEWb7Omu7F
         65UYUcQ527kpae3Ag8qvqoXegA/QU8yOp29rnW5r1fDfogDhvkyOGtm83sJSDqalAzFg
         SWQICf+lyt9sNjl4qF9jYWsj9kZJbLY63Y2HS/Gkw0BQXnosolRTyVXWiaLXsO5r15W9
         1W7tprJcSkyfYNpzSCo3kF/pi7TzplSAxbGMBxA+jpbanCdnM+Zaeh88oi5f2zEL0uDN
         b81GM3QrM5UOnHbyxgZD6DpCaB0r5BJSxtFLFItUwzL9ESn2RTggGde4hbhzx1UPVHvB
         4bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=16AnZsBkJuexPiViN7nj+Gw8aypGSfWNEZGs1nXo6RI=;
        b=WbT987p4kq8QHwjybfHJ6IY13b6IkMRDpCMryByx9PFLpqyErZ7DEpALim5FE0pL7A
         O9ic25E2JWIQwhdVc2tNQp35oAuIAZ6hhcSDEHdphnVAzkXhrTwdJTGAcMxuesoOn7vs
         +E1ij+3CMshYzvKqOU4Zg3NqR4OcT5pi4dDs8GH+Tt9JcRylo/PZzm6hVvz6tob3ScGp
         jhqrgtUDf3DiC82v3ibx5KOjVMJv/4BdZXLE0NWsId203j7kHsT8m63Ghb6kLmv75Oe4
         ce1bsJp+yTgznnuGvY/2QB+FR7afZHnRmxSA4MZZdVaPhvxNu9Xt8Tlx7/RibCoROjQQ
         Prnw==
X-Gm-Message-State: AOAM5309mzBP8StqBodFZgeCKpHNOhMAl1iNXjIbrVmh6snEX02icXvM
        I8osMMVfLgwuAgVCoznneBdb3g==
X-Google-Smtp-Source: ABdhPJxJsjOI6usqxmwJ3yXpmCcHvIibzi3UynlO47wUSDrTp5AuNEIAufTh7U3gtaifTI0kQhAKTw==
X-Received: by 2002:ac8:6054:: with SMTP id k20mr3060953qtm.237.1630421548372;
        Tue, 31 Aug 2021 07:52:28 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id c28sm14263873qkl.69.2021.08.31.07.52.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Aug 2021 07:52:27 -0700 (PDT)
Subject: Re: [Patch v5 2/6] thermal: qcom: Add support for LMh driver
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     agross@kernel.org, rui.zhang@intel.com, viresh.kumar@linaro.org,
        rjw@rjwysocki.net, robh+dt@kernel.org, steev@kali.org,
        tdas@codeaurora.org, mka@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20210809191605.3742979-1-thara.gopinath@linaro.org>
 <20210809191605.3742979-3-thara.gopinath@linaro.org>
 <fcbb6d64-7e39-7f03-e76c-512946124777@linaro.org> <YSO5Njg3DXo64InF@ripper>
 <a216c89d-6cd5-326d-f203-f48caaf2a096@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <299e2a59-ae4e-278d-200d-630f055c1411@linaro.org>
Date:   Tue, 31 Aug 2021 10:52:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <a216c89d-6cd5-326d-f203-f48caaf2a096@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 8/23/21 11:57 AM, Daniel Lezcano wrote:
> 
> Hi Bjorn,
> 
> On 23/08/2021 17:05, Bjorn Andersson wrote:
>> On Sat 21 Aug 02:41 PDT 2021, Daniel Lezcano wrote:
>>
>>>
>>> Hi Thara,
>>>
>>> On 09/08/2021 21:16, Thara Gopinath wrote:
>>>> Driver enabling various pieces of Limits Management Hardware(LMh) for cpu
>>>> cluster0 and cpu cluster1 namely kick starting monitoring of temperature,
>>>> current, battery current violations, enabling reliability algorithm and
>>>> setting up various temperature limits.
>>>>
>>>> The following has been explained in the cover letter. I am including this
>>>> here so that this remains in the commit message as well.
>>>>
>>>> LMh is a hardware infrastructure on some Qualcomm SoCs that can enforce
>>>> temperature and current limits as programmed by software for certain IPs
>>>> like CPU. On many newer LMh is configured by firmware/TZ and no programming
>>>> is needed from the kernel side. But on certain SoCs like sdm845 the
>>>> firmware does not do a complete programming of the h/w. On such soc's
>>>> kernel software has to explicitly set up the temperature limits and turn on
>>>> various monitoring and enforcing algorithms on the hardware.
>>>>
>>>> Tested-by: Steev Klimaszewski <steev@kali.org> # Lenovo Yoga C630
>>>> Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
>>>
>>> Is it possible to have an option to disable/enable the LMh driver at
>>> runtime, for instance with a module parameter ?
>>>
>>
>> Are you referring to being able to disable the hardware throttling, or
>> the driver's changes to thermal pressure?
> 
> The former.

Hi Daniel,

It is not recommended to turn off LMh once enabled. From h/w point of 
view, it can be done for debug purposes but it is not to be implemented 
as a feature.


> 
>> I'm not aware of any way to disable the hardware. I do remember that
>> there was some experiments done (with a hacked up boot chain) early on
>> and iirc it was concluded that it's not a good idea.
> 
> My objective was to test the board with the thermal framework handling
> the mitigation instead of the hardware.
> 
> I guess I can set the hardware temperature higher than the thermal zone
> temperature.

Right. Also remember that  patch 5 in this series removes the cooling 
devices for the cpu thermal zones. So if you are testing this you will 
have to add them back.

> 
> On which sensor the lmh does refer to ? The cluster one ?
> 
> (by the way the thermal zone temperatures per core are lower by 5°C than
> the hardware mitigation ? is it done on purpose ?)


So IIUC, it refers to tsens for individual cpus and collates the input. 
But the documentation is not clear on this one. I took the mitigation 
temperature from downstream code. Yes I did realize that the thermal 
zone trip1 temp is 90 degree where as the LMh mitigation point is 95 
degree. My thinking is this is because the h/w mitigation can happen 
faster than s/w and hence the 5 degree bump up in temperature.

> 
>> Either way, if there is a way and there is a use for it, we can always
>> add such parameter incrementally. So I suggest that we merge this as is.
> 
> Yes, that was for my information. It is already merged.

Thank you very much

> 
> Thanks
> 
>    -- Daniel
> 

-- 
Warm Regards
Thara (She/Her/Hers)
