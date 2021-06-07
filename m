Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2639D39DDCB
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 15:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbhFGNjz (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 09:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGNjz (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 09:39:55 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D46FC061766;
        Mon,  7 Jun 2021 06:37:51 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id v8so26296234lft.8;
        Mon, 07 Jun 2021 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lRMehmfHZcYJAVx0WUyZKmSVgdj8BgTPYFpCBqlVyAU=;
        b=rZEHcwZRuiTW+TaagQbAr7mjVuRphBFC01PEJwE+EUppCA1xXx42ulg0nRQt5rxAHY
         69hF/uBfIqPRYVfKV1F0/NMptfdbB5W6KpNx4hpMmeNlXXDhISFogZsTtFYTOsaQvHDz
         dASsSNyx4mHGXzQqFz0IBZ7CVV4ZI02F049tSIwdII0aOWmqkvM38SiMJ5O1Jqf75FKE
         MyRo5V7f1PwkPq0DCQBIBM3AJEDArOe6YLBxWbfx04ZIHu+OpoqgtO+6rYdewSilgW5M
         0GxC/xiU/t+U1JVAHsndoO7rWDADBidFwI9nR/lRIZK+ojQ0Dl2SW26wBKvA5rBs3LyZ
         76BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lRMehmfHZcYJAVx0WUyZKmSVgdj8BgTPYFpCBqlVyAU=;
        b=HlbX4M33RtQZx+la8E+2Ls+T6i1EnkivT4eunoa1YsTClKZJ8kyoF5WqBZFvkzKWHh
         E4dtn0zc6SZsEkU67dUj9VrXTkj+c27K15Fpmi5pGKWDUjEY9Q9Fo5NPprKwHzndBx5T
         wXJc7QOaT7ep8nL7J8P56110l2C+MFWgaXjKVBZiWFtXnSQ3w67dtPBzP9w6mL8z5PO8
         5TGHLrUvPVjGNPKX09BKp3TpwC4NvVsAIikCNQOPO60IbUGVhCDeXVsVjeFrDBXy9LgZ
         oU1q59NJt3e3xdr8GgmXFH+745hCGri0/pYEY+Z9ygqzX5O3nsQo62R43yPx5LWMAbLs
         UxYg==
X-Gm-Message-State: AOAM5303TU18URC9tm4FhIElaNrSWWltttfS6IkI3nU3wOCLJ0EMdXQo
        0MuawutbHGmZabwLmN3uH1pKfrEcywU=
X-Google-Smtp-Source: ABdhPJzkzlNBtcYquNR2vxBLPNUWLG3xsnTOuRRZMqFwkQkI4FHVi23K45sFGd+1RfVBkmVY37dImQ==
X-Received: by 2002:a19:dc5e:: with SMTP id f30mr12132778lfj.318.1623073068322;
        Mon, 07 Jun 2021 06:37:48 -0700 (PDT)
Received: from [192.168.2.145] (94-29-1-103.dynamic.spd-mgts.ru. [94.29.1.103])
        by smtp.googlemail.com with ESMTPSA id d27sm647075lfv.261.2021.06.07.06.37.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 06:37:48 -0700 (PDT)
Subject: Re: [PATCH v6 08/14] memory: tegra: Enable compile testing for all
 drivers
To:     Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210601023119.22044-1-digetx@gmail.com>
 <20210601023119.22044-9-digetx@gmail.com>
 <41899ef4-bb16-6c3a-035c-1e840a993bec@canonical.com>
 <YL4gwxWopKT7LomG@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c4839740-09d3-0f2b-e115-67bd74ad336d@gmail.com>
Date:   Mon, 7 Jun 2021 16:37:47 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL4gwxWopKT7LomG@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.06.2021 16:36, Thierry Reding пишет:
> On Mon, Jun 07, 2021 at 08:01:28AM +0200, Krzysztof Kozlowski wrote:
>> On 01/06/2021 04:31, Dmitry Osipenko wrote:
>>> Enable compile testing for all Tegra memory drivers.
>>>
>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>> ---
>>>  drivers/memory/tegra/Kconfig | 16 ++++++++++------
>>>  1 file changed, 10 insertions(+), 6 deletions(-)
>>>
>>
>> Hi Dmitry,
>>
>> This fails on x86_64 and i386:
>> https://krzk.eu/#/builders/38/builds/260
>> https://krzk.eu/#/builders/40/builds/261
>>
>> /bin/ld: warning: orphan section `__reservedmem_of_table' from `drivers/memory/tegra/tegra210-emc-table.o' being placed in section `__reservedmem_of_table'
>> /bin/ld: drivers/memory/tegra/mc.o: in function `tegra_mc_probe':
>> mc.c:(.text+0x87a): undefined reference to `reset_controller_register'
>> make[1]: *** [/home/buildbot/worker/builddir/build/Makefile:1191: vmlinux] Error 1
>>
>> It's a defconfig with:
>> scripts/config --file out/.config -e COMPILE_TEST -e OF -e SRAM -e
>> MEMORY -e PM_DEVFREQ -e ARM_PL172_MPMC -e ATMEL_SDRAMC -e ATMEL_EBI -e
>> BRCMSTB_DPFE -e BT1_L2_CTL -e TI_AEMIF -e TI_EMIF -e OMAP_GPMC -e
>> TI_EMIF_SRAM -e MVEBU_DEVBUS -e FSL_CORENET_CF -e FSL_IFC -e JZ4780_NEMC
>> -e MTK_SMI -e DA8XX_DDRCTL -e PL353_SMC -e RENESAS_RPCIF -e
>> STM32_FMC2_EBI -e SAMSUNG_MC -e EXYNOS5422_DMC -e EXYNOS_SROM -e
>> TEGRA_MC -e TEGRA20_EMC -e TEGRA30_EMC -e TEGRA124_EMC -e
>> TEGRA210_EMC_TABLE -e TEGRA210_EMC
> 
> Ugh... that's exactly one of the reasons why I dislike COMPILE_TEST...
> though admittedly it does point out a missing dependency here. I think
> we need to add && RESET_CONTROLLER to that || branch of the depends on
> to fix that. ARCH_TEGRA selects RESET_CONTROLLER explicitly, so the
> COMPILE_TEST branch needs to mirror that.
> 
> Either that, or I suppose we could add the depends on RESET_CONTROLLER
> explicitly to TEGRA_MC, or perhaps even select it (although that could
> cause conflicts down the road, but should be fine right now because
> RESET_CONTROLLER doesn't have any other dependencies right now).

The select will work.

The other option is to add stubs for the reset controller API.

