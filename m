Return-Path: <linux-pm+bounces-26634-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5AAA8EA6
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 10:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A73C93ABE7E
	for <lists+linux-pm@lfdr.de>; Mon,  5 May 2025 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69661F473C;
	Mon,  5 May 2025 08:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IKH0kldk"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B251F1921
	for <linux-pm@vger.kernel.org>; Mon,  5 May 2025 08:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435403; cv=none; b=FTZx2V6EWBSoNtJIsOzU6Mcctf2z69DKAj27qboUQq3WJqLAUavJRhvzt6VRj6o32/TVm8TYDSbEkMl+uIh34V0QXTcBK+LEBBckf13P0am1HEPQX+14+eYXWJ05Tx95Rzf4iXyJ3lc7h6mzbtxffwkhwFtm2ULQL+7eLjX+Fyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435403; c=relaxed/simple;
	bh=SmMCH697xC8Jvds5eQIi5w8fCsVUUCW9mlghMxxm3kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BD+I+GV0SVb5I+Z5XSmxKdI71KnP4peHCxsDlwbf1UI/w0rdujMSeppnFEZ8ciKC37EeIpnciEDIBhk11MNcmXTPUsZs8CnVACPzMEb75RJUeBmongBPeL0S4CZxOFnAspuBTrmAkElMn7gIq5/q1prgBROKJ7fTXn29ytNm1aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IKH0kldk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39ac9aea656so4479594f8f.3
        for <linux-pm@vger.kernel.org>; Mon, 05 May 2025 01:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1746435398; x=1747040198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sv1fXA/kXVQWR1mgUjAfLmrac7SzbmHKcHFUSyKNyaM=;
        b=IKH0kldkiw8v07nDcr/TjCCgcz7Xu2sbfPrRhwzumT91UcwMsJNgwHnIA/TUICMucP
         BehgQou9jvh5B/77GNKxVO7vP4tOvK/FRIxiTnKPAT3Zn+Ux0e7zJUllNja6PqDmx+kz
         RjllalaoMWwzmOg3p3mVMDablpM1X1mlPxIM7tg5N6zgdj26Hqd3SIElyxERgiJBAnCJ
         GltrGw31BUmiXXLWqQMM3Uk3t+yCcIp1FkxfCAiiaAO9hmvTCsVnz3P6+p0hnpr3tfIC
         83jhyqct2oBRBpWXoJH8FszqfZcQCMbjIj3t6/vQpSQ/9GBjaDilyidcEp701FT+71yx
         fgMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746435398; x=1747040198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sv1fXA/kXVQWR1mgUjAfLmrac7SzbmHKcHFUSyKNyaM=;
        b=V6VylEciLYWC98dZy907+kCWXGFKoGTfW5G9u2uaDoj3jkWx4UiBRpH9R5DHA4jeWG
         nbcHCSjH4rNeVaoS0LfVtJyheUTzwL7m9IYzGEqRw6HW3sqG425fG/RF6Z+XQxpLzM0a
         OOmbjXqywfP5WDRP+GSrMB50OMZbCtfCwgn3+jg/MnCUGLxBpKSUq4p6MAm+demM2vKj
         gaedFWC+/vQ2t1IXctOcOZfKqDHSmtpTqUcB15poxLowWyf529yIaZYJ2+rxKQRbleuQ
         0EvYZu4Q2ALie4kFKqchbm3ZmGi9VFmRxt/nXfsnQeGietp4MMncXf5Bks6SBgcQ2nWC
         BJ5A==
X-Forwarded-Encrypted: i=1; AJvYcCW1IlWkXS2vj1F5FS7s1HC5z+agwp3SLF1Mwu0cNwAr9XzYxr9EYHtf02Ro/IUULk68OS3F7gFQEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NNtPzmpU05q3d2aHvLV33fTyUBgUENP+p3hqxWxXeIbcS0Ae
	qsYbD1GpcHI0v/BEo/5CtbZJmQmxmfbXBTzz9NNCCWPfvwbl1536v9y5QDXvFr4=
X-Gm-Gg: ASbGncti+tguGn/bjNtWbkpPojtjLdO5EktuCV8lOLpSRyLII1keEkZ1dqW+hP0mmg9
	d8w0Atl6Nt/7zpK6Wzs2Mne/Fo+gO0RCob+5iHA5itZEMAL/hlaVZMk7EURSDv+bP7yvv+EUtYQ
	btPB4awrvKgyk6eFk3eNnyk1OOOxpdqBKCQeBQxyBGN0JqD5/BP9xqr+gCa8iztQC8HN7T2N+o2
	hnfceii3i3fxq1yd/96gSoVIgTYT9b7FC9zAAeLlEjg1Qq8k6sv0QLo/MGdYQ6RPDgD3RuJRXOn
	AZkZSfUCbfyr2YZ22d7ur9wlA+G4lXbfaXej2zzp/mg+pjDPYPAk8mh+xtDBOAxtBzyQWrA57kr
	+Z6E=
X-Google-Smtp-Source: AGHT+IGfImCYDlojSB1Sb4V6Dn940fvmK1LybNwwBa7WbdE2kVT+4CXyDuAT8T7krErERsIUODmGCw==
X-Received: by 2002:a5d:64e8:0:b0:38f:2766:759f with SMTP id ffacd0b85a97d-3a09fdbf30cmr4610206f8f.41.1746435398100;
        Mon, 05 May 2025 01:56:38 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a099b172a8sm9880997f8f.91.2025.05.05.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 01:56:37 -0700 (PDT)
Date: Mon, 5 May 2025 10:56:35 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Jonathan Cameron <jic23@kernel.org>, linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/1] thermal: thermal-generic-adc: add temperature
 sensor channel
Message-ID: <aBh9Q8zr2MtfVJtq@mai.linaro.org>
References: <20250430055807.11805-1-clamor95@gmail.com>
 <20250430055807.11805-2-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250430055807.11805-2-clamor95@gmail.com>

On Wed, Apr 30, 2025 at 08:58:07AM +0300, Svyatoslav Ryhel wrote:
> To avoid duplicating sensor functionality and conversion tables, this
> design allows converting an ADC IIO channel's output directly into a
> temperature IIO channel. This is particularly useful for devices where
> hwmon isn't suitable or where temperature data must be accessible through
> IIO.
> 
> One such device is, for example, the MAX17040 fuel gauge.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/thermal/thermal-generic-adc.c | 55 ++++++++++++++++++++++++++-
>  1 file changed, 54 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
> index ee3d0aa31406..7c844589b153 100644
> --- a/drivers/thermal/thermal-generic-adc.c
> +++ b/drivers/thermal/thermal-generic-adc.c
> @@ -7,6 +7,7 @@
>   * Author: Laxman Dewangan <ldewangan@nvidia.com>
>   */
>  #include <linux/iio/consumer.h>
> +#include <linux/iio/iio.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> @@ -73,6 +74,58 @@ static const struct thermal_zone_device_ops gadc_thermal_ops = {
>  	.get_temp = gadc_thermal_get_temp,
>  };
>  
> +static const struct iio_chan_spec gadc_thermal_iio_channels[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +	}
> +};
> +
> +static int gadc_thermal_read_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int *val, int *val2, long mask)
> +{
> +	struct gadc_thermal_info *gtinfo = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = gadc_thermal_get_temp(gtinfo->tz_dev, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info gadc_thermal_iio_info = {
> +	.read_raw = gadc_thermal_read_raw,
> +};
> +
> +static int gadc_iio_register(struct device *dev, struct gadc_thermal_info *gti)
> +{
> +	struct gadc_thermal_info *gtinfo;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*gtinfo));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	gtinfo = iio_priv(indio_dev);
> +	memcpy(gtinfo, gti, sizeof(*gtinfo));

Why copy the structure ?

Copying the thermal zone device pointer should be enough, no ?

> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &gadc_thermal_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = gadc_thermal_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(gadc_thermal_iio_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
>  static int gadc_thermal_read_linear_lookup_table(struct device *dev,
>  						 struct gadc_thermal_info *gti)
>  {
> @@ -153,7 +206,7 @@ static int gadc_thermal_probe(struct platform_device *pdev)
>  
>  	devm_thermal_add_hwmon_sysfs(dev, gti->tz_dev);
>  
> -	return 0;
> +	return gadc_iio_register(&pdev->dev, gti);
>  }
>  
>  static const struct of_device_id of_adc_thermal_match[] = {
> -- 
> 2.48.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

