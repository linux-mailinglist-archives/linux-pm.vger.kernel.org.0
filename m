Return-Path: <linux-pm+bounces-22862-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F7A433B4
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 04:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 329C318989B3
	for <lists+linux-pm@lfdr.de>; Tue, 25 Feb 2025 03:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545C024C689;
	Tue, 25 Feb 2025 03:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="aPj6j68H"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30953242912;
	Tue, 25 Feb 2025 03:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454805; cv=none; b=VZv+jl5qLbrF5exRoa6HEp/vicXoQomYvtH2VfQz4Dt/LdF94kg1QqAYdQCoO1yP+GSkuTI8UMORLwj/4t0bIg9X/U0BTt6XFqrwiRnP3Xf8hQws2Efd8/hab2P+QxPcEPOwBYASJM0yBfqfcdfJ4STbJhBfRQXJo3MEPEAMrLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454805; c=relaxed/simple;
	bh=6eC1Ex6Lga2/zVxCD43BHFsYHtz3Za7K6fsq5NQxa9g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=thUN9xcgnq+cfdaVbmRQ9u4eUe3w6ZQMz8zsWTwB5U0gV1Nub4ju/DPfOIJ7l1HpzKu4x8vT+JgPIaRoXURa2sv6jh9b/KhoiNh6ub3FXawvhihgEy0zoWcWVOKBdBFZ+3qcJ3PQ7wkquzzruzoGJ0nBrrmohk6xbKNZ8ZUxUXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=aPj6j68H; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740454793; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kU7ee/i+ZOxoBjtiiWDHV696ORQ4RA5ytO40/bKzA7c=;
	b=aPj6j68HrMRmxg7rG206S9rayfqJrG+OSqqrHc4vK9WAS0p2VfMqPwf4mOINc3tnJBxkAR4CfX6gNgxM1xumqr8aoxfxOQOBn+IFPYs49zisZ6SItLTq1v6jLbqPB7QeKcdfNg7KED+U/pIT0yy7sk6N/SVdMy7PhdF3xSTejqk=
Received: from 30.74.144.116(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WQD4a1M_1740454790 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 25 Feb 2025 11:39:51 +0800
Message-ID: <0af9a7d7-e710-4634-ade8-6a3cf324bb5e@linux.alibaba.com>
Date: Tue, 25 Feb 2025 11:39:48 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] power: supply: all: switch psy_cfg from of_node to
 fwnode
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 Samuel Holland <samuel@sholland.org>, David Lechner <david@lechnology.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
 Purism Kernel Team <kernel@puri.sm>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Orson Zhai <orsonzhai@gmail.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20250225-psy-core-convert-to-fwnode-v1-0-d5e4369936bb@collabora.com>
 <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250225-psy-core-convert-to-fwnode-v1-4-d5e4369936bb@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2025/2/25 07:21, Sebastian Reichel wrote:
> When registering a power-supply device, either a of_node or the more
> recent fwnode can be supplied. Since fwnode can also contain an of_node,
> let's try to get rid of it.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

[snip]

>   drivers/power/supply/sc2731_charger.c       | 2 +-
>   drivers/power/supply/sc27xx_fuel_gauge.c    | 3 +--

> diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
> index 50d5157af9277dc09fe24852747f4f62e72bc712..58b86fd78771360f74ffdad152c3905e1bee7c1b 100644
> --- a/drivers/power/supply/sc2731_charger.c
> +++ b/drivers/power/supply/sc2731_charger.c
> @@ -480,7 +480,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
>   	}
>   
>   	charger_cfg.drv_data = info;
> -	charger_cfg.of_node = np;
> +	charger_cfg.fwnode = dev_fwnode(&pdev->dev);
>   	info->psy_usb = devm_power_supply_register(&pdev->dev,
>   						   &sc2731_charger_desc,
>   						   &charger_cfg);
> diff --git a/drivers/power/supply/sc27xx_fuel_gauge.c b/drivers/power/supply/sc27xx_fuel_gauge.c
> index f36edc2ba708748d0ceb61298056f8c905aca012..196d96cd986266738785d8582e907858faaf2ba3 100644
> --- a/drivers/power/supply/sc27xx_fuel_gauge.c
> +++ b/drivers/power/supply/sc27xx_fuel_gauge.c
> @@ -1141,7 +1141,6 @@ static int sc27xx_fgu_hw_init(struct sc27xx_fgu_data *data)
>   static int sc27xx_fgu_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
> -	struct device_node *np = dev->of_node;
>   	struct power_supply_config fgu_cfg = { };
>   	struct sc27xx_fgu_data *data;
>   	int ret, irq;
> @@ -1205,7 +1204,7 @@ static int sc27xx_fgu_probe(struct platform_device *pdev)
>   	platform_set_drvdata(pdev, data);
>   
>   	fgu_cfg.drv_data = data;
> -	fgu_cfg.of_node = np;
> +	fgu_cfg.fwnode = dev_fwnode(dev);
>   	data->battery = devm_power_supply_register(dev, &sc27xx_fgu_desc,
>   						   &fgu_cfg);
>   	if (IS_ERR(data->battery)) {

For sc27xx parts:

Acked-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thanks.

