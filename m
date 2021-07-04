Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1C23BACF9
	for <lists+linux-pm@lfdr.de>; Sun,  4 Jul 2021 14:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhGDMGr (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 4 Jul 2021 08:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhGDMGq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 4 Jul 2021 08:06:46 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6189EC061574;
        Sun,  4 Jul 2021 05:04:11 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w19so27228183lfk.5;
        Sun, 04 Jul 2021 05:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MMWDNonMzJu4B/Nuq5tYsGdqYpWlaDoOAFfsFhwW0Qc=;
        b=YIV7bz8W+KXGAkmkVO2iSqNgFqP5UZtLzWDJUgCKxSBaAOjILkwkPi1BOyV0BZ7KLa
         IyC8ZQ9FA7t56KB0+hErPgHZFqyt8kvB0JXIAmvGdXW5Ze8yt2ESlyKAvbQtD36ybhxM
         9JoGsgqZWtaOlukCJxbL+hRTQI0vFP37NzXB61fa69JLN7AM6zymxzAhrVBbF5pvhDCY
         rLY0Enh7BXsWxPB42j3rqwg02AtBVzf68tNB6kxgR7LjjteTzUV6XMDWNwtfQptnXd4I
         4+U9r3SwCjaPzSTBdazvhVEAjshcpgVf0waTv3/WBkB7sVGUYA5xlpc3xmG392fWSD9m
         Corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MMWDNonMzJu4B/Nuq5tYsGdqYpWlaDoOAFfsFhwW0Qc=;
        b=l27T1jUdZT8+lkZqxt74UNDppABZkv/xKVGLzm2yzJtaiWSV+QWSGoEWXV95i40ACO
         uzj00VUdjd6EcZIG1a//Q+Z/cVkyRwxJ7Z+t/5NzANmpolui9gjtXBhyQpW+fSQZu3yE
         pRqDnSdY8d+77jSgmqvSPRYoz3J1PExt6FmsYrZ3EefymCUsCxZGD8AD+SKOKxlmqCrW
         gPbYbCVRL1ll6godBOy3CZw6AcMQYN4mbGkt7EaTmNIHrTYudhFORhQcWMJrtX8Sd1Ym
         kBapOnQDxGCtYVg9sLwUS7kmOdPmbXPVmz0b1rbFM24++KlJBcLvqnZiDRBsduY1o/iJ
         hTxA==
X-Gm-Message-State: AOAM531vWARkgoWCcvnfJcJa2r6P3f1YZnC+ffW5LOCCJkFHiBT+MUm6
        56TgF3Z+vm3jC565/YOcbQ8=
X-Google-Smtp-Source: ABdhPJx6U2bF20g+M191elcdj+Kq4cQo3mKvHXsYeFEIgOnCkNVhPzgPcu5t/tcP2Nmio18enaDAdg==
X-Received: by 2002:a19:490f:: with SMTP id w15mr6747087lfa.228.1625400248734;
        Sun, 04 Jul 2021 05:04:08 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id u10sm784828lfq.205.2021.07.04.05.04.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 05:04:08 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <aa250ea4-7871-dd39-dbf6-bffa6e732919@gmail.com>
Date:   Sun, 4 Jul 2021 15:04:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e6ac56a5-0b7e-bfbf-7e98-8bc3f39190fd@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

04.07.2021 12:51, Daniel Lezcano пишет:
> On 03/07/2021 21:56, Dmitry Osipenko wrote:
>> 03.07.2021 22:34, Linus Torvalds пишет:
>>> On Sat, Jul 3, 2021 at 9:17 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>>>> tags/thermal-v5.14-rc1
>>>
>>> This does not build for me. And I suspect it never built in linux-next either.
>>>
>>> I get
>>>
>>>   ERROR: modpost: "tegra_fuse_readl"
>>> [drivers/thermal/tegra/tegra30-tsensor.ko] undefined!
>>>   ERROR: modpost: "tegra_fuse_readl"
>>> [drivers/thermal/tegra/tegra-soctherm.ko] undefined!
>>>   make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
>>>   make[1]: *** Deleting file 'modules-only.symvers'
>>>   make: *** [Makefile:1762: modules] Error 2
>>>
>>> and I think it's due to that commit 1f9c5936b10c
>>> ("thermal/drivers/tegra: Correct compile-testing of drivers") which
>>> quite sensibly tries to extend build coverage for the tegra thermal
>>> drivers, but that build coverage doesn't actually *work* outside the
>>> tegra world.
>>>
>>> That commit says "All Tegra thermal drivers support compile-testing",
>>> but clearly they stumble at the last hurdle.
>>>
>>> I made the decision to just unpull this, not because I couldn't fix
>>> it, but because if it was this untested, I don't want to worry about
>>> all the *other* code in there too.
>>
>> It was tested in linux-next for about two weeks and it was a known
>> problem already [1], sorry again. The compile-testing depends on the
>> patch [2] that should come with the ARM32 PR. The linux-next was okay
>> because [2] got first into -next and I forgot about it. It will be fine
>> to defer these Tegra patches till the next release if this is the
>> easiest solution.
> 
> My bad, I did a wrong decision assuming the ARM32 branch would be
> already there when pulling the thermal branch.
> 
> I'll remove the patches.
> 
> Sorry for the inconvenience.

Daniel, please let me know if I will need to resend the thermal patches
for 5.15.
