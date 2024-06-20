Return-Path: <linux-pm+bounces-9681-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 939DF91096B
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 17:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9132821B5
	for <lists+linux-pm@lfdr.de>; Thu, 20 Jun 2024 15:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DCE1AF6AE;
	Thu, 20 Jun 2024 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhvNPEUt"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12D1AF68A
	for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 15:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718896298; cv=none; b=Gqp/BgooxjNIWJRCNFFULd3KJqfNg+zyGbHoo5PEL0TghCZ9/myQAGnVPq3jOFdt3nXtd/Fo/BzU86CX4yf6BZ0lfHqtRAVLL7EdnFLKdPj+MJcD5dA4rjkSwAm4aH68wRFug8BN1PcmfoHDKkSAZ0eVhyi9P54UeHwksriTPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718896298; c=relaxed/simple;
	bh=bXi5AxhJ6BOlPGDlzlnhp/B19Cg5Fbvd0iajo/vvX3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HiSI5Ob7mCWf3/plLxUAzG40xMbnZxIdAsJNUdH6luPur8gJ8P6MdbWQvm5diKqM0aXXcuS5Yo/QWgVU1dNC+qoVyCVK5fKwq4jEyD3FApFcZKQ9CRZNesTKrGbX4YetW7FticyPJx08nHom9cDMabRfAYXtrHIimfXMzjvKmGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fhvNPEUt; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ec1e5505abso16884681fa.1
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2024 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718896294; x=1719501094; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3h6oqRW/qdffe42UR3aCeVEd5BB42fceS5IJnJKBOSg=;
        b=fhvNPEUtUIs+2riN8Unpt5qz8zQWQqfmrmVuTSdWgCnOrFgicx+cb8QB/HazvRD1dZ
         9iCZIriFQtZWKRKpFEtNeQkUET4UuQmszb/1KSdWqSNGAi1aPu/ahGmJXYuIN38rDdtf
         MkDyg8WcdwFrtJ7rGwm42oA/bTosKLv9kmcwQsKtgofekmlK2drj8mCzrSIWEuaLBjAl
         bRgRp3v1ekG754XWWzg1o64MR2W+KqrKiFMKzV1bmtsDsHUXb68wHAy5olSSbWkmag7r
         twYPZYIwaxINL/xY7emBcB5S6eIF90fG340YnR8nCyIYFe5j7btngQEIt+QDcPOqCeN5
         AiDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718896294; x=1719501094;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3h6oqRW/qdffe42UR3aCeVEd5BB42fceS5IJnJKBOSg=;
        b=vo4MmX7yoogfLjnFTx71vDLKnnEx6lGisUwgFqVNLdH7gZc7Xk7M3yiJ3ZJnxNY2H3
         dlK0gRa/CP7Ti/O7xuBj2gYi20bb5OpgSLdv+JagYzbtqX+CHP20HuUzPij4XtNid/x4
         9dXuSxRp+SLxz0wY3yhwnp72CFafffKHq7zQmdBPHSpI44uv94qRw6lG8NOKLd7R8itN
         n6fx4s+YE7Lpx+F1K4+vn4d+6eCG9pe5h7JBtApqrTQjAi5MhhGCJgUHKmKPVWKnQ6+l
         M7tVKdaR4MD41hhT6PkC3DEiMhMnFLgJuRJfU7iIfEs57m5bbPuW84DqLDON1kFhEoy1
         WDbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnPa53qDfFEWlBTO4kCsJH6+xCBDfPV1vpUiZji8yE5JZ3eLGHxXLZ+cIGcsZAHE6sYqH66iazi3/0BblPRnkUYxmNemPetug=
X-Gm-Message-State: AOJu0Yx5+may81MxBgddxk+vzCmWXgv8NvgmPLx0IuGPDBvfS4WQ9Dqs
	oqrPH5rwAExd1wJ+5sKIQQTK3/GlphogJCIyC86C2F37ajsPKojR1B0C2rjbMGw=
X-Google-Smtp-Source: AGHT+IG2bhnBYuuNCUcW1g1XePnvj4eVOUhHtCKEC+de0GhrbLOlWQDOt226Xo64hud8Q/lYWQdHrw==
X-Received: by 2002:a05:6512:3049:b0:52c:a88e:945e with SMTP id 2adb3069b0e04-52cca1f35bcmr1702015e87.31.1718896294581;
        Thu, 20 Jun 2024 08:11:34 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca282ee54sm2120259e87.73.2024.06.20.08.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 08:11:34 -0700 (PDT)
Date: Thu, 20 Jun 2024 18:11:32 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	angelogioacchino.delregno@collabora.com, andersson@kernel.org, konrad.dybcio@linaro.org, 
	mturquette@baylibre.com, sboyd@kernel.org, ulf.hansson@linaro.org, quic_sibis@quicinc.com, 
	quic_rjendra@quicinc.com, luca@z3ntu.xyz, abel.vesa@linaro.org, quic_rohiagar@quicinc.com, 
	danila@jiaxyga.com, otto.pflueger@abscue.de, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v1 5/7] clk: qcom: gcc-ipq9574: Add CPR clock definition
Message-ID: <wadru6axfhvws74vcd6umdhnm6gl5poegoljvb7fgbtuz2mccp@hrclt6qesp6e>
References: <20240620081427.2860066-1-quic_varada@quicinc.com>
 <20240620081427.2860066-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620081427.2860066-6-quic_varada@quicinc.com>

On Thu, Jun 20, 2024 at 01:44:25PM GMT, Varadarajan Narayanan wrote:
> Add the CPR clock definition needed for enabling access to
> CPR register space.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  drivers/clk/qcom/gcc-ipq9574.c | 38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> index e1dc74d04ed1..7c8eb94f654b 100644
> --- a/drivers/clk/qcom/gcc-ipq9574.c
> +++ b/drivers/clk/qcom/gcc-ipq9574.c
> @@ -3994,6 +3994,43 @@ static struct clk_branch gcc_xo_div4_clk = {
>  	},
>  };
>  
> +static const struct freq_tbl ftbl_hmss_rbcpr_clk_src[] = {
> +	F(24000000, P_XO, 1, 0, 0),
> +	{ }
> +};
> +
> +static struct clk_rcg2 rbcpr_clk_src = {
> +	.cmd_rcgr = 0x48044,
> +	.mnd_width = 0,
> +	.hid_width = 5,
> +	.parent_map = gcc_xo_map,
> +	.freq_tbl = ftbl_gp1_clk_src,
> +	.clkr.hw.init = &(struct clk_init_data){
> +		.name = "rbcpr_clk_src",
> +		.parent_data = gcc_xo_gpll0_gpll4,
> +		.num_parents = ARRAY_SIZE(gcc_xo_map),
> +		.ops = &clk_rcg2_ops,
> +	},
> +};
> +
> +static struct clk_branch gcc_rbcpr_clk = {
> +	.halt_reg = 0x48008,
> +	.halt_check = BRANCH_HALT,
> +	.clkr = {
> +		.enable_reg = 0x48008,
> +		.enable_mask = BIT(0),
> +		.hw.init = &(struct clk_init_data){
> +			.name = "gcc_rbcpr_clk",
> +			.parent_hws = (const struct clk_hw *[]) {
> +				&rbcpr_clk_src.clkr.hw,

Where is the &rbcpr_clk_src registered?

> +			},
> +			.num_parents = 1,
> +			.flags = CLK_SET_RATE_PARENT,
> +			.ops = &clk_branch2_ops,
> +		},
> +	},
> +};
> +
>  static struct clk_hw *gcc_ipq9574_hws[] = {
>  	&gpll0_out_main_div2.hw,
>  	&gcc_xo_div4_clk_src.hw,
> @@ -4219,6 +4256,7 @@ static struct clk_regmap *gcc_ipq9574_clks[] = {
>  	[GCC_PCIE1_PIPE_CLK] = &gcc_pcie1_pipe_clk.clkr,
>  	[GCC_PCIE2_PIPE_CLK] = &gcc_pcie2_pipe_clk.clkr,
>  	[GCC_PCIE3_PIPE_CLK] = &gcc_pcie3_pipe_clk.clkr,
> +	[GCC_RBCPR_CLK] = &gcc_rbcpr_clk.clkr,
>  };
>  
>  static const struct qcom_reset_map gcc_ipq9574_resets[] = {
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry

