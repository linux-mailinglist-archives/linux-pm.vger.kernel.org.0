Return-Path: <linux-pm+bounces-10420-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74919924F30
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 05:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A9B41F272E7
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jul 2024 03:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE30314264C;
	Wed,  3 Jul 2024 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VdUPI78J"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A791422BD;
	Wed,  3 Jul 2024 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719976116; cv=none; b=OLgKunLKJ6JhmG6TzJUzcAfEZyGqE+SbUKlUwIOEbz1I/MJaI3C6sA/5g/w4V79xTSgrTQ+mvyzfT3INaSRdJWafwEzzedOirVKn/ofCsOWotfDxg6638Y4Ostc07cdJaUE4EjvpavNFHBGjbTg9sTb4s2WJApWtYv7aGdSbb8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719976116; c=relaxed/simple;
	bh=g9m3cGvHR4ck9CMMppV/qXr3G9Un1KzAXp1S8wWWDeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AaBv2Yd1kzjHGAENzX6XCMFcS+TKpQRCUxC5hH9X5Rm0QQHrPp5XzqB3Y05QKb5i3USZhed5PWvF3UMv1dL+e0qAx2Itb+457hTO1wnM7meHnHR+Thuw8tDt++byv6vNTtiguXn7Vk9NoS1ijERFamdmtq80B7kiGgFrr/HEhQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VdUPI78J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3749CC116B1;
	Wed,  3 Jul 2024 03:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719976116;
	bh=g9m3cGvHR4ck9CMMppV/qXr3G9Un1KzAXp1S8wWWDeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VdUPI78Jzd9RXAkLUKhGwqeBJb3VXdKatP+aEPDrmhxuARFctcOEZs92Qx/AwGNZK
	 BpkYOj8FeU04fqYP+QZHzN6aeEGmmvz7TwIsCTeHDUdVkocQBU4tAoJ5F5cASI1jdY
	 xBjMiQ/FL6MY4DvXu4+J+q2Q2tISdoGJVmkY/cGYBzQYG6V7F0Eo7J7FiS28R711HX
	 y+NYaWh8lNunfW7DJA3ibkStPFVggKvFCBia+0wAXiTcEZzVfBIUOvjwkRHeoSYB/N
	 EjGNuY/9+MVnJgG2uw6nCMUnJnsaoBzDzR4BZvufyF9HqQxvirWzOAVMYDnMIIaVAM
	 ZFWLE2RCBUBqw==
Date: Tue, 2 Jul 2024 22:08:27 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Stanimir Varbanov <stanimir.k.varbanov@gmail.com>, 
	Vikash Garodia <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Abel Vesa <abel.vesa@linaro.org>, linux-pm@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>, 
	Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, Imran Shaik <quic_imrashai@quicinc.com>, 
	Ajit Pandey <quic_ajipan@quicinc.com>
Subject: Re: [PATCH V7 4/5] clk: qcom: videocc: Use HW_CTRL_TRIGGER for
 SM8250, SC7280 vcodec GDSC's
Message-ID: <c76yhzs4psywaqes32zb23ixbujejurn3f3hj3qswbzaxf3j25@2wslykbylak4>
References: <20240624044809.17751-1-quic_jkona@quicinc.com>
 <20240624044809.17751-5-quic_jkona@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240624044809.17751-5-quic_jkona@quicinc.com>

On Mon, Jun 24, 2024 at 10:18:08AM GMT, Jagadeesh Kona wrote:
> For Venus V6 variant SoCs(sm8250, sc7280), the venus driver uses the newly
> introduced dev_pm_genpd_set_hwmode() API to switch the vcodec GDSC to
> HW/SW control modes at runtime. Hence use HW_CTRL_TRIGGER flag for vcodec
> GDSC's on sm8250, sc7280 to register the set_hwmode_dev & get_hwmode_dev
> callbacks for vcodec GDSC and allow the GDSC mode to be changed using
> dev_pm_genpd_set_hwmode() API.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> Reviewed-by: Taniya Das <quic_tdas@quicinc.com>

Acked-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/clk/qcom/videocc-sc7280.c | 2 +-
>  drivers/clk/qcom/videocc-sm8250.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/clk/qcom/videocc-sc7280.c b/drivers/clk/qcom/videocc-sc7280.c
> index 317b325d6daf..88c90853cf6e 100644
> --- a/drivers/clk/qcom/videocc-sc7280.c
> +++ b/drivers/clk/qcom/videocc-sc7280.c
> @@ -240,7 +240,7 @@ static struct gdsc mvs0_gdsc = {
>  		.name = "mvs0_gdsc",
>  	},
>  	.pwrsts = PWRSTS_OFF_ON,
> -	.flags = HW_CTRL | RETAIN_FF_ENABLE,
> +	.flags = HW_CTRL_TRIGGER | RETAIN_FF_ENABLE,
>  };
>  
>  static struct gdsc mvsc_gdsc = {
> diff --git a/drivers/clk/qcom/videocc-sm8250.c b/drivers/clk/qcom/videocc-sm8250.c
> index d7e0c32284c1..df479a69cddd 100644
> --- a/drivers/clk/qcom/videocc-sm8250.c
> +++ b/drivers/clk/qcom/videocc-sm8250.c
> @@ -293,7 +293,7 @@ static struct gdsc mvs0_gdsc = {
>  	.pd = {
>  		.name = "mvs0_gdsc",
>  	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> @@ -302,7 +302,7 @@ static struct gdsc mvs1_gdsc = {
>  	.pd = {
>  		.name = "mvs1_gdsc",
>  	},
> -	.flags = HW_CTRL,
> +	.flags = HW_CTRL_TRIGGER,
>  	.pwrsts = PWRSTS_OFF_ON,
>  };
>  
> -- 
> 2.43.0
> 

