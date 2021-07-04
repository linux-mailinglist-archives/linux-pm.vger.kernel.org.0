Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE5C3BAD17
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 15:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhGDNbW (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 09:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbhGDNbW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 09:31:22 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1298C061574;
        Sun,  4 Jul 2021 06:28:45 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a18so27417306lfs.10;
        Sun, 04 Jul 2021 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3xMqfh8elzx+SYmOtHOTYhmYFQAeBtG99tvp+qiX5Jo=;
        b=jYbcnxvP31Qj75aB9JOeCnvZKrNSzfy0h9EOykOMcW6mLcAYyVVY2yGFOC4tBzVdP2
         IiK5b3jw7PzBwz5lOLdNknJpXThIMJwWi6mEf++e90AOJ0o/SrKtCc9C4H2KzFxGXHms
         z/ELMQa2U6PMUdoFYXlgoUrZhreQiHmrKn5rTEmEWyobaQAOh1bwdbeIvuQAbWjbe69b
         9By3SBU6ejwflphI6zqLh2JSVDP7ll/of9y8mxWQ/vHQTEPutDgf2g3bxxAoQ7yAk+Fk
         loj4lp+JUP/+BcGOLkpckIDX509+EPu3QUz9cri53OGAOdhzku/ln0zUNklSC1XAs7D3
         scNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3xMqfh8elzx+SYmOtHOTYhmYFQAeBtG99tvp+qiX5Jo=;
        b=N+od7K0Q8A8w4XFWg0psP+o5MWEWkRT6UwB4YMP/GdxtHupyYBnxUlTNq6KhqOjPbL
         q1rhwFbdrarpsK1H6o1VCw6XPGpVkYIdwWeWPTLpa3/nfYnDGk10p2rW/MT2CZNXcS5i
         sdFFnYo+PKlil7a1NcyyZjv0pjM2mo81PcOmzcG9K08RUDJUEY6XBvLYT/+fYy6X9/49
         b2SbYbc1nu9VUzT9R7bt/nQWHwwtddwDKbnCWTj+9L0vCxXm5R5cVBHC4ky1BmfJpf5G
         JlhEyEb6rbWzvBUDcAVbFInkkKNZWn8CxsztBu786m9LglZqmtHLG8S37gPB2gtrMXx5
         mEOA==
X-Gm-Message-State: AOAM531K5VP2HIkmDqBBxYFEEm+qTPJzm+HnzT/H3UwVUvotEDWiC9Lj
        H31UCYD0AhBB4GmFTIXiHc8=
X-Google-Smtp-Source: ABdhPJxQBShpmQLpbitDF2jnVCdtnHGsPXxkjEcJJsou5JLYbEPrYo+eVOX+DkasN2VMi8XF0CL9lA==
X-Received: by 2002:a05:6512:419:: with SMTP id u25mr6985338lfk.600.1625405323929;
        Sun, 04 Jul 2021 06:28:43 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id x21sm1051682ljh.91.2021.07.04.06.28.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 06:28:43 -0700 (PDT)
Subject: Re: [GIT PULL] thermal for v5.14-rc1
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
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
 <17c8ce98-dc54-d439-95c8-318edb91932c@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c1afb772-0cab-3797-f0fb-af74c188c8bb@gmail.com>
Date:   Sun, 4 Jul 2021 16:28:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <17c8ce98-dc54-d439-95c8-318edb91932c@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.07.2021 16:19, Daniel Lezcano пишет:
> On 04/07/2021 14:04, Dmitry Osipenko wrote:
>> 04.07.2021 12:51, Daniel Lezcano пишет:
>>> On 03/07/2021 21:56, Dmitry Osipenko wrote:
>>>> 03.07.2021 22:34, Linus Torvalds пишет:
>>>>> On Sat, Jul 3, 2021 at 9:17 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>>>>>> tags/thermal-v5.14-rc1
>>>>>
>>>>> This does not build for me. And I suspect it never built in linux-next either.
>>>>>
>>>>> I get
>>>>>
>>>>>   ERROR: modpost: "tegra_fuse_readl"
>>>>> [drivers/thermal/tegra/tegra30-tsensor.ko] undefined!
>>>>>   ERROR: modpost: "tegra_fuse_readl"
>>>>> [drivers/thermal/tegra/tegra-soctherm.ko] undefined!
>>>>>   make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
>>>>>   make[1]: *** Deleting file 'modules-only.symvers'
>>>>>   make: *** [Makefile:1762: modules] Error 2
>>>>>
>>>>> and I think it's due to that commit 1f9c5936b10c
>>>>> ("thermal/drivers/tegra: Correct compile-testing of drivers") which
>>>>> quite sensibly tries to extend build coverage for the tegra thermal
>>>>> drivers, but that build coverage doesn't actually *work* outside the
>>>>> tegra world.
>>>>>
>>>>> That commit says "All Tegra thermal drivers support compile-testing",
>>>>> but clearly they stumble at the last hurdle.
>>>>>
>>>>> I made the decision to just unpull this, not because I couldn't fix
>>>>> it, but because if it was this untested, I don't want to worry about
>>>>> all the *other* code in there too.
>>>>
>>>> It was tested in linux-next for about two weeks and it was a known
>>>> problem already [1], sorry again. The compile-testing depends on the
>>>> patch [2] that should come with the ARM32 PR. The linux-next was okay
>>>> because [2] got first into -next and I forgot about it. It will be fine
>>>> to defer these Tegra patches till the next release if this is the
>>>> easiest solution.
>>>
>>> My bad, I did a wrong decision assuming the ARM32 branch would be
>>> already there when pulling the thermal branch.
>>>
>>> I'll remove the patches.
>>>
>>> Sorry for the inconvenience.
>>
>> Daniel, please let me know if I will need to resend the thermal patches
>> for 5.15.
> 
> I'll drop:
> 
> "thermal/drivers/tegra: Add driver for Tegra30 thermal sensor"
> "thermal/drivers/tegra: Correct compile-testing of drivers"
> 
> but keep the bindings.
> 
> It won't be necessary to resend them.

Great, thank you!

