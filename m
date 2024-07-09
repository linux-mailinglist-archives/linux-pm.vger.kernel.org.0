Return-Path: <linux-pm+bounces-10894-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0402092C3C2
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 21:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3585E1C2193F
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244B3182A58;
	Tue,  9 Jul 2024 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1xGWNKc"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8F5182A4F;
	Tue,  9 Jul 2024 19:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552299; cv=none; b=GIrVnHNS99UbrkHk95oskKxrFqP5RXZyZ5UfHUAB80lvW/zL+w2+Tha7sT0KZtZi2EsHPwAki9QkaIPMse0iVgCnIJtWXdhnbkRlNfTqFB4XfxdGR9kSXjViQoWkR/P6Q15iohRePgga62chL9F/Sd/gaYneSSyE0LX6gpID7Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552299; c=relaxed/simple;
	bh=YfjdhNm53xzOTj3Z9NufeiEhaRfrnE/93sBlKfwCkw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ssflCCydaUIllixHKmmXWxB+yRpOKDM6PLrqHN90GRJg96ckuJ3+lYfV7KoDqER6H/qXDhorEB7axw6dzcOTPQom/6EgDsYI36K3N9f3n1tuOT+pu/CaMcZuyn+S6T3hduyN5iWL54pNepXVDenGU+8R/2rO7utBHhRNienn848=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1xGWNKc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719B9C3277B;
	Tue,  9 Jul 2024 19:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720552298;
	bh=YfjdhNm53xzOTj3Z9NufeiEhaRfrnE/93sBlKfwCkw4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n1xGWNKcA3jQU1NvWSmP4Kgc5Fhvc9PnsEtPXzf9WTwI/TAbA3zBvxjfYcnQi174E
	 mx3r7rc4t3WfrLaiyHH3wvPtsvPuevdkktak+O0VmRiz+7PPfbwjdDixiwyz/N6ViX
	 fwlkc2tJ29nOrCsNBoNQYokiS6NGkoLpcgFdgm34q2LSZYu05snnCXAs1lAD4VkRET
	 3PW8yIm8+3BzAIX7L9sSey+ghDBtY/HCxASy6TtYbJSGBmuNvCFDnCWktd5So5GaEi
	 u2Tu6QQMiJaY2DBzRt6yIeOo93bmE/0hZfq1JUvzyyay2wxauzWJ7RD3J7kuX6I0Y7
	 xed2SI43K/dCQ==
Date: Tue, 9 Jul 2024 14:11:05 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>, 
	linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, 
	imx@lists.linux.dev, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 09/12] thermal/drivers/qcom-spmi-adc-tm5: simplify with
 dev_err_probe()
Message-ID: <kytoekbx4t52dynndilmbham45ufvsnhbnel6vmjmn4iztdc3c@an4jnvq57gw7>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
 <20240709-thermal-probe-v1-9-241644e2b6e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-thermal-probe-v1-9-241644e2b6e0@linaro.org>

On Tue, Jul 09, 2024 at 02:59:39PM GMT, Krzysztof Kozlowski wrote:
> Error handling in probe() can be a bit simpler with dev_err_probe().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 756ac6842ff9..7c9f4023babc 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -829,12 +829,9 @@ static int adc_tm5_get_dt_channel_data(struct adc_tm5_chip *adc_tm,
>  
>  	channel->iio = devm_fwnode_iio_channel_get_by_name(adc_tm->dev,
>  							   of_fwnode_handle(node), NULL);
> -	if (IS_ERR(channel->iio)) {
> -		ret = PTR_ERR(channel->iio);
> -		if (ret != -EPROBE_DEFER)
> -			dev_err(dev, "%s: error getting channel: %d\n", name, ret);
> -		return ret;
> -	}
> +	if (IS_ERR(channel->iio))
> +		return dev_err_probe(dev, PTR_ERR(channel->iio), "%s: error getting channel\n",
> +				     name);
>  
>  	ret = of_property_read_u32_array(node, "qcom,pre-scaling", varr, 2);
>  	if (!ret) {
> 
> -- 
> 2.43.0
> 
> 

