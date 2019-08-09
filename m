Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB8087917
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406638AbfHILzT (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 07:55:19 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35531 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406374AbfHILzT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 07:55:19 -0400
Received: by mail-lf1-f66.google.com with SMTP id p197so69285221lfa.2;
        Fri, 09 Aug 2019 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7Dk0IUHM38gePXuPnJcQWs6woRmICc2Sfnk5N9jHROY=;
        b=CHw+iblh/T0TAP092dyC0+mkS3a9L4c5UCcvy9tcg7tkhrayQi8xcfJZeFQbdQrvyY
         pzcS2FiXN+uyLODkLKYkk+tXSiLwYEGeD0VvtXXq8RkPHPnhuwP56IzynRPCNwWrAYA9
         cE+IFx5g6FB36M1ReRVo4HuJ759xFVn5G9yhUrrB+PTfudptknMK3VXlTbzdYU7MPKND
         Mvx4podHovEV329raVo9sG2MdCpI+4iYQnVicheg2BuN9opzkOIuvS/pR6VVRnze8R0H
         IObHLu2uOupWQFk2xHncZZMKzx0i+cMNLjXfh44z1Yrq/sCOjsrqgKpW2E1T5oI0YzPH
         C1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7Dk0IUHM38gePXuPnJcQWs6woRmICc2Sfnk5N9jHROY=;
        b=uNLOd9PPSB9SY5sE/ODRAoSvtAn7BPr93NqXf8MV5XyzowIxQg+nwuZ7ipmNj6c2gH
         5yzHIGZPJDusHVivNSzSqSaccQaZL0SbtHb1RX5ZiQ2gHl8NaNMT1Wc7pxIgv94eyzqy
         gSmzsy/Si675Ii3bOlL+30mPhVFOcqJ0ZR1nTV6NQJN0l/TXgNWghhlriiTWYT0XxuQt
         U2EjOVYBcs7ljt0tD91curBt6syJ4qD7nblx1Tdp9A8HVaO6HXMlvxA+xDkQFIMQg1jA
         gSLKiV++EaMoakDvpn+zN4ybm+ShhMQsdyxil2FGGS7WIk0IXKA10UlvF+XeQnYgi4mt
         nIpg==
X-Gm-Message-State: APjAAAXz6t6191dAUC9dbkerJmiZRrZe3eZVJQSwqQEz0T4FbNCfAKwl
        h8Ibqbj94qW1xOVHMRfKXLGrXggw
X-Google-Smtp-Source: APXvYqyVviYpNWisgymNhjYHi8j1qtWAONZnBQwbFO+/Hj+5p0AZb7Qdt+tD8KncAepElKrzWUbwRA==
X-Received: by 2002:ac2:43bc:: with SMTP id t28mr12887590lfl.14.1565351715595;
        Fri, 09 Aug 2019 04:55:15 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id u15sm19309007lji.61.2019.08.09.04.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 04:55:15 -0700 (PDT)
Subject: Re: [PATCH v8 08/21] clk: tegra: periph: Add restore_context support
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
 <1565308020-31952-9-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <5a5f9fb9-9cdd-5d91-4b0e-9bdb95b2625e@gmail.com>
Date:   Fri, 9 Aug 2019 14:55:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-9-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch implements restore_context support for clk-periph and
> clk-sdmmc-mux clock operations to restore clock parent and rates
> on system resume.
> 
> During system suspend, core power goes off and looses the context
> of the Tegra clock controller registers.
> 
> So on system resume, clocks parent and rate are restored back to
> the context before suspend based on cached data.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-periph.c    | 18 ++++++++++++++++++
>  drivers/clk/tegra/clk-sdmmc-mux.c | 12 ++++++++++++
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/clk/tegra/clk-periph.c b/drivers/clk/tegra/clk-periph.c
> index 58437da25156..c9d28cbadccc 100644
> --- a/drivers/clk/tegra/clk-periph.c
> +++ b/drivers/clk/tegra/clk-periph.c
> @@ -3,6 +3,7 @@
>   * Copyright (c) 2012, NVIDIA CORPORATION.  All rights reserved.
>   */
>  
> +#include <linux/clk.h>
>  #include <linux/clk-provider.h>
>  #include <linux/export.h>
>  #include <linux/slab.h>
> @@ -99,6 +100,20 @@ static void clk_periph_disable(struct clk_hw *hw)
>  	gate_ops->disable(gate_hw);
>  }
>  
> +static void clk_periph_restore_context(struct clk_hw *hw)
> +{
> +	struct tegra_clk_periph *periph = to_clk_periph(hw);
> +	const struct clk_ops *div_ops = periph->div_ops;
> +	struct clk_hw *div_hw = &periph->divider.hw;
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	int parent_id = clk_hw_get_parent_index(hw, parent);
> +
> +	if (!(periph->gate.flags & TEGRA_PERIPH_NO_DIV))
> +		div_ops->restore_context(div_hw);
> +
> +	clk_periph_set_parent(hw, parent_id);
> +}
> +
>  const struct clk_ops tegra_clk_periph_ops = {
>  	.get_parent = clk_periph_get_parent,
>  	.set_parent = clk_periph_set_parent,
> @@ -108,6 +123,7 @@ const struct clk_ops tegra_clk_periph_ops = {
>  	.is_enabled = clk_periph_is_enabled,
>  	.enable = clk_periph_enable,
>  	.disable = clk_periph_disable,
> +	.restore_context = clk_periph_restore_context,
>  };
>  
>  static const struct clk_ops tegra_clk_periph_nodiv_ops = {
> @@ -116,6 +132,7 @@ static const struct clk_ops tegra_clk_periph_nodiv_ops = {
>  	.is_enabled = clk_periph_is_enabled,
>  	.enable = clk_periph_enable,
>  	.disable = clk_periph_disable,
> +	.restore_context = clk_periph_restore_context,
>  };
>  
>  static const struct clk_ops tegra_clk_periph_no_gate_ops = {
> @@ -124,6 +141,7 @@ static const struct clk_ops tegra_clk_periph_no_gate_ops = {
>  	.recalc_rate = clk_periph_recalc_rate,
>  	.round_rate = clk_periph_round_rate,
>  	.set_rate = clk_periph_set_rate,
> +	.restore_context = clk_periph_restore_context,
>  };
>  
>  static struct clk *_tegra_clk_register_periph(const char *name,
> diff --git a/drivers/clk/tegra/clk-sdmmc-mux.c b/drivers/clk/tegra/clk-sdmmc-mux.c
> index a5cd3e31dbae..8db48966b100 100644
> --- a/drivers/clk/tegra/clk-sdmmc-mux.c
> +++ b/drivers/clk/tegra/clk-sdmmc-mux.c
> @@ -194,6 +194,17 @@ static void clk_sdmmc_mux_disable(struct clk_hw *hw)
>  	gate_ops->disable(gate_hw);
>  }
>  
> +static void clk_sdmmc_mux_restore_context(struct clk_hw *hw)
> +{
> +	struct clk_hw *parent = clk_hw_get_parent(hw);
> +	unsigned long parent_rate = clk_hw_get_rate(parent);
> +	unsigned long rate = clk_hw_get_rate(hw);
> +	int parent_id = clk_hw_get_parent_index(hw, parent);
> +
> +	clk_sdmmc_mux_set_parent(hw, parent_id);
> +	clk_sdmmc_mux_set_rate(hw, rate, parent_rate);

For the periph clocks you're restoring rate at first and then the
parent, while here it's the other way around. I'm wondering if there is
any difference in practice and thus whether rate's divider need to be
set to a some safe value before switching to a new parent that has a
higher clock rate than the old parent.

> +}
> +
>  static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
>  	.get_parent = clk_sdmmc_mux_get_parent,
>  	.set_parent = clk_sdmmc_mux_set_parent,
> @@ -203,6 +214,7 @@ static const struct clk_ops tegra_clk_sdmmc_mux_ops = {
>  	.is_enabled = clk_sdmmc_mux_is_enabled,
>  	.enable = clk_sdmmc_mux_enable,
>  	.disable = clk_sdmmc_mux_disable,
> +	.restore_context = clk_sdmmc_mux_restore_context,
>  };
>  
>  struct clk *tegra_clk_register_sdmmc_mux_div(const char *name,
> 

