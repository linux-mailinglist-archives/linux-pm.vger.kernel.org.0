Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98A11B3FA1
	for <lists+linux-pm@lfdr.de>; Wed, 22 Apr 2020 12:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730575AbgDVKjI (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Apr 2020 06:39:08 -0400
Received: from foss.arm.com ([217.140.110.172]:46140 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729474AbgDVKVh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 22 Apr 2020 06:21:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0F0D131B;
        Wed, 22 Apr 2020 03:21:37 -0700 (PDT)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2D1B3F68F;
        Wed, 22 Apr 2020 03:21:36 -0700 (PDT)
Received: by e110455-lin.cambridge.arm.com (Postfix, from userid 1000)
        id 9CCBE682F3D; Wed, 22 Apr 2020 11:21:35 +0100 (BST)
Date:   Wed, 22 Apr 2020 11:21:35 +0100
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Will Deacon <will@kernel.org>,
        Kevin Brodsky <Kevin.Brodsky@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 07/17] clk: vexpress-osc: Use the devres clock API
 variants
Message-ID: <20200422102135.GS364558@e110455-lin.cambridge.arm.com>
References: <20200419170810.5738-1-robh@kernel.org>
 <20200419170810.5738-8-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200419170810.5738-8-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Apr 19, 2020 at 12:08:00PM -0500, Rob Herring wrote:
> In preparation to enable the vexpress-osc clock driver as a module,
> convert the driver to use the managed devres clock API variants. With
> this, a driver .remove() hook is not needed.
> 
> Cc: Liviu Dudau <liviu.dudau@arm.com>

Acked-by: Liviu Dudau <liviu.dudau@arm.com>

> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/clk/versatile/clk-vexpress-osc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/versatile/clk-vexpress-osc.c b/drivers/clk/versatile/clk-vexpress-osc.c
> index 7ade146a3ea9..5bb1d5a714d0 100644
> --- a/drivers/clk/versatile/clk-vexpress-osc.c
> +++ b/drivers/clk/versatile/clk-vexpress-osc.c
> @@ -65,8 +65,8 @@ static int vexpress_osc_probe(struct platform_device *pdev)
>  {
>  	struct clk_init_data init;
>  	struct vexpress_osc *osc;
> -	struct clk *clk;
>  	u32 range[2];
> +	int ret;
>  
>  	osc = devm_kzalloc(&pdev->dev, sizeof(*osc), GFP_KERNEL);
>  	if (!osc)
> @@ -92,11 +92,11 @@ static int vexpress_osc_probe(struct platform_device *pdev)
>  
>  	osc->hw.init = &init;
>  
> -	clk = clk_register(NULL, &osc->hw);
> -	if (IS_ERR(clk))
> -		return PTR_ERR(clk);
> +	ret = devm_clk_hw_register(&pdev->dev, &osc->hw);
> +	if (ret < 0)
> +		return ret;
>  
> -	of_clk_add_provider(pdev->dev.of_node, of_clk_src_simple_get, clk);
> +	devm_of_clk_add_hw_provider(&pdev->dev, of_clk_hw_simple_get, &osc->hw);
>  	clk_hw_set_rate_range(&osc->hw, osc->rate_min, osc->rate_max);
>  
>  	dev_dbg(&pdev->dev, "Registered clock '%s'\n", init.name);
> -- 
> 2.20.1
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
