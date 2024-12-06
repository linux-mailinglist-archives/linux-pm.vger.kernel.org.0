Return-Path: <linux-pm+bounces-18728-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12E79E7C56
	for <lists+linux-pm@lfdr.de>; Sat,  7 Dec 2024 00:19:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 943731885139
	for <lists+linux-pm@lfdr.de>; Fri,  6 Dec 2024 23:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A5FF204582;
	Fri,  6 Dec 2024 23:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="UND0e9v7"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A922C6CD;
	Fri,  6 Dec 2024 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733527146; cv=none; b=bN6aCX0MIHA3+HH89OYjhIjF8yhlBBdecsrXTTdHjY2segbae35A79n8f6y6iHhEk6r53tmOINXVmL61hOPKkie6lFgtIcIXpuRG8ZEx29jOt8UZliAw0lYqIqeHEYSjpYCCcpS0R6uF9J5x8qLvqDeRQVGxFGg2tdayvQ614iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733527146; c=relaxed/simple;
	bh=JxTIiy96rTE1YU9SbWroA1I8AUFKzVQGZ7a3IGFt6oE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=icNyJwfkva7i5XVv6SDG5He5strtiL8LNYjBkrU8VssqBMhqx88EArUKFU2V9DeDZ13lIjx2qPw+dH5uz6XfDlmE5AVWc9+4zMkpltdYAa+FyiYlhV85MM9NG4MMS4ZjnTAXBpzEufthXWWpU75j4D/ekvFHu5n7GIsqRzIS6Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=UND0e9v7; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id Jhb3tmgoI3wKNJhb3tAfoD; Sat, 07 Dec 2024 00:18:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1733527135;
	bh=iJWW7bjs8XwyN4BIQGqjB9cOcNKN/bIWxDUv1xg8da4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=UND0e9v7tzPGGp6E7+obUozTJf8mcAnHD1ZLR04dZmh9hwHwg7MJeljXmKQlTurrR
	 6vPurxc5khR3hKArvHM/P43taifzDRf55tZZXpPxwqIidy0cghUl4u1Ah9TJbSIjvx
	 f69wvY9VZuKlgP9HaLs2gZMRZM4oQ96c0Ka3biZk3Hg0Xarbnx485nO+KhyQKiq/nP
	 cLqZt/lDNE4/izURS6lCWscrGB8PoU5KTr+sSxkMQj2fhV5k3b719bEo/ssSpR0RQC
	 n0jb/rbn7eBWMdwtlAYIWm82InCM3+oQ87hPOQ5A5IUf1/tYNLlwvaB4woT5Oz8tzE
	 sOgzvC3DtjUxQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 07 Dec 2024 00:18:55 +0100
X-ME-IP: 90.11.132.44
Message-ID: <81e0e916-b14b-4ecf-b70a-2ce334c174cf@wanadoo.fr>
Date: Sat, 7 Dec 2024 00:18:52 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/drivers/qoriq: Use dev_err_probe() simplify
 the code
To: Frank Li <Frank.Li@nxp.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>,
 "open list:THERMAL" <linux-pm@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20241206225624.3744880-1-Frank.Li@nxp.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241206225624.3744880-1-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 06/12/2024 à 23:56, Frank Li a écrit :
> Use dev_err_probe() and devm_clk_get_optional_enabled() to simplify the
> code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>   drivers/thermal/qoriq_thermal.c | 33 ++++++++++-----------------------
>   1 file changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
> index 52e26be8c53df..baf1b75b97cbe 100644
> --- a/drivers/thermal/qoriq_thermal.c
> +++ b/drivers/thermal/qoriq_thermal.c
> @@ -296,38 +296,27 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>   
>   	base = devm_platform_ioremap_resource(pdev, 0);
>   	ret = PTR_ERR_OR_ZERO(base);
> -	if (ret) {
> -		dev_err(dev, "Failed to get memory region\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get memory region\n");
>   
>   	data->regmap = devm_regmap_init_mmio(dev, base, &regmap_config);
>   	ret = PTR_ERR_OR_ZERO(data->regmap);
> -	if (ret) {
> -		dev_err(dev, "Failed to init regmap (%d)\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to init regmap\n");
>   
> -	data->clk = devm_clk_get_optional(dev, NULL);
> +	data->clk = devm_clk_get_optional_enabled(dev, NULL);
>   	if (IS_ERR(data->clk))
>   		return PTR_ERR(data->clk);
>   
> -	ret = clk_prepare_enable(data->clk);
> -	if (ret) {
> -		dev_err(dev, "Failed to enable clock\n");
> -		return ret;
> -	}
> -
>   	ret = devm_add_action_or_reset(dev, qoriq_tmu_action, data);

clk_disable_unprepare() in qoriq_tmu_action() should be removed as-well.

>   	if (ret)
>   		return ret;
>   
>   	/* version register offset at: 0xbf8 on both v1 and v2 */
>   	ret = regmap_read(data->regmap, REGS_IPBRR(0), &ver);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Failed to read IP block version\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(dev, ret,  "Failed to read IP block version\n");
> +
>   	data->ver = (ver >> 8) & 0xff;
>   
>   	qoriq_tmu_init_device(data);	/* TMU initialization */
> @@ -337,10 +326,8 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	ret = qoriq_tmu_register_tmu_zone(dev, data);
> -	if (ret < 0) {
> -		dev_err(dev, "Failed to register sensors\n");
> -		return ret;
> -	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to register sensors\n");
>   
>   	platform_set_drvdata(pdev, data);
>   


