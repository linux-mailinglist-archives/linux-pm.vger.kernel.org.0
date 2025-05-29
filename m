Return-Path: <linux-pm+bounces-27806-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 801FCAC7C4D
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 13:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 445B27A6D2C
	for <lists+linux-pm@lfdr.de>; Thu, 29 May 2025 10:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F228DF22;
	Thu, 29 May 2025 10:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u3Mvde2v"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F1B347B4
	for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 10:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748516392; cv=none; b=b+HXC65LGGrem53PHViY8fP8xZitSciihNaFqodFk1O3JVgWo/OHiWxuBzsZFbjmr+8xh1O79loSFokP2rGMFMNkePa+26tn/+9wFaTUVPx2Pa3mpXFIpvTVl1qo+hXDS/h9H63gNFO8rQCXOdZHUAL+xPdVGuAiJE3akn3KYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748516392; c=relaxed/simple;
	bh=uokOcpliAtsO0yPgDgaMCS61kumW1dce6ne6Ov1VvFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFUgGEeJ6H36gKlYHtRsfxhIkvzxntqsHKQizi2WuG9jIjSYNk9UW6rVf6uxgO4Zq1xtxSXjVzph+mcV2ObgpFAnT8WZkUU1D1pW4Te5AwN3k+utA4r/1N2GAO9ED3w599TPH0fBS/tCVmN3tcCxuc/Qtni/TKm+egGI/fc1fDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u3Mvde2v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so9925845e9.3
        for <linux-pm@vger.kernel.org>; Thu, 29 May 2025 03:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748516389; x=1749121189; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIw9ZqjIqtglnQzbhkOCsGKq/yrA50x6t5WtTG1WnPI=;
        b=u3Mvde2vIxJBag/MnIjAxlf4+nnq4KlMquSkzYdDjQxPGC9G4kdzXST65aGUMUsmwz
         yYWk1zv2l2i5Esm5E5pzvUw20DHIsY7yQCYNXsE2GW5oWCf0y0UhuT6xcnFSn8aPyKl7
         0GcHa6I35ZaFB/9AtFxG4xvcjeuSy+T8QvtgXiDwTEzi1LVHkZr1anW+sgufIZsqvBvd
         lumeCmLs44H7Zmd+f4O7YEPgi7JM9d05+vNrSK6BnX+M1+yVKU0tZArrlg+FHBBWcRTo
         IT1dRnTbbHRxowO2bm9iy6/uPfMBBB0yAQR93OH+bVP2rOFSUQpiunVbw5ZlxmQbdbfF
         fIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748516389; x=1749121189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIw9ZqjIqtglnQzbhkOCsGKq/yrA50x6t5WtTG1WnPI=;
        b=giQ1tp8J6EXs/PPT3AgIo/LGIVQS1FtqkQZxTJWZz/GBcXheKuQt8or2ufcMDnrBq4
         6r3p2bPfMQTa2GmBWiruMLQk8e3uDu+X14CgiJW7c4yUPbAUhTDSSnX6lAA4oVL4CfnV
         y7Fpl1rFwAkood5UEjqq5e0BscCNcn2liGsJ46d9rXoOcLE45M07hWeIdagdTm/lOp79
         /3VKCJ8zR/xIzQuYQfETYrfFLOf+pjuzgrwIG0VKv4rV2Mlq0owsNZrnMP7X2BE0vlO5
         NKqnOoQ15Q+y3yQwy/boLqogQnDEKdZMWfFkLYFJrCWbV5+IM8kZ5c2+AEd2KTGvopm7
         B+4w==
X-Forwarded-Encrypted: i=1; AJvYcCUZTGsLbrZWyNOaYy650fhihSkG6edV/F7mlqNVAl5ecHCf63JncEPO9cspBw1haHfZK6Lvk28rJw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxIdkZJxL/duBffJxNIBpXUfvtx35W2v/eoo49FEkQ4vVVfFMEv
	KZyRXjHfmBFebCT+yTooEBhXdjI0/7aWq0PY5iFuedeLBe3G+x2PQQBpmC9P4YFRWtU=
X-Gm-Gg: ASbGncuG9NgFLVawEmhMvKhBZ2X5JnI3RpgtccmzxIqATiyhT5JIJSe9SbVORKCYpBl
	H8BoisGqmhE68mkiuWy+gVE5sP5Ce4ZL7aj1zGJTPjovlX3Rb/OEBRIvjpNALBdbNYGUrcJZ4qW
	Hb2ySBvnq5gOBCjFF2MEJYD1XJfwIutIwyUXhmq5GcWcEQqnqO4x0MMzcj8FbMkZ4eWvhmESqk4
	RgU8zOvwwniSVt8gf4Yb5B6TfNva+pXASmjNQ3AI7DFtWNbuU4HEFONvYKRm3m+R3bzP4cOjtKE
	HXjc5iCT8ZIqpNHZCvbpMcjNnRxteLWv0oonKlGsgxobF3O7ffvW2H9WJk6Ubhmsb7ZfXEAdtFW
	D6OF5I/4Z2nGlX98E
X-Google-Smtp-Source: AGHT+IGBNOksY0Dn1siJUEYw2Be2FNY53x04kcV72jN+DJxdz71cewTb6DwiVUGoW3jjAYY9Zdl7Yw==
X-Received: by 2002:a05:600c:828f:b0:450:d3c6:84d8 with SMTP id 5b1f17b1804b1-450d3c68523mr10216405e9.14.1748516388671;
        Thu, 29 May 2025 03:59:48 -0700 (PDT)
Received: from [192.168.0.34] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc03430sm16779555e9.12.2025.05.29.03.59.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 03:59:48 -0700 (PDT)
Message-ID: <07ecd160-5bb5-4e39-ab5c-9f761e7db0af@linaro.org>
Date: Thu, 29 May 2025 11:59:47 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/5] thermal: qcom-spmi-temp-alarm: add support for
 GEN2 rev 2 PMIC peripherals
To: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>,
 amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
 daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, david.collins@oss.qualcomm.com,
 srinivas.kandagatla@linaro.org, stefan.schmidt@linaro.org,
 quic_tsoni@quicinc.com, linux-arm-msm@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dmitry.baryshkov@linaro.org, dmitry.baryshkov@oss.qualcomm.com
References: <20250528235026.4171109-1-anjelique.melendez@oss.qualcomm.com>
 <3niPa8t6TJc43heEDzbk3f9nuULmgPi0LavIEOdHufZwUvhipGZxrwj317kugr1GXnHZjtCwM_6trcPCQ3c4hQ==@protonmail.internalid>
 <20250528235026.4171109-5-anjelique.melendez@oss.qualcomm.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20250528235026.4171109-5-anjelique.melendez@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2025 00:50, Anjelique Melendez wrote:
> +static int qpnp_tm_gen2_rev2_set_temp_thresh(struct qpnp_tm_chip *chip, int trip, int temp)
> +{
> +	int ret, temp_cfg;
> +	u8 reg;
> +
> +	WARN_ON(!mutex_is_locked(&chip->lock));
> +
> +	if (trip < 0 || trip >= STAGE_COUNT) {

trip < 0 can never be true because the value passed to this function 
comes from an unsigned int

include/linux/thermal.h:#define THERMAL_TRIP_PRIV_TO_INT(_val_) 
(uintptr_t)(_val_)

actually why is it int trip here instead of unsigned int trip ?

> +		dev_err(chip->dev, "invalid TEMP_DAC trip = %d\n", trip);
> +		return -EINVAL;
> +	} else if (temp < TEMP_DAC_MIN || temp > temp_dac_max[trip]) {
> +		dev_err(chip->dev, "invalid TEMP_DAC temp = %d\n", temp);
> +		return -EINVAL;
> +	}
> +
> +	reg = TEMP_DAC_TEMP_TO_REG(temp);
> +	temp_cfg = TEMP_DAC_REG_TO_TEMP(reg);
> +
> +	ret = qpnp_tm_write(chip, QPNP_TM_REG_TEMP_DAC_STG1 + trip, reg);
> +	if (ret < 0) {
> +		dev_err(chip->dev, "TEMP_DAC_STG write failed, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	chip->temp_thresh_map[trip] = temp_cfg;
> +
> +	return 0;
> +}
> +
> +static int qpnp_tm_gen2_rev2_set_trip_temp(struct thermal_zone_device *tz,
> +					   const struct thermal_trip *trip, int temp)
> +{
> +	unsigned int trip_index = THERMAL_TRIP_PRIV_TO_INT(trip->priv);
> +	struct qpnp_tm_chip *chip = thermal_zone_device_priv(tz);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +	ret = qpnp_tm_gen2_rev2_set_temp_thresh(chip, trip_index, temp);The sign conversion in the integer seems questionable. I see that the 
intel code does the same thing but I think that's just an error being 
replicated here.
---
bod


