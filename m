Return-Path: <linux-pm+bounces-8703-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7B58FE463
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 12:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF3FC1C2193B
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 10:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA5818C33C;
	Thu,  6 Jun 2024 10:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="FZOtf0Z1"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D391E52A;
	Thu,  6 Jun 2024 10:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717670076; cv=none; b=kVy5gCX4yDIRFueKh6F6XRUzUmfbwatJwDH2UxqA4v1R4xpEkRuoaaNyhYD90tDQ1woPhF35/DT5TohYNj2OVn2SPRLlNU1bAzbNI0/7aSfYmoOxv1MNjI3wFyIAhcrgB4ECAce0noVj8YQnHZVOyttqMyAKF7MgnzQfUrBwBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717670076; c=relaxed/simple;
	bh=xarlqkaYdeE+nLuxfym9PFsp9VqtRvEoIg16ppfVSTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AS5orAClI0rL2dEK98z3xXfXnRhLMBF/9KwjfKd+up+F+Paq6GKos1weQPokv65O+AUSYzsx1zJZ3flwu3SYr0J09bWeSPgFNJNWUCquG1wbDZVq9Z4Q7ieCE0FZ4kS1/qa/AFPDIVrGb4+KgOsVai/3QEpCWGUZCeRtYvtG6VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=FZOtf0Z1; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Rc5FKMCWeViSJyUVW7Ojcp2k9qIpAlwfQMOpNh6XEuQ=; b=FZOtf0Z1lo7wYP6l6pngnnnLtU
	MP3Fc/W/XVJOKb+oiLiVDJ+z2Ju5eGUSpZX4GP1MYKvaMLHEA2YvCUELgART5fTnYDgxxg4PNS5Kc
	GXSWaDWwTjoUpPBKAhYAzJgWCAxS7eudXjMnpo+Ltd9ik/G9g3j93Z6+CmI/rbaVw+28jQPJEWxmh
	DiQhPA6KAb26o4i1qtLkQS9fMxvxPQGjVABNYarYos0P31xf52DJ/f9tygjYpjHf46PPl7NeU9vAM
	ihPPf79PvY6HzKy6HpnszCLtpbOFTjogNfnwu0C0yFtPv5cew34irtC1J0OuDrp2LdvLlW/IUHX26
	ORFXPx0g==;
Received: from [89.212.21.243] (port=38800 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sFAS0-00C1bQ-18;
	Thu, 06 Jun 2024 12:34:32 +0200
Message-ID: <81919640-b0c4-437c-a04f-1673e8189435@norik.com>
Date: Thu, 6 Jun 2024 12:34:31 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] OPP: ti: Fix ti_opp_supply_probe wrong return values
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de
References: <20240606070127.3506240-1-primoz.fiser@norik.com>
 <20240606085956.wsp3ecyfqck5tltt@vireshk-i7>
 <ed06bac9-6396-426a-b0ea-4932bc5fa7ed@norik.com>
 <20240606094859.6yclnarvlrzl74bj@vireshk-i7>
From: Primoz Fiser <primoz.fiser@norik.com>
Content-Language: en-US
Organization: Norik systems d.o.o.
In-Reply-To: <20240606094859.6yclnarvlrzl74bj@vireshk-i7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel.siel.si
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - norik.com
X-Get-Message-Sender-Via: cpanel.siel.si: authenticated_id: primoz.fiser@norik.com
X-Authenticated-Sender: cpanel.siel.si: primoz.fiser@norik.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi Viresh,

On 6. 06. 24 11:48, Viresh Kumar wrote:
> On 06-06-24, 11:43, Primoz Fiser wrote:
>> ti_opp_supply_probe
>>  -> dev_pm_opp_set_config_regulators
>>   -> dev_pm_opp_set_config (returns negative if error, otherwise >= 1)
> 
> Ah, I forgot about the token that is returned here. I think the driver
> should be fixed properly once and for all here.
> 
> The token must be used to clean the module removal part. Else if you
> try to insert this module, remove it, insert again, you will get some
> errors as the resources aren't cleaned well.
> 
> So either provide a remove() callback to the driver, or use
> devm_pm_opp_set_config() here.
> 

So basically, you want v2 with:

> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
> index e3b97cd1fbbf..8a4bcc5fb9dc 100644
> --- a/drivers/opp/ti-opp-supply.c
> +++ b/drivers/opp/ti-opp-supply.c
> @@ -392,7 +392,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>                         return ret;
>         }
>  
> -       ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
> +       ret = devm_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>         if (ret < 0)
>                 _free_optimized_voltages(dev, &opp_data);
>  
> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
> index dd7c8441af42..a2401878d1d9 100644
> --- a/include/linux/pm_opp.h
> +++ b/include/linux/pm_opp.h
> @@ -654,14 +654,14 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
>  }
>  
>  /* config-regulators helpers */
> -static inline int dev_pm_opp_set_config_regulators(struct device *dev,
> +static inline int devm_pm_opp_set_config_regulators(struct device *dev,
>                                                    config_regulators_t helper)
>  {
>         struct dev_pm_opp_config config = {
>                 .config_regulators = helper,
>         };
>  
> -       return dev_pm_opp_set_config(dev, &config);
> +       return devm_pm_opp_set_config(dev, &config);
>  }
>  
>  static inline void dev_pm_opp_put_config_regulators(int token)

Right?

BR,
Primoz




