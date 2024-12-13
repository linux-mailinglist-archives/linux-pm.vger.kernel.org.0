Return-Path: <linux-pm+bounces-19212-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7524E9F1566
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 20:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3597F284753
	for <lists+linux-pm@lfdr.de>; Fri, 13 Dec 2024 19:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E976918E054;
	Fri, 13 Dec 2024 19:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="plfdKrd5"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6026D13EFE3;
	Fri, 13 Dec 2024 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734116535; cv=none; b=S7wVyLwpA4oohe42FHGoMG3X72ipyfyXm9UuRekk0G21UDxoqMxgwi+Y8X3bgeC77GEyZ/0evUC6spJuuboLIzQdeD9VA9pb1d+lInR21w1ZD8Ceg1j02jZJaKpSRrSm6MS2utJpr9jxGfLnPz7nx+ubahaLtW0/lRDNYbmrTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734116535; c=relaxed/simple;
	bh=lLhbmt5vXh5RoFcmVposeOIz63KPHh6DSFcAlP00RBY=;
	h=Message-ID:Date:MIME-Version:Subject:References:From:To:Cc:
	 In-Reply-To:Content-Type; b=DfvcsoHeKLV5TY6TIms9ZhVVOGs/lXhN73ajcTp5kCfz/uNWVyNE8Fl22pZ6KiTH0/1Z2fBXPkIkMLobBd4HvpJXnBuTuH/FNBd6sMZ/B+wL2TAjIBggLvNvbu3Lx+2TWwV8I8LLOTDGCFNwvQ/r0FN+YFjs56Aq/R3ZBgDiypc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=plfdKrd5; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id MAvLtTguSjBR6MAvLtk7X6; Fri, 13 Dec 2024 20:02:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1734116526;
	bh=ta5vayNAQT1oijBjzQ9yIRe6BsxfdXYh4XTwMVpwURI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=plfdKrd5v5EFz6BgXrzGP47+tZ7bUz6SkRfCI67s5XdiAH9+5Chh3rW5d21wCMYQJ
	 N7wD2VLGmmDqZ7VkVIs4WQxVupupG/UOERTZJ8Z5iG8G7VTEO0uSbN1OO8x5g2rONJ
	 SgcfAv+d00uHKX0xZOIMbWIo7FBhraOjZOxFAXwR+b3Id3CnQetXxngrFK5WmPngwe
	 6pHb0X7/G4CtHNMSs/55Z4qGu/8IPe3SaBESwpLwyhRiFQQPBqhuux22jZ3YwFoy7x
	 gB5q6MecbU3IDgvkpGl5+iPPzXVxJNx1CQeWfSzNUMQCrE3dKhYsf9DgCT0jREZ94u
	 L8NuUC84TZUVg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Fri, 13 Dec 2024 20:02:06 +0100
X-ME-IP: 90.11.132.44
Message-ID: <f7f8f087-f3bb-4dbc-b95d-6a6edd6bf64c@wanadoo.fr>
Date: Fri, 13 Dec 2024 20:02:02 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/7] thermal/drivers/tsens: Add TSENS enable and
 calibration support for V2
References: <20241125050728.3699241-1-quic_mmanikan@quicinc.com>
 <20241125050728.3699241-4-quic_mmanikan@quicinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
Cc: quic_srichara@quicinc.com, quic_varada@quicinc.com,
 srinivas.kandagatla@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, amitk@kernel.org, thara.gopinath@gmail.com,
 rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, andersson@kernel.org, konradybcio@kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
In-Reply-To: <20241125050728.3699241-4-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 25/11/2024 à 06:07, Manikanta Mylavarapu a écrit :
> From: Praveenkumar I <quic_ipkumar-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org>
> 
> SoCs without RPM need to enable sensors and calibrate them from the kernel.
> The IPQ5332 and IPQ5424 use the tsens v2.3.3 IP and do not have RPM.
> Therefore, add a new calibration function for V2, as the tsens.c calib
> function only supports V1. Also add new feature_config, ops and data for
> IPQ5332, IPQ5424.
> 
> Although the TSENS IP supports 16 sensors, not all are used. The hw_id
> is used to enable the relevant sensors.

...

> diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
> index 0cb7301eca6e..836155fa9ab2 100644
> --- a/drivers/thermal/qcom/tsens-v2.c
> +++ b/drivers/thermal/qcom/tsens-v2.c
> @@ -4,13 +4,32 @@
>    * Copyright (c) 2018, Linaro Limited
>    */
>   
> +#include <linux/bitfield.h>
>   #include <linux/bitops.h>
>   #include <linux/regmap.h>
> +#include <linux/nvmem-consumer.h>

If moved one line above, alphabetical order would be kept.

>   #include "tsens.h"
>   
>   /* ----- SROT ------ */
>   #define SROT_HW_VER_OFF	0x0000

...

> +static const struct tsens_ops ops_ipq5332 = {
> +	.init		= init_tsens_v2_no_rpm,
> +	.get_temp	= get_temp_tsens_valid,
> +	.calibrate	= tsens_v2_calibration,
> +};
> +
> +struct tsens_plat_data data_ipq5332 = {

This could easily be made as const.

> +	.num_sensors	= 5,
> +	.ops		= &ops_ipq5332,
> +	.hw_ids		= (unsigned int []){11, 12, 13, 14, 15},
> +	.feat		= &ipq5332_feat,
> +	.fields		= tsens_v2_regfields,
> +};
> +
> +struct tsens_plat_data data_ipq5424 = {

This could easily be made as const.

> +	.num_sensors	= 7,
> +	.ops		= &ops_ipq5332,
> +	.hw_ids		= (unsigned int []){9, 10, 11, 12, 13, 14, 15},
> +	.feat		= &ipq5332_feat,
> +	.fields		= tsens_v2_regfields,
> +};

...

CJ

