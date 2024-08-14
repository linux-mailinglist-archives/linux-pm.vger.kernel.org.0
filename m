Return-Path: <linux-pm+bounces-12212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A950C952071
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 18:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5EB1C235DD
	for <lists+linux-pm@lfdr.de>; Wed, 14 Aug 2024 16:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F391BB695;
	Wed, 14 Aug 2024 16:50:57 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EFA3FB3B;
	Wed, 14 Aug 2024 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654257; cv=none; b=nlM4Twxy6Fc9a6PYcUGWmeLA/RWz3PpylZ4bI36zG7M44aMA7bVVzzhnFjfOBScjsDEELJNDdeJW9EFKvhbtXGi6h4jhfGh75hclVtNbtxMc1SYuzCZCMtwxj+1VL+AZNLpWrp8kyApiTTYzuU09MJ5isFVFWVuPVIL1KANRTUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654257; c=relaxed/simple;
	bh=44pcqnfDX2QNV25EOPVIw0NYpln9fEswOHABtyx2jfM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J4xH/MxOx7T/qf+LnhIB8Oz0b1NKMUJlyKhc+7av5kN0YVbGRlQivHD/1GhSHC+SPcfcyRU7Z5/Hd7qTMqRezY+ZLe46WQcOlTPK5DubpbwMFEDWIoWkql/6rLZ76ju9VurMFLJTaCthcAAJy0mr933aVTeQ7nFqwUDW/XhOd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WkZ1M1wM9z6K63G;
	Thu, 15 Aug 2024 00:47:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D7167140A36;
	Thu, 15 Aug 2024 00:50:51 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 17:50:51 +0100
Date: Wed, 14 Aug 2024 17:50:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Krzysztof Kozlowski <krzk@kernel.org>, Nicolas Ferre
	<nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Lukasz Luba <lukasz.luba@arm.com>, Alim Akhtar <alim.akhtar@samsung.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>, Santosh Shilimkar
	<ssantosh@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
	<linux-samsung-soc@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 5/9] memory: tegra-mc: simplify with scoped for each OF
 child loop
Message-ID: <20240814175049.00001821@Huawei.com>
In-Reply-To: <20240812-cleanup-h-of-node-put-memory-v1-5-5065a8f361d2@linaro.org>
References: <20240812-cleanup-h-of-node-put-memory-v1-0-5065a8f361d2@linaro.org>
	<20240812-cleanup-h-of-node-put-memory-v1-5-5065a8f361d2@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Aug 2024 15:33:59 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Use scoped for_each_child_of_node_scoped() when iterating over device
> nodes to make code a bit simpler.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
The final block is already a weird code structure, but your changes look fine
to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/memory/tegra/mc.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> index 224b488794e5..bd5b58f1fd42 100644
> --- a/drivers/memory/tegra/mc.c
> +++ b/drivers/memory/tegra/mc.c
> @@ -450,7 +450,6 @@ static int load_one_timing(struct tegra_mc *mc,
>  
>  static int load_timings(struct tegra_mc *mc, struct device_node *node)
>  {
> -	struct device_node *child;
>  	struct tegra_mc_timing *timing;
>  	int child_count = of_get_child_count(node);
>  	int i = 0, err;
> @@ -462,14 +461,12 @@ static int load_timings(struct tegra_mc *mc, struct device_node *node)
>  
>  	mc->num_timings = child_count;
>  
> -	for_each_child_of_node(node, child) {
> +	for_each_child_of_node_scoped(node, child) {
>  		timing = &mc->timings[i++];
>  
>  		err = load_one_timing(mc, timing, child);
> -		if (err) {
> -			of_node_put(child);
> +		if (err)
>  			return err;
> -		}
>  	}
>  
>  	return 0;
> @@ -477,7 +474,6 @@ static int load_timings(struct tegra_mc *mc, struct device_node *node)
>  
>  static int tegra_mc_setup_timings(struct tegra_mc *mc)
>  {
> -	struct device_node *node;
>  	u32 ram_code, node_ram_code;
>  	int err;
>  
> @@ -485,14 +481,13 @@ static int tegra_mc_setup_timings(struct tegra_mc *mc)
>  
>  	mc->num_timings = 0;
>  
> -	for_each_child_of_node(mc->dev->of_node, node) {
> +	for_each_child_of_node_scoped(mc->dev->of_node, node) {
>  		err = of_property_read_u32(node, "nvidia,ram-code",
>  					   &node_ram_code);
>  		if (err || (node_ram_code != ram_code))
>  			continue;
>  
>  		err = load_timings(mc, node);
> -		of_node_put(node);
>  		if (err)
>  			return err;
>  		break;
> 


