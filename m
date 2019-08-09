Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E15587973
	for <lists+linux-pm@lfdr.de>; Fri,  9 Aug 2019 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406528AbfHIMLP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 9 Aug 2019 08:11:15 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33261 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406048AbfHIMLP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 9 Aug 2019 08:11:15 -0400
Received: by mail-lj1-f194.google.com with SMTP id z17so3432510ljz.0;
        Fri, 09 Aug 2019 05:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j4NIkH+GpdlRIeIm+LhASfH+CmApJe3E7KjCUhYh+Bs=;
        b=KEFHb3YYxZ1op/aQjto19YmwFDANODMg8ElcHBR+nbGid4IVZfqPq+/beDcTQq83KG
         zbkHMaWYPsxsoquDIR0PeVIXvREfL9WFgKNRd/Jr7C0Y0rq6CNRkCE9YarBiB0ny1UuO
         Z1DNL9+/mZjFQkxNDRk956HwCWHSVy3TxtKQ3hRQezNORolPeZ0fngpDJgcdprR/QxE9
         SY770JhLIu2SKIcYd4LzHf/47lUxGDKl9M6XnrKPEEdFodu2DRlLFfFNkxtwcKgIsd6E
         KJB9Zdv24OWKJ5OSi+tb62qkxJhwy7MGTjbcFJbytuh/hY2oySsT93+BZC0WekYtFBBt
         cixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j4NIkH+GpdlRIeIm+LhASfH+CmApJe3E7KjCUhYh+Bs=;
        b=umg5hRfIKJz4KjtRahGH3n3pUtWQRyBelMkBmerEYwC85ICn6+FDfojkVSBPoKyfTG
         DnAI0c7jFXKCpp8+Umrv4BMLG1Ap+W4tFRnis/xfg3NbtgBCJb4Py5xV4jIMssf6x0Rn
         HDEGemflssV/GHp1FQp00gFKmNV4pyBeNh9S5ZLX0L44Ev/3KsiYaqL1nbfR7H+5smdL
         BmKyTuEOYfj2aDdnnocUd7rw1NNqT53qTrwaaSOHnBeBnMBTwU4pOeUkreiXdbmQvF/r
         8l4OOhjqwb73D7b6j80H3HKSjcJGnpWktCk1BkJoX5ov2/dHsDrwUpPapLgT7qxF+klN
         rIuQ==
X-Gm-Message-State: APjAAAWnN6N+/wg56N+xBO/qup9jlbf4B0KoWeAj7NOpp7TCexKXAvY3
        2awasHLfDk+hogP5Ret1SvlMThLI
X-Google-Smtp-Source: APXvYqzRa7ByJrg8pG5XhDucmkgzfM+RQksQzWnDUszyx+R735+zNgdFen8vQrviwUIGwZYvkxh90w==
X-Received: by 2002:a2e:b4d4:: with SMTP id r20mr11348307ljm.5.1565352672392;
        Fri, 09 Aug 2019 05:11:12 -0700 (PDT)
Received: from [192.168.2.145] ([94.29.34.218])
        by smtp.googlemail.com with ESMTPSA id i9sm17562927lfl.10.2019.08.09.05.11.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 05:11:11 -0700 (PDT)
Subject: Re: [PATCH v8 09/21] clk: tegra: clk-super: Fix to enable PLLP
 branches to CPU
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
 <1565308020-31952-10-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <35a716fe-595c-b260-a577-bf46e39c8acb@gmail.com>
Date:   Fri, 9 Aug 2019 15:11:10 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <1565308020-31952-10-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

09.08.2019 2:46, Sowjanya Komatineni пишет:
> This patch has a fix to enable PLLP branches to CPU before changing
> the CPU cluster clock source to PLLP for Gen5 Super clock and
> disables PLLP branches to CPU when not in use.
> 
> During system suspend entry and exit, CPU source will be switched
> to PLLP and this needs PLLP branches to be enabled to CPU prior to
> the switch.
> 
> On system resume, warmboot code enables PLLP branches to CPU and
> powers up the CPU with PLLP clock source.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  drivers/clk/tegra/clk-super.c            | 14 ++++++++++++++
>  drivers/clk/tegra/clk-tegra-super-gen4.c |  7 ++++++-
>  drivers/clk/tegra/clk.c                  | 14 ++++++++++++++
>  drivers/clk/tegra/clk.h                  |  5 +++++
>  4 files changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/tegra/clk-super.c b/drivers/clk/tegra/clk-super.c
> index 39ef31b46df5..e2a1e95a8db7 100644
> --- a/drivers/clk/tegra/clk-super.c
> +++ b/drivers/clk/tegra/clk-super.c
> @@ -28,6 +28,9 @@
>  #define super_state_to_src_shift(m, s) ((m->width * s))
>  #define super_state_to_src_mask(m) (((1 << m->width) - 1))
>  
> +#define CCLK_SRC_PLLP_OUT0 4
> +#define CCLK_SRC_PLLP_OUT4 5
> +
>  static u8 clk_super_get_parent(struct clk_hw *hw)
>  {
>  	struct tegra_clk_super_mux *mux = to_clk_super_mux(hw);
> @@ -97,12 +100,23 @@ static int clk_super_set_parent(struct clk_hw *hw, u8 index)
>  		if (index == mux->div2_index)
>  			index = mux->pllx_index;
>  	}
> +
> +	/* enable PLLP branches to CPU before selecting PLLP source */
> +	if ((mux->flags & TEGRA210_CPU_CLK) &&
> +	    (index == CCLK_SRC_PLLP_OUT0 || index == CCLK_SRC_PLLP_OUT4))
> +		tegra_clk_set_pllp_out_cpu(true);
> +
>  	val &= ~((super_state_to_src_mask(mux)) << shift);
>  	val |= (index & (super_state_to_src_mask(mux))) << shift;
>  
>  	writel_relaxed(val, mux->reg);
>  	udelay(2);
>  
> +	/* disable PLLP branches to CPU if not used */
> +	if ((mux->flags & TEGRA210_CPU_CLK) &&
> +	    index != CCLK_SRC_PLLP_OUT0 && index != CCLK_SRC_PLLP_OUT4)
> +		tegra_clk_set_pllp_out_cpu(false);
> +
>  out:
>  	if (mux->lock)
>  		spin_unlock_irqrestore(mux->lock, flags);
> diff --git a/drivers/clk/tegra/clk-tegra-super-gen4.c b/drivers/clk/tegra/clk-tegra-super-gen4.c
> index cdfe7c9697e1..98538f79b0c4 100644
> --- a/drivers/clk/tegra/clk-tegra-super-gen4.c
> +++ b/drivers/clk/tegra/clk-tegra-super-gen4.c
> @@ -180,7 +180,7 @@ static void __init tegra_super_clk_init(void __iomem *clk_base,
>  					gen_info->num_cclk_g_parents,
>  					CLK_SET_RATE_PARENT,
>  					clk_base + CCLKG_BURST_POLICY,
> -					0, 4, 8, 0, NULL);
> +					TEGRA210_CPU_CLK, 4, 8, 0, NULL);
>  		} else {
>  			clk = tegra_clk_register_super_mux("cclk_g",
>  					gen_info->cclk_g_parents,
> @@ -196,6 +196,11 @@ static void __init tegra_super_clk_init(void __iomem *clk_base,
>  	dt_clk = tegra_lookup_dt_id(tegra_clk_cclk_lp, tegra_clks);
>  	if (dt_clk) {
>  		if (gen_info->gen == gen5) {
> +		/*
> +		 * TEGRA210_CPU_CLK flag is not needed for cclk_lp as cluster
> +		 * switching is not currently supported on Tegra210 and also
> +		 * cpu_lp is not used.
> +		 */
>  			clk = tegra_clk_register_super_mux("cclk_lp",
>  					gen_info->cclk_lp_parents,
>  					gen_info->num_cclk_lp_parents,
> diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> index 573e3c967ae1..eb08047fd02f 100644
> --- a/drivers/clk/tegra/clk.c
> +++ b/drivers/clk/tegra/clk.c
> @@ -23,6 +23,7 @@
>  #define CLK_OUT_ENB_W			0x364
>  #define CLK_OUT_ENB_X			0x280
>  #define CLK_OUT_ENB_Y			0x298
> +#define CLK_ENB_PLLP_OUT_CPU		BIT(31)
>  #define CLK_OUT_ENB_SET_L		0x320
>  #define CLK_OUT_ENB_CLR_L		0x324
>  #define CLK_OUT_ENB_SET_H		0x328
> @@ -199,6 +200,19 @@ const struct tegra_clk_periph_regs *get_reg_bank(int clkid)
>  	}
>  }
>  
> +void tegra_clk_set_pllp_out_cpu(bool enable)
> +{
> +	u32 val;
> +
> +	val = readl_relaxed(clk_base + CLK_OUT_ENB_Y);
> +	if (enable)
> +		val |= CLK_ENB_PLLP_OUT_CPU;
> +	else
> +		val &= ~CLK_ENB_PLLP_OUT_CPU;
> +
> +	writel_relaxed(val, clk_base + CLK_OUT_ENB_Y);
> +}
> +
>  struct clk ** __init tegra_clk_init(void __iomem *regs, int num, int banks)
>  {
>  	clk_base = regs;
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index 8a9af45b6084..560e2bcb3d7d 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -677,6 +677,9 @@ struct clk *tegra_clk_register_periph_data(void __iomem *clk_base,
>   * Flags:
>   * TEGRA_DIVIDER_2 - LP cluster has additional divider. This flag indicates
>   *     that this is LP cluster clock.
> + * TEGRA210_CPU_CLK - This flag is used to identify CPU cluster for gen5
> + * super mux parent using PLLP branches. To use PLLP branches to CPU, need
> + * to configure additional bit PLLP_OUT_CPU in the clock registers.
>   */
>  struct tegra_clk_super_mux {
>  	struct clk_hw	hw;
> @@ -693,6 +696,7 @@ struct tegra_clk_super_mux {
>  #define to_clk_super_mux(_hw) container_of(_hw, struct tegra_clk_super_mux, hw)
>  
>  #define TEGRA_DIVIDER_2 BIT(0)
> +#define TEGRA210_CPU_CLK BIT(1)
>  
>  extern const struct clk_ops tegra_clk_super_ops;
>  struct clk *tegra_clk_register_super_mux(const char *name,
> @@ -838,6 +842,7 @@ int tegra_pll_p_div_to_hw(struct tegra_clk_pll *pll, u8 p_div);
>  int div_frac_get(unsigned long rate, unsigned parent_rate, u8 width,
>  		 u8 frac_width, u8 flags);
>  void tegra_clk_osc_resume(void __iomem *clk_base);
> +void tegra_clk_set_pllp_out_cpu(bool enable);
>  
>  
>  /* Combined read fence with delay */
> 

Looks good to me.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
