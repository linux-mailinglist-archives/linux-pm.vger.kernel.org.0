Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 488DBEB5CB
	for <lists+linux-pm@lfdr.de>; Thu, 31 Oct 2019 18:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728702AbfJaRHv (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 31 Oct 2019 13:07:51 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34401 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728597AbfJaRHv (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2019 13:07:51 -0400
Received: by mail-lj1-f195.google.com with SMTP id 139so7469639ljf.1;
        Thu, 31 Oct 2019 10:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xKp3WfNzfRPprkwSMJmaH7UF6M0QGd/6mj3T8rfzGeA=;
        b=g/94vjp3DxJKC4lpG7ZfRbS/LB/xMrDY/KGRdyNllSqD77GRT+A6/HUVDXfFuoZHDc
         srl4MMUeR/oY/P8mcNqpwaYGsFnhm2KFxfk8ZKWi17QvlK+Dl76WvczZ7DhvedD0Wgba
         A3L1NT1o+fA4L62RD0f/0n2ZwplZskiAbmWprihupOkZMzR6QcaQhPcD0nFuK1oPlzzK
         f/7GxwX9eraTh5cl3mV2g2fHbi5BdHWxT8z73v1HozhBDRGDHSPwxYxiJUcxDNVuba92
         GYGuqp53Utj5viWUgXD587JZEaGuGHUf3wbqCouQ9Dlkrq3MV9yL8pan7u5yXA3FGAQG
         oDUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xKp3WfNzfRPprkwSMJmaH7UF6M0QGd/6mj3T8rfzGeA=;
        b=apJBo4KYEM3QdiqgpFLrpJ9olQcu6BSel7vNoQRl1qn/OskImft5oWYhY1LR1AQV28
         isJWSQgxmW3AF6kZ6Tapsyl78lbRSd6uhO79ivHp3GQRtrppTIeRUcDtTAIFmu/zUftf
         6hrbyAFyT0qL8YkO9koxiGAvSTVKXE9g6Tq/uSBF5soLOpAysyTFsLq91woU3nJFxq9D
         bISpAFxs0u6DxN9NxYh59yk5cF8A2nK6swzyTEKAShEAAhqhthSqIbBZvj5bTkV5otaL
         DaEThaqu4szUCAmdbHBZsEQIIlS2lqDh9T14U/PUoPrcWQkbjLiQXrQpzliN8LEa8WZu
         HXog==
X-Gm-Message-State: APjAAAW9guW4JhD5m/klFGFX4Ioc006Us9QT635z0LwP9IV9w2iEWNHm
        r47I1MuzyEnPH4f9aGx5jDrYXTvD
X-Google-Smtp-Source: APXvYqxkyxPnYuZ6K5jJWpVjKNj99Ixk735u6swPjP+FCJR+/J3a75ogeSssFbIBeMTu30lUzJvNSw==
X-Received: by 2002:a2e:8e88:: with SMTP id z8mr4883420ljk.56.1572541666839;
        Thu, 31 Oct 2019 10:07:46 -0700 (PDT)
Received: from [192.168.2.145] (94-29-10-250.dynamic.spd-mgts.ru. [94.29.10.250])
        by smtp.googlemail.com with ESMTPSA id g26sm1924040lfh.1.2019.10.31.10.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 10:07:45 -0700 (PDT)
Subject: Re: [PATCH v3 01/10] clk: tegra: Add custom CCLK implementation
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191030213400.29434-1-digetx@gmail.com>
 <20191030213400.29434-2-digetx@gmail.com>
Message-ID: <50651277-d8db-0a38-3ca8-c991480c1e6a@gmail.com>
Date:   Thu, 31 Oct 2019 20:07:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191030213400.29434-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

31.10.2019 00:33, Dmitry Osipenko пишет:
> CCLK stands for "CPU Clock", CPU core is running off CCLK. CCLK supports
> multiple parents, it has internal clock divider and a clock skipper.
> PLLX is the main CCLK parent that provides clock rates above 1GHz and it
> has special property such that the CCLK's internal divider is set into
> bypass mode when PLLX is selected as a parent for CCLK.
> 
> This patch forks generic Super Clock into CCLK implementation which takes
> into account all CCLK specifics. The proper CCLK implementation is needed
> by the upcoming Tegra20 CPUFreq driver update that will allow to utilize
> the generic cpufreq-dt driver by moving intermediate clock selection into
> the clock driver.
> 
> Note that technically this patch could be squashed into clk-super.c, but
> it is cleaner to have a separate source file. Also note that currently all
> CCLKLP bits are left in the clk-super.c and only CCLKG is supported by
> clk-tegra-super-cclk. It shouldn't be difficult to move the CCLKLP bits,
> but CCLKLP is not used by anything in kernel and thus better not to touch
> it for now.
> 
> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> ---
>  drivers/clk/tegra/Makefile               |   1 +
>  drivers/clk/tegra/clk-tegra-super-cclk.c | 176 +++++++++++++++++++++++
>  drivers/clk/tegra/clk.h                  |  11 +-
>  3 files changed, 186 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/clk/tegra/clk-tegra-super-cclk.c
> 
> diff --git a/drivers/clk/tegra/Makefile b/drivers/clk/tegra/Makefile
> index df966ca06788..f04b490f5416 100644
> --- a/drivers/clk/tegra/Makefile
> +++ b/drivers/clk/tegra/Makefile
> @@ -14,6 +14,7 @@ obj-y					+= clk-tegra-audio.o
>  obj-y					+= clk-tegra-periph.o
>  obj-y					+= clk-tegra-pmc.o
>  obj-y					+= clk-tegra-fixed.o
> +obj-y					+= clk-tegra-super-cclk.o
>  obj-y					+= clk-tegra-super-gen4.o
>  obj-$(CONFIG_TEGRA_CLK_EMC)		+= clk-emc.o
>  obj-$(CONFIG_ARCH_TEGRA_2x_SOC)         += clk-tegra20.o
> diff --git a/drivers/clk/tegra/clk-tegra-super-cclk.c b/drivers/clk/tegra/clk-tegra-super-cclk.c
> new file mode 100644
> index 000000000000..5cff8363c978
> --- /dev/null
> +++ b/drivers/clk/tegra/clk-tegra-super-cclk.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Based on clk-super.c
> + * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
> + *
> + * Based on older tegra20-cpufreq driver by Colin Cross <ccross@google.com>
> + * Copyright (C) 2010 Google, Inc.
> + *
> + * Author: Dmitry Osipenko <digetx@gmail.com>
> + * Copyright (C) 2019 GRATE-DRIVER project
> + */
> +
> +#include <linux/bits.h>
> +#include <linux/clk-provider.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>
> +
> +#include "clk.h"
> +
> +#define PLLP_INDEX		4
> +#define PLLX_INDEX		8
> +
> +#define SUPER_CDIV_ENB		BIT(31)
> +
> +static u8 cclk_super_get_parent(struct clk_hw *hw)
> +{
> +	return tegra_clk_super_ops.get_parent(hw);
> +}
> +
> +static int cclk_super_set_parent(struct clk_hw *hw, u8 index)
> +{
> +	return tegra_clk_super_ops.set_parent(hw, index);
> +}
> +
> +static int cclk_super_set_rate(struct clk_hw *hw, unsigned long rate,
> +			       unsigned long parent_rate)
> +{
> +	return tegra_clk_super_ops.set_rate(hw, rate, parent_rate);
> +}
> +
> +static unsigned long cclk_super_recalc_rate(struct clk_hw *hw,
> +					    unsigned long parent_rate)
> +{
> +	if (cclk_super_get_parent(hw) == PLLX_INDEX)
> +		return parent_rate;
> +
> +	return tegra_clk_super_ops.recalc_rate(hw, parent_rate);
> +}
> +
> +static int cclk_super_determine_rate(struct clk_hw *hw,
> +				     struct clk_rate_request *req)
> +{
> +	struct clk_hw *pllp_hw = clk_hw_get_parent_by_index(hw, PLLP_INDEX);
> +	struct clk_hw *pllx_hw = clk_hw_get_parent_by_index(hw, PLLX_INDEX);
> +	struct tegra_clk_super_mux *super = to_clk_super_mux(hw);
> +	unsigned long pllp_rate;
> +	long rate = req->rate;
> +
> +	if (WARN_ON_ONCE(!pllp_hw || !pllx_hw))
> +		return -EINVAL;
> +
> +	/*
> +	 * Switch parent to PLLP for all CCLK rates that are suitable for PLLP.
> +	 * PLLX will be disabled in this case, saving some power.
> +	 */
> +	pllp_rate = clk_hw_get_rate(pllp_hw);
> +
> +	if (rate <= pllp_rate) {
> +		if (super->flags & TEGRA20_SUPER_CLK)
> +			rate = pllp_rate;
> +		else
> +			rate = tegra_clk_super_ops.round_rate(hw, rate,
> +							      &pllp_rate);
> +
> +		req->best_parent_rate = pllp_rate;
> +		req->best_parent_hw = pllp_hw;
> +		req->rate = rate;
> +	} else {
> +		rate = clk_hw_round_rate(pllx_hw, rate);
> +		req->best_parent_rate = rate;
> +		req->best_parent_hw = pllx_hw;
> +		req->rate = rate;
> +	}
> +
> +	if (WARN_ON_ONCE(rate <= 0))
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct clk_ops tegra_cclk_super_ops = {
> +	.get_parent = cclk_super_get_parent,
> +	.set_parent = cclk_super_set_parent,
> +	.set_rate = cclk_super_set_rate,
> +	.recalc_rate = cclk_super_recalc_rate,
> +	.determine_rate = cclk_super_determine_rate,
> +};
> +
> +static const struct clk_ops tegra_cclk_super_mux_ops = {
> +	.get_parent = cclk_super_get_parent,
> +	.set_parent = cclk_super_set_parent,
> +	.determine_rate = cclk_super_determine_rate,
> +};
> +
> +struct clk *tegra_clk_register_super_cclk(const char *name,
> +		const char * const *parent_names, u8 num_parents,
> +		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
> +		spinlock_t *lock)
> +{
> +	struct tegra_clk_super_mux *super;
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	u32 val;
> +
> +	super = kzalloc(sizeof(*super), GFP_KERNEL);
> +	if (!super)
> +		return ERR_PTR(-ENOMEM);
> +
> +	init.name = name;
> +	init.flags = flags;
> +	init.parent_names = parent_names;
> +	init.num_parents = num_parents;
> +
> +	super->reg = reg;
> +	super->lock = lock;
> +	super->width = 4;
> +	super->flags = clk_super_flags;
> +	super->hw.init = &init;
> +
> +	if (super->flags & TEGRA20_SUPER_CLK) {
> +		init.ops = &tegra_cclk_super_mux_ops;
> +	} else {
> +		init.ops = &tegra_cclk_super_ops;
> +
> +		super->frac_div.reg = reg + 4;
> +		super->frac_div.shift = 16;
> +		super->frac_div.width = 8;
> +		super->frac_div.frac_width = 1;
> +		super->frac_div.lock = lock;
> +		super->div_ops = &tegra_clk_frac_div_ops;
> +	}
> +
> +	/*
> +	 * Tegra30+ has the following CPUG clock topology:
> +	 *
> +	 *                                              OVERHEAT+----+
> +	 *        +---+  +-------+  +---+                            |
> +	 * PLLP+->+   +->+DIVIDER+->+0  |                            v
> +	 *        |   |  +-------+  |   |  +-------+               +-+-+
> +	 * PLLC+->+MUX|             |OUT+->+SKIPPER+-+------------>+0  |
> +	 *  ...   |   |             |   |  +-------+ |             |   |
> +	 * PLLX+->+-->+------------>+1  |            |             |OUT|->+CPU
> +	 *        +---+             +-+-+            |  +-------+  |   |
> +	 *                            ^              +->+ DIV2  +->+1  |
> +	 *                            |                 |SKIPPER|  +---+
> +	 *                PLLX_SEL+---+                 +-------+

Probably this will be a bit better:

       +---+  +-------+  +-+            +-+                +-+
PLLP+->+   +->+DIVIDER+->+0|  +-------->+0|  ------------->+0|
       |   |  +-------+  | |  |  +---+  | |  |             | |
PLLC+->+MUX|             | +->+  | S |  | +->+             | +>
 ...   |   |             | |  |  | K |  | |  |  +-------+  | |
PLLX+->+-->+------------>+1|  +->+ I +->+1|  +->+ DIV2  +->+1|
       +---+             +++     | P |  +++     |SKIPPER|  +++
                          ^      | P |   ^      +-------+   ^
                          |      | E |   |                  |
               PLLX_SEL+--+      | R |   |       OVERHEAT+--+
                                 +---+   |
                                         |
                        SUPER_CDIV_ENB+--+

[snip]
