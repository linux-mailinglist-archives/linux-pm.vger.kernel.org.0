Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE80A8A33D
	for <lists+linux-pm@lfdr.de>; Mon, 12 Aug 2019 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbfHLQZ6 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 12 Aug 2019 12:25:58 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45092 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfHLQZ6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 12 Aug 2019 12:25:58 -0400
Received: by mail-lj1-f194.google.com with SMTP id t3so10313491ljj.12;
        Mon, 12 Aug 2019 09:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GI6J9XP3pqv3peenMEorRXV7kifC4hCSkeYYvQzRZRE=;
        b=EsGauHJYxiqMkoas+2xMeBkvnF3ACWsFulwbbWK6xcxokGm7hvwTFRa6buzOz4T9ds
         jniqLavLRnLjy254zAypsvVGdjkErbXnTC99AviNnahqllmsN2NF63k/X8icI6Jy8rOm
         NnChb7RC/VE1Viu5SPR0llg/TZ4XA2Ui5CIiCCz4ITF1g4mLPjNbbWee/2yVGokGkBDn
         FWu/R3+vu/DhL4qY2LaxQ+uFKa/v5xkpchg9shDYcsYqANr61kFtWszG+2qexrbOjmxD
         /VeOKqh4f/OnIDol5iTjk1PoLHc2Lj+aZ9bN/mG+YhMsxObixpGVzJ7p650xWycBPSpQ
         /ZaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GI6J9XP3pqv3peenMEorRXV7kifC4hCSkeYYvQzRZRE=;
        b=bWYy4D8MfGgLfi38ikLrrDJOOJceLOTUx04Qsh5sGR5Hy8OV1PSX4GWBLf6fzMU7D3
         NG+n2agLZ67gZkYkKTY7RX/hXDf3MoqEjnIPWfIbZ2QhYJEo0w3t8bCFh3OYldii0lNa
         Nohs7+ghVLDTO5cX56hdVnkuAZ9J6l1qRhbc3EM45lK1LV1n656JMmdaJECx4O35j+/C
         bQCcEBE7HGsGnSUEGEEfblogWAzYlO9JkQy/kpvYAyOch6gCC7NmQghtXkoYQ/s9kRAM
         Ew2HosYCLd3R0H0cQJpW/4jFWJHnbrbVyyStHo0AxdRiHMaQLUQqopxsF7H50iygrV81
         qR5Q==
X-Gm-Message-State: APjAAAX9s4wCKmxbqR9HiWYz9S2r5UH8OuDj/BS7yXSLVsgURUc5tshK
        oD8poB9BcFWjmlKoZ50IMWMgPA6s
X-Google-Smtp-Source: APXvYqzkXyua3oFU5JpcZpNak3XRgGn9/2qHScbS3JmEAeENKgdqTBKVrQGPMyIyJ7xA1Zo3vsQeeA==
X-Received: by 2002:a2e:2d12:: with SMTP id t18mr19881109ljt.175.1565627153837;
        Mon, 12 Aug 2019 09:25:53 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id p15sm21425233lji.80.2019.08.12.09.25.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 09:25:52 -0700 (PDT)
Subject: Re: [PATCH v8 14/21] clk: tegra210: Add suspend and resume support
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, tglx@linutronix.de,
        jason@lakedaemon.net, marc.zyngier@arm.com,
        linus.walleij@linaro.org, stefan@agner.ch, mark.rutland@arm.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com, sboyd@kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        jckuo@nvidia.com, josephl@nvidia.com, talho@nvidia.com,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        mperttunen@nvidia.com, spatra@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, rjw@rjwysocki.net,
        viresh.kumar@linaro.org, linux-pm@vger.kernel.org
References: <1565308020-31952-1-git-send-email-skomatineni@nvidia.com>
 <1565308020-31952-15-git-send-email-skomatineni@nvidia.com>
 <a21b7464-62c3-8461-04c2-a0e863bdde85@gmail.com>
 <7d101ec9-c559-8b40-1764-6bf67a9c7a7a@nvidia.com>
 <aa823801-00c7-df88-0f63-45338bffa854@gmail.com>
 <cbe94f84-a17b-7e1a-811d-89db571784e1@nvidia.com>
 <4397de5d-772d-2b04-5f87-b2988f6c96c8@gmail.com>
 <805a825e-f19d-d056-83eb-8ed1cb1c089c@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <ca90bd2b-8088-8b46-2816-95e58a4811b8@gmail.com>
Date:   Mon, 12 Aug 2019 19:25:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <805a825e-f19d-d056-83eb-8ed1cb1c089c@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.08.2019 22:15, Sowjanya Komatineni пишет:
> 
> On 8/11/19 10:39 AM, Dmitry Osipenko wrote:
>> 09.08.2019 21:40, Sowjanya Komatineni пишет:
>>> On 8/9/19 11:18 AM, Dmitry Osipenko wrote:
>>>> 09.08.2019 19:19, Sowjanya Komatineni пишет:
>>>>> On 8/9/19 6:56 AM, Dmitry Osipenko wrote:
>>>>>> 09.08.2019 2:46, Sowjanya Komatineni пишет:
>>>>>>> This patch adds support for clk: tegra210: suspend-resume.
>>>>>>>
>>>>>>> All the CAR controller settings are lost on suspend when core
>>>>>>> power goes off.
>>>>>>>
>>>>>>> This patch has implementation for saving and restoring all PLLs
>>>>>>> and clocks context during system suspend and resume to have the
>>>>>>> clocks back to same state for normal operation.
>>>>>>>
>>>>>>> Clock driver suspend and resume are registered as syscore_ops as clocks
>>>>>>> restore need to happen before the other drivers resume to have all their
>>>>>>> clocks back to the same state as before suspend.
>>>>>>>
>>>>>>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>>>>>>> ---
>>>>>>>    drivers/clk/tegra/clk-tegra210.c | 103 +++++++++++++++++++++++++++++++++++++--
>>>>>>>    drivers/clk/tegra/clk.c          |  64 ++++++++++++++++++++++++
>>>>>>>    drivers/clk/tegra/clk.h          |   3 ++
>>>>>>>    3 files changed, 166 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/clk/tegra/clk-tegra210.c b/drivers/clk/tegra/clk-tegra210.c
>>>>>>> index 998bf60b219a..8dd6f4f4debb 100644
>>>>>>> --- a/drivers/clk/tegra/clk-tegra210.c
>>>>>>> +++ b/drivers/clk/tegra/clk-tegra210.c
>>>>>>> @@ -9,13 +9,13 @@
>>>>>>>    #include <linux/clkdev.h>
>>>>>>>    #include <linux/of.h>
>>>>>>>    #include <linux/of_address.h>
>>>>>>> +#include <linux/syscore_ops.h>
>>>>>>>    #include <linux/delay.h>
>>>>>>>    #include <linux/export.h>
>>>>>>>    #include <linux/mutex.h>
>>>>>>>    #include <linux/clk/tegra.h>
>>>>>>>    #include <dt-bindings/clock/tegra210-car.h>
>>>>>>>    #include <dt-bindings/reset/tegra210-car.h>
>>>>>>> -#include <linux/iopoll.h>
>>>>>>>    #include <linux/sizes.h>
>>>>>>>    #include <soc/tegra/pmc.h>
>>>>>>>    @@ -220,11 +220,15 @@
>>>>>>>    #define CLK_M_DIVISOR_SHIFT 2
>>>>>>>    #define CLK_M_DIVISOR_MASK 0x3
>>>>>>>    +#define CLK_MASK_ARM    0x44
>>>>>>> +#define MISC_CLK_ENB    0x48
>>>>>>> +
>>>>>>>    #define RST_DFLL_DVCO 0x2f4
>>>>>>>    #define DVFS_DFLL_RESET_SHIFT 0
>>>>>>>      #define CLK_RST_CONTROLLER_RST_DEV_Y_SET 0x2a8
>>>>>>>    #define CLK_RST_CONTROLLER_RST_DEV_Y_CLR 0x2ac
>>>>>>> +#define CPU_SOFTRST_CTRL 0x380
>>>>>>>      #define LVL2_CLK_GATE_OVRA 0xf8
>>>>>>>    #define LVL2_CLK_GATE_OVRC 0x3a0
>>>>>>> @@ -2825,6 +2829,7 @@ static int tegra210_enable_pllu(void)
>>>>>>>        struct tegra_clk_pll_freq_table *fentry;
>>>>>>>        struct tegra_clk_pll pllu;
>>>>>>>        u32 reg;
>>>>>>> +    int ret;
>>>>>>>          for (fentry = pll_u_freq_table; fentry->input_rate; fentry++) {
>>>>>>>            if (fentry->input_rate == pll_ref_freq)
>>>>>>> @@ -2853,9 +2858,14 @@ static int tegra210_enable_pllu(void)
>>>>>>>        reg |= PLL_ENABLE;
>>>>>>>        writel(reg, clk_base + PLLU_BASE);
>>>>>>>    -    readl_relaxed_poll_timeout_atomic(clk_base + PLLU_BASE, reg,
>>>>>>> -                      reg & PLL_BASE_LOCK, 2, 1000);
>>>>>>> -    if (!(reg & PLL_BASE_LOCK)) {
>>>>>>> +    /*
>>>>>>> +     * During clocks resume, same PLLU init and enable sequence get
>>>>>>> +     * executed. So, readx_poll_timeout_atomic can't be used here as it
>>>>>>> +     * uses ktime_get() and timekeeping resume doesn't happen by that
>>>>>>> +     * time. So, using tegra210_wait_for_mask for PLL LOCK.
>>>>>>> +     */
>>>>>>> +    ret = tegra210_wait_for_mask(&pllu, PLLU_BASE, PLL_BASE_LOCK);
>>>>>>> +    if (ret) {
>>>>>>>            pr_err("Timed out waiting for PLL_U to lock\n");
>>>>>>>            return -ETIMEDOUT;
>>>>>>>        }
>>>>>>> @@ -3288,6 +3298,84 @@ static void tegra210_disable_cpu_clock(u32 cpu)
>>>>>>>    }
>>>>>>>      #ifdef CONFIG_PM_SLEEP
>>>>>>> +/*
>>>>>>> + * This array lists mask values for each peripheral clk bank
>>>>>>> + * to mask out reserved bits during the clocks state restore
>>>>>>> + * on SC7 resume to prevent accidental writes to these reserved
>>>>>>> + * bits.
>>>>>>> + */
>>>>>>> +static u32 periph_clk_rsvd_mask[TEGRA210_CAR_BANK_COUNT] = {
>>>>>> Should be more natural to have a "valid_mask" instead of "rsvd_mask".
>>>>>>
>>>>>> What's actually wrong with touching of the reserved bits? They must be NO-OP.. or the
>>>>>> reserved bits are actually some kind of "secret" bits? If those bits have some use-case
>>>>>> outside of Silicon HW (like FPGA simulation), then this doesn't matter for upstream
>>>>>> and you
>>>>>> have to keep the workaround locally in the downstream kernel or whatever.
>>>>> Will rename as valid_mask.
>>>>>
>>>>> some bits in these registers are undefined and is not good to write to these bits as they
>>>>> can cause pslverr.
>>>> Okay, it should be explained in the comment.
>>>>
>>>> Is it possible to disable trapping of changing the undefined bits?
>>> No its internal to design
>> Okay.
>>
>> Also, what about to move the valid_mask into struct tegra_clk_periph_regs?
> 
> No, we cannot move to tegra_clk_periph_regs as its in tegra/clk.c and is common for all tegra.
> 
> Reserved bits are different on tegra chips so should come from Tegra chip specific clock
> driver like
> 
> clk-tegra210 for Tegra210.

Could you please check whether the reserved bits are RAZ (read as zero)?

[snip]
