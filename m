Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 624703BAD15
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 15:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhGDNWM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 09:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhGDNWK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 09:22:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD578C061574
        for <linux-pm@vger.kernel.org>; Sun,  4 Jul 2021 06:19:33 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v5so18645775wrt.3
        for <linux-pm@vger.kernel.org>; Sun, 04 Jul 2021 06:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8We6/ZMfhcjqBC4XSGNcgGBDGD6SExEiR8jKFgdhbUw=;
        b=Qxw0Pc7fYziCwJPcdZ8j0TvQg9oA4GBJbI6dplAC9w4Bly8wf6glvM2Dt9nkZOPwMT
         1Y9ARFKIFPyhLrD88gm6RmANRyX1IMYgEr+jM3Y7nmdgcu4e2MSwrdVe2RSUAfhLcozj
         KvqkbUmPscDFT03aYk1FUGe8VRw19qNFGUEky2cFTZrfEwvxMd0VTJpPvBzl8W6X/BnS
         nPGgegQJfuq72ONRRIXzOkp4vh9P5nQVTiXWPJVrnbrJpLvIUCH6T/CFrzr11bLquuex
         C6t5uENdpWcjhF1Bc/py50gA7qzsuIZicRTkQwsvtIp+IDNFCk32FtCg/jqnFkOvQFia
         oVng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8We6/ZMfhcjqBC4XSGNcgGBDGD6SExEiR8jKFgdhbUw=;
        b=n6m24hsku4KizEZzOneGMVjxTwX5z0bxPAZ5u6b9cJzNzknk8dlTxEDQ1GJ6A9LxSh
         2Mc2RQ4hpCF53dA/3YzXwjHST5BpkGiT9jxdMT3qX+ANpefWRGYEinW1vJCDDs+W8sRd
         dVOBEeGi8IRHdmg8N4wvIM1UEPWHW1WDAYsUiqZwzIbOltokL/gBZqGQ6OjOE3cmF5U5
         2S2FCehTSmTtJ/2bH/23UANHfmlHDPhmS8ap4JeN6IeZi/HycbEHutIIXM5/m2AVxBZP
         DDxzXY9NDc/cY7imrwaQfmpUjqjLPr5MYsO4PWjmXk2DdFq+G2Zs3Q33Y+nKsbaR+m8A
         xbZQ==
X-Gm-Message-State: AOAM532Iw7wp+K5tHjYExIjoTPD877osYYYsmxqyl+LHATTSrTirOSCb
        E+16EY4HnQioC71oJpgKkrERZw==
X-Google-Smtp-Source: ABdhPJx5NB8Igzeeg9QU/2kLr5LhLLm4DFq49ZDCTQYCcudMtZIEHeUzF+sUYjHe4ukFKuzFhbcwpQ==
X-Received: by 2002:a5d:5606:: with SMTP id l6mr10342019wrv.98.1625404772070;
        Sun, 04 Jul 2021 06:19:32 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:9c5f:457b:1c8a:d1f6? ([2a01:e34:ed2f:f020:9c5f:457b:1c8a:d1f6])
        by smtp.googlemail.com with ESMTPSA id s7sm9771423wrp.97.2021.07.04.06.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 06:19:31 -0700 (PDT)
Subject: Re: [GIT PULL] thermal for v5.14-rc1
To:     Dmitry Osipenko <digetx@gmail.com>
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
        Finley Xiao <finley.xiao@rock-chips.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <7a9ac752-2c1a-b05f-c5bd-9049c0bdd54e@linaro.org>
 <CAHk-=wgZzeaZb0ByL+zPV1grizuxw2nAnmzU49S7pzV7sPS1Hg@mail.gmail.com>
 <67ce84e6-f1a5-7796-805d-6482f24b1490@gmail.com>
 <e6ac56a5-0b7e-bfbf-7e98-8bc3f39190fd@linaro.org>
 <aa250ea4-7871-dd39-dbf6-bffa6e732919@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <17c8ce98-dc54-d439-95c8-318edb91932c@linaro.org>
Date:   Sun, 4 Jul 2021 15:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <aa250ea4-7871-dd39-dbf6-bffa6e732919@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04/07/2021 14:04, Dmitry Osipenko wrote:
> 04.07.2021 12:51, Daniel Lezcano пишет:
>> On 03/07/2021 21:56, Dmitry Osipenko wrote:
>>> 03.07.2021 22:34, Linus Torvalds пишет:
>>>> On Sat, Jul 3, 2021 at 9:17 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>>
>>>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>>>>> tags/thermal-v5.14-rc1
>>>>
>>>> This does not build for me. And I suspect it never built in linux-next either.
>>>>
>>>> I get
>>>>
>>>>   ERROR: modpost: "tegra_fuse_readl"
>>>> [drivers/thermal/tegra/tegra30-tsensor.ko] undefined!
>>>>   ERROR: modpost: "tegra_fuse_readl"
>>>> [drivers/thermal/tegra/tegra-soctherm.ko] undefined!
>>>>   make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
>>>>   make[1]: *** Deleting file 'modules-only.symvers'
>>>>   make: *** [Makefile:1762: modules] Error 2
>>>>
>>>> and I think it's due to that commit 1f9c5936b10c
>>>> ("thermal/drivers/tegra: Correct compile-testing of drivers") which
>>>> quite sensibly tries to extend build coverage for the tegra thermal
>>>> drivers, but that build coverage doesn't actually *work* outside the
>>>> tegra world.
>>>>
>>>> That commit says "All Tegra thermal drivers support compile-testing",
>>>> but clearly they stumble at the last hurdle.
>>>>
>>>> I made the decision to just unpull this, not because I couldn't fix
>>>> it, but because if it was this untested, I don't want to worry about
>>>> all the *other* code in there too.
>>>
>>> It was tested in linux-next for about two weeks and it was a known
>>> problem already [1], sorry again. The compile-testing depends on the
>>> patch [2] that should come with the ARM32 PR. The linux-next was okay
>>> because [2] got first into -next and I forgot about it. It will be fine
>>> to defer these Tegra patches till the next release if this is the
>>> easiest solution.
>>
>> My bad, I did a wrong decision assuming the ARM32 branch would be
>> already there when pulling the thermal branch.
>>
>> I'll remove the patches.
>>
>> Sorry for the inconvenience.
> 
> Daniel, please let me know if I will need to resend the thermal patches
> for 5.15.

I'll drop:

"thermal/drivers/tegra: Add driver for Tegra30 thermal sensor"
"thermal/drivers/tegra: Correct compile-testing of drivers"

but keep the bindings.

It won't be necessary to resend them.

Thanks
  -- Daniel

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
