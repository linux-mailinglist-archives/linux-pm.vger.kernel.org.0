Return-Path: <linux-pm+bounces-28247-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 809ACAD13FF
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:25:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 704BC3A754E
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 19:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005F71D9A54;
	Sun,  8 Jun 2025 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kYeqFRc4"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B563019343B;
	Sun,  8 Jun 2025 19:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749410714; cv=none; b=nJK0fMWOhAmLAI2qIclWoHeST0BwleWH127cg48YOKfZfRE9KHSfkLXTjqTV29Mvz8n4hfb5QkI+vv9PkzDCfXNSSqBuz2x73Jorvk8KJUtYYIzhgzHTql69coMskRaUL8/YUKeUlLYjUykxweNn6O8h31PJ1rP6zYTeF0AoeIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749410714; c=relaxed/simple;
	bh=w+z1n0H/ZI54B2EQAM5ESY1LA63IHqm/6PwgUYexADs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IRsZLlQCb3eUeZXYAlnW66SoFTo/k3bilDagXBU0B58oArQSXcMIqNuc8RgWV27MKrrsnvEy5yS89ToqOCoRGo/SjQfoe4UgBi47vbFF7GvbgV7tfiKIuw8sqOLRlwSh3AxBo7srD+h+DGXcOyGeTi5hVZ/YpKqxYMM4Ij3U/dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kYeqFRc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0790C4CEEE;
	Sun,  8 Jun 2025 19:25:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749410714;
	bh=w+z1n0H/ZI54B2EQAM5ESY1LA63IHqm/6PwgUYexADs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kYeqFRc4zYbahTwZEPeffzql0DHH9cp0Kzk/HruxmqPT61KQyfnqNHTaXei/RUFyc
	 1Kv3DToU7RzT0MDuFTuzDTOhL3QviDrBwAPSrB4KINjRZofXDzm4hxqM0ZgGDL5obJ
	 OpmCMMK9GcwSymqTwJOMc4hKmBosyEg702qxEy2dTqBZ2UxCCdJcBMaqaxJs5I+EXz
	 vlcpPuhovC+7xQd4EYFa/aRuUVbH7bFbHkOvD/RjUsj2PcgV6lxcJuHrhYuS1uxnzV
	 EklV8MZRyTXN6380NWXgVmE1/ju3pTe2iJFuER4yioOhHoNieL/CXOSeTqwN50iBaP
	 fzjO1SR7P7JKg==
Message-ID: <66a5a4d6-691c-4b3f-8356-dce8b52b0940@kernel.org>
Date: Sun, 8 Jun 2025 21:25:08 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] regulator: act8865-regulator: switch psy_cfg from
 of_node to fwnode
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, Hans de Goede <hdegoede@redhat.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, =?UTF-8?Q?Pali_Roh=C3=A1r?=
 <pali@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@vger.kernel.org
References: <20250430-psy-core-convert-to-fwnode-v2-0-f9643b958677@collabora.com>
 <20250430-psy-core-convert-to-fwnode-v2-1-f9643b958677@collabora.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250430-psy-core-convert-to-fwnode-v2-1-f9643b958677@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 30-Apr-25 12:54 AM, Sebastian Reichel wrote:
> In order to remove .of_node from the power_supply_config struct,
> use .fwnode instead.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
>  drivers/regulator/act8865-regulator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
> index 0457af23c55acdd97b2cdc6fd6bfd07ae0f9d11f..b2a6ddc6f56d32e8758977e25858b972e294bc84 100644
> --- a/drivers/regulator/act8865-regulator.c
> +++ b/drivers/regulator/act8865-regulator.c
> @@ -643,7 +643,7 @@ static int act8600_charger_probe(struct device *dev, struct regmap *regmap)
>  	struct power_supply *charger;
>  	struct power_supply_config cfg = {
>  		.drv_data = regmap,
> -		.of_node = dev->of_node,
> +		.fwnode = dev_fwnode(dev),
>  	};
>  
>  	charger = devm_power_supply_register(dev, &act8600_charger_desc, &cfg);
> 


