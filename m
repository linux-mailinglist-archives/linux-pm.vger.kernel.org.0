Return-Path: <linux-pm+bounces-7701-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 299978C1746
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 22:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40F01F21FCA
	for <lists+linux-pm@lfdr.de>; Thu,  9 May 2024 20:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9414784A3B;
	Thu,  9 May 2024 20:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="gy43XoG5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADDA8405C;
	Thu,  9 May 2024 20:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285111; cv=none; b=jKY4Mfg0eaLrJr/WrdVgdlgAk6pRArPNGl8cBMO4unQxT+l3Jq+LBgfYbwpfZETRF0KWqt+Lr3KyxP3CXBaV3o4HvUB9YRsS7ADJKiG7XMJigiR67yLjZx73L++GIY6z0HZ022yBBRpZMAzLZuKHJTdREvpDWNriRE8zVdOyiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285111; c=relaxed/simple;
	bh=+OQRrox4NiFSzWCAahZ6m6z1qcTCIJu3cMe6d9XV/4c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1qNLMnzRrY03Dd6c/bMRAYrn8KQuBU9jLkY58PBaL4VFeM4iQJo+8Wme15Yh68uZp9oZYKH5UizblIIi89ucUkz3Hn9yMY7fE2PJ4TVUkwz/Rc6kTV47M9wgnwGp7qNn/YKR92/Di/YClmPnXP0CTxTJSXOv/1eD+Bpjm5rZTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=gy43XoG5; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 5A0hsrFbhk6QC5A0hsoqMR; Thu, 09 May 2024 22:05:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715285101;
	bh=qX1DtiA+PUQHRn3nGRgzieMrVDQkAdDkg4WRPoC1ywM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=gy43XoG56J30hlSWRVxCtOVjO+dv2aixkqyHA8acv4TEvVWK2o7y8K7yQn869TRC+
	 uC4GAeHtsDzUCkvNxURGSSEg3oaBojbjYEsg46lQm7Iho87LQ7iNRsKt/8/Ylpu2pn
	 3p1auesTJw3otin1+94vVd59NLW5gaEaM5uRjCIqxQKxn9dPDpNI25F6+tFmfv7bP9
	 9/KzmUe7fXLSa535HO+aKf+57bPecDA6C1SSkXsvmAyAlfSHUWukgcj9EdcPdq1fuu
	 MYjaBoi/hE3i5RVyNPoyz+U2JtPWPk0SZZDMyaON/10cV4RqQns3REKpmsiMYpne1I
	 UiNcdFX3zuWqg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 09 May 2024 22:05:01 +0200
X-ME-IP: 86.243.17.157
Message-ID: <d2943958-ac80-4158-8e7c-b5493ab713f8@wanadoo.fr>
Date: Thu, 9 May 2024 22:04:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] PM / devfreq: exynos: Use Use devm_clk_get_enabled()
 helpers
To: Anand Moon <linux.amoon@gmail.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 MyungJoo Ham <myungjoo.ham@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240509064754.10082-1-linux.amoon@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240509064754.10082-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 09/05/2024 à 08:47, Anand Moon a écrit :
> The devm_clk_get_enabled() helpers:
>      - call devm_clk_get()
>      - call clk_prepare_enable() and register what is needed in order to
>       call clk_disable_unprepare() when needed, as a managed resource.
> 
> This simplifies the code and avoids the calls to clk_disable_unprepare().
> 
> While at it, use dev_err_probe consistently, and use its return value
> to return the error code.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> V4 - wrap up the error messagee within 80 char
> v3 - No change
> v2 - No change
> ---
>   drivers/devfreq/exynos-bus.c | 22 +++++-----------------
>   1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 00118580905a..7d06c476d8e9 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -160,7 +160,6 @@ static void exynos_bus_exit(struct device *dev)
>   	platform_device_unregister(bus->icc_pdev);
>   
>   	dev_pm_opp_of_remove_table(dev);
> -	clk_disable_unprepare(bus->clk);
>   	dev_pm_opp_put_regulators(bus->opp_token);
>   }
>   
> @@ -171,7 +170,6 @@ static void exynos_bus_passive_exit(struct device *dev)
>   	platform_device_unregister(bus->icc_pdev);
>   
>   	dev_pm_opp_of_remove_table(dev);
> -	clk_disable_unprepare(bus->clk);
>   }
>   
>   static int exynos_bus_parent_parse_of(struct device_node *np,
> @@ -247,23 +245,16 @@ static int exynos_bus_parse_of(struct device_node *np,
>   	int ret;
>   
>   	/* Get the clock to provide each bus with source clock */
> -	bus->clk = devm_clk_get(dev, "bus");
> -	if (IS_ERR(bus->clk)) {
> -		dev_err(dev, "failed to get bus clock\n");
> -		return PTR_ERR(bus->clk);
> -	}
> -
> -	ret = clk_prepare_enable(bus->clk);
> -	if (ret < 0) {
> -		dev_err(dev, "failed to get enable clock\n");
> -		return ret;
> -	}
> +	bus->clk = devm_clk_get_enabled(dev, "bus");
> +	if (IS_ERR(bus->clk))
> +		return dev_err_probe(dev, PTR_ERR(bus->clk),
> +				"failed to get bus clock\n");
>   
>   	/* Get the freq and voltage from OPP table to scale the bus freq */
>   	ret = dev_pm_opp_of_add_table(dev);
>   	if (ret < 0) {
>   		dev_err(dev, "failed to get OPP table\n");
> -		goto err_clk;
> +		return ret;
>   	}
>   
>   	rate = clk_get_rate(bus->clk);
> @@ -281,8 +272,6 @@ static int exynos_bus_parse_of(struct device_node *np,
>   
>   err_opp:
>   	dev_pm_opp_of_remove_table(dev);
> -err_clk:
> -	clk_disable_unprepare(bus->clk);
>   
>   	return ret;
>   }
> @@ -453,7 +442,6 @@ static int exynos_bus_probe(struct platform_device *pdev)
>   
>   err:
>   	dev_pm_opp_of_remove_table(dev);
> -	clk_disable_unprepare(bus->clk);
>   err_reg:
>   	dev_pm_opp_put_regulators(bus->opp_token);
>   

Hi,

if the patch is correct, I think that clk in struct exynos_bus can be 
easily be removed as well.

CJ

