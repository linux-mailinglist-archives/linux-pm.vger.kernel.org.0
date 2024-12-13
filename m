Return-Path: <linux-pm+bounces-19208-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF69F14F6
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A79D8168E54
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 18:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8971C18A92C;
	Fri, 13 Dec 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="spOKTCR2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30421DA5F;
	Fri, 13 Dec 2024 18:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114720; cv=none; b=gACWWdbF3oEWyv3U7aGXEpHhRXhAiKzdpvBANOmgWSdvSOpiV4gnmJVdsCN2mUvww3TNYV6WW31R9FTdUhZ82Af5jV688mLKwpjHBEklNX1orFnB6dCLCyP8JvfsbnZ6Zbz8X5gbQCk7lj2n9/84ZACmeJpf7Dq2+yIF/wIMOmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114720; c=relaxed/simple;
	bh=T3PCOXRgslDvYFRSEyw1FHGZH0CB9Yc0PyTvw+XPkoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PGq9myfIO+t8HFkCeP6629wEvTJVp4NfnIBtR4jINylYsIdmhEG8G0yMxiSoMfsE5CxwKE3sl5Unj+rK35qR7TuWXhl7awsU5PAFkcOara7HPJ8I6gxKpoBDvVsLUbwQcJKGOOstuthKZ7d6OoCyb/MFw+8PIF1LIlN+LruOBeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=spOKTCR2; arc=none smtp.client-ip=80.12.242.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id MAS2tfinZ16pxMAS3tV7CF; Fri, 13 Dec 2024 19:31:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734114707;
	bh=eumrcL79IYeHxeu0sdLBZY1C8OjtUoFdZuO5pn6cZsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=spOKTCR24mb13/tR68WrnfEApE33WVzBY19rozmP9jHnvr9bYWBwerhQ5S1sawKZh
	 i0JutCMzzN5zEkQIxmoAzE5xMFG3nsaMWfkyhGBSGYOXMa4180JzLsTXMyudlY8OBG
	 bD0pdtSKVERASfsWb2kkq1DH4zvlVvX+urKGs7DQcguxCUNCD4Q6m1VaJqJ0kisNTm
	 Nk6d2Mu4/4mLDDIhOHqhBcM99Y44TG1ZL1xl47AYb5B0QOgj2169XEd+41bjFqw35t
	 RvGuciYXfmFUgJKsIWMjJcTuIJd7Y5n3JZAbfuiPmNHVLWE5adSGKtuPTisbeGlZ3w
	 f2mb4ZRP/4o2Q==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Dec 2024 19:31:47 +0100
X-ME-IP: 90.11.132.44
Message-ID: <723a8253-a936-4901-9a05-a20f27fdb07c@wanadoo.fr>
Date: Fri, 13 Dec 2024 19:31:45 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] power/supply: Add support for ltc4162-f/s and
 ltc4015
To: Kim Seer Paller <kimseer.paller@analog.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kim Seer Paller <kimseer.paller@analog.com>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mike Looijmans <mike.looijmans@topic.nl>
References: <20241213023746.34168-1-kimseer.paller@analog.com>
 <20241213023746.34168-3-kimseer.paller@analog.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241213023746.34168-3-kimseer.paller@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 13/12/2024 à 03:37, Kim Seer Paller a écrit :
> LTC4162-L 35V/3.2A Multi-Cell Lithium-Ion Step-Down Battery Charger
> LTC4162-F 35V/3.2A Multi-Cell LiFePO4 Step-Down Battery Charger
> LTC4162-S 35V/3.2A Lead-Acid Step-Down Battery Charger
> LTC4015 35V/3.2A Multichemistry Buck Battery Charger Controller

...

> +static int ltc4015_get_vcharge(struct ltc4162l_info *info,
> +			       unsigned int reg,
> +			       union power_supply_propval *val)
>   {
> -	u8 cell_count = ltc4162l_get_cell_count(info);
> +	unsigned int regval, chem_type;
> +	int ret;
> +	u32 voltage;
> +
> +	ret = regmap_read(info->regmap, reg, &regval);
> +	if (ret)
> +		return ret;
>   
> -	if (!cell_count)
> -		return -EBUSY; /* Not available yet, try again later */
> +	regval &= BIT(6) - 1; /* Only the lower 5 bits */

Nitpick, should there be a v7:
	Would using GENMASK(5, 0) be clearer and self-explanatory?

> +
> +	/*
> +	 * charge voltage setting can be computed from:
> +	 * cell_count × (vcharge_setting × a + b)
> +	 * where vcharge_setting ranges from 0 to c (d).
...

CJ

