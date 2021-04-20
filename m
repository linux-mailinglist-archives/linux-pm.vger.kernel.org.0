Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB58365308
	for <lists+linux-pm@lfdr.de>; Tue, 20 Apr 2021 09:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhDTHQ7 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 20 Apr 2021 03:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhDTHQ7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 20 Apr 2021 03:16:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C48BC06174A
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 00:16:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g9so20423429wrx.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Apr 2021 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qvH5oBp0yvihlrHXr4lFzIRk/hMfoOyXGA5p6OKo85Q=;
        b=nHrw7057s30707SZYCUlH9nFy8e90EamV2y9WhiPLxSEIuyPQZqonEZoXd86vMwD1T
         rRrAokZ1tRTO2oepDUqWiJalajEv7sYe1QEj83BxRFYNguiA1M6p8Xfy65KepLwhbmTq
         hnyhn7PizHtuE3ejgqn95aq6PG0cxxlJTePNzBleDkzsyrAoEB8KNcVS+RJTcWR47L2j
         v7TvSc/U3g3jcZF7PD3emJTZpWI/1Lp1enOc2xVXfYGa7wv+hMSHOxrxiLx1ILhnmN6d
         DA/VRRkHpPpc7jGacst2X9UMO7LgeXX6MUH5ZjkabxgjNwMNSbpY8IdeMU7AqbASB1z/
         +qTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qvH5oBp0yvihlrHXr4lFzIRk/hMfoOyXGA5p6OKo85Q=;
        b=cb83WprjiB3tZx244qSe7lDNGdkqFu1BTVlzCSiEVMpxoxDBgfG275sF6zcKE6fmxf
         wW3ChJKFLq7qUASN7dNy66AQTHuth8YzR3TYKurkOiTI7Me4OwpuAlIJNXilebhkeEGu
         J2UkDcEhp/WP5fi6JU+oZ+SOkoR6r7BTlmvYGVkYUVH3Mbubo8y+Jp97sDGeu1bkjTKL
         2wDlakZJMbDpIEGLsOBZfB4YNARWqUyPD/PzLVCi+YMeINW4bvATmCioSehLlwvNDwLg
         ySIWmiM/7PW3exHJMzfUWbe4A11d/V5tKDIQq98Sz/Ps5oWUyPuz+dnCBHBbgvAFmmYT
         CF9Q==
X-Gm-Message-State: AOAM532PK3ibcND32HT0zBYSUOjHSb/GO9ZA4jWO7LpsMGdo4bufgoz1
        G9vS3UxcLjsLjXX74UQUcuaKkA==
X-Google-Smtp-Source: ABdhPJzSd8MkZKUF8/lneP/yUYHvQ1W/KGzvlNzfVHVu8PlwMEOzM7kMk8JxLB6MlpZUVikcxdelDg==
X-Received: by 2002:adf:e3cf:: with SMTP id k15mr18564401wrm.327.1618902986680;
        Tue, 20 Apr 2021 00:16:26 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:a079:f96:da87:2d00? ([2a01:e34:ed2f:f020:a079:f96:da87:2d00])
        by smtp.googlemail.com with ESMTPSA id q5sm2316256wmj.20.2021.04.20.00.16.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 00:16:25 -0700 (PDT)
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
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <7019d902-885f-d9ea-e24d-64ee8dd5aa0e@linaro.org>
Date:   Tue, 20 Apr 2021 09:16:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+_ehUziRf7Ls8PByz-9_L8SKB26+yRY-MrZK_26GqdycCkNhg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 19/04/2021 14:08, Ansuel Smith wrote:

[ ... ]

>>>> vim +193 drivers/thermal/qcom/tsens-8960.c
>>
>> [ ... ]
>>
>>> What happened here? This doesn't seem right.
>>
>> Yes, it is. It means the series is not git bisect safe.
>>
>> Please fix it.
>>
>>
> 
> I'm a bit confused. Should I send just a patch to fix this or I
> need to send the series again rebased with the new changes?

The latter, I've dropped your series from the thermal/next branch


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
