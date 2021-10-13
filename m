Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE6B42CDE8
	for <lists+linux-pm@lfdr.de>; Thu, 14 Oct 2021 00:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbhJMW1W (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Oct 2021 18:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231474AbhJMW1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Oct 2021 18:27:16 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1A8C061753;
        Wed, 13 Oct 2021 15:25:12 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p16so18440688lfa.2;
        Wed, 13 Oct 2021 15:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fAFM39F4OtwPo955+QYoKUKyjFO0/+s1I0jzyMsYoaM=;
        b=Ye/F4t82fRq9hE5UpPDLXL4Ugs2fkr3fSVTvglgFABcDT8wFVPcglXb326T25pMkz1
         SZefKfMX7YAlBb3KZizunAUzK2k5NFBUYZEZ8KkazEoB1opi/UErOdQcrTlJNHPta3z3
         jBltCmDx5C0cXHLd0Gf3kC/pnsUoEvzkAYJ8RtCbEfKy7D3//BXSSYpUevc16s67Yl7h
         eUez0KlyWHB00Kh4w1fcO0vcTyO54QO8I8fT3KrrOUKAlMbiIzzIkcHig6zQ8J9aL7xp
         Fu7LGW5s4HoAJz4mGowvRSDDsDcRmYjYAv+IACI3EMv1rJH2qGwzwOBG2m4N9mMKjwlO
         6f5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fAFM39F4OtwPo955+QYoKUKyjFO0/+s1I0jzyMsYoaM=;
        b=0mnFeAq+FmoCGos25CydEtX9z+PVOrrTnjubC/ZsJHZfOm44hsqw1xL4H/+DgXm2iM
         Txuv9tMwpNyqYmnaB0TRkX+A0to7TH2n4FGs0FcOJzUl9Uf/GHGwuPMsJMzngAKpqYeM
         v/l1ZZKclb6l3J5tnecRB8r25NptziTXAgz+8YPIdfmBDGIQRHvAMPbSjPGVbnhfQTig
         UpvLknEThbtk/l0LeuPb5EURWG8H0tEcadB6l3fIbVpGXa2OjhpsWUmPn1oslAxlLMF/
         CO1UAs1DHA02KlbH+XfgqtjE4jYrez9+n6iaJNMvk+JCfJME6XdtAFCw/sNAzAo3rj70
         dKRQ==
X-Gm-Message-State: AOAM5306mN52CWmFgPxBkA783+XwVEmSSfIypISyORNCtCusG4mNGoqO
        IFQhqjnAxiVfQf/gQYwBUHwshrOFXwc=
X-Google-Smtp-Source: ABdhPJxQeRUAFF7qtNBes2ye20CPQgrNe3xjiDBfonpUEPTpKAnP5XiBICdAv6vqSUOZEibQXfY86w==
X-Received: by 2002:a2e:530b:: with SMTP id h11mr2191203ljb.372.1634163910933;
        Wed, 13 Oct 2021 15:25:10 -0700 (PDT)
Received: from [192.168.2.145] (79-139-174-234.dynamic.spd-mgts.ru. [79.139.174.234])
        by smtp.googlemail.com with ESMTPSA id k14sm78185ljh.125.2021.10.13.15.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Oct 2021 15:25:10 -0700 (PDT)
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
 <7b4c1c31-3ef6-db9b-dc98-8a6f7a3d6243@gmail.com>
 <CAK8P3a0KKpfxfh=qZM8pQs51qxqLZMcn_RLC99mpR5eC4tX+4A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <e2ac7fc0-bd81-5e4f-c1a9-75af503c2cc5@gmail.com>
Date:   Thu, 14 Oct 2021 01:25:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0KKpfxfh=qZM8pQs51qxqLZMcn_RLC99mpR5eC4tX+4A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

14.10.2021 00:55, Arnd Bergmann пишет:
> On Wed, Oct 13, 2021 at 10:49 PM Dmitry Osipenko <digetx@gmail.com> wrote:
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
>> Arnd, thank you for the patch!
>>
>> Apparently ARM_QCOM_SPM_CPUIDLE doesn't have that problem visible
>> because it selects QCOM_SPM, which depends on ARCH_QCOM, and thus
>> ARCH_QCOM should be auto-selected(?).
> 
> No, that's not how it works. In fact ARM_QCOM_SPM_CPUIDLE has the
> exact same problem. I tried to check if there are other drivers affected
> by this problem before I sent my patch, but I did something wrong and
> missed this one.
> 
>> I'm curious whether this needs to
>> be corrected, otherwise (ARCH_QCOM || COMPILE_TEST) doesn't make much
>> sense for that driver. And then it will need the same Kconfig fix as well.
>>
>> I assume this problem wasn't caught by regular kernel build bots because
>> they don't test randconfig, don't they?
> 
> They do test randconfig builds, but only a few of them. This one is
> rather hard to hit, it probably took me 100 builds before I hit the first
> one and I haven't run into the QCOM one yet, though I did see a
> different issue for ARM_QCOM_SPM_CPUIDLE:
> 
> WARNING: unmet direct dependencies detected for QCOM_SPM
>   Depends on [n]: ARCH_QCOM [=n]
>   Selected by [y]:
>   - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64)
> && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

This is exactly what I expected, thank you for fixing all this!
