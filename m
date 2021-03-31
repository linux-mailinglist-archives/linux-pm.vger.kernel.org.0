Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1633503C4
	for <lists+linux-pm@lfdr.de>; Wed, 31 Mar 2021 17:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhCaPqF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 31 Mar 2021 11:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbhCaPpm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 Mar 2021 11:45:42 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A33C061574;
        Wed, 31 Mar 2021 08:45:41 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o16so10372710ljp.3;
        Wed, 31 Mar 2021 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Sg2M5vnLvA6N/v/unukjBIy2TElIYCrmD7g4frzymRQ=;
        b=rkkFwJ9Cpq5k0SUA92s1t0S+rpZf1whcRDyyhdYF+yvH3fJ0KJOD9TbUObQp19+2fw
         jDRmZCOQXy5+egCihBqXOdI3vaOo7iTf+81KhlvNjtfLU4UGfXe+m9j9P8s/N223jj5P
         kV2AbMwLHyDSvlM8yyrWOSUirPB892b0kMffK/xzpKLw3COLvH9/RcB7p2/FLlrYNDvn
         54LvMqE6zZPXp4r5n2pAk+imsO/ckDLs68Zn2Gx/e8FI2ZLDaJtabr2nuTFTfMt5hVKs
         D2r2d1G6PV1QxYpdjW8zNg84dU45ihBEWLc4vI/v+lrjvTVqmYLNChgExA8xotU2t2nn
         VVfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sg2M5vnLvA6N/v/unukjBIy2TElIYCrmD7g4frzymRQ=;
        b=FrxcAk1mYVwLa3Z8OYpLXumXgVB0g9WH8PBqMDvH93ub8gvFiDlMJTUOurrIMB/zJo
         AONlwt7N4dhS2WPYktr4c+GlwrRetEmw/Zr+hgSrkCh/u3w9EJIc8Dkv7vfikRapxl//
         BeWtmLBy2+lCLzT36oHfm9rN1xAYqTzOXNZzzLroJIhgMkHHRIuEsO4XC9uo/oIRCN5l
         B4Qf5xVeQJ8ivxGyCb93o7aXhfnItOLPfi6raEAY+zwBiKtScKwh96tgAOSUVvofWPk1
         8Z8wGv7ex0kg5p3z9ZUzT5dOeQyw1xmxtGUpQ9RQjeRS05j45Zm8gPBkqV8YO4mSin7z
         bR/g==
X-Gm-Message-State: AOAM530rtOZrZRyiqrIU315UEA7y1ZgBEBuFFgZ/VS8mP5nuqiEB4WC3
        jAdya5Msw/mQe+g1GsCqaCjV8T0GlPQ=
X-Google-Smtp-Source: ABdhPJxlLOpGqgOWnEgE7B4HJ0pcInOcka2zS2ofj5+/faiRKNsihhdztJFakPdBZVJRL1tzI5FcDQ==
X-Received: by 2002:a2e:b88c:: with SMTP id r12mr2476537ljp.212.1617205539966;
        Wed, 31 Mar 2021 08:45:39 -0700 (PDT)
Received: from ?IPv6:2a00:1370:814d:c71f:a10:76ff:fe69:21b6? ([2a00:1370:814d:c71f:a10:76ff:fe69:21b6])
        by smtp.googlemail.com with ESMTPSA id 203sm275275ljf.41.2021.03.31.08.45.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Mar 2021 08:45:39 -0700 (PDT)
Subject: Re: [PATCH v4 1/6] soc/tegra: Add
 devm_tegra_core_dev_init_opp_table()
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210314164810.26317-1-digetx@gmail.com>
 <20210314164810.26317-2-digetx@gmail.com>
 <8f78a014-eeab-d788-7d3b-b52b8109cb2c@gmail.com>
 <20210318103250.shjyd66pxw2g2nsd@vireshk-i7>
 <2498dd11-1d71-b245-2651-e43ab3f70e17@gmail.com>
Message-ID: <9115b38c-5d00-03e2-f51a-8c1ea15b9b6b@gmail.com>
Date:   Wed, 31 Mar 2021 18:45:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <2498dd11-1d71-b245-2651-e43ab3f70e17@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

18.03.2021 13:37, Dmitry Osipenko пишет:
> 18.03.2021 13:32, Viresh Kumar пишет:
>> On 18-03-21, 13:27, Dmitry Osipenko wrote:
>>> 14.03.2021 19:48, Dmitry Osipenko пишет:
>>>> Add common helper which initializes OPP table for Tegra SoC core devices.
>>>>
>>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>>>> ---
>>>>  drivers/soc/tegra/common.c | 137 +++++++++++++++++++++++++++++++++++++
>>>>  include/soc/tegra/common.h |  30 ++++++++
>>>>  2 files changed, 167 insertions(+)
>>>
>>> Viresh, do you think it will be possible to take this patch via the OPP
>>> tree along with the devres patches if Thierry will give an ack? This
>>> will allow us to start adding power management support to Tegra drivers
>>> once 5.13 will be released.
>>
>> I can do that.. OR
>>
>> I can give an immutable to Thierry over which he can base these patches..
>>
> 
> Thank you!
> 
> Thierry, please let us know if you're okay with this patch and what
> variant you prefer more.
> 

It's a bit too late now for 5.13, so I'll re-send this patch later on
for 5.14 separately and along with other patches that will make use of
this new helper.
