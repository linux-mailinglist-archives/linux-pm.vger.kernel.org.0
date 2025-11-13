Return-Path: <linux-pm+bounces-37933-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 314CBC56B64
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B8CCB347DC0
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE27C2DF3D1;
	Thu, 13 Nov 2025 09:54:35 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E342D7386;
	Thu, 13 Nov 2025 09:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027675; cv=none; b=l051j25Tn3TWmsqLTG12cGYbAda0GnpEVi5J+zzZ0KigyG71mR48SdUKrEmSFcVxEnzA3O71kGWz6kzYBYfxe+5mP/R+kTH3GJcL2OjxDXcFn5wCfNKWY+inEgkenV/aPv+rw/0kHlOuMxAOf+zWwR4t5I2dTPbksPGZF6k4pJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027675; c=relaxed/simple;
	bh=xZvtYftNkPUyNLlddxlQUnwySkgjdxI367joUU/66kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDGw50tHjs/Zg3BfA6WSRttCIndQPlE35nBgcOgw0toI3Ueq4fvoKV8GrtJumhVzV9EiwqsUwO/qlTizyUmxRPDdwv7jrqm3FnFzOsHi8ts4D4vDS/N18KoCjaXnScCfGenq/5CxtLLcPdUaAH7jyI4x7uGPd1V3/C/m4xX8obQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B891A12FC;
	Thu, 13 Nov 2025 01:54:25 -0800 (PST)
Received: from [10.57.40.163] (unknown [10.57.40.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 266A73F5A1;
	Thu, 13 Nov 2025 01:54:28 -0800 (PST)
Message-ID: <d0238361-8953-4f08-8c04-bacaf0465366@arm.com>
Date: Thu, 13 Nov 2025 09:55:09 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] of: Add wrappers to match root node with OF
 device ID tables
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Samuel Holland <samuel@sholland.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Saravana Kannan <saravanak@google.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Hans de Goede
 <hansg@kernel.org>, Maximilian Luz <luzmaximilian@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn Andersson
 <andersson@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>,
 linux-pm@vger.kernel.org, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Chen-Yu Tsai <wens@kernel.org>,
 Yangtao Li <tiny.windzz@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org,
 Konrad Dybcio <konradybcio@kernel.org>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
 <20251112-b4-of-match-matchine-data-v2-1-d46b72003fd6@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-1-d46b72003fd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 11/12/25 10:28, Krzysztof Kozlowski wrote:
> Several drivers duplicate same code for getting reference to the root
> node, matching it against 'struct of_device_id' table and getting out
> the match data from the table entry.
> 
> There is a of_machine_compatible_match() wrapper but it takes array of
> strings, which is not suitable for many drivers since they want the
> driver data associated with each compatible.
> 
> Add two wrappers, similar to existing of_device_get_match_data():
> 1. of_machine_device_match() doing only matching against 'struct
>     of_device_id' and returning bool.
> 2. of_machine_get_match_data() doing the matching and returning
>     associated driver data for found compatible.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> 
> All further patches depend on this.
> ---
>   drivers/of/base.c  | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>   include/linux/of.h | 13 +++++++++++++
>   2 files changed, 60 insertions(+)
> 
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index 7043acd971a0..0b65039ece53 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -434,6 +434,53 @@ bool of_machine_compatible_match(const char *const *compats)
>   }
>   EXPORT_SYMBOL(of_machine_compatible_match);
>   
> +/**
> + * of_machine_device_match - Test root of device tree against a of_device_id array
> + * @matches:	NULL terminated array of of_device_id match structures to search in
> + *
> + * Returns true if the root node has any of the given compatible values in its
> + * compatible property.
> + */
> +bool of_machine_device_match(const struct of_device_id *matches)
> +{
> +	struct device_node *root;
> +	const struct of_device_id *match = NULL;
> +
> +	root = of_find_node_by_path("/");
> +	if (root) {
> +		match = of_match_node(matches, root);
> +		of_node_put(root);
> +	}
> +
> +	return match != NULL;
> +}
> +EXPORT_SYMBOL(of_machine_device_match);
> +
> +/**
> + * of_machine_get_match_data - Tell if root of device tree has a matching of_match structure
> + * @matches:	NULL terminated array of of_device_id match structures to search in
> + *
> + * Returns data associated with matched entry or NULL
> + */
> +const void *of_machine_get_match_data(const struct of_device_id *matches)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *root;
> +
> +	root = of_find_node_by_path("/");
> +	if (!root)
> +		return NULL;
> +
> +	match = of_match_node(matches, root);
> +	of_node_put(root);
> +
> +	if (!match)
> +		return NULL;
> +
> +	return match->data;
> +}
> +EXPORT_SYMBOL(of_machine_get_match_data);
> +
>   static bool __of_device_is_status(const struct device_node *device,
>   				  const char * const*strings)
>   {
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 121a288ca92d..01bb3affcd49 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -407,6 +407,8 @@ extern int of_alias_get_id(const struct device_node *np, const char *stem);
>   extern int of_alias_get_highest_id(const char *stem);
>   
>   bool of_machine_compatible_match(const char *const *compats);
> +bool of_machine_device_match(const struct of_device_id *matches);
> +const void *of_machine_get_match_data(const struct of_device_id *matches);
>   
>   /**
>    * of_machine_is_compatible - Test root of device tree for a given compatible value
> @@ -855,6 +857,17 @@ static inline bool of_machine_compatible_match(const char *const *compats)
>   	return false;
>   }
>   
> +static inline bool of_machine_device_match(const struct of_device_id *matches)
> +{
> +	return false;
> +}
> +
> +static inline const void *
> +of_machine_get_match_data(const struct of_device_id *matches)
> +{
> +	return NULL;
> +}
> +
>   static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
>   {
>   	return false;
> 

Makes sense based on the clean-up in dtpm.c (since I've been there
I looked here as well).

LGTM

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz

