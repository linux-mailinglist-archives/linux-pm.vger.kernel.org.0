Return-Path: <linux-pm+bounces-28248-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BD3AD1401
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 21:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9660716866C
	for <lists+linux-pm@lfdr.de>; Sun,  8 Jun 2025 19:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDFF91D9A5F;
	Sun,  8 Jun 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c2wmdgh2"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A819343B;
	Sun,  8 Jun 2025 19:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749410766; cv=none; b=bEpHCOdoIszqVZPzqV9pEhi+JlgPEo8TaWww5zPLoTXN7j/Zt2rwwijA4h9ZKTLA5gxnYZelQrWv2o5XQ7etelIiehfHzBXn3Ns78+v0NVb8p4KSPNqvN0rJNH4GDfriug9/PDB/sx9pLPoT10FbRZs6jPVV3ktx72IjiKQNBBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749410766; c=relaxed/simple;
	bh=csPVNLbB7ZSUAkNe1rSDo7tLgCUrjJcZasqOJ1XzZK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hONCoOgjmemUiCLQ+wpAbzeW3/Pq/gn9w7ebRNovGjYmbsmCl7TeKD/xc21PJvy5qXn3WuBtfXQ+pk6dzFKJsSiaU9Vx2up1kn3k09RVOLlALaBmNpUXXCYrgOZ9GdCSXAvGv1obERPgBEloZeFqFCRd5KQ+3+VrUHb+EQT0JSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c2wmdgh2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2003C4CEEE;
	Sun,  8 Jun 2025 19:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749410766;
	bh=csPVNLbB7ZSUAkNe1rSDo7tLgCUrjJcZasqOJ1XzZK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=c2wmdgh2onvXXe3kx43LjtTwj3JM0P2iYcw4l6rin4uXHYBCm7PZXzvbmoRAHuAQ0
	 EcwLD3ITjrQE8+VhsXQwysxv2i4x87IAIy66M6UFK8HMEwFnUsQd/YcllvlSpqxvRp
	 m/f+qth6O0FcWqptVWh7bVltN8gL6iePVMhck6BGNvYUcm/WDYmKKP6yq5N/wqZHtU
	 SGh5zgAge3JFBGPgR1ZOsCiM55KGF2ObAmB6oisdP6Ok3Mkba8F+zLi7jhH5tCFi4a
	 +nNM/jiQ/HWAq52TS/mcYvdusVVrtdrYA3JJkI/NRpymROTF7Vr/6e7XTXVBV/F0y+
	 C+h0raLgJCb+A==
Message-ID: <b6e1c8af-dd37-4ea6-b076-dd1f1d9a11a0@kernel.org>
Date: Sun, 8 Jun 2025 21:26:01 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] power: supply: core: remove of_node from
 power_supply_config
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Mark Brown <broonie@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>
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
 <20250430-psy-core-convert-to-fwnode-v2-2-f9643b958677@collabora.com>
Content-Language: en-US, nl
From: Hans de Goede <hansg@kernel.org>
In-Reply-To: <20250430-psy-core-convert-to-fwnode-v2-2-f9643b958677@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 30-Apr-25 12:54 AM, Sebastian Reichel wrote:
> All drivers have been migrated from .of_node to .fwnode,
> so let's kill the former.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans


> ---
>  drivers/power/supply/power_supply_core.c | 3 +--
>  include/linux/power_supply.h             | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 33a5bfce4604f012344733ba489eda1c5e8b92c0..89947f1fe610d8a75756e1e4e5339b06349f9ab8 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -1529,10 +1529,9 @@ __power_supply_register(struct device *parent,
>  	dev_set_drvdata(dev, psy);
>  	psy->desc = desc;
>  	if (cfg) {
> +		device_set_node(dev, cfg->fwnode);
>  		dev->groups = cfg->attr_grp;
>  		psy->drv_data = cfg->drv_data;
> -		dev->of_node =
> -			cfg->fwnode ? to_of_node(cfg->fwnode) : cfg->of_node;
>  		psy->supplied_to = cfg->supplied_to;
>  		psy->num_supplicants = cfg->num_supplicants;
>  	}
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index c4cb854971f53a244ba7742a15ce7a5515da6199..b6eb31a23c878aa9ed8ad7bcb02a13721354e1cb 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -229,7 +229,6 @@ struct power_supply;
>  
>  /* Run-time specific power supply configuration */
>  struct power_supply_config {
> -	struct device_node *of_node;
>  	struct fwnode_handle *fwnode;
>  
>  	/* Driver private data */
> 


