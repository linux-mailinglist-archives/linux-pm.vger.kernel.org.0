Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6E99365798
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 13:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbhDTLd3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 07:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhDTLd2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 07:33:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ABCC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 04:32:54 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k26so20813794wrc.8
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 04:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2pB+5dp9tOe3/dQfTfQajQflD5Wxu+BkUEq3uAg1PfQ=;
        b=ph5SBtuyq81FoMcmjUEeWTKFwwnAlcefH5oEpymATxD8zX9ELEMr7M0PAz2JEc8466
         i84A9Qgv80DO55uznNOlnLhI2Mc/dKGY7aRNdki4qreeio9TJn0RObTHM7ueCeBUUij6
         CMGYR9BmQXsWhmzhlcn+8FWWOEAsJFRHniP9Ox9STMaOpYaUl/mMDOEJ4micwElgAKr4
         ys44priunaBvffyn9dpWmNU8zoGhrCIeWB8ezcIt4tVE/B3iWrCEmuCm1nLU7rql6EhC
         Nn/71eha/Smn8yGnxGakkZJLgEQ5bGt2WFWOA5+m2mZXKMO447NJkPKJhZCLvwwjxUnx
         11Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2pB+5dp9tOe3/dQfTfQajQflD5Wxu+BkUEq3uAg1PfQ=;
        b=SBsCUoRCJXeL9ZnaNQmi1JK2pbjsQ4K8laLf/i/TMOEF60c8ufU/FS/TuVNu5mU3ex
         jdPDuJ5EtRsIpA8lSmBybLkXBw1qLF1L8zpWxmXqsqU2Y1AfNsQRbOkJPTMqTQKWclch
         eMYVqryeJ49Sn5mnMpkxC6e9rfkYG/7Lh6IyDWoaBUakn7sj3QbAEvDdLo/MLaqwkmoO
         PuitPgO3+ly7K38n2BQA1afBma2c4MbqUU/4oN5pKrDasnuNNIRRGIB2xgw7CFXkSU87
         /Ap4dD0E0e6If7DOCW76VyiEODwLYsYL0yWwSSPywHvvFAlRVstJP1FxsiyhEV9CJqx7
         Qv+g==
X-Gm-Message-State: AOAM53334a/5b2+MjQIrCDgacT65NcwCQuPxp94YuZY3x5Uqe4O87TNV
        p5RBu5k+VoGFIQWJTTr4T1ujNQ==
X-Google-Smtp-Source: ABdhPJzHR+pXLyFtnHnqdzNOqKATo+m3eHymmTvVFNfNhvTk+j4hOP6tNW/jSyJBKhuXVh1l3v3fEg==
X-Received: by 2002:a05:6000:1816:: with SMTP id m22mr20421266wrh.260.1618918372649;
        Tue, 20 Apr 2021 04:32:52 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id n18sm20815825wrw.11.2021.04.20.04.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 04:32:52 -0700 (PDT)
Subject: Re: [thermal: thermal/next] thermal/drivers/tsens: Convert msm8960 to
 reg_field
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        thermal-bot for Ansuel Smith <tip-bot2@linutronix.de>,
        "open list:QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096" 
        <linux-pm@vger.kernel.org>, kbuild-all@lists.01.org,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <161848823868.29796.2378720492280917598.tip-bot2@tip-bot2>
 <202104160110.kPF71m4S-lkp@intel.com>
 <CA+_ehUzAhPhqn62ivcxF+giMUy430eija7_sOSoNmC=291wq-g@mail.gmail.com>
 <4187051b-4dcf-88e0-ac3d-fb47ff42e3ef@linaro.org>
 <CA+_ehUziRf7Ls8PByz-9_L8SKB26+yRY-MrZK_26GqdycCkNhg@mail.gmail.com>
 <7019d902-885f-d9ea-e24d-64ee8dd5aa0e@linaro.org>
 <CA+_ehUwzYLU5W0452Lvryb41w=-U_SgwGBePVhQA-3UBBZUOig@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e92be9ae-1ce9-adf1-86b9-0193cce708ea@linaro.org>
Date:   Tue, 20 Apr 2021 13:32:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+_ehUwzYLU5W0452Lvryb41w=-U_SgwGBePVhQA-3UBBZUOig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/04/2021 13:04, Ansuel Smith wrote:
>>
>> On 19/04/2021 14:08, Ansuel Smith wrote:
>>
>> [ ... ]
>>
>>>>>> vim +193 drivers/thermal/qcom/tsens-8960.c
>>>>
>>>> [ ... ]
>>>>
>>>>> What happened here? This doesn't seem right.
>>>>
>>>> Yes, it is. It means the series is not git bisect safe.
>>>>
>>>> Please fix it.
>>>>
>>>>
>>>
>>> I'm a bit confused. Should I send just a patch to fix this or I
>>> need to send the series again rebased with the new changes?
>>
>> The latter, I've dropped your series from the thermal/next branch
>>
> 
> Ok I will resend the series. I notice it has been applied to linux-next,
> will that be a problem?

No, it is fine. linux-next uses thermal/linux-next and it is allowed to
rebase the branch.

I've just updated it with your v14 series dropped.


>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
