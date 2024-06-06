Return-Path: <linux-pm+bounces-8707-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4258FE572
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 13:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10071F2567E
	for <lists+linux-pm@lfdr.de>; Thu,  6 Jun 2024 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E708A1953B5;
	Thu,  6 Jun 2024 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=norik.com header.i=@norik.com header.b="llSyIZOq"
X-Original-To: linux-pm@vger.kernel.org
Received: from cpanel.siel.si (cpanel.siel.si [46.19.9.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E353CF73;
	Thu,  6 Jun 2024 11:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.19.9.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717673741; cv=none; b=FIryP/NsK3DIOn5lvzdAAjEWqw3+8CPLmwVblAhMnVVlLnFXqa0ulW6PISxl/VZ3mMuFaE2p/IqN8EHoaWQfit51W0aydmr5WKdexTWM9l9/Vh0U0/tRjqzXjwUBaIrHjBpxwBxf7zIUiYav4N9pPPZ9IyNf/ZiLWhTekTDcPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717673741; c=relaxed/simple;
	bh=ZH6GM36wqlHhZOsej2jjdipbaBgIRrhTvyTHS94ZlNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rvtp/BE+2rzHcGnhpWpuErs1fpcf2w0X5iMWOA3aU0viTKgzOgwMuqroCHd3Y/5050TcIFqWmqqBg1GjgCbnmvKzKTbymT6m6M8OrD1qUm6/jAnpkvohF7kPNgsq8AIUN1Tr7MJ4k9l0YwkbI6UWgUMZoIb/1WsixIRhHd5+uwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com; spf=pass smtp.mailfrom=norik.com; dkim=pass (2048-bit key) header.d=norik.com header.i=@norik.com header.b=llSyIZOq; arc=none smtp.client-ip=46.19.9.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=norik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=norik.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=norik.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lNTRSjnXY/vxH8loIJkYuMWWBy2PzK80kChYWEvfwa4=; b=llSyIZOqfxo/X93D/SbcKYydL6
	VcJzSdtqwjxbutcoswBMlfJOZGqaGdpXmB6+4GZki5FLx+Ap24bK20sZK4zFo9yMtVk2IycOmVu0B
	bi/oGtfeC/nPrKcNO4/+lf0XkvIZAxfgLkljfAU3ZyLmK44cVWnOzGbPP0Wel/v/xSVk+6y06yBqJ
	At9HA6341f1Xiy2an8sAmVL6yK9G+vCHofatGt5nudzoO2J95MsPN4THsPJTjNNuXZnVsQV+0ovpt
	CmC9EMA00ygwjNj81Qrv/OB1ZY79zl/wAOzjxkzEVa5OpJa8tOs1eA5iFZcpxj8v+4FAlUzroJwb1
	yLQpb2Bw==;
Received: from [89.212.21.243] (port=53034 helo=[192.168.69.116])
	by cpanel.siel.si with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <primoz.fiser@norik.com>)
	id 1sFBP8-00CBmD-0v;
	Thu, 06 Jun 2024 13:35:38 +0200
Message-ID: <34dd6ccc-2b0f-45a7-a014-a9d924684f9c@norik.com>
Date: Thu, 6 Jun 2024 13:35:37 +0200
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
 <81919640-b0c4-437c-a04f-1673e8189435@norik.com>
 <20240606105822.a7giftun56dsnbgc@vireshk-i7>
From: Primoz Fiser <primoz.fiser@norik.com>
Content-Language: en-US
Organization: Norik systems d.o.o.
In-Reply-To: <20240606105822.a7giftun56dsnbgc@vireshk-i7>
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

Hi,

sent new series instead of v2.

Link:
https://lore.kernel.org/linux-pm/20240606113334.396693-2-primoz.fiser@norik.com/

BR,
Primoz

On 6. 06. 24 12:58, Viresh Kumar wrote:
> On 06-06-24, 12:34, Primoz Fiser wrote:
>>> Ah, I forgot about the token that is returned here. I think the driver
>>> should be fixed properly once and for all here.
>>>
>>> The token must be used to clean the module removal part. Else if you
>>> try to insert this module, remove it, insert again, you will get some
>>> errors as the resources aren't cleaned well.
>>>
>>> So either provide a remove() callback to the driver, or use
>>> devm_pm_opp_set_config() here.
>>>
>>
>> So basically, you want v2 with:
>>
>>> diff --git a/drivers/opp/ti-opp-supply.c b/drivers/opp/ti-opp-supply.c
>>> index e3b97cd1fbbf..8a4bcc5fb9dc 100644
>>> --- a/drivers/opp/ti-opp-supply.c
>>> +++ b/drivers/opp/ti-opp-supply.c
>>> @@ -392,7 +392,7 @@ static int ti_opp_supply_probe(struct platform_device *pdev)
>>>                         return ret;
>>>         }
>>>  
>>> -       ret = dev_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>>> +       ret = devm_pm_opp_set_config_regulators(cpu_dev, ti_opp_config_regulators);
>>>         if (ret < 0)
>>>                 _free_optimized_voltages(dev, &opp_data);
>>>  
>>> diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
>>> index dd7c8441af42..a2401878d1d9 100644
>>> --- a/include/linux/pm_opp.h
>>> +++ b/include/linux/pm_opp.h
>>> @@ -654,14 +654,14 @@ static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
>>>  }
>>>  
>>>  /* config-regulators helpers */
>>> -static inline int dev_pm_opp_set_config_regulators(struct device *dev,
> 
> Don't remove this, add a new devm_ counterpart.
> 
>>> +static inline int devm_pm_opp_set_config_regulators(struct device *dev,
>>>                                                    config_regulators_t helper)
>>>  {
>>>         struct dev_pm_opp_config config = {
>>>                 .config_regulators = helper,
>>>         };
>>>  
>>> -       return dev_pm_opp_set_config(dev, &config);
>>> +       return devm_pm_opp_set_config(dev, &config);
>>>  }
> 

-- 
Primoz Fiser                    | phone: +386-41-390-545
<tel:+386-41-390-545> |
---------------------------------------------------------|
Norik systems d.o.o.            | https://www.norik.com
<https://www.norik.com>  |
Your embedded software partner  | email: info@norik.com
<mailto:info@norik.com> |
Slovenia, EU                    | phone: +386-41-540-545
<tel:+386-41-540-545> |


