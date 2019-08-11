Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0B892E2
	for <lists+linux-pm@lfdr.de>; Sun, 11 Aug 2019 19:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfHKR3h (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 11 Aug 2019 13:29:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:32857 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKR3h (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 11 Aug 2019 13:29:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id z17so7916358ljz.0;
        Sun, 11 Aug 2019 10:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=G6hIjaWzlceVnrBcDFJgWVhjQPWlG10Ht4pFyddJzKE=;
        b=uKz2bRFMKoczaKuQN8c6gg2y4Fc2Yl4jHfk6861XSMV6YEQ8qye4YRoY1+HfKAnlsV
         4YHXoWq0Tr+2c8pno48DcyWkIjv6LJjLSA4RlDA3UObR20FonAZCgqArh/a5uxsGMi+7
         /QqHYeGnjT6Sx16ovbU+4pI340Kmf/tIwKH8pKok/wB+x8Dm00SEGJeycunc9+jNaeCF
         RNZ+OUVe46uLM4xt84dj0/EP19vWfLX41deT8njcytlwc1p02mvlFjfEOfmAMmkXjM9h
         ElmbAhaEoeF/JYHybZVc/D0yb80Q3j20tS535rwJ2aZPtvVE9jbQEodmZj1QlgC/gYPY
         r1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G6hIjaWzlceVnrBcDFJgWVhjQPWlG10Ht4pFyddJzKE=;
        b=pxvmt2cs4wq3F2FIvcni+J3H1Fzzm7DKWxA9wwNdScTnIdwxN074gI/ja6MnKXD8C6
         64oWkE2Adim6M8dz6r9p1kuo1n+UEvUoDloL/xiSCdRc56RyxMSnvT9YPzV2CchE19r7
         EfgupoZnSisZVyJfpYiZZ+qcaR+FmFLbwgdE+/2KpbzCdwtCorbzsKEM971RqrG6XLSt
         pynBNhL/7mVCW2F8YMvjBCB264C5RKsLR8HVTjz2lWspuWBvxQfxJcyZ3trv5qdrqWgv
         pgRxuFdlT3khsF/7rTpptZjfFjF5/lABqcvJ91mOCfUGqfrlz4c9VTmWnBGRsADmhivO
         P4XQ==
X-Gm-Message-State: APjAAAULpkClVyStHcZUw/YFH3b7+kIYNHEUyaEl2Ruq6rPEsP3cRgIW
        lgf2k/vhu0my+h90OB1jqyrhB07I
X-Google-Smtp-Source: APXvYqwDUcpyJCC8rZypYKqS0f/khMaIAX7wj33ZB34Fb18ckXW3nfFYzpNT+VIB5lGSKFX1ShcwXg==
X-Received: by 2002:a2e:9158:: with SMTP id q24mr17073599ljg.119.1565544573891;
        Sun, 11 Aug 2019 10:29:33 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id v4sm20508834lji.103.2019.08.11.10.29.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 10:29:33 -0700 (PDT)
Subject: Re: [PATCH v8 10/21] clk: tegra: clk-super: Add restore-context
 support
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
 <1565308020-31952-11-git-send-email-skomatineni@nvidia.com>
 <4e33bad9-8d5a-dcd7-c75e-db5843c9be4a@gmail.com>
 <12250cae-8850-ff1d-91b1-0a50cdab6fa1@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <0872c194-152e-da0f-31b5-8b0b2e8999d8@gmail.com>
Date:   Sun, 11 Aug 2019 20:29:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <12250cae-8850-ff1d-91b1-0a50cdab6fa1@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 20:08, Sowjanya Komatineni пишет:
> 
> On 8/9/19 5:17 AM, Dmitry Osipenko wrote:
>> 09.08.2019 2:46, Sowjanya Komatineni пишет:
>>> This patch implements restore_context for clk_super_mux and clk_super.
>>>
>>> During system supend, core power goes off the and context of Tegra
>>> CAR registers is lost.
>>>
>>> So on system resume, context of super clock registers are restored
>>> to have them in same state as before suspend.
>>>
>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>> ---
>>>   drivers/clk/tegra/clk-super.c | 21 +++++++++++++++++++++
>>>   1 file changed, 21 insertions(+)
>>>
>>> diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
>>> index e2a1e95a8db7..74c9e913e41c 100644
>>> --- a/drivers/clk/tegra/clk-super.c
>>> +++ b/drivers/clk/tegra/clk-super.c
>>> @@ -124,9 +124,18 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
>>>       return err;
>>>   }
>>>   +static void clk_super_mux_restore_context(struct clk_hw *hw)
>>> +{
>>> +    struct clk_hw *parent = clk_hw_get_parent(hw);
>>> +    int parent_id = clk_hw_get_parent_index(hw, parent);
>>> +
>>> +    clk_super_set_parent(hw, parent_id);
>> All Super clocks have a divider, including the "MUX". Thus I'm wondering
>> if there is a chance that divider's configuration may differ on resume
>> from what it was on suspend.
> 
> tegra_clk_register_super_mux which uses tegra_clk_super_mux_ops doesn't do divider rate
> programming.
> 
> I believe you are referring to sclk_divider, cclklp_divider, cclkg_divider...
> 
> these are registered as clk_divider and are restored during clk_divider resume.

Indeed, thanks for the clarification.
