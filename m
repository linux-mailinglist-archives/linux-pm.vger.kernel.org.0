Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C604C0F96
	for <lists+linux-pm@lfdr.de>; Wed, 23 Feb 2022 10:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbiBWJwe (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 23 Feb 2022 04:52:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239415AbiBWJwe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 23 Feb 2022 04:52:34 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393F04DF74
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 01:52:06 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p184-20020a1c29c1000000b0037f76d8b484so3904632wmp.5
        for <linux-pm@vger.kernel.org>; Wed, 23 Feb 2022 01:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=YoIQETZNiNSTyr2BJ/2MHgHvWpDqddGsgRS7MhKf4to=;
        b=E1M7o8rwgCxNFCW+d1Fjey13k8AXpaMRSRO2rr+CGOB4RDAiwg7OIGbLritYaQ1Jpr
         jZp5dSg9SN5BlP97kcEodaI2O02XznEbtiwOfyP1Fko9gRz91yA57C9IkvkniH9nZXyx
         Abfvy6Q+ML+wzxYdtjjxiPvCgrfMe+uHuKttW8Ga1MB46oj3JUnrdLxmEMBI7t4J0ERn
         Ly0ShQUw/0NuBfKG6v7jGch49L2S4Vq4+hVNVHSN4tTClRzamqNfa4xPakiacFxeu1s7
         nGRi8BRwwlVbXU08PJBURMBfG8lHQ/m3PzXHDT2Vl6CqOMOivRrRLHDUdHX9+ZoeTXLU
         7SDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YoIQETZNiNSTyr2BJ/2MHgHvWpDqddGsgRS7MhKf4to=;
        b=cgBK9uBLDIoscJu+zv8k8KfUn2VWVyK086pbABvDaLWs8Z+CLWSt7H3PXWrQBlbvvo
         eNY+BU7O7uh5xUXaeyMeR5GgZloe11cpi8iqfb/M0lvWh24VP1D+Qf7hhX/EX9m6Cp3p
         sr77suslU6b2tpaQhDOG1VoRpUy+CR0rOdTr33X5WHBl30r7oSjjT8LkGJHRvHNPpIeX
         0lXdtjXd4W6b+InQ2/SOYSIDgZSWAGJUV9SzALg4YCGoRxdRYgNXtucYYaAlok1dGWnE
         k/BuOp21HdJubbgPQpqzGHA0PiOzfRrX4TTuI43L83T9aEpiwBlRdSsMr0Iw3dldGW9r
         03sQ==
X-Gm-Message-State: AOAM5311P7n7o2p51Q2baOpGC9o/vOrBofZKVIikco+ggQDuvglTKgGp
        cnh0PyaXAJS1Daic7Kih+W+qYQ==
X-Google-Smtp-Source: ABdhPJy0VwwoooQfHbLqKpCv7uw1B7GMQRDRAJ2YXzL1EGhdNZBt8xLaWqe3gjc5/40/LXVwaMifeQ==
X-Received: by 2002:a05:600c:6c5:b0:380:dda2:d562 with SMTP id b5-20020a05600c06c500b00380dda2d562mr5293043wmn.138.1645609924666;
        Wed, 23 Feb 2022 01:52:04 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a? ([2a01:e34:ed2f:f020:7f69:edd5:61dd:b18a])
        by smtp.googlemail.com with ESMTPSA id e3sm1510091wrw.41.2022.02.23.01.52.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 01:52:04 -0800 (PST)
Message-ID: <467a7de4-df84-8e9e-a26a-80449ca55950@linaro.org>
Date:   Wed, 23 Feb 2022 10:52:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/2] Introduce 'advanced' Energy Model in DT
Content-Language: en-US
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Cc:     dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael@kernel.org, nm@ti.com, sboyd@kernel.org, mka@chromium.org,
        dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20220222140746.12293-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220222140746.12293-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Hi Lukasz,

why not extend the energy model to any kind of devices?

The changes are shyly proposing a new entry in the OPP table like that 
is the only place where power management can happen.

Is the approach to describe by small pieces here and there, specific 
attributes and let the kernel create an energy model from that soap?

I prefer the RFC approach where the energy model is described clearly 
but, IMHO, it should be more abstracted, without reference to frequency 
or whatever but index <-> power (t-uple or equation)

By this way, it could be possible to describe the battery with the 
different charges, the LCD bright light, etc ...


On 22/02/2022 15:07, Lukasz Luba wrote:
> Hi all,
> 
> This patch set solves a few issues:
> 1. It allows to register EM from DT, when the voltage information is not
>     available. (Some background of the issues present on Chromebook devices
>     can be checked at [1].)
> 2. It allows to register 'advanced' EM from the DT, which is more accurate
>     and reflects total power (dynamic + static).
> 
> Implementation details:
> It adds a new callback in OPP framework to parse the OPP node entry and
> read the "opp-microwatt". It's going to only work with OPP-v2, but it's
> agreed to be OK.
> 
> Comments, suggestions are very welcome.
> 
> changelog:
> v2:
> - implemented Viresh idea to add "opp-microwatt" into the OPP node entry in DT
> v1 [2]
> 
> Regards,
> Lukasz Luba
> 
> [1] https://lore.kernel.org/linux-pm/20220207073036.14901-2-lukasz.luba@arm.com/
> [2] https://lore.kernel.org/linux-pm/20220221225131.15836-1-lukasz.luba@arm.com/
> 
> Lukasz Luba (2):
>    dt-bindings: opp: Add 'opp-microwatt' entry in the OPP
>    OPP: Add 'opp-microwatt' parsing for advanced EM registration
> 
>   .../devicetree/bindings/opp/opp-v2-base.yaml  |  7 ++
>   drivers/opp/of.c                              | 70 +++++++++++++++++++
>   2 files changed, 77 insertions(+)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
