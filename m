Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3E439DEFC
	for <lists+linux-pm@lfdr.de>; Mon,  7 Jun 2021 16:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbhFGOog (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 7 Jun 2021 10:44:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52873 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGOof (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 7 Jun 2021 10:44:35 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lqGSh-0000pK-8g
        for linux-pm@vger.kernel.org; Mon, 07 Jun 2021 14:42:43 +0000
Received: by mail-wr1-f69.google.com with SMTP id n2-20020adfb7420000b029010e47b59f31so7873185wre.9
        for <linux-pm@vger.kernel.org>; Mon, 07 Jun 2021 07:42:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LZouowOMeDZ6EndWSO8l3IpGbZlNHlcW3YYdxdPf/aY=;
        b=tgxoIgXBPiFW25PyJ3wDIBW73a70ZsOANCwXonVq6C2b72qoy0HW3HfWnyuiUB5AnL
         4OVmNXPIAJfBFU+0EHO5IQupJmwKMIKQlcVzHGQ+qnauakeyipw49w2lOsFueFTwD44q
         bdzbOAg5ysIKD5qQ/CEVQtXHC1z1JKLPaxVjFyECbi8JIFQz542R7crLcMvN5VzLLlTs
         oZRfXl4zM+ekrbopElTcZJi1PTjMoXYNDZnZYsMiJlaUQDb+vJBeo6NbeHv1aMCsodsB
         Qp1FfpZQD1ypwyg6CXKK3EIeRgIO4HAwalgPo87SYeeDiV61stwdAp3OJmRWhgG2yOym
         qTUg==
X-Gm-Message-State: AOAM533tbylwCKtsQYZAIAlJQpK1X586fPhuAoastEcBUNjTw9baDbs5
        QOObeye8j9pqrmtXc3SKEURIijA8yTeZOn0V9cDBYxDttllwv0xe9ApA7kIsqjMi/w4WXLX6Ypg
        UPht+m7PW5mAvfgr6KDNHVMuKLmrdXReouPwY
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr17120994wri.134.1623076962916;
        Mon, 07 Jun 2021 07:42:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyCR/qOJ2HOoz8Yaxcz1xb5SQF3ouTzcrIeE2rRHBxNtJtXVZtVdkLJ/2+fUMEntjBQHi/CIw==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr17120979wri.134.1623076962784;
        Mon, 07 Jun 2021 07:42:42 -0700 (PDT)
Received: from [192.168.1.115] (xdsl-188-155-185-9.adslplus.ch. [188.155.185.9])
        by smtp.gmail.com with ESMTPSA id l9sm14332397wme.21.2021.06.07.07.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 07:42:42 -0700 (PDT)
Subject: Re: [PATCH v6 08/14] memory: tegra: Enable compile testing for all
 drivers
To:     Thierry Reding <thierry.reding@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <e4896499-e593-aa5d-9b74-c5a3725e334d@canonical.com>
Date:   Mon, 7 Jun 2021 16:42:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YL4rBYkWHpeit66m@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/06/2021 16:19, Thierry Reding wrote:
> On Mon, Jun 07, 2021 at 05:01:02PM +0300, Dmitry Osipenko wrote:
>> 07.06.2021 16:36, Thierry Reding пишет:
>>>> /bin/ld: warning: orphan section `__reservedmem_of_table' from `drivers/memory/tegra/tegra210-emc-table.o' being placed in section `__reservedmem_of_table'
>>>> /bin/ld: drivers/memory/tegra/mc.o: in function `tegra_mc_probe':
>>>> mc.c:(.text+0x87a): undefined reference to `reset_controller_register'
>>>> make[1]: *** [/home/buildbot/worker/builddir/build/Makefile:1191: vmlinux] Error 1
>> ...
>>
>>> Not sure what to do about that orphaned __reservedmem_of_table section.
>>> Maybe all we need to do is to select OF_RESERVED_MEM from
>>> TEGRA210_EMC_TABLE?
>>
>> Select won't work easily, but the dependency for TEGRA210_EMC should.
> 
> Select works if I also select OF_EARLY_FLATTREE. That's slightly odd
> because typically that's something that the platform would select, but
> there's precedent for doing this in drivers/clk/x86/Kconfig, so I think
> it'd be fine.
> 
> The attached patch resolves both of the above issues for me.
> 
> Krzysztof: do you want to squash that into the problematic patch or do
> you want me to send this as a follow-up patch for you to apply? I guess
> the latter since you've already sent out the PR for Will and ARM SoC?

Follow up, please, but I am not sure about selecting reset controller.
From the tegra/mc.c code I see it can be optional - if "reset_ops" is
provided. Therefore I think:
1. Reset controller should provide proper stubs. This will fix building
of mc.c when reset controller is not chosen (regardless of point #2 below).

2. Specific drivers should depend on it. Selecting user-visible symbols
is rather discourage because might lead to circular dependencies.

Best regards,
Krzysztof
