Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D268928E0B5
	for <lists+linux-pm@lfdr.de>; Wed, 14 Oct 2020 14:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388093AbgJNMpP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 14 Oct 2020 08:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388065AbgJNMpO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2020 08:45:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E588C061755
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 05:45:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h7so3704275wre.4
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2020 05:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=EMapByy2fAc6++BOyKztEzWls2USsjIizauk4KxzZh4=;
        b=T8uE5EbGueyPLQ1fvPPfJG2HSY2ZDx5iultP9xHkJ3999QTaoV7bS/xr6h9DutOHXx
         AcNTt0I9+yCzg3XXRzIvxGkylUfwD6011TQc+GhzgcFrIxgKyINXrtbfpfoU4I+uIVoP
         /y173JB7Vzwd6E9sncKv5YKuHWQEPd1gg0yuZ73LyzYu/jEqFyMpT8/MaVV4YtdMsKSi
         oWlFd0Gbxs/abVwH4vxlOaPDsX5n+Tg7iP57mE+olMygmWZ++rMnh4PnmkPLAwwcEJcn
         0W+0Z9PP6Pf0RApT9IkDGWGHHW2fy7VaZDc0mKUrFGrLBY38L/GQlnsE6KL5RyMh6RSA
         1YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EMapByy2fAc6++BOyKztEzWls2USsjIizauk4KxzZh4=;
        b=gNdMO2MTA4FMhE/qi0eF/iqMDlFwp74692tHeKZV0fQpvD+RPecEJ5rUP9KJPrvAxL
         BWWe1kKEMlQ2kXGD0qCRlXj1D8bMoiUeB7lx5+RO0zTNjGd1uzxjL7iO+z7cZaesySEQ
         h9YJoKKXvY1HXZqRqbGi71UgAwZNaWbAdyN17fyA8LRlWxKxi3ExdPJAaHb51LxZEW1H
         D0+KPfZ7O17wwIYOlG3JOXDKE9d+2+ILKTvwAoJ8gp8izPKgA/mRcvtlA0uRBUWWirKN
         FMD8dec7uWubUgCHGjKB1UIrbP+q8GPSD5jU81e06q62qhGWNE3G8+UH/c+/rUokPrWE
         H2Fw==
X-Gm-Message-State: AOAM532e7TZuSGrBbwzV8EfDyss8gjysR9x06ZWViD17SzBDAMg4MEuO
        mdq7/W4OmBJC2pKf6lbnwQpfaw==
X-Google-Smtp-Source: ABdhPJxkIspNczPzlCDJuItLgQOW0KRMh8pX697txPu2VTFUvryZR+JGUBdJMBq7s9cVTRGj2Q90ZA==
X-Received: by 2002:adf:814f:: with SMTP id 73mr5313760wrm.174.1602679511938;
        Wed, 14 Oct 2020 05:45:11 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f? ([2a01:e34:ed2f:f020:8b3:b79b:6fb0:3e8f])
        by smtp.googlemail.com with ESMTPSA id g144sm4023323wmg.30.2020.10.14.05.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2020 05:45:11 -0700 (PDT)
Subject: Re: [PATCH 0/3] Add upper and lower limits in IPA power budget
 calculation
To:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     amitk@kernel.org, Dietmar.Eggemann@arm.com,
        michael.kao@mediatek.com, rui.zhang@intel.com
References: <20201007122256.28080-1-lukasz.luba@arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <b19909fb-7a1c-96b2-9c04-ff8670d9e421@linaro.org>
Date:   Wed, 14 Oct 2020 14:45:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007122256.28080-1-lukasz.luba@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 07/10/2020 14:22, Lukasz Luba wrote:
> Hi all,
> 
> This patch set makes thermal governor Intelligent Power Allocation (IPA)
> aware of cooling device limits for upper and lower bounds and respects them
> in the internal power budget calculation.
> The patch set should be applied on top of some already posted IPA changes [1][2].
> 
> Regards,
> Lukasz
> 
> [1] https://lore.kernel.org/linux-pm/20201002122416.13659-1-lukasz.luba@arm.com/
> [2] https://lore.kernel.org/linux-pm/9ecedd8a-fbc3-895c-d79c-f05af5c90ae5@arm.com/T/#t
> 
> Lukasz Luba (3):
>   thermal: power_allocator: respect upper and lower bounds for cooling
>     device
>   thermal: core: remove unused functions in power actor section
>   thermal: move power_actor_set_power into IPA
> 
>  drivers/thermal/gov_power_allocator.c | 38 ++++++++++-
>  drivers/thermal/thermal_core.c        | 90 ---------------------------
>  drivers/thermal/thermal_core.h        |  6 --
>  3 files changed, 36 insertions(+), 98 deletions(-)

Thanks for this series. Except a comment in patch 1/3, it looks good to me.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
