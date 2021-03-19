Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128BF34267E
	for <lists+linux-pm@lfdr.de>; Fri, 19 Mar 2021 20:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhCSTvQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 19 Mar 2021 15:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhCSTuw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 Mar 2021 15:50:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB32C06175F
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 12:50:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 12so6050114wmf.5
        for <linux-pm@vger.kernel.org>; Fri, 19 Mar 2021 12:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SIG/oeaheQf2RId7wNZ0IHpB5oAGz2xYHIdZLF5AREY=;
        b=OwNI0Xo2GExgCdX4OhQ96/2J9OLrs4ysS6hwdQwAW67WfcabCbKQ03p2EyuaCAhNxv
         49N3qxWcQkwpdUkErhZNLIIkd9ldMkZrlU5KFo1jd7N6pVkQDqqBrO2mgJf7M4mx6FRz
         64AaVk77xzOPm+TfqddHfEmHKbkZ+m822TCKZJ6fjObPtlO2aAUQ/BLEsOCd6w15BioP
         X+HWKS5whEJ83L6RIX1iPpWORbIC3awS6qzohBu1F+JsmQ8/UOp5nQenFbmI6h6cfElz
         qEq/5SK/tART4nK7ssXAkSMikM/prmVN24cmQWY3SFzZdeCf+hCgEfsmWl6UNYMsqZLD
         HWpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SIG/oeaheQf2RId7wNZ0IHpB5oAGz2xYHIdZLF5AREY=;
        b=KEYiPII7lR+oVPNzYZGgRCf9zzbMXDOXaXpUBj2JNHpG8ZcrOtI3jJXjkwPimfiiQU
         R/Qt6dk1VRUa85wjesjvdMWnl+80D1sN/iEHp+Umgkl+AA/Dc+uzrflMuclvQ+Tn5SwB
         tZfzm906f30eLYorPY6a8ahhJ5ytzqeYx9qgQN3b4a0qJ6Anq+wzaDwfwV3KhsICWOex
         Q5rTZczYeUZW3wmtamFXayrqbQGC1akcLUGbXwNguY8Qz0C5kFKs9E1YkM256sfUmD0Q
         DQL+vHPWH2eeIRhWA2P7uzFaBEfFa7A785StNrNtu8FgZZcNUD6BlfzEeFLDPWpGlZCQ
         KrvA==
X-Gm-Message-State: AOAM530kMvrhzjm9rH5wGIHiMSMOlAUDi0G0tr3xUPm/FILPqMVLwzBu
        btKmt08sWCsPElviD5/azaSyAQ==
X-Google-Smtp-Source: ABdhPJwefTZKFom1qu8f13r6YV4bqflGFWavA7uF2YjxOx0WJC3fv3FOKMSaOcz2sFsXadiQrbCvog==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr5198371wmh.144.1616183450257;
        Fri, 19 Mar 2021 12:50:50 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85? ([2a01:e34:ed2f:f020:ddd7:1eb:a66:7a85])
        by smtp.googlemail.com with ESMTPSA id j26sm9357777wrh.57.2021.03.19.12.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Mar 2021 12:50:49 -0700 (PDT)
Subject: Re: [bug report] drivers: thermal: tsens: Merge tsens-8974 into
 tsens-v0_1
To:     amit.kucheria@linaro.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org,
        Thara Gopinath <thara.gopinath@linaro.org>
References: <20190514090635.GA21833@mwanda> <20200713114454.GR2571@kadam>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <44dab74b-eb4d-04b8-c800-c1471ac6adfc@linaro.org>
Date:   Fri, 19 Mar 2021 20:50:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713114454.GR2571@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 13/07/2020 13:44, Dan Carpenter wrote:
> Did we ever look into this?

Thara,

is it possible to have a look at this bug report?

Thanks

  -- Daniel

> regards,
> dan carpenter
>
> On Tue, May 14, 2019 at 12:06:35PM +0300, Dan Carpenter wrote:
>> Hello Amit Kucheria,
>>
>> The patch c80cbb79e851: "drivers: thermal: tsens: Merge tsens-8974
>> into tsens-v0_1" from Mar 20, 2019, leads to the following static
>> checker warning:
>>
>> 	drivers/thermal/qcom/tsens-v0_1.c:237 calibrate_8974()
>> 	warn: mask and shift to zero
>>
>> drivers/thermal/qcom/tsens-v0_1.c
>>    226                  case ONE_PT_CALIB:
>>    227                  case ONE_PT_CALIB2:
>>    228                          base1 = bkp[0] & BASE1_MASK;
>>    229                          p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
>>    230                          p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
>>    231                          p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
>>    232                          p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
>>    233                          p1[4] = (bkp[1] & S4_P1_MASK);
>>    234                          p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
>>    235                          p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
>>    236                          p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
>>    237                          p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
>>                                                   ^^^^^^^^^^^^^^     ^^^^^^^^^^^
>> #define S8_P1_MASK_BKP          0x3f
>> #define S8_P1_SHIFT 24
>>
>> Other places define S8_P1_SHIFT as 4, so that's maybe something to
>> consider.
>>
>>    238                          p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
>>    239                          p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
>>    240                          break;
>>    241                  }
>>    242          } else {
>>    243                  mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
>>    244                  mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
>>
>> regards,
>> dan carpenter


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
