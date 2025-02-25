Return-Path: <linux-pm+bounces-22878-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6B5A43D53
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 12:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961233BA802
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 11:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB99720AF78;
	Tue, 25 Feb 2025 11:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSPvHeia"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003AF206F38;
	Tue, 25 Feb 2025 11:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740482048; cv=none; b=QpeSvpplcW3TUYkxp+CesIaGtYFWAktO5FQ+zMmZDiK4gCcno/5wSNZxPRWGyfoeaWW+TqeG8IOM1djMGawvNqcodJaD3j6cus2XrnYJaPSx1KGcQtWkkY7HtGkoBmHgwsHJFo/WIiGkBfcfatKFmBF89h4mkElTaouI3oZe4IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740482048; c=relaxed/simple;
	bh=DANjY5TtCCrp11jRRZ29qp0AepL6LXWb2OAgWasVe/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HNIQ5Rdjyex16003/01UE2RBdmqoW2ZMosohyyGhm3Ik/lh44RnZS1mgYm+QmwOSQfmq7/r9a9cxitUhnDyBUDZHUHodZ+h7A4rzSYxLWTKNG+cUVvEkRtcEviESafok7lEnRqH10bjIcizYaQyr2myeFCSlsqSoKir/O1JriFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSPvHeia; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5452ca02bdbso5109978e87.1;
        Tue, 25 Feb 2025 03:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740482045; x=1741086845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rgo3Wa66A+J6hx1qOkgMYaAB9PtHBgkCHBMzDDLog5w=;
        b=SSPvHeiaReRunJYFmInDFwnMo8p1XsXRsFmScVE6EptBkjfwZ7+G191lyy33v7uyJ+
         JSmjLneiYem0+WKRAVYkVYcJUQWdpNX/F08pKLnyTImx3V8LNVdsZ0cKFzRpusGJkZsr
         E+PKYxGp6khhnJy+UUnmyrp1E4EgHqqu531GncCVdvDiu5MxRw3HE3VdzEDNqczoY7a0
         dKqhFQD9tkV9sluG9DSVy6Km7Sr/UqH4foUD5GUBLDfLmPoWONFPHUVGLrRURljn9vxl
         /GTZpeakr9jmtpQzVCpag6bfEMR3h9tsEnOIRxD1QBC4uw5LbWymTK/W2TDhpkWVqjWS
         8GHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740482045; x=1741086845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgo3Wa66A+J6hx1qOkgMYaAB9PtHBgkCHBMzDDLog5w=;
        b=kHGf4C9ZdvhyW8tPiUjP/VH65lxmWPlaAEg//Z9h/ukOO1ibJ9ZxXVxh+Na9snsgYQ
         s2G3C6kJT/qZXx+W4oJcLoGnL8BVO+czyaf7zEgJHF/rsOyf4UYbF81IX8PcDW7mT302
         DFhkG8KYmyT4Szl9PG1gcyFfdMqYWsdyPo/ut6vwn20wwI8/C3PxP3NyPlP0gdUyn5Fp
         QYSCdTh0nS3KyMHZBCP9hLxkg5htg1W8CYC9lyBO4VSYHIKgvQuuFjcVAsjTVmydSHoh
         HtAIY+EaPYFUzE25fOlrvMuvPJg+nBfct6xmqB9zH5WUd9LmFOxmyE/HTHycafjjRoLK
         l/hA==
X-Forwarded-Encrypted: i=1; AJvYcCUGR/VKNFpN0ypPfUvch8LLEzbZliHUAkJOImhaOYR9zQH01+rHPCFPy6qbkCfB6jX4yLP1/rvtKhR5@vger.kernel.org, AJvYcCUzbbQeYlh9hR0xAMeoHSV+BV4t7/5aQUwI9mEjyqdAw7LlWdiUpYo4muUBLO1BkHEr7Da8wq55eBOrz+k=@vger.kernel.org, AJvYcCVjG0nbL7JGVKywZjYqNaOaeEKbPZVWeyHd/ywTQvNJMRIqdEQ1vMxHW6+qpkADj8IJWr5jtCRbGcQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa/vmvgZwIBeb9Rr8McZZjys4Os98o7RuEly8KiSfLvVn+3Plc
	DCoQqummLVKoo/jSa3cCNxh/bSw8O5n7IA5vSMpe/rf572Orx963
X-Gm-Gg: ASbGncu2XyXl24LVXVjlvplGikAoulSiFbIQGQxZIZDSlF8/j2aydxApBxYfMosCP9y
	wuQ7OZTtxMMZTXmsPgWXJ+5QeJPwP0AMOOwP5HZmqwHJ18x50KhIgh2zOxduO6GgCKLqeiRiQR7
	FznxfZp22d+TPpT/IHfCellwFJY2oWaLrQCxYiwJLYlrNlGLzXmnMn1UJbjnlEESZOeHxIuE48U
	JRUWCyv8x05vG23VIpZENro4OyQELaHj7Ym63MKbp+NBqSJdEUw1RU06pftuKlsiUS/y82e62sW
	kQSevOUXLxq44ZW/vHTVkW3+f/hLMt0Bxwf34hw=
X-Google-Smtp-Source: AGHT+IH87webjBqQp4/vTTkCKu3naPzYWwEogj7hx0iJcKdAdu9PM46iA4Pc1YwDJQyPV713p/gb8g==
X-Received: by 2002:a05:6512:3e13:b0:545:e19:ba1c with SMTP id 2adb3069b0e04-548510d272cmr1073827e87.19.1740482044737;
        Tue, 25 Feb 2025 03:14:04 -0800 (PST)
Received: from [172.16.183.207] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5487950a4besm86332e87.124.2025.02.25.03.14.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 03:14:04 -0800 (PST)
Message-ID: <491e20bb-5ab4-40e9-bb35-5e05dc7bd46c@gmail.com>
Date: Tue, 25 Feb 2025 13:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] power: supply: core: get rid of of_node
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Samuel Holland <samuel@sholland.org>,
 David Lechner <david@lechnology.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-1-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25/02/2025 01:21, Sebastian Reichel wrote:
> This removes .of_node from 'struct power_supply', since there
> is already a copy in .dev.of_node and there is no need to have
> two copies.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   drivers/power/supply/power_supply_core.c | 17 ++++++++---------
>   include/linux/power_supply.h             |  1 -
>   2 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index d0bb52a7a0367a8e07787be211691cad14a41a54..11030035da6f121ca76bebf800c06cfd5db57578 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -200,11 +200,11 @@ static int __power_supply_populate_supplied_from(struct power_supply *epsy,
>   	int i = 0;
>   
>   	do {
> -		np = of_parse_phandle(psy->of_node, "power-supplies", i++);
> +		np = of_parse_phandle(psy->dev.of_node, "power-supplies", i++);
>   		if (!np)
>   			break;
>   
> -		if (np == epsy->of_node) {
> +		if (np == epsy->dev.of_node) {
>   			dev_dbg(&psy->dev, "%s: Found supply : %s\n",
>   				psy->desc->name, epsy->desc->name);
>   			psy->supplied_from[i-1] = (char *)epsy->desc->name;
> @@ -235,7 +235,7 @@ static int  __power_supply_find_supply_from_node(struct power_supply *epsy,
>   	struct device_node *np = data;
>   
>   	/* returning non-zero breaks out of power_supply_for_each_psy loop */
> -	if (epsy->of_node == np)
> +	if (epsy->dev.of_node == np)
>   		return 1;
>   
>   	return 0;
> @@ -270,13 +270,13 @@ static int power_supply_check_supplies(struct power_supply *psy)
>   		return 0;
>   
>   	/* No device node found, nothing to do */
> -	if (!psy->of_node)
> +	if (!psy->dev.of_node)
>   		return 0;
>   
>   	do {
>   		int ret;
>   
> -		np = of_parse_phandle(psy->of_node, "power-supplies", cnt++);
> +		np = of_parse_phandle(psy->dev.of_node, "power-supplies", cnt++);
>   		if (!np)
>   			break;
>   
> @@ -606,8 +606,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
>   	const __be32 *list;
>   	u32 min_max[2];
>   
> -	if (psy->of_node) {
> -		battery_np = of_parse_phandle(psy->of_node, "monitored-battery", 0);
> +	if (psy->dev.of_node) {
> +		battery_np = of_parse_phandle(psy->dev.of_node, "monitored-battery", 0);
>   		if (!battery_np)
>   			return -ENODEV;

This reminded me of a change I once did to power_supply - but maybe 
never got it further than RFC stage. Anyways, do you think it would be 
possible to decouple the battery info and struct power_suppply (while at 
it)?

I believe that the chargers and especially fuel-gauges which are 
designed to operate with different batteries (and which get battery 
details using static battery nodes), would like to get the battery info 
_before_ registering the power_supply (to avoid sending bogus values 
while operating on defaults, before the battery info is read and before 
things are set accordingly).

I know this may be a bit much to ask, but I believe it'd be an improvement.

Other than that, looks good to me.

>   
> @@ -1544,9 +1544,8 @@ __power_supply_register(struct device *parent,
>   	if (cfg) {
>   		dev->groups = cfg->attr_grp;
>   		psy->drv_data = cfg->drv_data;
> -		psy->of_node =
> +		dev->of_node =
>   			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
> -		dev->of_node = psy->of_node;
>   		psy->supplied_to = cfg->supplied_to;
>   		psy->num_supplicants = cfg->num_supplicants;
>   	}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 6ed53b292162469d7b357734d5589bff18a201d0..975ccab56597ef579ef0c9dc913dcb0a26b5855a 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -316,7 +316,6 @@ struct power_supply {
>   
>   	char **supplied_from;
>   	size_t num_supplies;
> -	struct device_node *of_node;
>   
>   	/* Driver private data */
>   	void *drv_data;
> 


