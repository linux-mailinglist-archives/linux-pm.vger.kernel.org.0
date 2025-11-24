Return-Path: <linux-pm+bounces-38491-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4489EC81FD4
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 18:56:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCCB3342AA2
	for <lists+linux-pm@lfdr.de>; Mon, 24 Nov 2025 17:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB1C2C21DD;
	Mon, 24 Nov 2025 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UIl/Lh93"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6BA2C15B5
	for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 17:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764006995; cv=none; b=LIBNgM3LXXSiFQAQGJCrJjvPt1ATWFk8RNT/Wy9sQ9QTKsEaB7wYBCmLBIYgEE4OvV5M6aBS/HzdGlX0iuGNceP3KhjJaDuGqUL6eVyFxYwAKScovnXFdDhCB9Ei6+ZOqaSyY25pQnA6wZfWxwJdLNB4fpL6Bd4wW+bS+yAJq4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764006995; c=relaxed/simple;
	bh=dPLZPXzQgDRDqQnurUjDg3r6SH40YxJqrAijPmz7Kww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j8AKw0N2MPRuADgxHwGHlUh3wy6SxGDT8W9492Kcf2yzn9rc2mAA97GSoqSitKrWDUfb9bnuFB83YKh+Q6DzkaHuvSoRB+7ewRmbuiIXXy+MVMdBBgxC4WFGEkXId2L2Tnfo9YXrT9xXe+FXEEaCWKpyPr0EEKnEII2TQTgByOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UIl/Lh93; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so48258515e9.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Nov 2025 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764006991; x=1764611791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dgj16XmQKLfzuMiMJnYwYhnRMSc7HIdJxo40jdxC8fc=;
        b=UIl/Lh934qmWi/fRDKj+vjLLHtpKfarbEWH9a1s9fVxnia8z3TC77ajVrESH/bCyEl
         lSy2W/PzTCwg/SY1DmESxMIAVfqT1a13iwx9ldJLR6KPaxPK5aQKsHUq8UUgArcpYFu5
         gRHW6dX8+8cdkbOhy74a8AsIRufMWc0ES6Px8ryb7FcgB0pD8PVJO8w+v/k/Rjc3av6d
         dCDzW05OQxvYUhTTyvlBwLIMQNGQ9IWqQkyhOZ0UxQyp2cT73cFrzfUrXvv/Fhinv7xj
         nadw1rWzqFHdQOr988iZbGVsrsi5UqJssIJLNEt5+D6GptY8LAQ198BI3w18KJFyiZ/R
         xc7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764006991; x=1764611791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgj16XmQKLfzuMiMJnYwYhnRMSc7HIdJxo40jdxC8fc=;
        b=qXJu1LuRdRDLj2lrWpu3jJabPwMagFG1tOfHpSo0mO7cexjKXIVd692RZcPviqZEEO
         lttoc5hGZSb+9BXAjRPgBjO5OND1z9GZpQU1NueemoHtpTqZF7VqqqaQkngXdWMvrbno
         FQwGUQMdgFXgPru8OVsKbd94y9nfjjTkb836VOUkM6XlCsJWqeIeSPIzib7tEHY7QsBs
         8IaZPcqi+0ccrBbwuPbqDTkEYiHUWYGZ0zlbGdAchXO+ZwiWLWL200A6B2CGdzDvRGK5
         VUtIowAopImUEBriZb+RXG55ZH+2uxhgw4wH8E8J1u/Yn4mo9UlsX98HLQ4MVXxWr4xp
         FNNw==
X-Forwarded-Encrypted: i=1; AJvYcCUBeIm1moJGB5cpwuXowyB6EnnN7LwZ1BFQtLgyHRpdlLTNNvXYqucohFOHMiaHcmYqaZaE/qVOig==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGpnm/dwn7OIrWhWtjSrVfhrnroES/U85XR3h+5ItN4UPAGxRN
	VNYGH19I853NeXGrxwoKw+OrOQ/58cdp0m9dY1FLHbt8miisAsF7rriRKt6iUi2nDjE=
X-Gm-Gg: ASbGncvn0XtpNqS38iMP9hRXxOFUH8YM3E1l1GemQjdEYnrSak2fkDIpxQy1RN9yz3z
	+eeto1OanSeSdrUMZSXA6AW29jmEn+5t30JNhdpvDxL7J2lapisetar6thDfYL/+wia3frSdgKD
	IDZqaeUw4tIakPcM8XQe39rE32eo0oyxR4jnJ7MCsl1vCpOfRGdA33iy3xewft8pwRpG0fFTZxb
	bar9PIyJnbYt+K3UKC9jyQSHdBYnGhO74HPuY7IzIJPF001ebrfCtiFWJyfKKou+IxKvhl6meqR
	RbioLvvw8+y+gsfu5L2+eXPaL77vQf8X5v30jBgAXy/QMws2T/h6a2RS5yiuMEdcuX/8s3ztLgc
	Pbmw75V6X/HWLs/o3zDfGAsfpkM4VgSA/rQgCPsIadvtsNLJoH/QGJWcmpDECFrGR0jF99o8/vU
	cEBF4PqUEwMAZxyOKnMnMHslwlCH754LWROCCGEgqaVmqJcLguzD/o0D7cRyVYwOuEyXIsBp/QK
	Hzw
X-Google-Smtp-Source: AGHT+IF9jQYjGDYWRD+2xNGzxOUo7frTRxo+/YiP6cBgQWSgQQXQD/fGaLUkrkLZhoAvTfv/zaiUjQ==
X-Received: by 2002:a05:600c:1f94:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-477c016bbd5mr123402035e9.7.1764006991417;
        Mon, 24 Nov 2025 09:56:31 -0800 (PST)
Received: from ?IPV6:2a05:6e02:1041:c10:a756:bb6c:7b35:af9b? ([2a05:6e02:1041:c10:a756:bb6c:7b35:af9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-477bf198a67sm217894095e9.0.2025.11.24.09.56.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Nov 2025 09:56:30 -0800 (PST)
Message-ID: <190003b6-2931-406a-a8f6-ec8909c65162@linaro.org>
Date: Mon, 24 Nov 2025 18:56:29 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] thermal/drivers/mediatek/lvts: Fail probe if
 temp_factor is zero
To: Laura Nao <laura.nao@collabora.com>, srini@kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, rafael@kernel.org,
 rui.zhang@intel.com, lukasz.luba@arm.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com
Cc: nfraprado@collabora.com, arnd@arndb.de, colin.i.king@gmail.com,
 u.kleine-koenig@baylibre.com, andrew-ct.chen@mediatek.com,
 lala.lin@mediatek.com, bchihi@baylibre.com, frank-w@public-files.de,
 wenst@chromium.org, fshao@chromium.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 kernel@collabora.com
References: <20251121-mt8196-lvts-v4-v4-0-357f955a3176@collabora.com>
 <20251121-mt8196-lvts-v4-v4-3-357f955a3176@collabora.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20251121-mt8196-lvts-v4-v4-3-357f955a3176@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/21/25 12:16, Laura Nao wrote:
> temp_factor is used in lvts_temp_to_raw() and lvts_raw_to_temp(). If
> platform data is incorrect and temp_factor is zero, it could cause a
> division by zero. Fail the probe early to prevent a kernel crash.
> 
> Signed-off-by: Laura Nao <laura.nao@collabora.com>
> ---
>   drivers/thermal/mediatek/lvts_thermal.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1c54d0b75b1a..b49441d82ffd 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -1346,6 +1346,11 @@ static int lvts_probe(struct platform_device *pdev)
>   	if (irq < 0)
>   		return irq;
>   
> +	if (!lvts_data->temp_factor)
> +		return dev_err_probe(
> +			dev, -EINVAL,
> +			"temp_factor should never be zero; check platform data.\n");
> +

 From my POV, this is not really useful. The temp_factor is set for each 
version statically in the code. The scope is limited to the driver, IOW 
it is not a parameter other subsystems passes to the driver.

If it is NULL, then shame on the submitter who did not test the driver 
before sending ;)



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

