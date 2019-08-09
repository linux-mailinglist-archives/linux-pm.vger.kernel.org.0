Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C236D8819C
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 19:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407599AbfHIRug (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 13:50:36 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42735 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407597AbfHIRug (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 13:50:36 -0400
Received: by mail-lf1-f68.google.com with SMTP id s19so7430921lfb.9;
        Fri, 09 Aug 2019 10:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0Sw/1ZpNovS8GPU6ODyACBRq1n5M5z9Hj/A0TEehRpc=;
        b=jS9A76GubJnVatO7k3NABYv63ju5mshD/TETrek1lijcq/jbSPQCt6zahaAWnXevhi
         Gt6zxeNBm23WDf41yPsrBCZcRGf0PGbMhEn43V8NLayKWAd+n+fKOjOTTYpnDho7TUwU
         gFRC3NcdK6Ui3znt2gGHAkBpj7IkNGqhiKiLvCH8SyYg37UV0MDRsOum5FA8AoCEbEsv
         /EMozayAvs4Alfg7ObXiQwZ6zjKgqq/9GaOSVbJV0jJbQQYvW6VF6B+b07HufvoSizqb
         h1PfZQjl44IjfYzBsZ1OMxDYapaC1GH1VL/F0T9g4QIqfaY2vG+WsduozIsEBMe8WZQn
         ACZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0Sw/1ZpNovS8GPU6ODyACBRq1n5M5z9Hj/A0TEehRpc=;
        b=E1MAkXKNVWTXt93r0ryZaKW2wf7jnJVgsQ3FfYctq9lpRiBaJVytrR8sECzN44FZ8d
         c0FoU5iEKEOPffbMxdUIuFvya37DrDDwcorqKDsRPbsQo2pLYb4GwEW3TSefOOItegir
         jLv2pcRYJXeIqJFDvqlddotB7IjyQ3XE/0HdDQUtu8Ri/KRYR3NkYAF2FWmcRZhVT4E8
         GqitGsU5bplK74mKCrK0c8IGdCVxqqN6rRpIvxZgGcjntTRKsNxRR2g8tkolpRgEoAT2
         08dDUAc+gixvEq1M0ph+FeOMvR7cJ9/853aPxasz0K92IAqaUa2QjH1JqzVq0Iwol17M
         jCzg==
X-Gm-Message-State: APjAAAWBzLjkwx+95LQ9F+qOcFX9ErmR6k6Qb7LftHEYB8R88YhMQ4I5
        Ss/l2eRi53sQttFGzOUB7MNC0ILM
X-Google-Smtp-Source: APXvYqxJ2RH0RMGbbTsBtD933maGRq1K3ihY3m2mpFLa4f7qn+LwKlmB0ArkeMtMq1u5Y+44ybD6CA==
X-Received: by 2002:ac2:5dd6:: with SMTP id x22mr13071555lfq.92.1565373033199;
        Fri, 09 Aug 2019 10:50:33 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id u21sm19568030lju.2.2019.08.09.10.50.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 10:50:32 -0700 (PDT)
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
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2eecf4ff-802d-7e0e-d971-0257fae4e3a2@gmail.com>
Date:   Fri, 9 Aug 2019 20:50:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <dd20aa34-d838-40c4-9edd-bbe5973053f3@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 20:39, Sowjanya Komatineni пишет:
> 
> On 8/9/19 4:33 AM, Dmitry Osipenko wrote:
>> 09.08.2019 2:46, Sowjanya Komatineni пишет:
>>> This patch implements save and restore of PLL context.
>>>
>>> During system suspend, core power goes off and looses the settings
>>> of the Tegra CAR controller registers.
>>>
>>> So during suspend entry pll context is stored and on resume it is
>>> restored back along with its state.
>>>
>>> Acked-by: Thierry Reding <treding@nvidia.com>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   drivers/clk/tegra/clk-pll.c | 88 ++++++++++++++++++++++++++++-----------------
>>>   drivers/clk/tegra/clk.h     |  2 ++
>>>   2 files changed, 58 insertions(+), 32 deletions(-)
>>>
>>> diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
>>> index 1583f5fc992f..e52add2bbdbb 100644
>>> --- a/drivers/clk/tegra/clk-pll.c
>>> +++ b/drivers/clk/tegra/clk-pll.c
>>> @@ -1008,6 +1008,28 @@ static unsigned long clk_plle_recalc_rate(struct clk_hw *hw,
>>>       return rate;
>>>   }
>>>   +static void tegra_clk_pll_restore_context(struct clk_hw *hw)
>>> +{
>>> +    struct tegra_clk_pll *pll = to_clk_pll(hw);
>>> +    struct clk_hw *parent = clk_hw_get_parent(hw);
>>> +    unsigned long parent_rate = clk_hw_get_rate(parent);
>>> +    unsigned long rate = clk_hw_get_rate(hw);
>>> +    u32 val;
>>> +
>>> +    if (clk_pll_is_enabled(hw))
>>> +        return;
>>> +
>>> +    if (pll->params->set_defaults)
>>> +        pll->params->set_defaults(pll);
>>> +
>>> +    clk_pll_set_rate(hw, rate, parent_rate);
>>> +
>>> +    if (!__clk_get_enable_count(hw->clk))
>> What about orphaned clocks? Is enable_count > 0 for them?
> There are no orphaned pll clocks.

Sorry, I meant the "clk_ignore_unused".
