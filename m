Return-Path: <linux-pm+bounces-10895-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 167E792C3C6
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 21:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7459283866
	for <lists+linux-pm@lfdr.de>; Tue,  9 Jul 2024 19:12:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEFC182A52;
	Tue,  9 Jul 2024 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OTqL0wO7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA39E180053;
	Tue,  9 Jul 2024 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720552364; cv=none; b=eI8PRAC8Mgha+sQxsHMuXS/e3Xv3nx3NOtSKqSDelrv1bD1G/hZv1udb+g+Uqo5iApD7q+bJnHF7DJO9oIzJ20qjOCZBS/TSdHI0Uy0OQt64AfSxmvvMB0HnmwPZ928EoNvG/yL/bGqSYwaDsYzbe/oLuqjMG3IKPLyXRalTTHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720552364; c=relaxed/simple;
	bh=jFCriMPf/fsY0JPkaXj8hV7KNOljgDzvKMA/4JhgyDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3qWTrPF8FwsvipOfZ81fjVUo3gVlJx1B5w5CwYDO5BySxDanvr+/U4gZdM5iOWnT9EMDDBEip6Cqc5a4ztOaaq4G0XqxkualwduRBNi/bS3Oku9JNeklfspW8TfW4rHFy6aw9PuNlkBqs+n159Y/qlepXcuiPvro4MVC3IuJQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OTqL0wO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D91AC3277B;
	Tue,  9 Jul 2024 19:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720552364;
	bh=jFCriMPf/fsY0JPkaXj8hV7KNOljgDzvKMA/4JhgyDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTqL0wO70S01B4Yw9jpnkYrij+//yNXzYfuzKIpdryj5rINygOnaZsFkzXABBmtB/
	 /3LyYBD3Y7OWvt9AVamfOySFv3tmhv/q/nk4iL7XTlaub4aZK71AhU1BjEoSlaI6fD
	 kU7GtW3/jmA8aMGdfQqKZfpKlffz62R8oTEg+0uSnNI9d2jL8dDDl77mtJMAJVTGRr
	 gQtj0+NTg6bpYMSu/BUmx0Sg/fqXH8glaDsOFfZCAvS7jjdpG5+3rvOQ5kz74EX8+n
	 w3bUNXygr5LkiXRh/bdB7P0jjKD3OCNUHnbvbYAJ5glRqN3UGEiZ/YkiiY7JUbwaaF
	 m3A+tPPLXOFdg==
Date: Tue, 9 Jul 2024 14:12:16 -0500
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
Subject: Re: [PATCH 10/12] thermal/drivers/qcom-tsens: simplify with
 dev_err_probe()
Message-ID: <kiingkxvtdyuuyabn5acfsvpazolso6yvlsmzacxilos2jwanp@dsvceugddgep>
References: <20240709-thermal-probe-v1-0-241644e2b6e0@linaro.org>
 <20240709-thermal-probe-v1-10-241644e2b6e0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-thermal-probe-v1-10-241644e2b6e0@linaro.org>

On Tue, Jul 09, 2024 at 02:59:40PM GMT, Krzysztof Kozlowski wrote:
> Error handling in probe() can be a bit simpler with dev_err_probe().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn

> ---
>  drivers/thermal/qcom/tsens.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
> index e76e23026dc8..0b4421bf4785 100644
> --- a/drivers/thermal/qcom/tsens.c
> +++ b/drivers/thermal/qcom/tsens.c
> @@ -1336,11 +1336,9 @@ static int tsens_probe(struct platform_device *pdev)
>  
>  	if (priv->ops->calibrate) {
>  		ret = priv->ops->calibrate(priv);
> -		if (ret < 0) {
> -			if (ret != -EPROBE_DEFER)
> -				dev_err(dev, "%s: calibration failed\n", __func__);
> -			return ret;
> -		}
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "%s: calibration failed\n",
> +					     __func__);
>  	}
>  
>  	ret = tsens_register(priv);
> 
> -- 
> 2.43.0
> 
> 

