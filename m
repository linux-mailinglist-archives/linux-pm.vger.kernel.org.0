Return-Path: <linux-pm+bounces-27804-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54AAC7BCF
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 12:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77D491C023E5
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38B4258CCE;
	Thu, 29 May 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LNJeyZPm"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D64227E80
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 10:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748514872; cv=none; b=pHI5Bfru46Jwo9ksLVN2ZOdSJ2a+YTTttIzHbgUY2oOaW+zXNKXxIrun37lZCpexkHc8OAQ2hs0mjZy7CRMKjco7anFvXhq+yNG0VzuryQ9+H+gycJfkgpidqdPCGoRqH39hMorPzTHmFJUZNk0whvVMqkUmiQBj96ti5NMfOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748514872; c=relaxed/simple;
	bh=OLn0yjcyfm3UkHNoQjh9sE/IUKOkrxifgngY5zpEWGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DyL7jEJ9lwYxNL3RFjMNs+4iN7tMuibvkwwRS7l9VVGVItWNDYhw4C0iv+HFEWhdQTbHzgou1GCyVLpUFdcWc++b7YDHhQtajBk78yW34IjBaPiiR8SlKvIhfY+PWNg60VJNU77tmzCJBvQv9v4WDYElXXREe8QCGvwf28SMmRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LNJeyZPm; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4ef2c2ef3so449754f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 03:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748514869; x=1749119669; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7XnyQzNX/drKQR10T94L+svKrfDQz7i/jR99c0lhmI=;
        b=LNJeyZPm1K/iLajVr5KmTdUHgV+UcxBw5bINJY5W0ehco53C8wkQxWL4SPMMplkJST
         piww+DS9fHtON7PJm5aH5ZHNtJBVsEMPD6JrINtbaNILQBlMX01VNnJSrHeGdsZDrugJ
         DJpkdpyC9x7Ms2X1PMzAiCJaLimsU1F+m9pmhIW01IYhWj8dtsaA3SSBd8T+uusKu9L3
         BN/vbTeel/s0QCfnN5V8EA2HRsE3U/Qx0REtugwVA5loWqnSvquSs3qRE8oUNUfwOppC
         4yB/eLP9Y/bSa048KO4bkYDFuQ9H9yFgI5OXmbU1M2+VxiQMTZRJ/6BOb7Cb6ZuqCL6t
         4Cug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748514869; x=1749119669;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7XnyQzNX/drKQR10T94L+svKrfDQz7i/jR99c0lhmI=;
        b=u+jiRsZQL1gMEIihy8MmNxe/XnP2VsRVt9JFsdkDhhBpCwdsOXv6z8XMbYSVRHYO/L
         2+N+l0aFvZIJ76EcV4NERNEvdUJqlohyzOspvRRrH6UZDGBbcQcgAj4hMjycQVCIAkSt
         GYsZSwytpZcziMA0PcJewrgI/b2XAGoqAzD4PsbVrrA0HvnZ6h1LIxyacAEvEbGi4P5U
         YMYHCA9LqxxB68kB8NZYIcHhxwtZBWZwkGMdZQMQniCSRk+ou+6ywPTV5E4k+hDvdIin
         KH6qlY+fCdPirsvXDOJKvu28595LxObA/RjgEehQvDIlhS/8rpQtOQjCMAn5XIE35v0B
         3Ezg==
X-Forwarded-Encrypted: i=1; AJvYcCUhW4b7KDtXuTkSxdfeMZS+S5S1UubvXH63YWvZwmyr9r64R5wcomW7plliv3Q2nVrWmQzDHoWmTA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+IV9sc38b4aX49EAbJWC38zMP3i7KAoWnReWbo91XEOwQnYBT
	5jEWUuDrLemQ9mW4jdQnY9RQHsql6r0DVQ0MgJ3VqO79RsNrlVcydzCCFXwBIQ0pAoc=
X-Gm-Gg: ASbGnctsztFTKOL06+YzWFowOkyrY3NZkwaVWkg5lDW2A7XSrjhf6C5GLAWEALG0FtF
	w+E/LAztPq5/zTq1I6JZ4zKl8jnKfKoRxe2CW7OhWN1Y3qsLShvyk391FpvqZ/h9A6ehiw4THMM
	BYkl5rgIAfEqmg8ft0KMPnOzRSdhBRFAE/ajy+bPC21rX6piBKBMibUguFOfrbE3xUCDCBvxWyZ
	xn1GjD0Yb+wskepopmC+qA8EToR7qH7B9leTWoaL+g3BmCmCe8evBksd/1HDmWSNZea1/USLdtj
	zeQDt9L1DmEa/QG4LmUekvqpT7yJw2+Acuj9dCkkjUb6z3ZyAvJ3Vk7DqaTrICuzp2YL0OFhKGZ
	TxoInFxJFNeMN6XvKcffbGpFYsw0=
X-Google-Smtp-Source: AGHT+IFJ+vCc0Saq1NPdw5Cj12pfvhYMrQ1F1BPZvlG/AECXTZSodeN9++HB8oVZB4vb/Avl2dr7XQ==
X-Received: by 2002:a05:6000:288b:b0:3a4:e65d:b6d5 with SMTP id ffacd0b85a97d-3a4e65db6demr6935306f8f.1.1748514869111;
        Thu, 29 May 2025 03:34:29 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc03147sm16037435e9.14.2025.05.29.03.34.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 03:34:28 -0700 (PDT)
Message-ID: <895a0004-04df-4b7e-9855-bc0033ca650b@linaro.org>
Date: Thu, 29 May 2025 11:34:27 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] thermal: qcom-spmi-temp-alarm: enable stage 2
 shutdown when required
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
 amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
 srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
 quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
 <0nJRx6-RgYybx3jhgUDcxC9hIxr02feRJuYYgLa6lpO3DOSuQidQkRKKoqvQoV0x26UVeiV6G5XN8cMTZ9Ol5g==@protonmail.internalid>
 <20250528235026.4171109-2-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250528235026.4171109-2-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2025 00:50, Anjelique Melendez wrote:
> From: David Collins <david.collins@oss.qualcomm.com>
> 
> Certain TEMP_ALARM GEN2 PMIC peripherals need over-temperature
> stage 2 automatic PMIC partial shutdown to be enabled in order to

stage 2 should be hyphenated to stage-2

> avoid repeated faults in the event of reaching over-temperature
> stage 3.  Modify the stage 2 shutdown control logic to ensure that
> stage 2 shutdown is enabled on all affected PMICs.  Read the
> digital major and minor revision registers to identify these
> PMICs.
> 
> Signed-off-by: David Collins <david.collins@oss.qualcomm.com>
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 32 +++++++++++++++++++--
>   1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index a81e7d6e865f..47248a843591 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.

Should have the year in it.

grep -r Copyright * | grep Qualcomm

>    */
> 
>   #include <linux/bitops.h>
> @@ -16,6 +17,7 @@
> 
>   #include "../thermal_hwmon.h"
> 
> +#define QPNP_TM_REG_DIG_MINOR		0x00
>   #define QPNP_TM_REG_DIG_MAJOR		0x01
>   #define QPNP_TM_REG_TYPE		0x04
>   #define QPNP_TM_REG_SUBTYPE		0x05
> @@ -78,6 +80,7 @@ struct qpnp_tm_chip {
>   	/* protects .thresh, .stage and chip registers */
>   	struct mutex			lock;
>   	bool				initialized;
> +	bool				require_s2_shutdown;
> 
>   	struct iio_channel		*adc;
>   	const long			(*temp_map)[THRESH_COUNT][STAGE_COUNT];
> @@ -255,7 +258,7 @@ static int qpnp_tm_update_critical_trip_temp(struct qpnp_tm_chip *chip,
> 
>   skip:
>   	reg |= chip->thresh;
> -	if (disable_s2_shutdown)
> +	if (disable_s2_shutdown && !chip->require_s2_shutdown)
>   		reg |= SHUTDOWN_CTRL1_OVERRIDE_S2;
> 
>   	return qpnp_tm_write(chip, QPNP_TM_REG_SHUTDOWN_CTRL1, reg);
> @@ -350,8 +353,8 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   {
>   	struct qpnp_tm_chip *chip;
>   	struct device_node *node;
> -	u8 type, subtype, dig_major;
> -	u32 res;
> +	u8 type, subtype, dig_major, dig_minor;
> +	u32 res, dig_revision;
>   	int ret, irq;
> 
>   	node = pdev->dev.of_node;
> @@ -402,6 +405,12 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   		return dev_err_probe(&pdev->dev, ret,
>   				     "could not read dig_major\n");
> 
> +	ret = qpnp_tm_read(chip, QPNP_TM_REG_DIG_MINOR, &dig_minor);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "could not read dig_minor\n");
> +		return ret;
> +	}
> +
>   	if (type != QPNP_TM_TYPE || (subtype != QPNP_TM_SUBTYPE_GEN1
>   				     && subtype != QPNP_TM_SUBTYPE_GEN2)) {
>   		dev_err(&pdev->dev, "invalid type 0x%02x or subtype 0x%02x\n",
> @@ -415,6 +424,23 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>   	else
>   		chip->temp_map = &temp_map_gen1;
> 
> +	if (chip->subtype == QPNP_TM_SUBTYPE_GEN2) {
> +		dig_revision = (dig_major << 8) | dig_minor;
> +		/*
> +		 * Check if stage 2 automatic partial shutdown must remain
> +		 * enabled to avoid potential repeated faults upon reaching
> +		 * over-temperature stage 3.
> +		 */
> +		switch (dig_revision) {
> +		case 0x0001:
> +		case 0x0002:
> +		case 0x0100:
> +		case 0x0101:
> +			chip->require_s2_shutdown = true;
> +			break;
> +		}
> +	}
> +
>   	/*
>   	 * Register the sensor before initializing the hardware to be able to
>   	 * read the trip points. get_temp() returns the default temperature
> --
> 2.34.1
> 
> 
---
bod

