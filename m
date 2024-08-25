Return-Path: <linux-pm+bounces-12861-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 414FE95E39C
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 15:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75180B213B8
	for <lists+linux-pm@lfdr.de>; Sun, 25 Aug 2024 13:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6361113D890;
	Sun, 25 Aug 2024 13:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="INfqn6vN"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A31F1DDE9;
	Sun, 25 Aug 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724593236; cv=none; b=d1ehXcNmkjvLp51kKMDELTjsbW3ETdXRcup1D3r7AO/g48eCFmFUZMAyWvH0f8JKPfKfbTtk86X0I+4LMh41lxacWGv8RMF0d21b/GGCAdViUcTw+8KBNEhPSVpvL0RcAyAi6PDdET6Clwp0ut5AxmTUd0pJwC8SXhj/O+vcU+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724593236; c=relaxed/simple;
	bh=lDuklK7q3QCT4iGA6hRIpyYmNP+Ic8gWGRHG5/1q88E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P2lFlIasGWzTc1sNQBpFQXLO9AisxdTOzcw8T47RNCtPdho0hdfhTrhVla0vOCggS00MTciPpT4L5ES2PObChY9wmh+MIoflt8g3XH+rz2wKhA3AnnetqjtNMPFdZvRDAVsCipWFFBp2e22sI4AhxMAJEme+gXUAl2nyovY55kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=INfqn6vN; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id iDTgsnQX8bNNsiDTgsn5tE; Sun, 25 Aug 2024 15:40:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1724593226;
	bh=AHnIX+a/yIVsUeGn9xjaC+MEHZoIwAnQwChHfduPZS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=INfqn6vNlvNcE3fxreIy6pylKbLxYfrtrPFw3lfYP37S+JG1v0Ffgf+dizJjsNQoj
	 ozylthI+kkw5dobZR9cc2Qh95ViKr7RWUmjhosEJp6v8OjV/kWXQfEHCg3jescgs0h
	 nYYYvpUvKE++0vqJZXwiJAowP4jOG8mp40Et4VQFyTMo4hs8OxH3ko3WM2INfxDvzq
	 YdYuR0VOdTRK1vdIaHsTdhfr7aa602/yhyGRXgaajekm9zWdZqewRWcR6JBMBu7j1X
	 /dvVCJYcSclisPiQqWju9y2YqNlvXJftNJdmpBG1zUIyEYOZmKTet0qmaaSGFThvpq
	 LLXvcxwzmanIw==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 25 Aug 2024 15:40:26 +0200
X-ME-IP: 90.11.132.44
Message-ID: <8cd324a7-1a08-47ca-9729-a5d680ca0589@wanadoo.fr>
Date: Sun, 25 Aug 2024 15:40:20 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] pmdomain: imx93-pd: replace dev_err() with
 dev_err_probe()
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com, Fabio Estevam <festevam@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Peng Fan <peng.fan@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-pm@vger.kernel.org
References: <20240825123626.3877812-1-dario.binacchi@amarulasolutions.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240825123626.3877812-1-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/08/2024 à 14:36, Dario Binacchi a écrit :
> This way, the code becomes more compact, and dev_err_probe() is used in
> every error path of the probe() function.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/pmdomain/imx/imx93-pd.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pmdomain/imx/imx93-pd.c b/drivers/pmdomain/imx/imx93-pd.c
> index d750a7dc58d2..afc482ec563f 100644
> --- a/drivers/pmdomain/imx/imx93-pd.c
> +++ b/drivers/pmdomain/imx/imx93-pd.c
> @@ -126,9 +126,9 @@ static int imx93_pd_probe(struct platform_device *pdev)
>   	if (!domain->init_off) {
>   		ret = clk_bulk_prepare_enable(domain->num_clks, domain->clks);
>   		if (ret) {
> -			dev_err(domain->dev, "failed to enable clocks for domain: %s\n",
> -				domain->genpd.name);
> -			return ret;
> +			return dev_err_probe(domain->dev, ret,
> +					     "failed to enable clocks for domain: %s\n",
> +					     domain->genpd.name);
>   		}

Hi,

you can now also remove the extra { } to be even more compact.

CJ

>   	}
>   


