Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EDE38CFBD
	for <lists+linux-pm@lfdr.de>; Fri, 21 May 2021 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhEUVVK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 21 May 2021 17:21:10 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56378 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhEUVVK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 May 2021 17:21:10 -0400
Received: from mail-vs1-f71.google.com ([209.85.217.71])
        by youngberry.canonical.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <krzysztof.kozlowski@canonical.com>)
        id 1lkCYb-0000m2-HT
        for linux-pm@vger.kernel.org; Fri, 21 May 2021 21:19:45 +0000
Received: by mail-vs1-f71.google.com with SMTP id w23-20020a67d1970000b029022afcb86374so7428842vsi.3
        for <linux-pm@vger.kernel.org>; Fri, 21 May 2021 14:19:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6XBMA+HgnOtwY23bMWATi+tkzjIBgQg4ublZMIjdwFo=;
        b=d8rSlXqHErO+Ha3S2gSvEcM6ytvadcE+ihRxQTB85aQdyeNhnqVyxVuaFFd8EyGorO
         JFP33qoAYUEFf0XLvpnusN4DOYtLrNCMgmub8hx6dG9GGEkjIFC0icwuhIiEQlZvcTw4
         js2gjsmBJZEt5Lfa3I3czt1Fvs34SWqbKkeGpAD+r/ng9ApbnfomQ1gvMyCXdwFpDs/d
         uSjsXoQCkPoYHn/ZC1/bZYsgsrdD3WFfTB77fOwV/qFBavwbUmRM6jGpO+md6ZLnhdV9
         AR2BkMcbbreqLWFYDYeLEMPiTbY5i/deA9zboYILN7D6g0UfhqY5gHJlFiJKmjxRCHlY
         Zj5g==
X-Gm-Message-State: AOAM532l3/PBalozG/eLIqhge85rdM0KeDwuejslnwoWCHnLEcKpzZb9
        5ZrmeNPTHVqQf1dWTooUMfSSn8xJ40EJa25CRAGKGG7WozzEvY576I36/Ks3JjaE+mJv4WikSMa
        2Q0hQwZoU7YRFN4PUj5jTT/5tg7/FmOEHlIio
X-Received: by 2002:a05:6122:885:: with SMTP id 5mr12803005vkf.5.1621631984636;
        Fri, 21 May 2021 14:19:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhv1QL8qHnMj7beq1hVR/DBdqFRV/8WccGKOBWL6eMnDKVdIK/gtYPulvL1hnnq+STEvvfRQ==
X-Received: by 2002:a05:6122:885:: with SMTP id 5mr12802995vkf.5.1621631984486;
        Fri, 21 May 2021 14:19:44 -0700 (PDT)
Received: from [192.168.1.4] ([45.237.48.5])
        by smtp.gmail.com with ESMTPSA id t2sm100467vkk.17.2021.05.21.14.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 May 2021 14:19:43 -0700 (PDT)
Subject: Re: [PATCH v1 07/13] memory: tegra: Fix compilation warnings on 64bit
 platforms
To:     Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        =?UTF-8?Q?Nikola_Milosavljevi=c4=87?= <mnidza@outlook.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        Mikko Perttunen <mperttunen@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        linux-clk@vger.kernel.org
References: <20210520230751.26848-1-digetx@gmail.com>
 <20210520230751.26848-8-digetx@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Message-ID: <28c84274-b9a9-86a5-5b39-5aa07a87626e@canonical.com>
Date:   Fri, 21 May 2021 17:19:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210520230751.26848-8-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 20/05/2021 19:07, Dmitry Osipenko wrote:
> Fix compilation warning on 64bit platforms caused by implicit promotion
> of 32bit signed integer to a 64bit unsigned value which happens after
> enabling compile-testing of the EMC drivers.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/memory/tegra/tegra124-emc.c | 4 ++--
>  drivers/memory/tegra/tegra30-emc.c  | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

Let me know if I should take the memory part.

Best regards,
Krzysztof
