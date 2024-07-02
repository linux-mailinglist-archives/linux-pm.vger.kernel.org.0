Return-Path: <linux-pm+bounces-10310-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FCCA91EE85
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 07:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C101F229FD
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jul 2024 05:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586543A260;
	Tue,  2 Jul 2024 05:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="4L1OOc1C"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06179CC;
	Tue,  2 Jul 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719899280; cv=none; b=TE1iErGEh+XHSkPq8nk1sV6WkqJXu0sQTfAwab+IRKHCT3KflMtY/pmbaT4im6fRmN66FhV4lCt10ZOq/9CWAzs/zJ8n2yqW/21PLa9EBbzLMpRZFc/n6baunfjBogG7SbRUrf5JAR7cs4OgxiUEQ9NSZHkkj1HCpNZOogPphmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719899280; c=relaxed/simple;
	bh=Bn3wG4lA+xxGiSruiHBol9oYVeiEnMeIGUNym8g/cIo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFv62Vn35yW95sPPIOKESQXALOdC5EueFWiLe4Kio5TP5PWGbnSTKR26B8kAgU2z8Y07hRYYNXkDgfVpAOAalBbh3JQ9pItFTZgU1QSPeHfwvIJxoLWSkkTZfTXpPyVw2ZpHHxuH3eN6eWrG1WBpbLpq0TypN4cHS9kP2+Q4eus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=4L1OOc1C; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719899277;
	bh=Bn3wG4lA+xxGiSruiHBol9oYVeiEnMeIGUNym8g/cIo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=4L1OOc1CMaqgg0QIXjgIFNkXfJ0CecvLU2J0BI6d5vzQBkZQhz0yY2bR9K+YU0sor
	 GOHqzqFBN8NXvkwF3Sz8yft2ORq6G7wDqct3gu0wYmVY4dIE+L3xnuuEC/09vpcrrq
	 SPwsLiB437/77bdi6yDbrI/hFopyJI4vey7asWFl/y3ENpqKVhlY2hQQ73Vnm2P7Z/
	 IGvoEhoSJqsL6GVHjqKsg7mQMDZOqCHJG7OxmcPujOYn4GB+B4Xdb0lNApvmJ3xQpk
	 SOD5S+yyLGZiwY2MAUUuRdeSKuxmV63nRzZF8HmtlI3sWs+trb/wyHuyvk7/hVEg8N
	 PEEFRuxcTIidg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 81F9837811EB;
	Tue,  2 Jul 2024 05:47:56 +0000 (UTC)
Message-ID: <70b31b71-750b-4de0-9102-0852fef7d623@collabora.com>
Date: Tue, 2 Jul 2024 07:47:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: mediatek: Use dev_err_probe in every error path
 in probe
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: kernel@collabora.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240628-mtk-cpufreq-dvfs-fail-init-err-v1-1-19c55db23011@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 28/06/24 21:48, Nícolas F. R. A. Prado ha scritto:
> Use the dev_err_probe() helper to log the errors on every error path in
> the probe function and its sub-functions. This includes
> * adding error messages where there was none
> * converting over dev_err/dev_warn
> * removing the top-level error message after mtk_cpu_dvfs_info_init() is
>    called, since every error path inside that function already logs the
>    error reason. This gets rid of the misleading error message when probe
>    is deferred:
> 
>      mtk-cpufreq mtk-cpufreq: failed to initialize dvfs info for cpu0
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 66 ++++++++++++++++++--------------------
>   1 file changed, 31 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 518606adf14e..b21425bb83be 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c

..snip..

> @@ -487,7 +488,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>   	rate = clk_get_rate(info->inter_clk);
>   	opp = dev_pm_opp_find_freq_ceil(cpu_dev, &rate);
>   	if (IS_ERR(opp)) {
> -		dev_err(cpu_dev, "cpu%d: failed to get intermediate opp\n", cpu);
> +		dev_err_probe(cpu_dev, ret, "cpu%d: failed to get intermediate opp\n", cpu);
>   		ret = PTR_ERR(opp);

I believe you want to first assign ret, and then use it in dev_err_probe() :-P

Please fix. After which:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Cheers!

>   		goto out_disable_inter_clock;
>   	}
> @@ -501,7 +502,7 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>   	info->opp_nb.notifier_call = mtk_cpufreq_opp_notifier;
>   	ret = dev_pm_opp_register_notifier(cpu_dev, &info->opp_nb);
>   	if (ret) {
> -		dev_err(cpu_dev, "cpu%d: failed to register opp notifier\n", cpu);
> +		dev_err_probe(cpu_dev, ret, "cpu%d: failed to register opp notifier\n", cpu);
>   		goto out_disable_inter_clock;
>   	}
>   
> @@ -629,11 +630,9 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>   	int cpu, ret;
>   
>   	data = dev_get_platdata(&pdev->dev);
> -	if (!data) {
> -		dev_err(&pdev->dev,
> -			"failed to get mtk cpufreq platform data\n");
> -		return -ENODEV;
> -	}
> +	if (!data)
> +		return dev_err_probe(&pdev->dev, -ENODEV,
> +				     "failed to get mtk cpufreq platform data\n");
>   
>   	for_each_possible_cpu(cpu) {
>   		info = mtk_cpu_dvfs_info_lookup(cpu);
> @@ -643,24 +642,21 @@ static int mtk_cpufreq_probe(struct platform_device *pdev)
>   		info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
>   		if (!info) {
>   			ret = -ENOMEM;
> +			dev_err_probe(&pdev->dev, ret, "Failed to allocate dvfs_info\n");
>   			goto release_dvfs_info_list;
>   		}
>   
>   		info->soc_data = data;
>   		ret = mtk_cpu_dvfs_info_init(info, cpu);
> -		if (ret) {
> -			dev_err(&pdev->dev,
> -				"failed to initialize dvfs info for cpu%d\n",
> -				cpu);
> +		if (ret)
>   			goto release_dvfs_info_list;
> -		}
>   
>   		list_add(&info->list_head, &dvfs_info_list);
>   	}
>   
>   	ret = cpufreq_register_driver(&mtk_cpufreq_driver);
>   	if (ret) {
> -		dev_err(&pdev->dev, "failed to register mtk cpufreq driver\n");
> +		dev_err_probe(&pdev->dev, ret, "failed to register mtk cpufreq driver\n");
>   		goto release_dvfs_info_list;
>   	}
>   
> 
> ---
> base-commit: 0fc4bfab2cd45f9acb86c4f04b5191e114e901ed
> change-id: 20240627-mtk-cpufreq-dvfs-fail-init-err-0a662ca72de2
> 
> Best regards,



