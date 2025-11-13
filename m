Return-Path: <linux-pm+bounces-37932-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 901B9C56B06
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 10:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DBB2634C7F1
	for <lists+linux-pm@lfdr.de>; Thu, 13 Nov 2025 09:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633F2DF3FD;
	Thu, 13 Nov 2025 09:50:13 +0000 (UTC)
X-Original-To: linux-pm@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518F12D73B4;
	Thu, 13 Nov 2025 09:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763027413; cv=none; b=fJkMgiAt3qC/pschuMaXaVeOZWLbBQPgAfREIoFn49S9RWOiu4xaRprRXL9zdaw0S5r8210trehL96LtFIv3syl5YwiwAdshwc3paO8dclQ+QPZcpeV5wFT1tdcgpTrg3YUrhEbDkK/a8KOJR+PVjoYGF9bVRRYus0z0H6TOhBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763027413; c=relaxed/simple;
	bh=vnpgERAXA13Nli6g2gHDQ3S7eRBRkQiSbM9EinmQVd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZmY0hZcYBoS6QcA52A2dDMI6xfdexdzgOXkqyl47MSqV++x1H2Mkc0MoLDSkJLYrYnDnm9odNNZZjjF+EJdVZXKxYw7/YTZk9N6VT9VP2IHA3oEc/sw/DemOh/6ev16yUGQ4FhQRQ7TPCJQdXTXsb9tUPMgV7IKi5Cc4KSk6W1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E89CC12FC;
	Thu, 13 Nov 2025 01:49:57 -0800 (PST)
Received: from [10.57.40.163] (unknown [10.57.40.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E5B913F66E;
	Thu, 13 Nov 2025 01:49:59 -0800 (PST)
Message-ID: <953f1aaa-d8bd-4091-9bf6-9538ccdd3bfa@arm.com>
Date: Thu, 13 Nov 2025 09:50:40 +0000
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] powercap: dtpm: Simplify with
 of_machine_get_match_data()
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Samuel Holland <samuel@sholland.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Saravana Kannan <saravanak@google.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pm@vger.kernel.org,
 Chen-Yu Tsai <wens@kernel.org>, Yangtao Li <tiny.windzz@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-tegra@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Hans de Goede <hansg@kernel.org>
References: <20251112-b4-of-match-matchine-data-v2-0-d46b72003fd6@linaro.org>
 <20251112-b4-of-match-matchine-data-v2-9-d46b72003fd6@linaro.org>
Content-Language: en-US
From: Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20251112-b4-of-match-matchine-data-v2-9-d46b72003fd6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/12/25 10:28, Krzysztof Kozlowski wrote:
> Replace open-coded getting root OF node, matching against it and getting
> the match data with new of_machine_get_match_data() helper.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first OF patch.
> ---
>   drivers/powercap/dtpm.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> index f390665743c4..129d55bc705c 100644
> --- a/drivers/powercap/dtpm.c
> +++ b/drivers/powercap/dtpm.c
> @@ -548,9 +548,7 @@ static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
>    */
>   int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>   {
> -	const struct of_device_id *match;
>   	const struct dtpm_node *hierarchy;
> -	struct device_node *np;
>   	int i, ret;
>   
>   	mutex_lock(&dtpm_lock);
> @@ -567,19 +565,7 @@ int dtpm_create_hierarchy(struct of_device_id *dtpm_match_table)
>   		goto out_pct;
>   	}
>   
> -	ret = -ENODEV;
> -	np = of_find_node_by_path("/");
> -	if (!np)
> -		goto out_err;
> -
> -	match = of_match_node(dtpm_match_table, np);
> -
> -	of_node_put(np);
> -
> -	if (!match)
> -		goto out_err;
> -
> -	hierarchy = match->data;
> +	hierarchy = of_machine_get_match_data(dtpm_match_table);
>   	if (!hierarchy) {
>   		ret = -EFAULT;
>   		goto out_err;
> 

I don't know if Daniel had a chance to look at it, but I can help him.

The patch looks OK.

The extra return error value which is removed doesn't harm the client of
this function in other subsystem.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

