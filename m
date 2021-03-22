Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23118343632
	for <lists+linux-pm@lfdr.de>; Mon, 22 Mar 2021 02:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVBTA (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 21 Mar 2021 21:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhCVBSx (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 21 Mar 2021 21:18:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C0C061574
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 18:18:53 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id j7so11243751qtx.5
        for <linux-pm@vger.kernel.org>; Sun, 21 Mar 2021 18:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WX7meLomAM66/Gdx6mzxfG43j5efQ9y05sRG2ciIlw8=;
        b=Mh7Qm7HX9VCSUrdMMnkO8kTTrd7P/1I2mutuVRzkm3ZDDWkAcLQ4HZiW9faaaZki5a
         HcFxT4eDYQ86ir0iTPJDHWS44QGiBbfQS76AaBiJ6sGUflPLXJjxD2A+EBwRRD/6w4Ov
         +IK9XDKTkhxOHgnZ72XOQfjoj5tL/Ahz58C6vMTP5X6bBLGiohh31r4RqiPiOVYg8o1m
         GHF8O70u1/TBZ0poHYXTZ1IHmNd+X0vo6ZEax9vBMZspDejstzpgdleHuSsvVEEi9bVK
         WJm9Twhsk035VrkKrLaICybEx1xcdEcY21HFE1zcli0kBH11XywMbyEO7VsasDTtRXQo
         XoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WX7meLomAM66/Gdx6mzxfG43j5efQ9y05sRG2ciIlw8=;
        b=ACJ1Ce8UF1y0CnP+672KSLO6U0JoRI00/I77maxw7oOotG35ACZ2v9hnOq5Q+ibbbE
         Hdi2Ta65gAUVz/lTYRMP7oW8JpBwCyfLTQwdvuFGN5hR7QoAH3xeNuQMRIfg01n2I5sc
         PH2PtD5OaGsGwzyFMRj2IMWO5e6i+0M7D7k0NPm9J5MrI7QattyT1F1+ShUDfwAkhUpo
         PYg8sb468u29fKrzGyL1GZ41wU+cv8q3eDGqsnIp9wMSYbgOpQv8ewqKx1JgLoLAAEaV
         tkKvNMp7mv/CgAHPd0WnahRDccip1u8tLSKRtjrNDFDG8SDHqlgBlq0Q5cPtj1MCV7dC
         KhKA==
X-Gm-Message-State: AOAM530oBwv9MUyzLNdMR7XpDUMaQMFudew9WArs+0ac6SF/78LpAFZd
        ZKnQuZAD20qDaxt2cXPXdH+J5adPJLvgPQ==
X-Google-Smtp-Source: ABdhPJyc8ijpM2PDXebcI0ld2C9OqLM86XBfNXXG5jvjnaEeSHCYAjBFo14M1jGwMbCS7XAFrGNDKQ==
X-Received: by 2002:a05:622a:446:: with SMTP id o6mr7645846qtx.257.1616375932341;
        Sun, 21 Mar 2021 18:18:52 -0700 (PDT)
Received: from [192.168.1.93] (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.gmail.com with ESMTPSA id 84sm10235194qkg.8.2021.03.21.18.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Mar 2021 18:18:51 -0700 (PDT)
Subject: Re: [bug report] drivers: thermal: tsens: Merge tsens-8974 into
 tsens-v0_1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        amit.kucheria@linaro.org
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, linux-pm@vger.kernel.org
References: <20190514090635.GA21833@mwanda> <20200713114454.GR2571@kadam>
 <44dab74b-eb4d-04b8-c800-c1471ac6adfc@linaro.org>
From:   Thara Gopinath <thara.gopinath@linaro.org>
Message-ID: <eeadd133-0612-90d8-0357-fd7d31439d95@linaro.org>
Date:   Sun, 21 Mar 2021 21:18:51 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <44dab74b-eb4d-04b8-c800-c1471ac6adfc@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org



On 3/19/21 3:50 PM, Daniel Lezcano wrote:
> On 13/07/2020 13:44, Dan Carpenter wrote:
>> Did we ever look into this?
> 
> Thara,
> 
> is it possible to have a look at this bug report?

Sure! In a few weeks..


> 
> Thanks
> 
>    -- Daniel
> 
>> regards,
>> dan carpenter
>>
>> On Tue, May 14, 2019 at 12:06:35PM +0300, Dan Carpenter wrote:
>>> Hello Amit Kucheria,
>>>
>>> The patch c80cbb79e851: "drivers: thermal: tsens: Merge tsens-8974
>>> into tsens-v0_1" from Mar 20, 2019, leads to the following static
>>> checker warning:
>>>
>>> 	drivers/thermal/qcom/tsens-v0_1.c:237 calibrate_8974()
>>> 	warn: mask and shift to zero
>>>
>>> drivers/thermal/qcom/tsens-v0_1.c
>>>     226                  case ONE_PT_CALIB:
>>>     227                  case ONE_PT_CALIB2:
>>>     228                          base1 = bkp[0] & BASE1_MASK;
>>>     229                          p1[0] = (bkp[0] & S0_P1_MASK) >> S0_P1_SHIFT;
>>>     230                          p1[1] = (bkp[0] & S1_P1_MASK) >> S1_P1_SHIFT;
>>>     231                          p1[2] = (bkp[0] & S2_P1_MASK) >> S2_P1_SHIFT;
>>>     232                          p1[3] = (bkp[0] & S3_P1_MASK) >> S3_P1_SHIFT;
>>>     233                          p1[4] = (bkp[1] & S4_P1_MASK);
>>>     234                          p1[5] = (bkp[1] & S5_P1_MASK) >> S5_P1_SHIFT;
>>>     235                          p1[6] = (bkp[1] & S6_P1_MASK) >> S6_P1_SHIFT;
>>>     236                          p1[7] = (bkp[1] & S7_P1_MASK) >> S7_P1_SHIFT;
>>>     237                          p1[8] = (bkp[2] & S8_P1_MASK_BKP) >> S8_P1_SHIFT;
>>>                                                    ^^^^^^^^^^^^^^     ^^^^^^^^^^^
>>> #define S8_P1_MASK_BKP          0x3f
>>> #define S8_P1_SHIFT 24
>>>
>>> Other places define S8_P1_SHIFT as 4, so that's maybe something to
>>> consider.
>>>
>>>     238                          p1[9] = (bkp[2] & S9_P1_MASK_BKP) >> S9_P1_BKP_SHIFT;
>>>     239                          p1[10] = (bkp[2] & S10_P1_MASK_BKP) >> S10_P1_BKP_SHIFT;
>>>     240                          break;
>>>     241                  }
>>>     242          } else {
>>>     243                  mode = (calib[1] & CAL_SEL_0_1) >> CAL_SEL_SHIFT;
>>>     244                  mode |= (calib[3] & CAL_SEL_2) >> CAL_SEL_SHIFT_2;
>>>
>>> regards,
>>> dan carpenter
> 
> 

-- 
Warm Regards
Thara
