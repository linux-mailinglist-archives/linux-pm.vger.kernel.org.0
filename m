Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAA803968BC
	for <lists+linux-pm@lfdr.de>; Mon, 31 May 2021 22:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhEaU3x (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 31 May 2021 16:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbhEaU3x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 31 May 2021 16:29:53 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418D8C061574;
        Mon, 31 May 2021 13:28:12 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q7so18368997lfr.6;
        Mon, 31 May 2021 13:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aFEQ7LJ4IndjWtKAkoh3+98OH1W1aYhIxJ7hGveYV50=;
        b=YRCowztTycQIsNDzf9BKRw1kQbZtkYO3FMXGKpGYrKPFxRmrPvSvWmswrx3Tx1XU+3
         J18hyoNZB3d1b9UmihrfUGlZ0U8mB25w2bSD6y6ZW5APnuEdseBV0HnqWb+Eq1mnpfUB
         XjC3LcR3CqE4p2si40a05Hp2y77n0PtErZsVvaGckkKv/NzynQ88wuXbaVMXCkiE/uZx
         JuZJh8ogVJ0LQVw/ZEx+RDsDBNcPcoIf9kydKWXDzngeeGlt4WA/LqmhEHqhLnb10yew
         x/dhKcryUjheetkEbD3UAX+jleEFpHWRs9oLMcAhWXwhJ1mr9aiSiyVUfTi1zJ5PLb5x
         uvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aFEQ7LJ4IndjWtKAkoh3+98OH1W1aYhIxJ7hGveYV50=;
        b=ODZ41mUYjwGdyNT1H3UxrVrSfKKPaf3s2rMZ53qKH6lYqDms9ky5r6uGbQuGBAVzgG
         rSkPpNc0EzuRMpYjjm863eavKjJP+orKxxscmbymz+xuDgYyGVroTR5dy12Uepv/e6WH
         wqAxQP6V9zbJeEzEpiiQ8flGKfeSC0zASfeyv+iH4OsC/NFdlYfrnDqcJs4LnYEte9Te
         71bDDfWHgR1HcmhEovwzL7MEqCmD/ct5kDEeOGmI4cyy12XcBtBIxBPwK1O7nt+23oLc
         RDx+s1w9+bZXQCO59HRsDngwKUmd/WV9IjkAk9Xb/eQimCcApe+aqK+4QdrITQQXvTiU
         r+yA==
X-Gm-Message-State: AOAM530ULNYVNvKAKAGbqZQuQjQ8M475Wp0cnyrv5cIjiyF6GfyxLd5S
        0nFl5ft3RbzzMu2J862lNHclwpRr0Ec=
X-Google-Smtp-Source: ABdhPJxrVJzozM2H0OXTG5vBM2BXsr+h97CO90rL70Ezk2OO0Q+BjGzwg21fv3PGu6nJ3ILNthGPNA==
X-Received: by 2002:ac2:5f05:: with SMTP id 5mr7273920lfq.2.1622492890505;
        Mon, 31 May 2021 13:28:10 -0700 (PDT)
Received: from [192.168.2.145] (79-139-170-222.dynamic.spd-mgts.ru. [79.139.170.222])
        by smtp.googlemail.com with ESMTPSA id g20sm1446777lfr.81.2021.05.31.13.28.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 May 2021 13:28:10 -0700 (PDT)
Subject: Re: [PATCH v5 2/3] soc/tegra: pmc: Add core power domain
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Paul Fertser <fercerpav@gmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
References: <20210516231755.24193-1-digetx@gmail.com>
 <20210516231755.24193-3-digetx@gmail.com> <YLTYayQD7ufuUsXJ@orome.fritz.box>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4df63546-8266-3579-a3f7-e133014a4ca6@gmail.com>
Date:   Mon, 31 May 2021 23:28:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YLTYayQD7ufuUsXJ@orome.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.05.2021 15:36, Thierry Reding пишет:
> On Mon, May 17, 2021 at 02:17:54AM +0300, Dmitry Osipenko wrote:
>> NVIDIA Tegra SoCs have multiple power domains, each domain corresponds
>> to an external SoC power rail. Core power domain covers vast majority of
>> hardware blocks within a Tegra SoC. The voltage of a power domain should
>> be set to a level which satisfies all devices within the power domain.
>> Add support for the core power domain which controls voltage state of the
>> domain. This allows us to support system-wide DVFS on Tegra20-210 SoCs.
>> The PMC powergate domains now are sub-domains of the core domain, this
>> requires device-tree updating, older DTBs are unaffected.
>>
>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T124
>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
>> ---
>>  drivers/soc/tegra/Kconfig  |  14 ++++
>>  drivers/soc/tegra/pmc.c    | 143 +++++++++++++++++++++++++++++++++++++
>>  include/soc/tegra/common.h |   6 ++
>>  3 files changed, 163 insertions(+)
> 
> Since this power domain code is all dealt with within the PMC driver,
> and the PMC driver is enabled on all platforms, how about if we avoid
> creating the additional SOC_TEGRA_COMMON kconfig option and instead
> make SOC_TEGRA_PMC list the dependencies?
> 
> No need to resend, I can make that change when I apply, if you agree.

This can be done. I'll send v6 with the fixed compile-testing anyways,
so will apply this change there too.

The most recent version of this patch is found in [1]. Sorry for sending
so many versions and creating confusion, I settled on a unified series
that takes all build dependencies into account.

[1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=246158

Thank you for the review.
