Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAF8892D7
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 19:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfHKRYc (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 13:24:32 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35406 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfHKRYb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 13:24:31 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so72738888lfa.2;
        Sun, 11 Aug 2019 10:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/pMvHtk+M/m2BtPotUFGhDIVPX/VoDUBZOFj7Ex1OpE=;
        b=QhWmE08jXK6cT0R9qwXBbJVFKcHGm+8TQ1eixjtzcM/wkemUEM1du4hYazrXEndVpT
         y0FEZWbMqEAdHmGfM1bRGaHecgZyq68XcfRTbistQfxW1J6U5x6Xx24YQPF/XadUGgq2
         /9ySH0J9qBNlcMecSwyALJoRsuuCtSxh/89GGf23Fq11tcpl0yAJQa3ZjaKBesdfexxR
         8OFPaSIL2jCvgkgPELZvaoW8Qjrdpqlpsi3K+En/nRc8+S5qLNbAkYUVb98WDKRfJW3I
         9ZFytBnQ5ZDuEPxfqO1SH2dEHkMVPjMHifu9SMbYaN05ymxxYdAR2TPi5frIslL/unhR
         xnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/pMvHtk+M/m2BtPotUFGhDIVPX/VoDUBZOFj7Ex1OpE=;
        b=ZZWPW+2IkZNnW+3U4aul1nn44W1GJyhJlcOn4Bxkve/ShvYhwbrjMY1jCQfXID583h
         MUTkPJDIWohN/8rzc58NYxZxdxmcL99JpJ5JcGp7f5r0u1CCq34DsWGEf5vZ127/nRWX
         J/SWupMPfWmoxGish6zkULyvgAtq2vtL4AWGh9X4YxlWur8mXvUm/pxLNCi+pPMD9lUe
         hKMGrsGgTiEecXacfwADhwPsnfRrxQyI3IyibyG98XotIDKk5C0GsaJ04yDLtOV6Ombs
         f9AtQM8AbV59IoVyICjIQeWsvgJMatgN+9QnlLpNWcGF4Ivudghyy6YYXBlMEilvlb21
         YyFg==
X-Gm-Message-State: APjAAAWDx5qhMJwoB+B6QEwElYnynoqNCCTXPJVIV2Pg++6jOBk4KEVn
        lynxaC4QdXita8rIM7Y4yiO2n41+
X-Google-Smtp-Source: APXvYqx0eMIALFSSfkzuJmnIRn5B58WB5jzFU9BQ57A8l/Ytm7iKaxoVhpZr+BL1i3f5Su+zBPRzTA==
X-Received: by 2002:ac2:5976:: with SMTP id h22mr17733445lfp.79.1565544268454;
        Sun, 11 Aug 2019 10:24:28 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id q1sm20492867ljb.87.2019.08.11.10.24.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 10:24:27 -0700 (PDT)
Subject: Re: [PATCH v8 05/21] clk: tegra: pll: Save and restore pll context
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-6-git-send-email-skomatineni@nvidia.com>
 <68f65db6-44b7-1c75-2633-4a2fffd62a92@gmail.com>
 <dd20aa34-d838-40c4-9edd-bbe5973053f3@nvidia.com>
 <2eecf4ff-802d-7e0e-d971-0257fae4e3a2@gmail.com>
 <9096cbca-f647-b0af-2ab8-d48769555c3e@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <d289b682-1760-efe1-e6a5-5b51c476f1ed@gmail.com>
Date:   Sun, 11 Aug 2019 20:24:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <9096cbca-f647-b0af-2ab8-d48769555c3e@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 21:50, Sowjanya Komatineni пишет:
> 
> On 8/9/19 10:50 AM, Dmitry Osipenko wrote:
>> 09.08.2019 20:39, Sowjanya Komatineni пишет:
>>> On 8/9/19 4:33 AM, Dmitry Osipenko wrote:
>>>> 09.08.2019 2:46, Sowjanya Komatineni пишет:
>>>>> This patch implements save and restore of PLL context.
>>>>>
>>>>> During system suspend, core power goes off and looses the settings
>>>>> of the Tegra CAR controller registers.
>>>>>
>>>>> So during suspend entry pll context is stored and on resume it is
>>>>> restored back along with its state.
>>>>>
>>>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>> ---
>>>>>    drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++-----------------
>>>>>    drivers/clk/tegra/clk.h     |  2 ++
>>>>>    2 files changed, 58 insertions(+), 32 deletions(-)
>>>>>
>>>>> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
>>>>> index 1583f5fc992f..e52add2bbdbb 100644
>>>>> --- a/drivers/clk/tegra/clk-pll.c
>>>>> +++ b/drivers/clk/tegra/clk-pll.c
>>>>> @@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struct clk_hw *hw,
>>>>>        return rate;
>>>>>    }
>>>>>    +static void tegra_clk_pll_restore_context(struct clk_hw *hw)
>>>>> +{
>>>>> +    struct tegra_clk_pll *pll = to_clk_pll(hw);
>>>>> +    struct clk_hw *parent = clk_hw_get_parent(hw);
>>>>> +    unsigned long parent_rate = clk_hw_get_rate(parent);
>>>>> +    unsigned long rate = clk_hw_get_rate(hw);
>>>>> +    u32 val;
>>>>> +
>>>>> +    if (clk_pll_is_enabled(hw))
>>>>> +        return;
>>>>> +
>>>>> +    if (pll->params->set_defaults)
>>>>> +        pll->params->set_defaults(pll);
>>>>> +
>>>>> +    clk_pll_set_rate(hw, rate, parent_rate);
>>>>> +
>>>>> +    if (!__clk_get_enable_count(hw->clk))
>>>> What about orphaned clocks? Is enable_count > 0 for them?
>>> There are no orphaned pll clocks.
>> Sorry, I meant the "clk_ignore_unused".
> 
> clocks with CLK_IGNORE_UNUSED are taken care by clk driver.
> 
> clk_disable_unused checks for clocks with this flag and if they are not enabled it will
> enable them.
> 
> So by the time suspend happens enable_count is > 0

Okay.
