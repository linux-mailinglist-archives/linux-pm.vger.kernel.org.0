Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90D1B41CCFC
	for <lists+linux-pm@lfdr.de>; Wed, 29 Sep 2021 21:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345818AbhI2T5F (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Sep 2021 15:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345887AbhI2T5D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Sep 2021 15:57:03 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D4AC061765
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 12:55:22 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id x27so15586465lfu.5
        for <linux-pm@vger.kernel.org>; Wed, 29 Sep 2021 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zIP+fT3P6R0yvKNN26znulCvOf0uZzhNp76ydFE5KGM=;
        b=oLH5VMnESFf8hDlXdhtVvTI4OPGgZPLti9/yUSFcghvqOFR8+1q15z4q6upS+kTSvk
         K3BKlDD5vbLvfuGkR2znd52pJxoqID2YMqf24qVuId5hOO5io+aMo4+g4+HRMAu3dzsK
         WQcvLHMd+wdKtmts8MHrukqHFaEGyCQNH12etPoANPb3jeEU5R8zMZcmYOIOL4hl7xdy
         CpB+Vn7h9KkrmAa77QlZY8thzONOxPKcB4IRQJlb3BHdPdKW8OWixOY1zwrouOPXq2c0
         noAeX2Yo54bebM4Tkd0sldYqTE5gbm9ZIjWf7tLIdntkLY/a8q4yXJQ/0+DST800MKRf
         rUJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zIP+fT3P6R0yvKNN26znulCvOf0uZzhNp76ydFE5KGM=;
        b=HfRs3gFFnvq7h1CXwToMZKDaZiKjqjT9rIQd/NxZQtZziUirgrE8z23+pB0585CkUq
         mAx0qwL8BTztwUYAN9ttj9z0jJku7odASsNj82SRTXsphnp1wmQe6G1MaCcmzFlyI3/Z
         0Y73U2MjaHjjIwTsjF+ddIBFxD9+qyRnawrJ57XsYZ5+yeLCXmcv5lKEReqX8rcQ1uOq
         8dZUsnTrZLrbLmBH/r9N0vuLqnXmEe/8D+IpvhTYK1y6Qz6fXtfv6b7fZCKGsdHJl7pX
         qfnMV2fJTJQFthRG4tfJKhZMbJHNeAWbm0XWMDB/Z18rpPlWFhCrIWCe7op+ygXdoTHv
         0KbQ==
X-Gm-Message-State: AOAM5300rV3vLRIlOarYq8C4X1OsYpUUuUmyEk31g2iJg6Y4WjrMu7MB
        IzeWvqrZ+JoCN6QotoNrnZk/pA==
X-Google-Smtp-Source: ABdhPJw2NBeebkhp21q8eiztBXx7rEsS8aq9QKNrH06jaurbSofJowNctBm6Ot5kXUJjIgkgPboaVw==
X-Received: by 2002:a05:6512:3f1a:: with SMTP id y26mr1524768lfa.372.1632945320615;
        Wed, 29 Sep 2021 12:55:20 -0700 (PDT)
Received: from [192.168.10.17] (88-112-130-172.elisa-laajakaista.fi. [88.112.130.172])
        by smtp.gmail.com with ESMTPSA id z8sm94311lfq.284.2021.09.29.12.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 12:55:20 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] thermal/drivers/qcom/spmi-adc-tm5: Add support for
 HC variant
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210923212311.2877048-1-bjorn.andersson@linaro.org>
 <20210923212311.2877048-3-bjorn.andersson@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Message-ID: <04bbf390-9e17-08fb-24dd-f1d71288aaaa@linaro.org>
Date:   Wed, 29 Sep 2021 22:55:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210923212311.2877048-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On 9/24/21 12:23 AM, Bjorn Andersson wrote:
> The variant of the ADC Thermal Monitor block found in e.g. PM8998 is
> "HC", add support for this variant to the ADC TM5 driver in order to
> support using VADC channels as thermal_zones on SDM845 et al.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> 
> Changes since v1:
> - New patch
> 
>   drivers/thermal/qcom/qcom-spmi-adc-tm5.c | 43 +++++++++++++++++++++++-
>   1 file changed, 42 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> index 8494cc04aa21..7fe5cf28ae15 100644
> --- a/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> +++ b/drivers/thermal/qcom/qcom-spmi-adc-tm5.c
> @@ -82,6 +82,7 @@ struct adc_tm5_data {
>   	const u32	full_scale_code_volt;
>   	unsigned int	*decimation;
>   	unsigned int	*hw_settle;
> +	bool		is_hc;
>   };
>   
>   enum adc_tm5_cal_method {
> @@ -146,6 +147,14 @@ static const struct adc_tm5_data adc_tm5_data_pmic = {
>   					 64000, 128000 },
>   };
>   
> +static const struct adc_tm5_data adc_tm_hc_data_pmic = {
> +	.full_scale_code_volt = 0x70e4,
> +	.decimation = (unsigned int []) { 256, 512, 1024 },
> +	.hw_settle = (unsigned int []) { 0, 100, 200, 300, 400, 500, 600, 700,
> +					 1000, 2000, 4000, 6000, 8000, 10000 },
> +	.is_hc = true,
> +};
> +
>   static int adc_tm5_read(struct adc_tm5_chip *adc_tm, u16 offset, u8 *data, int len)
>   {
>   	return regmap_bulk_read(adc_tm->regmap, adc_tm->base + offset, data, len);
> @@ -375,6 +384,31 @@ static int adc_tm5_register_tzd(struct adc_tm5_chip *adc_tm)
>   	return 0;
>   }
>   
> +static int adc_tm_hc_init(struct adc_tm5_chip *chip)
> +{
> +	unsigned int i;
> +	u8 buf[2];
> +	int ret;
> +
> +	for (i = 0; i < chip->nchannels; i++) {
> +		if (chip->channels[i].channel >= ADC_TM5_NUM_CHANNELS) {
> +			dev_err(chip->dev, "Invalid channel %d\n", chip->channels[i].channel);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	buf[0] = chip->decimation;
> +	buf[1] = chip->avg_samples | ADC_TM5_FAST_AVG_EN;
> +
> +	ret = adc_tm5_write(chip, ADC_TM5_ADC_DIG_PARAM, buf, sizeof(buf));
> +	if (ret) {
> +		dev_err(chip->dev, "block write failed: %d\n", ret);
> +		return ret;
> +	}

	if (ret)
		dev_err(chip->dev, "block write failed: %d\n", ret);

above should be sufficient here and similarly in adc_tm5_init().

> +
> +	return ret;
> +}
> +
>   static int adc_tm5_init(struct adc_tm5_chip *chip)
>   {
>   	u8 buf[4], channels_available;
> @@ -591,7 +625,10 @@ static int adc_tm5_probe(struct platform_device *pdev)
>   		return ret;
>   	}
>   
> -	ret = adc_tm5_init(adc_tm);
> +	if (adc_tm->data->is_hc)
> +		ret = adc_tm_hc_init(adc_tm);
> +	else
> +		ret = adc_tm5_init(adc_tm);
>   	if (ret) {
>   		dev_err(dev, "adc-tm init failed\n");
>   		return ret;
> @@ -612,6 +649,10 @@ static const struct of_device_id adc_tm5_match_table[] = {
>   		.compatible = "qcom,spmi-adc-tm5",
>   		.data = &adc_tm5_data_pmic,
>   	},
> +	{
> +		.compatible = "qcom,spmi-adc-tm-hc",
> +		.data = &adc_tm_hc_data_pmic,
> +	},
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, adc_tm5_match_table);
> 

--
Best wishes,
Vladimir
