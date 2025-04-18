Return-Path: <linux-pm+bounces-25705-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D61A9365C
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 13:16:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8179D8A84DF
	for <lists+linux-pm@lfdr.de>; Fri, 18 Apr 2025 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D492749FD;
	Fri, 18 Apr 2025 11:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8iWYNMW"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281E027467D
	for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 11:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744974958; cv=none; b=MizkAFByb/mp2uIt4O3HSayX8ubC2iQKDQzDjG035pWTVt9pF9pouRtu0JUmj1HJfkqLi02EAUGIBlyroxQz6QOzobPj6ssAlIc47sN2gGSrSLfiWsZ25A0Qv8UYnE4loemCkiJYMVR4hB9L/xaL+oTyn5HlHnF5Ms195vzZsDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744974958; c=relaxed/simple;
	bh=n4swobHnDNUwLAENenY29umYN5A4cEqdjrUkZ0UBV5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TZ1FuFuz2BRQ5fDosLgqIAlzVtnD7zj8qWrR+TmJFScMea7xMjyQ5aw9qcCcjEWKezdk9ymIqJEI5MqLZZWYGw9lJSz2OgpHsvpAvJXIiTNdlXlBvJ6lG/5cO40C3yO58QHrSvtcbhngtUWBJsLiKz7+/D1kIsFLnUtM3wSBfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V8iWYNMW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so13181465e9.2
        for <linux-pm@vger.kernel.org>; Fri, 18 Apr 2025 04:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744974953; x=1745579753; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4z+4vitFF1HLmYGp5qH1vxFH58VNRpmJ23zED24ccPg=;
        b=V8iWYNMWKmMi4XNcOCybvrj1m1u96A0Itwh5WAUEbkmR5e2AyM4oXOLWjH+fS+Rrcy
         SMyGwKrOsJT9eQgELLv7fbtorxM9U1YG7wMAIEFUEnnQdMDDk8bU2nL2jLw/c2IzhGfa
         tmk7RQuv9M4yac+/DnbiTJ31scqHtktUowdmIZHPumBMsMQbX2wsMT7WXtMT00WTtsYj
         qAzc1/ES+1ei+hg8dJuEc4IKOEhw/zfMBZqQPoc0qjLKNIYNR8Wxr+/By6XtuL4G69yu
         BmEaTVW87kiZs4d/aknM4Sz3BBt13r2g2UopHpuxsNUqJM22MycpMKxkN8etcp+kadw/
         Abzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974953; x=1745579753;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4z+4vitFF1HLmYGp5qH1vxFH58VNRpmJ23zED24ccPg=;
        b=PVDY7UG9YtiL5l2KO695ocj1Ogh8N577KOnNH1Es+7Uy2nDKjZQO4z29ciqJTnEqSB
         rIs9nsn0lTPrwTTaxM0DjYQBPTN9Uh3k+OLwvQfg7earrzJtktZpx4t1fIV0XeD9RmRv
         dauXUz77qfU6XIjbSZX3PzOHlnoP1AD2XHA4rIyYrhwTCPPg1+7p3WVABQMuoajshjYh
         a2Cpmkfp1Ks4EbVs4TM6zPYDkJdlJdCrfshgKWkb6ujAEnJPLo64ryqVWavRfgZGEYUX
         6PNXY2LOReL6XC88iRAG9DQ1MOL0fuN0X6GbmZ5xURDWR30hc7eDa0cajxhRGwCIn8ZU
         ig7g==
X-Forwarded-Encrypted: i=1; AJvYcCU8RgSjwlGnY2TGC3u5TVY/v4O0hGD4XnV+sbE/RwNeQZLmj8Z1g7T9wy0BnCafwRFmMQsoatKXAA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyGWJ7qqtxZ/nzv9s2kaTrnfI3AR12uTSA2rvAItFw+S5Z1gOFQ
	nSPNcLmKQ0jFQ0KvzwRsJZUlBgRMF3/FsotBKxud+S1iBgMJeAsQ7CTeHDlrOBc=
X-Gm-Gg: ASbGncuhyaC/Prs5MOehN9t3BnGXXUAbd53jBk8T8xTxIx8eeg5AGAof4kCRfQOwXlq
	5i0mIjpqhtuVytd3bPsPwfc2Sqwk7z2WboGhbIChF+AM+bTMO7w6ruo0w6zctnRmSBGPI/cwFfO
	u8jrILu+dLSkTd5EbChauFMgurhVb6HRtGg/5zF+Hp2jISgvHKZqkwIdSqdl8XUYCpU12sPozQG
	poq2vXGOcmC7LvWFEi1qvpzwWL41n93ar1EYreqUUSF/sl1lPmeURq6lY0anxu4BZvHXGmstSXh
	rWceL+A/DvYddCNBR0rFj8dUhLR5QgukXajEeFbz1Qdti/Y2fUULO3eKNbiAjj2IkaZLaSNJl+l
	UxeA=
X-Google-Smtp-Source: AGHT+IGgzDneWpjqDYsrvMrlNm2kziIqWIKfA6WRzSUivYakLEXrOn3tJvonIi77xE/vY/on/myTfg==
X-Received: by 2002:a05:600c:8508:b0:43c:fe15:41cb with SMTP id 5b1f17b1804b1-4406aba4af7mr24333745e9.15.1744974953462;
        Fri, 18 Apr 2025 04:15:53 -0700 (PDT)
Received: from mai.linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbd35sm18383865e9.22.2025.04.18.04.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 04:15:52 -0700 (PDT)
Date: Fri, 18 Apr 2025 13:15:50 +0200
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
Cc: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
	rui.zhang@intel.com, lukasz.luba@arm.com,
	david.collins@oss.qualcomm.com, srinivas.kandagatla@linaro.org,
	stefan.schmidt@linaro.org, quic_tsoni@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmitry.baryshkov@linaro.org
Subject: Re: [PATCH v3 3/5 RESEND] thermal: qcom-spmi-temp-alarm: Prepare to
 support additional Temp Alarm subtypes
Message-ID: <aAI0Zm5M9ba9ehyI@mai.linaro.org>
References: <20250320202408.3940777-1-anjelique.melendez@oss.qualcomm.com>
 <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250320202408.3940777-4-anjelique.melendez@oss.qualcomm.com>

On Thu, Mar 20, 2025 at 01:24:06PM -0700, Anjelique Melendez wrote:
> In preparation to support newer temp alarm subtypes, add the "ops" and
> "configure_trip_temps" references to spmi_temp_alarm_data. This will
> allow for each Temp Alarm subtype to define its own
> thermal_zone_device_ops and properly configure thermal trip temperature.
> 
> Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
> ---
>  drivers/thermal/qcom/qcom-spmi-temp-alarm.c | 38 ++++++++++++++-------
>  1 file changed, 26 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> index 1cc9369ca9e1..514772e94a28 100644
> --- a/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> +++ b/drivers/thermal/qcom/qcom-spmi-temp-alarm.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2011-2015, 2017, 2020, The Linux Foundation. All rights reserved.
> - * Copyright (c) 2024, Qualcomm Innovation Center, Inc. All rights reserved.
> + * Copyright (c) 2024-2025, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #include <linux/bitfield.h>
> @@ -71,8 +71,10 @@ static const long temp_map_gen2_v1[THRESH_COUNT][STAGE_COUNT] = {
>  struct qpnp_tm_chip;
>  
>  struct spmi_temp_alarm_data {
> +	const struct thermal_zone_device_ops *ops;
>  	const long (*temp_map)[THRESH_COUNT][STAGE_COUNT];
>  	int (*get_temp_stage)(struct qpnp_tm_chip *chip);
> +	int (*configure_trip_temps)(struct qpnp_tm_chip *chip);
>  };
>  
>  struct qpnp_tm_chip {
> @@ -312,18 +314,39 @@ static irqreturn_t qpnp_tm_isr(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> +static int qpnp_tm_configure_trip_temp(struct qpnp_tm_chip *chip)
> +{
> +	int crit_temp, ret;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> +	if (ret)
> +		crit_temp = THERMAL_TEMP_INVALID;
> +
> +	mutex_lock(&chip->lock);
> +
> +	return qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +}

The qpnp_tm_configure_trip_temp() is called with the lock held which is really
unusual to have this assymetry when dealing with the locks.

In the other side, this code assume it is ok the userspace can change the
critical temperature of the board. Is it really a good idea ?

>  static const struct spmi_temp_alarm_data spmi_temp_alarm_data = {
> +	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
>  	.get_temp_stage = qpnp_tm_gen1_get_temp_stage,
>  };
>  
>  static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_data = {
> +	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
>  	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
>  };
>  
>  static const struct spmi_temp_alarm_data spmi_temp_alarm_gen2_rev1_data = {
> +	.ops = &qpnp_tm_sensor_ops,
>  	.temp_map = &temp_map_gen2_v1,
> +	.configure_trip_temps = qpnp_tm_configure_trip_temp,
>  	.get_temp_stage = qpnp_tm_gen2_get_temp_stage,
>  };
>  
> @@ -336,7 +359,6 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  {
>  	int ret;
>  	u8 reg = 0;
> -	int crit_temp;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -355,15 +377,7 @@ static int qpnp_tm_init(struct qpnp_tm_chip *chip)
>  	if (chip->stage)
>  		chip->temp = qpnp_tm_decode_temp(chip, chip->stage);
>  
> -	mutex_unlock(&chip->lock);
> -
> -	ret = thermal_zone_get_crit_temp(chip->tz_dev, &crit_temp);
> -	if (ret)
> -		crit_temp = THERMAL_TEMP_INVALID;
> -
> -	mutex_lock(&chip->lock);
> -
> -	ret = qpnp_tm_update_critical_trip_temp(chip, crit_temp);
> +	ret = chip->data->configure_trip_temps(chip);
>  	if (ret < 0)
>  		goto out;
>  
> @@ -483,7 +497,7 @@ static int qpnp_tm_probe(struct platform_device *pdev)
>  	 * before the hardware initialization is completed.
>  	 */
>  	chip->tz_dev = devm_thermal_of_zone_register(
> -		&pdev->dev, 0, chip, &qpnp_tm_sensor_ops);
> +		&pdev->dev, 0, chip, chip->data->ops);
>  	if (IS_ERR(chip->tz_dev))
>  		return dev_err_probe(&pdev->dev, PTR_ERR(chip->tz_dev),
>  				     "failed to register sensor\n");
> -- 
> 2.34.1
> 

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

