Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45ECE42E94E
	for <lists+linux-pm@lfdr.de>; Fri, 15 Oct 2021 08:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235674AbhJOGvg (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 Oct 2021 02:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbhJOGvg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 Oct 2021 02:51:36 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D929EC061570;
        Thu, 14 Oct 2021 23:49:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id p16so37688137lfa.2;
        Thu, 14 Oct 2021 23:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EddHbOUdADVimAbGlRz3BSKwi7rBdjCzr1uQlPDasjY=;
        b=PmwPPO/GA/ClMdgV82YfF48PkWuhObrNiEQ1AVmHXtVjAzwjqHXrOkBSYDYYMl4cHw
         OALDVYwz8N8AHBj6bFrjupDyUm5olb7WdS9DeH6MH0cfe7rnxMMgO2I/5lANMr9T0xk4
         /TJS7SjUg1d9gFDei7Xra85sa304nA5F7tngZe1B2R8VNRHL2qntWXWmyyYX2f8gSlIm
         WTUidy6ETXbRk4J0uyUA4U/MwZ90eWSwKMCscKPL10wOKDd2eCnYi1WwvsurqF6vpw6X
         WOjIqlxOpwnBedK7eg09FBjgP/pyjJ20R7/+XTOQHbxySesutUzXWr7nJKYYWqzPdNa6
         cc5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EddHbOUdADVimAbGlRz3BSKwi7rBdjCzr1uQlPDasjY=;
        b=b7T4vD+tn06LEinXcxdUA+Snl8sdg/0G5VuX7uOojqoeo9XXFjVMjqgqXWQPUlH9OW
         p9qr8zAffzZ1oqrQZkCVOtDMKwLH1igMZaprRfCjndaxrDJpikP93DCU3+bddDZSeOfM
         h6xrSaOcfclnbhgpy/xD3eOGjY6Q4EZfDWNjzgznnWJ6kTRSa78KCizTBX+O70JckWY9
         rSNYWE6THNrNzE+GNd46KPWFmcMpgCslek24hWieFXgwQHAcl6PVsJeZEbNecJpIdKLr
         3ybdULjHy1zSrLxGOx6yG8viXWNNeOMptvmLWggZaJYgrQEw/HSZfadtmc2vv2+bmYNK
         2Smg==
X-Gm-Message-State: AOAM531O7FaTyQ/BdGmiEX0zz2os1f91Oi9kVQQHQRs7SXSSTj5/Bvjj
        /DXvn0ObSd9vmzh6a5arUp3652+oaKk=
X-Google-Smtp-Source: ABdhPJyygzlRnZV944jPDBS6uILWDq3znMl83/ecUVpOGvqQn62q4swoXqP/LuPMyGP29IBpI5gY3A==
X-Received: by 2002:a2e:90b:: with SMTP id 11mr11288492ljj.186.1634280567802;
        Thu, 14 Oct 2021 23:49:27 -0700 (PDT)
Received: from [192.168.2.145] (79-139-176-16.dynamic.spd-mgts.ru. [79.139.176.16])
        by smtp.googlemail.com with ESMTPSA id s11sm69237ljp.60.2021.10.14.23.49.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 23:49:27 -0700 (PDT)
Subject: Re: [PATCH] cpuidle: tegra: add ARCH_SUSPEND_POSSIBLE dependency
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thierry Reding <treding@nvidia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        He Ying <heying24@huawei.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20211013160125.772873-1-arnd@kernel.org>
 <2fdbd732-2496-2267-6636-2f682c39e928@gmail.com>
 <CAK8P3a2jwJb_B8y3juin74kpW5cRJb2GQrYyTW8qJ+9y-x0cmQ@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <86f9d315-7d98-ed92-0245-9d99f7131d1a@gmail.com>
Date:   Fri, 15 Oct 2021 09:49:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2jwJb_B8y3juin74kpW5cRJb2GQrYyTW8qJ+9y-x0cmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.10.2021 17:41, Arnd Bergmann пишет:
> On Thu, Oct 14, 2021 at 12:25 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> 13.10.2021 19:01, Arnd Bergmann пишет:
>>> From: Arnd Bergmann <arnd@arndb.de>
>>>
>>> Some StrongARM processors don't support suspend, which leads
>>> to a build failure with the tegra cpuidle driver:
>>>
>>> WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
>>>   Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
>>>   Selected by [y]:
>>>   - ARM_TEGRA_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_TEGRA [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]
>>>
>>> arch/arm/kernel/sleep.o: in function `__cpu_suspend':
>>> (.text+0x68): undefined reference to `cpu_sa110_suspend_size'
>>>
>>> Add an explicit dependency to make randconfig builds avoid
>>> this combination.
>>>
>>> Fixes: faae6c9f2e68 ("cpuidle: tegra: Enable compile testing")
>>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>>> ---
>>>  drivers/cpuidle/Kconfig.arm | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
>>> index 2cc3c208a180..af97992eaa82 100644
>>> --- a/drivers/cpuidle/Kconfig.arm
>>> +++ b/drivers/cpuidle/Kconfig.arm
>>> @@ -100,6 +100,7 @@ config ARM_MVEBU_V7_CPUIDLE
>>>  config ARM_TEGRA_CPUIDLE
>>>       bool "CPU Idle Driver for NVIDIA Tegra SoCs"
>>>       depends on (ARCH_TEGRA || COMPILE_TEST) && !ARM64 && MMU
>>> +     depends on ARCH_SUSPEND_POSSIBLE
>>>       select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
>>>       select ARM_CPU_SUSPEND
>>>       help
>>>
>>
>> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Thanks!
> 
> I realized now that we should drop the '&& MMU' after my fix, for both
> the tegra and qualcomm drivers, reverting the change from 498ba2a8a275
> ("cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration") that got failed
> to fix this problem. I'll resend it as a series of three patches with your R-b
> on this patch.
> 
> On a related note, I now see that the "||COMPILE_TEST" bit for the
> arm-specific cpuidle drivers is not all that useful because we can curently
> not hit that on non-ARM machines at all. I'll try changing that as well, but
> this is probably nontrivial.

Ack

