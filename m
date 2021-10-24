Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59098438B00
	for <lists+linux-pm@lfdr.de>; Sun, 24 Oct 2021 19:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbhJXRci (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 24 Oct 2021 13:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhJXRcg (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 24 Oct 2021 13:32:36 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A880C061220
        for <linux-pm@vger.kernel.org>; Sun, 24 Oct 2021 10:30:13 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id s18-20020a0568301e1200b0054e77a16651so11627671otr.7
        for <linux-pm@vger.kernel.org>; Sun, 24 Oct 2021 10:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HgGS/TvUDMG3fQx9yKOzke/c5Xu6vKp0j7mW0xSrxIs=;
        b=WPX33eA6Cus/C/DS/Fhqhv1hc2HIccKxAURkdetkilrRWi6UoMsB6jaqZRJbgt9LFY
         Nfw8nDbrrZBq9eRLTq60RRF3UMB8VwCcmng6GFRmr+brEOcI4plthFaWgSb6dSpfeRB5
         UPG8r6EAw7qO7mTyVah6oLD8VrhqeJ7sL6oXHKfJQ2ZB1jv24bsrtYY5Fw3Cly1Iwr4r
         Daypsu1akqHI1GKVnh32oCy+ihigTykW/XOYd9cjCiAIKqwEkkFIdIwGn5N/Yxh3rIbS
         Y9eW9F5uUztm8mg8H4PmbAhOHwt03vNSUd2fZQbZ+UV5SKVRNQvi87FgnYo2g7Wou5dM
         0OiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HgGS/TvUDMG3fQx9yKOzke/c5Xu6vKp0j7mW0xSrxIs=;
        b=n08J8KNkhHIpXHwcVK0qX8f8Cq77JrMZWVNEnEoPcbqDVn48kWpbOlovJVI7RdFaEZ
         Jg02xLzngQmFDkdVFUA/asEGqO/xh19hm49M72M4iPpl8Oqtlurjnhr86xoQOiLO6gVr
         u90vzMb+ztXV9Zyt+GK8TLysaycC++0gKo6E85N81znF99HPEC/OK3FU6z0rc8eg6h0Y
         5IDPM+Qn476JR4m4XJFrKxMN3NInFOoafA1fk7Ox+9bqxkJ9S4+NERpVD91TeMZwsY3X
         ATGo3SZ6jwxpL7dWv3bhjia26ll1aqJvyRUG+mftwIaBqKmQaKbGJBUA2eX9xmaaJ7IK
         rDyQ==
X-Gm-Message-State: AOAM531pccFUr1fad7Mkf5BVnMoeSn5tOOqEv+nuLPXU/VxmWBprip57
        vXCEdMiUF774M+h801obvRpPWw==
X-Google-Smtp-Source: ABdhPJwwLaa3HoRhxwvud70mZAMJuX1zsZznSPYjV9lyqXnqIhVuSAztt2n+pum51P8tI6yGE6xS+w==
X-Received: by 2002:a9d:19e3:: with SMTP id k90mr9508712otk.99.1635096612490;
        Sun, 24 Oct 2021 10:30:12 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id r22sm2955520otq.5.2021.10.24.10.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Oct 2021 10:30:11 -0700 (PDT)
Date:   Sun, 24 Oct 2021 12:30:09 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ilia Lin <ilia.lin@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org
Subject: Re: [PATCH 3/8] clk: qcom: msm8996-cpu: Add MSM8996 Pro CBF support
Message-ID: <YXWYIUUi3rY3N+aK@builder.lan>
References: <20211014083016.137441-1-y.oudjana@protonmail.com>
 <20211014083016.137441-4-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014083016.137441-4-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu 14 Oct 03:32 CDT 2021, Yassine Oudjana wrote:

> MSM8996 Pro (MSM8996SG) has a few differences in the CBF clock.
> 

I think it would be nice if you described what those differences are.

Regards,
Bjorn

> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
> Dependencies:
> - clk: qcom: msm8996-cpu: Add CBF support
>   https://lore.kernel.org/linux-arm-msm/20210528192541.1120703-1-konrad.dybcio@somainline.org/
> 
>  drivers/clk/qcom/clk-cpu-8996.c | 61 +++++++++++++++++++++------------
>  1 file changed, 40 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/clk/qcom/clk-cpu-8996.c b/drivers/clk/qcom/clk-cpu-8996.c
> index 8afc271f92d0..ab2acbe74f0f 100644
> --- a/drivers/clk/qcom/clk-cpu-8996.c
> +++ b/drivers/clk/qcom/clk-cpu-8996.c
> @@ -70,11 +70,11 @@ enum _pmux_input {
>  
>  enum {
>  	CBF_PLL_INDEX = 1,
> -	CBF_DIV_2_INDEX,
> +	CBF_DIV_INDEX,
>  	CBF_SAFE_INDEX
>  };
>  
> -#define DIV_2_THRESHOLD		600000000
> +#define DIV_THRESHOLD		600000000
>  #define PWRCL_REG_OFFSET 0x0
>  #define PERFCL_REG_OFFSET 0x80000
>  #define MUX_OFFSET	0x40
> @@ -142,6 +142,17 @@ static const struct alpha_pll_config cbfpll_config = {
>  	.early_output_mask = BIT(3),
>  };
>  
> +static const struct alpha_pll_config cbfpll_config_pro = {
> +	.l = 72,
> +	.config_ctl_val = 0x200d4aa8,
> +	.config_ctl_hi_val = 0x006,
> +	.pre_div_mask = BIT(12),
> +	.post_div_mask = 0x3 << 8,
> +	.post_div_val = 0x3 << 8,
> +	.main_output_mask = BIT(0),
> +	.early_output_mask = BIT(3),
> +};
> +
>  static struct clk_alpha_pll perfcl_pll = {
>  	.offset = PERFCL_REG_OFFSET,
>  	.regs = prim_pll_regs,
> @@ -230,7 +241,8 @@ struct clk_cpu_8996_mux {
>  	u8	width;
>  	struct notifier_block nb;
>  	struct clk_hw	*pll;
> -	struct clk_hw	*pll_div_2;
> +	struct clk_hw	*pll_div;
> +	u8 div;
>  	struct clk_regmap clkr;
>  };
>  
> @@ -280,11 +292,11 @@ static int clk_cpu_8996_mux_determine_rate(struct clk_hw *hw,
>  	struct clk_cpu_8996_mux *cpuclk = to_clk_cpu_8996_mux_hw(hw);
>  	struct clk_hw *parent = cpuclk->pll;
>  
> -	if (cpuclk->pll_div_2 && req->rate < DIV_2_THRESHOLD) {
> -		if (req->rate < (DIV_2_THRESHOLD / 2))
> +	if (cpuclk->pll_div &&req->rate < DIV_THRESHOLD) {
> +		if (req->rate < (DIV_THRESHOLD / cpuclk->div))
>  			return -EINVAL;
>  
> -		parent = cpuclk->pll_div_2;
> +		parent = cpuclk->pll_div;
>  	}
>  
>  	req->best_parent_rate = clk_hw_round_rate(parent, req->rate);
> @@ -336,7 +348,8 @@ static struct clk_cpu_8996_mux pwrcl_pmux = {
>  	.shift = 0,
>  	.width = 2,
>  	.pll = &pwrcl_pll.clkr.hw,
> -	.pll_div_2 = &pwrcl_smux.clkr.hw,
> +	.pll_div = &pwrcl_smux.clkr.hw,
> +	.div = 2,
>  	.nb.notifier_call = cpu_clk_notifier_cb,
>  	.clkr.hw.init = &(struct clk_init_data) {
>  		.name = "pwrcl_pmux",
> @@ -358,7 +371,8 @@ static struct clk_cpu_8996_mux perfcl_pmux = {
>  	.shift = 0,
>  	.width = 2,
>  	.pll = &perfcl_pll.clkr.hw,
> -	.pll_div_2 = &perfcl_smux.clkr.hw,
> +	.pll_div = &perfcl_smux.clkr.hw,
> +	.div = 2,
>  	.nb.notifier_call = cpu_clk_notifier_cb,
>  	.clkr.hw.init = &(struct clk_init_data) {
>  		.name = "perfcl_pmux",
> @@ -481,19 +495,23 @@ static int qcom_cbf_clk_msm8996_register_clks(struct device *dev,
>  					      struct regmap *regmap)
>  {
>  	int ret;
> +	bool is_pro = of_device_is_compatible(dev->of_node, "qcom,msm8996pro-apcc");
>  
> -	cbf_mux.pll_div_2 = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
> -						      "cbf_pll", CLK_SET_RATE_PARENT,
> -						      1, 2);
> -	if (IS_ERR(cbf_mux.pll_div_2)) {
> +	cbf_mux.div = is_pro ? 4 : 2;
> +	cbf_mux.pll_div = clk_hw_register_fixed_factor(dev, "cbf_pll_main",
> +						       "cbf_pll", CLK_SET_RATE_PARENT,
> +						       1, cbf_mux.div);
> +
> +	if (IS_ERR(cbf_mux.pll_div)) {
>  		dev_err(dev, "Failed to initialize cbf_pll_main\n");
> -		return PTR_ERR(cbf_mux.pll_div_2);
> +		return PTR_ERR(cbf_mux.pll_div);
>  	}
>  
>  	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[0]);
>  	ret = devm_clk_register_regmap(dev, cbf_msm8996_clks[1]);
>  
> -	clk_alpha_pll_configure(&cbf_pll, regmap, &cbfpll_config);
> +	clk_alpha_pll_configure(&cbf_pll, regmap, is_pro ?
> +				&cbfpll_config_pro : &cbfpll_config);
>  	clk_set_rate(cbf_pll.clkr.hw.clk, 614400000);
>  	clk_prepare_enable(cbf_pll.clkr.hw.clk);
>  	clk_notifier_register(cbf_mux.clkr.hw.clk, &cbf_mux.nb);
> @@ -575,7 +593,7 @@ static int cpu_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
>  		qcom_cpu_clk_msm8996_acd_init(base);
>  		break;
>  	case POST_RATE_CHANGE:
> -		if (cnd->new_rate < DIV_2_THRESHOLD)
> +		if (cnd->new_rate < DIV_THRESHOLD)
>  			ret = clk_cpu_8996_mux_set_parent(&cpuclk->clkr.hw,
>  							  DIV_2_INDEX);
>  		else
> @@ -600,15 +618,15 @@ static int cbf_clk_notifier_cb(struct notifier_block *nb, unsigned long event,
>  
>  	switch (event) {
>  	case PRE_RATE_CHANGE:
> -		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
> -		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
> +		parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_DIV_INDEX);
> +		ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX);
>  
> -		if (cnd->old_rate > DIV_2_THRESHOLD && cnd->new_rate < DIV_2_THRESHOLD)
> -			ret = clk_set_rate(parent->clk, cnd->old_rate / 2);
> +		if (cnd->old_rate > DIV_THRESHOLD && cnd->new_rate < DIV_THRESHOLD)
> +			ret = clk_set_rate(parent->clk, cnd->old_rate / cbfclk->div);
>  		break;
>  	case POST_RATE_CHANGE:
> -		if (cnd->new_rate < DIV_2_THRESHOLD)
> -			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_2_INDEX);
> +		if (cnd->new_rate < DIV_THRESHOLD)
> +			ret = clk_cpu_8996_mux_set_parent(&cbfclk->clkr.hw, CBF_DIV_INDEX);
>  		else {
>  			parent = clk_hw_get_parent_by_index(&cbfclk->clkr.hw, CBF_PLL_INDEX);
>  			ret = clk_set_rate(parent->clk, cnd->new_rate);
> @@ -676,6 +694,7 @@ static int qcom_cpu_clk_msm8996_driver_remove(struct platform_device *pdev)
>  
>  static const struct of_device_id qcom_cpu_clk_msm8996_match_table[] = {
>  	{ .compatible = "qcom,msm8996-apcc" },
> +	{ .compatible = "qcom,msm8996pro-apcc" },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, qcom_cpu_clk_msm8996_match_table);
> -- 
> 2.33.0
> 
> 
