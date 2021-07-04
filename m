Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7483BAC95
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 11:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGDJxv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbhGDJxv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 05:53:51 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCDDC061762
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 02:51:15 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id m18so18300821wrv.2
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 02:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DyAPDDuQ1eqE8i0UciuIoMX1PQ8MXE7kw1cwogcfOCU=;
        b=SkhPUwxdJlj2UXV582jVO/fN+WQVO0v7yaJjcdVwG5IrQ3MdfARcKrKh6Tz242wasM
         ykSDT+ZNWJfDOr+Va3aKXwmcJEUPgdpfnk0Bl+fCgh4pTN8B0mDYA9H9k3c+z/Z6uHyL
         nwkXFp+hAPtqt9/L3852FJclbrGtTZlwA/bOND1WLDrt2HUAhgQJ/UvD3xPKbZukh+4d
         csf/ifHC4yXCS5exUg44FmoGeZM/bHtvc0XkMpZEoBpsW4bTbuYIz5F2eFT/sRpNJOjo
         tQdN3dF2I89ESE9ECGLYE0ZQ3Telv3o8zQvvhRQ8YkQiI15URS1ty89X2iKe3IyFnvga
         XvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DyAPDDuQ1eqE8i0UciuIoMX1PQ8MXE7kw1cwogcfOCU=;
        b=PTI7Qu+eq15EswSH76NoIB83tLUp76EbJTSOd5cIehUk2SOrnFT0xHqKDOoaIaUqQL
         5GLzzqYpcfQv5uNe9ESvv/BuCZry1JbJpqNBaKdO89B4t8e0hShq+9ZkNujvB5KhJZI3
         0PRnevxadAMIKryVmSUwkWfloXIi7qB3zRFLsLt6d6GlXyqqAokkOxwzZZwJR2BghtoI
         m98bzNHLtDqikZ+HkAPIYy+Oow3sF5zmupsyMSXUn7IRl5e2282L4J7raj67QYAzc8YR
         lPhZjT83quAohfUsBxWSOljQstJzj21ZdZilOB+bjXkIBvTO8HnR3dfrJxp17O3APNEn
         4V6g==
X-Gm-Message-State: AOAM532JbiLwG3zjgzFagjt00JfV693l/YGBwaJBLPR4uWQDE4Mg1SlK
        etGupL1fLuwRF3E4w17ObEqLkOIt+7SpO7fj
X-Google-Smtp-Source: ABdhPJyXjx6F+bIJ3fAE34Z5grYfF1JpzaPJ473ZpNd2p6MJ3dU6nEWWTPzxP5uZh0xB3mm/xEAMIg==
X-Received: by 2002:adf:a3ce:: with SMTP id m14mr9625863wrb.246.1625392274387;
        Sun, 04 Jul 2021 02:51:14 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:11d:6696:65bb:ef7f? ([2a01:e34:ed2f:f020:11d:6696:65bb:ef7f])
        by smtp.googlemail.com with ESMTPSA id c9sm9130247wro.5.2021.07.04.02.51.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 02:51:13 -0700 (PDT)
Subject: Re: [GIT PULL] thermal for v5.14-rc1
To:     Dmitry Osipenko <digetx@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <zhang.chunyan@linaro.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Rajeshwari Ravindra Kamble <rkambl@codeaurora.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Finley Xiao <finley.xiao@rock-chips.com>
References: <7a9ac752-2c1a-b05f-c5bd-9049c0bdd54e@linaro.org>
 <CAHk-=wgZzeaZb0ByL+zPV1grizuxw2nAnmzU49S7pzV7sPS1Hg@mail.gmail.com>
 <67ce84e6-f1a5-7796-805d-6482f24b1490@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <e6ac56a5-0b7e-bfbf-7e98-8bc3f39190fd@linaro.org>
Date:   Sun, 4 Jul 2021 11:51:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <67ce84e6-f1a5-7796-805d-6482f24b1490@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03/07/2021 21:56, Dmitry Osipenko wrote:
> 03.07.2021 22:34, Linus Torvalds пишет:
>> On Sat, Jul 3, 2021 at 9:17 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>>> tags/thermal-v5.14-rc1
>>
>> This does not build for me. And I suspect it never built in linux-next either.
>>
>> I get
>>
>>   ERROR: modpost: "tegra_fuse_readl"
>> [drivers/thermal/tegra/tegra30-tsensor.ko] undefined!
>>   ERROR: modpost: "tegra_fuse_readl"
>> [drivers/thermal/tegra/tegra-soctherm.ko] undefined!
>>   make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
>>   make[1]: *** Deleting file 'modules-only.symvers'
>>   make: *** [Makefile:1762: modules] Error 2
>>
>> and I think it's due to that commit 1f9c5936b10c
>> ("thermal/drivers/tegra: Correct compile-testing of drivers") which
>> quite sensibly tries to extend build coverage for the tegra thermal
>> drivers, but that build coverage doesn't actually *work* outside the
>> tegra world.
>>
>> That commit says "All Tegra thermal drivers support compile-testing",
>> but clearly they stumble at the last hurdle.
>>
>> I made the decision to just unpull this, not because I couldn't fix
>> it, but because if it was this untested, I don't want to worry about
>> all the *other* code in there too.
> 
> It was tested in linux-next for about two weeks and it was a known
> problem already [1], sorry again. The compile-testing depends on the
> patch [2] that should come with the ARM32 PR. The linux-next was okay
> because [2] got first into -next and I forgot about it. It will be fine
> to defer these Tegra patches till the next release if this is the
> easiest solution.

My bad, I did a wrong decision assuming the ARM32 branch would be
already there when pulling the thermal branch.

I'll remove the patches.

Sorry for the inconvenience.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
