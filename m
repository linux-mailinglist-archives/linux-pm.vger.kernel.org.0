Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B4C330282
	for <lists+linux-pm@lfdr.de>; Sun,  7 Mar 2021 16:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhCGPRO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 7 Mar 2021 10:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhCGPQ4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Mar 2021 10:16:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F5FC06175F
        for <linux-pm@vger.kernel.org>; Sun,  7 Mar 2021 07:16:55 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w11so8714803wrr.10
        for <linux-pm@vger.kernel.org>; Sun, 07 Mar 2021 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Scv4zOxnnaBWjmmeFnXouZuxffp8iOuoaC+fdqy3lIY=;
        b=ItW9oetdiV0wMrdC06hYWVYy2gpAZTrLucIo11WuKMMD/YsXG1Tlbh9Nk+0Nb4M7DR
         5dPpMvaGObcv72eDcM27XwOnmymUfmp9IwPHzeIBpossxUx3kANeS06o/vcuZSlZPoCu
         9whHTk6jMLwDdeFvCDh76EXSn3mZgcDFbzxaRIXPACzqErJUvMrPjnghdSLq5Zt5iRgF
         l1FTTMN9zQd2Q5WnFt7xSer5IhiEQDEUq4iWHOjYA9jiZQBmyvPThW01jCnd4iWot9Bs
         XiMQ82jzvmShHVNpfMrIutV3955tuUkhc59Ta2aTIwhqsT2mW0YQfGpagOXiicehcYtd
         Rasw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Scv4zOxnnaBWjmmeFnXouZuxffp8iOuoaC+fdqy3lIY=;
        b=UoZcJWmNaYkCzRgarYpR+qsSJAmvOAd16TjmB8JWVVm5bfwu4zA18xxq+0C7Ns/HSU
         KRd6LGZ2gPZxrI/7/9mFGwilfufubY0xZ0br6q4D+MlK0aONI61rFTz1gdB5WQ8t2ECI
         DoGRLQbMfeUU629WzfBkf9yRte3bePYS0qivBR4MsKewYl9SwYPaELyN4nkzsp/aQ7PY
         mIkbE6sNogRRWL1NSXrSbbkm2kocS9C4PnchGiFDBqxsuIHMy97Or3d7qQH5JFvu9UNj
         auoR4VKBmVl6yzxY/ghXQjjICKLUkCuJ839usaRvVQd/y/MJYVjvNpd1qiXhWhxtTBRk
         QVkQ==
X-Gm-Message-State: AOAM532jOJPUopkRqTy4cr9mavL9btgymmEBqaqTohYN2Yi0T0v6o9oc
        a9lWakkvi7t8dxUB2XuJ4jpCwXyCERk3Sw==
X-Google-Smtp-Source: ABdhPJy4/Gv6hoeTSP5rG9IcgL5vO+gB0zbIhPU7httEX/JsGYIX9KI3EIrBztYAj7uFswp3kksIAg==
X-Received: by 2002:a5d:67cf:: with SMTP id n15mr18407451wrw.95.1615130214477;
        Sun, 07 Mar 2021 07:16:54 -0800 (PST)
Received: from ?IPv6:2a01:e34:ed2f:f020:b087:286:c426:25b5? ([2a01:e34:ed2f:f020:b087:286:c426:25b5])
        by smtp.googlemail.com with ESMTPSA id a17sm13939652wmj.9.2021.03.07.07.16.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Mar 2021 07:16:54 -0800 (PST)
Subject: Re: [PATCH v3 1/4] devfreq: Register devfreq as a cooling device on
 demand
To:     Chanwoo Choi <cwchoi00@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
References: <20210307094519.9032-1-daniel.lezcano@linaro.org>
 <CAGTfZH3jFJ8CaJ1Yg=oxhVSYVDULWr83iPokL+tut8mKgSufFA@mail.gmail.com>
 <76b5b6bc-952b-aa7c-025b-3eeb2ca23c79@linaro.org>
 <587ae86e-158d-8ffa-319c-66f397f5a218@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <5bedc08e-8f46-925a-4840-dafbacd6cd39@linaro.org>
Date:   Sun, 7 Mar 2021 16:16:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <587ae86e-158d-8ffa-319c-66f397f5a218@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/03/2021 16:14, Chanwoo Choi wrote:
> On 21. 3. 7. 오후 11:28, Daniel Lezcano wrote:

[ ... ]

> Thanks. And, please add 'PM /' prefix for patch in order to
> keep the consistent patch title format.
> 
> PM / devfreq: Register devfreq as a cooling device on demand

Sure, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
