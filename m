Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB14C39FA33
	for <lists+linux-pm@lfdr.de>; Tue,  8 Jun 2021 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhFHPVa (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 8 Jun 2021 11:21:30 -0400
Received: from mail-lf1-f48.google.com ([209.85.167.48]:33595 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFHPV3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 8 Jun 2021 11:21:29 -0400
Received: by mail-lf1-f48.google.com with SMTP id t7so25567274lff.0;
        Tue, 08 Jun 2021 08:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+ZQdXFWpJEUYm2HPd1TCaErdT12gtevimcDp8YdzDY4=;
        b=DFEB8wDt/p44yutjfofgv6kWLwjFVGzDUweIAXNcva3bPS4NzmE3CrMUhi5gdBtN3j
         M8+EORdTcFHID9lHno6kDtRRPjom9BEIFrwRbiyo8RDXD8xRIc4/hWfSssq4M9PY3B7K
         B8FSh8mmeLeNzt2Su9FXOGsJYtimo9pR9J8d3Z4lqeKkgOe/B4LGIaVwjE8AXjevjrBU
         08r9Gcb7ELphDeJsGUaS0l0Qw6/Y/tZLXMsvWnkG3sjJqxxradOvmyAdJQbKd4HFWVnS
         16UHLPE1ww6IrNjcr3EfLfL0QRNeGDgxX3/6sU18Aoo/KYe3G3kyZNLXgDALk8fPYzn8
         k58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+ZQdXFWpJEUYm2HPd1TCaErdT12gtevimcDp8YdzDY4=;
        b=X8UbsM5WaVfUq31w4EEnHYdajBTiGFiVSLyn0oYtAZMJEICputgUg/v0pEmRmXhXn2
         DKzXyDEZnV/ONWMmTYfJOPHHu/p/tI8hYEG6QNfuE7WmNGOVn0kfTwqacGE/0IR8bO72
         3SLoV5pswqqCIe04lnYY1F4XViSksf1bfrn6JhMW5x9oBGkJsldR+0ElYfl9Bps1BEHc
         uravlSy8BhUV5K7Pjp4n6mAWPkloasqiVIwnuIUZ/rvOl25QfMd6MO0hOsZWSsZa71Bt
         HduQ20nfKwP4cmj+ow3NWq+fjs4UJwSHoFP6++M68E9+395BWsPbh25jlngGwsyK9ywb
         LHKQ==
X-Gm-Message-State: AOAM530Y+A7q+stmjaTVS1tBeqwf3VleoGYHwRwQ9RPUOnfo4Hqy75O4
        R9KhgE+zGD098z7EAmQW3Yg2Qu17HfY=
X-Google-Smtp-Source: ABdhPJw43kpao7o3/u2SJFT6tQ9eJmDDDd6oDB9e5wQ933ARQOu4BWLkd7hkFiT6ABEfEQVidYDxqA==
X-Received: by 2002:a05:6512:310d:: with SMTP id n13mr15804450lfb.165.1623165514306;
        Tue, 08 Jun 2021 08:18:34 -0700 (PDT)
Received: from [192.168.2.145] (94-29-21-60.dynamic.spd-mgts.ru. [94.29.21.60])
        by smtp.googlemail.com with ESMTPSA id h24sm2107455lfp.60.2021.06.08.08.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jun 2021 08:18:33 -0700 (PDT)
Subject: Re: [PATCH v6 08/14] memory: tegra: Enable compile testing for all
 drivers
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>
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
 <a1f20257-f041-966e-c37e-5c81c4cf94d9@gmail.com>
 <YL4rBYkWHpeit66m@orome.fritz.box>
 <e4896499-e593-aa5d-9b74-c5a3725e334d@canonical.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <7595e6f2-327e-b80c-5e64-ccdec4700ddf@gmail.com>
Date:   Tue, 8 Jun 2021 18:18:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <e4896499-e593-aa5d-9b74-c5a3725e334d@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

07.06.2021 17:42, Krzysztof Kozlowski пишет:
> On 07/06/2021 16:19, Thierry Reding wrote:
>> On Mon, Jun 07, 2021 at 05:01:02PM +0300, Dmitry Osipenko wrote:
>>> 07.06.2021 16:36, Thierry Reding пишет:
>>>>> /bin/ld: warning: orphan section `__reservedmem_of_table' from `drivers/memory/tegra/tegra210-emc-table.o' being placed in section `__reservedmem_of_table'
>>>>> /bin/ld: drivers/memory/tegra/mc.o: in function `tegra_mc_probe':
>>>>> mc.c:(.text+0x87a): undefined reference to `reset_controller_register'
>>>>> make[1]: *** [/home/buildbot/worker/builddir/build/Makefile:1191: vmlinux] Error 1
>>> ...
>>>
>>>> Not sure what to do about that orphaned __reservedmem_of_table section.
>>>> Maybe all we need to do is to select OF_RESERVED_MEM from
>>>> TEGRA210_EMC_TABLE?
>>>
>>> Select won't work easily, but the dependency for TEGRA210_EMC should.
>>
>> Select works if I also select OF_EARLY_FLATTREE. That's slightly odd
>> because typically that's something that the platform would select, but
>> there's precedent for doing this in drivers/clk/x86/Kconfig, so I think
>> it'd be fine.
>>
>> The attached patch resolves both of the above issues for me.
>>
>> Krzysztof: do you want to squash that into the problematic patch or do
>> you want me to send this as a follow-up patch for you to apply? I guess
>> the latter since you've already sent out the PR for Will and ARM SoC?
> 
> Follow up, please, but I am not sure about selecting reset controller.
> From the tegra/mc.c code I see it can be optional - if "reset_ops" is
> provided. Therefore I think:
> 1. Reset controller should provide proper stubs. This will fix building
> of mc.c when reset controller is not chosen (regardless of point #2 below).
> 
> 2. Specific drivers should depend on it. Selecting user-visible symbols
> is rather discourage because might lead to circular dependencies.

Thierry, should I send the patches or you're willing to do it?

