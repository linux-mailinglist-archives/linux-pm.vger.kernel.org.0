Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71ADDE7431
	for <lists+linux-pm@lfdr.de>; Mon, 28 Oct 2019 15:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390518AbfJ1O5K (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 28 Oct 2019 10:57:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:16617 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390461AbfJ1O5K (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 28 Oct 2019 10:57:10 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5db701cd0001>; Mon, 28 Oct 2019 07:57:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 28 Oct 2019 07:57:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 28 Oct 2019 07:57:09 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 28 Oct
 2019 14:57:08 +0000
Received: from tbergstrom-lnx.Nvidia.com (10.124.1.5) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Mon, 28 Oct 2019 14:57:08 +0000
Received: by tbergstrom-lnx.Nvidia.com (Postfix, from userid 1000)
        id C8DA543032; Mon, 28 Oct 2019 16:57:06 +0200 (EET)
Date:   Mon, 28 Oct 2019 16:57:06 +0200
From:   Peter De Schrijver <pdeschrijver@nvidia.com>
To:     Dmitry Osipenko <digetx@gmail.com>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        "Nicolas Chauvet" <kwizart@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        <linux-pm@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 01/17] clk: tegra: Add custom CCLK implementation
Message-ID: <20191028145706.GF27141@pdeschrijver-desktop.Nvidia.com>
References: <20191015211618.20758-1-digetx@gmail.com>
 <20191015211618.20758-2-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191015211618.20758-2-digetx@gmail.com>
X-NVConfidentiality: public
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1572274637; bh=a3iQGGwz0Ivg7sfs0KItL4POFuee26IhkUhjou3eb4M=;
        h=X-PGP-Universal:Date:From:To:CC:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
         X-NVConfidentiality:User-Agent:X-Originating-IP:X-ClientProxiedBy;
        b=ltTYQgdfMjWQKG2jN1sK+ylYqIivDrD90MVQgPlGFVpj2Sp27DCwSzppeJbib+j0j
         CLEn+3hwOL3Fvb3JPx5nmrIeLBJuGCOGjdGnF196NJippTqXGkyD45hQ3XydK2WOZ5
         w3afkvcQ2jUpA188B3DIQoik5OX2/feYlEqZdf68hVJ0iu4IbVBq4t+pArmqjBeCxH
         UctsgV6EGdwyyuaaQJSo4clSL9PAzOHwIW16j96+H21FqJGnv4J8JcSDkmNQO4zH+n
         toCpLsBLEgVUD3to458/C7zcPfhcz9Xu/xwUfqsIYqWMlPkP1Vsn27NJTdzaVxmVAV
         Rbi+wn2KM9YWg==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Wed, Oct 16, 2019 at 12:16:02AM +0300, Dmitry Osipenko wrote:
> CCLK stands for "CPU Clock", CPU core is running off CCLK. CCLK supports
> multiple parents and it has internal clock divider which uses clock
> skipping technique, meaning that CPU's voltage should correspond to the
> parent clock rate and not CCLK. PLLX is the main CCLK parent that provides
> clock rates above 1GHz and it has special property such that the CCLK's
> internal divider is set into bypass mode when PLLX is set as a parent for
> CCLK.
> 
> This patch forks generic Super Clock into CCLK implementation which takes
> into account all CCLK specifics. The proper CCLK implementation is needed
> by the upcoming Tegra20 CPUFreq driver update that will allow to utilize
> the generic cpufreq-dt driver by moving intermediate clock handling into
> the clock driver. Note that technically this all could be squashed into
> clk-super, but result will be messier.
> 
> Note that currently all CCLKLP bits are left in the clk-super.c and only
> CCLKG is supported by clk-tegra-super-cclk. It shouldn't be difficult
> to move the CCLKLP bits, but CCLKLP is not used by anything in kernel
> and thus better not to touch it for now.

..

> +	super->reg = reg;
> +	super->lock = lock;
> +	super->width = 4;
> +	super->flags = clk_super_flags;
> +	super->frac_div.reg = reg + 4;
> +	super->frac_div.shift = 16;
> +	super->frac_div.width = 8;
> +	super->frac_div.frac_width = 1;
> +	super->frac_div.lock = lock;
> +	super->frac_div.flags = TEGRA_DIVIDER_SUPER;
> +	super->div_ops = &tegra_clk_frac_div_ops;
> +

This is not right. The super clock divider is not a divider, it's a
pulse skipper.

> +	/* Data in .init is copied by clk_register(), so stack variable OK */
> +	super->hw.init = &init;
> +
> +	clk = clk_register(NULL, &super->hw);
> +	if (IS_ERR(clk))
> +		kfree(super);
> +
> +	return clk;
> +}
> diff --git a/drivers/clk/tegra/clk.h b/drivers/clk/tegra/clk.h
> index f81c10654aa9..095595a5b8a8 100644
> --- a/drivers/clk/tegra/clk.h
> +++ b/drivers/clk/tegra/clk.h
> @@ -699,6 +699,10 @@ struct clk *tegra_clk_register_super_clk(const char *name,
>  		const char * const *parent_names, u8 num_parents,
>  		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
>  		spinlock_t *lock);
> +struct clk *tegra_clk_register_super_cclk(const char *name,
> +		const char * const *parent_names, u8 num_parents,
> +		unsigned long flags, void __iomem *reg, u8 clk_super_flags,
> +		spinlock_t *lock);
>  
>  /**
>   * struct tegra_sdmmc_mux - switch divider with Low Jitter inputs for SDMMC
> -- 
> 2.23.0
> 
