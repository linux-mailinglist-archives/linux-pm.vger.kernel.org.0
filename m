Return-Path: <linux-pm+bounces-39766-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E189CD4848
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 02:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB9813005F21
	for <lists+linux-pm@lfdr.de>; Mon, 22 Dec 2025 01:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB630F7FB;
	Mon, 22 Dec 2025 01:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="Fa9WENIm"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A930C619;
	Mon, 22 Dec 2025 01:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766367706; cv=pass; b=H2AGSrfOPl1LFS3V7US4IqmL4xwLu8OUnP9l3STy4KJhRKAw1BPGFS//EGEe5x4ktpCfX6qViTDyrJRbrtBJ1aRSekx6tWtIFeJROIVJPTBo2qQ7CM+6s6Y1EqAgdGbb+ZhjTPzR2WySVgOoSuUSwlwVFIfu7+X4DA92WyIB1hI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766367706; c=relaxed/simple;
	bh=uJ+HVrOMWfCJQUaeMyKudL48kiEZzBMGryL54qhKwJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0bDnOVwBj4y26FNzp8srGworPC2/DxD1F1l8KR0A29Qu1NmIYfnRKs/J0R54t/WlfcOjQxyXgPjIN2eSkQk/2+Zp4KH5qdmJdxNYczC6TXPMs01oMPxxY+UVpaC1/GK/+s9Jn5TibqTOil1JMDEz3ULR6MAQc3sAeJhkC9HP8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=Fa9WENIm; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1766367577; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KBsLHSAarQUwN6Mc/W7D0mvxXCxlmBViJtujrrxHpqDl6XuBwH36BN7Wc4+S8eLGII7u+7NxBQ7k2loyhS7G1ZXkWvHrkR9LOqypXAEHoL6NPzs3fkNB2BPq4DCnaZw8W8kzN36yaQHDfsJaQWIDeOyWzsD5hKVuFNWS6KUwAV8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1766367577; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wKm6BelI5UzQkTJhxf1DHtTgxvzKM+zOwwM2yQXybfQ=; 
	b=AfuIufjLv07lvqXqtsuamUkU2fBI7k3RXEwah1GEm1bae4F71Q8i4BP8gNQXZNQi5S25j3bNjqfkbXTFP0TLDsiD0HWxvfiZPSgtnX/q6GwOIZyhVoxHuqXzum+jCvdibfrpnkXLQuBvvtVJZdfCN+hMyTMLFuLmtcLoa31+bpg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1766367577;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=wKm6BelI5UzQkTJhxf1DHtTgxvzKM+zOwwM2yQXybfQ=;
	b=Fa9WENImYUxUomi3mgm0BE9irq1DhT/eWSo73KBWD74p9DNtPklPc/i8B6YIO4x3
	o+1s0DAYn9+d8KTxsKoSlHolALtbF89Vfm71trajh7vFdejbeWgP8NdH5RNHgfMxbWx
	qnh0QqiEx2opoIXomGdb/Jo88MkdXiBXzCtJd+AM=
Received: by mx.zohomail.com with SMTPS id 1766367574825926.5109115965784;
	Sun, 21 Dec 2025 17:39:34 -0800 (PST)
Received: by venus (Postfix, from userid 1000)
	id CDA3A181972; Sun, 21 Dec 2025 21:57:01 +0900 (JST)
Date: Sun, 21 Dec 2025 21:57:01 +0900
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kamal.wadhwa@oss.qualcomm.com, 
	fenglin.wu@oss.qualcomm.com
Subject: Re: [PATCH 2/2] power: supply: core: Add SiLION battery technology
Message-ID: <aUft_bUIhiMJF_2A@venus>
References: <20251124-add_silion_battery-v1-0-3c86b70d2543@oss.qualcomm.com>
 <20251124-add_silion_battery-v1-2-3c86b70d2543@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251124-add_silion_battery-v1-2-3c86b70d2543@oss.qualcomm.com>
X-ZohoMailClient: External

Hi,

On Mon, Nov 24, 2025 at 04:42:41PM +0530, Rakesh Kota wrote:
> Add support for lithium-ion-silicon-anode (SiLION) battery technology
> to enable proper identification of devices using this newer battery
> chemistry. Without this change, such batteries would report as
> unknown technology.
> 
> Introduce POWER_SUPPLY_TECHNOLOGY_SiLION and update technology
> mappings across core, sysfs, and test interfaces.
> 
> Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> ---

The change itself looks good to me, but it must be submitted with a
user (e.g. an update to the qcom_battmgr) as a follow-up patch.

Greetings,

-- Sebastian

>  Documentation/ABI/testing/sysfs-class-power | 2 +-
>  drivers/power/supply/power_supply_core.c    | 2 ++
>  drivers/power/supply/power_supply_sysfs.c   | 1 +
>  drivers/power/supply/test_power.c           | 3 ++-
>  include/linux/power_supply.h                | 1 +
>  5 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 4b21d5d2325136be65126d4d1d6e64608280fe44..1f42e6f138ea8ae0fe8c232c38d0ff6fb20180e7 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -525,7 +525,7 @@ Description:
>  
>  		Valid values:
>  			      "Unknown", "NiMH", "Li-ion", "Li-poly", "LiFe",
> -			      "NiCd", "LiMn"
> +			      "NiCd", "LiMn", "Si-Li-ion"
>  
>  
>  What:		/sys/class/power_supply/<supply_name>/voltage_avg,
> diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
> index 9a28381e2607d650fa9b719b683af375bb118fad..385ab8aa7e69f3f804e7ac0ee3782446f18e2c3f 100644
> --- a/drivers/power/supply/power_supply_core.c
> +++ b/drivers/power/supply/power_supply_core.c
> @@ -677,6 +677,8 @@ int power_supply_get_battery_info(struct power_supply *psy,
>  			info->technology = POWER_SUPPLY_TECHNOLOGY_LiFe;
>  		else if (!strcmp("lithium-ion-manganese-oxide", value))
>  			info->technology = POWER_SUPPLY_TECHNOLOGY_LiMn;
> +		else if (!strcmp("lithium-ion-silicon-anode", value))
> +			info->technology = POWER_SUPPLY_TECHNOLOGY_SiLION;
>  		else
>  			dev_warn(&psy->dev, "%s unknown battery type\n", value);
>  	}
> diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
> index 198405f7126f96a57a549cd1ecb9b71089b9c3d0..f2a5ec519b2ef60fb5ede101ca461d899218e186 100644
> --- a/drivers/power/supply/power_supply_sysfs.c
> +++ b/drivers/power/supply/power_supply_sysfs.c
> @@ -122,6 +122,7 @@ static const char * const POWER_SUPPLY_TECHNOLOGY_TEXT[] = {
>  	[POWER_SUPPLY_TECHNOLOGY_LiFe]		= "LiFe",
>  	[POWER_SUPPLY_TECHNOLOGY_NiCd]		= "NiCd",
>  	[POWER_SUPPLY_TECHNOLOGY_LiMn]		= "LiMn",
> +	[POWER_SUPPLY_TECHNOLOGY_SiLION]	= "Si-Li-ion",
>  };
>  
>  static const char * const POWER_SUPPLY_CAPACITY_LEVEL_TEXT[] = {
> diff --git a/drivers/power/supply/test_power.c b/drivers/power/supply/test_power.c
> index 2c0e9ad820c0db23165758303a16bddac1a1634b..64bd4a1147ca06566a909513a80760ad707a8605 100644
> --- a/drivers/power/supply/test_power.c
> +++ b/drivers/power/supply/test_power.c
> @@ -437,6 +437,7 @@ static struct battery_property_map map_technology[] = {
>  	{ POWER_SUPPLY_TECHNOLOGY_LiFe, "LiFe" },
>  	{ POWER_SUPPLY_TECHNOLOGY_NiCd, "NiCd" },
>  	{ POWER_SUPPLY_TECHNOLOGY_LiMn, "LiMn" },
> +	{ POWER_SUPPLY_TECHNOLOGY_SiLION, "SiLION" },
>  	{ -1,				NULL   },
>  };
>  
> @@ -733,7 +734,7 @@ MODULE_PARM_DESC(battery_present,
>  
>  module_param(battery_technology, battery_technology, 0644);
>  MODULE_PARM_DESC(battery_technology,
> -	"battery technology <NiMH|LION|LIPO|LiFe|NiCd|LiMn>");
> +	"battery technology <NiMH|LION|LIPO|LiFe|NiCd|LiMn|SiLION>");
>  
>  module_param(battery_health, battery_health, 0644);
>  MODULE_PARM_DESC(battery_health,
> diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
> index 360ffdf272dab86241f1aac4650d1a91a088a84b..04996037219d5a22d2b2a7f136e5d3565a4507ca 100644
> --- a/include/linux/power_supply.h
> +++ b/include/linux/power_supply.h
> @@ -83,6 +83,7 @@ enum {
>  	POWER_SUPPLY_TECHNOLOGY_LiFe,
>  	POWER_SUPPLY_TECHNOLOGY_NiCd,
>  	POWER_SUPPLY_TECHNOLOGY_LiMn,
> +	POWER_SUPPLY_TECHNOLOGY_SiLION,
>  };
>  
>  enum {
> 
> -- 
> 2.34.1
> 

