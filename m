Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621C768169
	for <lists+linux-pm@lfdr.de>; Mon, 15 Jul 2019 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbfGNWTZ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 14 Jul 2019 18:19:25 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40286 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728731AbfGNWTY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 14 Jul 2019 18:19:24 -0400
Received: by mail-lj1-f193.google.com with SMTP id m8so14184684lji.7;
        Sun, 14 Jul 2019 15:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=umaBieZkHQlpvJRlI46BSRt17eppj53ySrGsxMxyEG4=;
        b=dGKKLVKd7gLPwY113cgCcCqC8J9kg/7znMzw2eIin4M0OqAI8R1bMUlioeGfBhTuua
         1fJ+VcSaWusysnmOtj+aP2D1/1x6iH02Mx6tcBtMO61wRkky5YMAfLL/GwRVZ0DnVSj5
         t3m5yi8C6KAXvrdHImfzVLHECQIgWX8W/fDQq3eS6yhQhTIk2vffF/X7nYKkvgy0+6+e
         Vh3xeXl7utyhVns7hBMuMQLqF0FLhcYi9fdnPt9L+3P7vWW5MpDYKi9q8Q2f6/Jlp7rz
         DiavHy2pWYz4nX//uHpnICAGCVYN7OFvzh+Gex1JGb7yeVVJt03QUB+hTEWj9zUojiYq
         Z2nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=umaBieZkHQlpvJRlI46BSRt17eppj53ySrGsxMxyEG4=;
        b=lalG2xtnd+4uSOcfBUJ1Ud5X1CtaFQWziVpKJM3bQzX2W53lOBtJbKYt8z+iTPcsA4
         P7880vn4F85g/goLd4RvmEsMbU777gqa7InYREC5eFToxRUcH7CFuWaQkM95PEuO9ChZ
         hQUZQmMAxQ7wnAcCmZpaYesYFtjqB6UYGli1qSHIVDU9V5WjQYerP3hb8peCYLzdO4vd
         4B5TyAgSxBLiUpNu/0dggmkcKF9BXEydcf7ihB9NDZPtWmJnIQzV0dRp2ZftLlNZN6JX
         XR+u74vAFuzuCvAb9shG+cqHSiBTFavzOPlJkpSR86gXpu9qgztQIyUg628f3b36sr+z
         kLWQ==
X-Gm-Message-State: APjAAAX2vJCMp0U6Ygd7AfqD1dRRze/T0v3yfXU/zxjYkzE5dzvcvmAy
        y2IhuHpl5V0cJS/Z64aVIrXws/N2
X-Google-Smtp-Source: APXvYqy5XOMeWNWyjwppmpufMHj4Zd2QTGvWzxwnDt18HRH4CsnVfOJOY5AjnP74wL5x0w0XxPawFQ==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr12325112ljt.175.1563142761276;
        Sun, 14 Jul 2019 15:19:21 -0700 (PDT)
Received: from [192.168.2.145] (ppp79-139-233-208.pppoe.spdop.ru. [79.139.233.208])
        by smtp.googlemail.com with ESMTPSA id n10sm2064700lfe.24.2019.07.14.15.19.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jul 2019 15:19:20 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] ARM: tegra: Remove cpuidle drivers
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20190711031312.10038-1-digetx@gmail.com>
 <20190711031312.10038-2-digetx@gmail.com>
 <c087a5cb-2ffa-1cf6-f0bf-631234759a22@nvidia.com>
 <a6e4b43e-369c-c501-6d2e-69d5b940ff9c@gmail.com>
 <73781434-d25a-b17b-aacb-95ace5ac5f95@nvidia.com>
 <9d79ed3e-a37f-af9c-0696-31dc33bbdefd@gmail.com>
Message-ID: <0a04f2f3-a2bd-b750-d6db-06dae481fb0b@gmail.com>
Date:   Mon, 15 Jul 2019 01:19:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9d79ed3e-a37f-af9c-0696-31dc33bbdefd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

12.07.2019 19:23, Dmitry Osipenko пишет:
> 12.07.2019 12:39, Jon Hunter пишет:
>>
>> On 11/07/2019 18:03, Dmitry Osipenko wrote:
>>> 11.07.2019 12:26, Jon Hunter пишет:
>>>>
>>>> On 11/07/2019 04:13, Dmitry Osipenko wrote:
>>>>> Remove the old drivers to replace them cleanly with a new one later on.
>>>>>
>>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>>> ---
>>>>>  arch/arm/mach-tegra/Makefile           |  13 --
>>>>>  arch/arm/mach-tegra/cpuidle-tegra114.c |  89 -----------
>>>>>  arch/arm/mach-tegra/cpuidle-tegra20.c  | 212 -------------------------
>>>>>  arch/arm/mach-tegra/cpuidle-tegra30.c  | 132 ---------------
>>>>>  arch/arm/mach-tegra/cpuidle.c          |  50 ------
>>>>>  arch/arm/mach-tegra/cpuidle.h          |  21 ---
>>>>>  arch/arm/mach-tegra/irq.c              |  18 ---
>>>>>  arch/arm/mach-tegra/irq.h              |  11 --
>>>>>  arch/arm/mach-tegra/pm.c               |   7 -
>>>>>  arch/arm/mach-tegra/pm.h               |   1 -
>>>>>  arch/arm/mach-tegra/reset-handler.S    |  11 --
>>>>>  arch/arm/mach-tegra/reset.h            |   9 +-
>>>>>  arch/arm/mach-tegra/sleep-tegra20.S    | 190 +---------------------
>>>>>  arch/arm/mach-tegra/sleep.h            |  12 --
>>>>>  arch/arm/mach-tegra/tegra.c            |   3 -
>>>>>  drivers/soc/tegra/Kconfig              |   1 -
>>>>>  include/soc/tegra/cpuidle.h            |   4 -
>>>>>  17 files changed, 5 insertions(+), 779 deletions(-)
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra114.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra20.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle-tegra30.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.c
>>>>>  delete mode 100644 arch/arm/mach-tegra/cpuidle.h
>>>>>  delete mode 100644 arch/arm/mach-tegra/irq.h
>>>>
>>>> By removing all the above, it is really hard to review the diff. Is
>>>> there any way you could first consolidate the cpuidle drivers into say
>>>> the existing arch/arm/mach-tegra/cpuidle-tegra20.c and then move to
>>>> drivers/cpuidle?
>>>
>>> I'm afraid that it will make reviewing even more difficult because
>>> everything that is removed here is not returned in the further patches.
>>> The new driver is based on the older ones, but I wrote it from scratch
>>> and it's not only looks different, but also works a bit different as you
>>> may see.
>>>
>>> Could you please clarify what exactly makes it hard to review? The diff
>>> looks pretty clean to me, while squashing everything into existing
>>> driver should be quite a mess.
>>
>> Ideally a patch should standalone and can be reviewed by itself.
>> However, to review this, we need to review patches 1, 2 and 3 at the
>> same time. So IMO it is not that convenient from a reviewers
>> perspective. Furthermore, patches 1 and 3 are large and so easy to miss
>> something.
>>
>> Is there really no way to have a patch to combined the existing drivers,
>> then a patch to convert them into the newer rewritten version you have
>> implemented, then move the driver?
> 
> Probably I spent a bit too much time with that code, so now yours
> suggestion looks to me like an unnecessary step. But I will try and see
> how it goes, at least it should be possible to break down the patch 1 a
> bit more, hopefully it will help to better understand what's going on in
> the further patches if you're not familiar or don't remember how it all
> works.

I tried (in several attempts) and couldn't find a way how to
meaningfully squash the old drivers. It's a lot of unnecessary churning
that won't help with reviewing of the code at all because new driver is
structured differently and beating of old drivers until they resemble
the new one just not worth it. I'll write a bit more detailed commit
message, emphasizing the details, hope it will be helpful. The old
drivers are ~200 LOC each and the new one will be ~300 LOC + 50 lines of
comments, I don't think that it's really very hard to review as it it
may initially looked like to you, Jon.
