Return-Path: <linux-pm+bounces-9927-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD43915EC7
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 08:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1484F282610
	for <lists+linux-pm@lfdr.de>; Tue, 25 Jun 2024 06:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172A713B2A5;
	Tue, 25 Jun 2024 06:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="AWoQjufD"
X-Original-To: linux-pm@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0876F145FE1;
	Tue, 25 Jun 2024 06:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719296368; cv=none; b=JZHY7+fA5/fD6R4J3/ARw04jTBp+NWWror/LC9pnTuMeDb7T8M68cvfYgwZHxr2Mjihu6oH2CN/nfi6jc1zrhL7gxpF4YCfz5Xb923OXzuGteby/iDYXS7PlxzDO9aETPOBFe72FwS4sUrnUqVCFfvFE+7lsE7ytMUea0Jsu1c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719296368; c=relaxed/simple;
	bh=EN/Kl52uPTOwTqtRqpZ4IO9jM1Vjjhms6ItkNCF6IxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RGf9NlMHdYb/Sr+zxUfXjs3opVsReUxERsMeXcW3QgM/IY4pzMoAwb/UtUIq71TSjdyYItpRDIDw1vRn+MUP7O1EQy8yNzlvI4XDLHrPsHkOVIaOx5XrwOPqg74EgbwPDmTYNXXzSjao1Efcaoywoa1Fpe3T5DM0Fhl0FYTLz4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=AWoQjufD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45P65KcM017611;
	Tue, 25 Jun 2024 08:18:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	bFN0URSqTU+fG3mqAp5y9Iy1xpvvUu5x6itkRCIjl+o=; b=AWoQjufDebP4pUOY
	3+j6W6pwzw1e+PfBUvYK9pp3uT0Z/Rf/C9h8ufbltLvjo2OtE3CnOa8vPDe0m4Yk
	DH1FDROMgAlVC5K6InFmtY7ugiHgkHXK+al4bC6m7g0y9vKrZO1YuXV3yeGVpEop
	W2KAVxRE0bKWQHRIOSfM1A51BQ6UM+GhVtvVJT8ryhVdGvOKlg5SbrSj8+0Nm8QR
	nE059lnorab/QB3JVATI21NsckcwTDKxUvjfSx/kRvfz1x+yiXic6wz+g3yNB4u9
	Z6CIQdK3wMzGVb3IST8t76bdD1BxUmbIXMZxB8WGmWW5m1581BTmaeq3LHZgMnmE
	h3PN8A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ywnxxa0gb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Jun 2024 08:18:47 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4FF9D4002D;
	Tue, 25 Jun 2024 08:18:42 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 97B9521074D;
	Tue, 25 Jun 2024 08:17:43 +0200 (CEST)
Received: from [10.48.87.62] (10.48.87.62) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 25 Jun
 2024 08:17:40 +0200
Message-ID: <e5c0719a-d49f-4470-964a-c72973c975e7@foss.st.com>
Date: Tue, 25 Jun 2024 08:17:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] thermal: st: switch from CONFIG_PM_SLEEP guards to
 pm_sleep_ptr()
To: Raphael Gallais-Pou <rgallaispou@gmail.com>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
References: <20240518-thermal-v1-0-7dfca3ed454b@gmail.com>
 <20240518-thermal-v1-1-7dfca3ed454b@gmail.com>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <20240518-thermal-v1-1-7dfca3ed454b@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_02,2024-06-24_01,2024-05-17_01



On 5/18/24 14:12, Raphael Gallais-Pou wrote:
> Letting the compiler remove these functions when the kernel is built
> without CONFIG_PM_SLEEP support is simpler and less error prone than the
> use of #ifdef based kernel configuration guards.
> 
> Remove those guards on every ST thermal related drivers.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> ---
>  drivers/thermal/st/st_thermal.c        | 4 +---
>  drivers/thermal/st/st_thermal_memmap.c | 2 +-
>  drivers/thermal/st/stm_thermal.c       | 8 +++-----
>  3 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/thermal/st/st_thermal.c b/drivers/thermal/st/st_thermal.c
> index 2a105409864e..5f33543a3a54 100644
> --- a/drivers/thermal/st/st_thermal.c
> +++ b/drivers/thermal/st/st_thermal.c
> @@ -236,7 +236,6 @@ void st_thermal_unregister(struct platform_device *pdev)
>  }
>  EXPORT_SYMBOL_GPL(st_thermal_unregister);
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int st_thermal_suspend(struct device *dev)
>  {
>  	struct st_thermal_sensor *sensor = dev_get_drvdata(dev);
> @@ -265,9 +264,8 @@ static int st_thermal_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
> -SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
> +DEFINE_SIMPLE_DEV_PM_OPS(st_thermal_pm_ops, st_thermal_suspend, st_thermal_resume);
>  EXPORT_SYMBOL_GPL(st_thermal_pm_ops);
>  
>  MODULE_AUTHOR("STMicroelectronics (R&D) Limited <ajitpal.singh@st.com>");
> diff --git a/drivers/thermal/st/st_thermal_memmap.c b/drivers/thermal/st/st_thermal_memmap.c
> index 29c2269b0fb3..28b380013956 100644
> --- a/drivers/thermal/st/st_thermal_memmap.c
> +++ b/drivers/thermal/st/st_thermal_memmap.c
> @@ -180,7 +180,7 @@ static void st_mmap_remove(struct platform_device *pdev)
>  static struct platform_driver st_mmap_thermal_driver = {
>  	.driver = {
>  		.name	= "st_thermal_mmap",
> -		.pm     = &st_thermal_pm_ops,
> +		.pm     = pm_sleep_ptr(&st_thermal_pm_ops),
>  		.of_match_table = st_mmap_thermal_of_match,
>  	},
>  	.probe		= st_mmap_probe,
> diff --git a/drivers/thermal/st/stm_thermal.c b/drivers/thermal/st/stm_thermal.c
> index 34785b9276fc..ffd988600ed6 100644
> --- a/drivers/thermal/st/stm_thermal.c
> +++ b/drivers/thermal/st/stm_thermal.c
> @@ -440,7 +440,6 @@ static int stm_thermal_prepare(struct stm_thermal_sensor *sensor)
>  	return ret;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
>  static int stm_thermal_suspend(struct device *dev)
>  {
>  	struct stm_thermal_sensor *sensor = dev_get_drvdata(dev);
> @@ -466,10 +465,9 @@ static int stm_thermal_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif /* CONFIG_PM_SLEEP */
>  
> -static SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
> -			 stm_thermal_suspend, stm_thermal_resume);
> +static DEFINE_SIMPLE_DEV_PM_OPS(stm_thermal_pm_ops,
> +				stm_thermal_suspend, stm_thermal_resume);
>  
>  static const struct thermal_zone_device_ops stm_tz_ops = {
>  	.get_temp	= stm_thermal_get_temp,
> @@ -580,7 +578,7 @@ static void stm_thermal_remove(struct platform_device *pdev)
>  static struct platform_driver stm_thermal_driver = {
>  	.driver = {
>  		.name	= "stm_thermal",
> -		.pm     = &stm_thermal_pm_ops,
> +		.pm     = pm_sleep_ptr(&stm_thermal_pm_ops),
>  		.of_match_table = stm_thermal_of_match,
>  	},
>  	.probe		= stm_thermal_probe,
> 
Hi Raphael

Reviewed-by: Patrice Chotard <patrice.chotard@foss.st.com>

Thanks
Patrice

