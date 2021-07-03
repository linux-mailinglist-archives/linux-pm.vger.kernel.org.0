Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14D2B3BAA33
	for <lists+linux-pm@lfdr.de>; Sat,  3 Jul 2021 21:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGCT7D (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 3 Jul 2021 15:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbhGCT7D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jul 2021 15:59:03 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D89C061762;
        Sat,  3 Jul 2021 12:56:28 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q4so18523894ljp.13;
        Sat, 03 Jul 2021 12:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X7kAJPIrQ2CRZ+nDTEzyAgFnzLsX8TyF6pbd+uBdKss=;
        b=CG9H5d24HXih4TLKhGeIYj25/R+NEXOviMPeJa0oeSnirkGqJIS3D78oS+NJCsTtT/
         K0/bCy055Gv4E5/xNXWAOfvVPogUO3JHOfYkYB3Y2MjN0YVfNxTDZUoaZ0Z2cLXe3eTl
         t53NqYYgGJbzh8t7GaeIP7jlVoUvWlHIBaAFmijliHMRPPTZwz6uvavtDtxfKpq6qsS5
         Kuclh6h8Y0kZzlYuIl6P4EoI93sxTLtIwWdeP6ozyBDEwQEnA/55GpKh9O3nz75h2Qmo
         BpSjmKqEa3q0OUpuibNfmYDtKy6xGBDmrFTf8MciNKJ75xBxK66m0oTW/WcoF6Z+x0/X
         Hd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X7kAJPIrQ2CRZ+nDTEzyAgFnzLsX8TyF6pbd+uBdKss=;
        b=DuzcGXnRFdbgPfJoW8ka2/RF5NetIlSKDyCBhNajgUI9ebdJO4h0AA8jISZ6QI8vYp
         IR6lL0hFdS8jbbHJJSQCWFOtuPg1wSTrmwb1frd+Yi8Ny6kj+UZa37VMDdHPRzsT0e+Y
         QmDyTrlUtnZ5FrCIO1rJDrB9jHHGovrKZ2iPJQdI/ZcuQmdTa9jW1xIx65XBrvRS9bYJ
         9QIs5hpdNkp2bv/1MwU8apjMCYHbvOnILwfX1wSJ6o1Pnhi/OA7HtcwTjW6oOFlJ3ckc
         fyXMMgACgkcW5gToSlJdzhvmFE8yUbOFAnRFXRLA0QpD5Yh0wpJo/wDSE4qW5rEKRSqi
         F+Nw==
X-Gm-Message-State: AOAM532607G5S2EK0EJqCQvJbfWIDSbSuCtrnV7FBIaXuIAtvxWvU5gR
        J5ptAmDczeA+/6dImQZT1ro=
X-Google-Smtp-Source: ABdhPJxchmcoaNDUdVbE5J/1i5+lCqCYd0hCV4zz9kYQsEv9lyJDWrP2Aq/wVFKu0oKi42ni/4RiXg==
X-Received: by 2002:a2e:b532:: with SMTP id z18mr4638555ljm.259.1625342186575;
        Sat, 03 Jul 2021 12:56:26 -0700 (PDT)
Received: from [192.168.2.145] (94-29-37-113.dynamic.spd-mgts.ru. [94.29.37.113])
        by smtp.googlemail.com with ESMTPSA id b7sm616001lfb.121.2021.07.03.12.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Jul 2021 12:56:26 -0700 (PDT)
Subject: Re: [GIT PULL] thermal for v5.14-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <67ce84e6-f1a5-7796-805d-6482f24b1490@gmail.com>
Date:   Sat, 3 Jul 2021 22:56:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHk-=wgZzeaZb0ByL+zPV1grizuxw2nAnmzU49S7pzV7sPS1Hg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

03.07.2021 22:34, Linus Torvalds пишет:
> On Sat, Jul 3, 2021 at 9:17 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
>> tags/thermal-v5.14-rc1
> 
> This does not build for me. And I suspect it never built in linux-next either.
> 
> I get
> 
>   ERROR: modpost: "tegra_fuse_readl"
> [drivers/thermal/tegra/tegra30-tsensor.ko] undefined!
>   ERROR: modpost: "tegra_fuse_readl"
> [drivers/thermal/tegra/tegra-soctherm.ko] undefined!
>   make[1]: *** [scripts/Makefile.modpost:150: modules-only.symvers] Error 1
>   make[1]: *** Deleting file 'modules-only.symvers'
>   make: *** [Makefile:1762: modules] Error 2
> 
> and I think it's due to that commit 1f9c5936b10c
> ("thermal/drivers/tegra: Correct compile-testing of drivers") which
> quite sensibly tries to extend build coverage for the tegra thermal
> drivers, but that build coverage doesn't actually *work* outside the
> tegra world.
> 
> That commit says "All Tegra thermal drivers support compile-testing",
> but clearly they stumble at the last hurdle.
> 
> I made the decision to just unpull this, not because I couldn't fix
> it, but because if it was this untested, I don't want to worry about
> all the *other* code in there too.

It was tested in linux-next for about two weeks and it was a known
problem already [1], sorry again. The compile-testing depends on the
patch [2] that should come with the ARM32 PR. The linux-next was okay
because [2] got first into -next and I forgot about it. It will be fine
to defer these Tegra patches till the next release if this is the
easiest solution.

[1]
https://lore.kernel.org/linux-devicetree/20210616190417.32214-7-digetx@gmail.com/T/#m354e679e93c4f84e26d5e630423e47317d0c2edc

[2]
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=30b44e81772a5caa983000057ce1cd9cb4531647
